

import os
from dotenv import load_dotenv
from typing import Optional, Literal
from pydantic import BaseModel, Field
from langchain_google_genai import ChatGoogleGenerativeAI #to chat with the model

# Load environment variables from the .env file
load_dotenv()

# Initialize Gemini
llm = ChatGoogleGenerativeAI(
    model="gemini-3.8-flash",
    google_api_key=os.getenv("GEMINI_API_KEY"),
    temperature=0.5 #you need creativity
)
class Ticket(BaseModel):
    title: str = Field(
        ...,
        min_length=1,
        description="Name of the task ticket"
    )

    description: str = Field(
        ...,
        min_length=1,
        description="Detailed description of the task"
    )

    dueDate: Optional[str] = Field(
        None,
        description="Due date in DD/MM/YY format. Return null if not explicitly mentioned."
    )

    assignedTo: Optional[str] = Field(
        None,
        description="Full name of the employee assigned to the task. Must match an employee in the provided project team. Return null if no valid assignee exists."
    )

    assignedBy: Optional[str] = Field(
        None,
        description="Full name of the person assigning the task, if explicitly identified. Return null otherwise."
    )

    department: Optional[str] = Field(
        None,
        description="Department responsible for this task. Must match a department involved in the project."
    )

    priority: Optional[Literal["Low", "Medium", "High"]] = Field(
        None,
        description="Task priority. Return null if it cannot be determined from the meeting."
    )


class Meeting(BaseModel):
    meeting_summary: str = Field(
        ...,
        description="Meeting summary including important discussions, decisions, and key tasks."
    )

    meeting_date: Optional[str] = Field(
        None,
        description="Meeting date in DD/MM/YY format. Return null if not mentioned."
    )


class MeetingAnalysis(BaseModel):
    tickets: list[Ticket] = Field(
        default_factory=list,
        description="List of actionable tickets extracted from the meeting."
    )

    meeting: Meeting



from langchain_core.output_parsers import JsonOutputParser

output_parser = JsonOutputParser(
    pydantic_object=MeetingAnalysis
)



from langchain_core.prompts import ChatPromptTemplate

prompt = ChatPromptTemplate.from_messages([
    (
        "system",
        """
You are the meeting intelligence engine for InSync.

Your responsibilities:
1. Analyze meeting minutes.
2. Extract actionable tasks as tickets.
3. Identify the responsible department for each ticket.
4. Assign tickets only to employees provided in the project team.
5. Produce a concise but comprehensive meeting summary.

PROJECT CONTEXT:

Project Summary:
{project_summary}

DEPARTMENTS INVOLVED IN THIS PROJECT:
{departments_involved}

AVAILABLE PROJECT EMPLOYEES:
{employees_involved}

IMPORTANT RULES:

EMPLOYEE ASSIGNMENT:
- Employees provided above are already filtered by the
  departments involved in this project.
- You MUST assign employees only from this list.
- Never invent employee names.
- assignedTo must contain the exact employee name
  from the provided list.
- If no valid assignee can be identified, return null.
- Do not assign employees from departments outside
  the provided project departments.

DEPARTMENT IDENTIFICATION:
- Identify the department responsible for each task.
- Use only departments listed in the project context.
- Never invent departments.
- If the department cannot be determined, return null.

DEADLINES:
- Never invent deadlines.
- Extract due dates only when explicitly mentioned.
- Use DD/MM/YY format.
- Return null if no deadline is specified.

PRIORITY:
- Use only Low, Medium, or High.
- Determine priority from explicit statements or
  clear urgency in the meeting.
- Return null if priority cannot be determined.

ASSIGNED BY:
- Identify the person who assigned the task only
  when explicitly stated or clearly established.
- Return null otherwise.

MEETING:
- Extract the meeting date if available.
- Use DD/MM/YY format.
- Never invent meeting dates.
- Include important discussions, decisions,
  and relevant tasks in the summary.

OUTPUT:
{format_instructions}

Return valid JSON only.
Do not include markdown or additional explanations.
"""
    ),
    (
        "human",
        """
Analyze the following meeting minutes:

{meeting_minutes}
"""
    )
]).partial(
    format_instructions=output_parser.get_format_instructions()
)


chain=prompt|llm|output_parser

#to be given its inputs
result=chain.invoke({})
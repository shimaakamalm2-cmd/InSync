
import os
from typing import Literal

from dotenv import load_dotenv
from pydantic import BaseModel, ConfigDict, Field, field_validator
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.runnables import RunnableLambda
from datetime import datetime

class Ticket(BaseModel):
    title: str = Field(..., min_length=1, description="Name of the task ticket")
    description: str = Field(..., min_length=1, description="Description of the task ticket")
    dueDate: str = Field(..., description="Due date in format DD/MM/YY")
    assignedTo: str = Field(..., min_length=1, description="Person assigned to this task")
    assignedeBy: str = Field(..., min_length=1, description="Person who assigned this task")
    priority:str=Literal()


class Meeting(BaseModel):
    meeting_summary:str = Field(..., 
        description="Meeting Summary with key tasks and summary of meeting"
    )

    meeting_date: str = Field(..., 
        description="Meeting date in format DD/MM/YY")



# Initialize output parsers
ticket_parser = JsonOutputParser(pydantic_object=Ticket)
meeting_parser = JsonOutputParser(pydantic_object=Meeting)



prompt = ChatPromptTemplate.from_messages([
    (
        "system",
        """
        You are the meeting intelligence engine for InSync.

        Your responsibilities:
        - Extract actionable tickets from meeting minutes.
        - Identify the responsible department.
        - Match assignees ONLY from the provided project team.
        - Never invent employees or departments.
        - If no valid assignee exists, return null.
        - Never invent deadlines.
        - Produce a meeting summary.

        PROJECT CONTEXT:
        {project_context}
        """
    ),
    (
        "human",
        "Analyze these meeting minutes:\n{meeting_minutes}"
    )
])
import 'package:insync/model/ticket.dart';

class TicketSorting {
  // sorting class to handle the sorting of tickets to keep screen clean
  static List<Ticket> sortTickets(List<Ticket> tickets, String sortType) {
    final sortedTickets = List<Ticket>.from(tickets);

//sorting will be alphabetical for all at first, then by priority, then by project( not implemented yet)
    switch (sortType) {
      case 'Priority':
        sortedTickets.sort(
          (a, b) => a.priority.index.compareTo(b.priority.index),
        );
        break;
      case 'Alphabetically':
        sortedTickets.sort(
          (a, b) => a.title.compareTo(b.title),
        );
        break;
      case 'Project':
        sortedTickets.sort(
          (a, b) => a.belongingProject.name.compareTo(
            b.belongingProject.name,
          ),
        );
        break;
    }

    return sortedTickets;
  }

  // Group tickets by priority so i can then display them in different sections
  static Map<Priority, List<Ticket>> groupByPriority(
    List<Ticket> tickets,
  ) {
    return {
      //.where() filters according to the condition but returns iterable , thats why i did toList
      Priority.high: tickets.where((ticket) => ticket.priority == Priority.high).toList(),
      Priority.medium: tickets.where((ticket) => ticket.priority == Priority.medium).toList(),
      Priority.low: tickets.where((ticket) => ticket.priority == Priority.low).toList(),
    };
  }
  
}

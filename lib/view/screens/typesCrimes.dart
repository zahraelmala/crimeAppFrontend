import 'package:flutter/material.dart';

class CrimeListScreen extends StatelessWidget {
  const CrimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Types of Crimes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const CrimeList(),
    );
  }
}

class CrimeList extends StatefulWidget {
  const CrimeList({super.key});

  @override
  CrimeListState createState() => CrimeListState();
}

class CrimeListState extends State<CrimeList> {
  final List<CrimeOption> crimes = const [
    CrimeOption(
        title: 'Theft',
        details:
            'Theft is a crime that involves unlawfully taking someone else\'s property with the intent to permanently deprive the owner of it. It\'s one of the most common types of crime and is generally categorized based on the value of the stolen property.'),
    CrimeOption(
        title: 'Burglary',
        details:
            'Burglary involves unlawfully entering a building, residence, or property with the intent to commit theft or another crime. It typically occurs when the occupants are not present, but it can also happen during home invasions. Burglary can lead to property loss and emotional distress.'),
    CrimeOption(
        title: 'Violence',
        details:
            'Violence refers to physical force intended to harm, damage, or kill someone. Violent crimes often involve aggression and pose serious risks to individuals\' safety. Common forms of violence include assault, domestic violence, armed robbery, and homicide.'),
    CrimeOption(
        title: 'Fraud',
        details:
            'Fraud is a deliberate act of deception intended to result in financial or personal gain at the expense of another party. It involves manipulating information or identity to steal money, services, or sensitive information. Fraudulent activities can occur online, in-person, or through various forms of communication.'),
    CrimeOption(
        title: 'Cybercrime',
        details:
            'Cybercrime involves illegal activities carried out using computers or the internet. It targets individuals, businesses, and organizations, often aiming to steal sensitive information, cause disruption, or gain unauthorized access to systems.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: crimes.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.grey),
      itemBuilder: (context, index) {
        return crimes[index];
      },
    );
  }
}

class CrimeOption extends StatefulWidget {
  final String title;
  final String details;

  const CrimeOption({super.key, required this.title, required this.details});

  @override
  CrimeOptionState createState() => CrimeOptionState();
}

class CrimeOptionState extends State<CrimeOption> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.arrow_drop_down, color: Colors.red),
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.details),
          ),
      ],
    );
  }
}

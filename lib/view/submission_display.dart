import 'package:competition_arena/components/comment_section.dart';
import 'package:competition_arena/http/submission_service.dart';
import 'package:competition_arena/models/submission_data.dart';
import 'package:competition_arena/view/judge_score.dart';
import 'package:flutter/material.dart';

class SubmissionDisplay extends StatefulWidget {
  final SubmissionData data;
  final int submissionID;
  SubmissionDisplay({this.data, this.submissionID});

  @override
  State<StatefulWidget> createState() =>
      _SubmissionDisplayState(data: data, submissionID: submissionID);
}

class _SubmissionDisplayState extends State<SubmissionDisplay> {
  final SubmissionData data;
  final int submissionID;

  SubmissionData submission;
  SubmissionService submissionService = SubmissionService();

  _SubmissionDisplayState({this.data, this.submissionID});

  initState() {
    fillSubmission();
    super.initState();
  }

  fillSubmission() async {
    if (data != null) {
      submission = data;
      setState(() {
        submission = data;
      });
    } else if (submissionID != null) {
      submission = await submissionService.doGetOne(submissionID);
      setState(() {
        submission = submission;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //fillSubmission();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.15,
                      child: Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                'https://rhythmega.s-ul.eu/y4E3hmm6'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        submission.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      bottom: 80,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        submission.participant.participantName,
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 60,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        submission.dateCreated.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 40,
                      left: 15,
                    ),
                    Positioned(
                      child: Text(
                        submission.dateModified.toIso8601String(),
                        style: TextStyle(fontSize: 12),
                      ),
                      bottom: 20,
                      left: 15,
                    ),
                  ],
                ),
              ),
              Divider(),
              InkWell(
                child: Text('Score'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JudgeScore(
                        idSubmission: submissionID,
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              Text(submission.description),
              Divider(),
              CommentSection(
                idSubmission: submission.idSubmission,
              )
            ],
          ),
        ),
      ),
    );
  }
}

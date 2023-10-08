// ignore_for_file: avoid_print, avoid_types_as_parameter_names, non_constant_identifier_names, library_private_types_in_public_api

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/section_title.dart';
import 'widgets/dashed_container.dart';
import 'ai/app.dart';
// ignore: depend_on_referenced_packages
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

const String apiKey = 'API-KEY';
const String apiUrl = 'SERVICE-ENDPOINT';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // ignore: duplicate_ignore
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<String> aiconversation = [];
  final List<String> userconversation = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  bool isAIReplying = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  // ignore: unused_element

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    setState(() {
      userconversation.clear();
      aiconversation.clear();
      _textEditingController.clear();
      isAIReplying = true;
    });

    await Future.delayed(const Duration(microseconds: 1));

    setState(() {
      userconversation.add(text);
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final prompt1 = {
      "prompt": {
        "text":
            "You are STAR AI, you are an AI co-pilot tasked with providing accurate info from NASA.\ninput: What is the primary purpose of safety standards in space missions?\noutput: The primary purpose of safety standards in space missions, such as NASA-STD 8719.24A, is to establish a set of guidelines and requirements (as outlined in the code) that ensure the safety of personnel, equipment, and the environment involved in space missions. These standards aim to minimize risks, prevent accidents, and promote mission success by providing a framework for safe planning, design, fabrication, testing, integration, and operation of space payloads and launch vehicles.\ninput: How are mandatory actions usually denoted in safety standards?\noutput:  Mandatory actions within safety standards, such as NASA-STD 8719.24A, are typically denoted by specific terminology and language (as indicated by the code). The code \"shall\" is commonly used to indicate actions or requirements that are obligatory and must be followed without exceptions. When safety standards employ the term \"shall,\" it implies that compliance with the specified action is not optional but mandatory\ninput: What is the primary purpose of a NASA Technical Standard related to crew health and performance in space missions?\noutput: The primary purpose of a NASA Technical Standard related to crew health and performance in space missions is to provide uniform technical requirements for various aspects such as crew health, performance, training, medical operations, design, selection, and application of hardware, software, processes, procedures, practices, and methods for human-rated systems. This is done to safeguard spacefaring crews and minimize health and performance risks.\ninput: What authorizes NASA to establish technical requirements for crew health and safety in space missions?\noutput: NASA is authorized to establish technical requirements for crew health and safety in space missions by NPD 1000.3, The NASA Organization, and NPD 8900.5, NASA Health and Medical Policy for Human Space Exploration. Additional directives, such as NPD 8900.1 and NPD 8900.3, provide the specific authorization for health and medical programs for crewmembers during all phases of spaceflight.\ninput: What is the purpose of an adhesive in optical fiber applications?\noutput:  In optical fiber applications, such as those described in NASA-STD-8739.5A, adhesive serves the crucial purpose of securing the optical fiber in a splice assembly or connector. This adhesive, typically in the form of epoxy, ensures a stable and permanent connection between optical fibers, preventing movement or separation that could lead to signal loss or disruption.\ninput: How does backscatter impact optical fiber systems\noutput: According to NASA-STD-8739.5A, backscatter refers to the phenomenon where a portion of scattered light is directed back to the input end of an optical fiber. In optical fiber systems, backscatter can have a significant impact. It leads to signal loss and interference by introducing noise and reflections into the optical signal. This can degrade the quality and reliability of data transmission over the optical fiber.\ninput: What role does a splice enclosure play in optical fiber applications\noutput: As detailed in NASA-STD-8739.5A, a splice enclosure is a critical component in optical fiber applications. Its primary role is to protect the spliced area of an optical fiber from physical damage. This protection ensures the integrity and durability of the spliced connection, preventing any environmental factors or handling from causing harm to the optical fibers and maintaining signal continuity.\ninput: what is the purpose of a ferrule in optical fiber applications?\noutput:  As per NASA-STD-8739.5A, a ferrule is described as a mechanical fixture, often a rigid tube. In optical fiber applications, its primary purpose is to confine the stripped end of a fiber bundle or an individual optical fiber. This confinement serves several important functions, including maintaining proper alignment of the fibers, protecting them from damage, and ensuring efficient signal transmission within connectors and assemblies.\ninput: What is the primary purpose of ensuring nuclear flight safety in space missions?\noutput: The primary purpose of ensuring nuclear flight safety in space missions, as described in the document, is to safeguard both the mission itself and the Earth'''s environment from potential risks associated with nuclear systems. This includes preventing accidental releases of radioactive materials during launch, operation, or reentry, and minimizing the impact of nuclear systems on the biosphere. Ensuring nuclear flight safety is vital to protect the public, the environment, and the mission'''s success.\ninput: Who are the key parties or organizations involved in overseeing and implementing nuclear flight safety measures for space missions?\noutput: According to the document, several key parties and organizations are involved in overseeing and implementing nuclear flight safety measures for space missions. These include NASA, other Federal authorities responsible for licensing and regulating nuclear material, agencies involved in National Environmental Policy Act (NEPA) activities, and those responsible for risk communication, public outreach, and decommissioning strategies. Effective coordination among these stakeholders is essential for nuclear flight safety.\n output: "
      },
      "temperature": 0.4,
      "top_k": 40,
      "top_p": 0.95,
      "candidate_count": 1,
      "max_output_tokens": 1024,
      "stop_sequences": [],
      "safety_settings": [
        {"category": "HARM_CATEGORY_DEROGATORY", "threshold": 4},
        {"category": "HARM_CATEGORY_TOXICITY", "threshold": 4},
        {"category": "HARM_CATEGORY_VIOLENCE", "threshold": 4},
        {"category": "HARM_CATEGORY_SEXUAL", "threshold": 4},
        {"category": "HARM_CATEGORY_MEDICAL", "threshold": 4},
        {"category": "HARM_CATEGORY_DANGEROUS", "threshold": 4}
      ]
    };

    final response1 = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(prompt1),
    );

    if (response1.statusCode == 200) {
      final responseData1 = jsonDecode(response1.body);
      if (responseData1.containsKey('candidates') &&
          responseData1['candidates'].length > 0) {
        final generatedText1 = responseData1["candidates"][0]["output"];
        setState(() {
          isAIReplying = false;
          aiconversation.add(generatedText1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Image.asset(
                    'rocket.png',
                    color: AppColors.primaryColor.withOpacity(
                        isAIReplying ? (0.6 + (_animation.value * 0.4)) : 1.0),
                  );
                },
              ),
            ),
            _buildNASAStandardsButton(),
            const Checklist(),
            _buildCopilotSection(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'By JavaBoys',
                style: TextStyle(
                  fontSize: 30,
                  color: const Color(0xff7CC4F1),
                  shadows: [
                    Shadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNASAStandardsButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: DottedBorder(
          color: AppColors.primaryColor.withOpacity(0.1),
          dashPattern: const [3, 2],
          strokeWidth: 1,
          child: TextButton(
            onPressed: () async {
              try {
                await launchUrl(Uri.parse(AppConfig.nasaStandardsUrl));
              } catch (e) {
                print('Error launching URL: $e');
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.buttonBackgroundColor,
              padding: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                'View NASA\nStandards',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppFonts.buttonTextSize,
                  height: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopilotSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "COPILOT ENGAGED",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'Mozart',
              fontSize: AppFonts.titleSize,
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          DottedBorder(
            color: AppColors.primaryColor,
            dashPattern: const [8, 4],
            strokeWidth: 3,
            child: SizedBox(
              height: 500,
              width: 900,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SectionTitle('Input'),
                            DashedContainer(
                              child: SizedBox(
                                height: 350,
                                child: userconversation.isEmpty
                                    ? const Text(
                                        'Waiting...',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff82888C),
                                        ),
                                      )
                                    : ListView.builder(
                                        controller: _scrollController,
                                        itemCount: userconversation.length,
                                        itemBuilder: (context, index) {
                                          final message =
                                              userconversation[index];
                                          return AnimatedTextKit(
                                            totalRepeatCount: 1,
                                            animatedTexts: [
                                              TypewriterAnimatedText(message,
                                                  textStyle: const TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: 'Mozart',
                                                    fontSize: 25,
                                                  ),
                                                  speed: const Duration(
                                                      milliseconds: 10))
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SectionTitle('Output'),
                            DashedContainer(
                              child: SizedBox(
                                height: 350,
                                child: aiconversation.isEmpty
                                    ? const Text(
                                        'At your assistance, captain.',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff82888C),
                                        ),
                                      )
                                    : ListView.builder(
                                        controller: _scrollController,
                                        itemCount: aiconversation.length,
                                        itemBuilder: (context, index) {
                                          final message = aiconversation[index];
                                          return AnimatedTextKit(
                                            totalRepeatCount: 1,
                                            animatedTexts: [
                                              TypewriterAnimatedText(message,
                                                  textStyle: const TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: 'Mozart',
                                                    fontSize: 25,
                                                  ),
                                                  speed: const Duration(
                                                      milliseconds: 10))
                                            ],
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: DashedBorder(
                            dashLength: 3,
                            top: BorderSide(
                              color: Color(0xff7CC4F1),
                              width: 2,
                            ),
                          ),
                        ),
                        child: TextField(
                          cursorColor: AppColors.primaryColor,
                          controller: _textEditingController,
                          enabled: !isAIReplying,
                          onSubmitted: isAIReplying ? null : _handleSubmitted,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xff7CC4F1),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'What would you like to know?',
                            hintStyle: TextStyle(
                              fontSize: 30,
                              color: Color(0xff82888C),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChecklistItem {
  final String taskText;
  bool isChecked;

  ChecklistItem(this.taskText, this.isChecked);
}

class Checklist extends StatefulWidget {
  const Checklist({Key? key}) : super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  List<ChecklistItem> checklistItems = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();

    updateDisplayedPoints();
  }

  void updateDisplayedPoints() {
    setState(() {});
  }

  void addTask(String taskText) {
    setState(() {
      checklistItems.add(ChecklistItem(taskText, false));
      taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 40, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: DashedBorder(
                    dashLength: 3,
                    bottom: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text(
                  "   Checklist   ",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                height: 250,
                child: ListView.builder(
                  itemExtent: 30,
                  itemCount: checklistItems.length,
                  itemBuilder: (context, index) {
                    final item = checklistItems[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Icon(
                            item.isChecked
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: AppColors.primaryColor,
                            size: 11,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            item.taskText,
                            style: TextStyle(
                              fontFamily: 'Mozart',
                              fontSize: 19,
                              color: AppColors.primaryColor,
                              shadows: [
                                Shadow(
                                  color: Colors.white.withOpacity(0.8),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          item.isChecked = !item.isChecked;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: 173,
                child: TextField(
                  maxLength: 16,
                  controller: taskController,
                  style: const TextStyle(
                    fontSize: 23,
                    color: Color(0xff7CC4F1),
                  ),
                  decoration: const InputDecoration(
                    counterStyle:
                        TextStyle(color: Color(0xff7CC4F1), fontSize: 18),
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Add a task.',
                    hintStyle: TextStyle(
                      fontSize: 23,
                      color: Color(0xff82888C),
                    ),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (taskText) {
                    if (taskText.isNotEmpty) {
                      addTask(taskText);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

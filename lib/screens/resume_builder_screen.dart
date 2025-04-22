import 'package:flutter/material.dart';
import '../models/resume_model.dart';
import '../services/pdf_generator_service.dart';

class ThemeColors {
  static final mainTheme = ThemeData(
    primaryColor: Color(0xFF9C2C26), // Main color from the design
    colorScheme: ColorScheme.light(
      primary: Color(0xFF9C2C26),
      secondary: Color(0xFFFBF4F4), // Light background color
      surface: Colors.white,
      background: Color(0xFFFBF4F4),
      onPrimary: Colors.white,
      onSecondary: Color(0xFF9C2C26),
    ),
    scaffoldBackgroundColor: Color(0xFFFBF4F4),
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Color(0xFF9C2C26).withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF9C2C26).withOpacity(0.1), width: 1),
      ),
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF9C2C26).withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF9C2C26).withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Color(0xFF9C2C26), width: 2),
      ),
      labelStyle: TextStyle(color: Color(0xFF9C2C26).withOpacity(0.8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF9C2C26),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Color(0xFF9C2C26).withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF9C2C26);
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF9C2C26).withOpacity(0.3);
        }
        return Colors.grey.withOpacity(0.3);
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF9C2C26),
      elevation: 2,
      shadowColor: Color(0xFF9C2C26).withOpacity(0.1),
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF9C2C26)),
      titleTextStyle: TextStyle(
        color: Color(0xFF9C2C26),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Color(0xFF9C2C26),
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xFF9C2C26),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF2D3748),
        fontSize: 16,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Color(0xFF9C2C26).withOpacity(0.1),
      thickness: 2,
      space: 40,
    ),
  );
}

class ResumeBuilderScreen extends StatefulWidget {
  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ResumeModel _resume = ResumeModel(
    fullName: '',
    jobTitle: '',
    email: '',
    phone: '',
    skills: [],
    education: [],
    workExperiences: [],
    projects: [],
    certifications: [],
  );
  String _selectedTemplate = 'Modern';

  final List<String> _templates = [
    'Modern',
    'Professional',
    'Minimal',
  ];

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  // Lists for dynamic education input
  List<TextEditingController> educationInstitutionControllers = [];
  List<TextEditingController> educationDegreeControllers = [];
  List<TextEditingController> educationYearControllers = [];

  // Lists for dynamic work experience input
  List<TextEditingController> workCompanyControllers = [];
  List<TextEditingController> workPositionControllers = [];
  List<TextEditingController> workStartDateControllers = [];
  List<TextEditingController> workEndDateControllers = [];
  List<TextEditingController> workResponsibilitiesControllers = [];

  // Lists for dynamic projects input
  List<TextEditingController> projectNameControllers = [];
  List<TextEditingController> projectDurationControllers = [];
  List<TextEditingController> projectDescriptionControllers = [];
  List<TextEditingController> projectTechnologiesControllers = [];
  List<TextEditingController> projectLinkControllers = [];

  // Lists for dynamic certifications input
  List<TextEditingController> certNameControllers = [];
  List<TextEditingController> certIssuerControllers = [];
  List<TextEditingController> certDateControllers = [];
  List<TextEditingController> certExpiryDateControllers = [];
  List<TextEditingController> certIdControllers = [];
  List<TextEditingController> certUrlControllers = [];

  // Template and styling options
  String selectedFont = 'Roboto';
  List<String> fonts = [
    'Roboto',
    'Lobster',
    'OpenSans',
    'Pacifico',
    'Montserrat',
    'Lato'
  ];

  String selectedColorScheme = 'Professional';
  List<String> colorSchemes = [
    'Professional',
    'Creative',
    'Minimal',
    'Bold',
    'Modern'
  ];

  // Resume sections visibility
  bool showEducation = true;
  bool showWorkExperience = true;
  bool showSkills = true;
  bool showAddress = true;
  bool showProjects = true;
  bool showCertifications = true;

  @override
  void initState() {
    super.initState();
    _addEducationField();
    _addWorkExperienceField();
    _addProjectField();
    _addCertificationField();
  }

  @override
  void dispose() {
    // Dispose all controllers
    nameController.dispose();
    jobTitleController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    experienceController.dispose();
    skillsController.dispose();

    for (var controller in educationInstitutionControllers) {
      controller.dispose();
    }
    for (var controller in educationDegreeControllers) {
      controller.dispose();
    }
    for (var controller in educationYearControllers) {
      controller.dispose();
    }

    for (var controller in workCompanyControllers) {
      controller.dispose();
    }
    for (var controller in workPositionControllers) {
      controller.dispose();
    }
    for (var controller in workStartDateControllers) {
      controller.dispose();
    }
    for (var controller in workEndDateControllers) {
      controller.dispose();
    }
    for (var controller in workResponsibilitiesControllers) {
      controller.dispose();
    }

    for (var controller in projectNameControllers) {
      controller.dispose();
    }
    for (var controller in projectDurationControllers) {
      controller.dispose();
    }
    for (var controller in projectDescriptionControllers) {
      controller.dispose();
    }
    for (var controller in projectTechnologiesControllers) {
      controller.dispose();
    }
    for (var controller in projectLinkControllers) {
      controller.dispose();
    }

    for (var controller in certNameControllers) {
      controller.dispose();
    }
    for (var controller in certIssuerControllers) {
      controller.dispose();
    }
    for (var controller in certDateControllers) {
      controller.dispose();
    }
    for (var controller in certExpiryDateControllers) {
      controller.dispose();
    }
    for (var controller in certIdControllers) {
      controller.dispose();
    }
    for (var controller in certUrlControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _addEducationField() {
    setState(() {
      educationInstitutionControllers.add(TextEditingController());
      educationDegreeControllers.add(TextEditingController());
      educationYearControllers.add(TextEditingController());
    });
  }

  void _removeEducationField(int index) {
    setState(() {
      educationInstitutionControllers[index].dispose();
      educationDegreeControllers[index].dispose();
      educationYearControllers[index].dispose();

      educationInstitutionControllers.removeAt(index);
      educationDegreeControllers.removeAt(index);
      educationYearControllers.removeAt(index);
    });
  }

  void _addWorkExperienceField() {
    setState(() {
      workCompanyControllers.add(TextEditingController());
      workPositionControllers.add(TextEditingController());
      workStartDateControllers.add(TextEditingController());
      workEndDateControllers.add(TextEditingController());
      workResponsibilitiesControllers.add(TextEditingController());
    });
  }

  void _removeWorkExperienceField(int index) {
    setState(() {
      workCompanyControllers[index].dispose();
      workPositionControllers[index].dispose();
      workStartDateControllers[index].dispose();
      workEndDateControllers[index].dispose();
      workResponsibilitiesControllers[index].dispose();

      workCompanyControllers.removeAt(index);
      workPositionControllers.removeAt(index);
      workStartDateControllers.removeAt(index);
      workEndDateControllers.removeAt(index);
      workResponsibilitiesControllers.removeAt(index);
    });
  }

  void _addProjectField() {
    setState(() {
      projectNameControllers.add(TextEditingController());
      projectDurationControllers.add(TextEditingController());
      projectDescriptionControllers.add(TextEditingController());
      projectTechnologiesControllers.add(TextEditingController());
      projectLinkControllers.add(TextEditingController());
    });
  }

  void _removeProjectField(int index) {
    setState(() {
      projectNameControllers[index].dispose();
      projectDurationControllers[index].dispose();
      projectDescriptionControllers[index].dispose();
      projectTechnologiesControllers[index].dispose();
      projectLinkControllers[index].dispose();

      projectNameControllers.removeAt(index);
      projectDurationControllers.removeAt(index);
      projectDescriptionControllers.removeAt(index);
      projectTechnologiesControllers.removeAt(index);
      projectLinkControllers.removeAt(index);
    });
  }

  void _addCertificationField() {
    setState(() {
      certNameControllers.add(TextEditingController());
      certIssuerControllers.add(TextEditingController());
      certDateControllers.add(TextEditingController());
      certExpiryDateControllers.add(TextEditingController());
      certIdControllers.add(TextEditingController());
      certUrlControllers.add(TextEditingController());
    });
  }

  void _removeCertificationField(int index) {
    setState(() {
      certNameControllers[index].dispose();
      certIssuerControllers[index].dispose();
      certDateControllers[index].dispose();
      certExpiryDateControllers[index].dispose();
      certIdControllers[index].dispose();
      certUrlControllers[index].dispose();

      certNameControllers.removeAt(index);
      certIssuerControllers.removeAt(index);
      certDateControllers.removeAt(index);
      certExpiryDateControllers.removeAt(index);
      certIdControllers.removeAt(index);
      certUrlControllers.removeAt(index);
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // Save resume data to local storage
  void _saveResumeLocally() {
    // Implementation for saving to local storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resume saved locally')),
    );
  }

  // Load resume data from local storage
  void _loadResumeLocally() {
    // Implementation for loading from local storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resume loaded from local storage')),
    );
  }

  Future<void> _generateResume() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Generating your resume...'),
            ],
          ),
        ),
      );

      // Collect all data
      final resume = _buildResumeModel();

      // Close loading dialog
      Navigator.pop(context);

      // Generate and share PDF
      await PDFGeneratorService.generateResumePDF(
        resume,
        template: _selectedTemplate,
      );
    } catch (e) {
      // Close loading dialog if it's still showing
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to generate resume: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _previewResume() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Preparing preview...'),
            ],
          ),
        ),
      );

      // Collect all data
      final resume = _buildResumeModel();

      // Close loading dialog
      Navigator.pop(context);

      // Show preview
      await PDFGeneratorService.previewResumePDF(
        resume,
        template: _selectedTemplate,
      );
    } catch (e) {
      // Close loading dialog if it's still showing
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to preview resume: ${e.toString()}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  ResumeModel _buildResumeModel() {
    // Collect education entries
    List<EducationEntry> educationEntries = List.generate(
      educationInstitutionControllers.length,
      (index) => EducationEntry(
        institution: educationInstitutionControllers[index].text,
        degree: educationDegreeControllers[index].text,
        graduationYear: educationYearControllers[index].text,
      ),
    );

    // Collect work experience entries
    List<WorkExperience> workExperiences = List.generate(
      workCompanyControllers.length,
      (index) => WorkExperience(
        company: workCompanyControllers[index].text,
        position: workPositionControllers[index].text,
        startDate: workStartDateControllers[index].text,
        endDate: workEndDateControllers[index].text,
        responsibilities: workResponsibilitiesControllers[index]
            .text
            .split('\n')
            .where((line) => line.trim().isNotEmpty)
            .toList(),
      ),
    );

    // Collect project entries
    List<Project> projects = List.generate(
      projectNameControllers.length,
      (index) => Project(
        name: projectNameControllers[index].text,
        duration: projectDurationControllers[index].text,
        description: projectDescriptionControllers[index].text,
        technologies: projectTechnologiesControllers[index]
            .text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        link: projectLinkControllers[index].text,
      ),
    );

    // Collect certification entries
    List<Certification> certifications = List.generate(
      certNameControllers.length,
      (index) => Certification(
        name: certNameControllers[index].text,
        issuer: certIssuerControllers[index].text,
        date: certDateControllers[index].text,
        expiryDate: certExpiryDateControllers[index].text,
        credentialId: certIdControllers[index].text,
        credentialUrl: certUrlControllers[index].text,
      ),
    );

    // Create and return new resume model
    return ResumeModel(
      fullName: nameController.text,
      jobTitle: jobTitleController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: showAddress ? addressController.text : null,
      skills: skillsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      education: showEducation ? educationEntries : [],
      workExperiences: showWorkExperience ? workExperiences : [],
      projects: showProjects ? projects : [],
      certifications: showCertifications ? certifications : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeColors.mainTheme,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Resume Builder',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C2C26),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: _previewResume,
                tooltip: 'Preview Resume',
              ),
              IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: _generateResume,
                tooltip: 'Generate PDF',
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF8F9FA),
                  Color(0xFFF0F2F5),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Template Selection
                    _buildSectionCard(
                      'Template',
                      DropdownButtonFormField<String>(
                        value: _selectedTemplate,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        items: _templates.map((template) {
                          return DropdownMenuItem(
                            value: template,
                            child: Text(template),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTemplate = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),

                    // Personal Information Section
                    _buildSectionCard(
                      'Personal Information',
                      Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your name'
                                : null,
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: jobTitleController,
                            decoration: InputDecoration(
                              labelText: 'Job Title',
                              prefixIcon: Icon(Icons.work),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter job title'
                                : null,
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                      value!.isEmpty || !value.contains('@')
                                          ? 'Enter valid email'
                                          : null,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter phone number'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          SwitchListTile(
                            title: Text('Include Address'),
                            value: showAddress,
                            onChanged: (bool value) {
                              setState(() {
                                showAddress = value;
                              });
                            },
                          ),
                          if (showAddress)
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                prefixIcon: Icon(Icons.location_on),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Work Experience Section
                    _buildExpandableSection(
                      'Work Experience',
                      showWorkExperience,
                      (bool value) {
                        setState(() {
                          showWorkExperience = value;
                        });
                      },
                      _buildWorkExperienceSection(),
                    ),

                    // Projects Section
                    _buildExpandableSection(
                      'Projects',
                      showProjects,
                      (bool value) {
                        setState(() {
                          showProjects = value;
                        });
                      },
                      _buildProjectsSection(),
                    ),

                    // Certifications Section
                    _buildExpandableSection(
                      'Certifications',
                      showCertifications,
                      (bool value) {
                        setState(() {
                          showCertifications = value;
                        });
                      },
                      _buildCertificationsSection(),
                    ),

                    // Skills Section
                    _buildExpandableSection(
                      'Skills',
                      showSkills,
                      (bool value) {
                        setState(() {
                          showSkills = value;
                        });
                      },
                      _buildSkillsSection(),
                    ),

                    // Education Section
                    _buildExpandableSection(
                      'Education',
                      showEducation,
                      (bool value) {
                        setState(() {
                          showEducation = value;
                        });
                      },
                      _buildEducationSection(),
                    ),

                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _previewResume,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF9C2C26),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shadowColor: Color(0xFF9C2C26).withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove_red_eye, size: 18),
                                  SizedBox(width: 4),
                                  Text('Preview'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _generateResume,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF9C2C26),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shadowColor: Color(0xFF9C2C26).withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.picture_as_pdf, size: 18),
                                  SizedBox(width: 4),
                                  Text('Generate PDF'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9C2C26).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF9C2C26),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Divider(
              color: Color(0xFF9C2C26).withOpacity(0.1),
              thickness: 2,
              height: 40,
            ),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
    String title,
    bool isExpanded,
    Function(bool) onChanged,
    Widget content,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          SwitchListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: isExpanded,
            onChanged: onChanged,
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.all(20),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildWorkExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Work Experience'),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Work Experience'),
          onPressed: _addWorkExperienceField,
        ),
        SizedBox(height: 8),
        for (int i = 0; i < workCompanyControllers.length; i++)
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Experience ${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeWorkExperienceField(i),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: workCompanyControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Company',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: workPositionControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Position',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _selectDate(context, workStartDateControllers[i]),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: workStartDateControllers[i],
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              _selectDate(context, workEndDateControllers[i]),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: workEndDateControllers[i],
                              decoration: InputDecoration(
                                labelText: 'End Date (or Present)',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: workResponsibilitiesControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Responsibilities (one per line)',
                      border: OutlineInputBorder(),
                      hintText: 'Enter responsibilities, one per line',
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Skills'),
        TextFormField(
          controller: skillsController,
          decoration: InputDecoration(
            labelText: 'Skills (comma separated)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.psychology),
            hintText: 'e.g., Java, Project Management, Public Speaking',
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tip: Enter your skills separated by commas',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Education'),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Education'),
          onPressed: _addEducationField,
        ),
        SizedBox(height: 8),
        for (int i = 0; i < educationInstitutionControllers.length; i++)
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Education ${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeEducationField(i),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: educationInstitutionControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Institution',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.school),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: educationDegreeControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Degree',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.grade),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: educationYearControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Graduation Year',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Project'),
          onPressed: _addProjectField,
        ),
        SizedBox(height: 8),
        for (int i = 0; i < projectNameControllers.length; i++)
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Project ${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeProjectField(i),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: projectNameControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Project Name',
                      prefixIcon: Icon(Icons.work),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: projectDurationControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: projectDescriptionControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: projectTechnologiesControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Technologies (comma separated)',
                      prefixIcon: Icon(Icons.code),
                      hintText: 'e.g., React, Node.js, MongoDB',
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: projectLinkControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Project Link (optional)',
                      prefixIcon: Icon(Icons.link),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCertificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Certification'),
          onPressed: _addCertificationField,
        ),
        SizedBox(height: 8),
        for (int i = 0; i < certNameControllers.length; i++)
          Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Certification ${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeCertificationField(i),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: certNameControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Certification Name',
                      prefixIcon: Icon(Icons.card_membership),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: certIssuerControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Issuing Organization',
                      prefixIcon: Icon(Icons.business),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: certDateControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Issue Date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () =>
                              _selectDate(context, certDateControllers[i]),
                          readOnly: true,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: certExpiryDateControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Expiry Date (if any)',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(
                              context, certExpiryDateControllers[i]),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: certIdControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Credential ID (optional)',
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: certUrlControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Credential URL (optional)',
                      prefixIcon: Icon(Icons.link),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}

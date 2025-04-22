class ResumeModel {
  final String fullName;
  final String jobTitle;
  final String email;
  final String phone;
  final String? address;
  final List<String> skills;
  final List<EducationEntry> education;
  final List<WorkExperience> workExperiences;
  final List<Project> projects;
  final List<Certification> certifications;

  ResumeModel({
    required this.fullName,
    required this.jobTitle,
    required this.email,
    required this.phone,
    this.address,
    required this.skills,
    required this.education,
    required this.workExperiences,
    required this.projects,
    required this.certifications,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'jobTitle': jobTitle,
      'email': email,
      'phone': phone,
      'address': address,
      'skills': skills,
      'education': education.map((e) => e.toJson()).toList(),
      'workExperiences': workExperiences.map((e) => e.toJson()).toList(),
      'projects': projects.map((e) => e.toJson()).toList(),
      'certifications': certifications.map((e) => e.toJson()).toList(),
    };
  }

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      fullName: json['fullName'] as String,
      jobTitle: json['jobTitle'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      skills: List<String>.from(json['skills'] as List),
      education: (json['education'] as List)
          .map((e) => EducationEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      workExperiences: (json['workExperiences'] as List)
          .map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      certifications: (json['certifications'] as List)
          .map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EducationEntry {
  final String institution;
  final String degree;
  final String graduationYear;

  EducationEntry({
    required this.institution,
    required this.degree,
    required this.graduationYear,
  });

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'graduationYear': graduationYear,
    };
  }

  factory EducationEntry.fromJson(Map<String, dynamic> json) {
    return EducationEntry(
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      graduationYear: json['graduationYear'] as String,
    );
  }
}

class WorkExperience {
  final String company;
  final String position;
  final String startDate;
  final String endDate;
  final List<String> responsibilities;

  WorkExperience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.responsibilities,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'responsibilities': responsibilities,
    };
  }

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      company: json['company'] as String,
      position: json['position'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      responsibilities: List<String>.from(json['responsibilities'] as List),
    );
  }
}

class Project {
  final String name;
  final String duration;
  final String description;
  final List<String> technologies;
  final String link;

  Project({
    required this.name,
    required this.duration,
    required this.description,
    required this.technologies,
    required this.link,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'description': description,
      'technologies': technologies,
      'link': link,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      link: json['link'] as String,
    );
  }
}

class Certification {
  final String name;
  final String issuer;
  final String date;
  final String expiryDate;
  final String credentialId;
  final String credentialUrl;

  Certification({
    required this.name,
    required this.issuer,
    required this.date,
    required this.expiryDate,
    required this.credentialId,
    required this.credentialUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'issuer': issuer,
      'date': date,
      'expiryDate': expiryDate,
      'credentialId': credentialId,
      'credentialUrl': credentialUrl,
    };
  }

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      name: json['name'] as String,
      issuer: json['issuer'] as String,
      date: json['date'] as String,
      expiryDate: json['expiryDate'] as String,
      credentialId: json['credentialId'] as String,
      credentialUrl: json['credentialUrl'] as String,
    );
  }
}

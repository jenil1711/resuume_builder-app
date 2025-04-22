import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path/path.dart' as path;

import '../models/resume_model.dart';

class PDFGeneratorService {
  static Future<void> generateResumePDF(ResumeModel resume,
      {String template = 'Modern'}) async {
    final pdf = await _createPDF(resume, template);
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
  }

  static Future<void> previewResumePDF(ResumeModel resume,
      {String template = 'Modern'}) async {
    final pdf = await _createPDF(resume, template);
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'Resume.pdf',
    );
  }

  static Future<pw.Document> _createPDF(
      ResumeModel resume, String template) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: _getPageTheme(template),
        build: (context) => [
          _buildHeader(resume),
          if (resume.address != null) _buildAddress(resume.address!),
          pw.SizedBox(height: 20),
          _buildSection('Professional Summary', [
            pw.Text(
              '${resume.jobTitle} with expertise in ${resume.skills.join(", ")}.',
              style: pw.TextStyle(fontSize: 12),
            ),
          ]),
          if (resume.workExperiences.isNotEmpty)
            _buildSection(
                'Work Experience',
                resume.workExperiences
                    .map((exp) => _buildWorkExperience(exp))
                    .toList()),
          if (resume.education.isNotEmpty)
            _buildSection('Education',
                resume.education.map((edu) => _buildEducation(edu)).toList()),
          if (resume.projects.isNotEmpty)
            _buildSection('Projects',
                resume.projects.map((proj) => _buildProject(proj)).toList()),
          if (resume.certifications.isNotEmpty)
            _buildSection(
                'Certifications',
                resume.certifications
                    .map((cert) => _buildCertification(cert))
                    .toList()),
          if (resume.skills.isNotEmpty)
            _buildSection('Skills', [
              pw.Wrap(
                spacing: 8,
                runSpacing: 8,
                children: resume.skills
                    .map((skill) => pw.Container(
                          padding: pw.EdgeInsets.all(4),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Text(skill),
                        ))
                    .toList(),
              ),
            ]),
        ],
      ),
    );

    return pdf;
  }

  static pw.PageTheme _getPageTheme(String template) {
    switch (template) {
      case 'Modern':
        return pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.helvetica(),
            bold: pw.Font.helveticaBold(),
          ),
          buildBackground: (context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
        );
      case 'Professional':
        return pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.times(),
            bold: pw.Font.timesBold(),
          ),
          buildBackground: (context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
        );
      case 'Minimal':
        return pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.courier(),
            bold: pw.Font.courierBold(),
          ),
          buildBackground: (context) => pw.Container(),
        );
      default:
        return pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.helvetica(),
            bold: pw.Font.helveticaBold(),
          ),
          buildBackground: (context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
        );
    }
  }

  static pw.Widget _buildHeader(ResumeModel resume) {
    return pw.Container(
      padding: pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            resume.fullName,
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            resume.email,
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            resume.phone,
            style: pw.TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildAddress(String address) {
    return pw.Container(
      padding: pw.EdgeInsets.symmetric(horizontal: 20),
      child: pw.Text(
        address,
        style: pw.TextStyle(fontSize: 12),
      ),
    );
  }

  static pw.Widget _buildSection(String title, List<pw.Widget> children) {
    return pw.Container(
      padding: pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  static pw.Widget _buildWorkExperience(WorkExperience exp) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            exp.position,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            exp.company,
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            '${exp.startDate} - ${exp.endDate}',
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 4),
          ...exp.responsibilities.map((resp) => pw.Text(
                '• $resp',
                style: pw.TextStyle(fontSize: 10),
              )),
        ],
      ),
    );
  }

  static pw.Widget _buildEducation(EducationEntry edu) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            edu.degree,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            edu.institution,
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            edu.graduationYear,
            style: pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProject(Project proj) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            proj.name,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            proj.duration,
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            proj.description,
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            'Technologies: ${proj.technologies.join(", ")}',
            style: pw.TextStyle(fontSize: 10),
          ),
          if (proj.link.isNotEmpty)
            pw.Text(
              'Link: ${proj.link}',
              style: pw.TextStyle(fontSize: 10),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildCertification(Certification cert) {
    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            cert.name,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            cert.issuer,
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            'Issued: ${cert.date}',
            style: pw.TextStyle(fontSize: 10),
          ),
          if (cert.expiryDate.isNotEmpty)
            pw.Text(
              'Expires: ${cert.expiryDate}',
              style: pw.TextStyle(fontSize: 10),
            ),
          if (cert.credentialId.isNotEmpty)
            pw.Text(
              'ID: ${cert.credentialId}',
              style: pw.TextStyle(fontSize: 10),
            ),
          if (cert.credentialUrl.isNotEmpty)
            pw.Text(
              'URL: ${cert.credentialUrl}',
              style: pw.TextStyle(fontSize: 10),
            ),
        ],
      ),
    );
  }
}

# Resume Builder

A modern, user-friendly Flutter application for creating professional resumes with customizable templates and sections.

![Resume Builder Screenshot](screenshots/resume-builder-screenshot.png)

## Features

- 🎨 Multiple professional templates (Modern, Professional, Minimal)
- 📝 Comprehensive resume sections:
  - Personal Information
  - Work Experience
  - Education
  - Skills
  - Projects
  - Certifications
- ✨ Modern and clean UI with customizable themes
- 📱 Responsive design for all screen sizes
- 📄 PDF generation and preview
- 🔄 Dynamic form fields for multiple entries
- 🎯 Form validation for required fields
- 📅 Date picker for experience and certification dates
- 🎨 Customizable color schemes and fonts

## Getting Started

### Prerequisites

- Flutter SDK (version 3.6.0 or higher)
- Dart SDK (version 3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/resume-builder.git
cd resume-builder
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage Guide

### Creating a Resume

1. **Select Template**
   - Choose from Modern, Professional, or Minimal templates
   - Each template has unique styling and layout

2. **Fill Personal Information**
   - Enter your full name, job title, email, and phone
   - Optionally include your address

3. **Add Work Experience**
   - Click "Add Work Experience" to add new entries
   - Fill in company name, position, dates, and responsibilities
   - Add multiple experiences as needed

4. **Add Education**
   - Click "Add Education" to add new entries
   - Enter institution name, degree, and graduation year
   - Add multiple education entries as needed

5. **Add Skills**
   - Enter your skills separated by commas
   - Skills will be formatted as tags in the PDF

6. **Add Projects**
   - Click "Add Project" to add new entries
   - Include project name, duration, description, and technologies
   - Optionally add project links

7. **Add Certifications**
   - Click "Add Certification" to add new entries
   - Include certification name, issuer, dates, and credential details

### Generating PDF

1. **Preview Resume**
   - Click the "Preview" button to see how your resume looks
   - Make adjustments as needed

2. **Generate PDF**
   - Click the "Generate PDF" button
   - Choose where to save the PDF file
   - Share or download the generated resume

## Project Structure

```
resume_builder/
├── lib/
│   ├── models/
│   │   └── resume_model.dart
│   ├── screens/
│   │   └── resume_builder_screen.dart
│   ├── services/
│   │   └── pdf_generator_service.dart
│   └── main.dart
├── assets/
│   └── fonts/
├── android/
├── ios/
├── web/
└── pubspec.yaml
```

## Dependencies

- `flutter`: Core Flutter framework
- `pdf`: For PDF generation
- `printing`: For PDF preview and sharing
- `path_provider`: For file system access
- `path`: For path manipulation
- `file_picker`: For file operations
- `google_fonts`: For custom fonts

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- All contributors who have helped improve this project

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)

Project Link: [https://github.com/yourusername/resume-builder](https://github.com/yourusername/resume-builder)# resuume_builder-app

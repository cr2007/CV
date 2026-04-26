#import "resume.typ": *
#import "@preview/oxifmt:1.0.0": strfmt

#let data = yaml("metadata.yml")

// Put your personal information here, replacing mine
#let name          = data.at("name")
#let location      = data.at("location")
#let email         = data.at("email")
#let github        = strfmt("github.com/{}", data.at("githubUsername"))
#let linkedin      = strfmt("linkedin.com/in/{}", data.at("linkedinUsername"))
#let phone         = data.at("phone")
#let personal-site = data.at("website")

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  phone: phone,
  personal-site: personal-site,
  // accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "a4",
  author-position: left,
  personal-info-position: center,
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/

== Work Experience

#work(
  title: "Software Engineer",
  location: "Dubai, UAE",
  company: "ODeX Global",
  dates: dates-helper(start-date: "December 2024", end-date: "Present"),
)
#v(-0.5em)

- Developing scalable Spring Boot microservices with secure, reactive APIs for multi-module backend systems on AWS
- Designing and optimising RESTful APIs for customer-facing  dashboards, improving service delivery efficiency by 30\%
- Driving efficiency by crafting AI strategies that streamline internal workflows and elevate product experiences

#work(
  title: "Solutions Intern",
  location: "Dubai, UAE",
  company: "Emirates Group",
  dates: dates-helper(start-date: "September 2024", end-date: "December 2024"),
)

#v(-0.5em)

- Coordinated cross-team and vendor requirements for Skywards Rewards backend replacement
- Designed use case diagrams and specifications to streamline the Accrual process
- Documented project workflows and progress in Confluence for stakeholder alignment

== Skills

#grid(
  rows: 6,
  columns: (auto, 1fr),
  row-gutter: 0.75em,
  column-gutter: 0.5em,
  // align: (left, right),
  [*Languages:*], [Python, Go, Java (Spring Boot), Bash, SQL, PostgreSQL, JavaScript, PowerShell, HTML, CSS, C\#],
  [*Tools:*], text(spacing: 45%)[Git, GitHub, Bitbucket, Ollama, Figma, ChatGPT, CI/CD, Docker, Kubernetes, GitHub Actions, Puppet],
  [*Soft Skills:*], [Communication, Collaboration, Leadership, Problem Solving, Stakeholder Management, Delegation],
  [*Business Skills:*], [Analytical Skills, Organizational Skills, Strategy, Microsoft Excel, MS Office, Research],
  [*Platforms:*], [Linux, Ubuntu, Windows, Amazon Web Services, AWS S3, Google Cloud Platform, Web],
  [*Other Skills:*], [Valid UAE Driving License, Adobe Premiere Pro CC, Video Editing],
)

#v(-0.5em)

== Projects

#project(
  name: "AI Chat Prompt URL Maker",
  dates: "January 2026",
  // role: "",
  url: (
    "Live Project": "cr2007.github.io/chatgpt-url-maker",
    "Project Link": "github.com/cr2007/chatgpt-url-maker"
  ),
  tech: ("TypeScript", "React", "Vite", "Bun"),
  desc: "Built a web app that generates shareable, prefilled prompt URLs for AI chat tools."
)

#v(-3pt)

#project(
  name: "Wordle Model Context Protocol Server",
  dates: "June 2025",
  url: (
    "Python Project Link": "github.com/cr2007/mcp-wordle-python",
    "Go Project Link": "github.com/cr2007/mcp-wordle-go",
  ),
  tech: ("uv", "Python", "FastMCP"),
  desc: "Built a MCP server that retrieves Wordle solutions by date, demonstrating API integrations."
)

#v(-3pt)

#project(
  name: "AI Chat Heatmap Visualizer",
  dates: "January 2025",
  url: (
    "Live Project": "aiheatmap.csk.fyi",
    "Project Link": "github.com/cr2007/chatgpt-heatmap-web",
  ),
  tech: ("TypeScript", "Next.js", "D3.js", "Bun"),
  desc: "Built an app that visualizes exported ChatGPT conversation history as an interactive calendar heatmap."
)

#v(-3pt)

#project(
  name: "WhatsApp Voice AI Assistant",
  dates: "August 2024",
  url: (
    "Project Link": "github.com/cr2007/whatsapp-voice-ai-assistant",
  ),
  tech: ("Go", "Python", "OpenAI Whisper", "Groq API"),
  desc: "Developed a microservice-based WhatsApp bot that transcribes voice messages and generates AI responses.",
)

#v(-3pt)

== Awards and Certifications

#certificates(
  name: "Google IT Automation with Python Specialization",
  issuer: "Coursera",
  date: "October 2024",
  url: "coursera.org/verify/professional-cert/TCQO05PHHGE5"
)

#v(-3pt)

#certificates(
  name: "Winner",
  issuer: "Camb.ai X Coders HQ Hackathon",
  date: "May 2024",
)

#v(-3pt)

#certificates(
  name: "Career Essentials in Software Development by Microsoft and LinkedIn",
  issuer: "LinkedIn",
  date: "May 2024",
  url: "linkedin.com/learning/certificates/89ecc674e4f0587a88390cc07ce509093d8b63cd8bcb02e3fd833e966bba7ea8"
)

#v(-3pt)

#certificates(
  name: "Google IT Support Specialization",
  issuer: "Coursera",
  date: "June 2022",
  url: "coursera.org/verify/professional-cert/KXSX89ULVN5F"
)

#v(-0.5pt)

== Education

#edu(
  institution: "Georgia Institute of Technology",
  location: "Dubai, UAE",
  dates: dates-helper(start-date: "Jan 2026", end-date: "Present"),
  degree: "Master's of Science, Computer Science",
)
#v(-0.25em)
#text(size: 9pt)[*Courses:* Introduction to Information Security]
// - Cumulative GPA: 4.0\/4.0 | Dean's List, Harvey S. Mudd Merit Scholarship, National Merit Scholarship

#edu(
  institution: "Heriot-Watt University",
  location: "Dubai, UAE",
  dates: "Batch of 2024",
  degree: "Bachelor's of Science, Computer Science (Hons.)",
)
#v(-0.25em)
#text(size: 9pt)[*Courses:* Data Visualization and Analytics, Digital Forensics, Computer Network Security, Industrial Programming, Data Communications \& Networking, Operating Systems \& Concurrency, Data Structures and Algorithms, Hardware-Software Interface]

== Volunteer Experience

#work(
  company: link("https://gdg.community.dev/gdg-on-campus-heriot-watt-university-dubai-dubai-united-arab-emirates")[Google Developer Student Clubs],
  title: "Chapter Lead",
  dates: dates-helper(start-date: "July 2022", end-date: "June 2023"),
  location: "Dubai, UAE"
)

- Directed a 6-member core team to deliver workshops \& events on Google technologies for a diverse student community
- Mentored peers through delegation, coaching, and technical enablement, fostering trust and impactful collaboration
- Boosted club engagement by 50\% through creative outreach and community-driven initiatives.

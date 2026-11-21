# Code style & error handling
- Fail early with a readable error message. Detect wrong/missing things upfront rather than letting the program fail later with a cryptic missing-attribute error.
  - "Fail early" and "readable error message" concept is nice but should not hide the original error and original stack trace
- Do not over-validate. Leave flexibility for data format; stay python-ish.
- Respect mathematical and logical validity: Don't reject valid cases simply because they're unusual, empty, or degenerate.

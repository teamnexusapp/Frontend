# LANGUAGE REQUIREMENTS - NEXUS FERTILITY APP

## CRITICAL DIRECTIVE
Effective immediately, the Nexus Fertility App must ONLY support these 4 languages:
1. **English** (Primary/default)
2. **Yoruba** 
3. **Igbo**
4. **Hausa**

## MANDATORY ACTIONS REQUIRED:
1. **REMOVE** all other language implementations (including Spanish, French, Portuguese)
2. **DELETE** any localization files for non-approved languages
3. **UPDATE** language selection UI to show ONLY these 4 options
4. **VERIFY** no code references to other languages exist
5. **PREVENT** future implementation of any additional languages

## RATIONALE:
This decision ensures focus on the core Nigerian market with appropriate local language support while maintaining development efficiency.

## ENFORCEMENT:
- All PRs must verify language compliance
- CI/CD pipeline should check for unauthorized language files
- Database should reject non-approved language codes

## TESTING REQUIREMENTS:
- Language selector must show exactly 4 options
- No fallback to unauthorized languages
- All screens must support all 4 languages
- Language persistence must work for all 4

## CONTACT:
For questions or clarification, contact the product owner.

Document created by: Olat
Date: 2026-01-08
Status: ACTIVE AND ENFORCED

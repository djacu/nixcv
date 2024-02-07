# Site

## Netlify setup

1. Go to Netlify create site page
1. Select GitHub and pick the template repo you created in the Getting Started step.
1. Finally click on the Deploy site button.

## Steps to integrate with nwtgck/actions-netlify

- Setup personal access token from netlify
    1. Go [here](https://app.netlify.com/user/applications#personal-access-tokens)
    1. Personal access token -> New access token
    1. Go to repo -> Settings -> Security -> Secrets and variables -> Actions -> Repository secrets
    1. Store the token as `NETLIFY_AUTH_TOKEN`
- Setup site ID from netlify
    1. Go to netlify -> team page -> the site -> Site configuration -> Site information
    1. There is a field `Site ID`; copy that token
    1. Go to repo -> Settings -> Security -> Secrets and variables -> Actions -> Repository secrets
    1. Store the token as `NETLIFY_SITE_ID`
- Let the action write comments on PRs
    1. Go to repo -> Settings -> Code and automation -> Actions -> General -> Workflow permissions
    1. Check 'Read and write permissions'
- Turn off Netlify's Deploy Previews
    1. Go to [Site configuration -> Build & deploy -> Continuous Deployment -> Branches and deploy contexts](https://app.netlify.com/sites/nixcv/configuration/deploys#branches-and-deploy-contexts)
    1. Select `Configure`
    1. Under Deploy Previews, select `None`

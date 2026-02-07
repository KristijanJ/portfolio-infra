# Portfolio Infra

Hello, this is the infrastructure for my personal portfolio.

It is a very simple terraform project, containing a CloudFront distribution.

The Route53 hosted zone and Certificate are manually configured in my AWS account.

## Frontend code

The frontend code for this project can be found at [Github Portfolio](https://github.com/KristijanJ/portfolio)

## Github actions

The code in this project is deployed using a manually triggered CI/CD pipeline using github actions. See `.github/workflows/deploy.yml`

The actions for this project might not be needed seeing as how I am the only developer working on it, but they are mostly used as a showcase of my ability to work with Github actions.

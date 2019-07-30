
var reporter = require('cucumber-html-reporter');

var report_options = {
    theme: 'bootstrap',
    jsonDir: '/Users/sahmed/projects/bdso_api_bdd_tests/results/',
    output: '/Users/sahmed/projects/bdso_api_bdd_tests/results/cucumber_report.html',
    reportSuiteAsScenarios: true,
    launchReport: false,
    ignoreBadJsonFile:true,
    name:'BDSO API Cucumber Reports'
};

reporter.generate(report_options);

var reporter = require('cucumber-html-reporter');

var report_options = {
    theme: 'bootstrap',
    jsonFile: '../results/results_api_output.json',
    output: '../results/cucumber_report.html',
    reportSuiteAsScenarios: true,
    launchReport: false,
    ignoreBadJsonFile:true,
    name:'Retropaper API Cucumber Reports'
};

reporter.generate(report_options);
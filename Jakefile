/*
 * Jakefile
 * ClassifierSandbox2
 *
 * Created by You on January 26, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("ClassifierSandbox2", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "ClassifierSandbox2.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("ClassifierSandbox2");
    task.setIdentifier("com.yourcompany.ClassifierSandbox2");
    task.setVersion("1.0");
    task.setAuthor("Your Company");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("ClassifierSandbox2");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");
    task.setNib2CibFlags("-R Resources/");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["ClassifierSandbox2"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "ClassifierSandbox2", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "ClassifierSandbox2", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "ClassifierSandbox2"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "ClassifierSandbox2"), FILE.join("Build", "Deployment", "ClassifierSandbox2")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "ClassifierSandbox2"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "ClassifierSandbox2"), FILE.join("Build", "Desktop", "ClassifierSandbox2", "ClassifierSandbox2.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "ClassifierSandbox2", "ClassifierSandbox2.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "ClassifierSandbox2"));
    print("----------------------------");
}

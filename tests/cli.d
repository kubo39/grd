version (unittest):

import std.file;
import std.process;

void findContentInFile()
{
    auto p = execute(["dub", "run", "-q", "--", "test", "tests/test.txt"]);
    assert(p.output == "A test\nAnother test\n");
}

void specifyOutputFile()
{
    auto deleteme = "deleteme";
    auto p = execute(["dub", "run", "-q", "--", "-o", deleteme, "test", "tests/test.txt"]);
    assert(exists(deleteme));
    scope (exit) remove(deleteme);
    assert(readText(deleteme) == "A test\nAnother test\n");
}

void main()
{
    findContentInFile();
    specifyOutputFile();
}

version (unittest):

import std.process;

void findContentInFile()
{
    auto p = execute(["dub", "run", "-q", "--", "test", "tests/test.txt"]);
    assert(p.output == "A test\nAnother test\n");
}

void main()
{
    findContentInFile();
}

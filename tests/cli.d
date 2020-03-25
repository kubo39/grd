version (unittest)  : import std.file;
import std.process;

// findContentInFile.
unittest
{
    const p = execute(["dub", "run", "-q", "--", "test", "tests/test.txt"]);
    assert(p.output == "A test\nAnother test\n");
}

// specifyOutputFile.
unittest
{
    const deleteme = "deleteme";
    cast(void) execute([
            "dub", "run", "-q", "--", "-o", deleteme, "test", "tests/test.txt"
            ]);
    assert(exists(deleteme));
    scope (exit)
        remove(deleteme);
    assert(readText(deleteme) == "A test\nAnother test\n");
}

// multipleOutputFiles.
unittest
{
    const deleteme1 = "deleteme1";
    const deleteme2 = "deleteme2";
    cast(void) execute(["dub", "run", "-q", "--",
                        "-o", deleteme1,
                        "-o", deleteme2,
                        "test",
                        "tests/test.txt"]);
    assert(exists(deleteme1) && exists(deleteme2));
    scope (exit)
    {
        remove(deleteme1);
        remove(deleteme2);
    }
    assert(readText(deleteme1) == "A test\nAnother test\n");
    assert(readText(deleteme2) == "A test\nAnother test\n");
}

void main() {}

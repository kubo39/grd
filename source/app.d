import core.stdc.stdlib;
import std.exception;
import std.file;
import std.stdio;

import commandr;

import grd;

///
class CustomError : Exception
{
    ///
    this(string msg, string file = __FILE__, size_t line = __LINE__) @safe pure nothrow
    {
        super(msg, file, line);
    }
}

version (unittest)
{
    void main()
    {
    }
}
else
    int main(string[] args)
{
    auto a = new Program("grd", "1.0")
        .author("Hiroki Noda <kubo39@gmail.com>")
        .add(new Option("o", "output", "output file name")
             .name("output")
             .repeating
             .optional)
        .add(new Argument("pattern", "match pattern").required)
        .add(new Argument("path", "path to file").required)
        .parse(args);

    try
    {
        auto content = a.arg("path").readText;
        if (!a.optionAll("output").length)
        {
            findMatches(content, a.arg("pattern"), stdout.lockingTextWriter());
        }
        else
        {
            foreach (outputFile; a.optionAll("output"))
            {
                auto output = File(outputFile, "w");
                findMatches(content, a.arg("pattern"), output.lockingTextWriter());
            }
        }
    }
    catch (ErrnoException e)
    {
        throw new CustomError("Error reading " ~ a.arg("path") ~ ": " ~ e.msg);
    }
    return EXIT_SUCCESS;
}

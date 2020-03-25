module grd;

import std.algorithm;
import std.range;
import std.stdio;
import std.string;

///
void findMatches(T)(string input, string pattern, T writer) @system
    if (isOutputRange!(T, char))
{
    foreach (line; input.splitLines)
    {
        if (line.canFind(pattern))
        {
            writer.put(line);
            writer.put('\n');
        }
    }
}

@system unittest
{
    import std.array : appender;

    auto content = "lorem ipsum\ndolor sit amet";
    auto results = appender!(char[]);
    findMatches(content, "lorem", results);
    assert(results.data == "lorem ipsum\n", results.data);
}

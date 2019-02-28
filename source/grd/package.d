module grd;

import std.algorithm;
import std.range;
import std.string;

void findMatches(T)(string content, string pattern, T writer)
    if (isOutputRange!(T, char))
{
    foreach (line; lineSplitter(content))
    {
        if (line.canFind(pattern))
        {
            writer.put(line);
            writer.put('\n');
        }
    }
}

unittest
{
    void findOneMatch()
    {
        char[] results;
        findMatches("lorem ipsum\ndolor sit amet", "lorem", results);
        assert(results == "lorem ipsum\n");
    }
}

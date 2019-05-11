module grd;

import std.algorithm;
import std.range;
import std.stdio;

///
void findMatches(T)(File input, string pattern, T writer)
        if (isOutputRange!(T, char))
{
    foreach (line; input.byLine)
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
        import std.array : appender;

        auto tmp = File.tmpfile();
        scope (exit)
            tmp.close();
        tmp.write("lorem ipsum\ndolor sit amet");
        tmp.flush();
        auto results = appender!(char[]);
        findMatches(tmp, "lorem", results);
        assert(results.data == "lorem ipsum\n");
    }
}

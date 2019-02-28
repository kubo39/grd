import std.getopt;
import std.stdio;

void usage()
{
    stderr.writeln(`
USAGE:
    grd <pattern> <path>
`);
}

int main(string[] args)
{
    string output = void;
    auto helpInformation = args.getopt("o|output", &output);
    if (helpInformation.helpWanted)
    {
        usage();
        return 0;
    }
    if (args.length < 2)
    {
        usage();
        return 1;
    }
    string pattern = args[1];
    string path = args[2];

    writeln(args[1 .. 3]);
    return 0;
}

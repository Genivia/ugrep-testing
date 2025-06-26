#include <iostream>
#include <vector>

int main(int argc, char **argv)
{
  if (argc < 2)
  {
    printf("Usage: pick num [min [max [suffix]]] < file\nPicks num lines from file such that each line length >= min and length <= max\nwhere zero min picks any line length >= min,\notherwise at least one line has length == min.\n\n");
    exit(0);
  }
  int num = atoi(argv[1]);
  int min = 0;
  int max = 100000;
  const char *suffix = "";
  size_t shortest = max;
  if (argc >= 3)
    min = atoi(argv[2]);
  if (argc >= 4)
    max = atoi(argv[3]);
  if (max < min)
    exit(EXIT_FAILURE);
  if (argc >= 5)
    suffix = argv[4];
  std::vector<std::string> patterns;
  while (!std::cin.eof())
  {
    std::string pattern;
    getline(std::cin, pattern);
    patterns.push_back(pattern);
  }
  sranddev();
  while (num > 0)
  {
    std::string& pattern = patterns[rand() % patterns.size()];
    if ((min <= 0 ? pattern.size() > 0 : pattern.size() >= min) && pattern.size() <= max)
    {
      if (pattern.size() < shortest)
        shortest = pattern.size();
      // make sure we have at least one minimal pattern
      if (num == 1 && min > 0 && shortest > min)
        continue;
      // output
      std::cout << pattern << suffix << '\n';
      // remove from the set
      pattern.clear();
      --num;
    }
  }
}

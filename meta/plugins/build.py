from osdk.args import Args
from osdk.rules import Rule, append as rule_append

rule_append(Rule("fbc", ["*.bas"], ["*.o"], "-c -o $out $in -lang fb -gen gcc -g $flags"))
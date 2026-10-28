# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "ruamel.yaml",
# ]
# ///

from ruamel.yaml import YAML
import json
import re
import argparse
import subprocess
import pathlib

yaml = YAML(typ="rt")


def maybe_first(item, default):
    return next(iter(item), default)


def modify_versions(spec, replacer):
    deps = spec["dependencies"]

    # Drop any versions
    for i, dep in enumerate(deps):
        if not isinstance(dep, str):
            continue

        name, *constraint = re.split(r"[<>=~!]", dep, maxsplit=1)
        new_constraint = replacer(name, maybe_first(constraint, ""))
        deps[i] = f"{name}{new_constraint}"


def to_constraint_with_patches(constraint: str) -> str:
    # Assume we can treat _all_ deps as x.y.z, even if they're x.y, or x.y.z.m
    major, minor, patch, *_ = [*constraint.split("."), 0, 0, 0]
    return f"~={major}.{minor}.{patch}"


def cli(args):
    # First, build a "loose" spec
    spec = yaml.load(args.src.read_text())

    # Solve it
    output_json = subprocess.check_output(
        [
            "micromamba",
            "create",
            "-n demo",
            "-f",
            args.src,
            f"python~={args.python}",
            "--dry-run",
            "--json",
        ]
    )
    output = json.loads(output_json)

    solved_constraints = {
        r["name"]: to_constraint_with_patches(r["version"])
        for r in output["actions"]["LINK"]
    }

    # Rebuild the environment
    def solved_constraint(name, constraint):
        return solved_constraints.get(name, "")

    modify_versions(spec, replacer=solved_constraint)

    with args.src.open("w") as f:
        yaml.dump(spec, f)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("src", type=pathlib.Path)
    parser.add_argument("python", type=str)
    args = parser.parse_args()
    cli(args)

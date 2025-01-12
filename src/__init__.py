import os
import sys
import subprocess
from pathlib import Path


class MyPopen(subprocess.Popen):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault("encoding", "utf-8")
        super().__init__(*args, **kwargs)


subprocess.Popen = MyPopen

import execjs

if getattr(sys, "frozen", False):
    inner_path = sys._MEIPASS
    application_path = os.path.dirname(sys.executable)
    # 指定 Node.js 可执行文件的具体路径
    runtime = execjs.ExternalRuntime(
        name="Node (custom)",
        command="",  # 替换为你的 Node.js 路径
        encoding="utf-8",
        runner_source=execjs._runner_sources.Node,
    )
    runtime._binary_cache = [(Path(inner_path) / "node.exe").absolute().as_posix()]
    runtime._available = True

    # 设置为默认运行时
    execjs.register("local_node", runtime)
elif __file__:
    inner_path = os.getcwd()
    application_path = inner_path

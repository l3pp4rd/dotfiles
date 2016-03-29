# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
#------------------------------------------------------------------------------

# You can import any python module as needed.
import subprocess
import os

class run_with(Command):
    """:run_with
    Runs a currently selected files with an application
    which is chosen from dmenu path. It uses historical
    index to top most the mostly used applications - works
    perfectly well !
    """

    context = 'browser'
    resolve_macros = False

    def execute(self):
        dmenu = '/usr/local/bin/dmenu_app'
        if os.path.isfile(dmenu):
            proc = subprocess.Popen([dmenu], stdout=subprocess.PIPE)
            app = proc.communicate()[0].rstrip().decode('utf-8')
            if len(app):
                self.fm.execute_file(
                    files = [f for f in self.fm.thistab.get_selection()],
                    app = app,
                    flags = '',
                    mode = 0)
        else:
            self.fm.notify('Could not locate dmenu run app script ' + dmenu, bad=True)

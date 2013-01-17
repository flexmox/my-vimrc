" Normal Mode Mappings
nmap <leader>ss  <Esc>ggVG:call CleanUp()<CR><Esc>:call NewSurvey()<CR>
nmap <leader>mo  <Esc>:call MakeOrs()<Esc>
nmap <leader>ju  <Esc>:call Justify()<CR>
nmap <leader>sr  <Esc>:call SwitchRating()<CR>
nmap <leader>dif <Esc>:call Vimdiff()<CR>
nmap <leader>no  <Esc>:call CleanNotes()<CR>
nmap <leader>hr  <Esc>:call HRef()<CR>
nmap <leader>mai <Esc>:call Mailto()<CR>
nmap <leader>ee  <Esc>i exclusive="1" randomize="0"<Esc>
nmap <leader>rr  <Esc>i randomize="0"<Esc>
nmap <leader>oe  <Esc>i open="1" openSize="25" randomize="0"<Esc>
nmap <leader>aa  <Esc>i aggregate="0" percentages="0"<Esc>
nmap <leader>oo  <Esc>i optional="1"<Esc>
nmap <leader>dev <Esc>i where="execute"<Esc>
nmap <leader>sh  <Esc>i shuffle="rows"<Esc>
nmap <leader>su  <Esc>o<suspend/><Esc>
nmap <leader>br  <Esc>i<br/><br/><Esc>
nmap <leader>mb  <Esc>i<br><br><Esc>
nmap <leader>nu  <Esc>:.,$s'\v(^\d+) '\1. 'gc<CR>
nmap <leader>le  <Esc>:.,$s'\v(^[A-Z]+) '\1. 'gc<CR>
nmap <leader>va  <Esc>:call Validate()<Esc>

" Visual Mode Mappings
vmap <leader>ro  <Esc>:call Rows()<CR>
vmap <leader>co  <Esc>:call Cols()<CR>
vmap <leader>ch  <Esc>:call Choice()<CR>
vmap <leader>ra  <Esc>:call Rates()<CR>
vmap <leader>mr  <Esc>:call MakeRadio()<CR>
vmap <leader>mc  <Esc>:call MakeCheckbox()<CR>
vmap <leader>ms  <Esc>:call MakeSelect()<CR>
vmap <leader>mn  <Esc>:call MakeNumber()<CR>
vmap <leader>mf  <Esc>:call MakeFloat()<CR>
vmap <leader>mt  <Esc>:call MakeText()<CR>
vmap <leader>ma  <Esc>:call MakeTextarea()<CR>
vmap <leader>mh  <Esc>:call MakeHTML()<CR>
vmap <leader>mv  <Esc>:call MakeRating()<CR>
vmap <leader>re  <Esc>:call Resource()<CR>
vmap <leader>mg  <Esc>:call MakeGroups()<CR>
vmap <leader>ne  <Esc>:call MakeNets()<CR>
vmap <leader>na  <Esc>:call NoAnswer()<CR>
vmap <leader>ca  <Esc>:call Case()<CR>
vmap <leader>avl <Esc>:call AddValuesLow()<CR>
vmap <leader>avh <Esc>:call AddValuesHigh()<CR>
vmap <leader>ag  <Esc>:call AddGroups()<CR>
vmap <leader>aa  <Esc>:call AddAlts()<CR>
vmap <leader>qc  <Esc>:call CommentQuestion()<CR>
vmap <leader>es  <Esc>:call Escape()<Esc>
vmap <leader>hc  <Esc>:call HTMLComment()<CR>
vmap <leader>me  <Esc>:call MakeExtras()<CR>
vmap <leader>qs  <Esc>:call SpaceQuote()<Esc>
vmap <leader>st  <Esc>:call Strip()<CR>
vmap <leader>sw  <Esc>:call Switcher()<CR>
vmap <leader>qu  <Esc>:call URLQuote()<Esc>
vmap <leader>cl  <Esc>:call CleanUp()<CR>


function! NewSurvey()
python << EOF
"""
Surround current buffer with v2 survey template
"""
try:
    import vim

    def NewSurvey(vbuffer):
        import re

        COMPAT = 113

        header = ['<?xml version="1.0" encoding="UTF-8"?>',
                  '<survey name="Survey"',
                  '    alt=""',
                  '    autosave="0"',
                  '    extraVariables="source,list,url,record,ipAddress,userAgent"',
                  '    compat="%d"' % COMPAT,
                  '    state="testing"',
                  '    newVirtual="1"',
                  '    setup="time,quota,term"',
                  '    ss:disableBackButton="1"',
                  '    unmacro="0"',
                  '    displayOnError="all"',
                  '    unique="">',
                  '',
                  '',
                  '<samplesources default="1">',
                  '  <samplesource list="1" title="default">',
                  '    <exit cond="qualified"><b>Thanks again for completing the survey!<br/><br/>Your feedback and quick response to this survey are greatly appreciated.</b></exit>',
                  '    <exit cond="terminated"><b>Thank you for your selection!</b></exit>',
                  '    <exit cond="overquota"><b>Thank you for your selection!</b></exit>',
                  '  </samplesource>',
                  '</samplesources>',
                  '',
                  '']

        footer = '<marker name="qualified"/>\n\n</survey>'.split('\n')
        return header + vbuffer + footer

    vim.current.buffer[:] = NewSurvey(vim.current.buffer[:])

except Exception, e:
    print e
EOF
set filetype=xml
endfunction


function! CleanUp()
'<,'>python << EOF
"""
Clean up visually selected text
Replaces UTF special chars to ASCII
Reduces and normalizes tabs and newlines
"""
try:
    import vim

    def CleanUp(vrange):
        import re

        selection = '\n'.join(vrange)

        selection = re.sub("\t+", " ", selection)
        selection = re.sub("\n\s+\n", "\n\n", selection)
        selection = re.sub("\n{2,}", "\n\n", selection)
        selection = re.sub("\r", "", selection)

        transTable = {'–': '-',
                      '”': '"',
                      '“': '"',
                      '‘': "'",
                      '’': "'",
                      '…': '...',
                      '&': '&amp;'}

        for k, v in transTable.items():
            selection = selection.replace(k, v)
        return [line.lstrip() for line in selection.split('\n')]

    vim.current.range[:] = CleanUp(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Rows()
'<,'>python << EOF
try:
    import vim

    def Rows(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        return decipher.cell_factory(vrange, "row", "r") + ['\n']

    vim.current.range[:] = Rows(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Cols()
'<,'>python << EOF
try:
    import vim

    def Cols(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher
        return decipher.cell_factory(vrange, "col", "c") + ['\n']

    vim.current.range[:] = Cols(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Choice()
'<,'>python << EOF
try:
    import vim

    def Choice(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher
        return decipher.cell_factory(vrange, "choice", "ch") + ['\n']

    vim.current.range[:] = Choice(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Rates()
'<,'>python << EOF
try:
    import vim

    def Rates(vrange):
        import os
        import sys
        import re
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        lines = [line for line in vrange if line.strip()]

        row_rgx = re.compile(r"^(?P<num>[a-zA-Z0-9-_]+)\.?\s+(?P<text>\w.*)")

        poleTemplate  =  "{num}. {text}<br/>{num}"
        innerTemplate =  "{num}. {num}"

        for i, line in enumerate(lines):
            if row_rgx.match(line):
                lines[i] = poleTemplate.format(**row_rgx.match(line).groupdict())
            else:
                num = re.match(r"(?P<num>\d+)\.?", line)
                lines[i] = innerTemplate.format(**num.groupdict())
        return decipher.cell_factory(lines, "col", "c")

    vim.current.range[:] = Rates(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Case()
'<,'>python << EOF
try:
    import vim

    def Case(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        cases = decipher.cell_factory(vrange, "case", "c", attrs={'cond': ''})

        cases.append("""  <case label="c99" cond="1">BAD PIPE</case>""")

        cases = ['<pipe label="" capture="">'] + cases + ['</pipe>']

        return cases

    vim.current.range[:] = Case(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], cursor[1] + 12

except Exception, e:
    print e
EOF
endfunction


function! NoAnswer()
'<,'>python << EOF
try:
    import vim

    def NoAnswer(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        return decipher.cell_factory(vrange, "noanswer", "r")

    vim.current.range[:] = NoAnswer(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Resource()
'<,'>python << EOF
try:
    import vim

    def Resource(vrange):
        import re

        resLabeled   = '<res label="{label}">{text}</res>'
        resUnLabeled = '<res label="">{text}</res>'

        label_rgx = re.compile('^(?P<label>\w*)\. (?P<text>.*)\s*$')

        lines = [line for line in vrange if line.strip()]

        output = []
        for line in lines:
            hasLabel = label_rgx.match(line)
            if hasLabel:
                output.append(resLabeled.format(**hasLabel.groupdict()))
            else:
                output.append(resUnLabeled.format(text=line))
        return output

    vim.current.range[:] = Resource(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], 11

except Exception, e:
    print e
EOF
endfunction


function! MakeRadio()
'<,'>python << EOF
try:
    import vim

    def MakeRadio(vrange):
        import re
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        questionText = '\n'.join(vrange)
        hasRow = questionText.find('<row') != -1
        hasCol = questionText.find('<col') != -1

        comment1D = "Please select one"
        comment2D = "Please select one for each row"

        if hasRow and hasCol:
            comment = comment2D
        else:
            comment = comment1D

        element = decipher.element_factory(vrange,
                                           elType="radio",
                                           comment=comment)
        decipher.openify(element)

        return element

    vim.current.range[:] = MakeRadio(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeCheckbox()
'<,'>python << EOF
try:
    import vim

    def MakeCheckbox(vrange):
        import os
        import sys
        import re
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        comment = "Please select all that apply"
        attrs = dict(atleast=1)
        element = decipher.element_factory(vrange,
                                           attrs=attrs,
                                           elType="checkbox",
                                           comment=comment)

        element = decipher.exclusify(element)
        element = decipher.openify(element)

        return element

    vim.current.range[:] = MakeCheckbox(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeSelect()
'<,'>python << EOF
try:
    import vim

    def MakeSelect(vrange):
        import re
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        questionText = '\n'.join(vrange)
        hasRow = questionText.find('<row') != -1
        hasCol = questionText.find('<col') != -1

        comment1D = "Please select one"
        comment2D = "Please select one for each selection"

        if hasRow or hasCol:
            comment = comment2D
        else:
            comment = comment1D

        attrs = dict(optional=0)

        return decipher.element_factory(vrange,
                                        attrs=attrs,
                                        elType="select",
                                        comment=comment)

    vim.current.range[:] = MakeSelect(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeNumber()
'<,'>python << EOF
try:
    import vim

    def MakeNumber(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        attrs = dict(size=3, optional=0)
        comment = "Please enter a whole number"

        return decipher.element_factory(vrange,
                                        elType="number",
                                        attrs=attrs,
                                        comment=comment)

    vim.current.range[:] = MakeNumber(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeFloat()
'<,'>python << EOF
try:
    import vim

    def MakeFloat(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        attrs = dict(size=3, optional=0)
        comment = "Please enter a number"

        return decipher.element_factory(vrange,
                                        elType="float",
                                        attrs=attrs,
                                        comment=comment)

    vim.current.range[:] = MakeFloat(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeText()
'<,'>python << EOF
try:
    import vim

    def MakeText(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        attrs = dict(optional=0)
        comment = "Please be as specific as possible"

        return decipher.element_factory(vrange,
                                        elType="text",
                                        attrs=attrs,
                                        comment=comment)

    vim.current.range[:] = MakeText(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeTextarea()
'<,'>python << EOF
try:
    import vim

    def MakeTextarea(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        comment = "Please be as specific as possible"
        attrs = dict(optional=0)

        return decipher.element_factory(vrange,
                                        attrs=attrs,
                                        elType="textarea",
                                        comment=comment)

    vim.current.range[:] = MakeTextarea(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeHTML()
'<,'>python << EOF
try:
    import vim

    def MakeHTML(vrange):
        INDENT = 4
        lines = '\n'.join(' ' * INDENT + line for line in vrange if line.strip())

        htmlTemplate = ('<html label="" where="survey">',
                        '  <p>',
                        '%s',
                        '  </p>',
                        '</html>')
        htmlTemplate = '\n'.join(htmlTemplate)

        return (htmlTemplate % lines).split('\n')

    vim.current.range[:] = MakeHTML(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], 13

except Exception, e:
    print e
EOF
endfunction


function! MakeRating()
'<,'>python << EOF
try:
    import vim

    def MakeRating(vrange):
        import re
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        questionText = '\n'.join(vrange)
        hasRow = questionText.find('<row') != -1
        hasCol = questionText.find('<col') != -1

        comment1D = "Please select one"
        comment2D = "Please select one for each row"

        if hasRow and hasCol:
            comment = comment2D
        else:
            comment = comment1D

        attrs = dict(type="rating", values="order", averages="cols", adim="rows")

        return decipher.element_factory(vrange,
                                        attrs=attrs,
                                        elType="radio",
                                        comment=comment)

    vim.current.range[:] = MakeRating(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], len(vim.current.range[0]) - 1

except Exception, e:
    print e
EOF
endfunction


function! MakeNets()
'<,'>python << EOF
try:
    import vim

    def MakeNets(vrange):
        return ['  <net labels="">%s</net>' % res.strip() for res in vrange if res.strip()]

    vim.current.range[:] = MakeNets(vim.current.range[:])

    cursor = vim.current.window.cursor
    vim.current.window.cursor = cursor[0], 12

except Exception, e:
    print e
EOF
endfunction


function! MakeGroups()
'<,'>python << EOF
try:
    import vim

    def MakeGroups(vrange):
        import os
        import sys
        pluginPath = os.path.join(os.environ['HOME'], '.vim', 'plugin')
        sys.path.append(pluginPath)
        import decipher

        return decipher.cell_factory(vrange, "group", "g")

    vim.current.range[:] = MakeGroups(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! MakeExtras()
'<,'>python << EOF
try:
    """
    Pulls textNode into cs:extra attribute
    Also spaces the attribute to take up
    the same width as the longest node

    input:   <row label="r1">foo</row>
    output:  <row label="r1" cs:extra="foo">foo</row>
    """
    import vim

    def MakeExtras(vrange):
        import re

        textNode_rgx = re.compile('>(.*?)<')

        selection = vrange

        textNodes = [textNode_rgx.findall(line)[0] for line in selection]
        maxWidth = max(len(text) for text in textNodes) + 1
        attrTemplate = '{0:<%d}>' % maxWidth

        newSelection = []
        for row, node in zip(selection, textNodes):
            csExtra = ' cs:extra="' + attrTemplate.format(node + '"')
            newRow = row.replace('>', csExtra, 1)
            newSelection.append(newRow)

        return newSelection

    vim.current.range[:] = MakeExtras(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! MakeOrs()
python << EOF
try:
    import vim

    def MakeOrs(line, label, indices, element, joinType):
        import re
        from string import uppercase, lowercase

        assert indices.find('--') == -1, "Cannot have multiple dashes in range"
        firstChar = indices[0]
        elements  = re.sub('[-,]', '', indices)
        indices   = [e.strip() for e in indices.split(',')]
        joinType  = ' %s ' % joinType

        cond_rgx = re.compile('cond=".*?"')

        syntaxError = "Unknown input. Ranges should numeric 1-10, or alpha A-F, but not both"
        rangeError = "Range is backwards: %s-%s"

        res = []

        if firstChar.isdigit():
            if not elements.isdigit():
                raise Exception(syntaxError)

            for i in indices:
                if '-' in i:
                    start, end = map(int, i.split('-'))
                    if start > end:
                        raise Exception("Range is backwards: %d-%d" % (start, end))
                    rng = list(range(start, end + 1))
                    res.extend(map(str, rng))
                else:
                    res.append(i)

        if firstChar.isalpha():
            if not (elements.islower() or elements.isupper()):
                raise Exception("Cannot mix case. All letters must be upper or lower")

            for c in indices:
                case = uppercase if firstChar.isupper() else lowercase

                if '-' in c:
                    start, end = c.split('-')
                    if len(start) > len(end):
                        raise Exception(rangeError % (start, end))
                    for c in (start, end):
                        if c.count(c[0]) != len(c):
                            raise Exception("Labels must be uniform: AA BB CC, not AC")
                    startIndex = case.index(start[0])
                    if len(start) == len(end):
                        endIndex = case.index(end[0])
                        if endIndex < startIndex:
                            raise Exception(rangeError % (start, end))
                    multiplier = len(start)
                    rng = [start]
                    while start != end:
                        i = (startIndex + 1) % len(case)
                        if i < startIndex:
                            multiplier += 1
                        startIndex = i
                        start = case[startIndex] * multiplier
                        rng.append(start)
                    res.extend(rng)
                else:
                    res.append(c)

        formatDict = {'label': label,
                      'element': element,
                      'joinType': joinType}

        condString = joinType.join(["%(label)s.%(element)s" % formatDict + c for c in res])

        if cond_rgx.findall(line):
            return cond_rgx.sub('cond="{0}"'.format(condString), line)

        return condString


    def python_input(message):
        vim.command('call inputsave()')
        vim.command("let user_input = input('" + message + ": ')")
        vim.command('call inputrestore()')
        return vim.eval('user_input')

    label     = python_input("Label?")
    indices   = python_input("Indices?")
    element   = python_input("Cell Type?")
    joinType  = python_input("Join type? [or]") or 'or'

    vim.current.line = MakeOrs(vim.current.line, label, indices, element, joinType)

except Exception, e:
    print e
EOF
endfunction


function! AddValuesLow()
'<,'>python << EOF
try:
    import vim

    def AddValuesLow(vrange):

        for i, line in enumerate(vrange):
            vrange[i] = line.replace('">', '" value="%d">' % (i + 1))

        return vrange

    vim.current.range[:] = AddValuesLow(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! AddValuesHigh()
'<,'>python << EOF
try:
    import vim

    def AddValuesHigh(vrange):

        numElements = len(vrange)

        for i, line in enumerate(vrange):
            vrange[i] = line.replace('">', '" value="%d">' % (numElements - i))

        return vrange

    vim.current.range[:] = AddValuesHigh(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Switcher()
'<,'>python << EOF
try:
    import vim

    def Switcher(vrange):
        import re

        for i in range(len(vrange)):
            if "<row" in vrange[i]:
                this1 = "row"
                that1 = "col"
                this2 = "r"
                that2 = "c"
            elif "<col" in vrange[i]:
                this1 = "col"
                that1 = "row"
                this2 = "c"
                that2 = "r"
            vrange[i] = re.sub("(<|\/)" + this1, r'\1' + that1, vrange[i])
            vrange[i] = re.sub('label="%s' % this2, 'label="%s' % that2, vrange[i])
        return vrange

    vim.current.range[:] = Switcher(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! SwitchRating()
python << EOF
try:
    import vim

    def SwitchRating(vline):
        import re

        namesToSwitch  = ('averages', 'adim')
        valuesToSwitch = ('cols', 'rows')

        combos = []
        for attr in namesToSwitch:
            pair = []
            for val in valuesToSwitch:
                pair.append('{0}="{1}"'.format(attr, val))
            combos.append(pair)

        for combo in combos:
            for i, attr in enumerate(combo):
                if vline.find(attr) != -1:
                    vline = vline.replace(attr, combo[i ^ 1])
                    break

        return vline

    vim.current.line = SwitchRating(vim.current.line)

except Exception, e:
    print e
EOF
endfunction


function! AddGroups()
'<,'>python << EOF
try:
    import vim

    def AddGroups(vrange):
        for i, line in enumerate(vrange):
            vrange[i] = line.replace(">", ' groups="g1">', 1)

        return vrange

    vim.current.range[:] = AddGroups(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! CommentQuestion()
'<,'>python << EOF
try:
    import vim

    def CommentQuestion(vrange):
        INDENT = 2
        INDENT = ' ' * INDENT

        if len(vrange) == 1:
            template = INDENT + "<comment>%s</comment>"
            selection = '\n'.join([line.strip() for line in vrange if line.strip()])
        else:
            template = INDENT + "<comment>\n%s\n" + INDENT + "</comment>"
            selection = '\n'.join([(INDENT * 2) + line.strip() for line in vrange if line.strip()])

        return (template % selection).split('\n')

    vim.current.range[:] = CommentQuestion(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! HTMLComment()
'<,'>python << EOF
try:
    import vim

    def HTMLComment(vrange):
        return ['<!--'] + vrange + ['-->']

    vim.current.range[:] = HTMLComment(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! AddAlts()
'<,'>python << EOF
"""
Inserts an <alt> for Cells and Element's <title>
"""
try:
    import vim

    def AddAlts(vrange):
        import re

        ELEMENTS = ('row', 'col', 'choice', 'group')

        selection = '\n'.join(vrange)

        rgxTemplate = "(?P<open><({elements}).*?>)(?P<text>.*?)(?P<close></({elements})\s*?>)"
        cell_rgx  = re.compile(rgxTemplate.format(elements='|'.join(ELEMENTS)), re.DOTALL)
        title_rgx = re.compile(rgxTemplate.format(elements='title'), re.DOTALL)

        cellSub  = "\g<open><alt>\g<text></alt>\g<text>\g<close>"
        titleSub = "\g<open>\g<text>\g<close>\n  <alt>\g<text></alt>"

        selection = cell_rgx.sub(cellSub, selection)
        selection = title_rgx.sub(titleSub, selection)

        return selection.split('\n')

    vim.current.range[:] = AddAlts(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Validate()
python << EOF
try:
    import vim
    """
    Remove macro lines @foo bar=baz
    Validate xml
    Search for optional without <validate/>
    """
    raise NotImplementedError("XXX TODO external validate module")

except Exception, e:
    print e
EOF
endfunction


function! Escape()
'<,'>python << EOF
try:
    import vim

    vim.current.range[:] = [line.replace('<', '&lt;').replace('>', '&gt;') for line in vim.current.range[:]]

except Exception, e:
    print e
EOF
endfunction


function! URLQuote()
'<,'>python << EOF
try:
    import vim
    from urllib import quote

    vim.current.range[:] = [quote(line) for line in vim.current.range[:]]

except Exception, e:
    print e
EOF
endfunction


function! SpaceQuote()
'<,'>python << EOF
try:
    import vim

    vim.current.range[:] = [line.replace(' ', '&#32;') for line in vim.current.range[:]]

except Exception, e:
    print e
EOF
endfunction


function! Mailto()
python << EOF
try:
    import vim

    vim.current.line = '<a href="mailto:{email}">{email}</a>'.format(email=vim.current.line)

except Exception, e:
    print e
EOF
endfunction


function! HRef()
python << EOF
try:
    import vim

    currentLine = vim.current.line

    vim.current.line = '<a href="{line}">{line}</a>'.format(line=currentLine)

except Exception, e:
    print e
EOF
endfunction


function! Strip()
'<,'>python << EOF
try:
    import vim

    def Strip(vrange):
        import re

        ELEMENTS = ('row', 'col', 'choice', 'group')

        text_rgx = re.compile('\s*<({elements}).*?>(?P<text>.*?)</({elements}).*'.format(elements='|'.join(ELEMENTS)))

        output = []

        for line in vrange:
            match = text_rgx.match(line)
            if match:
                output.append(match.groupdict()['text'])

        return output

    vim.current.range[:] = Strip(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! Justify()
python << EOF
"""
Justify some long text to MAX_LINE_LENGTH
Preserves indentation
"""
try:
    import vim

    def Justify(vrange):
        selection = ''.join(vrange)

        MAX_LINE_LENGTH = 79

        indent = len(selection) - len(selection.lstrip())
        words  = [word for word in selection.split(' ') if word]

        lines = []

        lineLength = 0
        curLine = []
        wordCount = len(words)
        for i, word in enumerate(words):
            curLine.append(word)
            lineLength += len(word)
            if lineLength > MAX_LINE_LENGTH or (i == wordCount - 1):
                lines.append(' ' * indent + ' '.join(curLine))
                curLine, lineLength = [], 0
        return lines

    vim.current.range[:] = Justify(vim.current.range[:])

except Exception, e:
    print e
EOF
endfunction


function! CleanNotes()
python << EOF
"""
This is used for cleaning up Notes created by tasklist.vim
e.g. <!-- XXX [foo]: bar -->
"""
try:
    import vim

    def CleanNotes(vbuffer):
        import re

        comment_rgx = re.compile(r'.*XXX \[(?P<label>[^\]]+)\]: (?P<note>.*)\s*-->')

        template = '[{label}]: {note}'

        output = []
        for line in vbuffer:
            match = comment_rgx.match(line)
            if match:
                output.append(template.format(**match.groupdict()))

        return output

    vim.current.buffer[:] = CleanNotes(vim.current.buffer[:])

except Exception, e:
    print e
EOF
endfunction


function! Vimdiff()
python << EOF
"""
Split buffer by blank lines and open in vimdiff
"""
try:
    import vim
    import tempfile
    from subprocess import Popen, PIPE

    PROGRAM = 'gvimdiff'

    vbuffer = '\n'.join(vim.current.buffer[:])

    parts = vbuffer.split('\n\n')

    files = []

    for part in parts:
        tmp = tempfile.NamedTemporaryFile()
        tmp.write(part)
        tmp.flush()
        files.append(tmp)

    cmd = [PROGRAM] + [f.name for f in files]

    Popen(cmd, stdout=PIPE).wait()

except Exception, e:
    print e
EOF
endfunction

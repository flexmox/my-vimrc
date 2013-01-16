########################################
Custom vimrc and decipher-clip plugin
########################################


Installation
============
After cloning you can run install.sh to create .vim and .vimrc sym links
to ``~/.vimrc`` and ``~/.vim``.

To retrieve necessary submodules you can either use the helper
script ``submodules-reload.sh`` or use git manually

Checkout vim/snippets/xml.snippets for useful autocompletes
that can be executed by typing the snippet name and pressing tab


Cheat Sheet
===========

Normal Mode
    Clean up unicode, newlines, tabs and place the current buffer in a new-survey template

    .. code-block::

        ,ss

    Create boolean logic you can trust **Make Ors**

    .. code-block::

        ,mo

        Label?: Q1
        Indices?: 1-3,5,8
        Element Type? [r]: r
        Join type? [or]: or

        returns: Q1.r1 or Q1.r2 or Q1.r3 or Q1.r5 or Q1.r8

    Justify the current line to prevent horizontal scrolling

    .. code-block::

        ,ju

    Switch adim and averages between cols and rows **Switch Rating**

    .. code-block::

        ,sr

    Open the current buffer into parts *delimited by blank lines* in gvimdiff

    .. code-block::

        ,dif

    To clean ``<!-- XXX [foo]: bar -->`` notes made by snipmate for sending to QA

    .. code-block::

        ,no

    Turn the current line into a hyperlink

    .. code-block::

        ,hr

    Turn the current line into a mailto: hyperlink

    .. code-block::

        ,mai

    Insert ``exclusive="1" randomize="0"``

    .. code-block::

        ,ee

    Insert ``randomize="0"``

    .. code-block::

        ,rr

    Insert ``open="1" openSize="25" randomize="0"``

    .. code-block::

        ,oe

    Insert ``aggregate="0" percentages="0"``

    .. code-block::

        ,aa

    Insert ``optional="1"``

    .. code-block::

        ,oo

    Insert ``where="execute"``

    .. code-block::

        ,dev

    Insert ``shuffle="rows"``

    .. code-block::

        ,sh

    Insert ``<suspend/>`` below current line

    .. code-block::

        ,su

    Insert ``<br/><br/>``

    .. code-block::

        ,br

    Insert ``<br><br>`` **Mail Break**

    .. code-block::

        ,mb


Visual Mode
    Make row Cells

    .. code-block::

        ,ro

    Make col Cells

    .. code-block::

        ,co

    Make choice Cells

    .. code-block::

        ,ch

    Make rating row cells with poles. e.g. ``Disagree</br>1,2,3,4,Agree<br/>5``

    .. code-block::

        ,ra

    Make radio Element

    .. code-block::

        ,mr

    Make checkbox Element

    .. code-block::

        ,mc

    Make select Element

    .. code-block::

        ,ms

    Make number Element

    .. code-block::

        ,mn

    Make float Element

    .. code-block::

        ,mf

    Make text Element

    .. code-block::

        ,mt

    Make textarea Element

    .. code-block::

        ,ma

    Make html Element

    .. code-block::

        ,mh

    Make radio-rating Element **Make Values**

    .. code-block::

        ,mv

    Make res Elements

    .. code-block::

        ,re

    Make group Cells

    .. code-block::

        ,mg

    Make net Cells

    .. code-block::

        ,ne

    Make noanswer Cells

    .. code-block::

        ,na

    Make pipe by creating cases out of selected lines

    .. code-block::

        ,ca

    Add values to Cells from low to high

    .. code-block::

        ,avl

    Add values to Cells from high to low

    .. code-block::

        ,avh

    Add groups to Cells

    .. code-block::

        ,ag

    Add alts to Cells and title

    .. code-block::

        ,aa

    Create a question comment

    .. code-block::

        ,qc

    Escape ``< and >``

    .. code-block::

        ,es

    Comment out some text **HTML Comment**

    .. code-block::

        ,hc

    Pull text node into configurable style **Make Extras**

    .. code-block::

        ,me

    HTML escape spaces **Quote Spaces**

    .. code-block::

        ,qs

    Strip text-nodes from selected Cells

    .. code-block::

        ,st

    Switch selected Cells between cols and rows

    .. code-block::

        ,sw

    URL escape selection **Quote URL**

    .. code-block::

        ,qu

    Clean out common utf-8 chars and remove excessive tabs, newlines, etc

    .. code-block::

        ,cl

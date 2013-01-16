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
    To clean ``<!-- XXX [foo]: bar -->`` notes made by snipmate for sending to QA

    .. code-block::

        ,no

    Make the current line into a hyperlink

    .. code-block::

        ,hr

    Justify the current line to prevent horizontal scrolling

    .. code-block::

        ,ju

    Turn the current line into a mailto: hyperlink

    .. code-block::

        ,mai

    Create boolean logic you can trust **Make Ors**

    .. code-block::

        ,mo

    Switch adim and averages between cols and rows **Switch Rating**

    .. code-block::

        ,sr

    Open the current buffer into parts *delimited by blank lines* in gvimdiff

    .. code-block::

        ,dif

Visual Mode
    Add alts to Cells and title

    .. code-block::

        ,aa

    Add groups to Cells

    .. code-block::

        ,ag

    Add values to Cells from high to low

    .. code-block::

        ,avh

    Add values to Cells from low to high

    .. code-block::

        ,avl

    Create cases surrounded by a ``pipe`` Element

    .. code-block::

        ,ca

    Make choice Cells

    .. code-block::

        ,ch

    Clean out common utf-8 chars and remove excessive tabs, newlines, etc

    .. code-block::

        ,cl

    Make col Cells

    .. code-block::

        ,co

    Create a question comment

    .. code-block::

        ,qc

    Escape ``< and >``

    .. code-block::

        ,es

    Comment out some text **HTML Comment**

    .. code-block::

        ,hc

    Make checkbox Element

    .. code-block::

        ,mc

    Pull text node into configurable style **Make Extras**

    .. code-block::

        ,me

    Make float Element

    .. code-block::

        ,mf

    Make group Cells

    .. code-block::

        ,mg

    Make html Element

    .. code-block::

        ,mh

    Make net Cells

    .. code-block::

        ,ne

    Make number Element

    .. code-block::

        ,mn

    Make radio Element

    .. code-block::

        ,mr

    Make radio-rating Element **Make Values**

    .. code-block::

        ,mv

    Make select Element

    .. code-block::

        ,ms

    Make text Element

    .. code-block::

        ,mt

    Make textarea Element

    .. code-block::

        ,ma

    Make noanswer Cells

    .. code-block::

        ,na

    Make rating scale with poles. e.g. ``Disagree</br>1,2,3,4,Agree<br/>5``

    .. code-block::

        ,ra

    Make res Elements

    .. code-block::

        ,re

    Make row Cells

    .. code-block::

        ,ro

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

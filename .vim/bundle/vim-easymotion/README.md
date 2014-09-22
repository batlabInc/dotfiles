Vim motion on speed! [![Build Status](https://travis-ci.org/Lokaltog/vim-easymotion.png?branch=master)](https://travis-ci.org/Lokaltog/vim-easymotion)
=====

![Animated demonstration](https://f.cloud.github.com/assets/3797062/2039359/a8e938d6-899f-11e3-8789-60025ea83656.gif)

About the authors
=====

- Kim Silkebækken (https://github.com/Lokaltog)
- haya14busa (https://github.com/haya14busa) (since version 2.0)

The EasyMotion project, revived!
======

Starting from version 2.0 [haya14busa](https://github.com/haya14busa) will be
taking over the project from [Lokaltog](https://github.com/Lokaltog). He's
improved the default motions, implemented many useful new features, and fixed
some bugs.

EasyMotion is now completely

- **Well-behaved**: It's consistent with the default motions of Vim and works
  well in all modes. And it now supports repeating with the dot operator.
- **Configurable**. You can easily configure its behavior and map it to any key
  you want.

Even though some default behaviors were modified and many new features were
added, I carefully considered backward compatibility. So those of you updating
from older versions can do so without worry and start benefitting immediately
from all the new features!

Introduction
=====

EasyMotion provides a much simpler way to use some motions in vim. It
takes the `<number>` out of `<number>w` or `<number>f{char}` by
highlighting all possible choices and allowing you to press one key to
jump directly to the target.

When one of the available motions is triggered, all visible text
preceding or following the cursor is faded, and motion targets are
highlighted.

EasyMotion is triggered by the provided mappings. This readme only covers the
basics; please refer to
[`:help easymotion.txt`](https://github.com/Lokaltog/vim-easymotion/blob/master/doc/easymotion.txt#L86)
to see all of the available mappings.

Important notes
=====

### Default bindings

**The default leader has been changed to `<Leader><Leader>` to avoid
conflicts with other plugins you may have installed.** This can easily be
changed back to pre-1.3 behavior by rebinding the leader in your vimrc:

```vim
map <Leader> <Plug>(easymotion-prefix)
```

All motions will then be triggered with `<Leader>` by default, e.g.
`<Leader>s`, `<Leader>gE`.

### For users of the forked version

SelectLines and SelectPhrase are not actually *motions*, so I've moved them into
separate plugins.

- https://github.com/haya14busa/vim-easyoperator-line
- https://github.com/haya14busa/vim-easyoperator-phrase

Usage example for the base features
=====

	<cursor>Lorem ipsum dolor sit amet.

Type `<Leader><Leader>w`(`<Plug>(easymotion-w)`) to trigger the word motion `w`.
When the motion is triggered, the text is updated (no braces are actually added,
the text is highlighted in red by default):

	<cursor>Lorem {a}psum {b}olor {c}it {d}met.

Press `c` to jump to the beginning of the word "sit":

	Lorem ipsum dolor <cursor>sit amet.

Similarly, if you're looking for an "o", you can use the `f` motion.
Type `<Leader><Leader>fo`, and all "o" characters are highlighted:

	<cursor>L{a}rem ipsum d{b}l{c}r sit amet.

Press `b` to jump to the second "o":

	Lorem ipsum d<cursor>olor sit amet.

Jeffrey Way of Nettuts+ has also [written
a tutorial](http://net.tutsplus.com/tutorials/other/vim-essential-plugin-easymotion/)
about EasyMotion.


New features in version 2.0
====

### Two key highlighting

When EasyMotion runs out of single characters to highlight movement targets, it
now shows you immediately the keys you have to press.

In previous versions you could not see the next character you would needed to
press until you entered the first one. This made movement over long distances
less fluid. Now you can see at a glance exactly which characters to select to
get to your destination.

### Bidirectional motions

All motions now come in a bidirectional variants (e.g. `<Plug>(easymotion-s)`,
`<Plug>(easymotion-bd-w)` and so forth).
By default you can already jump forward or backward with `<Leader>s`. A useful
trick is to map `nmap s <Plug>(easymotion-s)` to use `s` instead and save one
keystroke!

### 2-character search motion

You can now also perform a 2-character search, similar to [vim-seek](https://github.com/goldfeld/vim-seek)/[vim-sneak](https://github.com/justinmk/vim-sneak) with `<Plug>(easymotion-s2)`. For example you can highlight all words that start with `fu`.

![2-key-find-motion](https://f.cloud.github.com/assets/3797062/2039612/7cafcec8-89a5-11e3-8f2c-5f26a6b83efd.gif)

```vim
" Gif config
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
```

### n-character search motion

You can also search for `n` characters, which basically can be used to replace the default search of Vim.
It suports incremental highlighting and you can use `<Tab>` and `<S-Tab>` to scroll down/up a page. If you press
`<CR>` you get the usual EasyMotion highlighting and can jump to any matching target destination with a
single keystroke.

What sounds complicated should become clear if you look at the following examples.

![n-key-motion-scroll](https://f.cloud.github.com/assets/3797062/2039254/4fbf7276-899e-11e3-9bf3-1e446cabc097.gif)

![replace-search](https://f.cloud.github.com/assets/3797062/2039751/64b72bd8-89a8-11e3-80ea-2a6b578040b2.gif)

```vim
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
```

### Within line motion

Every motion also has variants that are restricted to just the current line
(e.g. `<Plug>(easymotion-sl)`, `<Plug>(easymotion-bd-wl)`, etc...). This can be
helpful if you find the full search distracting or slows down vim.

### hjkl motions

EasyMotion can be configured to avoid repetitive use of the `h` `j` `k` and
`l` keys.

![hjkl-motion](https://f.cloud.github.com/assets/3797062/2039413/d8b32ab2-89a0-11e3-894f-3e81db084cfd.gif)

```vim
" Gif config
map <Leader>h <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
```

### Smartcase & Smartsign

This setting makes EasyMotion work similarly to Vim's `smartcase` option for
global searches.

```vim
let g:EasyMotion_smartcase = 1
```

With this option set, `v` will match both `v` and `V`, but `V` will match `V`
only. Default: 0.

```vim
let g:EasyMotion_use_smartsign_us = 1 " US layout
" or
let g:EasyMotion_use_smartsign_jp = 1 " JP layout
```

This applies the same concept, but for symbols and numerals. `1` will match `1`
and `!`; `!` matches `!` only. Default: 0.


### Migemo feature (for Japanese user)

```vim
let g:EasyMotion_use_migemo = 1
```


Easymotion can match multibyte Japanese characters with alphabetical input.
For example, `<Leader><Leader>sa` can search 'あ'.
This feature doesn't require cmigemo because Easymotion includes regex
patterns generated by cmigemo. However installing `cmigemo` will make
2-character and n-character search motions to also support the migemo feature.
Default:0


### Repeat motions

#### Repeat the last motion

`<Plug>(easymotion-repeat)`

#### Repeat the last find motion

In a find motion (e.g. `<Plug>(easymotion-s)`), type `<CR>` without
input characters to find the last motion again.

#### Jump to next/previous match (even on next/previous page)

* `<Plug>(easymotion-next)`
* `<Plug>(easymotion-prev)`

#### Support for dot repeat

This requires https://github.com/tpope/vim-repeat.

You can use EasyMotion with operators and press `.` to repeat!
It is well-behaved, and consistent with the default behavior of Vim.

![repeat-motion](https://f.cloud.github.com/assets/3797062/2039538/0aef66aa-89a4-11e3-8242-c27a5208cfca.gif)

```vim
" Gif config

" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `s{char}{target}`
" `s<CR>` repeat last find motion.
nmap s <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1
```

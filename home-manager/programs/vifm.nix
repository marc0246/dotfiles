{ inputs, outputs, config, lib, pkgs, ... }: {
  programs.vifm = {
    enable = true;
    extraConfig = with outputs.lib.palette; ''
      set vicmd=hx
      set syscalls
      set trash
      set vifminfo=dhistory,savedirs,chistory,state,tui,shistory,phistory,fhistory,dirstack,
        \registers,bookmarks,bmarks
      set history=100
      set nofollowlinks
      set sortnumbers
      set undolevels=100
      set vimhelp
      set norunexec
      set timefmt='%Y-%m-%d %H:%M'
      set wildmenu
      set wildstyle=popup
      set suggestoptions=normal,visual,view,otherpane,keys,marks,registers
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      set scrolloff=5
      if !has('win')
        set slowfs=curlftpfs
      endif
      set statusline="  %=%A %10u:%-7g %15s %20d  "

      nnoremap x :!cargo run --bin %c<cr>

      highlight Win             cterm=none              ctermfg=lightwhite ctermbg=default
      highlight Directory       cterm=bold              ctermfg=blue       ctermbg=default
      highlight Link            cterm=bold              ctermfg=cyan       ctermbg=default
      highlight BrokenLink      cterm=bold              ctermfg=red        ctermbg=default
      highlight HardLink        cterm=bold              ctermfg=cyan       ctermbg=default
      highlight Socket          cterm=bold              ctermfg=magenta    ctermbg=default
      highlight Device          cterm=bold              ctermfg=yellow     ctermbg=default
      highlight Fifo            cterm=bold              ctermfg=yellow     ctermbg=default
      highlight Executable      cterm=bold              ctermfg=green      ctermbg=default
      highlight Selected        cterm=bold              ctermfg=default    ctermbg=black
      highlight CurrLine        cterm=bold,reverse      ctermfg=default    ctermbg=default
      highlight TopLine         cterm=none              ctermfg=green      ctermbg=default
      highlight TopLineSel      cterm=bold              ctermfg=green      ctermbg=default
      highlight StatusLine      cterm=bold              ctermfg=lightblack ctermbg=default
      highlight WildMenu        cterm=underline,reverse ctermfg=white      ctermbg=default
      highlight CmdLine         cterm=none              ctermfg=white      ctermbg=default
      highlight ErrorMsg        cterm=none              ctermfg=red        ctermbg=default
      highlight Border          cterm=none              ctermfg=default    ctermbg=default
      highlight JobLine         cterm=bold,reverse      ctermfg=default    ctermbg=white

      filextype {*.pdf},<application/pdf>
        \ {Open in Firefox}
        \ firefox %f,

      filextype {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus,*.aac,*.mpga},
        \<audio/*>
        \ {Play using ffplay}
        \ ffplay -nodisp -hide_banner -autoexit %c,
      fileviewer {*.wav,*.mp3,*.flac,*.m4a,*.wma,*.ape,*.ac3,*.og[agx],*.spx,*.opus,*.aac,*.mpga},
        \<audio/*>
        \ ffprobe -hide_banner -pretty %c 2>&1

      filextype {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,*.fl[icv],*.m2v,
        \*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,*.as[fx],*.unknown_video},<video/*>
        \ {Play using mpv}
        \ mpv --no-video %f,
      fileviewer {*.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,*.fl[icv],*.m2v,
        \*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,*.as[fx],*.unknown_video},<video/*>
        \ ffprobe -hide_banner -pretty %c 2>&1

      filextype {*.xhtml,*.html,*.htm},<text/html>
        \ {Open in Firefox}
        \ firefox %f,

      filextype {*.svg,*.svgz},<image/svg+xml>
        \ {Open in Inkscape}
        \ inkscape %f,

      filextype {*.xcf}
        \ {Open in GIMP}
        \ gimp %f,

      filextype {.blend}
        \ {Open in Blender}
        \ blender %c,

      filextype {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
        \ {Open in Firefox}
        \ firefox %f,
      fileviewer {*.bmp,*.jpg,*.jpeg,*.png,*.gif,*.xpm},<image/*>
        \ identify %c

      filextype {*.torrent},<application/x-bittorrent>
        \ {Open in qBittorrent}
        \ qbittorrent %f,

      filetype {*.zip,*.jar,*.war,*.ear,*.oxt,*.apkg},
        \<application/zip,application/java-archive>
        \ {Mount with fuse-zip}
        \ FUSE_MOUNT|fuse-zip %SOURCE_FILE %DESTINATION_DIR,
        \ {View contents}
        \ unzip -l %f | less,
        \ {Extract here}
        \ unzip %c,
      fileviewer {*.zip,*.jar,*.war,*.ear,*.oxt}
        \ unzip -l %c

      filetype {*.tar,*.tar.bz2,*.tbz2,*.tgz,*.tar.gz,*.tar.xz,*.txz,*.tar.zst,*.tzst},
        \<application/x-tar>
        \ {Mount with archivemount}
        \ FUSE_MOUNT|archivemount %SOURCE_FILE %DESTINATION_DIR,
      fileviewer {*.tgz,*.tar.gz}
        \ tar -tzf %c
      fileviewer {*.tar.bz2,*.tbz2}
        \ tar -tjf %c
      fileviewer {*.tar.xz,*.txz}
        \ tar -tJf %c
      fileviewer {*.tar.zst,*.tzst}
        \ tar -t --zstd -f %c
      fileviewer {*.tar},<application/x-tar>
        \ tar -tf %c

      filetype {*.rar},<application/x-rar>
        \ {Mount with rar2fs}
        \ FUSE_MOUNT|rar2fs %SOURCE_FILE %DESTINATION_DIR,
      fileviewer {*.rar},<application/x-rar>
        \ unrar v %c

      filetype {*.iso},<application/x-iso9660-image>
        \ {Mount with fuseiso}
        \ FUSE_MOUNT|fuseiso %SOURCE_FILE %DESTINATION_DIR,

      filetype {*.7z},<application/x-7z-compressed>
        \ {Mount with fuse-7z}
        \ FUSE_MOUNT|fuse-7z %SOURCE_FILE %DESTINATION_DIR,
      fileviewer {*.7z},<application/x-7z-compressed>
        \ 7z l %c

      filextype {*.odt,*.doc,*.docx,*.xls,*.xlsx,*.odp,*.pptx,*.ppt},
        \<application/vnd.openxmlformats-officedocument.*,application/msword,
        \application/vnd.ms-excel>
        \ libreoffice %f &

      set classify=' :dir:/, :exe:, :reg:, :link:,? :?:, ::../::'

      set classify+=' ::.Xdefaults,,.Xresources,,.bashprofile,,.bash_profile,,.bashrc,,.dmrc,,
        \.d_store,,.fasd,,.gitconfig,,.gitignore,,.jack-settings,,.mime.types,,.nvidia-settings-rc,,
        \.pam_environment,,.profile,,.recently-used,,.selected_editor,,.xinitpurc,,.zprofile,,
        \.yarnc,,.snclirc,,.tmux.conf,,.urlview,,.config,,.ini,,.user-dirs.dirs,,.mimeapps.list,,
        \.offlineimaprc,,.msmtprc,,.Xauthority,,config::'
      set classify+=' ::dropbox::'
      set classify+=' ::favicon.*,,README,,readme::'
      set classify+=' ::.vim,,.vimrc,,.gvimrc,,.vifm::'
      set classify+=' ::gruntfile.coffee,,gruntfile.js,,gruntfile.ls::'
      set classify+=' ::gulpfile.coffee,,gulpfile.js,,gulpfile.ls::'
      set classify+=' ::ledger::'
      set classify+=' ::license,,copyright,,copying,,LICENSE,,COPYRIGHT,,COPYING::'
      set classify+=' ::node_modules::'
      set classify+=' ::react.jsx::'

      set classify+=' ::*.nix::'
      set classify+='λ ::*.ml,,*.mli::'
      set classify+=' ::*.styl::'
      set classify+=' ::*.scss::'
      set classify+=' ::*.py,,*.pyc,,*.pyd,,*.pyo::'
      set classify+=' ::*.php::'
      set classify+=' ::*.markdown,,*.md::'
      set classify+=' ::*.json::'
      set classify+=' ::*.js::'
      set classify+=' ::*.bmp,,*.gif,,*.ico,,*.jpeg,,*.jpg,,*.png,,*.svg,,*.svgz,,*.tga,,*.tiff,,
        \*.xmb,,*.xcf,,*.xpm,,*.xspf,,*.xwd,,*.cr2,,*.dng,,*.3fr,,*.ari,,*.arw,,*.bay,,*.crw,,
        \*.cr3,,*.cap,,*.data,,*.dcs,,*.dcr,,*.drf,,*.eip,,*.erf,,*.fff,,*.gpr,,*.iiq,,*.k25,,
        \*.kdc,,*.mdc,,*.mef,,*.mos,,*.mrw,,*.obm,,*.orf,,*.pef,,*.ptx,,*.pxn,,*.r3d,,*.raf,,*.raw,,
        \*.rwl,,*.rw2,,*.rwz,,*.sr2,,*.srf,,*.srw,,*.tif,,*.x3f,,*.webp,,*.avif,,*.jxl::'
      set classify+=' ::*.ejs,,*.htm,,*.html,,*.slim,,*.xml::'
      set classify+=' ::*.mustasche::'
      set classify+=' ::*.css,,*.less,,*.bat,,*.conf,,*.ini,,*.rc,,*.yml,,*.cfg::'
      set classify+=' ::*.rss::'
      set classify+=' ::*.coffee::'
      set classify+=' ::*.twig::'
      set classify+=' ::*.c++,,*.cpp,,*.cxx,,*.h::'
      set classify+=' ::*.cc,,*.c::'
      set classify+=' ::*.hs,,*.lhs::'
      set classify+=' ::*.lua::'
      set classify+=' ::*.jl::'
      set classify+=' ::*.go::'
      set classify+=' ::*.ts::'
      set classify+=' ::*.db,,*.dump,,*.sql::'
      set classify+=' ::*.sln,,*.suo::'
      set classify+=' ::*.exe::'
      set classify+=' ::*.diff,,*.sum,,*.md5,,*.sha512::'
      set classify+=' ::*.scala::'
      set classify+=' ::*.java,,*.jar::'
      set classify+=' ::*.xul::'
      set classify+=' ::*.clj,,*.cljc::'
      set classify+=' ::*.pl,,*.pm,,*.t::'
      set classify+=' ::*.cljs,,*.edn::'
      set classify+=' ::*.rb::'
      set classify+=' ::*.fish,,*.sh,,*.bash::'
      set classify+=' ::*.dart::'
      set classify+=' ::*.f#,,*.fs,,*.fsi,,*.fsscript,,*.fsx::'
      set classify+=' ::*.rlib,,*.rs::'
      set classify+=' ::*.d::'
      set classify+=' ::*.erl,,*.hrl::'
      set classify+=' ::*.ai::'
      set classify+=' ::*.psb,,*.psd::'
      set classify+=' ::*.jsx::'
      set classify+=' ::*.aac,,*.anx,,*.asf,,*.au,,*.axa,,*.flac,,*.m2a,,*.m4a,,*.mid,,*.midi,,
        \*.mp3,,*.mpc,,*.oga,,*.ogg,,*.ogx,,*.ra,,*.ram,,*.rm,,*.spx,,*.wav,,*.wma,,*.ac3::'
      set classify+=' ::*.avi,,*.flv,,*.mkv,,*.mov,,*.mp4,,*.mpeg,,*.mpg,,*.webm,,*.av1::'
      set classify+=' ::*.epub,,*.pdf,,*.fb2,,*.djvu::'
      set classify+=' ::*.7z,,*.apk,,*.bz2,,*.cab,,*.cpio,,*.deb,,*.gem,,*.gz,,*.gzip,,*.lh,,
        \*.lzh,,*.lzma,,*.rar,,*.rpm,,*.tar,,*.tgz,,*.xz,,*.zip,,*.zst::'
      set classify+=' ::*.cbr,,*.cbz::'
      set classify+=' ::*.log::'
      set classify+=' ::*.doc,,*.docx,,*.adoc::'
      set classify+=' ::*.xls,,*.xlsmx::'
      set classify+=' ::*.pptx,,*.ppt::'
    '';
  };
}

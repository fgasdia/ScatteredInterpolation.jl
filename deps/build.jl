deps_dir = Pkg.Dir.path() * "/ScatteredInterpolation/deps/"
pkg_dir = deps_dir * "qhull/"

install_dir = pkg_dir
src_dir = pkg_dir * "src"

# Get source
version = "qhull-2015.2"
filename = "qhull-2015-src-7.2.0.tgz"

mkpath(src_dir)

run(`wget http://www.qhull.org/download/$filename`)
run(`tar xzf $filename -C $src_dir`)
run(`rm $filename`)

# Build!
cd(src_dir * "/" * version)
run(`make`)
run(`make DESTDIR=$install_dir install`)

# Compile the wrapper
cd(deps_dir)
run(`gcc  -fPIC -shared wrapqhull.c qhull/lib/libqhullstatic_r.a -o libwrapqhull.so`)

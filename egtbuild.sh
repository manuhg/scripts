# Download the needed packages we will need, as well as their dependencies.
wget ftp://ftp.gnu.org/gnu/binutils/binutils-2.23.1.tar.bz2
wget http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2
wget ftp://ftp.gnu.org/gnu/gmp/gmp-5.0.5.tar.xz
wget http://mpfr.loria.fr/mpfr-3.0.1/mpfr-3.0.1.tar.xz
wget http://www.multiprecision.org/mpc/download/mpc-1.0.1.tar.gz

# Extract the archives in the current directory.
tar xvf binutils-2.23.1.tar.bz2
tar xvf gcc-4.7.2.tar.bz2 
tar xvf gmp-5.0.5.tar.xz
tar xvf mpfr-3.0.1.tar.xz
tar xvf mpc-1.0.1.tar.gz

# Note: this file was auto-generated by Module::Build::Compat version 0.4007
require 5.008;
    use Module::Build::Compat 0.02;
    use lib 'inc';
    Module::Build::Compat->run_build_pl(args => \@ARGV);
    require Test::Run::Builder;
    Module::Build::Compat->write_makefile(build_class => 'Test::Run::Builder');

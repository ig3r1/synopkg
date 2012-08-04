
INFODATA=$(strip $(shell awk -F=  '/^$(1)/ { print $$2; }' INFO | tr -d '"' ))

PACKAGE=$(call INFODATA,package)
VERSION=$(call INFODATA,version)
DEPENDS=$(call INFODATA,install_dep_packages)


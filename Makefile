IMG = slapd
NAME = pjakobi/$(IMG)
VERSION = latest

.PHONY: build build-nocache test tag-latest push push-latest release git-tag-version

build: 
# PJ : begin
# Kerberos prerequisites : principal (root/admin), keytab (root_admin.keytab)
# Changed ldap.conf
#
#	@cp AuthzRegExp.ldif $(ASSETS)/config/bootstrap/ldif/custom
#	@cp root_admin.keytab $(ASSETS)
#	@cp ldap_slapd.keytab $(ASSETS)
#	@cp sasl_slapd.conf $(ASSETS)
#	@cp -f ldap.conf $(ASSETS)
# PJ : end
	docker build -t $(NAME):$(VERSION) .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm image

run:
	docker run --name $(IMG) $(NAME):$(VERSION)

test:
	env NAME=$(NAME) VERSION=$(VERSION) bats test/test.bats

tag-latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

push:
	docker push $(NAME):$(VERSION)

push-latest:
	docker push $(NAME):latest

release: build test tag-latest push push-latest

git-tag-version: release
	git tag -a v$(VERSION) -m "v$(VERSION)"
	git push origin v$(VERSION)

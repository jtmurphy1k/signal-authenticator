CC = gcc
CFLAGS = -x c -D_POSIX_C_SOURCE -D_DEFAULT_SOURCE -std=c99
CWARN_FLAGS = -Wall -Wextra -Wno-long-long -Wno-variadic-macros
CSHAREDLIB_FLAGS = -fPIC -DPIC -shared -rdynamic
ifndef LIB_SECURITY_DIR
LIB_SECURITY_DIR = "/lib/x86_64-linux-gnu/security"
endif
ifndef SIGNAL_PROG
SIGNAL_PROG = "/usr/local/bin/signal-cli"
endif
PSA = pam_signal_authenticator

all: $(PSA).so

warn: CFLAGS += $(CWARN_FLAGS) 

$(PSA).so : $(PSA).c
	gcc $(CSHAREDLIB_FLAGS) $(CFLAGS) -DSIGNAL_PROG='$(SIGNAL_PROG)' -o $@ $<

install:
	install -m 644 $(PSA).so $(LIB_SECURITY_DIR)/$(PSA).so

uninstall:
	rm -f $(LIB_SECURITY_DIR)/$(PSA).so

clean:
	rm -f pam_signal_authenticator.so

.PHONY: warn all clean install uninstall

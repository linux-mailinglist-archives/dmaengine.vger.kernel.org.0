Return-Path: <dmaengine+bounces-9004-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAfuNeixmWnlWAMAu9opvQ
	(envelope-from <dmaengine+bounces-9004-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED216CE7D
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104333029E54
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD01C3314;
	Sat, 21 Feb 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTIxvzvA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE01B4F0A
	for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771680175; cv=none; b=b2HMKrJah2XRqD2SxRCy8DW9UR7X/Q+7bQr/O6OclU1kRuB5Um3uTG5TO3crLg1Gw5lNihEOFpHtvfaeBKDelkBQUCByfiTZIlGgd8ZYMXbf6f8HW6s08J0gFl15smbj/M4xS7AaME/JdAhzNS95irfZEsVEgVl66exzY1pzSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771680175; c=relaxed/simple;
	bh=MfRtKlsPf92cvmknWCNpjHH1UFJaCSWtJaLIWhAYOwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVpOjfwzFOe5NB0qJooJ2ri/s2WO90kf+0s3xpl/22ckhOfNGO/VkXkwgDrvWmB2wGU8fGklHl9A8F6+0Q8iOOZ5xN+mgsAzFbTG6m2kI/nhjWk7nr+xrWtnOcE1swehUSoVpHmRQWWmhZ1Ua4RLs5rBo9igJntjahOEo4r6908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTIxvzvA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4358fb60802so2162815f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 05:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771680172; x=1772284972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXZPKH4BTRjso/DEzKLoghC1KYJGYJFp04pWZ2xgxCc=;
        b=NTIxvzvAbR6ikJTt1s/hMryMiongd2zW4Xv/uO/DK8/VJ7F8RkSXReG9XmxBcf4U+l
         qbrIOCTWEPAeaO9Jl53GQkcx6DnZoskSlrCwTRJW7JqfR7I8Jv0jynLPxmLv/7oKSXEz
         ZOU4UnxhuFEHjcICo+sdYOGbF53zNJKDb+pnEHEysNyLdHTdJDinjZU7d+2oxSi4bl/5
         ALGrXRPnesEogYT2YUjNmZ4anIbliL3U2MHdccR1m8RboxXv8tfQeYcThBdddtzXor/j
         X5UB0rUKXzCg4M6/VlKmntehkpkLhC8+go5g8os119Nbcz1VjlaifE6ClIpawCbXvqD+
         Pgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771680172; x=1772284972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXZPKH4BTRjso/DEzKLoghC1KYJGYJFp04pWZ2xgxCc=;
        b=q/Qn6UYsUi4OGNSm1UKwO7xJbfSh1VDbiUu7W66Izbdzp9QbwZy5x/YB3hc8I71lPr
         MnenDUK6J9JTtWulJp7o3mKuye3xEHLofrG0BsB3g/IibxgXWhjL4+1zB58qn1UVH22O
         GBB7s/TsrW5kA3S1GdN/mC4xjDG8rZ5oQWdtuI3IQNtI5gEv0sJjgCldl/fZgw69K58O
         ggzxlr0MUXMJ1gOo9HtEdg8QceJeZdFgt4MMaIeUt+DQbbN7FROheack2iEXEIRtBYYL
         uH4QUp2rUXNtlpObkAgOevfBrk+kVe3xkIF7BA+NiBG1Dzu69ZHb5BD2FHKc2wfo6sTC
         vZEQ==
X-Gm-Message-State: AOJu0YzCs/7jlPfIFD/xWYQ5yUW6JnzN/o3Ojk8txZaXZGNNxYGdBDIS
	N7u4Ov75cDKiPX2KrYGeKQXGR8pnu3QLsKXvSKQSLlgZ/SW/DoyXbI3K
X-Gm-Gg: AZuq6aL8qL99kk6YoKSQNWE422wMCaMc1ozrqcn/Gy4TakWb595foievP36FpiBDrnz
	gdeLHsM351ADGglG2vs7TaMRTINRKWi+y4xxiQn8Sgcf00Al0qQi0vAm1sqcNUVjSpYvyLzt5DJ
	NxACHUgfdubdlBCTuYdSG0R7KiSDMNs8iblus97QZOm4dSyECkbC1/SoUeAo6vvOzkdpR4UY8O8
	kqo9GH10YRAF4uMBGZ6D1Sb40tMKmNsA6GBWpGHmL3xoVASc2kUZvupcaWpPCqjDAhvzNBQhliP
	68whbirkYHTAWaD+y4YJz7T+CNtdZF3/9qQT+rWNHX9vQEgum/j7ftSHYnuqQgfMNghpyGQ71bj
	9uuVqJHYoZ7FB7e9zAvH5BxjHYpe1satmOiTDhci7SwK7oS240uux/MbtGWdwBKJTI3NhoJ5I2T
	tJ4wZAx21HkwjnkaTme86MgID/X1Q=
X-Received: by 2002:a05:6000:2505:b0:435:a135:777d with SMTP id ffacd0b85a97d-4396fda9bafmr5128784f8f.9.1771680171999;
        Sat, 21 Feb 2026 05:22:51 -0800 (PST)
Received: from ideapad ([2a02:8070:a483:bca0:8c22:565c:f0a8:cd41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa1bdsm4645071f8f.3.2026.02.21.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:22:50 -0800 (PST)
From: Alexander Gordeev <a.gordeev.box@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] tools/dma-slave: DMA slave device transfer utility
Date: Sat, 21 Feb 2026 14:22:48 +0100
Message-ID: <20260221132248.17721-3-a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221132248.17721-1-a.gordeev.box@gmail.com>
References: <20260221132248.17721-1-a.gordeev.box@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9004-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[agordeevbox@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78ED216CE7D
X-Rspamd-Action: no action

A utility to pass user data through a DMA slave device. It is
intended for bringing up and debugging DMA devices.

The tool writes the contents of a binary file to, or reads from,
the companion dma-slave device driver, which must be loaded.

The contents of an input file to be transferred can be prepared
to trigger specific target device behavior on writes.

For read operations, the output file contents can be examined using
user-level tools to detect transfer integrity issues.

The DMA transfer parameters are provided via command-line arguments
and are not sanitized in any way. These parameters are used as-is to
initialize a dma_slave_config instance passed to dmaengine_slave_config().

An additional file may be provided as peripheral configuration data for
the DMA transfer. In this case, dma_slave_config::peripheral_config and
dma_slave_config::peripheral_size members are populated from the file
contents and its size.

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 tools/Makefile        |  11 +-
 tools/dma/Makefile    |  20 +++
 tools/dma/dma-slave.c | 321 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 5 deletions(-)
 create mode 100644 tools/dma/Makefile
 create mode 100644 tools/dma/dma-slave.c

diff --git a/tools/Makefile b/tools/Makefile
index c31cbbd12c45..2c52bf7bc899 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -14,6 +14,7 @@ help:
 	@echo '  counter                - counter tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  debugging              - tools for debugging'
+	@echo '  dma                    - DMA tools'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
 	@echo '  firmware               - Firmware tools'
 	@echo '  freefall               - laptop accelerometer program for disk protection'
@@ -69,7 +70,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
+counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing dma: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -122,7 +123,7 @@ kvm_stat: FORCE
 ynl: FORCE
 	$(call descend,net/ynl)
 
-all: acpi counter cpupower gpio hv firewire \
+all: acpi counter cpupower dma gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -134,7 +135,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
+counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install dma_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -165,7 +166,7 @@ ynl_install:
 	$(call descend,net/$(@:_install=),install)
 
 install: acpi_install counter_install cpupower_install gpio_install \
-		hv_install firewire_install iio_install \
+		hv_install firewire_install iio_install dma_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
@@ -178,7 +179,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
+counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean dma_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
diff --git a/tools/dma/Makefile b/tools/dma/Makefile
new file mode 100644
index 000000000000..c92a260ccf36
--- /dev/null
+++ b/tools/dma/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+PREFIX ?= /usr
+SBINDIR ?= sbin
+INSTALL ?= install
+CFLAGS += -Wall -Wextra -I../../include/uapi -D__EXPORTED_HEADERS__
+
+TARGET = dma-slave
+
+all: $(TARGET)
+
+%: %.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
+
+clean:
+	$(RM) $(TARGET)
+
+install: $(TARGET)
+	$(INSTALL) -D -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/$(SBINDIR)/$(TARGET)
+
+.PHONY: all clean install
diff --git a/tools/dma/dma-slave.c b/tools/dma/dma-slave.c
new file mode 100644
index 000000000000..e1256779ccd3
--- /dev/null
+++ b/tools/dma/dma-slave.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Alexander Gordeev <a.gordeev.box@gmail.com>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/uio.h>
+#include <sys/mman.h>
+#include <linux/types.h>
+#include <linux/dma-slave.h>
+
+static void dump_mem(const void *mem, size_t mem_len)
+{
+	unsigned int i;
+
+	if (mem_len > 16)
+		mem_len = 16;
+	printf("[ ");
+	for (i = 0; i < mem_len; i++)
+		printf("%02X ", ((const unsigned char *)mem)[i]);
+	printf("]\n");
+}
+
+static bool check_args(unsigned int cmd, const char *file, struct dma_slave_config_uapi *ucfg)
+{
+	if (cmd == IOCTL_DMA_SLAVE_READ) {
+		if (!ucfg->data.iov_len)
+			return false;
+		if (!ucfg->src_addr)
+			return false;
+	} else if (cmd == IOCTL_DMA_SLAVE_WRITE) {
+		if (!ucfg->dst_addr)
+			return false;
+	} else {
+		return false;
+	}
+	if (!file)
+		return false;
+	return true;
+}
+
+static int read_peripheral_config(const char *conf, struct iovec *peripheral_config)
+{
+	struct stat stat;
+	void *buf;
+	int fd;
+	int ret;
+
+	if (!conf)
+		return 0;
+
+	fd = open(conf, O_RDONLY);
+	if (fd < 0) {
+		ret = errno;
+		goto err_ret;
+	}
+	if (fstat(fd, &stat) < 0) {
+		ret = errno;
+		goto err_close_fd;
+	}
+	buf = malloc(stat.st_size);
+	if (!buf) {
+		ret = errno;
+		goto err_close_fd;
+	}
+	if (read(fd, buf, stat.st_size) < 0) {
+		ret = errno;
+		goto err_free;
+	}
+
+	peripheral_config->iov_base = buf;
+	peripheral_config->iov_len = stat.st_size;
+	ret = 0;
+
+err_free:
+	free(buf);
+err_close_fd:
+	close(fd);
+err_ret:
+	return ret;
+}
+
+static void print_usage(void)
+{
+	printf("A utility to transfer the contents of a file to a DMA slave device.\n");
+	printf("Requires the companion 'dma-slave' device driver to be loaded.\n\n");
+
+	printf("Usage:\n");
+	printf("  dma-slave [OPTIONS]\n\n");
+
+	printf("Transfer direction (required, select one):\n");
+	printf("  -r, --read                     Perform DMA read (device to file)\n");
+	printf("  -w, --write                    Perform DMA write (file to device)\n\n");
+
+	printf("Transfer address (required):\n");
+	printf("  -S, --src-addr <addr>          Source address (hex,dec,oct)\n");
+	printf("  -D, --dst-addr <addr>          Destination address (hex,dec,oct)\n\n");
+
+	printf("Transfer size (required on read, optional on write):\n");
+	printf("  -s, --size <bytes>             Transfer size in bytes\n\n");
+
+	printf("Transfer parameters (optional):\n");
+	printf("      --src-addr-width <n>       Source address width\n");
+	printf("      --dst-addr-width <n>       Destination address width\n");
+	printf("      --src-maxburst <n>         Source max burst size\n");
+	printf("      --dst-maxburst <n>         Destination max burst size\n");
+	printf("      --src-port-window-size <n> Source port window size\n");
+	printf("      --dst-port-window-size <n> Destination port window size\n");
+	printf("      --device-fc                Enable device flow control\n");
+	printf("  -p, --peripheral-config <file> Peripheral configuration file (raw)\n\n");
+
+	printf("User stored data (recreated on read, must exist on write):\n");
+	printf("  -f, --file <file>              Transfer contents (raw)\n\n");
+
+	printf("Target DMA channel (optional, auto-selected if not provided):\n");
+	printf("  -c, --channel-name <name>      DMA channel name (in /sys/class/dma)\n");
+
+	printf("Advanced parameters (optional):\n");
+	printf("  -d, --dump                     Dump transferred data (16 bytes at most)\n\n");
+
+	printf("Examples:\n");
+	printf("  dma-slave --read  -c dma0chan0 -S 0x20000000 --file output.bin -s 4096\n");
+	printf("  dma-slave --write -c dma0chan0 -D 0x10000000 --file input.bin\n");
+}
+
+enum {
+	OPT_SRC_ADDR_WIDTH,
+	OPT_DST_ADDR_WIDTH,
+	OPT_SRC_MAXBURST,
+	OPT_DST_MAXBURST,
+	OPT_SRC_PORT_WINDOW_SIZE,
+	OPT_DST_PORT_WINDOW_SIZE,
+	OPT_DEVICE_FC,
+};
+
+static const struct option long_opts[] = {
+	{ "help",			no_argument,		NULL, 'h' },
+	{ "read",			no_argument,		NULL, 'r' },
+	{ "write",			no_argument,		NULL, 'w' },
+	{ "dump",			no_argument,		NULL, 'd' },
+	{ "channel-name",		required_argument,	NULL, 'c' },
+	{ "peripheral-config",		required_argument,	NULL, 'p' },
+	{ "file",			required_argument,	NULL, 'f' },
+	{ "size",			required_argument,	NULL, 's' },
+	{ "src-addr",			required_argument,	NULL, 'S' },
+	{ "dst-addr",			required_argument,	NULL, 'D' },
+	{ "src-addr-width",		required_argument,	NULL, OPT_SRC_ADDR_WIDTH },
+	{ "dst-addr-width",		required_argument,	NULL, OPT_DST_ADDR_WIDTH },
+	{ "src-maxburst",		required_argument,	NULL, OPT_SRC_MAXBURST },
+	{ "dst-maxburst",		required_argument,	NULL, OPT_DST_MAXBURST },
+	{ "src-port-window-size",	required_argument,	NULL, OPT_SRC_PORT_WINDOW_SIZE },
+	{ "dst-port-window-size",	required_argument,	NULL, OPT_DST_PORT_WINDOW_SIZE },
+	{ "device-fc",			no_argument,		NULL, OPT_DEVICE_FC },
+	{ NULL,				0,			NULL, 0  }
+};
+
+int main(int argc, char **argv)
+{
+	char *file = NULL, *conf = NULL, *endptr;
+	struct dma_slave_config_uapi ucfg = {};
+	int fd, fd_dev;
+	unsigned int cmd = 0;
+	bool dump = false;
+	struct stat stat;
+	char opt;
+	int ret;
+
+	if (argc == 1) {
+print_usage:
+		print_usage();
+		return 0;
+	}
+
+	while ((opt = getopt_long(argc, argv, "hrwdc:s:p:f:S:D:", long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			goto print_usage;
+		case 'r':
+			if (cmd == IOCTL_DMA_SLAVE_WRITE)
+				goto err_args;
+			cmd = IOCTL_DMA_SLAVE_READ;
+			break;
+		case 'w':
+			if (cmd == IOCTL_DMA_SLAVE_READ)
+				goto err_args;
+			cmd = IOCTL_DMA_SLAVE_WRITE;
+			break;
+		case 'd':
+			dump = true;
+			break;
+		case 'c':
+			strncpy(ucfg.channel_name, optarg, sizeof(ucfg.channel_name) - 1);
+			break;
+		case 'p':
+			conf = optarg;
+			break;
+		case 'f':
+			file = optarg;
+			break;
+		case 's':
+			ucfg.data.iov_len = strtoull(optarg, &endptr, 0);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case 'S':
+			ucfg.src_addr = strtoull(optarg, &endptr, 0);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case 'D':
+			ucfg.dst_addr = strtoull(optarg, &endptr, 0);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_SRC_ADDR_WIDTH:
+			ucfg.src_addr_width = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_DST_ADDR_WIDTH:
+			ucfg.dst_addr_width = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_SRC_MAXBURST:
+			ucfg.src_maxburst = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_DST_MAXBURST:
+			ucfg.dst_maxburst = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_SRC_PORT_WINDOW_SIZE:
+			ucfg.src_port_window_size = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_DST_PORT_WINDOW_SIZE:
+			ucfg.dst_port_window_size = strtoul(optarg, &endptr, 10);
+			if (endptr[0])
+				goto err_args;
+			break;
+		case OPT_DEVICE_FC:
+			ucfg.device_fc = true;
+			break;
+		default:
+			goto err_args;
+		}
+	}
+
+	ret = read_peripheral_config(conf, &ucfg.peripheral_config);
+	if (ret)
+		return ret;
+
+	if (!check_args(cmd, file, &ucfg)) {
+err_args:
+		print_usage();
+		return EINVAL;
+	}
+
+	fd_dev = open("/dev/" DMA_SLAVE_DEVICE, O_RDWR);
+	if (fd_dev < 0)
+		return errno;
+
+	switch (cmd) {
+	case IOCTL_DMA_SLAVE_READ:
+		fd = open(file, O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+		if (fd < 0)
+			return errno;
+		if (ftruncate(fd, ucfg.data.iov_len) < 0)
+			return errno;
+		ucfg.data.iov_base = mmap(NULL, ucfg.data.iov_len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (ucfg.data.iov_base == MAP_FAILED) {
+			ret = errno;
+			unlink(file);
+			return ret;
+		}
+		close(fd);
+		break;
+
+	case IOCTL_DMA_SLAVE_WRITE:
+		fd = open(file, O_RDONLY);
+		if (fd < 0)
+			return errno;
+		if (fstat(fd, &stat) < 0)
+			return errno;
+		if (!stat.st_size)
+			return EINVAL;
+		if (!ucfg.data.iov_len || (size_t)stat.st_size < ucfg.data.iov_len)
+			ucfg.data.iov_len = stat.st_size;
+		ucfg.data.iov_base = mmap(NULL, ucfg.data.iov_len, PROT_READ, MAP_SHARED, fd, 0);
+		if (ucfg.data.iov_base == MAP_FAILED)
+			return errno;
+		close(fd);
+		if (dump)
+			dump_mem(ucfg.data.iov_base, ucfg.data.iov_len);
+		break;
+	}
+
+	if (ioctl(fd_dev, cmd, &ucfg) < 0) {
+		ret = errno;
+		if (cmd == IOCTL_DMA_SLAVE_READ)
+			unlink(file);
+		return ret;
+	}
+
+	if (cmd == IOCTL_DMA_SLAVE_READ && dump)
+		dump_mem(ucfg.data.iov_base, ucfg.data.iov_len);
+
+	munmap(ucfg.data.iov_base, ucfg.data.iov_len);
+	close(fd_dev);
+
+	return 0;
+}
-- 
2.51.0



Return-Path: <dmaengine+bounces-6133-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B7B32437
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19F2AA20EB
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C0340D9D;
	Fri, 22 Aug 2025 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2y5zO3q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25733CEB0
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897975; cv=none; b=aE71yUK5ytZRmxcmQ2ssgtlGVggkky2mh+AJ5UM2wkCyWVkkhEAjBDcCPkXLrqzh0l+Eb0cHV5OwZkeqv5Gk3GWpE+ZjVHejSnJE8reKhPNIeyC96VSmJlDguXSZNTkp8BokG7ubzpzOLpQeGCjBf91v3SYIhV/pHk1uZkaX0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897975; c=relaxed/simple;
	bh=NORyUSlbU8EsWUFNyAQgoB9EJFRJk920ZPVgWiWOQcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vk9Nsl0IOe2cqAKejmrG8/jXmoLZnyhuXFyAG1LGp654R3baEP0xq+TsOmZ7SriJAcVHLgC/lkBE/GzbQg9K/xMuZhS30CXDkuF5DyXArHMRbx5vx7pvfbKt9GS45ukHlrn/dO+1IUbA80QPDJDwa69DLQvg9DO5HuARQp0MCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2y5zO3q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eaecf8dso2107785b3a.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897973; x=1756502773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBj2QiMe0vt7AZV7Qmm+QhcLWq8qiOs1xJ5ZlqOKZDM=;
        b=W2y5zO3q9N5lH+1sV1JiIJJScZ15CPgz2WduZbpIw4FWR77pUNK94AjONeEBIimf1A
         e6IRqIAyZ4K61Kp8zxXOfneRLcjcl46oRCIod5KGaz/fDSgr/VyHcckyvukP4Jt3UhE9
         AtaWi8B+vcG+CG9ffEqvR0rz24p8CjyEaNTn6CyqCv93dH/NTujuUDTUNXdg6N9E2+Wb
         l5uUWc78VHTKctjT1mKa+Pcyy0mwdqqNDgQWQLiSx2vT52qnvDY4Xnalr1atG220Sm58
         QkEf5xwaaXvbRbn4++f8pGW75VqDbcJV33zpsPrhz5079H44PQYUIxRz5YM+JFIrizrr
         +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897973; x=1756502773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBj2QiMe0vt7AZV7Qmm+QhcLWq8qiOs1xJ5ZlqOKZDM=;
        b=mi8/VQynH5YwiuVjeMNs7dt9B1ydEJ5zpjCW635t/W/wOQ4lzkvx+LZm72YT0CXUB1
         3ornqr5EI+K2UbmCQ8ZZC8Q0bsx0gluhKTdWQgXpLiFZ9sipDw/DDR3t6C6wQl66CkSz
         uuXohrUatSR4Lis5OjF9uOvULB/jvafVCLdavUlBT0CAfwP+4OlC1ECaliRC6k3prHBN
         7PTCjEnosbfPBGysUWl32+OTOgxY/vuILCMsj4WMjB6pFTOrSU4KI5F9feCyWxx+aCZs
         j+U7G9Z9eXJb2XJiPRmarvjN/qvPyX0QbkVLsqM02d51AyXfSzqt7ULWHz+j7QK75OQP
         gaYg==
X-Forwarded-Encrypted: i=1; AJvYcCVc9DoI+3h6vNH24yZ5eFvk0EWt3URJ84nip2luvSIQ62I/U3TTj2C20Xm2Cl3QRYfY5tSGI0icQ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvMB/3V2AbrPXg2UZ7pLruKafJrSL1rg/X4tTOnJsRjy2X8OY
	ueEP5B3Vp6MDE/MjLiTPGdzgWfpAm9/Jq4e5bq+NMn9/mtv/EfLWmTgPbX3pYm4yLPePbtvRYPh
	QCQHoCvk/2a0fGA==
X-Google-Smtp-Source: AGHT+IF9blvj2jiQhhauuqaLOwwXU1bbadYRx7ZF6hGIpAPUKYj3eVAvxvCO2/rhk+fmSVymvuwZZO701Acs9A==
X-Received: from pjvb15.prod.google.com ([2002:a17:90a:d88f:b0:311:c197:70a4])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3ca7:b0:243:78a:82a5 with SMTP id adf61e73a8af0-24340d92912mr6918380637.59.1755897972725;
 Fri, 22 Aug 2025 14:26:12 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:50 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-4-dmatlack@google.com>
Subject: [PATCH v2 03/30] vfio: selftests: Introduce vfio_pci_device_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Introduce a basic VFIO selftest called vfio_pci_device_test to
demonstrate the functionality of the VFIO selftest library and provide
some test coverage of basic VFIO operations, including:

 - Mapping and unmapping DMA
 - Mapping and unmapping BARs
 - Enabling, triggering, and disabling MSI and MSI-x
 - Reading and writing to PCI config space

This test should work with most PCI devices, as long as they are bound
to vfio-pci.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_device_test.c     | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index db3e4db1a6dd..828419537250 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS += vfio_pci_device_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
new file mode 100644
index 000000000000..3e7049b9c8f6
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <stdlib.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/limits.h>
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+/*
+ * Limit the number of MSIs enabled/disabled by the test regardless of the
+ * number of MSIs the device itself supports, e.g. to avoid hitting IRTE limits.
+ */
+#define MAX_TEST_MSI 16U
+
+FIXTURE(vfio_pci_device_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_pci_device_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_device_test)
+{
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_device_test, dma_map_unmap)
+{
+	const u64 size = SZ_2M;
+	void *mem;
+	u64 iova;
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(mem, MAP_FAILED);
+
+	iova = (u64)mem;
+
+	vfio_pci_dma_map(self->device, iova, size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_unmap(self->device, iova, size);
+
+	ASSERT_TRUE(!munmap(mem, SZ_2M));
+}
+
+#define read_pci_id_from_sysfs(_file) ({							\
+	char __sysfs_path[PATH_MAX];								\
+	char __buf[32];										\
+	int __fd;										\
+												\
+	snprintf(__sysfs_path, PATH_MAX, "/sys/bus/pci/devices/%s/%s", device_bdf, _file);	\
+	ASSERT_GT((__fd = open(__sysfs_path, O_RDONLY)), 0);					\
+	ASSERT_GT(read(__fd, __buf, ARRAY_SIZE(__buf)), 0);					\
+	ASSERT_EQ(0, close(__fd));								\
+	(u16)strtoul(__buf, NULL, 0);								\
+})
+
+TEST_F(vfio_pci_device_test, config_space_read_write)
+{
+	u16 vendor, device;
+	u16 command;
+
+	/* Check that Vendor and Device match what the kernel reports. */
+	vendor = read_pci_id_from_sysfs("vendor");
+	device = read_pci_id_from_sysfs("device");
+
+	ASSERT_EQ(vendor, vfio_pci_config_readw(self->device, PCI_VENDOR_ID));
+	ASSERT_EQ(device, vfio_pci_config_readw(self->device, PCI_DEVICE_ID));
+
+	printf("Vendor: %04x, Device: %04x\n", vendor, device);
+
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_FALSE(command & PCI_COMMAND_MASTER);
+
+	vfio_pci_config_writew(self->device, PCI_COMMAND, command | PCI_COMMAND_MASTER);
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_TRUE(command & PCI_COMMAND_MASTER);
+	printf("Enabled Bus Mastering (command: %04x)\n", command);
+
+	vfio_pci_config_writew(self->device, PCI_COMMAND, command & ~PCI_COMMAND_MASTER);
+	command = vfio_pci_config_readw(self->device, PCI_COMMAND);
+	ASSERT_FALSE(command & PCI_COMMAND_MASTER);
+	printf("Disabled Bus Mastering (command: %04x)\n", command);
+}
+
+TEST_F(vfio_pci_device_test, validate_bars)
+{
+	struct vfio_pci_bar *bar;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		bar = &self->device->bars[i];
+
+		if (!(bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP)) {
+			printf("BAR %d does not support mmap()\n", i);
+			ASSERT_EQ(NULL, bar->vaddr);
+			continue;
+		}
+
+		/*
+		 * BARs that support mmap() should be automatically mapped by
+		 * vfio_pci_device_init().
+		 */
+		ASSERT_NE(NULL, bar->vaddr);
+		ASSERT_NE(0, bar->info.size);
+		printf("BAR %d mapped at %p (size 0x%llx)\n", i, bar->vaddr, bar->info.size);
+	}
+}
+
+FIXTURE(vfio_pci_irq_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_VARIANT(vfio_pci_irq_test) {
+	int irq_index;
+};
+
+FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msi) {
+	.irq_index = VFIO_PCI_MSI_IRQ_INDEX,
+};
+
+FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
+	.irq_index = VFIO_PCI_MSIX_IRQ_INDEX,
+};
+
+FIXTURE_SETUP(vfio_pci_irq_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_irq_test)
+{
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_irq_test, enable_trigger_disable)
+{
+	bool msix = variant->irq_index == VFIO_PCI_MSIX_IRQ_INDEX;
+	u32 count;
+	u64 value;
+	int i;
+
+	if (msix)
+		count = self->device->msix_info.count;
+	else
+		count = self->device->msi_info.count;
+
+	count = min(count, MAX_TEST_MSI);
+
+	if (!count)
+		SKIP(return, "MSI%s: not supported\n", msix ? "-x" : "");
+
+	vfio_pci_irq_enable(self->device, variant->irq_index, 0, count);
+	printf("MSI%s: enabled %d interrupts\n", msix ? "-x" : "", count);
+
+	for (i = 0; i < count; i++) {
+		vfio_pci_irq_trigger(self->device, variant->irq_index, i);
+		ASSERT_EQ(8, read(self->device->msi_eventfds[i], &value, 8));
+		ASSERT_EQ(1, value);
+	}
+
+	vfio_pci_irq_disable(self->device, variant->irq_index);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog



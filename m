Return-Path: <dmaengine+bounces-5565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEFAE263F
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD007189EE77
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234C253351;
	Fri, 20 Jun 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03gO1m3R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE624EAB1
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461693; cv=none; b=PVnt9ylhVJHXcQ5m4IYFXXeJqKXWUeDudQRCbgXf9Ve10Fz9kWljm9SFVArxFv4ZeWQ8hyedxVLikbHNjcSqoDxeB8qPPDClt5oAD2xF4yd2/Lgh1VutIYI2NW6HZqZwt6FEmlFauAlch1hTGBbiSbR+dH30gJn+fqzWUJwIkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461693; c=relaxed/simple;
	bh=IsFvOBHqRlAEUVF7KKJZ2x4utZaxc/EDPWqQq/TN5ZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQoxl6tW02EzPCcnWe2Hu1rB4OwwGWiU/pKY+e4LQJciy3KuHi3OW2MmCutfMcxv6r7vrCWVlyiK709w8ymVDZNFtwtKEbZpthg8dKCHRhCg6wRFKfjjPOfDhzVJhSRCQr4vL6k9Zrg/4AcKYDQtYyJYxjBffwViN2TSHeN75ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03gO1m3R; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23689228a7fso34359525ad.1
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461690; x=1751066490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZz31D2ntF5YQlDX99DZ96oCVuyO8djunRncVBrswig=;
        b=03gO1m3RdMsMRuf1sKlX2I2gQaUT40yVJbSUvYnlbe1M9UwIOylBttOnqDtO5xiNm8
         lXVnvmAyx3rulM5ujznpoywSmLvXvGb5GH61CIhCqHj/mY09+d+v/H8JDiAQaiqo/A2E
         +RegIN7ROaqllhmxwvCwgSURMQZWN4FT4JSRY1t79HsFcVgiltY5VAx/OuojQv2kBMze
         44QgJnr4S+0nWkzCB2zmcUNoz0UPOEI/NFLyfkeAwIo6INgIwJIgSKE/AZMQSGJ+Qtip
         xuFxGIGyNfx6dE1i1p1IiT2xdUK7DAB3IZB+Onc1xAwgPFKUIseAjGF/+fGYWSWx4gVa
         PWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461690; x=1751066490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZz31D2ntF5YQlDX99DZ96oCVuyO8djunRncVBrswig=;
        b=advmvGgATOimRkICJG3VMIXocztG1r3T/jyV3sJcNtiDzWKb00n0rbGlJqMhKL8Muh
         GwhfoxDrkcNT87mrYeF/LGWCc/yL2Kmb2TBZ+6Lih8BtIvGFNvDj4tRlquuLn9WimW0v
         t8U3Jy9Fqh5XvHFEKaqNVM3ie/KGVwm3dH8g5nvLdsJt0UuuqdlVX3dIu8V32NvLCcRe
         lQYvAyZxBCxypjkFXmuI+It/yhNRchDTaa4QBMmQEJeHFXr3ck34ZA2I58yYvXS8TJks
         0kh++a2OJCJBx+c0eZZMIuGbb0U3llt4Yshk6LdZBJcWO9rmnzYfy/x4Sz8k606rQx9G
         cc7g==
X-Forwarded-Encrypted: i=1; AJvYcCVVkv21FkrExaNoooUhCyixI2q4LfAovzIFkge+g4VdAJIZ1NmstbjtpiguSGvLpjyPqpHbhnkQpWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6CiDbZR84lyNFcuo/5WFjhjhpRD+eDSnGiVp/exKwaE+nyAL
	E9+uwiJAl/bsDWATGRV10s+2wVoDuJCOylU9NwdyFfe7SGOZ1VYPjhvRJAqaWaSI/sTV/0ezjAN
	cQmm58/dOr0rtFg==
X-Google-Smtp-Source: AGHT+IG+xiglp96OyIGi9Ol6UgEO/j0nlXM/dP0GSFtRx/oZMy7VW9qLOdaznuVaI39/U9/9zQ+tv65i5Cxaew==
X-Received: from pjur11.prod.google.com ([2002:a17:90a:d40b:b0:309:f831:28e0])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b03:b0:236:15b7:62e8 with SMTP id d9443c01a7336-237d9852884mr63231725ad.25.1750461689922;
 Fri, 20 Jun 2025 16:21:29 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:16 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-19-dmatlack@google.com>
Subject: [PATCH 18/33] vfio: sefltests: Add vfio_pci_driver_test
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a new selftest that tests all driver operations. This test serves
both as a demonstration of the driver framework, and also as a
correctness test for future drivers.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_driver_test.c     | 236 ++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 05c5a585cca6..ee09c027ade5 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -2,6 +2,7 @@ CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
+TEST_GEN_PROGS += vfio_pci_driver_test
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
new file mode 100644
index 000000000000..ab22b7e357fd
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+#include <linux/io.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+#define ASSERT_NO_MSI(_eventfd) do {			\
+	u64 __value;					\
+							\
+	ASSERT_EQ(-1, read(_eventfd, &__value, 8));	\
+	ASSERT_EQ(EAGAIN, errno);			\
+} while (0)
+
+static void region_setup(struct vfio_pci_device *device,
+			 struct vfio_dma_region *region,
+			 iova_t iova, u64 size)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, prot, flags, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = iova;
+	region->size = size;
+
+	vfio_pci_dma_map(device, region);
+}
+
+static void region_teardown(struct vfio_pci_device *device,
+			    struct vfio_dma_region *region)
+{
+	vfio_pci_dma_unmap(device, region);
+	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
+}
+
+FIXTURE(vfio_pci_driver_test) {
+	struct vfio_pci_device *device;
+	struct vfio_dma_region memcpy_region;
+	void *vaddr;
+	int msi_fd;
+
+	u64 size;
+	void *src;
+	void *dst;
+	iova_t src_iova;
+	iova_t dst_iova;
+	iova_t unmapped_iova;
+};
+
+FIXTURE_SETUP(vfio_pci_driver_test)
+{
+	struct vfio_pci_driver *driver;
+
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+
+	driver = &self->device->driver;
+
+	region_setup(self->device, &self->memcpy_region, SZ_1G, SZ_1G);
+	region_setup(self->device, &driver->region, SZ_4G, SZ_2M);
+
+	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
+	self->unmapped_iova = 8UL * SZ_1G;
+
+	vfio_pci_driver_init(self->device);
+	self->msi_fd = self->device->msi_eventfds[driver->msi];
+
+	/*
+	 * Use the maximum size supported by the device for memcpy operations,
+	 * slimmed down to fit into the memcpy region (divided by 2 so src and
+	 * dst regions do not overlap).
+	 */
+	self->size = self->device->driver.max_memcpy_size;
+	self->size = min(self->size, self->memcpy_region.size / 2);
+
+	self->src = self->memcpy_region.vaddr;
+	self->dst = self->src + self->size;
+
+	self->src_iova = to_iova(self->device, self->src);
+	self->dst_iova = to_iova(self->device, self->dst);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_driver_test)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+
+	vfio_pci_driver_remove(self->device);
+
+	region_teardown(self->device, &self->memcpy_region);
+	region_teardown(self->device, &driver->region);
+
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_pci_driver_test, init_remove)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		vfio_pci_driver_remove(self->device);
+		vfio_pci_driver_init(self->device);
+	}
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_success)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	memset(self->src, 'x', self->size);
+	memset(self->dst, 'y', self->size);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->device,
+					    self->src_iova,
+					    self->dst_iova,
+					    self->size));
+
+	ASSERT_EQ(0, memcmp(self->src, self->dst, self->size));
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_from_unmapped_iova)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Ignore the return value since not all devices will detect and report
+	 * accesses to unmapped IOVAs as errors.
+	 */
+	vfio_pci_driver_memcpy(self->device, self->unmapped_iova,
+			       self->dst_iova, self->size);
+
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, memcpy_to_unmapped_iova)
+{
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Ignore the return value since not all devices will detect and report
+	 * accesses to unmapped IOVAs as errors.
+	 */
+	vfio_pci_driver_memcpy(self->device, self->src_iova,
+			       self->unmapped_iova, self->size);
+
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+TEST_F(vfio_pci_driver_test, send_msi)
+{
+	u64 value;
+
+	vfio_pci_driver_send_msi(self->device);
+	ASSERT_EQ(8, read(self->msi_fd, &value, 8));
+	ASSERT_EQ(1, value);
+}
+
+TEST_F(vfio_pci_driver_test, mix_and_match)
+{
+	u64 value;
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		memset(self->src, 'x', self->size);
+		memset(self->dst, 'y', self->size);
+
+		ASSERT_EQ(0, vfio_pci_driver_memcpy(self->device,
+						    self->src_iova,
+						    self->dst_iova,
+						    self->size));
+
+		ASSERT_EQ(0, memcmp(self->src, self->dst, self->size));
+
+		vfio_pci_driver_memcpy(self->device,
+				       self->unmapped_iova,
+				       self->dst_iova,
+				       self->size);
+
+		vfio_pci_driver_send_msi(self->device);
+		ASSERT_EQ(8, read(self->msi_fd, &value, 8));
+		ASSERT_EQ(1, value);
+	}
+}
+
+TEST_F_TIMEOUT(vfio_pci_driver_test, memcpy_storm, 60)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+	u64 total_size;
+	u64 count;
+
+	fcntl_set_nonblock(self->msi_fd);
+
+	/*
+	 * Perform up to 250GiB worth of DMA reads and writes across several
+	 * memcpy operations. Some devices can support even more but the test
+	 * will take too long.
+	 */
+	total_size = 250UL * SZ_1G;
+	count = min(total_size / self->size, driver->max_memcpy_count);
+
+	printf("Kicking off %lu memcpys of size 0x%lx\n", count, self->size);
+	vfio_pci_driver_memcpy_start(self->device,
+				     self->src_iova,
+				     self->dst_iova,
+				     self->size, count);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy_wait(self->device));
+	ASSERT_NO_MSI(self->msi_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	struct vfio_pci_device *device;
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+	if (!device->driver.ops) {
+		fprintf(stderr, "No driver found for device %s\n", device_bdf);
+		return KSFT_SKIP;
+	}
+	vfio_pci_device_cleanup(device);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.50.0.rc2.701.gf1e915cc24-goog



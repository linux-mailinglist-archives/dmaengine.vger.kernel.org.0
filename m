Return-Path: <dmaengine+bounces-6135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B24B32442
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C66A20E78
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D2343205;
	Fri, 22 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8DulvSA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5234166E
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897979; cv=none; b=SPhbmT4crTeXSPzTW3GBm0rkwlcRWgt4JeMTFZ0t4BrYDomT4i6qacMYxh2ARfryXgVDTeWodEP4ymXukdFYAoOxFf8L7nfX8QSELkj/3OiU3+abjSizSzljZMQsU/idip2BmWT1LPcBrSF2jP6rvX7HTjT+DxvSEMNt0drWa20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897979; c=relaxed/simple;
	bh=pKdEjvsPhO4sdnnlpSYtt8LFrQQahqcjDYLnpvRwl60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUmcjOjZdVKJnsyPLyP6Ip0EOOtpMLhphtULJ3U7pKWzRUG3m3WyvrGL6xdzB5mjYwVk8DRJRvToz+VwQVdws4euugg/yr9kxTaay/vpbesoAHMSj/186OQrlSlhrxi5gUJ3/R1BRNZwwy71diaTUJAkb8clXEApgPreIFHGOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8DulvSA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b474b68cff7so2172321a12.1
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897976; x=1756502776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RYDPV0uYiAvqyhiIKkPSxK3HYqExYDiY91NCb6FZc=;
        b=e8DulvSAEp+2JQQGzePZirJ5IaiuDKxx0iw9cxJowv0u4UOV9+ysVpAvOYciDndaAd
         6UVVLl+FykfbGV0X4pd/vWeJPMcGKXPPhmrE7MLae4wiqteGU8UXmV0KzU+Ky3axqwA8
         12ygFSwcwJ5nwvn2Bq3eQE1hTkpLGf75FYfMJP4JCJKNHtVkCLzAmcuW2BJr/x3t6vJL
         v8I+K/FllOCq6it95bL0xwMPr1WCMJkX/yY3Tn9y/TPTxBuER4YDKOB0lCUqdbx+j069
         LnJHoguPZoCMvBdCsOGggQOn3qS89xuJ7hEC/xekATzqR/OVy2bb1EuWmA0WOiBwRjeq
         hYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897976; x=1756502776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RYDPV0uYiAvqyhiIKkPSxK3HYqExYDiY91NCb6FZc=;
        b=SDM4mfLoqutcGudva7OwSjE5x+Y7rWRvxlDZzY8TwFrzYzJfhQYJVDY3B3LjjCKzsw
         iE9Dvma45a0ZMIsCfpjWzSd2KFU6dGqEcd8hS2hisnprIgNYGRgDpSn6qIJDND2yVr/u
         cvohURUvUCEB+EE7imj8gNe1xRfOCxLt3PtGxS0lGUZl8z6ti6pkn424Wfnrl6Q84HB7
         WhjEpuU6EMXa0WFn6btx9/YnyXXsA34gw7wt4cLlDgsrldogvzu1zH2tipg/cRVabasx
         4OlpLkE7q0Lekh4zYEyJNewL8dpjNvGoXN7pfpAJmIigDh1QdCUeP8k7be/MZHZ/aj5h
         0tAA==
X-Forwarded-Encrypted: i=1; AJvYcCV3vrkpds++FjWHMn5umyR6fa4m0/IxauMcDCzgxP7ESRV94uqU8AWC2Bp9UbsYjwDEPFNzDikZaqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kTY4vTff9MMU/3/RWyk3Mfilx3KAZGqVMivxDOicYX148Q7o
	LVSpioqstsdhMe/CBp276prRvZwWmA7koC0SwnSQhfVmO1mCkGMwqiC37q9uOgKlnEH9uMR4opV
	v+vG6Ifm5rr5PeQ==
X-Google-Smtp-Source: AGHT+IEVFhT7DHWStdC9kWfQfile+sl8WT42pZdXQ3bGNOUKp45LZ+2E5stBhJBh1E/Xl0jGvCg0aJDdG3u/ng==
X-Received: from pjl3.prod.google.com ([2002:a17:90b:2f83:b0:31c:4a51:8b75])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2349:b0:246:5488:5df0 with SMTP id d9443c01a7336-246548871ffmr25789605ad.44.1755897975809;
 Fri, 22 Aug 2025 14:26:15 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:52 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-6-dmatlack@google.com>
Subject: [PATCH v2 05/30] vfio: selftests: Move vfio dma mapping test to their
 own file
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

From: Josh Hilke <jrhilke@google.com>

Move the dma_map_unmap test from vfio_pci_device_test to a new test:
vfio_dma_mapping_test. We are going to add more complex dma mapping
tests, so it makes sense to separate this from the vfio pci device
test which is more of a sanity check for vfio pci functionality.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_dma_mapping_test.c    | 51 +++++++++++++++++++
 .../selftests/vfio/vfio_pci_device_test.c     | 18 -------
 3 files changed, 52 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e4a5d6eadff3..05c5a585cca6 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 include ../lib.mk
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
new file mode 100644
index 000000000000..b56cebbf97eb
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_dma_mapping_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_dma_mapping_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_test)
+{
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_dma_mapping_test, dma_map_unmap)
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
+	ASSERT_TRUE(!munmap(mem, size));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 3e7049b9c8f6..a2e41398d184 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -36,24 +36,6 @@ FIXTURE_TEARDOWN(vfio_pci_device_test)
 	vfio_pci_device_cleanup(self->device);
 }
 
-TEST_F(vfio_pci_device_test, dma_map_unmap)
-{
-	const u64 size = SZ_2M;
-	void *mem;
-	u64 iova;
-
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
-
-	iova = (u64)mem;
-
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
-	vfio_pci_dma_unmap(self->device, iova, size);
-
-	ASSERT_TRUE(!munmap(mem, SZ_2M));
-}
-
 #define read_pci_id_from_sysfs(_file) ({							\
 	char __sysfs_path[PATH_MAX];								\
 	char __buf[32];										\
-- 
2.51.0.rc2.233.g662b1ed5c5-goog



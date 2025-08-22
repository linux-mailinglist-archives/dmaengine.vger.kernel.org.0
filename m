Return-Path: <dmaengine+bounces-6137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB59BB32443
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AF31D6366C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3B343D91;
	Fri, 22 Aug 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBHeBFx5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A36343215
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897981; cv=none; b=tKC0O5WUayMYk9pembf/cT7X11ZykDBajWV6FQpUKqT8ib/SRv7AWhHq2ycoc0RoDYzHuIKNIbzqbDWSIZToT4koTx90/SCyRSqf6kJV1quduFpiD1ioVIUioi1KLKkEUcWYE6ovP6EL6+amzH/JZuHvemj0PDIZgL0tryoKTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897981; c=relaxed/simple;
	bh=sMBil33kEP0p72RsUquWHWpa11BvknJzVAjPDsLGcAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OaBfJhF9Pc6zBcW1HNjjuAkHYIefipQShYpRmEJmKVcEw/m5HJjbVZQu75Yw28+mKjZn30dMOzQNL0PxwsIUosqI/VLuoENklH5vQal/xiI7WAwUKu+XbZJZlNqPqHVi+Ev5hE7KWc4MHICXqUjzqR3yhn5j4CsPivqboPVX0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBHeBFx5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e8b4ab7so2307041b3a.1
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897979; x=1756502779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNSc8pwOi0iqwicPsbzu5iOCe1/x4uOTBWnOJx+bas0=;
        b=FBHeBFx5T6lPciEChT04zssWZ6raAERhr0LCkYQBwrsAiIjQm5v6HmAOgM7+XVwDkD
         t9vhEKig3a4xBM6v1pdGfXwFNAyiBC5KFnpmgwIvYCQWN/wzy9FEuET3b6DDOwiyFzhV
         m8P/xaOpdWCMiLQ86c+8r9slmIVAWlOcEUAtnT4WR8SRfhHuB2yZxMqxPl5lGHbKMKLl
         2iLLUw3DckIifJm+d/M2EtUn59djTmwh8IXx3A2VBCGG4t5L9XLv59hVGcePVNsMaJB4
         cMDm1ha8RL3/3QQvkaDQo1jA1zH04QUIYEItGBRW4Gez52SL4AxTmMySX5POZTbHQ0fr
         2nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897979; x=1756502779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNSc8pwOi0iqwicPsbzu5iOCe1/x4uOTBWnOJx+bas0=;
        b=tC/dgurMFP8jjmTEFn6+T99r96LhtR40BkD3vbPxULuMiSN7e+6USbZBRpmg7cNa0T
         eXn5Cz9NY10H76Eet3eQwWIoNelojTvNEC/lK9odanmTnupc9E1dj5gs05sJrVL+uFBJ
         6k7yA1VFThSE6i+/xIPdHJ9pmg1BIQ3owPl+OTvFpBVRXVOgFSULis9yRZoFETynDR7R
         UY+UxqDl4MHH25g0ENJslbE3DAQAPVsTcoJRNnpjIgVTUOqwsrDC8LofeBLEfxQMRg1A
         p8a8mMM22W1b1SbsGQ1QJSGDCLW9B5LeJqzD37+rSvDin4bDbWMSAEBvVfYZPH580F9c
         mJbw==
X-Forwarded-Encrypted: i=1; AJvYcCUqb/toLzbm6F92qOalQ0Tkt5+5/16qIYS2SDEVb6A4nmD8YDy+5FcFL0fBjQbmoE7p5J3+ZZqe6lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSrZmvus4lM7/zbF8KDkzKd+JP28u5N4roFT1tfmwDSytOIuA
	Ybh2qr3AuRbK8uVHdRejwQVligbHTfq5zSYU91oIOYRRbCdLXx5vBdYcMnNLS6jaeliuUfAY0Wu
	aiTpJmTVStrVS8Q==
X-Google-Smtp-Source: AGHT+IFn/CDahDRmuxUdDN7e34jUojyZdA5OMHuul/gVBglae1u1FQW/KHvUA6Y4zqwKNx7L4oUVRZKvWUqifw==
X-Received: from pfxa28.prod.google.com ([2002:a05:6a00:1d1c:b0:748:f98a:d97b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:420d:b0:770:34eb:1d38 with SMTP id d2e1a72fcca58-77034eb2007mr4306407b3a.3.1755897978799;
 Fri, 22 Aug 2025 14:26:18 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:54 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-8-dmatlack@google.com>
Subject: [PATCH v2 07/30] vfio: selftests: Add DMA mapping tests for 2M and 1G HugeTLB
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

Add test coverage of mapping 2M and 1G HugeTLB to vfio_dma_mapping_test
using a fixture variant. If there isn't enough HugeTLB memory available
for the test, just skip them.

Signed-off-by: Josh Hilke <jrhilke@google.com>
[switch from command line option to fixture variant]
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/vfio_dma_mapping_test.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index b56cebbf97eb..8f8e6e9e8197 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <fcntl.h>
-
+#include <stdio.h>
 #include <sys/mman.h>
+#include <unistd.h>
 
+#include <linux/limits.h>
+#include <linux/mman.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
@@ -16,6 +18,25 @@ FIXTURE(vfio_dma_mapping_test) {
 	struct vfio_pci_device *device;
 };
 
+FIXTURE_VARIANT(vfio_dma_mapping_test) {
+	u64 size;
+	int mmap_flags;
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous) {
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_2mb) {
+	.size = SZ_2M,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_2MB,
+};
+
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
+	.size = SZ_1G,
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_1GB,
+};
+
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
@@ -28,17 +49,24 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_test)
 
 TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 {
-	const u64 size = SZ_2M;
+	const u64 size = variant->size ?: getpagesize();
+	const int flags = variant->mmap_flags;
 	void *mem;
 	u64 iova;
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (flags & MAP_HUGETLB && mem == MAP_FAILED)
+		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(mem, MAP_FAILED);
 
 	iova = (u64)mem;
 
 	vfio_pci_dma_map(self->device, iova, size, mem);
 	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+
 	vfio_pci_dma_unmap(self->device, iova, size);
 
 	ASSERT_TRUE(!munmap(mem, size));
-- 
2.51.0.rc2.233.g662b1ed5c5-goog



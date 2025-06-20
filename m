Return-Path: <dmaengine+bounces-5574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909AAE265C
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763911890DAC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4C255E23;
	Fri, 20 Jun 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrQS8hkK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7A255E30
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461705; cv=none; b=FIcjq+JWF9Vef61pvjIF5e3UrrYvGdxgBoUCibTcQ4xcf7D1i1zmO6JQJJihVBImtJeY3gtz9GfKY1ubknOlFTNoSeEJLdoDwwWx54VsxyFY4Tq/8QiCGDZ6S+lSHfSdJ44G53sUV1VyRMudech69plBnsNTAho6kKBTZiXKr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461705; c=relaxed/simple;
	bh=CSyQPFUHAlDGVzgOyzCSraaqw2INKk4YMjO9iVwMl5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/G4W0gfIywfvEilaNFmWH9tKP5HGHyc/gqCkMwP4Jj3BzdYVXpZMAIZSVNPRRfTrqABhkmxOcJ6+6OXdF/TGRMdRhRHNvd+1TG7VXKBqDSeUCtT7TF0REjaMVZdUsv4SLJ669snlRbQSDVTv6uEm6SKbk7wu8qcMO+fZOMyvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrQS8hkK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso1992592a91.1
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461703; x=1751066503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ0iOxOfW3dcm2yM/JYcuEkC22RFXZbbBe2zYFPW3yg=;
        b=LrQS8hkKVHh/pYSMz9GbG+ObNA9e13f9aPdJ0EBfA6JfHPfLfGQJAWhK5TD2vI2AzN
         kLbfLwHa/ZoeXE4zGKRG9cA8XES8dDvvPKeIyoctFRfUtxMuYbZdsHzQIGh3TCXUrFY4
         NnFp0TA0G5KUDvZimxdThxnnX2UXBzbFJ2aWGomcJPydZ/aqpFDNY93CGrbs2hzdymDd
         EuNrMrDAyDGT6oWUDx7Auxj/Z2vlPM7+63a2kqAJpqUotHNbkb6r5ajJR2gqNT/BWFL2
         97607BDX9SgaUkbLiASQ4tK85wjRFhc04p0/foLbVxPnOF5TX7pDbU0lU74B4tNJ9qIq
         T5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461703; x=1751066503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ0iOxOfW3dcm2yM/JYcuEkC22RFXZbbBe2zYFPW3yg=;
        b=ErGA56AN00QEjFF4eGt5GHt8U5Rrlk8mIMBYh6jYaUqV/tjeNUVx5zY6es4J6RiQxv
         m2Uz05vxrysjyCHAaPZMqRfW+EJym93d5OPWnlqxufwdb9mEUwSD8fwP8IGMT3Jl+V9j
         OamRonrSlrF9c2N07qctMF+T16NUftR/ZqSCoLDssH4hWv6ZlqbWP35aVvHvoiew2eg9
         Q6n1eOxoX7AIV/PExiJoajjmb/JnQ1AtH12rngau4CeeRIUyqIGH5JvVMi190g2UswF8
         n1D4sVxqr+2bc/GHVXMJsYMS14O7InrfWzjIcQu5Z903h/HrbNsNiOIoB4zoec4F9VMD
         3Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCW0zrvjFwrfvQ7+J1/dTxqLRyIKZ98xulOUVmNH44C1xxZdRDXih5l2rO8i+EEPuyFY1vAe7Dmz0DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9dTbbK34WBXdm7GDKgnR9dXMBdnUdpOGhaSmkWdxc+2v5Erj
	RAdG1RA5jaDutemwJ+UL1K2+beGeWJ6VXMvrPYHsDAYLWXmBX87Hv1Rr1aF2Htgv+9oF544ctQv
	HbvimOXJwG27ySw==
X-Google-Smtp-Source: AGHT+IGdtBi2TnS6cO5AiphX5I+EdWZmfOtRc+oZTDmEr7kP7U5sygovoW4WD5avZQy9LCfweVp1tLPI+I1Rng==
X-Received: from pjbsi5.prod.google.com ([2002:a17:90b:5285:b0:2ff:84e6:b2bd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a92:b0:311:fde5:e225 with SMTP id 98e67ed59e1d1-3159d64a738mr8003936a91.14.1750461703245;
 Fri, 20 Jun 2025 16:21:43 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:25 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-28-dmatlack@google.com>
Subject: [PATCH 27/33] vfio: selftests: Add iommufd_compat_type1{,v2} modes
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

Add new IOMMU modes for using iommufd in compatibility mode with
VFIO_TYPE1_IOMMU and VFIO_TYPE1v2_IOMMU.

In these modes, VFIO selftests will open /dev/iommu and treats it as a
container FD (as if it had opened /dev/vfio/vfio) and the kernel
translates the container ioctls to iommufd calls transparently.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h |  4 +++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 10 ++++++++++
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 12 ++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 981ddc9a52a9..035ef5b9d678 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -60,7 +60,9 @@ struct vfio_iommu_mode {
  */
 #define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__)
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__)
 
 struct vfio_pci_bar {
 	struct vfio_region_info info;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index cc1b732dd8ba..b6fefe2b3ec8 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -376,6 +376,16 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
+	{
+		.name = "iommufd_compat_type1",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1_IOMMU,
+	},
+	{
+		.name = "iommufd_compat_type1v2",
+		.container_path = "/dev/iommu",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index ffaf941ede39..2cc4ac71104c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -128,6 +128,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	const int flags = variant->mmap_flags;
 	struct vfio_dma_region region;
 	struct iommu_mapping mapping;
+	u64 mapping_size = size;
 	const u64 iova = 0;
 	int rc;
 
@@ -150,6 +151,13 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	if (rc == -EOPNOTSUPP)
 		goto unmap;
 
+	/*
+	 * IOMMUFD compatibility-mode does not support huge mappings when
+	 * using VFIO_TYPE1_IOMMU.
+	 */
+	if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
+		mapping_size = SZ_4K;
+
 	ASSERT_EQ(0, rc);
 	printf("Found IOMMU mappings for IOVA 0x%lx:\n", iova);
 	printf("PGD: 0x%016lx\n", mapping.pgd);
@@ -158,7 +166,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	printf("PMD: 0x%016lx\n", mapping.pmd);
 	printf("PTE: 0x%016lx\n", mapping.pte);
 
-	switch (size) {
+	switch (mapping_size) {
 	case SZ_4K:
 		ASSERT_NE(0, mapping.pte);
 		break;
@@ -172,7 +180,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 		ASSERT_NE(0, mapping.pud);
 		break;
 	default:
-		VFIO_FAIL("Unrecognized size: 0x%lx\n", size);
+		VFIO_FAIL("Unrecognized size: 0x%lx\n", mapping_size);
 	}
 
 unmap:
-- 
2.50.0.rc2.701.gf1e915cc24-goog



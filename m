Return-Path: <dmaengine+bounces-6155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF22B32472
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE3B622E64
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AB0350D75;
	Fri, 22 Aug 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLxiLW92"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F9350D4D
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898007; cv=none; b=i6mY4nq2Un9AHPhijkCf5XogNxDh3123eVtOk+u1DD0mOiVGR6t7np01KauS8+mftu9QPAQLq8qFxXnnGpm0Tizd20o93lNQZ3210v7DHQ2Vwhgpj8sO82HqlO6lWgBMVOea4nAoqlCFmIRZVL56deD52kVQAuEIdRXBDS/Ka4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898007; c=relaxed/simple;
	bh=9hnBbxgoyyyfgGwjq+xSkSPvVZ68AmuFFHElBIq5wTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ER47hW/Sp+ilv7NoAcgm18HJ5gx5g4p1lASkZjmFD5Lj/FuOvAnM21fsm3JzV6f6Zel0IElLG6iDgWc9Ic3n5NP4LcjIMbPX3vCnOMy1dAdTvPtgrK/hk1JvAPiOhzRHcTSq2gdPNHxeJQfbtM8Ons+BoWc1oQj4pnEjM0xoVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLxiLW92; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174c8fd2so3993979a12.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898006; x=1756502806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/yaIzU2QpXvAWW2OjGw4oY6biAviRGUbHbcV8PB4r6M=;
        b=wLxiLW92zL7FKDLF2XB7NCjmGOpGyFhEYs1nvEtNmQIoFPCCqkwJT2tFtHS9dQ0OEO
         t+Ihv2At0CJMYxgEwjfib5Q7GUu77xBbnUurKaM3aYqiujQb2CKBb6wGSZyD5bL5KPen
         svlJGpVf96i/Kp4BJGy92LHZcaUEK2BjWqn5jLFm7k3DaOG1tvgbnRuloC8Bac/U+p72
         uNBFaGF0AaBN6MslA8NbS1jEjwNGHgj7taGn8XaWVtkVL0RxaBnB8dQGYYtnPsfovoo4
         N7qB373hykMetoFdOV7nPoVOzCJgwTQUplUyXgpgHEENm6hkKN4ewpDe6/+UY+AoO7DL
         +n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898006; x=1756502806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yaIzU2QpXvAWW2OjGw4oY6biAviRGUbHbcV8PB4r6M=;
        b=nsmWhcNQlEgn9M5wSTwpObXtsOhKleIKHpP53NcSP1Bnvuv9ZcEYVP50EPsejbYjcT
         QMhfNl71Wawhl51gCpOFlmZMgtadrYSqWe9ZlJQA3hAmzJmzYEJh3QskmejCDDuSUN0/
         bT3bTvk5DsmvcI1PQZrpxKvKb+B0/aHyo84c8hNzOUvBi4348iiBz0pR0AGBbzO86iWm
         06ADQP2JPoKs7iADxgo96TkRbRBKtKN3j3dTCdF4qLyYn1BgnXdG24dTgSfFa5WUcjEa
         JJ5OE/Nspn2JOREiNvkf9lRX6VMpKX4m2tkwIEKMiuK6vHSGQqjbo69ZF5ZaoIAV+BLR
         clUA==
X-Forwarded-Encrypted: i=1; AJvYcCWeTIfbNa85rAA4P6ZJ1He1W4sOEuhYcdlGdJYYyUgbHJBcL+fTClvQk+IO85za7eiSUuPrr3ZTuYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEs7AsY1xlivSowo/lddsBHy009K+ENw0cNvpIBoAa2ycDEMGy
	nArR2F+Auc3tFyweiEyfmgpgXd8Gav0GaQ9XmervqCFh7tP4W1BBN72X4AbPJay3qwOpcVfWbaS
	E1RMeL7/HGWhBtQ==
X-Google-Smtp-Source: AGHT+IEwm9+1p5obadsZK9Bi8St2rkEpqxnOex2o11eFyVZOkrjzOVolMFofvvH8d8AAQiz7oyA1jLphggD/bQ==
X-Received: from pjjz30.prod.google.com ([2002:a17:90a:6d21:b0:325:4ab8:8fb8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:339e:b0:238:e4d8:2bba with SMTP id adf61e73a8af0-24340d15c6amr6562944637.35.1755898005896;
 Fri, 22 Aug 2025 14:26:45 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:12 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-26-dmatlack@google.com>
Subject: [PATCH v2 25/30] vfio: selftests: Replicate tests across all iommu_modes
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

Automatically replicate vfio_dma_mapping_test and vfio_pci_driver_test
across all supported IOMMU modes using fixture variants. Both of these
tests exercise DMA mapping to some degree so having automatic coverage
across all IOMMU modes will help catch bugs.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  8 +++++++
 .../selftests/vfio/lib/vfio_pci_device.c      |  1 +
 .../selftests/vfio/vfio_dma_mapping_test.c    | 24 +++++++++----------
 .../selftests/vfio/vfio_pci_driver_test.c     | 13 +++++++++-
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index d50debd84813..bf0b636a9c0c 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -53,6 +53,14 @@ struct vfio_iommu_mode {
 	unsigned long iommu_type;
 };
 
+/*
+ * Generator for VFIO selftests fixture variants that replicate across all
+ * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
+ * which should then use FIXTURE_VARIANT_ADD() to create the variant.
+ */
+#define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__)
+
 struct vfio_pci_bar {
 	struct vfio_region_info info;
 	void *vaddr;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 15e5adb770c3..5c4d008f2a25 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -364,6 +364,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
+/* Reminder: Keep in sync with FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(). */
 static const struct vfio_iommu_mode iommu_modes[] = {
 	{
 		.name = "vfio_type1_iommu",
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index f07bdb602422..b65949c6b846 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -96,27 +96,25 @@ FIXTURE(vfio_dma_mapping_test) {
 };
 
 FIXTURE_VARIANT(vfio_dma_mapping_test) {
+	const char *iommu_mode;
 	u64 size;
 	int mmap_flags;
 };
 
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous) {
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE,
-};
-
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_2mb) {
-	.size = SZ_2M,
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_2MB,
-};
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _size, _mmap_flags) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, _iommu_mode ## _ ## _name) {	       \
+	.iommu_mode = #_iommu_mode,					       \
+	.size = (_size),						       \
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),	       \
+}
 
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, anonymous_hugetlb_1gb) {
-	.size = SZ_1G,
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_1GB,
-};
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0, 0);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
 }
 
 FIXTURE_TEARDOWN(vfio_dma_mapping_test)
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 14ec862c0b11..2dbd70b7db62 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -56,11 +56,22 @@ FIXTURE(vfio_pci_driver_test) {
 	iova_t unmapped_iova;
 };
 
+FIXTURE_VARIANT(vfio_pci_driver_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)		\
+FIXTURE_VARIANT_ADD(vfio_pci_driver_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,				\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
 FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
-	self->device = vfio_pci_device_init(device_bdf, default_iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
 
 	driver = &self->device->driver;
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog



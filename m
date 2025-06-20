Return-Path: <dmaengine+bounces-5573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA68AE2654
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8749A3BC107
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E65255E27;
	Fri, 20 Jun 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z7IOLNMn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4D2550BA
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461703; cv=none; b=B0DxxjJyIFy/DfU6oKxwGlOBc0/BaRtYgS4qG9A31dI1A0R2+I/CminxMOptlk+L8CeuKFNq7B+cKdTot/BpFyuF5salpetuG47JWk/1FY5uXGtBgpcNomt4tubkZJxauLVqTdGm5bKoTnLVpj4immCyatXL3b2tT1bSWOZ8kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461703; c=relaxed/simple;
	bh=8XUDtqf/7IQlsfIcfUe4Hmwyn5luqDMpgLWbMwlLRKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F13ffrKfnhbPLX1QzobhPNASnf2xh17HFc1majsxBwaG84k1pOD6Fm392EMDkzmaQHrD+cdiPALCUy8ldqgg+CYVIbwYtDSSa1enXs/vriDHg027r+Xkw1199NDoy4GTbCEejBvm6jDtRiSRI2bwCurJ0azdYSK7BcFdOKtZKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z7IOLNMn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747dd44048cso1898342b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461702; x=1751066502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESKw7WHnLO47vHSoG9Q4OOa+SwDCVR3Bunm9HuTbYpA=;
        b=z7IOLNMn9pFwSvSD1Ic+uVBar96bUBlTwj1lvlMJmPKb/JRV2yPQCEdO1h30T/24lr
         EV4uFwpJ+kGseNff/UeuS7sAm2qBFnD3Z03XkXckfpdZBL1WFYut1HX8/cDHl9NLEvy2
         wLX/fky0Go8ijJojjvzoUvNqkYmHotRFQsOEfMnYEalPAmeRzhy+tzWdv5y4tp0N1DsA
         7Y7m+N+K4ny8trPJS2Oa/OpqiyutRJqi1UJJvRE5jNe89u3Vhv2hrWET3jFi4GnEyXwn
         oI617Ynegzx6PvBuzxGoD8BODUJ23VJrppB1sRWnNAJccNO/Qvsj9kCOsY8FyQHa+nKM
         DppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461702; x=1751066502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESKw7WHnLO47vHSoG9Q4OOa+SwDCVR3Bunm9HuTbYpA=;
        b=BNr37uDvMnrfGjy/g9GliP4L0FDGIsdRpoKTTyoqASn2WUjFPkfI7C73V6zB5E4j2H
         okVkwOYXHrur6oIJVMrjqCraV9R0fubUKZrA897I0rGWolnacNieORDoAetYl2sj3oua
         SnazcOwlhvDXkJLt/YXOIfZzx3mRHlnm+81r49GPTJayhXyVjp/n2bLI5kwxkQV5HCtD
         8woZnNnol9qmZMdjfp1J45rUrU1BOxpmg2hYZXTOes3YVvWB+1ZLC3NrBuxV3eH67pJW
         akfJy3mugff3Gni0OU9p8EEuH9wY/e7doE/8tRDPnhNP7qURoWNzwX4qYESx/vHnwXRb
         lBJg==
X-Forwarded-Encrypted: i=1; AJvYcCX+w07f+RGE+j+yB36CrJs7g4LOvQNZmsYmFgwmGYiXdAPR1J/1MKI2tSAh4hB/O53nrwvi5puOd0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJc63N9QksGebpCAP1wgqPFmK9xt9tsX0cu/9fQWpoxy7WRtz
	EnjjKyk7tobtdHq5aWvIuhb0fB4KWwWX6B4WrPCmBKp5kD7wJ6dHkuWhEJ7vSipeW7JdF05y+jf
	WCgCzmeZLLoDunQ==
X-Google-Smtp-Source: AGHT+IE2CsPx8OfG7aqkpvzGfrprbaldlIQyullZcxFEwiZOgm+XjdTJSon9Y52Faoq78klszsxOZpnM5lXhxQ==
X-Received: from pgbcq2.prod.google.com ([2002:a05:6a02:4082:b0:b2d:aac5:e874])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b82:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-22026e6036fmr7417947637.2.1750461701628;
 Fri, 20 Jun 2025 16:21:41 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:24 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-27-dmatlack@google.com>
Subject: [PATCH 26/33] vfio: selftests: Add vfio_type1v2_mode
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

Add a new IOMMU mode for using VFIO_TYPE1v2_IOMMU.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 3 ++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index bf0b636a9c0c..981ddc9a52a9 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -59,7 +59,8 @@ struct vfio_iommu_mode {
  * which should then use FIXTURE_VARIANT_ADD() to create the variant.
  */
 #define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
-FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__)
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__)
 
 struct vfio_pci_bar {
 	struct vfio_region_info info;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 5c4d008f2a25..cc1b732dd8ba 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -371,6 +371,11 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/vfio/vfio",
 		.iommu_type = VFIO_TYPE1_IOMMU,
 	},
+	{
+		.name = "vfio_type1v2_iommu",
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
-- 
2.50.0.rc2.701.gf1e915cc24-goog



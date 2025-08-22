Return-Path: <dmaengine+bounces-6156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C10B32484
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34F1AA6AB2
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711435206C;
	Fri, 22 Aug 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPc1bKan"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EB350D73
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898010; cv=none; b=Sj2D17IDPlntBVqTuw8zMJtCJpIQDkemP6K3YtauaOSdUNegdUmDKGLkmSEXPw+iTeMdl8bHs8pyGq6R+i2qFTT1I9GjzxeTmCcZG7xNMa/9tMCBqwltdcxZqc1xgwpiYxejM7McIi1WTOinMSU+YIvR4c/Xuelr/VKtK89Z6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898010; c=relaxed/simple;
	bh=sh7MfRrAOZij7IDH3NzvhcBuoP2zKJwxaJk8P3oeD/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUrPZa850XYd+xqaeWrgxwAEpOkZqWOsyKbN6O6+pVwKa3p+HvlLD0XOBlzLlyW32FdpfsjhZnjXdkDfvMi4bNeqTGIYsfZilPe1UWtx9lcnZ2G+cMpyy4N7sphm+7gFkdgBiokLEmsPEDQoGunjHkuoEbkDbS5vd6M2MFpb4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPc1bKan; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso2876539a91.3
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898007; x=1756502807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=onZhjFNbqDI2Cp2ViRPMMzVX/q4pjThkfMtadERhvF4=;
        b=aPc1bKanVOq62l/fQH5toQmhdo4QMxQ+LV0Ca583o6H/3McAsYGaqDQKxAwxwlZMrN
         w9R+1lWp0KkRpkm3VOi/Yr8OxUoqdtNthbNH8OFYMbu6SEuJVKjuVyn1S67VgJRkcyex
         mh4IhCT/k6zknVw83cJb6RXimKETYMuGdgzbJq3yg9s1OXRh1gwzUN6Gz5JNAI6y2KDX
         cfmYV+0YFmU8B+gxgb+2JcvotCOWLzPTpC2xTnqnsNCvkgcSprwZaS1YUrC2Ya1/uzLF
         MusmUM4rSVB6jzn70Js1JYEZ1Rr8tSzLzkRh7z5wthP0h60GLd5V5jG+Jtlo8DlyFcJv
         Uznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898007; x=1756502807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onZhjFNbqDI2Cp2ViRPMMzVX/q4pjThkfMtadERhvF4=;
        b=qurJBoKgNThUS9g4YQz6J8ue5gk1G2jUN6qsYNC3RSFQDd7Lfdr2SRHAdMUUvJY1Eg
         suje2W3C0OLuybY8nlyCBIq1+dG5CWhshGqBgKilqbzPlavMfvACA1TQqxfwFT9u5y/e
         JPCTD6AUKGcS/jCXLol3enqp6i4JYRphC114jAgdXw7D2eUIJt4goDMCUyqdHxg6zrBt
         YIRlNf8iHOHNSkNWC3UujU77pMly3JzdMqJbyl4ZuTV3mvC0QI/Dt1YEgaikLjePpt/v
         xAj2NVZzF+Em4cDIQmQDAcq2r0bJS905wpcyHmEtSHQQsqQrLYKM6Za4PK0d8iXW/Z9y
         yWAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQTEGNA3zNnIgSo9XQnR1B3E+gEiwl4cSUtOsRo8Q04UWOaw8zUEQgO0rHP3mk2wyfm8LMldVVsKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTm9QBhmwtdHfvHmMRpH1MkJB3KR5znNADKKc9Xo4cZWY+C8d
	cxAHYPzFYDQO+4/Dox6TFVbyUr5S+9vNhd7neAao3iPWrDlFLn2aaCmtt8bk61Av7csj6C+mNxB
	gQoArKhpOlxX/Jw==
X-Google-Smtp-Source: AGHT+IG2yRIP4wJNDx+3ZhqjNdAXW3cdcOyWtXJFKmvuNvY8aZ9mLND9WX45Kkk+KjItBOJZMK/HD/nxpKXidA==
X-Received: from pjbpl15.prod.google.com ([2002:a17:90b:268f:b0:325:220a:dd41])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f88:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-32515e2b881mr5213233a91.2.1755898007294;
 Fri, 22 Aug 2025 14:26:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:13 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-27-dmatlack@google.com>
Subject: [PATCH v2 26/30] vfio: selftests: Add vfio_type1v2_mode
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

Add a new IOMMU mode for using VFIO_TYPE1v2_IOMMU.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.51.0.rc2.233.g662b1ed5c5-goog



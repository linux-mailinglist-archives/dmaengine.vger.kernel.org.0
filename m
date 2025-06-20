Return-Path: <dmaengine+bounces-5566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1559AE2644
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FD37A1A79
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70293253358;
	Fri, 20 Jun 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aV1RBJl+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9F2522A1
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461693; cv=none; b=cJz0+7cqr52mrKLaRWOudKX3YhmIMVUMzau8MDQV+qGneig74pldejACJo+qMC2AQqcgsaRt/utwU0ZpFDsFjgcKqKkOp/VkI+uOgIwlYi3ER2olFniTjIPfzcILMn1UyK1ioxWlAIbLCsF/XDJNBkHTNYW7TOd91i/uNA9/S+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461693; c=relaxed/simple;
	bh=2iMX2EMfHz/E7qCCKrLmyjamrHZOVNZpooDdsA75v/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q7ZApRqNCewoQia1nDgdkKSdRE0pYy/ZIs9kRNyl+NQPpSzHVBAVoOhyZag+Vg79s9/H9adGxsv4U2KT3YBENEMEmxCQJFdwGWI1QPBMsoCZMS4/rh/iLO0ItRmphYqVP3ve6reEyajFFtxZn8viqEDczn0xme6Hx0y7XRivN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aV1RBJl+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1829600a91.0
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461691; x=1751066491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDg+qHoVlPnnqgAQ0XZTNIaLoYeEDVAQBDodGwbZSRw=;
        b=aV1RBJl+9uj0T5J+L+LZZJpwqmf/P07LmpXzI1mydtUGwpuxMs8DE/XoTgESKZnFG3
         l0N4tQqIKEBPpe6YbMGXvQOqse/Ex+1h0CgOGf+vWYMr4nIi4jpwo4V2brJ00kyQg5Ej
         BVbx7V/tELzxsT52py5Y4HXilrbY8iqcM518LzDBmjCVRaWCq64N4iedF5pbGmUhcwow
         /IvK2Uncm2EiF3wEgfCy/6tthGnrqAEP5DvJtyhlf6CU/w4/BzkH0GRgV9Ow9syk/CzA
         MHV0fO82nAaJKlA/M69zMntDolslvPc2lXLJuLKMbzGJsg7i5MVym+/8GmawRIi4cyOK
         DDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461691; x=1751066491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDg+qHoVlPnnqgAQ0XZTNIaLoYeEDVAQBDodGwbZSRw=;
        b=wIT1AoTCfvBOX+knWAkEUVdgSovpOuZsmSmHolhsx57Ag6Zu4TppjCOm328BwK9Wl3
         iQ2iz5SBlRSYKreK4RN77+j/UqaNLA2paeBOD8tHEcLdxDxjliNSNDMK5hQ4ytigAfUu
         N0esTzwWLTYBiPq6pxFRLcjseJFHbeJNe/89hXSAMEt9L1mD8rNtMkWsTjF4WFsMxqRl
         EbgCVCcPTyP97bhcll7jPl7Q/9u14cQ9McNZAIbpq/nLzxV9BfHgsvQRIWRIx2ZJE/CI
         CLcEQEGn5UCUrXmBOHxNjlpJfknf4F5RGax7wVFj7vdXT84p43pMY5H94cxcrttAWd3x
         eOFA==
X-Forwarded-Encrypted: i=1; AJvYcCUaFjAL4m0WfNFGpSqZ1N6ibg2lGJq3ObsZnSHXLmRruYi+cypE+se5fe5q7G92a1DlnQFIE9arMus=@vger.kernel.org
X-Gm-Message-State: AOJu0YznHcl2EWWogizaihaeWIVXQ0XlaBvadcScdyK1IDkhVeoyDc/r
	pO0rvwTVs9cNOBfL1h02pmxDMMcxcE4inrG0dc0HcZc+/jbY241MUZPTn1aGolD10ihxwHOc4to
	GBCt9ngqfjGS5+w==
X-Google-Smtp-Source: AGHT+IFs43C2ej04kH8n8aRCsH/Wg82cBZjuZGu7XW2GRQz/tLx/zBFRtVXqtoqimRRtTluqznEhBJLUzTTNiw==
X-Received: from pjbpd10.prod.google.com ([2002:a17:90b:1dca:b0:311:e9bb:f8d4])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0d:b0:311:9c9a:58c5 with SMTP id 98e67ed59e1d1-3159d643c15mr8903110a91.12.1750461691436;
 Fri, 20 Jun 2025 16:21:31 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:17 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-20-dmatlack@google.com>
Subject: [PATCH 19/33] dmaengine: ioat: Move system_has_dca_enabled() to dma.h
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

Move the function prototype for system_has_dca_enabled() from hw.h to
dma.h. This allows hw.h to be included from tools/, which will be used
in a subsysequent commit to implement a userspace driver for Intel CBDMA
devices in tools/testing/selftests/vfio.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/dma/ioat/dma.h | 2 ++
 drivers/dma/ioat/hw.h  | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index a180171087a8..12a4a4860a74 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -19,6 +19,8 @@
 
 #define IOAT_DMA_DCA_ANY_CPU		~0
 
+int system_has_dca_enabled(struct pci_dev *pdev);
+
 #define to_ioatdma_device(dev) container_of(dev, struct ioatdma_device, dma_dev)
 #define to_dev(ioat_chan) (&(ioat_chan)->ioat_dma->pdev->dev)
 #define to_pdev(ioat_chan) ((ioat_chan)->ioat_dma->pdev)
diff --git a/drivers/dma/ioat/hw.h b/drivers/dma/ioat/hw.h
index 79e4e4c09c18..0373c48520c9 100644
--- a/drivers/dma/ioat/hw.h
+++ b/drivers/dma/ioat/hw.h
@@ -63,9 +63,6 @@
 #define IOAT_VER_3_3            0x33    /* Version 3.3 */
 #define IOAT_VER_3_4		0x34	/* Version 3.4 */
 
-
-int system_has_dca_enabled(struct pci_dev *pdev);
-
 #define IOAT_DESC_SZ	64
 
 struct ioat_dma_descriptor {
-- 
2.50.0.rc2.701.gf1e915cc24-goog



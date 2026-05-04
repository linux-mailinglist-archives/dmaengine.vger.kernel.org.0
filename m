Return-Path: <dmaengine+bounces-10207-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK5cOGN0+Gk9vgIAu9opvQ
	(envelope-from <dmaengine+bounces-10207-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 12:26:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD744BBB2F
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC09B302BEBB
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C5439185A;
	Mon,  4 May 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="AxO9ZPcw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49994391E76
	for <dmaengine@vger.kernel.org>; Mon,  4 May 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890020; cv=none; b=c8KJBcBG1bYDc+RhlLK1BdVfdqlagWM9fAcbqke5Ze0LGo7QF60oUY4Eim7OTHeKL+nMwGKTXV/b8nDzxiZIWCn2gkzrIENbND2GYqtuEAZPUgAqydcOjmKr0Kgw84R4LYlXCgCmCKYVxdjTyA6v/K8QmCFzTHyHf73BY9ffn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890020; c=relaxed/simple;
	bh=s/6N5gB8DGjoEg4dSFAL94hJC0H4w9laOHrkxskMoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTLPcGJsaVFMnegJwuR/Yo7NuP+3eeoxwOeUED1lyBGsEb6Z98sA7KJ5saO4/47+Vr7pcjO0FaL5G+4leJIyhzIaOfZimdOTJuHEKaNkyz0qmiEdOLBAs6TMOd1jzVKorRJImH4oCuuvO9dypsYnb01XpmGtAqc2wmbzBH/jcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=AxO9ZPcw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso28287365e9.0
        for <dmaengine@vger.kernel.org>; Mon, 04 May 2026 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777890016; x=1778494816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyhQFJnZEJaCueKPpnDeICsuB1xZ0J96lBFz4FcGpak=;
        b=AxO9ZPcwBTLcHxDqPcG3peL+IOsqRkgTaNhGppgRrmS/A+EQOvMNduj0bKvLnxPF5S
         C06ZrDY74rVJ8bdJX7NTUsxfrXXNFfl0jOEeB3QgH1oEY+nLSVkkh9EbSxaM470Mp8S5
         8TupZIA8GSMaIeIB0NBvGJNIguW+1pIkcOI3ZDw/1gbMmn9tx2EYCF2AX5q1PFmxU2eW
         VtrwADYQgUCFpfaCo2WhiU/IA7wwhI6/Wf3hovcztWBBRTKIMo6ijR4hOEeWxsuTkCfj
         an4J4buz691gngoVWVEIL1Zlvz1IVBXcU0K7nkYpmb79MKVjbse27z4nUGkmOLo/ZoZk
         QIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890016; x=1778494816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyhQFJnZEJaCueKPpnDeICsuB1xZ0J96lBFz4FcGpak=;
        b=KUS+SaUjpOOrEmVETprBJEqbqOqbhodrjMtzNsOLLftlT7huPUcl54FHgZlS0Md9bi
         U+alfB0pGTXlMm4w9WIivOdk+Qu+o/SBAIgxIHFJsITCMjQlWYCV2CGnKTZ47hFC21wN
         WmqIsDFnoOPj2TvFKVHXMEgW8eMOv7DEY6MGCIHiGCX/iIV642eqEy8viX61fgp3pQOE
         I6zwLxRHsSmijUJVy8jXxTbF1EzvRvsyJsxuRGRHCa7OZmuFYU63edGad31RvEPUy3Em
         w0hjCrXAi+IwK8OHP+Cuf45n3vt45NoCNEAhP+3CUAPGABjEpO4fhPRW9fm0iFGmHCnZ
         kDHg==
X-Forwarded-Encrypted: i=1; AFNElJ/m9imQciA/G4MlOcN2b1VhfdK7w9eDTUGdzuTXNSxY5UC0rYU3lrwUKfDZWdQaaUQ5z3pBqV+L8tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKCTXYxqjfo78FEzL5WQ/J2helgLcYqu4oIzeB1ffN+u8ZO82
	oYp0ot7hBhKI4JpHryBR+HfjElCppSnbKof3TYAMU57bRpnualbOBlfOGdjfl4h1eS0R/pE++Qg
	DzMYM
X-Gm-Gg: AeBDieuLE3koeiGj2EhLUAehOQEFim/K7zSE0FuElXgo+Sa86SDmMLNnvh3gjQeIXLh
	pT5Wf3kTb88CdBU2DMNeDH8gaI+lFo055TkWnVD6pC6cIpKjrNrhJQNWedq4z5PzigDjM5OqDLn
	4SdsQkReQqdwofR0RUCtvLRzmrsClmbTDTJZx8Ifp6djsErDiRT54a6bY3tS886P0zlBzQzinB0
	zZEhavrBobHOq1qalVRIv+NbxNnUYszWU/78xr2VP1QV9CZvnIqfjfLcY6ZYKXPPTgxqTrqFrgO
	HHHqsk3ZcUtW+4/UEwrMmu2G9CTW3RhKxiyZcpg8ibHTuj9neKp9Vk9peqpAs36s6Y84jKqnIyp
	5mPjlE+3SdDeRBEcWYnCBB/APqp/GPbUSYgVZlc4V4u6BvTn6bMDfmADTUCcO80nujrHftFSoGp
	Dqa7L2LKJ1jz1Y9AozpLfa0Tp4FdmJaKrsTiRyuFt3rC/QZyNOOTdJit8WTJkWp1GrAkacLM912
	2FXgonnfmyQw/0XWew7AbaTeg==
X-Received: by 2002:a05:600c:6215:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48a988a9c49mr134437975e9.5.1777890015677;
        Mon, 04 May 2026 03:20:15 -0700 (PDT)
Received: from localhost (p200300f65f114e08f5a4175dadf07882.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:f5a4:175d:adf0:7882])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a81ed6bafsm561197875e9.2.2026.05.04.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:20:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: Consistently define pci_device_ids using named initializers
Date: Mon,  4 May 2026 12:20:06 +0200
Message-ID: <20260504102008.1996139-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7943; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=s/6N5gB8DGjoEg4dSFAL94hJC0H4w9laOHrkxskMoWo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+HLYOV/ZyjERRcweUg8Jts3cQoG6txIhaCre1 PXO8S/4u0yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafhy2AAKCRCPgPtYfRL+ TqAjB/sG9YsoRP2CSPOdFBEX96+ohj/sPR1GMwrTKgvFhAjTZyfr3o/e3UPmIklNTsgx2Ur2/En tt48/dbTkPPuyHBnpRA8R0/LYdGRug8MrLLF0gMMh+DXlC14m+s/ioHmVhZC9eFlDXdVWsfGzC3 AEpVsoG7SwhVptQoNiS30y8hAWJzrOtCAOc/w/EvpWC4+4cBjTscTMfhANO2LAXMwo7wdvkNIpz GZxZirkhsWTrOddE2AVmk3uyo44Cq+hlteRQumYScKUixhZ6Nwkh1iEUOm0iV3zoAw2xFudRwNW yccaNoF4Zm3yZJr4cBatR6/mBPFEAiKUZtuMcBSPePuHvu7U
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CD744BBB2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10207-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]

The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse. Also skip explicit assignments of 0 (which the compiler then
takes care of).

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But it's also a nice cleanup on
its own.

The anonymous union will allow changes like the following:

-	{ PCI_VDEVICE(INTEL, 0x0827), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x0827), .driver_data_ptr = &dw_dma_chip_pdata },

(together with the respective change in the code when the value is
used).  This gets rid of a bunch of casts and thus slightly improving
type safety.

Best regards
Uwe
---
 drivers/dma/amd/ptdma/ptdma-pci.c  |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c |  2 +-
 drivers/dma/dw/pci.c               | 22 +++++++++++-----------
 drivers/dma/hsu/pci.c              |  4 ++--
 drivers/dma/pch_dma.c              | 26 +++++++++++++-------------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/ptdma-pci.c
index 22739ff0c3c5..0b226bec950c 100644
--- a/drivers/dma/amd/ptdma/ptdma-pci.c
+++ b/drivers/dma/amd/ptdma/ptdma-pci.c
@@ -223,9 +223,9 @@ static const struct pt_dev_vdata dev_vdata[] = {
 };
 
 static const struct pci_device_id pt_pci_table[] = {
-	{ PCI_VDEVICE(AMD, 0x1498), (kernel_ulong_t)&dev_vdata[0] },
+	{ PCI_VDEVICE(AMD, 0x1498), .driver_data = (kernel_ulong_t)&dev_vdata[0] },
 	/* Last entry must be zero */
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pt_pci_table);
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..6c589d8b46e1 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -546,7 +546,7 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
-	  (kernel_ulong_t)&xilinx_mdb_data },
+	  .driver_data = (kernel_ulong_t)&xilinx_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index a3aae3d1c093..99565fab3565 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -98,29 +98,29 @@ static const struct dev_pm_ops dw_pci_dev_pm_ops = {
 
 static const struct pci_device_id dw_pci_id_table[] = {
 	/* Medfield (GPDMA) */
-	{ PCI_VDEVICE(INTEL, 0x0827), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x0827), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* BayTrail */
-	{ PCI_VDEVICE(INTEL, 0x0f06), (kernel_ulong_t)&dw_dma_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x0f40), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x0f06), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x0f40), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Merrifield */
-	{ PCI_VDEVICE(INTEL, 0x11a2), (kernel_ulong_t)&idma32_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x11a2), .driver_data = (kernel_ulong_t)&idma32_chip_pdata },
 
 	/* Braswell */
-	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_dma_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x2286), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x22c0), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
-	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&xbar_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&xbar_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&xbar_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb4), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb5), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb6), .driver_data = (kernel_ulong_t)&xbar_chip_pdata },
 
 	/* Haswell */
-	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x9c60), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Broadwell */
-	{ PCI_VDEVICE(INTEL, 0x9ce0), (kernel_ulong_t)&dw_dma_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x9ce0), .driver_data = (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	{ }
 };
diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 0fcc0c0c22fc..b42c9c0887a8 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -116,8 +116,8 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id hsu_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA), 0 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA), 0 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MFLD_HSU_DMA) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, hsu_pci_id_table);
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index e9fbfd5a3d51..0ecc10b9288d 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -956,19 +956,19 @@ static void pch_dma_remove(struct pci_dev *pdev)
 #define PCI_DEVICE_ID_ML7831_DMA2_4CH	0x8815
 
 static const struct pci_device_id pch_dma_id_table[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
-	{ 0, },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data = 8 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data = 8 },		/* UART Video */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data = 8 },		/* PCMIF SPI */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data = 4 },		/* FPGA */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data = 12 },	/* I2S */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data = 4 },		/* UART */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data = 4 },		/* Video SPI */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data = 4 },		/* Security */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data = 4 },		/* FPGA */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data = 8 },		/* UART */
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data = 4 },		/* SPI */
+	{ },
 };
 
 static SIMPLE_DEV_PM_OPS(pch_dma_pm_ops, pch_dma_suspend, pch_dma_resume);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3



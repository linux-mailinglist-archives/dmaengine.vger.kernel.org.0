Return-Path: <dmaengine+bounces-11453-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w2xDGa1rKmphpAMAu9opvQ
	(envelope-from <dmaengine+bounces-11453-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:02:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B266FAAC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 10:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=m1cnFTyg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11453-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11453-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93FD7300EDB3
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A5376A11;
	Thu, 11 Jun 2026 08:02:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8036D50D
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 08:02:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164962; cv=none; b=YXuO4MpB2/OqlqxZSt7l7I+5V4eQw1RFDSdKwrgIOZfp6TUpU+IkHQ7uoON/ib0YKM2zRsgGzxROKdFzgpry2R3PRGHZmf9ysLg0k6NcTVyLDcisrA24eNlEd8UE5V8q4ERpV8MmwQs3RIMSP1En9oG9ty/fg7ERn/ajGtUNLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164962; c=relaxed/simple;
	bh=32fjIRogMQH/aBmCWgG/o8/J83kcEv+5aQPcPv8jg0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chv0BWLX2uk8PI0konZMkS8+9rM3957B+D2orFVhqkk0FRZE+tXlxM9PNoOtqo08bkk118W8JFlH85DUrGhjspgvBjaCBKLtlapdxXKYxxgx+yyFbcFH88RyOrVVBvZTB0GfBDUyay1nd0mtrBpOULQNAwpRq5be5LGLM/Qt86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=m1cnFTyg; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so66564135e9.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781164959; x=1781769759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLsOXu/PIA0Rqgf0caOViuMa3t911qJAiucle+LAS6c=;
        b=m1cnFTyg5kB59FBUuYYDLbRTN9kPm/1SHQnlz6GvQAV30HiLPziRx2ng1x1L/gpKc1
         gUWfFPtjymjl3WHYB2doQzO7BAxcIzYOQ3Np7dEbLNlBJpVpeJgb6QnpWnRAfsaGK0w+
         KCiCcEvmGL+0fFHFdtgBu9ii3l1DwfGieGB57kYMYj6n/visa7svIMXQdGuz5R4sGiYe
         xNDqSP60NFebLs08mKf3F9Q4eWsz/bNKcRnfSI6HHltfZttTZgfMPU2qygskpeQ/JLnm
         L9OAc/HkTbH2h1m6foftISzqwrK28zf4nrKTmJhUBtarWgQt56ERHfz56CzVgaYY5VUQ
         n95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164959; x=1781769759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLsOXu/PIA0Rqgf0caOViuMa3t911qJAiucle+LAS6c=;
        b=DwOZDnHBUI1ovr5ulSVGL0wgvJbi0zqxdX5CRXwMcFY2lQUMJ21e6JtrSAQiUBaAtE
         58de2LoECObNl5C1qLUOFh9waHnjfFYz4hVq4gIqCSV98XSdG2Ffq472EQRaPbDZMDwv
         LCoAdcMQekhaGhAN8P0qZxmCwXzHFFnlx6pZunH0K6Xfcqkaft1ziEX25mviYZydk7v2
         fV4QcgPZ7Dfrls7NN1MFO1WboIcnHsgyed0XbGDWQHTcWbWwQ5rapRgtiuPW0mTBhKSA
         hydWrekPfZZDeqjLHaxGvfdz5NVrbhFZgtq81kffzXNCV9JAE07neW6GApSieFrPltK9
         v3wg==
X-Forwarded-Encrypted: i=1; AFNElJ9/TSMhm+ZscDn7aDDZFZXQL0Yp132ifkkT00FqF6xwwHFXjRBNOXOtAQXw5UbNlZCrjiZCjCJ0fHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1bDi7AldpDz+TzrXXecOBCfQ5XNbLjOjnN9d47zjg/mahA2/
	YCD1iMjFtGval04QaYcfgzlI5bKBRrgcJDKzbW9qLdtt1XvA7/0ujpCsr9xCZVEfscY=
X-Gm-Gg: Acq92OHBz4TyJ9hesopN+gqCsWPeWv9aCVlZkuOEHV8r+UVu00G+RQx7OR2fvT8kFvZ
	7nr87WK8eqOSuUg6z/Fb00ji4XjJVKbXuu2KvodMiyoE387uUMcVN9Sm0VgkWtp/2gDiUZMKBmP
	nURF0I7esNRC/2dLpHkbaSVF6x9tqEgHYNDtgIfmyRTD8CEDGTltC93e+bAl1QD5e1iGTOLLAj2
	/iWfIP0bg/GHmxoKgoTvQEP53cBnsL0SH0OQ/e81iZ0puhu1GcUPLU521w6itNZ5cMwHlA0QRe0
	JtysjXJFKKFgYdSM7VQPUWFN8LP+5w+oBGro9z3bK8qb4tpXeNLFq2xH/dvgQ/09wv0u3eQOR5X
	PfUStqZzMJye01KtuwbylJkUP6a4jfp6pr1aQCEMp09e53EvhzKzVa1TCjbpEfn553eaG1VPXBY
	a9q13ku5Kl7rnFOVH92uDGr+nZ0bIqr5dnN9Vned8=
X-Received: by 2002:a05:600c:c108:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490e55f1eb6mr14922115e9.21.1781164958550;
        Thu, 11 Jun 2026 01:02:38 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490e47a8e85sm22883075e9.1.2026.06.11.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:02:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: Consistently define pci_device_ids using named initializers
Date: Thu, 11 Jun 2026 09:45:10 +0200
Message-ID:  <c355276dd152ef312c29f7b9758a68f94aa77086.1781161455.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781161455.git.ukleinek@kernel.org>
References: <cover.1781161455.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6615; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=32fjIRogMQH/aBmCWgG/o8/J83kcEv+5aQPcPv8jg0Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKmeKnX1O9Hkay7hEVI5fMabDKKW/NAKIRaKZw EcaoTuif6mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaipnigAKCRCPgPtYfRL+ TiemB/0aWWIyPSahgynklTbsAIcOZhrrUtfcfVHysAyCIQ2uAnMzUgCEmGqBacTLviRUuVXduTT HQu9PyjHVjJuMNezXXEPbY2Z3Pk9+q5+npOLg7gNCL5SV2J/d4sPqV+Y1KkcLbvOx4M8TksY86B jyxJAcDeJFDeSrK9HUkz4iltqgMqrgiNMauFT9TNsSZ8fL5Pax+faQmtryxkYhyMLNsp/Plf8yL ULS/x3gvamW3eISiR4M734Lln1TPp44Vr6ckCu6CNF3L6XY2pV1RFhIBqm+wFKMMSJzDnoMXKUP +kCgH/PPKnc7i8lUUNRm3fmILRr/8mnJ6MTept1oI11hNBaM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11453-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Basavaraj.Natikar@amd.com,m:vkoul@kernel.org,m:mani@kernel.org,m:vireshk@kernel.org,m:Frank.Li@kernel.org,m:andriy.shevchenko@linux.intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9B266FAAC

The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse.

While touching these arrays, unify the list terminators to be just an
empty struct with no trailing comma.

This change doesn't introduce changes to the compiled pci_device_id
arrays, which was confirmed using x86 and arm64 builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/dma/amd/ptdma/ptdma-pci.c  |  4 ++--
 drivers/dma/dw-edma/dw-edma-pcie.c |  2 +-
 drivers/dma/dw/pci.c               | 22 +++++++++++-----------
 drivers/dma/pch_dma.c              | 26 +++++++++++++-------------
 4 files changed, 27 insertions(+), 27 deletions(-)

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
index 791c46e8ae4c..a27112de5497 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -563,7 +563,7 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
-	  (kernel_ulong_t)&xilinx_mdb_data },
+	  .driver_data = (kernel_ulong_t)&xilinx_mdb_data },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
 	  .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data },
 	{ }
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
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index bf805f1024f6..152939e7c6fd 100644
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
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pch_dma_id_table);
 
-- 
2.47.3



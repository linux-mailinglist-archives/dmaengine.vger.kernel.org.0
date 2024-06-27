Return-Path: <dmaengine+bounces-2573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336B91ADF4
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3591F247B1
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAC19CD1C;
	Thu, 27 Jun 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEv1jjkd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAA19B3E3;
	Thu, 27 Jun 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508975; cv=none; b=Yp76jIGuQWwUgBdZzjXOzPEJLa5ciPCBO6lm6qe/9LGFtXtREs5DSqT1xF+2uR130SMt90VyGrg53lsY8CHIK+szYDnT+0iimzrwSPh+tun7DTd0gYKio0Gx4uH4VkAOwDmIHpIBN8qhW+2nsr48XSmdQYkebT0sGt2wcaQXHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508975; c=relaxed/simple;
	bh=7c2a53YpQodmCF26TS5JXa9VgIKEr2auMGh9ugNAu2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVQJWoYDaw1uh9XJpj6Tsv2ToEsY87zcKvSAstsiSc/8Physi2lh1tX3s2K0a/vo5eJtha/dYKqmyvH1DumioSCEte5Sw/DILP1eI7wjpUDEPn1uV39PCmA/iubkQuAz/rJfqlszuOZS8QU0pDnj1TlLKb3slUgtzroabwBVWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEv1jjkd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e7145c63cso632639e87.0;
        Thu, 27 Jun 2024 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508972; x=1720113772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeEWdCK+v3cFCGOt0s8SezCLp0oS2iOHSzMswWowNvs=;
        b=bEv1jjkdLroIsi0LoWtFoV3OBauBcCPpF44bj8x2rAJDwiI2dj7UUB2dVbKTerSOPW
         IgBzhaKnTd8oVEKqiib7MmrejcwLIpEvZH12j2obxVjD4BgkrYXs+1R0pq6W5FaJ+6pY
         0JO7vwKBpq4jCn1gcwrDPOmK7hiRm70O8SvDJKovJK9NTpUCHY7hAzqzsh1ShCCPblB/
         L5XvutMN2biP4k4ZoRs5YhbZJbDsLv/hzcxppMKHXBw+xGFvS9zZKG5583fzxUDy5B7Z
         /PdtQqZc3Bz24LgQAKCcBCSpBJfwoJYLRixxnsaVKZsJv7pE9QcPq5T52B+2l/QE+Pbi
         JjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508972; x=1720113772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeEWdCK+v3cFCGOt0s8SezCLp0oS2iOHSzMswWowNvs=;
        b=p2qX3gHT2BLI4fonzf7Bywo5uyop6VxES7XYUqm9wDz2KnOinVg1GZ+TlnobhCrHGi
         w1es75PRMOI4VKysMcyVemmymO3DDzArDxAgd34jL8beK38lOUVWOkXCQTZe7Fr3XZ9c
         u6tjRSMxedCaHMLVG6VgPgwcf/78FLqxq1WBxD9eGY7/faKIyfj8UWnHMVYHjhs32dg4
         e1RNtFbVQQkw5Cpr/Jad5airuLHhb5VehpHUsBcM6F1wgJ2qH4e1wFVXAxDxnitJv6hr
         qTQBvNfq8o45ruTS4wPTCl47yFgQ9xeRd+chITUKx+Fy0mesNRcXziAWMhnMkjKuUu0u
         SBQA==
X-Forwarded-Encrypted: i=1; AJvYcCWrHat4flyqvWjRugOnEB5vPtzs2z8MlVddvoqBL50iu3BvSmovcy1jdHUeDnh+MDftP1bQ5x+QkQoytbTdl4YloD8kmuZudbC1J5FyqjmY1CZeIGx5uTdDMKX1+3dPIwazNSthwzA7dkYPTy4mB9zGZSE2mpu6xQFPeTNa+tQdWFDffIL9
X-Gm-Message-State: AOJu0YyYYvF72LbXGOLr3Yti5DPr2pyeq8PPnhyKU2RlF/Jjq2Ls2S+M
	6XW1oiQs+LbiEw0GJ+cVCo0cw+Ldbo2hqqMMfscS+Sz8rPnbCcBD
X-Google-Smtp-Source: AGHT+IF/npTSsVNef8jboB8omMFAeMLmlrurRJdb6QuF8dkT7XBz+Cb8CK/50DdhfPoKialyLwtGnw==
X-Received: by 2002:a05:6512:3996:b0:52c:8508:e851 with SMTP id 2adb3069b0e04-52e70384cadmr776161e87.14.1719508971731;
        Thu, 27 Jun 2024 10:22:51 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e712a7401sm265353e87.5.2024.06.27.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:22:51 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 5/6] dmaengine: dw: Simplify max-burst calculation procedure
Date: Thu, 27 Jun 2024 20:22:21 +0300
Message-ID: <20240627172231.24856-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627172231.24856-1-fancer.lancer@gmail.com>
References: <20240627172231.24856-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to have a more coherent DW AHB DMA slave configuration method -
dwc_config() - let's simplify the source and destination channel max-burst
calculation procedure:

1. Create the max-burst verification method as it has been just done for
the memory and peripheral address widths. Thus the dwc_config() method
will turn to a set of the verification methods execution.

2. Since both the generic DW AHB DMA and Intel iDMA 32-bit engines support
the power-of-2 bursts only, then the specified by the client driver
max-burst values can be converted to being power-of-2 right in the
max-burst verification method.

3. Since max-burst encoded value is required on the CTL_LO fields
calculation stage, the encode_maxburst() callback can be easily dropped
from the dw_dma structure meanwhile the encoding procedure will be
executed right in the CTL_LO register value calculation.

Thus the update will provide the next positive effects: the internal
DMA-slave config structure will contain only the real DMA-transfer config
values, which will be encoded to the DMA-controller register fields only
when it's required on the buffer mapping; the redundant encode_maxburst()
callback will be dropped simplifying the internal HW-abstraction API;
dwc_config() will look more readable executing the verification functions
one-by-one.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Refer to dwc_config() in the commit message. (Andy)
- Convert dwc_verify_maxburst() to returning zero. (Andy)
- Add a comment regarding the values utilized in the
  dwc_verify_p_buswidth() being verified before the method is called.
  (Andy, see patch 2)
- Detach the dw_dma_encode_maxburst() and idma32_encode_maxburst()
  movement to a preparatory patch. (Andy)
---
 drivers/dma/dw/core.c   | 30 +++++++++++++++++++++---------
 drivers/dma/dw/dw.c     |  9 ++++-----
 drivers/dma/dw/idma32.c |  9 ++++-----
 drivers/dma/dw/regs.h   |  1 -
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index b341a6f1b043..32a66f9effd9 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -779,6 +779,23 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(dw_dma_filter);
 
+static int dwc_verify_maxburst(struct dma_chan *chan)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+
+	dwc->dma_sconfig.src_maxburst =
+		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
+	dwc->dma_sconfig.dst_maxburst =
+		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
+
+	dwc->dma_sconfig.src_maxburst =
+		rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
+	dwc->dma_sconfig.dst_maxburst =
+		rounddown_pow_of_two(dwc->dma_sconfig.dst_maxburst);
+
+	return 0;
+}
+
 static int dwc_verify_p_buswidth(struct dma_chan *chan)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
@@ -838,7 +855,7 @@ static int dwc_verify_m_buswidth(struct dma_chan *chan)
 		dwc->dma_sconfig.src_addr_width = mem_width;
 	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
 		reg_width = dwc->dma_sconfig.src_addr_width;
-		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
+		reg_burst = dwc->dma_sconfig.src_maxburst;
 
 		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
 	}
@@ -849,15 +866,13 @@ static int dwc_verify_m_buswidth(struct dma_chan *chan)
 static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
-	struct dw_dma *dw = to_dw_dma(chan->device);
 	int ret;
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
-	dwc->dma_sconfig.src_maxburst =
-		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
-	dwc->dma_sconfig.dst_maxburst =
-		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
+	ret = dwc_verify_maxburst(chan);
+	if (ret)
+		return ret;
 
 	ret = dwc_verify_p_buswidth(chan);
 	if (ret)
@@ -867,9 +882,6 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	if (ret)
 		return ret;
 
-	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
-	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
-
 	return 0;
 }
 
diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index 628ee1e77505..6766142884b6 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -64,13 +64,13 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return DWC_CTLH_BLOCK_TS(block) << width;
 }
 
-static void dw_dma_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
+static inline u8 dw_dma_encode_maxburst(u32 maxburst)
 {
 	/*
 	 * Fix burst size according to dw_dmac. We need to convert them as:
 	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
 	 */
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;
+	return maxburst > 1 ? fls(maxburst) - 2 : 0;
 }
 
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
@@ -82,11 +82,11 @@ static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 	if (dwc->direction == DMA_MEM_TO_DEV) {
 		sms = dwc->dws.m_master;
 		dms = dwc->dws.p_master;
-		dmsize = sconfig->dst_maxburst;
+		dmsize = dw_dma_encode_maxburst(sconfig->dst_maxburst);
 	} else if (dwc->direction == DMA_DEV_TO_MEM) {
 		sms = dwc->dws.p_master;
 		dms = dwc->dws.m_master;
-		smsize = sconfig->src_maxburst;
+		smsize = dw_dma_encode_maxburst(sconfig->src_maxburst);
 	} else /* DMA_MEM_TO_MEM */ {
 		sms = dwc->dws.m_master;
 		dms = dwc->dws.m_master;
@@ -125,7 +125,6 @@ int dw_dma_probe(struct dw_dma_chip *chip)
 	dw->suspend_chan = dw_dma_suspend_chan;
 	dw->resume_chan = dw_dma_resume_chan;
 	dw->prepare_ctllo = dw_dma_prepare_ctllo;
-	dw->encode_maxburst = dw_dma_encode_maxburst;
 	dw->bytes2block = dw_dma_bytes2block;
 	dw->block2bytes = dw_dma_block2bytes;
 
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index 493fcbafa2b8..dac617c183e6 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -199,9 +199,9 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return IDMA32C_CTLH_BLOCK_TS(block);
 }
 
-static void idma32_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
+static inline u8 idma32_encode_maxburst(u32 maxburst)
 {
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 1 : 0;
+	return maxburst > 1 ? fls(maxburst) - 1 : 0;
 }
 
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
@@ -210,9 +210,9 @@ static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 	u8 smsize = 0, dmsize = 0;
 
 	if (dwc->direction == DMA_MEM_TO_DEV)
-		dmsize = sconfig->dst_maxburst;
+		dmsize = idma32_encode_maxburst(sconfig->dst_maxburst);
 	else if (dwc->direction == DMA_DEV_TO_MEM)
-		smsize = sconfig->src_maxburst;
+		smsize = idma32_encode_maxburst(sconfig->src_maxburst);
 
 	return DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN |
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
@@ -274,7 +274,6 @@ int idma32_dma_probe(struct dw_dma_chip *chip)
 	dw->suspend_chan = idma32_suspend_chan;
 	dw->resume_chan = idma32_resume_chan;
 	dw->prepare_ctllo = idma32_prepare_ctllo;
-	dw->encode_maxburst = idma32_encode_maxburst;
 	dw->bytes2block = idma32_bytes2block;
 	dw->block2bytes = idma32_block2bytes;
 
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 76654bd13c1a..5969d9cc8d7a 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -327,7 +327,6 @@ struct dw_dma {
 	void	(*suspend_chan)(struct dw_dma_chan *dwc, bool drain);
 	void	(*resume_chan)(struct dw_dma_chan *dwc, bool drain);
 	u32	(*prepare_ctllo)(struct dw_dma_chan *dwc);
-	void	(*encode_maxburst)(struct dw_dma_chan *dwc, u32 *maxburst);
 	u32	(*bytes2block)(struct dw_dma_chan *dwc, size_t bytes,
 			       unsigned int width, size_t *len);
 	size_t	(*block2bytes)(struct dw_dma_chan *dwc, u32 block, u32 width);
-- 
2.43.0



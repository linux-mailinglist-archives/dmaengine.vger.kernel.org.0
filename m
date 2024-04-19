Return-Path: <dmaengine+bounces-1913-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFE8AB4A4
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71241C2148A
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410813D269;
	Fri, 19 Apr 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ1ewyil"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439513C9B8;
	Fri, 19 Apr 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549461; cv=none; b=BoLOC+O9MPRyh86QMf52Ik56L40SDcJprfe3HJPWi46E8qJCxHaTpCmgXFiMLb33OKu2URWOPXk7tDjQmvzbkkjYEjz0Dat+akGzB4ePOqbrfX8fKRiv5sUdt3dq5cXuso9sJ3cvBc6jcQf37PT7B9mWxU+ynCD2ITSI9O7/j84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549461; c=relaxed/simple;
	bh=7c2a53YpQodmCF26TS5JXa9VgIKEr2auMGh9ugNAu2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhVDj18Nw1iEc5u2c9IO//7o9CgwsqCftcuoKdlr7lhNWulCyOuHbUj1+MyrG+St/BlvXYarv77Iwlv3QUfMZhwcgXQF8qKbbTRdUHbdVvwKlUWHU/c8UGG2+/G3wvaJ4fMEEcoVQcPopUYvQwLp8cHz4a2CYliI4OYWP4Hzk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ1ewyil; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5176f217b7bso3947133e87.0;
        Fri, 19 Apr 2024 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549457; x=1714154257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeEWdCK+v3cFCGOt0s8SezCLp0oS2iOHSzMswWowNvs=;
        b=ZQ1ewyilweYXrwD7F3Poj2h+cXtgk08fqhvLfxWnN7HzuQBfnDBD+jXb3LE5K5d2d8
         pebldW/BntRf2oMd1vq3TmidGCDT2Dhx3ST/PpQv3guguEsX7hs80+2P+A9797N039R4
         ROTzPrbamf8B1xzHYIIgdou8HyCNIpdIbjv+UZyhuQxxTujSyNc3GiXlTrHWL61KwYW6
         MrfKQb82SaNckzviLQ7I65EkJyDtPk/Lp0n70s8RuF+MursXaHsAvKBjwKHTBccL+8+B
         guZx+YaCA93kSl9tQbsWuhCn8R+CCK9/nC5MsdqakEGlnDGLt3n3wt1hW22hypsE9tA6
         AW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549457; x=1714154257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeEWdCK+v3cFCGOt0s8SezCLp0oS2iOHSzMswWowNvs=;
        b=aFXRZqGOyyHtrmeAqrzrwex+0NK4LCXEvh4zzSS887cjB/H7lna52rZUD1D7HbV1eQ
         Kjt58t3ab/8u5SNgbs4saPthLrQUzb40CMyYGsAtBZI0MGA5Se+iLw53CMdD2tyck6kR
         Gnezal3lgBeIdDUMB8KBABJiWxL+EOuzLXzZietA0mKpkXHh8BCmBxF38Kwov4ZaiDd1
         xwtUWKdMAHEUW9kc5HL64pGRl3Xb53mQEG9KHPXJY6KWWoU46yN0rxEmqISwjL4HhPh/
         o4t2tWZ3nfbuyKk2rrXjVaOY16zQolLIJsOV2f8DHLDVddelQg26fwc3fCjJw8ki4odm
         3uGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXfiLKVFW89DkfFrIQz8H89s3UFSidBVlOd1xuqcg0x69DTgqkVapx8O8oVoRb8dZ7Wj0fXqYz0q1VNwwiuAfE8IEM0T9k2muqj/hGdhE/qAjb5mgEYdpBWyjMeWRtSxtmN+fn/5IWk/OUZkGf5qipHKdCqT12HFK2ybNR0UsWsh5inJlz
X-Gm-Message-State: AOJu0Yz/dlW16FVJuRlxEi1+Mcq4+v3vO3044MIn8fbt0ftp/mDscb4V
	cfKFT4H+pIMSYXszss4hMqapQ7nj8sx35sEB5RtKsNxjnM6wmXjN
X-Google-Smtp-Source: AGHT+IFsnfXWHG0zC7wHY7vk9Bj04PjjH9zch50NthT3ja53RqWLI1NXZ9Py8r2TyR7fFardqXv7BA==
X-Received: by 2002:ac2:529c:0:b0:515:d196:6d4d with SMTP id q28-20020ac2529c000000b00515d1966d4dmr2376464lfm.24.1713549457174;
        Fri, 19 Apr 2024 10:57:37 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id s5-20020a056512214500b00515acfbe448sm793320lfr.163.2024.04.19.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:57:36 -0700 (PDT)
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
Subject: [PATCH v2 5/6] dmaengine: dw: Simplify max-burst calculation procedure
Date: Fri, 19 Apr 2024 20:56:47 +0300
Message-ID: <20240419175655.25547-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419175655.25547-1-fancer.lancer@gmail.com>
References: <20240419175655.25547-1-fancer.lancer@gmail.com>
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



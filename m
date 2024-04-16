Return-Path: <dmaengine+bounces-1850-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFF8A716A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC61F1F224A0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6F134CD4;
	Tue, 16 Apr 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5remeGD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6D132C17;
	Tue, 16 Apr 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284964; cv=none; b=u7G8jXeg2NqEeTwa1t5TPSYdFCDLgWxBuFqh7zMjjwP0WbAGtJW26d7sNJpAA5bnXwKjqsrkrKpk2BlfEZOxJ08cOhju8Bbp4F2skbl1zT/ttGin7fcRXe570hTtmOPs40Bx4+gSr1C1oHR+trSbq70ncnyDtkLS0lGuN0ieeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284964; c=relaxed/simple;
	bh=2Kd3DIDnTnUy4CbLobJwZ9WXWWQcfVElxl61UbnfXBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ33TBeL+3zUWVBsa5WFtp6tHzZogr7i1EJWsVBKNNdQFGcNoH6Mt3X133E1Zdsbm5vupU0y/Qo2JBt3l/ZMBF0Xtg1HGW1RbZq461y5WtoipmKkFyczmYB8FLAiTS7sAH4/cQauqEoVH3XOHI7QRqlCEb1ZvXT78JjSr+MkXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5remeGD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518c9ff3e29so3174801e87.0;
        Tue, 16 Apr 2024 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284961; x=1713889761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERSdJnkxlnsAamkbGXEbd3rVP20U4VTq4AXaYwSzTK4=;
        b=m5remeGDhaa8m6vtpemN9IHJbNP48nVfOKmDYvADjaXCRlz6Xh+YnYkeMKNhWbz/WG
         YXe3PYSuemmN2TheJAXOz8f6eCMeBxqzu0nq4J7XmCDkHII6WGRfsEhAwsbQsgGayuF5
         QxoSwY5Dhuj/r8jxz3lKhCkug47WQO7mmdv+YdfFqFPub3rz4qGwQONEbHENvjqeXvwT
         CkRglL/2dpxOr1LuxSWqdip8e7ydIbeXrFVokNRNKxilLvsNlayIsQ9WdImQBzJG2Z7w
         JwcIV9XPh4h+3pv+MFFDgR0u4NmHT0V42sgd1ZISWPxAc45rNzBqIiHobDTHH5y2GD1u
         c6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284961; x=1713889761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERSdJnkxlnsAamkbGXEbd3rVP20U4VTq4AXaYwSzTK4=;
        b=QGiMeNI1hxEFKNaPrefKMevhEjToBClU7tneANzmZx+ywqvzl1ZAHNrfQuXlnOFFzh
         wSEa7mgkeTld2M1rXARjYrf9GOMVt6az6iwQxEv+HLbjVSqT2/RNn3yYb5bMXv/mhw8Q
         qJgEo4Haz99SDuv+HQMgLL+aBMizgyjyZpmrgn2KH3XVnFClMClNFcyHPkV9e5VWxQBD
         pLUms3Bcc6QRMarEo1Uokl/cCkkMBQHXv0Ea/DGWY01Td11voJpVefW7hfZh7r1FQYvf
         Mg3QGkBLP1z9Z3DrgCLe+HPvCV3fWTKGYqUYVeGcUAEfHZGfMzSJEQAXcttx0vZG8N87
         a5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIzJw0q8Nl5rF4aKZWaIvRYPdks46bMN4NcnZw6/KAtfuEcYTSYcfmDx4Kas1X4D7QZnmneOKqcCyyOqWMAisLBHyOToAE5eBgTFAQK5q01L9b4iI6gH8qTrkAuzHGFZlJMsyApmFqPonaoPIWgap+qkEtOTq2tEOAN22BBZ5Hh+TdGvmF
X-Gm-Message-State: AOJu0YzJVl48j/2oNBmakgcGBEGof5Gnbm2owpz5GsXWIWUfFpT2ItgR
	bDD3jShbYVY2EawdAd+taqU6LSrpo99vCE9HqGsWshR1xsRpSHVi
X-Google-Smtp-Source: AGHT+IEgOpxZx3I5tU4e2wy/CEpm2oORaDSbppjjbJltxTZmqIiynZaKaL3dRR0kLnuX00xbwbTrtw==
X-Received: by 2002:a05:6512:10c5:b0:518:c371:2db4 with SMTP id k5-20020a05651210c500b00518c3712db4mr7803127lfg.10.1713284960779;
        Tue, 16 Apr 2024 09:29:20 -0700 (PDT)
Received: from localhost (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512374b00b0051926db8fe7sm223971lfs.228.2024.04.16.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:29:20 -0700 (PDT)
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
Subject: [PATCH 4/4] dmaengine: dw: Simplify max-burst calculation procedure
Date: Tue, 16 Apr 2024 19:28:58 +0300
Message-ID: <20240416162908.24180-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416162908.24180-1-fancer.lancer@gmail.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to have a more coherent DW AHB DMA slave configuration method
let's simplify the source and destination channel max-burst calculation
procedure:

1. Create the max-burst verification method as it has been just done for
the memory and peripheral address widths. Thus the DWC DMA slave config
method will turn to a set of the verification methods execution.

2. Since both the generic DW AHB DMA and Intel DMA32 engines support the
power-of-2 bursts only, then the specified by the client driver max-burst
values can be converted to being power-of-2 right in the max-burst
verification method.

3. Since max-burst encoded value is required on the CTL_LO fields
calculation stage, the encode_maxburst() callback can be easily dropped
from the dw_dma structure meanwhile the encoding procedure will be
executed right in the CTL_LO register value calculation.

Thus the update will provide the next positive effects: the internal
DMA-slave config structure will contain only the real DMA-transfer config
value, which will be encoded to the DMA-controller register fields only
when it's required on the buffer mapping; the redundant encode_maxburst()
callback will be dropped simplifying the internal HW-abstraction API;
DWC-config method will look more readable executing the verification
functions one-by-one.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw/core.c   | 26 +++++++++++++++++---------
 drivers/dma/dw/dw.c     | 23 +++++++++++------------
 drivers/dma/dw/idma32.c | 15 +++++++--------
 drivers/dma/dw/regs.h   |  1 -
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 61e026310dd8..8b4ecd137ae2 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -779,6 +779,21 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL_GPL(dw_dma_filter);
 
+static void dwc_verify_maxburst(struct dma_chan *chan)
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
+}
+
 static int dwc_verify_p_buswidth(struct dma_chan *chan)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
@@ -828,7 +843,7 @@ static int dwc_verify_m_buswidth(struct dma_chan *chan)
 		dwc->dma_sconfig.src_addr_width = mem_width;
 	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
 		reg_width = dwc->dma_sconfig.src_addr_width;
-		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
+		reg_burst = dwc->dma_sconfig.src_maxburst;
 
 		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
 	}
@@ -839,15 +854,11 @@ static int dwc_verify_m_buswidth(struct dma_chan *chan)
 static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
-	struct dw_dma *dw = to_dw_dma(chan->device);
 	int err;
 
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 
-	dwc->dma_sconfig.src_maxburst =
-		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
-	dwc->dma_sconfig.dst_maxburst =
-		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
+	dwc_verify_maxburst(chan);
 
 	err = dwc_verify_p_buswidth(chan);
 	if (err)
@@ -857,9 +868,6 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	if (err)
 		return err;
 
-	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
-	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
-
 	return 0;
 }
 
diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index c65438d1f1ff..c52333646edd 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -64,6 +64,15 @@ static size_t dw_dma_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return DWC_CTLH_BLOCK_TS(block) << width;
 }
 
+static inline u8 dw_dma_encode_maxburst(u32 maxburst)
+{
+	/*
+	 * Fix burst size according to dw_dmac. We need to convert them as:
+	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
+	 */
+	return maxburst > 1 ? fls(maxburst) - 2 : 0;
+}
+
 static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
@@ -73,10 +82,10 @@ static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 		sms = dwc->dws.m_master;
 		smsize = 0;
 		dms = dwc->dws.p_master;
-		dmsize = sconfig->dst_maxburst;
+		dmsize = dw_dma_encode_maxburst(sconfig->dst_maxburst);
 	} else if (dwc->direction == DMA_DEV_TO_MEM) {
 		sms = dwc->dws.p_master;
-		smsize = sconfig->src_maxburst;
+		smsize = dw_dma_encode_maxburst(sconfig->src_maxburst);
 		dms = dwc->dws.m_master;
 		dmsize = 0;
 	} else /* DMA_MEM_TO_MEM */ {
@@ -91,15 +100,6 @@ static u32 dw_dma_prepare_ctllo(struct dw_dma_chan *dwc)
 	       DWC_CTLL_DMS(dms) | DWC_CTLL_SMS(sms);
 }
 
-static void dw_dma_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
-{
-	/*
-	 * Fix burst size according to dw_dmac. We need to convert them as:
-	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
-	 */
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;
-}
-
 static void dw_dma_set_device_name(struct dw_dma *dw, int id)
 {
 	snprintf(dw->name, sizeof(dw->name), "dw:dmac%d", id);
@@ -128,7 +128,6 @@ int dw_dma_probe(struct dw_dma_chip *chip)
 	dw->suspend_chan = dw_dma_suspend_chan;
 	dw->resume_chan = dw_dma_resume_chan;
 	dw->prepare_ctllo = dw_dma_prepare_ctllo;
-	dw->encode_maxburst = dw_dma_encode_maxburst;
 	dw->bytes2block = dw_dma_bytes2block;
 	dw->block2bytes = dw_dma_block2bytes;
 
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index 3a1b12517655..428aba9fc2db 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -199,6 +199,11 @@ static size_t idma32_block2bytes(struct dw_dma_chan *dwc, u32 block, u32 width)
 	return IDMA32C_CTLH_BLOCK_TS(block);
 }
 
+static inline u32 idma32_encode_maxburst(u32 maxburst)
+{
+	return maxburst > 1 ? fls(maxburst) - 1 : 0;
+}
+
 static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 {
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
@@ -206,9 +211,9 @@ static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 
 	if (dwc->direction == DMA_MEM_TO_DEV) {
 		smsize = 0;
-		dmsize = sconfig->dst_maxburst;
+		dmsize = idma32_encode_maxburst(sconfig->dst_maxburst);
 	} else if (dwc->direction == DMA_DEV_TO_MEM) {
-		smsize = sconfig->src_maxburst;
+		smsize = idma32_encode_maxburst(sconfig->src_maxburst);
 		dmsize = 0;
 	} else /* DMA_MEM_TO_MEM */ {
 		smsize = 0;
@@ -219,11 +224,6 @@ static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
 	       DWC_CTLL_DST_MSIZE(dmsize) | DWC_CTLL_SRC_MSIZE(smsize);
 }
 
-static void idma32_encode_maxburst(struct dw_dma_chan *dwc, u32 *maxburst)
-{
-	*maxburst = *maxburst > 1 ? fls(*maxburst) - 1 : 0;
-}
-
 static void idma32_set_device_name(struct dw_dma *dw, int id)
 {
 	snprintf(dw->name, sizeof(dw->name), "idma32:dmac%d", id);
@@ -280,7 +280,6 @@ int idma32_dma_probe(struct dw_dma_chip *chip)
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



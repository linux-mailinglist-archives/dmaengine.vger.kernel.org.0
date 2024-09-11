Return-Path: <dmaengine+bounces-3145-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1119975A84
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336D21F2387D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF51BA276;
	Wed, 11 Sep 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WooLDRRx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729101B86D0;
	Wed, 11 Sep 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080447; cv=none; b=ArxNxuXCQuV4Pbswn5JgAMIvDwA7/wNHt8VCygJsYuRM/rRoIDTmyQYPULUDpimWDFK8dvxOjaMJUM9x0HgZP4N6tz8valtfkruXnoQ0VnJpwF/GlJGUeQS9vw51Gm3T1b2i4VODyHMnmi9VDtte/PtdFUP7gLcHi8n4x6Zliw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080447; c=relaxed/simple;
	bh=jG+cBMrrU7kEPtIhaK4lz1snZWwWlmphK5ZWBHwRWwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoqO7Y3XtiVrA9hldZyfmOMuoaRws/ChC06Kg+NviOXTWd3wLgtuRaOXcfcyOK2fldtdM5FLZ0KwfVTH+daiw9adP3ZU6WhyzOMhzXv6t4T5lb9r0+tLtVIZcacLgFmghu19MXfTCnxpEdMAzIJpl6CNbCCKXHH+QRgCMlSxtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WooLDRRx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso1881801fa.2;
        Wed, 11 Sep 2024 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726080443; x=1726685243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2NK/t6WSD8HTwnr1lVk45gkSuvvMRiYaxrej/JNjGI=;
        b=WooLDRRxATQtySG2SNJldtl7z+AjhH/4dSamL/xsJ0V48xMA4YlRZnPMYFl+WjVCGl
         o6+AIwGGLU+j/Mpi8ZNp1tAw8ECXxPgwzJYHSP4P6sC0W3WdDtXZk7ClPb1jx/GF25zl
         lQWt2p1gSvr7GpGODbqovtppnTC9+w8FYkvMGJfKFCfF3DYkE0vkwlo7pdp7SWtGMxAM
         hpSi8A8eaSXB8XtPYjY6ntcDNYZQGC+dWFTWhGDB2evzqMbrB2CVRl6jW2+oyowueGtw
         6bRY8nhqTMEEm8oolvjUGuS/UnrPhVMYi/xHLxcN4sl6Loj7//IAXY4q0vJaDakgCEwB
         mi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080443; x=1726685243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2NK/t6WSD8HTwnr1lVk45gkSuvvMRiYaxrej/JNjGI=;
        b=tQzoafWQUwa27Ww7q6o++Em8FHFxx3+tWQfl64juUym3lYCYsc2wL/xnKcTw3gWEwN
         5LT9VoqJcCwhUIJO+0cRuUijpF9LhnBJxU879Jfzi/AfB0E72YXSEh5BllvkQ9oIXCs8
         ybaP+Fmu8mfxF9GZOliZKcMx3NRKtKUwByZvWlIO/mJh6FUTT2Udl4db5SUeNsk85i5V
         CUVXlNE26yVEtSWKyW2auRyxu3phyMKFBlwLnq4QZOlfcR4ICtUDJ4gDC3VCfGy7x0B0
         Lmtb/ZLRXqvWN5PxKwVnSScehMpehzMZ2FuVKoZ0eSRqmA+47894Q4FO8ZvsPd/PFvf9
         766A==
X-Forwarded-Encrypted: i=1; AJvYcCVn0hCFS+LC+SmT5VZkJv9lgzF/hdFee/6Baa0d11W3usiKccl75WDyFoKJBLeAHknH5qM8TBwnikxPodbg@vger.kernel.org, AJvYcCWrvvaSlGpt9eRsLMAKjd5Owx7StDbGxylHqh5cEsvtHtC4syZ1usXij9NCJgqjCeuE2gNqrr8Hm7TeJneh@vger.kernel.org, AJvYcCXeE/AtFxMrjprTrRDeOgsvpH7V0rtB8TbsO1naTYxaBLfjEhx+NONTRmhIuOYCWeYiu20uHtbnm2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywum8biCspcnOqfHAa4EwRFoU/VstOQh/ltDABgMQ5ECMT/aFwk
	N0cq87yKZ8stKDAA+xZC0jI4QVwtnQP4Vtf7xnN8ivJ2pI6VNFaV
X-Google-Smtp-Source: AGHT+IFEKVAH2QfQanfHHpxmvt1deDrG94y1qz601o6433JwnfOKwBdSd2QaSVKFk43vaarWewLGAw==
X-Received: by 2002:a2e:a587:0:b0:2f6:6198:1cfa with SMTP id 38308e7fff4ca-2f787f44fe7mr1621451fa.41.1726080441707;
        Wed, 11 Sep 2024 11:47:21 -0700 (PDT)
Received: from localhost ([185.195.191.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c098ce9sm15821681fa.108.2024.09.11.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:47:20 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: dw: Prevent tx-status calling DMA-desc callback
Date: Wed, 11 Sep 2024 21:46:09 +0300
Message-ID: <20240911184710.4207-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911184710.4207-1-fancer.lancer@gmail.com>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmaengine_tx_status() method implemented in the DW DMAC driver is
responsible for not just DMA-transfer status getting, but may also cause
the transfer finalization with the Tx-descriptors callback invocation.
This makes the simple DMA-transfer status getting being much more complex
than it seems with a wider room for possible bugs.

In particular a deadlock has been discovered in the DW 8250 UART device
driver interacting with the DW DMA controller channels. Here is the
call-trace causing the deadlock:

serial8250_handle_irq()
  uart_port_lock_irqsave(port); ----------------------+
  handle_rx_dma()                                     |
    serial8250_rx_dma_flush()                         |
      __dma_rx_complete()                             |
        dmaengine_tx_status()                         |
          dwc_scan_descriptors()                      |
            dwc_complete_all()                        |
              dwc_descriptor_complete()               |
                dmaengine_desc_callback_invoke()      |
                  cb->callback(cb->callback_param);   |
                  ||                                  |
                  dma_rx_complete();                  |
                    uart_port_lock_irqsave(port); ----+ <- Deadlock!

So in case if the DMA-engine finished working at some point before the
serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
been executed yet to finalize the DMA transfer, then calling the
dmaengine_tx_status() will cause the DMA-descriptors status update and the
Tx-descriptor callback invocation.

Generalizing the case up: if the dmaengine_tx_status() method callee and
the Tx-descriptor callback refer to the related critical section, then
calling dmaengine_tx_status() from the Tx-descriptor callback will
inevitably cause a deadlock around the guarding lock as it happens in the
Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
very often, but can be eventually discovered if the being received data
size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
driver. In my case reducing the Rx DMA-buffer size increased the deadlock
probability.)

Alas there is no obvious way to prevent the deadlock by fixing the
8250-port drivers because the UART-port lock must be held for the entire
port IRQ handling procedure. Thus the best way to fix the discovered
problem (and prevent similar ones in the drivers using the DW DMAC device
channels) is to simplify the DMA-transfer status getter by removing the
Tx-descriptors state update from there and making the function to serve
just one purpose - calculate the DMA-transfer residue and return the
transfer status. The DMA-transfer status update will be performed in the
bottom-half procedure only.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 90 ++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index dd75f97a33b3..af1871646eb9 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -39,6 +39,8 @@
 	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES)		| \
 	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
 
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc);
+
 /*----------------------------------------------------------------------*/
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -297,14 +299,12 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -358,41 +358,16 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		return;
 	}
 
-	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
+	dev_vdbg(chan2dev(&dwc->chan), "%s: hard LLP mode\n", __func__);
 
 	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
-
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		/* Check first descriptors llp */
-		if (lli_read(desc, llp) == llp) {
-			/* This one is currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
+		desc->residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+		if (desc->residue) {
 			spin_unlock_irqrestore(&dwc->lock, flags);
 			return;
 		}
 
-		desc->residue -= desc->len;
-		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (lli_read(child, llp) == llp) {
-				/* Currently in progress */
-				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
-			desc->residue -= child->len;
-		}
-
-		/*
-		 * No descriptors so far seem to be in progress, i.e.
-		 * this one must be done.
-		 */
+		/* No data left to be send. Finalize the transfer then */
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		dwc_descriptor_complete(dwc, desc, true);
 		spin_lock_irqsave(&dwc->lock, flags);
@@ -976,6 +951,45 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 	return NULL;
 }
 
+static u32 dwc_get_soft_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->residue;
+
+	if (residue)
+		residue -= dwc_get_sent(dwc);
+
+	return residue;
+}
+
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->total_len;
+	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
+
+	/* Check first descriptor for been pending to be fetched by DMAC */
+	if (desc->txd.phys == DWC_LLP_LOC(llp))
+		return residue;
+
+	/* Check first descriptor LLP to see if it's currently in-progress */
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
+
+	/* Check subordinate LLPs to find the currently in-progress desc */
+	residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
+	}
+
+	/* Shall return zero if no in-progress desc found */
+	return residue;
+}
+
 static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
 				      enum dma_status *status)
 {
@@ -988,9 +1002,11 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc_first_active(dwc)) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
-				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
+				residue = dwc_get_soft_llp_desc_residue(dwc, desc);
+			else
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {
@@ -1012,12 +1028,6 @@ dwc_tx_status(struct dma_chan *chan,
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	enum dma_status		ret;
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
-
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
-
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
-- 
2.43.0



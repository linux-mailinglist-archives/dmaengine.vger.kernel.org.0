Return-Path: <dmaengine+bounces-3146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CA975A85
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 20:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A41F237D6
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4C1BA291;
	Wed, 11 Sep 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m78bhn4H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0021B9B58;
	Wed, 11 Sep 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080448; cv=none; b=Prul6UFsR71TxhoTjKMhfb9Ge8dbCUln+lXKRUK294Vtv4LLv3R85kHAOG8UyoYs1t0mosoZ3ZR0bnMo84cMyBRP5qp5hO8rKalNiQpdxgDYZietuwt6SdJTUFExgz3oA2j5j9T3aZA06ZTyeXhawXIipy8QhmhuyDV1LMVx20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080448; c=relaxed/simple;
	bh=g1wKLq6EZVzIY+jjtq31yNBD0OEGVAAlGiGuJ4FjodA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY+tezW6uHGhTAkcC60RDls9o9V0SmmEnDME68FBLX2sEN5y9AoyMuJTU0M3XUbOKoRUI6/zgR7QSPfSi9l+gQFXQapxN9dU9SULr0Xlo4DPof2Zwx5JGLRr3fJHaupiVMKYsfLxuNi8YLzhhKjKNlS2zQbqumrroV/bxyVemx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m78bhn4H; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356bb55224so167735e87.0;
        Wed, 11 Sep 2024 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726080444; x=1726685244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fewwl+lFoaJ2FBbeLyQj39EYVP4HCmDCuF5Re12r5s=;
        b=m78bhn4Huuc3RghchgacuBDhvpXroLJlb88RMjyJjMFnOHIu3UztD82B5Z4pRL65Pn
         PlVGbY7jhrPspaunB+adv+1nENe4z/+78UmPZT28eFuaZPH3xp2hv9UQelUk9IfrbVHW
         8/XTfc0oX3PLoRxkK+XdNa2g8cHQZAeH7vVrKuxRcdlGOEY0rDXpTb4sLr0t75dvm5R2
         0vYB8iVN5KOobH4WYLgoaz/8AhIh4sS2K8jyKTMJ0D2KD+BJiSyRbd6NuTUkj9ZLPnBO
         PWYYsl5GUkmlDQ3v8sZPAAb6DX1WRmK9bbdZ1AzmhSHMrggI0EWj+HIdz1VAQESVA5Cy
         0xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080444; x=1726685244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fewwl+lFoaJ2FBbeLyQj39EYVP4HCmDCuF5Re12r5s=;
        b=KOLJ/4SnzdDr0lH9KisONdKXcrZUqBc9vj6hXuJFPXnSyGiklefabQinC0+Ln6nQlT
         ySp1u8WcKsglbRhs0DNXizi5UBMHLGJwKGpdgYwp78IAAJnIoAyKuT4DFgpuKWEYKMot
         m3Hk7UPg/kAfmthAHacGjsik+DBPciG8DaMhfS2VPXi6hM7Eq9cub250TZO+qh6rruAm
         CWpXABOmrgyGUSiHqNcfF5WvB0Xz/X+pqd/8scP2Sd/JCBwM0XHArQ5spNovxRl6kZ2v
         g99TrbUBs3cKIIbwiHTy+6UicD0uU4ZwhhSr9D+XARfaaC3jbG4UsrE9yr7U8Al1DXjQ
         5Znw==
X-Forwarded-Encrypted: i=1; AJvYcCUoyPI5YnPzJ0Vu+MGyXz0088nU7xfTwVikkIwE+dHF6Y+rWKoeQYUpjO0VniJDPblYOhLNfKbFGsOrz0I2@vger.kernel.org, AJvYcCUye04XOStBEnjdLM2EVzem/GYAKM8+a/vFPCELc+q1xaJH/ERLpeoNQr1jQVfEupoC1IidNuLX+wfTUQdC@vger.kernel.org, AJvYcCXiYoheGawCWH2z4L+9cOES6nNzrPlDz5q2e+Vza2Ynm4JV+LkHrc/h/eEJDeXNLHMuf1BlLht+OjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCiimecGBVS04QiQBB3KEb248QwwX6lOCX/2wL1N3L0NK3Iu7
	k15Zq7XXVPW+tocSSgrnTW6qFUll51tj2uZn8g4ZpdEHjE0xumtA
X-Google-Smtp-Source: AGHT+IEmC7BC2TuOTOPFoYXjgiONufb+BKVRN5oCB9gLhz95XL5udTn4Yjj2M7EVU/OSD0jfXkKRRg==
X-Received: by 2002:a05:6512:12c8:b0:533:46cc:a71e with SMTP id 2adb3069b0e04-53678fec522mr210325e87.54.1726080443614;
        Wed, 11 Sep 2024 11:47:23 -0700 (PDT)
Received: from localhost ([185.195.191.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d531sm1671429e87.267.2024.09.11.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:47:23 -0700 (PDT)
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
Subject: [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
Date: Wed, 11 Sep 2024 21:46:10 +0300
Message-ID: <20240911184710.4207-3-fancer.lancer@gmail.com>
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

If a client driver gets to use the DW DMAC engine device tougher
than usual, with occasional DMA-transfers termination and restart, then
the next error can be randomly spotted in the system log:

> dma dma0chan0: BUG: XFER bit set, but channel not idle!

For instance that happens in case of the 8250 UART port driver handling
the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
DMA-engine interface.

The error happens due to the two-staged nature of the DW DMAC IRQs
handling procedure and due to the critical section break in the meantime.
In particular in case if the DMA-transfer is terminated and restarted:
1. after the IRQ-handler submitted the tasklet but before the tasklet
   started handling the DMA-descriptors in dwc_scan_descriptors();
2. after the XFER completion flag was detected in the
   dwc_scan_descriptors() method, but before the dwc_complete_all() method
   is called
the error denoted above is printed due to the overlap of the last transfer
completion and the new transfer execution stages.

There are two places need to be altered in order to fix the problem.
1. Clear the IRQs in the dwc_chan_disable() method. That will prevent the
   dwc_scan_descriptors() method call in case if the DMA-transfer is
   restarted in the middle of the two-staged IRQs-handling procedure.
2. Move the dwc_complete_all() code to being executed inseparably (in the
   same atomic section) from the DMA-descriptors scanning procedure. That
   will prevent the DMA-transfer restarts after the DMA-transfer completion
   was spotted but before the actual completion is executed.

Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw/core.c | 54 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index af1871646eb9..fbc46cbfe259 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -143,6 +143,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	channel_clear_bit(dw, CH_EN, dwc->mask);
 	while (dma_readl(dw, CH_EN) & dwc->mask)
 		cpu_relax();
+
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
+	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.ERROR, dwc->mask);
 }
 
 /*----------------------------------------------------------------------*/
@@ -259,34 +265,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
 
-static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
-{
-	struct dw_desc *desc, *_desc;
-	LIST_HEAD(list);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(chan2dev(&dwc->chan),
-			"BUG: XFER bit set, but channel not idle!\n");
-
-		/* Try to continue after resetting the channel... */
-		dwc_chan_disable(dw, dwc);
-	}
-
-	/*
-	 * Submit queued descriptors ASAP, i.e. before we go through
-	 * the completed ones.
-	 */
-	list_splice_init(&dwc->active_list, &list);
-	dwc_dostart_first_queued(dwc);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, true);
-}
-
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -303,6 +281,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
+	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	status_xfer = dma_readl(dw, RAW.XFER);
@@ -341,9 +320,26 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 		}
 
+		/*
+		 * No more active descriptors left to handle. So submit the
+		 * queued descriptors and finish up the already handled ones.
+		 */
+		if (dma_readl(dw, CH_EN) & dwc->mask) {
+			dev_err(chan2dev(&dwc->chan),
+				"BUG: XFER bit set, but channel not idle!\n");
+
+			/* Try to continue after resetting the channel... */
+			dwc_chan_disable(dw, dwc);
+		}
+
+		list_splice_init(&dwc->active_list, &list);
+		dwc_dostart_first_queued(dwc);
+
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		dwc_complete_all(dw, dwc);
+		list_for_each_entry_safe(desc, _desc, &list, desc_node)
+			dwc_descriptor_complete(dwc, desc, true);
+
 		return;
 	}
 
-- 
2.43.0



Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E145D6BA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbhKYJGJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:62146 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353577AbhKYJEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830858; x=1669366858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IzKN39oOHNC3CK9tz3WGrvZQjLqHyTGav61lvPMp9Bg=;
  b=Tsp90S7DtqNipbH/+p0uxNVwkwR+Xq4hAHjcLlntoV9A3d86buQuqa/5
   QpvOvpwqi3RZhM69iRpI0wBnZKJiMPL/BdKVQaff4kIPTRcFkOorw4GAd
   tJYUvUoQXv5YjDoaCkSbsrRQcH1yVR782atLuSn+xImhl37f/VctmTlo2
   0VPCCE5fgeACkMVDAznGn8YHrbKe2BqmV0KEdOgAh/qLWQmlXZu4vczMO
   i/XwQ0Wai6nXjYTdMk9DJppGUvtrmgFeaLlWGOzMTdObqzYcPMS2U+1U7
   cWGKLWf5lbI8wLFAEr++bjFxmZc3YchfYTyoCVmc4sCo/YiQMZdE7e02I
   g==;
IronPort-SDR: vyPr1F2plqj76Swh6q75SBov6E1446XVpQoxgAr6KVcsSSMUVDV0RqXySK++sRL7JGYf0+aGjq
 2o6whjre3LV6WsdWDLsfwRGCeHz4oYPU/nnW+IB4sdckhZKALJ3Rn56yJ0NnXmf3FBm590PWUT
 qHO15mWufasiiOjjK6cInrkIryIu1a5M1Rsj6Q+e8qUrL1/4M6r4qWuNE3Tefoh8+QHasaaRTN
 7gVzs61Djc38Op06+HUttKCmNNfjC9mmFCFUbtNpAdW4D2yxjgEdNOEal8e7AkPZ8sBu1bFLFa
 zIBIaiJsWx9U+3QIORpQ9cwf
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="144534247"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:53 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 07/13] dmaengine: at_xdmac: Fix race for the tx desc callback
Date:   Thu, 25 Nov 2021 11:00:22 +0200
Message-ID: <20211125090028.786832-8-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The transfer descriptors were wrongly moved to the free descriptors list
before calling the tx desc callback. As the DMA engine drivers drop any
locks before calling the callback function, txd could be taken again,
resulting in its callback called prematurely.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 4d8476845c20..2cc9af222681 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1582,20 +1582,6 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	return ret;
 }
 
-/* Call must be protected by lock. */
-static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
-				    struct at_xdmac_desc *desc)
-{
-	dev_dbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-
-	/*
-	 * Remove the transfer from the transfer list then move the transfer
-	 * descriptors into the free descriptors list.
-	 */
-	list_del(&desc->xfer_node);
-	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
-}
-
 static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac_desc	*desc;
@@ -1704,7 +1690,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 		txd = &desc->tx_dma_desc;
 		dma_cookie_complete(txd);
-		at_xdmac_remove_xfer(atchan, desc);
+		/* Remove the transfer from the transfer list. */
+		list_del(&desc->xfer_node);
 		spin_unlock_irq(&atchan->lock);
 
 		if (txd->flags & DMA_PREP_INTERRUPT)
@@ -1713,6 +1700,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		dma_run_dependencies(txd);
 
 		spin_lock_irq(&atchan->lock);
+		/* Move the xfer descriptors into the free descriptors list. */
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1859,8 +1848,10 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		cpu_relax();
 
 	/* Cancel all pending transfers. */
-	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
-		at_xdmac_remove_xfer(atchan, desc);
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		list_del(&desc->xfer_node);
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
-- 
2.25.1


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED1475730
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbhLOLBf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16372 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbhLOLBe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566093; x=1671102093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4X8BJvNzEUcQqoMWQpov9DWaBKuYhadvuaqzWzFzBHw=;
  b=Yna+Pnop/z9nBVz00MwEulQ0mMNeFx+JQz22Xk/1p+CLhrtYy/Mbh+Rs
   gShDzj/Tt1KZsLspZIecA+9T7ondMwYMjO+E4qAaV8FdHeNXw3Vfh7p8q
   9RJ4tHQxvmMLgVSPlYUEmYaeo7X4LnL/dv9NNCUy4BOOo1VCgoz+II8U0
   aMoPLOcIJRdIPQReUyJv2aq47MUI8DE3eA3KzKSW0kxM2/t6ry8IZIOs1
   Cgy3gh2xuN84J6SIEj/9TKarQtkTH5bJMVKFt/tQMQYD4MFAZk22ngidh
   kIqV0bQVc0fOVsIURxcPvsyZnSvSvksqOvRx0lEYi0cJ3ttyloEDnwniw
   Q==;
IronPort-SDR: 5144dnubbSn42QemwMCTwZaOM6kP58KT4tTkUJEtFCZkYQpFbIhDXDKuLbymvtzEgIDnn8+CFk
 uBAg6Psn3qTRey/XPwckMnhzBEoPaGwD+Vxo9WcTmcTDuwuga1pgYLV4JoSUKKM7RTDpAzpf7Z
 wvq6FYpnSlvarZkqcLCttwPB7Bxbob44IfF027f09Hy3X2uaFskVUk+Y69To2eVQpLIAEzEzpY
 2ze8Qp2ltApX5tQ+9iLfRxKgHLtqMQCosvb0W3TotrTysiDv7ewiJDSpVzC9vGQV17zAFe+Lj3
 Xa3ipGFZ0gXjekR9tfAhEhuF
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="139842688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:32 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:30 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 05/12] dmaengine: at_xdmac: Fix race for the tx desc callback
Date:   Wed, 15 Dec 2021 13:01:08 +0200
Message-ID: <20211215110115.191749-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The transfer descriptors were wrongly moved to the free descriptors list
before calling the tx desc callback. As the DMA engine drivers drop any
locks before calling the callback function, txd could be taken again,
resulting in its callback called prematurely. Fix the race for the tx desc
callback by moving the xfer desc into the free desc list after the
callback is invoked.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 83c031207530..d5b37459f906 100644
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


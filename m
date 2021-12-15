Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776EA47573F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbhLOLB5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16401 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbhLOLBw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566111; x=1671102111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=livyu8Olu9F9Ywh/gQcsyDAU8oKSPgD+q4+UxxEb734=;
  b=SNJpg7CWyCFPdmXLKn4GSCD4x6TbtRPMeTvmBCojq5H+2uZlhN9065gK
   KS/KvA7iVqiK9sgnwEN3YJfasRH2d1WlnjT9rSxXTWqCAT9rMeGDayLsY
   NMdtynY6kTElOdMXbtCWZZK/wj3E3iaryQG9Uhm0ZHaiKdOlQ92fDXA+F
   NePEhaygoJYqFaQaw9PMr1NzkxB8HxBZ40VLKsKkpn/c0ZZyEXFUtR+sp
   DtuNPE/sGwguzFi6JHMBA3DLrkjSEcuxso9/XOA0XWBQqJKJaJ0jdIGlC
   6/MH6R8dicggTr3IiNZksaH8ahCnYqD83N2x4AcmbVexX3ZkAfFzepBRJ
   g==;
IronPort-SDR: law3cO30f8LFLnfWd/Rjq4CEuz7T4Bx4DvtkSXmrdYQrIERp0Mxn4pOP7NmvXPxSkG3PqGKMiq
 XjPu05B9Y6dwIRL+6vs5GiM0jZyVdbievZ/vQAB11aOR69853E5NknJVUqnBvLAcbBHCDE2VMz
 uPYp7fUKVMzMhmnAr4LLCbtRNjib021fXDkN76B5tpwYIAwfbd6ks3Jf7uKPT4lOoHUxvxPl59
 IUfBdty4gdUjhjdm6QnaVCKaEmK6j6B2zjF/xthNrkdTNwIOA6mID4d1lcqqgNk2Lg0kVaXFAR
 qR6Wc3cOyh1rwSOPitr0sGuh
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="139842746"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:51 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 12/12] dmaengine: at_xdmac: Fix race over irq_status
Date:   Wed, 15 Dec 2021 13:01:15 +0200
Message-ID: <20211215110115.191749-13-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tasklets run with interrupts enabled, so we need to protect
atchan->irq_status with spin_lock_irq() otherwise the tasklet can be
interrupted by the IRQ that modifies irq_status. Move the dev_dbg that
prints the irq_status in at_xdmac_handle_cyclic() and lower in
at_xdmac_tasklet() where the IRQ is disabled.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ba727751a9f6..a1da2b4b6d73 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1611,6 +1611,8 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 	struct dma_async_tx_descriptor	*txd;
 
 	spin_lock_irq(&atchan->lock);
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+		__func__, atchan->irq_status);
 	if (list_empty(&atchan->xfers_list)) {
 		spin_unlock_irq(&atchan->lock);
 		return;
@@ -1623,6 +1625,7 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 		dmaengine_desc_get_callback_invoke(txd, NULL);
 }
 
+/* Called with atchan->lock held. */
 static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
@@ -1641,8 +1644,6 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
-	spin_lock_irq(&atchan->lock);
-
 	/* Channel must be disabled first as it's not done automatically */
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
@@ -1652,8 +1653,6 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 				    struct at_xdmac_desc,
 				    xfer_node);
 
-	spin_unlock_irq(&atchan->lock);
-
 	/* Print bad descriptor's details if needed */
 	dev_dbg(chan2dev(&atchan->chan),
 		"%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
@@ -1670,15 +1669,17 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 	struct dma_async_tx_descriptor *txd;
 	u32			error_mask;
 
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
-		__func__, atchan->irq_status);
-
 	if (at_xdmac_chan_is_cyclic(atchan))
 		return at_xdmac_handle_cyclic(atchan);
 
 	error_mask = AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS |
 		AT_XDMAC_CIS_ROIS;
 
+	spin_lock_irq(&atchan->lock);
+
+	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+		__func__, atchan->irq_status);
+
 	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
 	    !(atchan->irq_status & error_mask))
 		return;
@@ -1686,7 +1687,6 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 	if (atchan->irq_status & error_mask)
 		at_xdmac_handle_error(atchan);
 
-	spin_lock_irq(&atchan->lock);
 	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
 				xfer_node);
 	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-- 
2.25.1


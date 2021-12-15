Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F74475740
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhLOLB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16395 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbhLOLBt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566109; x=1671102109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmF5KOk6wLZ0TwZsu8nvDmLPx1dYcRpG1UMV30FGRhQ=;
  b=BNn9vqspvbCRLOsM2p3KP6yqzVt5lW1PKFeIvhDoAQtzEDPUxCRirUVZ
   JyiGpcIlp18vn4D8dcZlX4NOkdYb9e2+fLncWUyuyowsONy7d0jZzQ0Vm
   vSKQC7o551X0zwFX2tkUBo5O1RMO/+IoWlXTNuSjJtmvLLTKKe6XdwwSR
   o8P7Er+UmGKVpBHSPQyiPpZMHxxSkxS1DdRw11QnLuiKA1dmRo/2Yjvic
   UPCOdhfMCvQxAw4j63eYcja/xzsaGuc7nUf1exSEOqj42iWj7Pnf7ST5b
   3WeFf9gQIZd6DOKP8oe3cGO39gOQ75HBju4hE/q0YwbyBmhgeMNpgBhlZ
   w==;
IronPort-SDR: rPY4p4r0SuDwn9mAd3+2mVKhSWUTfe7YGJyZf8HAb8n5t3lMoijNgA+FL8yWL8pcN/i3Wovbui
 bbPbf6w2+Y1T0sxS1Ts+C9LdSYGGqGRVaQPPoaYYRdgsE6enL80Fu7Bl+eQe+uF09T+84OZn4Q
 6D3lbSbNNOI6q9KuRF0fQ0BRP37ozTCEX23ms3oh72IXSPc4uu0cWeU7klmDYl58gPmcuFcHWQ
 h7ZnFHJidxDVdVYyn7d/h7Xy3l6zLrqizpQXYD8hJPEYqdAdtO+vJhRDqbn4lZ57rizmqRk0y6
 SLqWWHy1j5DUp1C6yZafSmOM
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="139842729"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:48 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 11/12] dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_tasklet()
Date:   Wed, 15 Dec 2021 13:01:14 +0200
Message-ID: <20211215110115.191749-12-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apart of making the code easier to read, this patch is a prerequisite for
a functional change: tasklets run with interrupts enabled, so we need to
protect atchan->irq_status with spin_lock_irq() otherwise the tasklet can
be interrupted by the IRQ that modifies irq_status. atchan->irq_status
will be protected in a further patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 70 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index abe8c4615e65..ba727751a9f6 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1667,53 +1667,51 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 {
 	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
 	struct at_xdmac_desc	*desc;
+	struct dma_async_tx_descriptor *txd;
 	u32			error_mask;
 
 	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
 		__func__, atchan->irq_status);
 
-	error_mask = AT_XDMAC_CIS_RBEIS
-		     | AT_XDMAC_CIS_WBEIS
-		     | AT_XDMAC_CIS_ROIS;
-
-	if (at_xdmac_chan_is_cyclic(atchan)) {
-		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
-		   || (atchan->irq_status & error_mask)) {
-		struct dma_async_tx_descriptor  *txd;
-
-		if (atchan->irq_status & error_mask)
-			at_xdmac_handle_error(atchan);
-
-		spin_lock_irq(&atchan->lock);
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc,
-					xfer_node);
-		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		if (!desc->active_xfer) {
-			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
-			spin_unlock_irq(&atchan->lock);
-			return;
-		}
+	if (at_xdmac_chan_is_cyclic(atchan))
+		return at_xdmac_handle_cyclic(atchan);
 
-		txd = &desc->tx_dma_desc;
-		dma_cookie_complete(txd);
-		/* Remove the transfer from the transfer list. */
-		list_del(&desc->xfer_node);
-		spin_unlock_irq(&atchan->lock);
+	error_mask = AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS |
+		AT_XDMAC_CIS_ROIS;
 
-		if (txd->flags & DMA_PREP_INTERRUPT)
-			dmaengine_desc_get_callback_invoke(txd, NULL);
+	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
+	    !(atchan->irq_status & error_mask))
+		return;
 
-		dma_run_dependencies(txd);
+	if (atchan->irq_status & error_mask)
+		at_xdmac_handle_error(atchan);
 
-		spin_lock_irq(&atchan->lock);
-		/* Move the xfer descriptors into the free descriptors list. */
-		list_splice_tail_init(&desc->descs_list,
-				      &atchan->free_descs_list);
-		at_xdmac_advance_work(atchan);
+	spin_lock_irq(&atchan->lock);
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	if (!desc->active_xfer) {
+		dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
 		spin_unlock_irq(&atchan->lock);
+		return;
 	}
+
+	txd = &desc->tx_dma_desc;
+	dma_cookie_complete(txd);
+	/* Remove the transfer from the transfer list. */
+	list_del(&desc->xfer_node);
+	spin_unlock_irq(&atchan->lock);
+
+	if (txd->flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_get_callback_invoke(txd, NULL);
+
+	dma_run_dependencies(txd);
+
+	spin_lock_irq(&atchan->lock);
+	/* Move the xfer descriptors into the free descriptors list. */
+	list_splice_tail_init(&desc->descs_list, &atchan->free_descs_list);
+	at_xdmac_advance_work(atchan);
+	spin_unlock_irq(&atchan->lock);
 }
 
 static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
-- 
2.25.1


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7B1C6E79
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2020 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgEFKgi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 May 2020 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgEFKgh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 May 2020 06:36:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB51C061A0F
        for <dmaengine@vger.kernel.org>; Wed,  6 May 2020 03:36:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so313570pls.8
        for <dmaengine@vger.kernel.org>; Wed, 06 May 2020 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=thaTuz023J24mmfYx9WFuNUVR4uqDSDs4hd6xiMs2HQ=;
        b=Juk8aX+/Z6K3rUR9tShvSf8QO/59KmTN6rxhKB9Mt4roYZzLAXhkMmBse1u1uy3wZ6
         gO067Y5vaMP4NzmZLRT7RmHI90eBWk5MWMP0MSO/95TSkr0AuE5y2EtBsHVGLQZY2PHc
         IGVSWhhtgGZFi/GZzLsTjBkeJBD8AFb/6kxSQ4gi2eX0C0xkDgpof43hu+ce1jZaIFUP
         +asKdgFD7Invze3lbGALkogLgrEY5LNYsAVh40x/YNlhuiYkvt7RVlzhKbODkyBpRYNr
         LSA++b17xQQ47DHfvQmKRy2iXyM5w3z+CVBXPrOe9BUjnMLpmLPit523/sXEYoUybQDa
         eTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=thaTuz023J24mmfYx9WFuNUVR4uqDSDs4hd6xiMs2HQ=;
        b=S3jKwIXGDakDGd8qUsM1w6GCqAPY7nJ/jb3kg9aI90oDNo3dNFRpimkUCZvIDOewGE
         jqzjBdma1Sy520BDOp1Spo+PmlEmW61ctBFJ90WXJCr4kDII4znqDyHQ0my0ZxAh9+6A
         2h/aN2c6PcNhH4g+qbIVAVqLFed8vMk1Rd6d67/njdHGzeCTsNip434A3YWg/HJ9k02b
         /L1cwhTG9dw3NWljCtHdkrHuqAcNRf7QfTJxCgwG7VtY6BpzTEgCPSVvZZ3CLQ6Q3K5P
         hq1SuXiiKcpowhPz8tKI/+xdF1IIEzsEnasMCkFUjESNMy+V8C/3uV92kc1hMu7+MdGi
         rePw==
X-Gm-Message-State: AGi0PubvHN5k7KBi7XqkUO1vC7JDW3XgbjrXLoV9NW1h4YpgumC+fo3G
        xCMFW454l0Y05lg7mSisYRI=
X-Google-Smtp-Source: APiQypIYqg3kBltw6m7Zi9HbaL4qr5KxUh+1Z/pssRv1XSrG6qmz4S7b5jJZQF5wtZ3ECdo0GdkPWQ==
X-Received: by 2002:a17:90a:d56:: with SMTP id 22mr8227363pju.187.1588761397235;
        Wed, 06 May 2020 03:36:37 -0700 (PDT)
Received: from localhost.localdomain ([106.215.43.48])
        by smtp.gmail.com with ESMTPSA id i72sm1601582pfe.104.2020.05.06.03.36.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 03:36:36 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH RFC 2/8] dmaengine: Actions: Add support for S700 DMA engine
Date:   Wed,  6 May 2020 16:06:04 +0530
Message-Id: <1588761371-9078-3-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA controller present on S700 SoC is compatible with the one on S900
(as most of registers are same), but it has different DMA descriptor
structure where registers "fcnt" and "ctrlb" uses different encoding.

For instance, on S900 "fcnt" starts at offset 0x0c and uses upper 12
bits whereas on S700, it starts at offset 0x1c and uses lower 12 bits.

This commit adds support for DMA controller present on S700.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
 drivers/dma/owl-dma.c | 99 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index b0d80a2fa383..6c2f0d0aad4c 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -134,6 +134,11 @@ enum owl_dmadesc_offsets {
 	OWL_DMADESC_SIZE
 };
 
+enum owl_dma_id {
+	S900_DMA,
+	S700_DMA,
+};
+
 /**
  * struct owl_dma_lli - Link list for dma transfer
  * @hw: hardware link list
@@ -200,6 +205,7 @@ struct owl_dma_vchan {
  * @pchans: array of data for the physical channels
  * @nr_vchans: the number of physical channels
  * @vchans: array of data for the physical channels
+ * @devid: device id based on OWL SoC
  */
 struct owl_dma {
 	struct dma_device	dma;
@@ -214,6 +220,7 @@ struct owl_dma {
 
 	unsigned int		nr_vchans;
 	struct owl_dma_vchan	*vchans;
+	enum owl_dma_id		devid;
 };
 
 static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
@@ -354,6 +361,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				  struct dma_slave_config *sconfig,
 				  bool is_cyclic)
 {
+	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
 	u32 mode, ctrlb;
 
 	mode = OWL_DMA_MODE_PW(0);
@@ -409,8 +417,14 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 	lli->hw[OWL_DMADESC_DADDR] = dst;
 	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
 	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
-	lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
-	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
+
+	if (od->devid == S700_DMA) {
+		lli->hw[OWL_DMADESC_FLEN] = len;
+		lli->hw[OWL_DMADESC_CTRLB] = 1 | ctrlb;
+	} else {
+		lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
+		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
+	}
 
 	return 0;
 }
@@ -562,26 +576,35 @@ static irqreturn_t owl_dma_interrupt(int irq, void *dev_id)
 	dma_writel(od, OWL_DMA_IRQ_PD0, pending);
 
 	/* Check missed pending IRQ */
-	for (i = 0; i < od->nr_pchans; i++) {
-		pchan = &od->pchans[i];
-		chan_irq_pending = pchan_readl(pchan, OWL_DMAX_INT_CTL) &
-				   pchan_readl(pchan, OWL_DMAX_INT_STATUS);
-
-		/* Dummy read to ensure OWL_DMA_IRQ_PD0 value is updated */
-		dma_readl(od, OWL_DMA_IRQ_PD0);
+	if (od->devid == S900_DMA) {
+		for (i = 0; i < od->nr_pchans; i++) {
+			pchan = &od->pchans[i];
+			chan_irq_pending = pchan_readl(pchan,
+						       OWL_DMAX_INT_CTL) &
+					   pchan_readl(pchan,
+						       OWL_DMAX_INT_STATUS)
+							;
+
+			/* Dummy read to ensure OWL_DMA_IRQ_PD0 value is
+			 * updated
+			 */
+			dma_readl(od, OWL_DMA_IRQ_PD0);
 
-		global_irq_pending = dma_readl(od, OWL_DMA_IRQ_PD0);
+			global_irq_pending = dma_readl(od,
+						       OWL_DMA_IRQ_PD0);
 
-		if (chan_irq_pending && !(global_irq_pending & BIT(i)))	{
-			dev_dbg(od->dma.dev,
-				"global and channel IRQ pending match err\n");
+			if (chan_irq_pending && !(global_irq_pending &
+						  BIT(i))) {
+				dev_dbg(od->dma.dev,
+			"global and channel IRQ pending match err\n");
 
-			/* Clear IRQ status for this pchan */
-			pchan_update(pchan, OWL_DMAX_INT_STATUS,
-				     0xff, false);
+				/* Clear IRQ status for this pchan */
+				pchan_update(pchan, OWL_DMAX_INT_STATUS,
+					     0xff, false);
 
-			/* Update global IRQ pending */
-			pending |= BIT(i);
+				/* Update global IRQ pending */
+				pending |= BIT(i);
+			}
 		}
 	}
 
@@ -720,6 +743,7 @@ static int owl_dma_resume(struct dma_chan *chan)
 
 static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
 {
+	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
 	struct owl_dma_pchan *pchan;
 	struct owl_dma_txd *txd;
 	struct owl_dma_lli *lli;
@@ -741,9 +765,15 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
 		list_for_each_entry(lli, &txd->lli_list, node) {
 			/* Start from the next active node */
 			if (lli->phys == next_lli_phy) {
-				list_for_each_entry(lli, &txd->lli_list, node)
-					bytes += lli->hw[OWL_DMADESC_FLEN] &
-						 GENMASK(19, 0);
+				list_for_each_entry(lli, &txd->lli_list, node) {
+					if (od->devid == S700_DMA)
+						bytes +=
+						lli->hw[OWL_DMADESC_FLEN];
+					else
+						bytes +=
+						lli->hw[OWL_DMADESC_FLEN] &
+						GENMASK(19, 0);
+				}
 				break;
 			}
 		}
@@ -756,6 +786,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
 					 dma_cookie_t cookie,
 					 struct dma_tx_state *state)
 {
+	struct owl_dma *od = to_owl_dma(chan->device);
 	struct owl_dma_vchan *vchan = to_owl_vchan(chan);
 	struct owl_dma_lli *lli;
 	struct virt_dma_desc *vd;
@@ -773,8 +804,13 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
 	vd = vchan_find_desc(&vchan->vc, cookie);
 	if (vd) {
 		txd = to_owl_txd(&vd->tx);
-		list_for_each_entry(lli, &txd->lli_list, node)
-			bytes += lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
+		list_for_each_entry(lli, &txd->lli_list, node) {
+			if (od->devid == S700_DMA)
+				bytes += lli->hw[OWL_DMADESC_FLEN];
+			else
+				bytes += lli->hw[OWL_DMADESC_FLEN] &
+					 GENMASK(19, 0);
+		}
 	} else {
 		bytes = owl_dma_getbytes_chan(vchan);
 	}
@@ -1031,11 +1067,20 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
+static const struct of_device_id owl_dma_match[] = {
+	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
+	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, owl_dma_match);
+
 static int owl_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct owl_dma *od;
 	int ret, i, nr_channels, nr_requests;
+	const struct of_device_id *of_id =
+				of_match_device(owl_dma_match, &pdev->dev);
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
@@ -1060,6 +1105,8 @@ static int owl_dma_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
 		 nr_channels, nr_requests);
 
+	od->devid = (enum owl_dma_id)of_id->data;
+
 	od->nr_pchans = nr_channels;
 	od->nr_vchans = nr_requests;
 
@@ -1192,12 +1239,6 @@ static int owl_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id owl_dma_match[] = {
-	{ .compatible = "actions,s900-dma", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, owl_dma_match);
-
 static struct platform_driver owl_dma_driver = {
 	.probe	= owl_dma_probe,
 	.remove	= owl_dma_remove,
-- 
2.7.4


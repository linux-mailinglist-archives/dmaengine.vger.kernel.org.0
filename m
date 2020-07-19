Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFDB225322
	for <lists+dmaengine@lfdr.de>; Sun, 19 Jul 2020 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgGSRmr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Jul 2020 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRmr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Jul 2020 13:42:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23450C0619D2;
        Sun, 19 Jul 2020 10:42:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so9237153pgf.0;
        Sun, 19 Jul 2020 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROpEia7dLWxAWmZl3nniROlyoR2ai/hdFalKlJ7+0r0=;
        b=hdtU74xI2PSJMrcR7eeB8YUz5ry5qBF15yjM8wzCRPOIusnVGDIG7Ik8wwD6PFQ+/6
         rqHKysglE5Vjwq/7msvUlE7A992Az9DbRRvFtHLyQ7O+c+WagBonENthYPNggcZ9CVa9
         1FqJgpn0sGGLWaLE+kdRwnAoTpH7P/mVI4+rKseTX8uqfcy6cf/p6nzyFYCq0nczPf4e
         2eCc1Z0EW0N/NZhVuKa0L3NqO9p15dcwe+0/QPOeT4232DuhaalKnwEhqtJOWA9zXD6N
         rhcUA9DWas0ezXXTHG3yJDKjFp2jA+Ta0QdHG02OEmipxRXMGECvi+gOSPGOGhSkiKGY
         a4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROpEia7dLWxAWmZl3nniROlyoR2ai/hdFalKlJ7+0r0=;
        b=krellsXPxB/rO67eLucVMkYNslkKk6sS5m2cnHozsCufNdeNSJTvX8qD2iRI90HntU
         BP6/9L+l4qoK/t94AN2aSpgclOJOsCRz0oQG3JAT09KNlxrkzwsQi5auJ0UPmuVhPCmr
         S+6YHppyrERmZ5avlYymmhYzkF8zq0XoKfhAuS6H4Q0N95G0NFbU+fmtfWfDICYMMfEN
         kkNVFGKVF+8vzxzNuMZ0aW4flkzA8vi0IzjEbEuCxFBLF+LQuvT8mpRPy4qxvV8wJd5m
         xva4LKS64eVG+Fm/Q7c7pOF9XVPndyjVwpT0oOMDBTiWZvkmAr+u2uI9wyZ8k5zfenZG
         ur8A==
X-Gm-Message-State: AOAM532eXlsafn8cN9echoEdDr4S6XTY6pnP0UGAH/Y88bh+a4l6W0Pq
        BMgtkL3CIq6sPfKQJrXVoBA=
X-Google-Smtp-Source: ABdhPJzfhaW8f+pame1Kwgve316NFtOVEkmo54YcyrsYmswFqGPhqJa6taOaIUK2JDd19E90nrvkZQ==
X-Received: by 2002:a62:164a:: with SMTP id 71mr16773166pfw.266.1595180566550;
        Sun, 19 Jul 2020 10:42:46 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:45 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v7 03/10] dmaengine: Actions: Add support for S700 DMA engine
Date:   Sun, 19 Jul 2020 23:12:00 +0530
Message-Id: <1595180527-11320-4-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
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
Changes since v6:
	* NO change.
Changes since v5:
        * No change.
Changes since v4:
        * Reordered it from 02/10 to 03/10.
        * Used of_device_get_match_data() instead of
          of_match_device().
        * Removed the uintptr_t used for typecast.
Changes since v3:
        * Added description for enum fields.
        * Restored the old comment.
        * Added detailed comment about, the way FLEN
          and FCNT values are filled.
Changes since v2:
        * No change.
Changes since v1:
        * Defined macro for frame count value.
        * Introduced llc_hw_flen() from patch 2/9.
        * Removed the unnecessary line break.
Changes since rfc:
        * No change.
---
 drivers/dma/owl-dma.c | 57 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 948d1bead860..331c8d8b10a3 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -149,6 +149,11 @@ enum owl_dmadesc_offsets {
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
@@ -213,6 +218,7 @@ struct owl_dma_vchan {
  * @pchans: array of data for the physical channels
  * @nr_vchans: the number of physical channels
  * @vchans: array of data for the physical channels
+ * @devid: device id based on OWL SoC
  */
 struct owl_dma {
 	struct dma_device	dma;
@@ -227,6 +233,7 @@ struct owl_dma {
 
 	unsigned int		nr_vchans;
 	struct owl_dma_vchan	*vchans;
+	enum owl_dma_id		devid;
 };
 
 static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
@@ -316,6 +323,10 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
 {
 	u32 ctl;
 
+	/*
+	 * Irrespective of the SoC, ctrlb value starts filling from
+	 * bit 18.
+	 */
 	ctl = BIT_FIELD(int_ctl, 7, 0, 18);
 
 	return ctl;
@@ -372,6 +383,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 				  struct dma_slave_config *sconfig,
 				  bool is_cyclic)
 {
+	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
 	u32 mode, ctrlb;
 
 	mode = OWL_DMA_MODE_PW(0);
@@ -427,14 +439,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
 	lli->hw[OWL_DMADESC_DADDR] = dst;
 	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
 	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
-	/*
-	 * Word starts from offset 0xC is shared between frame length
-	 * (max frame length is 1MB) and frame count, where first 20
-	 * bits are for frame length and rest of 12 bits are for frame
-	 * count.
-	 */
-	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
-	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
+
+	if (od->devid == S700_DMA) {
+		/* Max frame length is 1MB */
+		lli->hw[OWL_DMADESC_FLEN] = len;
+		/*
+		 * On S700, word starts from offset 0x1C is shared between
+		 * frame count and ctrlb, where first 12 bits are for frame
+		 * count and rest of 20 bits are for ctrlb.
+		 */
+		lli->hw[OWL_DMADESC_CTRLB] = FCNT_VAL | ctrlb;
+	} else {
+		/*
+		 * On S900, word starts from offset 0xC is shared between
+		 * frame length (max frame length is 1MB) and frame count,
+		 * where first 20 bits are for frame length and rest of
+		 * 12 bits are for frame count.
+		 */
+		lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
+		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
+	}
 
 	return 0;
 }
@@ -596,7 +620,7 @@ static irqreturn_t owl_dma_interrupt(int irq, void *dev_id)
 
 		global_irq_pending = dma_readl(od, OWL_DMA_IRQ_PD0);
 
-		if (chan_irq_pending && !(global_irq_pending & BIT(i)))	{
+		if (chan_irq_pending && !(global_irq_pending & BIT(i))) {
 			dev_dbg(od->dma.dev,
 				"global and channel IRQ pending match err\n");
 
@@ -1054,6 +1078,13 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
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
@@ -1083,6 +1114,8 @@ static int owl_dma_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
 		 nr_channels, nr_requests);
 
+	od->devid = (enum owl_dma_id)of_device_get_match_data(&pdev->dev);
+
 	od->nr_pchans = nr_channels;
 	od->nr_vchans = nr_requests;
 
@@ -1215,12 +1248,6 @@ static int owl_dma_remove(struct platform_device *pdev)
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


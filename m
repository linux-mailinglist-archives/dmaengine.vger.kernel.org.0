Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03E1F37BC
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFIKRr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 06:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgFIKRo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Jun 2020 06:17:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDDC05BD1E;
        Tue,  9 Jun 2020 03:17:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so1211759pjd.0;
        Tue, 09 Jun 2020 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQdCRFfYdPppZGvtRf2Qw+IWmyFiiFu+29JBhbNDyN8=;
        b=gwR3G7PWt79JOA99k7n/mSRwpOh2VjLsZUwX0BsNQE3xxs0d6mFAg3MXK/V4K0y8OV
         uSGHffxdUDKNFEQfKJKMsraVQ3Wiap5RHxpsUVL8Ln7lXHWxJb7EySZmGMI4io1eBohp
         XePta9FC+Cbh+MXyQvZ1JTARhq3FZUWPySYvyryKSq41XZYyMkZDx41E+F2FeaDwZiSh
         6Upi2/cY994OFjcvXjGGKypFPfstRP0ji0W1Pts2gTsiQlqOz+Wvf376Ku/xxPISGRNr
         Xe/FynLFK6j9YfMz133sUCv7lvlVCRgFdJBQXsxRK63MoWgxgqi+dego6PFCnWLZFbB/
         KjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQdCRFfYdPppZGvtRf2Qw+IWmyFiiFu+29JBhbNDyN8=;
        b=tatLQYioIkOG+eqPPUKqJwjgcNVkz4/B+y0nIYG+j1GHQisVoC2VZ/6oUXUrVzYe1u
         Xt991tLUDMiq0NA80dbVbMyfAazU2qem2qlxGjPG70zhgvj+htrr4+ozxthzML/Ahoc3
         2hFMTCfgYnweu0R3nIIerSqzZbiOcX5mIMQJjvSbblIqAhY7n7joVP44sVZ9yE7jRIx/
         ygZ+L0ok6VWlHwJDYA6Kt6wyd7GyNqgwIW0JtTny7NXtHHtwdx2xGj1XBv3gLXu6zBWL
         8AR1iJ2uXpmFWQPK/1YCJOgbqXCNEVXHX3Nfn7Vzur0m8sSuP8TOGqSSsuSeHagnBqjL
         XcdA==
X-Gm-Message-State: AOAM530N58WdyxN4ghsjfE1N0I9peybYlVfQfESa9H6KzxWvdbHhe06U
        zUVWyyEtKFdhKBRaXh0feZY=
X-Google-Smtp-Source: ABdhPJwciG5MYDIMBgSNFzw7qXrwbjg3B1y2d56BPNz6SnwxdpXiInt4nZczfNrlUqO/UpXljWfUeQ==
X-Received: by 2002:a17:902:c3c3:: with SMTP id j3mr2687249plj.307.1591697861962;
        Tue, 09 Jun 2020 03:17:41 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:17:41 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA engine
Date:   Tue,  9 Jun 2020 15:47:02 +0530
Message-Id: <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
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
Changes since v3:
	* Provided detailed comment about, the way
	  shared DMA descriptor fields are programmed.
        * Fixed following clang compilation warning:
	  warning: cast to smaller integer type 'enum owl_dma_id' from 'const void *'
	  [-Wvoid-pointer-to-enum-cast]
Changes since v2:
	* No changes.
Changes since v1:
	* Moved llc_hw_flen() to patch 1/9.
	* provided comments about dma descriptor difference.
	  between S700 and S900.
Changes since RFC:
	* Added accessor function to get the frame lenght.
	* Removed the SoC specific check in IRQ routine.
---
 drivers/dma/owl-dma.c | 59 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 948d1bead860..f0c5425c06e7 100644
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
 
@@ -1054,11 +1078,20 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
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
@@ -1083,6 +1116,8 @@ static int owl_dma_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
 		 nr_channels, nr_requests);
 
+	od->devid = (enum owl_dma_id)(uintptr_t)of_id->data;
+
 	od->nr_pchans = nr_channels;
 	od->nr_vchans = nr_requests;
 
@@ -1215,12 +1250,6 @@ static int owl_dma_remove(struct platform_device *pdev)
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


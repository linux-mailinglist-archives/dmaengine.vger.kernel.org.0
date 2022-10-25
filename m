Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCC60C792
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJYJJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYJI1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:08:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288A15A972;
        Tue, 25 Oct 2022 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688687; x=1698224687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNYjV2Q3jC4jvrXHxiUxftt34rStJpI4LTWjKAnwEFc=;
  b=qZHpJ1bWsBP+Y6+req3uCPZU8mdWzoZWtMy5s0pcdjUTOj9Ej7k44KC9
   QouRnN59g6tF0b8j8Zj/Z4wH8WIRVSzV9qQJ9djV2vEHnsvEJA0zFUfOX
   uphWnI9sC5uQxdEGg/OSndXkJ5UBKFHFzk2fj9ccwXQP0oRf6O9Ddcsba
   nJJg9ETU6vK6y6bR7hJH/WYHNHH6GKQQn9RJV5/LVfoogpPbGER9YOSS4
   7uYFVcC6jVP1i4KXlyLpP1djI7K49ANfm2eki8SmNsNIJSItdMxqUH2vY
   FC0xQoafkHjt8norcVoqzqbr/ykvpqeCDgqBpeu0/ZV+N0BRyU7kWHFo/
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910281"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:38 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 29/32] dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
Date:   Tue, 25 Oct 2022 12:03:03 +0300
Message-ID: <20221025090306.297886-30-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"dma_common" name was misleading and did not suggest that's actually
a struct dma_device underneath. Rename it so that readers can follow the
code easier. One may see some checks and a warning when running
checkpatch. Those have nothing to do with the rename and will be addressed
in a further patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 92 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index edec6a8c730c..b2619600f68a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -338,7 +338,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
 
 /**
  * struct at_dma - internal representation of an Atmel HDMA Controller
- * @chan_common: common dmaengine dma_device object members
+ * @dma_device: dmaengine dma_device object members
  * @atdma_devtype: identifier of DMA controller compatibility
  * @ch_regs: memory mapped register base
  * @clk: dma controller clock
@@ -348,7 +348,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @chan: channels table to store at_dma_chan structures
  */
 struct at_dma {
-	struct dma_device	dma_common;
+	struct dma_device	dma_device;
 	void __iomem		*regs;
 	struct clk		*clk;
 	u32			save_imr;
@@ -368,7 +368,7 @@ struct at_dma {
 
 static inline struct at_dma *to_at_dma(struct dma_device *ddev)
 {
-	return container_of(ddev, struct at_dma, dma_common);
+	return container_of(ddev, struct at_dma, dma_device);
 }
 
 
@@ -1069,11 +1069,11 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 		if (!pending)
 			break;
 
-		dev_vdbg(atdma->dma_common.dev,
+		dev_vdbg(atdma->dma_device.dev,
 			"interrupt: status = 0x%08x, 0x%08x, 0x%08x\n",
 			 status, imr, pending);
 
-		for (i = 0; i < atdma->dma_common.chancnt; i++) {
+		for (i = 0; i < atdma->dma_device.chancnt; i++) {
 			atchan = &atdma->chan[i];
 			if (pending & (AT_DMA_BTC(i) | AT_DMA_ERR(i))) {
 				if (pending & AT_DMA_ERR(i)) {
@@ -2000,7 +2000,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 		 * We need controller-specific data to set up slave
 		 * transfers.
 		 */
-		BUG_ON(!atslave->dma_dev || atslave->dma_dev != atdma->dma_common.dev);
+		BUG_ON(!atslave->dma_dev || atslave->dma_dev != atdma->dma_device.dev);
 
 		/* if cfg configuration specified take it instead of default */
 		if (atslave->cfg)
@@ -2011,7 +2011,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 	for (i = 0; i < init_nr_desc_per_channel; i++) {
 		desc = atc_alloc_descriptor(chan, GFP_KERNEL);
 		if (!desc) {
-			dev_err(atdma->dma_common.dev,
+			dev_err(atdma->dma_device.dev,
 				"Only %d initial descriptors\n", i);
 			break;
 		}
@@ -2255,7 +2255,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		return irq;
 
 	/* discover transaction capabilities */
-	atdma->dma_common.cap_mask = plat_dat->cap_mask;
+	atdma->dma_device.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
 	atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
@@ -2299,16 +2299,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		cpu_relax();
 
 	/* initialize channels related values */
-	INIT_LIST_HEAD(&atdma->dma_common.channels);
+	INIT_LIST_HEAD(&atdma->dma_device.channels);
 	for (i = 0; i < plat_dat->nr_channels; i++) {
 		struct at_dma_chan	*atchan = &atdma->chan[i];
 
 		atchan->mem_if = AT_DMA_MEM_IF;
 		atchan->per_if = AT_DMA_PER_IF;
-		atchan->chan_common.device = &atdma->dma_common;
+		atchan->chan_common.device = &atdma->dma_device;
 		dma_cookie_init(&atchan->chan_common);
 		list_add_tail(&atchan->chan_common.device_node,
-				&atdma->dma_common.channels);
+				&atdma->dma_device.channels);
 
 		atchan->ch_regs = atdma->regs + ch_regs(i);
 		spin_lock_init(&atchan->lock);
@@ -2323,49 +2323,49 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	}
 
 	/* set base routines */
-	atdma->dma_common.device_alloc_chan_resources = atc_alloc_chan_resources;
-	atdma->dma_common.device_free_chan_resources = atc_free_chan_resources;
-	atdma->dma_common.device_tx_status = atc_tx_status;
-	atdma->dma_common.device_issue_pending = atc_issue_pending;
-	atdma->dma_common.dev = &pdev->dev;
+	atdma->dma_device.device_alloc_chan_resources = atc_alloc_chan_resources;
+	atdma->dma_device.device_free_chan_resources = atc_free_chan_resources;
+	atdma->dma_device.device_tx_status = atc_tx_status;
+	atdma->dma_device.device_issue_pending = atc_issue_pending;
+	atdma->dma_device.dev = &pdev->dev;
 
 	/* set prep routines based on capability */
-	if (dma_has_cap(DMA_INTERLEAVE, atdma->dma_common.cap_mask))
-		atdma->dma_common.device_prep_interleaved_dma = atc_prep_dma_interleaved;
+	if (dma_has_cap(DMA_INTERLEAVE, atdma->dma_device.cap_mask))
+		atdma->dma_device.device_prep_interleaved_dma = atc_prep_dma_interleaved;
 
-	if (dma_has_cap(DMA_MEMCPY, atdma->dma_common.cap_mask))
-		atdma->dma_common.device_prep_dma_memcpy = atc_prep_dma_memcpy;
+	if (dma_has_cap(DMA_MEMCPY, atdma->dma_device.cap_mask))
+		atdma->dma_device.device_prep_dma_memcpy = atc_prep_dma_memcpy;
 
-	if (dma_has_cap(DMA_MEMSET, atdma->dma_common.cap_mask)) {
-		atdma->dma_common.device_prep_dma_memset = atc_prep_dma_memset;
-		atdma->dma_common.device_prep_dma_memset_sg = atc_prep_dma_memset_sg;
-		atdma->dma_common.fill_align = DMAENGINE_ALIGN_4_BYTES;
+	if (dma_has_cap(DMA_MEMSET, atdma->dma_device.cap_mask)) {
+		atdma->dma_device.device_prep_dma_memset = atc_prep_dma_memset;
+		atdma->dma_device.device_prep_dma_memset_sg = atc_prep_dma_memset_sg;
+		atdma->dma_device.fill_align = DMAENGINE_ALIGN_4_BYTES;
 	}
 
-	if (dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)) {
-		atdma->dma_common.device_prep_slave_sg = atc_prep_slave_sg;
+	if (dma_has_cap(DMA_SLAVE, atdma->dma_device.cap_mask)) {
+		atdma->dma_device.device_prep_slave_sg = atc_prep_slave_sg;
 		/* controller can do slave DMA: can trigger cyclic transfers */
-		dma_cap_set(DMA_CYCLIC, atdma->dma_common.cap_mask);
-		atdma->dma_common.device_prep_dma_cyclic = atc_prep_dma_cyclic;
-		atdma->dma_common.device_config = atc_config;
-		atdma->dma_common.device_pause = atc_pause;
-		atdma->dma_common.device_resume = atc_resume;
-		atdma->dma_common.device_terminate_all = atc_terminate_all;
-		atdma->dma_common.src_addr_widths = ATC_DMA_BUSWIDTHS;
-		atdma->dma_common.dst_addr_widths = ATC_DMA_BUSWIDTHS;
-		atdma->dma_common.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-		atdma->dma_common.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+		dma_cap_set(DMA_CYCLIC, atdma->dma_device.cap_mask);
+		atdma->dma_device.device_prep_dma_cyclic = atc_prep_dma_cyclic;
+		atdma->dma_device.device_config = atc_config;
+		atdma->dma_device.device_pause = atc_pause;
+		atdma->dma_device.device_resume = atc_resume;
+		atdma->dma_device.device_terminate_all = atc_terminate_all;
+		atdma->dma_device.src_addr_widths = ATC_DMA_BUSWIDTHS;
+		atdma->dma_device.dst_addr_widths = ATC_DMA_BUSWIDTHS;
+		atdma->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+		atdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	}
 
 	dma_writel(atdma, EN, AT_DMA_ENABLE);
 
 	dev_info(&pdev->dev, "Atmel AHB DMA Controller ( %s%s%s), %d channels\n",
-	  dma_has_cap(DMA_MEMCPY, atdma->dma_common.cap_mask) ? "cpy " : "",
-	  dma_has_cap(DMA_MEMSET, atdma->dma_common.cap_mask) ? "set " : "",
-	  dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)  ? "slave " : "",
+	  dma_has_cap(DMA_MEMCPY, atdma->dma_device.cap_mask) ? "cpy " : "",
+	  dma_has_cap(DMA_MEMSET, atdma->dma_device.cap_mask) ? "set " : "",
+	  dma_has_cap(DMA_SLAVE, atdma->dma_device.cap_mask)  ? "slave " : "",
 	  plat_dat->nr_channels);
 
-	err = dma_async_device_register(&atdma->dma_common);
+	err = dma_async_device_register(&atdma->dma_device);
 	if (err) {
 		dev_err(&pdev->dev, "Unable to register: %d.\n", err);
 		goto err_dma_async_device_register;
@@ -2388,7 +2388,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	return 0;
 
 err_of_dma_controller_register:
-	dma_async_device_unregister(&atdma->dma_common);
+	dma_async_device_unregister(&atdma->dma_device);
 err_dma_async_device_register:
 	dma_pool_destroy(atdma->memset_pool);
 err_memset_pool_create:
@@ -2408,13 +2408,13 @@ static int at_dma_remove(struct platform_device *pdev)
 	at_dma_off(atdma);
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&atdma->dma_common);
+	dma_async_device_unregister(&atdma->dma_device);
 
 	dma_pool_destroy(atdma->memset_pool);
 	dma_pool_destroy(atdma->dma_desc_pool);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 
-	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
+	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
 		struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 
@@ -2443,7 +2443,7 @@ static int at_dma_prepare(struct device *dev)
 	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
-	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
+	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
 		struct at_dma_chan *atchan = to_at_dma_chan(chan);
 		/* wait for transaction completion (except in cyclic case) */
@@ -2478,7 +2478,7 @@ static int at_dma_suspend_noirq(struct device *dev)
 	struct dma_chan *chan, *_chan;
 
 	/* preserve data */
-	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
+	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
 		struct at_dma_chan *atchan = to_at_dma_chan(chan);
 
@@ -2528,7 +2528,7 @@ static int at_dma_resume_noirq(struct device *dev)
 
 	/* restore saved data */
 	dma_writel(atdma, EBCIER, atdma->save_imr);
-	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
+	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
 		struct at_dma_chan *atchan = to_at_dma_chan(chan);
 
-- 
2.25.1


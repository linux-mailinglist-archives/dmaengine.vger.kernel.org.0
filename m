Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3145959AE47
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiHTNAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbiHTM7Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B81AF;
        Sat, 20 Aug 2022 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000337; x=1692536337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaORr3egtpR/KWQ1DPRM89kswjkKEOpmdXKUvZbbRIU=;
  b=ds6O2rQ5Xi10IkamgHn0nH9/mzvnioNt936wAh8OyyndQ1Fa8DQ7L3AE
   Me0s3ZX7rzz43xD/YGB+fI2FZwlG49bgFuNiject/FbLOq/aMyjDzaSsg
   GlPVgs2L/MQ9UsXWOcWPVv+Mb1GD5EY5odZJowxCGpPAiEyi9u11U3d+9
   1LZjo6X214LBGCT8+bHYT4obnhYtRcwrl0RBJPhJ8ih+qJn04WBH/ITTT
   /ggVMZQ6NTfKrKA59NxSrxG1i4ts/9d1a34Cu78iT4H3sK3NSyjS+6cIu
   2UxHQTM33qohEnR9NS8glYHXlpNN8VItR2aJxi0dtADomcc8uftAHzHu9
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="173329512"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:53 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 27/33] dmaengine: at_hdmac: Use devm_platform_ioremap_resource
Date:   Sat, 20 Aug 2022 15:57:11 +0300
Message-ID: <20220820125717.588722-28-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820125717.588722-1-tudor.ambarus@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource() helper for cleanner code and easier
resource management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 85808cfda3cc..9c414f167b62 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2208,9 +2208,7 @@ static void at_dma_off(struct at_dma *atdma)
 
 static int __init at_dma_probe(struct platform_device *pdev)
 {
-	struct resource		*io;
 	struct at_dma		*atdma;
-	size_t			size;
 	int			irq;
 	int			err;
 	int			i;
@@ -2236,9 +2234,9 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (!atdma)
 		return -ENOMEM;
 
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!io)
-		return -EINVAL;
+	atdma->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(atdma->regs))
+		return PTR_ERR(atdma->regs);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2248,21 +2246,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
-	size = resource_size(io);
-	if (!request_mem_region(io->start, size, pdev->dev.driver->name))
-		return -EBUSY;
-
-	atdma->regs = ioremap(io->start, size);
-	if (!atdma->regs) {
-		err = -ENOMEM;
-		goto err_release_r;
-	}
-
 	atdma->clk = clk_get(&pdev->dev, "dma_clk");
-	if (IS_ERR(atdma->clk)) {
-		err = PTR_ERR(atdma->clk);
-		goto err_clk;
-	}
+	if (IS_ERR(atdma->clk))
+		return PTR_ERR(atdma->clk);
+
 	err = clk_prepare_enable(atdma->clk);
 	if (err)
 		goto err_clk_prepare;
@@ -2395,11 +2382,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	clk_disable_unprepare(atdma->clk);
 err_clk_prepare:
 	clk_put(atdma->clk);
-err_clk:
-	iounmap(atdma->regs);
-	atdma->regs = NULL;
-err_release_r:
-	release_mem_region(io->start, size);
 	return err;
 }
 
@@ -2407,7 +2389,6 @@ static int at_dma_remove(struct platform_device *pdev)
 {
 	struct at_dma		*atdma = platform_get_drvdata(pdev);
 	struct dma_chan		*chan, *_chan;
-	struct resource		*io;
 
 	at_dma_off(atdma);
 	if (pdev->dev.of_node)
@@ -2432,12 +2413,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	clk_disable_unprepare(atdma->clk);
 	clk_put(atdma->clk);
 
-	iounmap(atdma->regs);
-	atdma->regs = NULL;
-
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(io->start, resource_size(io));
-
 	return 0;
 }
 
-- 
2.25.1


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C581960C783
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiJYJHg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiJYJGV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:06:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FC15B11D;
        Tue, 25 Oct 2022 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688663; x=1698224663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9UoQovfFmM0YtiY/nUWq4KqxPZWJf5964xit0q5oTQo=;
  b=aqBq5wAGq3txlWqV1tc7y5LnLXJSNZJ/UdUdXnvANGXp209L0ZlxSRCb
   wMbuvhk3Pavso7npkYLoubQGG6RPPP9P58hjkF8Co+bSd/wyab1A1DLi6
   ZH0+Ae1/ByW3MxAo2fLk++OD+KTrq3L+FZRIJmHTIscg2VG3FwYKMnj1b
   VURYikp/0sbNW8fGg7F8fIdBZXcHz2xXEIGPoUU6xnq5z1e1kjcPRrERp
   SIVbQgUOT3ZzNOuJhBv5Wwk+0ra8bEfEr8NmOyIcVDjuLkqNxDMK63dgD
   z2toYtmjcJk0DDqvJVmRGM4n+ho5r/ET3LxavP5pyXRS4+oJbHmOD0atQ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="180386462"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:20 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:18 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 23/32] dmaengine: at_hdmac: Use devm_platform_ioremap_resource
Date:   Tue, 25 Oct 2022 12:02:57 +0300
Message-ID: <20221025090306.297886-24-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index f3fbb0aa8b24..10c250618a33 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1765,9 +1765,7 @@ static void at_dma_off(struct at_dma *atdma)
 
 static int __init at_dma_probe(struct platform_device *pdev)
 {
-	struct resource		*io;
 	struct at_dma		*atdma;
-	size_t			size;
 	int			irq;
 	int			err;
 	int			i;
@@ -1793,9 +1791,9 @@ static int __init at_dma_probe(struct platform_device *pdev)
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
@@ -1805,21 +1803,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_common.cap_mask = plat_dat->cap_mask;
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
@@ -1957,11 +1944,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
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
 
@@ -1969,7 +1951,6 @@ static int at_dma_remove(struct platform_device *pdev)
 {
 	struct at_dma		*atdma = platform_get_drvdata(pdev);
 	struct dma_chan		*chan, *_chan;
-	struct resource		*io;
 
 	at_dma_off(atdma);
 	if (pdev->dev.of_node)
@@ -1994,12 +1975,6 @@ static int at_dma_remove(struct platform_device *pdev)
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


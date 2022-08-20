Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88559AE31
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347149AbiHTNAh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347330AbiHTM7d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC77F256;
        Sat, 20 Aug 2022 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000340; x=1692536340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDyvtjdoUQ/ZE1kaAzbregn+LZl7wiMtfm/LN75pW6M=;
  b=gOnfhM7xACHZT/d9Fi8r69ZItsuYQshL1QadqLiUZJ7wzN5VMaXbFvHv
   crzNUGOjgPglUeWikS/0uMmKluQni9iqB2UTUMtZhNrHWNUxE0/mcgwI4
   iForr5YnkXh09Fw7WYURz85D6zL2vv4Ki267uz+zFXgUh/JK26mBBL2QH
   3tm5vwWmk9h0GyIx5ZXTaewdpSXHRJG4rxriUhkwFafg1O3gN/jkRRP9P
   X9inlO+Qiz4flMemH05p2/Vt6ytt8a/cBgmC5o1Pi0XHw6Ogqw8VIRuXp
   YcOJi0r0ToHewARw1f9U6fW/BJ0l4leXhuPbhzsLA/go4aAbkAtMBOgRg
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="187325871"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:59 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 28/33] dmaengine: at_hdmac: Use devm_request_irq()
Date:   Sat, 20 Aug 2022 15:57:12 +0300
Message-ID: <20220820125717.588722-29-tudor.ambarus@microchip.com>
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

IRQs requested with this function will be automatically freed on driver
detach. Use devm_request_irq() and make the code cleaner.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 9c414f167b62..96b885f83374 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2241,6 +2241,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
+	err = devm_request_irq(&pdev->dev, irq, at_dma_interrupt, 0,
+			       dev_name(&pdev->dev), atdma);
+	if (err)
+		return err;
 
 	/* discover transaction capabilities */
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
@@ -2257,10 +2261,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	/* force dma off, just in case */
 	at_dma_off(atdma);
 
-	err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
-	if (err)
-		goto err_irq;
-
 	platform_set_drvdata(pdev, atdma);
 
 	/* create a pool of consistent memory blocks for hardware descriptors */
@@ -2377,8 +2377,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 err_memset_pool_create:
 	dma_pool_destroy(atdma->dma_desc_pool);
 err_desc_pool_create:
-	free_irq(platform_get_irq(pdev, 0), atdma);
-err_irq:
 	clk_disable_unprepare(atdma->clk);
 err_clk_prepare:
 	clk_put(atdma->clk);
@@ -2397,7 +2395,6 @@ static int at_dma_remove(struct platform_device *pdev)
 
 	dma_pool_destroy(atdma->memset_pool);
 	dma_pool_destroy(atdma->dma_desc_pool);
-	free_irq(platform_get_irq(pdev, 0), atdma);
 
 	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
-- 
2.25.1


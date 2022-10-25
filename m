Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D160C60C782
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiJYJHb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiJYJF5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:05:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D4163382;
        Tue, 25 Oct 2022 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688660; x=1698224660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9hQ1oZ5mjOGtj70JKEN2QunnSSqI2AP8MBA7pO0V/8=;
  b=yEftSncB5jqJ5AVmWlxusH9cU+VwD1TWzDt06qx2nRKGHfc38dPvuoz0
   xf0Law1VyLZRxrvLVY63kvUswqFnUJMoRJQzV3khp3WeuEYDzh1n5Ni/C
   E/RISFImIJeCXB2TZiBGrF4L4PkKib1nwpRRf+6rWNF6AsTQNimDZQNUY
   +cy+RX32z/2nJhQC8U6L7876UXB1zb6nqDbRm+1va09cwy/GGTem7OQHa
   eg6lvrpvdnwhGOk+REptC8NeEl9JWVT5y5ZbpH7xYiNC1xGHcfmng6a61
   eiYiccmJ71BA70H9hZCkSmzf1cwnL2IdYzQ6bnQzcaNOXA5HniN52sD/4
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="120221371"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:15 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 22/32] dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
Date:   Tue, 25 Oct 2022 12:02:56 +0300
Message-ID: <20221025090306.297886-23-tudor.ambarus@microchip.com>
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

Use the resource-managed kzalloc to simplify error logic. Memory allocated
with this function is automatically freed on driver detach. Use
struct_size() helper to calculate the size of the atdma structure with its
trailing flexible array. While here, move the mem allocation higher in the
probe method, as failing to allocate memory indicates a serious system
issue, and everything else does not matter anyway. All these help the code
look a bit cleaner.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6bd9e35db8f9..f3fbb0aa8b24 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 
@@ -1786,6 +1787,12 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (!plat_dat)
 		return -ENODEV;
 
+	atdma = devm_kzalloc(&pdev->dev,
+			     struct_size(atdma, chan, plat_dat->nr_channels),
+			     GFP_KERNEL);
+	if (!atdma)
+		return -ENOMEM;
+
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io)
 		return -EINVAL;
@@ -1794,21 +1801,13 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	size = sizeof(struct at_dma);
-	size += plat_dat->nr_channels * sizeof(struct at_dma_chan);
-	atdma = kzalloc(size, GFP_KERNEL);
-	if (!atdma)
-		return -ENOMEM;
-
 	/* discover transaction capabilities */
 	atdma->dma_common.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
 	size = resource_size(io);
-	if (!request_mem_region(io->start, size, pdev->dev.driver->name)) {
-		err = -EBUSY;
-		goto err_kfree;
-	}
+	if (!request_mem_region(io->start, size, pdev->dev.driver->name))
+		return -EBUSY;
 
 	atdma->regs = ioremap(io->start, size);
 	if (!atdma->regs) {
@@ -1963,8 +1962,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->regs = NULL;
 err_release_r:
 	release_mem_region(io->start, size);
-err_kfree:
-	kfree(atdma);
 	return err;
 }
 
@@ -2003,8 +2000,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(io->start, resource_size(io));
 
-	kfree(atdma);
-
 	return 0;
 }
 
-- 
2.25.1


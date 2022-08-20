Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3415659AE0E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347129AbiHTNAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiHTM7Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C07E336;
        Sat, 20 Aug 2022 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000336; x=1692536336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70x6Ux9dtCRPdjl3BGLUlHE5yBnNcec5IO+lsG27vqQ=;
  b=YHHNKUMz9gj0mUPJJ92VaXPFKxMyi6uR8aL9MVmYUsxk2Tt/hv31FILR
   Tr2tThdeWCnN8nY2vL+rItLIXX1VVZPfSO1KMVQxi/+k5wp25btnZQfC/
   Hj7xSR2aOWJTPK+CptqhCNpA6jxc7gTp0d4p6iawO1XUG+wNrngj5uhy2
   iMqu4YT0J5fc/Gi6E96yjwAGLtltooSQNYkwZB5TKoPz0ASW3vnBLy9wQ
   PLEDtx0qw8ofcDir7NqirDB6Epbrr0oSzF5pBQ+8KdMT/hTpCayDCEAtk
   wGl39EHAUBQnzz7lZ3QgdxsoMPuCOYhnhDKdsHQFQxfZmvFZoCwwV6zvL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="109911828"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:52 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:49 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 26/33] dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
Date:   Sat, 20 Aug 2022 15:57:10 +0300
Message-ID: <20220820125717.588722-27-tudor.ambarus@microchip.com>
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
index f2c645e60619..85808cfda3cc 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 
@@ -2229,6 +2230,12 @@ static int __init at_dma_probe(struct platform_device *pdev)
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
@@ -2237,21 +2244,13 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	size = sizeof(struct at_dma);
-	size += plat_dat->nr_channels * sizeof(struct at_dma_chan);
-	atdma = kzalloc(size, GFP_KERNEL);
-	if (!atdma)
-		return -ENOMEM;
-
 	/* discover transaction capabilities */
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
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
@@ -2401,8 +2400,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->regs = NULL;
 err_release_r:
 	release_mem_region(io->start, size);
-err_kfree:
-	kfree(atdma);
 	return err;
 }
 
@@ -2441,8 +2438,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(io->start, resource_size(io));
 
-	kfree(atdma);
-
 	return 0;
 }
 
-- 
2.25.1


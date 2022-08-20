Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935DE59AE22
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbiHTNAj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbiHTM7o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F31113;
        Sat, 20 Aug 2022 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000344; x=1692536344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/HravYc3GPNkJyCgo/JRSQpzWjiTucJwMIBl87KVag=;
  b=q7kX/3tkGiDqhK2ebZ1o8RhXFZ/unPQmYRNB4JvrDIYFDXzRgen43je3
   SGtu9dLoKE0Omp49j1/p3Fgv5R/e1O7FESkBlgYPQRh6o35chwXSS4ZDx
   9iNDNz6E+l9lDDijIFCA+CATLSzfKjbnh5fNFzfqSMmTpxhBfwmzJEv4s
   /x3y28QaYLzc8jioaSSOqeUVXXSDZJsjreyMY4gKDgjAoGEkmYBYYMkrR
   vAclOAPcXuxj1HzwSftVwa1eFtZEaOvGYPGy4uL6OWPYmQPB6WNl6AxAS
   +tKzUvYNTra97qmZQ4jl+iFjoAptQUHwpguf0Ro8cWiSZCxL4njCYktM0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="187325896"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:59:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:59:02 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 29/33] dmaengine: at_hdmac: Use devm_clk_get()
Date:   Sat, 20 Aug 2022 15:57:13 +0300
Message-ID: <20220820125717.588722-30-tudor.ambarus@microchip.com>
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

Clocks that are get with this method will be automatically put on driver
detach. Use devm_clk_get() and simplify the error handling.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 96b885f83374..042c7cba74bb 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2250,13 +2250,13 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
-	atdma->clk = clk_get(&pdev->dev, "dma_clk");
+	atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
 	if (IS_ERR(atdma->clk))
 		return PTR_ERR(atdma->clk);
 
 	err = clk_prepare_enable(atdma->clk);
 	if (err)
-		goto err_clk_prepare;
+		return err;
 
 	/* force dma off, just in case */
 	at_dma_off(atdma);
@@ -2378,8 +2378,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_pool_destroy(atdma->dma_desc_pool);
 err_desc_pool_create:
 	clk_disable_unprepare(atdma->clk);
-err_clk_prepare:
-	clk_put(atdma->clk);
 	return err;
 }
 
@@ -2408,7 +2406,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(atdma->clk);
-	clk_put(atdma->clk);
 
 	return 0;
 }
-- 
2.25.1


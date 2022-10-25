Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682860C788
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJYJHo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiJYJGc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:06:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440749B6D;
        Tue, 25 Oct 2022 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688667; x=1698224667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2dHIbWPEA/klMV1uzBkl6AouHK73ZLrDvDFdf+YQBU=;
  b=ToVXI9LyVSlHlm7NQVc/f6WWMWmbPLIJ7gQcRhGCVY3R5FYy3c3RX4He
   ZtDcbDrJKUPJD3IWASSzkLWMrgArUY6FeVelZYxHfQwowwa6n+gtGZSu4
   iH7XAVAU6j+82byf1FFuDV2SBGRi+PAIEi3NpCE+3Hpjf38c0Lftto177
   IIEHnHZULjBS/UHX8K2pEJ5G6+gYyFuL+7a3M+GWPOT8XWrmK17Og+R1b
   veOlHcu9KF13a5KD0JyKYmwHhSbkVYk5ZYn/c2CpGhrXV6IedYU1UTJw5
   ZvbKWjoDYWM+PF8jJSlS7a3v/Gqv5NJ+fpmzxWvkggW02kXWvS/rGf/pr
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910199"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:23 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:21 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 24/32] dmaengine: at_hdmac: Use devm_clk_get()
Date:   Tue, 25 Oct 2022 12:02:58 +0300
Message-ID: <20221025090306.297886-25-tudor.ambarus@microchip.com>
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

Clocks that are get with this method will be automatically put on driver
detach. Use devm_clk_get() and simplify the error handling.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 10c250618a33..444aa7d75ff5 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1803,13 +1803,13 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_common.cap_mask = plat_dat->cap_mask;
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
@@ -1942,8 +1942,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	free_irq(platform_get_irq(pdev, 0), atdma);
 err_irq:
 	clk_disable_unprepare(atdma->clk);
-err_clk_prepare:
-	clk_put(atdma->clk);
 	return err;
 }
 
@@ -1973,7 +1971,6 @@ static int at_dma_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(atdma->clk);
-	clk_put(atdma->clk);
 
 	return 0;
 }
-- 
2.25.1


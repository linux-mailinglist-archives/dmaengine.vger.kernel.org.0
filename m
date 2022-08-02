Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E316587DE1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiHBOGj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBOGi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 10:06:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3A64E9;
        Tue,  2 Aug 2022 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659449195; x=1690985195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+bD6Zoxnh572tnDwsX2wJkJ1zD0vSVAl0vbD6JMWMAw=;
  b=yVTSdaYnnAJM2uLQI6PmQmG2M1eNB2/aU55TAUvAnPYXc1uLvBShevoJ
   kFit7NRE/eMc5+9vnqdmD3YZIWS/cN4WZdobQP2IkrUWLP9qdPBjggpA+
   2xeQlXj/MMGKOmoWTuO/OdoXuQZMO97T87CeJ8ea9A7k2xrFqtuK3Wn4u
   xWfMgBdB7YV0cMmNGWVpa88FbrruCGzZf041967MgJkbL9jZdqV1E5mR8
   txTDu+5zTd7GPweTL5lQ0eMW6Ew5UuUZlJUlnQgo4oUrEZrakpd5wOg93
   Mrd7Nlx5tLuem/PBZGu0GyUluEq5NDW/+A+Q94DmoyDrvNLv7CXSGHpQa
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="174586374"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 07:06:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 07:06:33 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 2 Aug 2022 07:06:31 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] dmaengine: at_xdmac: Replace two if statements with only one with two conditions
Date:   Tue, 2 Aug 2022 17:06:30 +0300
Message-ID: <20220802140630.243550-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a cosmetic change and replace two if statements with a single if
statement with two conditions. In case the optional txstate parameter is
NULL, we return the dma_cookie_status, which is fine, no functional change
required.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index def564d1e8fa..0aa3ae8d61e4 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1463,10 +1463,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	bool			initd;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
-
-	if (!txstate)
+	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-- 
2.25.1


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A166967E4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjBNPVW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjBNPVP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:21:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599E2B2BF;
        Tue, 14 Feb 2023 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388064; x=1707924064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJhtvYwUVrba315GfdJC2HmxllCdahamNor2uBxDCIY=;
  b=NCUktWhS+w8J13MoG5m+n1P6WI45e3A4Nw2w46/QQCANthT39AfMCDcV
   PgBRM4jswAYUMm/Sc37cxy4kgaUYxBBkQdopM3Vfkr10arp+OXrvTE/k3
   S0ySYAGfEIHs1JvYbJLcOWS1DDiPT8gthJDGUFS01F25IUSCNdWdyVdSk
   gUq1bdbLoFV/trwD6OjFao7psYmYCIgBPRyuOc7pcWexbQtRx9dI09I11
   s/qaudM2jRJYZiEeJrECREkYqg7vZs/qdRy6Co8FrGeX1gLU8qD3dHobC
   +x6soy1lbO6RYVGFjIpy30iVPFTJq3eLAuNiSu8IrLR66BIjCrdnEktA2
   g==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="211939093"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:21:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:21:01 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/7] dmaengine: at_xdmac: align declaration of ret with the rest of variables
Date:   Tue, 14 Feb 2023 17:18:27 +0200
Message-ID: <20230214151827.1050280-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
References: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Align the declaration of ret in atmel_xdmac_resume() with the rest of
variables. Do this by adding ret to the line with declaration for i
variable.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7ff6ca01e0b5..7da6d9b6098e 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2181,8 +2181,7 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	struct platform_device	*pdev = container_of(dev, struct platform_device, dev);
-	int			i;
-	int ret;
+	int			i, ret;
 
 	ret = clk_prepare_enable(atxdmac->clk);
 	if (ret)
-- 
2.34.1


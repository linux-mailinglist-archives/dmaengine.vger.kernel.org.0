Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC924251C6
	for <lists+dmaengine@lfdr.de>; Thu,  7 Oct 2021 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhJGLPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 07:15:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhJGLPP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Oct 2021 07:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605201; x=1665141201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9G5mkeuHGSDm1qX15Pe+VCWC7BU1ZpOu7l6FKVirsw=;
  b=d6vU4hanDWJON8eosYAOEC3Mp6za+mhbvRcFalxVkI51W9D8MBvfAHnE
   BOdK+dnQTFWSd7bngXa2MSxkbwtZa4jLt73NqigpNsvE9S94QOyH2LNa4
   bzxH3gv13nvEVzLcaR9a1bd7z+Bf755kJQ2SsLBrI4vKfLDMrT1Z+Uhv6
   qmAcSRiZ+xwQcb43YUfmt1JzPXAW/RPSPFBh7jp3ioF648rXmpAI/5hU9
   lsiU9hioY1jFbsfVH4M3HqLHMSk3u0bOkgeigI4a9XDPP1FxvO+Hrf0jR
   vl7DmM5SRWoYBsxdnaA0wQ3gR2LIQe6wsRqrWDg3CwuAJtpB2SRChGpIA
   Q==;
IronPort-SDR: kcro7hrD7NmMGEweJg3yv4RNzMnDVLIjjErXwvQyrjd/JZ6pNdkYn+7e20rkthgL8TQBe2SrSQ
 I5ghwPvM1LNlr1PhRs8/X1pYy3LJ/0H25PrtSDgYC+crwajfC6/CVedexWmVTKlvoGaFK813ct
 VX0Om9V30uJn6RneQCKWPYP6yleP385Atq/ynqN15llv1lU6luf/aNhSsWm6+AbZDEVRrYyv0w
 8X2I5pRxp0BTOwxbqZ5j/MnJweOW0VoStEscKG+RDsV4DebJ/JT/0wWU741KHygQ/jnW5zLYOg
 k1TD3DI+QSXwOiWezjBMM6UI
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="147120373"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:13:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:13:20 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:13:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] dmaengine: at_xdmac: call at_xdmac_axi_config() on resume path
Date:   Thu, 7 Oct 2021 14:12:27 +0300
Message-ID: <20211007111230.2331837-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

at_xdmac could be used on SoCs which supports backup mode (where most
of the SoC power, including power to DMA controller, is closed at suspend
time). Thus, on resume, the settings which were previously done need to be
restored. Do the same for axi configuration.

Fixes: f40566f220a1 ("dmaengine: at_xdmac: add AXI priority support and recommended settings")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 51 ++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ab78e0f6afd7..c66ad5706cb5 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1926,6 +1926,30 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
 	return;
 }
 
+static void at_xdmac_axi_config(struct platform_device *pdev)
+{
+	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
+	bool dev_m2m = false;
+	u32 dma_requests;
+
+	if (!atxdmac->layout->axi_config)
+		return; /* Not supported */
+
+	if (!of_property_read_u32(pdev->dev.of_node, "dma-requests",
+				  &dma_requests)) {
+		dev_info(&pdev->dev, "controller in mem2mem mode.\n");
+		dev_m2m = true;
+	}
+
+	if (dev_m2m) {
+		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_M2M);
+		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_M2M);
+	} else {
+		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_P2M);
+		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_P2M);
+	}
+}
+
 #ifdef CONFIG_PM
 static int atmel_xdmac_prepare(struct device *dev)
 {
@@ -1975,6 +1999,7 @@ static int atmel_xdmac_resume(struct device *dev)
 	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
+	struct platform_device	*pdev = container_of(dev, struct platform_device, dev);
 	int			i;
 	int ret;
 
@@ -1982,6 +2007,8 @@ static int atmel_xdmac_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	at_xdmac_axi_config(pdev);
+
 	/* Clear pending interrupts. */
 	for (i = 0; i < atxdmac->dma.chancnt; i++) {
 		atchan = &atxdmac->chan[i];
@@ -2007,30 +2034,6 @@ static int atmel_xdmac_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static void at_xdmac_axi_config(struct platform_device *pdev)
-{
-	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
-	bool dev_m2m = false;
-	u32 dma_requests;
-
-	if (!atxdmac->layout->axi_config)
-		return; /* Not supported */
-
-	if (!of_property_read_u32(pdev->dev.of_node, "dma-requests",
-				  &dma_requests)) {
-		dev_info(&pdev->dev, "controller in mem2mem mode.\n");
-		dev_m2m = true;
-	}
-
-	if (dev_m2m) {
-		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_M2M);
-		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_M2M);
-	} else {
-		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_P2M);
-		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_P2M);
-	}
-}
-
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
-- 
2.25.1


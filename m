Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A146D73A0
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjDEFL3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 01:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjDEFL2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 01:11:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD53F3A8E;
        Tue,  4 Apr 2023 22:11:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3355BGvn027461;
        Wed, 5 Apr 2023 00:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680671476;
        bh=HyY5f+LPZ0dJBsWVVmO0EyBFssVpLwhs+Kw/bLISOo4=;
        h=From:To:CC:Subject:Date;
        b=bFtq/B0Pl/rvCzKNtCCiSprdYF5ys8GU91Z4rguSdCnPDmcvcyDBQ5/x1PDEnH9/a
         /iB7FA5dC/jMs5GaX4MC1GJidjzoHSgtB8Ck2L7WwxLG0WgOi/lr31rxqinjqqqe6q
         iuBfFpIJ9dZ/zXS0b0f8DjmWdrVn18Vt+SyjfX6s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3355BGsc088122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 00:11:16 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 00:11:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 00:11:16 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3355BDNJ066548;
        Wed, 5 Apr 2023 00:11:13 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma-glue: do not create glue dma devices for udma channels
Date:   Wed, 5 Apr 2023 10:41:12 +0530
Message-ID: <20230405051112.1364277-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

In case K3 DMA glue layer is using UDMA channels (AM65/J721E/J7200) it
doesn't need to create own DMA devices per RX/TX channels as they are never
used and just waste resources. The UDMA based platforms are coherent and
UDMA device iteslf is used for DMA memory management.

Hence, update K3 DMA glue layer to create K3 DMA glue DMA devices per RX/TX
channels only in case of PKTDMA (AM64) where coherency configurable per DMA
channel.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes from v1:
- Add missing put_device() at all 3 occurrences:
  * In k3_udma_glue_request_tx_chn()
  * In k3_udma_glue_request_rx_chn_priv()
  * In k3_udma_glue_request_remote_rx_chn()

v1:
https://lore.kernel.org/all/20230404081158.1266530-1-s-vadapalli@ti.com/

 drivers/dma/ti/k3-udma-glue.c | 73 ++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 789193ed0386..ab8ac52e38e4 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -293,19 +293,19 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	}
 	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
 
-	tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
-	tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
-	dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
-		     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
-	ret = device_register(&tx_chn->common.chan_dev);
-	if (ret) {
-		dev_err(dev, "Channel Device registration failed %d\n", ret);
-		put_device(&tx_chn->common.chan_dev);
-		tx_chn->common.chan_dev.parent = NULL;
-		goto err;
-	}
-
 	if (xudma_is_pktdma(tx_chn->common.udmax)) {
+		tx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
+		tx_chn->common.chan_dev.parent = xudma_get_device(tx_chn->common.udmax);
+		dev_set_name(&tx_chn->common.chan_dev, "tchan%d-0x%04x",
+			     tx_chn->udma_tchan_id, tx_chn->common.dst_thread);
+		ret = device_register(&tx_chn->common.chan_dev);
+		if (ret) {
+			dev_err(dev, "Channel Device registration failed %d\n", ret);
+			put_device(&tx_chn->common.chan_dev);
+			tx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		tx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&tx_chn->common.chan_dev,
@@ -912,19 +912,19 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	}
 	rx_chn->udma_rchan_id = xudma_rchan_get_id(rx_chn->udma_rchanx);
 
-	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
-	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
-	dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
-		     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
-	ret = device_register(&rx_chn->common.chan_dev);
-	if (ret) {
-		dev_err(dev, "Channel Device registration failed %d\n", ret);
-		put_device(&rx_chn->common.chan_dev);
-		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
-	}
-
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
+		rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
+		dev_set_name(&rx_chn->common.chan_dev, "rchan%d-0x%04x",
+			     rx_chn->udma_rchan_id, rx_chn->common.src_thread);
+		ret = device_register(&rx_chn->common.chan_dev);
+		if (ret) {
+			dev_err(dev, "Channel Device registration failed %d\n", ret);
+			put_device(&rx_chn->common.chan_dev);
+			rx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		rx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
@@ -1044,19 +1044,20 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		goto err;
 	}
 
-	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
-	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
-	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
-		     rx_chn->common.src_thread);
-	ret = device_register(&rx_chn->common.chan_dev);
-	if (ret) {
-		dev_err(dev, "Channel Device registration failed %d\n", ret);
-		put_device(&rx_chn->common.chan_dev);
-		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
-	}
-
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
+		rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
+		rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
+		dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
+			     rx_chn->common.src_thread);
+
+		ret = device_register(&rx_chn->common.chan_dev);
+		if (ret) {
+			dev_err(dev, "Channel Device registration failed %d\n", ret);
+			put_device(&rx_chn->common.chan_dev);
+			rx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		rx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
-- 
2.25.1


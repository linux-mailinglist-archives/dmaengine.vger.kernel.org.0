Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A756D5A7A
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjDDIN2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjDDIN1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 04:13:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81A42133;
        Tue,  4 Apr 2023 01:13:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3348C2hY026278;
        Tue, 4 Apr 2023 03:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680595922;
        bh=TqZ5qDDcfhD6dFOZqTpAdYtWhunUPEFwnBfFY1A7eHE=;
        h=From:To:CC:Subject:Date;
        b=Xo7da6GYAnGNIAIQ+RZ1I/yvOh5k4jhmUheikcR7roDblKurto+gLGZV2XTsZD7EJ
         Z+pC7kA2I7/N981GJGeCRVsuXvDsaN/7jdz/L3srddmcabSs4TZUcWqTeXxE422ZUy
         LOatSOEZWqjmlcDnT76+NuDbjWQz9xAbP+hv0Fas=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3348C2gw028878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 03:12:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 03:12:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 03:12:01 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3348BxjR035955;
        Tue, 4 Apr 2023 03:11:59 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: do not create glue dma devices for udma channels
Date:   Tue, 4 Apr 2023 13:41:58 +0530
Message-ID: <20230404081158.1266530-1-s-vadapalli@ti.com>
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
 drivers/dma/ti/k3-udma-glue.c | 70 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 789193ed0386..b0c9572b0d02 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -293,19 +293,18 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
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
+			tx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		tx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&tx_chn->common.chan_dev,
@@ -912,19 +911,18 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
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
+			rx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		rx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
@@ -1044,19 +1042,19 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
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
+			rx_chn->common.chan_dev.parent = NULL;
+			goto err;
+		}
+
 		/* prepare the channel device as coherent */
 		rx_chn->common.chan_dev.dma_coherent = true;
 		dma_coerce_mask_and_coherent(&rx_chn->common.chan_dev,
-- 
2.25.1


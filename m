Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1E649D18
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLLLH5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiLLLHO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 06:07:14 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4C511A1B;
        Mon, 12 Dec 2022 02:54:43 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsa0B007740;
        Mon, 12 Dec 2022 04:54:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670842476;
        bh=lSeG+4HQ3gyOii17ukc7PlcSnkdUoIsNZqiqck3q650=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KoPEPG/tnwm0WVfTVa96ve2FT5tDrYG0Lonc2BZwv43YD1JYLP5V+r95Lg9wEPh/P
         9gaAJNVXF8lWmVXDoln5Ag/e7+43hyquDqAHzx5Ei2yDhflnfpvQJIbZWBUzOHZ+06
         JNkNIpVt5rdA//VE6Mf0uS72MQPumvccFmNpy+jA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BCAsaHT026467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Dec 2022 04:54:36 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 12
 Dec 2022 04:54:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 12 Dec 2022 04:54:36 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsJVL035634;
        Mon, 12 Dec 2022 04:54:34 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 5/5] dmaengine: ti: k3-udma: Add support for BCDMA CSI RX
Date:   Mon, 12 Dec 2022 16:24:16 +0530
Message-ID: <20221212105416.3628442-6-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212105416.3628442-1-vigneshr@ti.com>
References: <20221212105416.3628442-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

BCDMA CSI RX present on AM62Ax SoC is a dedicated DMA for servicing
Camera Serial Interface (CSI) IP. Add support for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c1005d17b42e..1d3d1b387b96 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -135,6 +135,7 @@ struct udma_match_data {
 	u32 flags;
 	u32 statictr_z_mask;
 	u8 burst_size[3];
+	struct udma_soc_data *soc_data;
 };
 
 struct udma_soc_data {
@@ -4295,6 +4296,25 @@ static struct udma_match_data j721e_mcu_data = {
 	},
 };
 
+static struct udma_soc_data am62a_dmss_csi_soc_data = {
+	.oes = {
+		.bcdma_rchan_data = 0xe00,
+		.bcdma_rchan_ring = 0x1000,
+	},
+};
+
+static struct udma_match_data am62a_bcdma_csirx_data = {
+	.type = DMA_TYPE_BCDMA,
+	.psil_base = 0x3100,
+	.enable_memcpy_support = false,
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
+	.soc_data = &am62a_dmss_csi_soc_data,
+};
+
 static struct udma_match_data am64_bcdma_data = {
 	.type = DMA_TYPE_BCDMA,
 	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
@@ -4344,6 +4364,10 @@ static const struct of_device_id udma_of_match[] = {
 		.compatible = "ti,am64-dmss-pktdma",
 		.data = &am64_pktdma_data,
 	},
+	{
+		.compatible = "ti,am62a-dmss-bcdma-csirx",
+		.data = &am62a_bcdma_csirx_data,
+	},
 	{ /* Sentinel */ },
 };
 
@@ -5274,12 +5298,15 @@ static int udma_probe(struct platform_device *pdev)
 	}
 	ud->match_data = match->data;
 
-	soc = soc_device_match(k3_soc_devices);
-	if (!soc) {
-		dev_err(dev, "No compatible SoC found\n");
-		return -ENODEV;
+	ud->soc_data = ud->match_data->soc_data;
+	if (!ud->soc_data) {
+		soc = soc_device_match(k3_soc_devices);
+		if (!soc) {
+			dev_err(dev, "No compatible SoC found\n");
+			return -ENODEV;
+		}
+		ud->soc_data = soc->data;
 	}
-	ud->soc_data = soc->data;
 
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
-- 
2.38.1


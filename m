Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861016F7F00
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 10:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEEI2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjEEI2T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 04:28:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800B18927;
        Fri,  5 May 2023 01:27:07 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q819003857;
        Fri, 5 May 2023 03:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683275168;
        bh=dDL1Ix5ed3FpBkik2TeAdp7w4F8HGFiJXQbTgcTMItg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mD5O5x5drXSMEGikaubI8ZijpDUdjYwNgSi1FDfuahvxzryN4xJxKHQR0BaXmKgmM
         PtVyGYAalrXyFV/IiX5CeMXc8umGhPmE7TwaoqD+lj4EdyoVqk73wXW1kj2e3pHIML
         wSzUpgAWFi5tQe8mGp5pQI7fwqbg9bzSeLbHqknY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3458Q84k035321
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 03:26:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 03:26:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 03:26:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q6Yo120576;
        Fri, 5 May 2023 03:26:07 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v2 2/2] dmaengine: ti: k3-udma: Add support for J721S2 CSI BCDMA instance
Date:   Fri, 5 May 2023 13:56:02 +0530
Message-ID: <20230505082602.31783-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505082602.31783-1-vaishnav.a@ti.com>
References: <20230505082602.31783-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

J721S2 has dedicated BCDMA instance for Camera Serial Interface RX
and TX. The BCDMA instance supports RX and TX channels but block copy
channels are not present, add support for the same.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/dma/ti/k3-udma.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fc3a2a05ab7b..16c5c333808b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4308,6 +4308,15 @@ static struct udma_soc_data am62a_dmss_csi_soc_data = {
 	},
 };
 
+static struct udma_soc_data j721s2_bcdma_csi_soc_data = {
+	.oes = {
+		.bcdma_tchan_data = 0x800,
+		.bcdma_tchan_ring = 0xa00,
+		.bcdma_rchan_data = 0xe00,
+		.bcdma_rchan_ring = 0x1000,
+	},
+};
+
 static struct udma_match_data am62a_bcdma_csirx_data = {
 	.type = DMA_TYPE_BCDMA,
 	.psil_base = 0x3100,
@@ -4346,6 +4355,18 @@ static struct udma_match_data am64_pktdma_data = {
 	},
 };
 
+static struct udma_match_data j721s2_bcdma_csi_data = {
+	.type = DMA_TYPE_BCDMA,
+	.psil_base = 0x2000,
+	.enable_memcpy_support = false,
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
+	.soc_data = &j721s2_bcdma_csi_soc_data,
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am654-navss-main-udmap",
@@ -4373,6 +4394,10 @@ static const struct of_device_id udma_of_match[] = {
 		.compatible = "ti,am62a-dmss-bcdma-csirx",
 		.data = &am62a_bcdma_csirx_data,
 	},
+	{
+		.compatible = "ti,j721s2-dmss-bcdma-csi",
+		.data = &j721s2_bcdma_csi_data,
+	},
 	{ /* Sentinel */ },
 };
 
-- 
2.17.1


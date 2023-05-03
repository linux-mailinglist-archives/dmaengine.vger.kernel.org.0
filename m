Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660976F5062
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjECGxT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 02:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjECGxS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 02:53:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C62684;
        Tue,  2 May 2023 23:53:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3436r7iD015967;
        Wed, 3 May 2023 01:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683096787;
        bh=dDL1Ix5ed3FpBkik2TeAdp7w4F8HGFiJXQbTgcTMItg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MWV6/DKAaut9rrmb1aPB1cvas7X8I34+NweCC4JQ3ecLXKTvBzgkbY8IK2ZPNsVRc
         C1HZMCa9KWBNrxMJkRy8QOE8I/scqGv1wb2sp9KVUegVdLjGmA74ZxYCX9N7EUxYXV
         IqmFe5PvPQNwKeMn9nuFUae7aaPMSD3+DmXr5GAs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3436r7mQ126813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 01:53:07 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 01:53:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 01:53:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3436r6s4083088;
        Wed, 3 May 2023 01:53:06 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 2/2] dmaengine: ti: k3-udma: Add support for J721S2 CSI BCDMA instance
Date:   Wed, 3 May 2023 12:23:03 +0530
Message-ID: <20230503065303.16674-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230503065303.16674-1-vaishnav.a@ti.com>
References: <20230503065303.16674-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


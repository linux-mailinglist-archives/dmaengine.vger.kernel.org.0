Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4662E2574A0
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgHaHwL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:52:11 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbgHaHv6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:51:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPIfVh+PcqPFgS4E3PVdHFxKDEaqUZSF/rYFooskQtrEvtxqa3ZHZ+Wc+xJ6c4Sj5V8pZ5Pj6SSfC9WpF7PFvUsCy6NTtrxTQRXHRDPABV/kcrUNnVPaWDan8wiHWA2vyZ+IEm2BPrxwHfN/SGsXt9soS73N+hWAEgDnb3A2OwVYN+PfQqQ215M/xktFXxkFTytSpZIOaUU9RybaHCuUfyVc5SVdoOw1JPQJEZWYKtbVo2GQ/TKxAW44+YDuNZlBCatweI+HSbrlKC/qj2VF+08RRFB6y5cdVHLmRJoYBzWihfw26QY8jDxiiQjPNDl32+VvahQAcEyjTNiG8tgAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDfHy8Hv7RnomQuRhGndIyDNhmOpj00PCTCtTZJsaoQ=;
 b=EiXICqGwnoFr08iWTbxa0cf2E0FQTc9KLvfVgHeHdEF+RIZEhTYkUtabUufC44w8ORoEmMgIx9q1Q//dvoVz+E/5NZ0AtnxCTzsa5p2hM/m0lgwqjGKTAGH2VvaNRJXy4KZ6pQCJnQvk3VQS0+xvuPta8hxsNkv+Eg/6SHuNxkec5fNgqA3/3MtblOv0e5jl0+dBTg9Emd3bN7SwCfBtthlt9P1t/Tecje7y51vn2IoPNmemqvr40ZH/h64PvSwz2yaYoNrMm5pbGab95NkDeI7HOUIbi2AO5PSqt7HoEeES7wSBai32tAPQV0E4AQvGD0v4tZATuvpy560uJf63HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDfHy8Hv7RnomQuRhGndIyDNhmOpj00PCTCtTZJsaoQ=;
 b=Y+9szm+c3643ANcJfTD/rjV0HdVuewR67+0wtDFBqulgaq1fKY7547jFEiVaU+CizL8LrGhzhhxEQS2znTzNyMS8R8gjtbizhAf54sUSm4WZyZoWHqyLocyEm13jULfuvlYt8XEheq9BENiUZbLkVxR6+i5mq210x/WM93YGjDI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:29 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Tue,  1 Sep 2020 00:03:22 +0800
Message-Id: <1598889805-30399-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccafa2d5-cd22-4d81-3d60-08d84d82abba
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694E80F4C2E17AF7524F8B689510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zEww/S6gFPspmp1gnyXCEBIVH/9UTmSO7BYhmSjYNzht0iC1p++Ngyi0AfKiL9OkpqouA1eL2LhUsVTMVWgi8fsyH1Ips5gpd8Soz4PEmWykf/ANOcE0P5i6qHxQmDx97XbWonXKCiPITxtIEXLmlQgSQFxV5kw4vaE0X9oGVUqCU9an/jlbfzHewr8Jx6HvWJRoTpdxHS2jsOCxCO6nc69tzV5Lvty1aQLu4gBpyjYkSr3fH0bBu3oKTLpjX2zBvsvpcR5UJpPJ8GvvP7BqINZal1b2tohAlZ0mNphaz4UaHvGCHLaeOjCIK8CUwhBNZ2XwUSawuJKOdO4XKlBHEaTVpAaS4YpNfS21luWl12u0EuvkoVRHla6jXTa3QSxuB3B6DSbIjh4BasFoYt52IZXNHrdnAuj23wiP0c8xQAAeGp8uN6gfvOHpZwAK6LrSmCS8sBVq63Eu6uNLOZC5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(966005)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: deMQ6budwCANQrSwYG1VwPi32tC4dvOErXGkKX+123GadDd2UAfmvDh0LPriwHWNLgYTD5yZcyaiyckLg8lkqtqHMWcbxzST5yCXDGCzuehGyHGF96FyUfXLVQHeyj4hX16hIeV3ECXltvzyTU9mrFHIYZsGK8TWGHx9owwRRUS43fBnxy2CeOK/1RFTCi0G2fZyP8WJ9d3gSPi/QCQ4tfWbqXTXC0Jc3eMjgDDsgwd+ejKziamvD4JdgESHFY3Y+zdclwkqKs86+esjhKD8Xenx9gi14eT1bCFjHfD+VymIaPKOyWziK4suzMFZ7g9Wfb8h3s5vJIDByaq1M7EJ33XvB5Wc3HzTcIf7YbcIYsHKSpnjihZTti98oropFjH4NwBVpkdltv7hYexuu41dMjTd7b6Loub2+1Ct22xSX/OlVDEaT5L40HiOoHoCHKd6KjKPpjEDrwSjwBqURtyglihAyYcZTZRAlUjcVEW2bR4Ozm1tWSgc5SDKWzEYMd8olrzjar79LdpoKyYyy7/WvBAX4Az3e/gIyQe5fy8uztTdcVw5iKcZWdVREgTv5MZLeDH3mTt/7ywof/OUJeRFDRcv2qDMVErqd0fGOeXT1nLUWghXfkHt7Jre1XQUYCRMEAIwoohbvh6+VyS+AByMrQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccafa2d5-cd22-4d81-3d60-08d84d82abba
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:29.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kte4/oe8C4piU5f71KGGL6z8oTQSqlkGT5VnMqPhB/OZ6eXXmCkSLTvT5J1H16Yt7IGDdmXwIhp3OORDmyNx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fb522a1..147ea88 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -422,6 +422,13 @@ struct sdma_driver_data {
 	int num_events;
 	struct sdma_script_start_addrs	*script_addrs;
 	bool check_ratio;
+	/*
+	 * ecspi ERR009165 fixed should be done in sdma script
+	 * and it has been fixed in soc from i.mx6ul.
+	 * please get more information from the below link:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool ecspi_fixed;
 };
 
 struct sdma_engine {
@@ -543,6 +550,13 @@ static struct sdma_driver_data sdma_imx6q = {
 	.script_addrs = &sdma_script_imx6q,
 };
 
+static struct sdma_driver_data sdma_imx6ul = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6q,
+	.ecspi_fixed = true,
+};
+
 static struct sdma_script_start_addrs sdma_script_imx7d = {
 	.ap_2_ap_addr = 644,
 	.uart_2_mcu_addr = 819,
@@ -591,6 +605,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -607,6 +624,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1176,8 +1194,17 @@ static int sdma_config_channel(struct dma_chan *chan)
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
-		} else
+		} else {
+			/*
+			 * ERR009165 fixed from i.mx6ul, no errata need,
+			 * set bit31 to let sdma script skip the errata.
+			 */
+			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
+			    sdmac->direction == DMA_MEM_TO_DEV &&
+			    sdmac->sdma->drvdata->ecspi_fixed)
+				__set_bit(31, &sdmac->watermark_level);
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
+		}
 
 		/* Address */
 		sdmac->shp_addr = sdmac->per_address;
-- 
2.7.4


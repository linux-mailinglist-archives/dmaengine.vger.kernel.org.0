Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8A24176F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHKHk7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:59 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:61166
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgHKHk7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb+cFVaxW3fFNyJl9gTxE4y48IjEmD2hRoF6lyOjHcddVB/bnVkf+ekD5mw/yN7seZ2Eq4439VuprsHWHGXnS1NV5MJ/0E6r/EtvTUPJSxXtbw1echFnzVOxUVzE5JnH9bmDzwvMm2UXSSN1A/UfyS3uscjDTYtSF278lj8pxFbo0MwFC38uqLBtuu/1LKtzGbP1SkKHvnI0623IW1ut6LVh95B7FzY9bp7rU5vzs5lAGC/ujRRhWXivNWMd/shfxsYj75Pchzuwkt9g4hog/fRgvcZGoHJPguTV1tYn3J8+soAmZxBAyFyb9SM7RwJpQpvNIazPoH8duJjVTh7/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNKNXEEdPeOOlP0E3WJENUitoaKeApNIO0w0G7TvIl8=;
 b=Sdcg74YdC9E/+oLYq26a8SHY146mYtjuBmPRL2/nuCA+isuIqRaOIJjw+bX7Z12HQYXZU2YEpMYkOKM6xTpSKKWUJ/TCKEcgJ9tfdflXmJcpNSZPsjV2lpQSbGmS7yxjhLczKeyYE7MkxCHVHJ5yaKeLNlDycLOqWAQOrKBN+MhuDK4+TPPEpKy6Q5cYUBvRCR6YmB/f1S6ZLCpYnJItI+ZWj7AL1XADVrqRnbKfsi+HjURjtdN7wwcQ9rTfyGHXtA66OklD1wH4DxC6JDXjXzIWTWNBf6IcRMK5kVOS1Gi1GfaCjbp48BDI9NDF50WoW0s7RefK6cVr72S5W8rGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNKNXEEdPeOOlP0E3WJENUitoaKeApNIO0w0G7TvIl8=;
 b=ch1Gfvyq5rY/JwR0TzlvaWnqXmDzWPN0IasPPOvlwe80WidCuvOm28ahTsxzS7mlvFuCPz3qWYKMyjT3IqcgGdMrpOEh5iOVtg9e72awWx3QIffODyPbcOk4RY0Er7MWGaCzn0yMq0HFCFa9nQwMcqNJeu1LrHeeZ7Zs9PYuY4M=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:50 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Tue, 11 Aug 2020 23:53:49 +0800
Message-Id: <1597161231-32303-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 649ce89c-dac9-4f07-c458-08d83dc9de7d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34645229D0854B6B9C8DA00F89450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL9tzYCWxDcy1u16OE//kAq9GIfyP+oUHiG3ssQ+d2E1krGCXCCRqvW8/T7R1eJIlJzPJSWJEJEcEr/SiRTMYCslYAj1T1XR6fKpgN99c8P70sFbI6Ggj6kpvM9eUdr9A3diJYRLlDpb4aqHdKhigf8ZHOdorVmbBw/+KV6X5z+TKTTfPrIVuJ21riFMoM4xFrm69HPb9HsVSuEFiYyDklKTG3FWImz2QhREgIqqZyfaYXlkN1ykO6zDImLzXWwgNqWc9wiZZ+mtWZPoMHRbUIRflu1dAMmusxiaPmv37r+2Y3vo6kbdSa4YQK+tYPHDmxfvoc4JkWFs3NsrsxRvWzPDSb399HyBq7skjN4UYNVJqeBZvWHCW8DEz8maiJaWK+c5ZvJ4gHlgz/jMzE+HB2dtQPnm+ZGL/8KGcdYQNbqZFVaS0lV+xlM1p1JdeGGk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(966005)(36756003)(186003)(2906002)(8676002)(6506007)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wgjhsf9JTd+5WtfSUMrP6cC64siUQVFQGyJ/8/zBazEM00lZd65zNnnAviyDGM8IOvdPtorOlSYGz//mreFtGGEAmT2oiMiqFiIcMmh7oYHlJIbE4vi5ha/UeYpUO+wBdp/gy6tMSZwSlmwlsg0RTTu+ZayxXqbbDY8NLlJW6RpIMB/8s8Z7dU5i21NDLIWvEZjL2dXA0Y45Q+6dAHJeWQpeyIgyM1Itpa48bKAugesqSpZhBmmyJIOfZLzGRS2zQTUAIJzn3iThPip6BobsdfC4zTFPRM2oGZzWxv9MI4WEvA3HKJ6j0/Kf93u0+RrU9lCMmNNjgNoCv8qsE5AB3uynlPTSLkPLkX0ODCil+CrVzUN1/lTZC80Bcmz0KsmmTNf+wqLvEvnDEFNJ7iZCOv8ifID32Z6sxrENnaefy9ETIkUVUk0IlFnq2tLwqssR4wjYnWbliXb1gnL3L1ANNx+NSGf3yIhFstSvLXFpP+RswByzKiihpcU+fsRbnEqlCIBxgUqK+GEaf0I4hSppcxAWgy6RRonJLwt+vCNXYatQ2HdSHg/SGOFfKMS1dPSfafWL824+THhL/0vKxTXHiJuzgq3Jdv8t/W1XC2hWmFHcmvoT8gkIACf2o4sxVOBHmoUBcfveBHWiwGeeFLsnCw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649ce89c-dac9-4f07-c458-08d83dc9de7d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:50.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMpQqUAm04dSfhpsBFPAZAYutPbEdM0kMF49vDKMj4Zjknc5ghzlA4KVw6L2bTvJDnnBdDA5NhYGbtbW+baOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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
index d5d5d40..8735606 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -420,6 +420,13 @@ struct sdma_driver_data {
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
@@ -541,6 +548,13 @@ static struct sdma_driver_data sdma_imx6q = {
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
@@ -589,6 +603,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -605,6 +622,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1174,8 +1192,17 @@ static int sdma_config_channel(struct dma_chan *chan)
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


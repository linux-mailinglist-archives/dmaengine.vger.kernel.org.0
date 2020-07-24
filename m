Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC122C35D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGXKiM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:38:12 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:5348
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbgGXKiL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSCIyl813a74wFwaaqc0mf3M75BTdcXYL/gcpu0jVzqLDwbpILgfg/x4cdn7HAbQbpuo0HOFgWpnq3puvmnPgX0VBLoTtDDlcvsoeAd7/06hx87/VRFFSDDdbfdHjffhXQuj5Lid64eErBPiVcdowcoD1CY2kVoyChCTTiXzyG6uo/TgY8AYk4VKXqpwG9S5Cud7EL02or+Y3kSu1WhcoZMKA0UCCPtTPGFKJKFOT2WpC8N7ifTwacMzW8dN5DwDJT/58xkZ/ACL8BMhLK7j2RUv8NeYai6ot1H8O9pM/xJsAp7G9Fu9cG3zT0aCMgEJuVbyQhazFkN7JhhE9eXGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNKNXEEdPeOOlP0E3WJENUitoaKeApNIO0w0G7TvIl8=;
 b=aybCTO6FSJLBoG/GlOTMmO6c54ZW0c7HMJaa+ab6eKr3QjXoCA2UqPLX6IqWIYy0U6r8fG/9rm7s5FrYbG6PgLK4/iBNHJ7tdp+xk43hZFkaWCPKxW/4uEDg7d5Q7EFpxrFPgjm6E+BleZAid8gXfDJ4Fr9GkLVB54wG5sLmCNKITwA7Cm4CahmDLahMydkMXjdOcZC2+/bHHwTmKaMBVVLpwR4Kq6YhPNVCnphIadwaEGGe5eDuicvdSBP8a9eIbi51VlVxIt5CWK0KO0wUnnGqcu4StZvmcxqRV3Z1Y/SX4Dz8QdIKfaDeEslC355Q8YUvwRpPxW2AF50lgiMYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNKNXEEdPeOOlP0E3WJENUitoaKeApNIO0w0G7TvIl8=;
 b=QI9g3CSi9XG1nSMhfDHIxE7JG1qecYqu1EJCla7vDjqkphhE5JRRx0M2G3LqCI+Y0RkOTtf8YoaCEPxkmpLHkDDBeWO78JgnBFC8jW4UG2UPTxlxiv0rBw2vJHIzl9yEmmNlGetAbeIVG1CAJqQeKKAL97S+QLGKlTA43XGZGKE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:38:08 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:38:08 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Sat, 25 Jul 2020 02:51:23 +0800
Message-Id: <1595616685-9987-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:38:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef12247e-02ba-4fd8-7936-08d82fbda76d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37104E6CB9BB0B3B660A6D6E89770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ5kzJHt89xpQpfmmyTIfkn/OtlQPB5VqI7zd8Ex46NR/c39FTrC0VJstQRNJppLH7yzLSyuohcOcT0pTr/wIRD905p/vNE9FQBsRcPs+mg/Gs/5O3yKhtUaxmSJa3HqTXzOjepL0mvDuDvQauPvWgQd8M3TuyNHLxpM4DdwVPnCy6pEFrCNqPX3KdkRNA51xBV/1BeCy76qmnDawdcSkjtk6Z9quBDGf3Xm2THPfYltznDwHIDD/X1A51sfR7X7ozC5aPqdyb0fiV99e4X4Lvk2Yp61nyZoFeNttw+AvwCNORpPQCm5bJSkqJ2Lop9BCMc+sCBU3K5WP57rTxGBhw5oqdhOEsll6ofaprRsRFOqTPP5X6wo6iMj8VjyJXKEUTKG+KogJoqFXtSB/s13mOm53iMSjqTquZLDD3vt9OSCmc6smk5hK99qiYUI2dU4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8FemPzLvIK0dobVhE853b29kLMLcmXX0+Bi06rOzIQZcZ1GYs4Nwbjnsy6eXc1Wuf+0Dgx0ckl/yjlURctq4AX1vzmSWvrnXEWYXKkciExpy88bFpsr1ogDiBFKb6qJnRNCggp+L1lX0I4No/yCINU4E0pn5oNDidJrQ8ORAUBkmyVg2TPG5Xg9Nlu5s5V0xf88C+8X3HaGVaBrFrLhZxjfCwcIeQhuf5coPcRD+LgO2lzOBpY81VL9tGO5liNnNrsp2tuhBZgkah+Xd29k5rxlCKcUhYI8k9ohwgUdsonPXAr1+yPN1saDdd5mydhKQ7fCIobdGl6qQ2dwjtE/MBhfpCbaTZS4ERYitViVTtOmcwvOsKG/1hGhfq47uXV2adNw7y1oSooI2sCdHZ8ezdEsTYCjLMBH4eOIMBDdTN/6ozS/bbvSEmb4A47ifgsLzEo7DmKxNW/h3IPekvgjXrC0G6jGGuOEdrSvjdSuIRGc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef12247e-02ba-4fd8-7936-08d82fbda76d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:38:07.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUEeBECkHH0wi/MqdWLB1fUMaD+cZWqda/T/DO62fmRP9HeB8OZtWjN4GTaL4sws+rJyi4eFgalzgNAn9u9sxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
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


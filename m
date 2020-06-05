Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1891EF944
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgFENdg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:33:36 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:6128
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727863AbgFENdf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4G7jmCTlzABm9e/1MMZtKdhwXNQDqgreeJcKwmbU+8AIluBF0FcKl0mv15mK6+LO+VinD/wYWg+mrE9z5q9lHpyMT6BQoQJmsp/fblUuOaqaaDcmB7UbtA7djDWSaiSCVAm4Q9ufMk+drbBSw35yWRcmZLa+/BOlQMoNAByZ552CX3bAVZ1lOyhVIjOx1NkzlGfjlD/LdDmYeiBS/mpRrUVaEGYvtIS9+JB5q/IRIAYJG82fGhaZiIm06mxD1AOeH5kJ6qegXQNUrBFtc0/qXUISI+CTZ5ggcS9xx0n9GLH1S4qnL6DfihQ9oG63IJ7hTW6UCNS6JBAOOw+JTbNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3U69uN0DL45TP1sCU2rBpvu0XorFo1Mf6dwI30ew/0=;
 b=OMpMqwLwK9W1mFt7ZluQ3iEg+MQGHrF3j9GWxEe+swLiRb9uFJHSU1BU/VeeUhNpDow3ujOUAoEtBXcxXveELrGkzzNBwFWYE2ghfQ/c35B5XSur34TDM41iGCruvcKxXWQCrIyhgAE11BiDBLM7zKrrtCY0Mb5dSfoBEweDt6JsbPOZCsb4+/npSHZsNJkGJO8cdFlKI1PF4VrQl0pb9qF/jc3Zt3EcX/vuMj1swY50vqGAHyRkDKNm469ZqJNUJCX0RJGEzK705C/MQCo5ykLo2oDV1HbL0MvoQBC/syrn2IVC8joAyusQ9XPn+MlPZYHErEumGeW7XiHUuc8Gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3U69uN0DL45TP1sCU2rBpvu0XorFo1Mf6dwI30ew/0=;
 b=fgfmTHfykjvKDss5xiOOU+I1BiJ3Vng7LBhmcQTFWgbtMSr+csTAGFLwzwGJNU/0RCyZT7EsoFGaMZnulsUw7fq1HeWlzA73uT+63Ael8kvJ6y0w/FJ+Fz00ufw7V4UQrgUy8TRhalpySBE1zTntMYIAJViP3yuyKu6/JE3dQw8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:33:31 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:33:31 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 11/14] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Sat,  6 Jun 2020 05:32:32 +0800
Message-Id: <1591392755-19136-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:33:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05644715-2387-480b-12c2-08d809550965
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6702B48E51CC911B412BFC1489860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaqeNoZMGMDKQHM+I7m9DQl0wScfYbom+BqVIDHLVziXrdocXPjCMtsEKKz0dQEHgP6MzP1LB1E9PRXtRmQ723uGpiYeESpj4bISMy0Q4FDvBlC5oU9LsW96EGdckUFwnYoBWnErIgr9sLeX2i9foe8ezsB9cgeQFDZtI9U3XgpKjmo3wZJnmXVHGuLMc6+NkQf53LBCeEq1uIdWWSDVIcO7WpnUE/PFR26XlSsLo8Hg8rtd1iic0zKAkogAjozrpdcC142PTAHtc8dBkFIMq2/O9Hv4M6/PLp5YbyYDH/UFOH7LRn+5jBKqSstRtaYH2RIXjskWvNq41qti3B3pE1PTie8J6Dj1dThsPOegbrrUvPlUYuTXsvJcIVm31HkfAVE+EmqyizQTBFkgwSri/PbecjnjsGw13tS5ROFFPHLhEhL331JfVIHE0ceTjOO9Jdl12sgD1tbAkjBsX1NE0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(966005)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4p5Ok7swT+snvPxphSf6tmWgNDuCC6me7fzHyUmidL0IJQKPu+Ks9GDTYIEeIQvmdIWktRi0IHcZkw9WhJJVh/ryAgNMYC4JOl6gq9d9IOJNkRjtHwqOTciNsZxouJS/3RBYtyJ7vQfASpkzj92tT9TaO8I0UI62VVt/1OX+fNh7zZu1qDCzfcDIZSLwnssvy4/kBb+nOrRi+0LbLb+XPvACZS1pd02ZNgKsbZukrgQpLZHs4ETz811gvC2gjbCtUUwiHeqtFUm7Mp/c+8RRenP/WEqKhRVq5DTYIljTuwcg3zHETrQJsK6Nuuy6HZmiderw4uPWJbJDl59jv1WDKNdtktyIGpEgyDR6kqm5VmIV9HhtZASbwjQDsWoAOhLknv7bzoBKHQwOVCn0wGAVhGFv5zlVaO0bBMlihCOCLRo0wntPg1Nii2E9QvHIhXW3bWTr808IEeX9vXhMloNygt+vZAhAwQhW0XhtcBcTDvg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05644715-2387-480b-12c2-08d809550965
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:33:30.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjW4CcEvNv+S7hkK+JujrrtLqtzxtwdvPlBkK7AaeGjHIG+yxC5C64+J1v18fiR07sQUbjQH3rMykQrcqgp4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
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
index db4132f..be86ae8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -419,6 +419,13 @@ struct sdma_driver_data {
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
@@ -539,6 +546,13 @@ static struct sdma_driver_data sdma_imx6q = {
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
@@ -587,6 +601,9 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -603,6 +620,7 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1169,8 +1187,17 @@ static int sdma_config_channel(struct dma_chan *chan)
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


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98DE17EF36
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCJDbe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:31:34 -0400
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:64192
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgCJDbe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0LMnr2iE2sRb7iI8zMt20lHLfK9bCEkcbyok0qtPZVGZa0k1BJLvD22WF17OcVM47YqG6GXy+VRDvKLmYYhoJwNaGcusE/evEdiKHzgtOUlj5n6XX6I/gDjjKgu2HsWjt1w0JZcJdi8izkJ+d7HcXadhZqN4i4tS4AlVs/THyyJoX3yYaSJptZMoPJd8mBiG094K2x1Ct02SliIs9sy+IrJk0ASseESgFautXLTMSjb6ef19wRS/GnKBzrkiuYWWoaZ0hj+bzbjiFCIv928bS0cl/3uE7swcLWs1VUCyGRR+Ih0VanziychurqaGhyXMZPu1fLRpa4qQO9ulUCmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpuFOIpGRVZC+E2IfBEhwmZFP587LJHNhkEXKY5JJ3M=;
 b=mKb4b2XRr9PM8n9sjTscbFleh/YUJMDBMrvUeM7lLlDGofegYZ5CdDlST5zhOIp8H508IGOmqh4pMYNZ9pZ2VDEQUWXoWYCWae1mUmYlLn0xosscMmQiv5mcxBvtVP7fTmD+O8z8TDmySST/h608G4phUV79AA52jrKYVW2sct6QO7p0rnaO/fJeel3QxknekIGBomocAQX/E9PT7uLZUNJSdODN1a/omiwJ2kZWPMcSYwsIuYaKb+32LQsAshPd8daq0voA0K4FW48AAHAfXZk/r0RA1lTYlMcxwYLqE7L0SEwovfYZx6CJ+S405i/ctACSHIAygYdkdSPNOjwebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpuFOIpGRVZC+E2IfBEhwmZFP587LJHNhkEXKY5JJ3M=;
 b=D8I4T/P1KPu87Diq2aAK7Me+//ajcR9KFIn2fDENFGmsSq8Bq/4c5CerwwJooCU8sFIUzaXJ6RAVfRO5Mk2LUQIqUucLpsAgcPVvVb++rqnrqNz5WJAse3BJKe0t4yjOMt7atvPkIpnMjmWQh54FUtd0MUANFFnqg50yVutO3Z8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6511.eurprd04.prod.outlook.com (20.179.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:31:29 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:31:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Tue, 10 Mar 2020 19:31:58 +0800
Message-Id: <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:31:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b60cf1f-df72-4005-a682-08d7c4a38527
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:|VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6511EB1C43DAD229D00C21D689FF0@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(4326008)(5660300002)(6506007)(52116002)(66476007)(66946007)(66556008)(316002)(6486002)(6512007)(6666004)(36756003)(2906002)(966005)(86362001)(186003)(478600001)(956004)(2616005)(81156014)(8936002)(8676002)(81166006)(7416002)(26005)(16526019)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6511;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+2P02t98W/dud2N0nQSXa26kygjHHZusAJ+rXl4YW1m2ufJdkwqet6MDrJaY+cGotPqEuU+I+WYFG/Dh+2M0F2ZvL3mzVhAUMneF4h1+K7npt8/0IBq7CKjZCjADvGH6QOr5TqBy72E8i1Vwg3R4ztZ3sVm2s9GAkimcQRAngVPOSG35rxVX1mz7s9g7dMKcebbshMwQfuV8HgodwV31ODv+nq9Nl1Kz8fUaUnVjLjJaixqlz9Af70Ahpkdwekht5pn///hZF6MT+BqJ2oXybX3+5ntd+hi2wqn+D4pxE2MO4tjkA6ubn81GSzqubMLZERH9RH8VlNdH/BtMx5UxkJKVPp8dTY/QKMt2kIr08ZGgB+c8ATEsEuvt2/aAiDVrLeOKg9jBkQG234esgUrbAy1P7TsLm8ycZ8J9OYSr1GWXRtO4HDICz8O/H+i+ToQXzg/vzx/TF5w409iPzgukckVKzhJ9Csa1yv+xqYkF06bh2GOs5jCjRfJjoTv0Ysed21Q20osSnu7QZ7q5rRHyN0cffjBuXbVI3NLjlQ6HcZLNR6IJ60MSfCqUDY+v9QBdOPmReEsb86eyNcE78LzHQ==
X-MS-Exchange-AntiSpam-MessageData: ibPAGe0soXZq3z3502XFIHu+/GNNU0xHlZmD30r7hq9YHXuV4yucEXV5huDMkU0C6qImI+R6PIy1HQeWbRIrKKSbMepXD6WUZE4GyOKzVS9BbhhmlM318YwGBZijDAJ7XGw6Kv1eE265KRWzo2jCaQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b60cf1f-df72-4005-a682-08d7c4a38527
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:31:29.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/7wkhYeuCBAMv/9+nA+ynRUAgARFHiSI1adKw0aGqjLgfMVEdKPN15sXmTSubEGQqHEdT0J5L9mct1SRjDLsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ECSPI issue fixed from i.mx6ul at hardware level, no need
ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx
from where i.mx6ul source.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 56288d8..5ae7237 100644
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
@@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q = {
 	.script_addrs = &sdma_script_imx6q,
 };
 
+static struct sdma_script_start_addrs sdma_script_imx6sx = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.uartsh_2_mcu_addr = 1032,
+	.mcu_2_shp_addr = 960,
+	.app_2_mcu_addr = 683,
+	.shp_2_mcu_addr = 891,
+	.spdif_2_mcu_addr = 1100,
+	.mcu_2_spdif_addr = 1134,
+};
+
+static struct sdma_driver_data sdma_imx6sx = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6sx,
+};
+
+static struct sdma_driver_data sdma_imx6ul = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6sx,
+	.ecspi_fixed = true,
+};
+
 static struct sdma_script_start_addrs sdma_script_imx7d = {
 	.ap_2_ap_addr = 644,
 	.uart_2_mcu_addr = 819,
@@ -584,9 +616,15 @@ static const struct platform_device_id sdma_devtypes[] = {
 		.name = "imx6q-sdma",
 		.driver_data = (unsigned long)&sdma_imx6q,
 	}, {
+		.name = "imx6sx-sdma",
+		.driver_data = (unsigned long)&sdma_imx6sx,
+	}, {
 		.name = "imx7d-sdma",
 		.driver_data = (unsigned long)&sdma_imx7d,
 	}, {
+		.name = "imx6ul-sdma",
+		.driver_data = (unsigned long)&sdma_imx6ul,
+	}, {
 		.name = "imx8mq-sdma",
 		.driver_data = (unsigned long)&sdma_imx8mq,
 	}, {
@@ -602,7 +640,9 @@ static const struct of_device_id sdma_dt_ids[] = {
 	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
 	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
+	{ .compatible = "fsl,imx6sx-sdma", .data = &sdma_imx6sx, },
 	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
+	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
 	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
 	{ /* sentinel */ }
 };
@@ -1169,8 +1209,17 @@ static int sdma_config_channel(struct dma_chan *chan)
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


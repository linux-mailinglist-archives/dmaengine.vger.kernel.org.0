Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0E20ED7B
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgF3FZb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:31 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:63552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729753AbgF3FZa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ/DxqoxGKv64246wZRCpSZZoBvsvKNldZdGOJYA+bR1zrsoF0qWelZ5UpsPxGA3pq7JhgzOPuoR19YeyuePRH6fMT++TtfXXvht6Zww5wnZ1HLEsC+k2ls0B8xxLrMWRSJRJv1sFRaiDgDSCbv6SaPT3KYqQhpsojihUipDDJgxs1hw4EoBvg4MK8Q6LcGRPSCWa6lzm+lQh+QBULdmNDyYvgjdP0wdozfqrc+M4Y/JEVOmVUej3qUFcP0B3308I5b3BZSs7mdkw0jY3+bOsvz6m/wqdlz70wU0C/NitN92/lVvDOehY75SB2VErBS3Br+gQWf3Pdy5vncIEgJmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPvhGd9cKIQVy20dHzs7vXDHIb1HIKaMjLjlAe3QYgc=;
 b=ZP11bQTJf9Q250ClcyExZh01NDZobBQshskyJSl5PWhb+20W1pjfFdDTuqzDnr5B5rciPQasCElKRaNAKMzpkXm8Wryq5bvc96AFz5C9hXBtXSUQ2LkmOW4xCczohIokCyxc2jv5uefk5v24FjFzSFtsPqcYqYxgBPMhymfVxHEmYJ2xzXETFY3r4n+e6YIi3xXv+0iP6R0qykEJHCFm6Sh7wHTvrm9NOg+h8YAa8lRueVX0V8sDtMgClc+wNRbOa4/YRbO/3k38/R9AlLF5wwdsDRr6IDROISRuLBbjTbNZ7uakWZGqj7iKbYh7vzisufGXCJ0iSnNV5wD1ZxsgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPvhGd9cKIQVy20dHzs7vXDHIb1HIKaMjLjlAe3QYgc=;
 b=Ewoi0Fj4QjiHKRDGjO7rozowhYkwWLOBOqy+HT+Jse4tUbuxgY8dVBtacboz01CqcgWlZroTJlWBRLQS0C57p0g9gs5MmuWdUDXzX/Nmsf3mEcQexvUYaeg/lVSg8cXQcGIpS4S8NtalUxD/qfLPfYHCej+C01hOj1v0w8WTCvE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:24 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 10/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
Date:   Tue, 30 Jun 2020 21:31:14 +0800
Message-Id: <1593523876-22387-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6f3b00f-6315-4b26-0fc7-08d81cb5fda2
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6640FC01B44D1FC1E0B606B5896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzrTI+Mja6j5haNHrLKkU8T9S1qZrNXgrqzozv70xKjCXiKiev/QqENr50V+1Cppawcm1EuODIXUAciewRVwXWggh/BhMGy0cI63iwh4w8/4KJvet2jlK0lNPvJ7ITmVfVsriwZmtr+BIcSmneM2nDLiItC0KQ5KpRFSlKaaYGbedcxyKkqSbTZrsxWneiBfIzzFY+cWT3kD1/tLZypKm48Iut7oR6CPo7bv+hcL63VY6Jg7tRePHp1kJJC3XwTL9LS9Bl3gGRf2HTF59PwXxWrsRucWWMGlA2Zo9+vXPn/fxz3qr7eoGEP9a3J71nzJr0lfMr+UwOo3dTZ/97cfHGUL9jBk/bBCeAJs9TM8qT2ao6W1NTsuZqaQZb94/DUjzFn7J5+5UZIiQSHnx60HX3WlOCKhft9IPRyQ+dJkEqN7y2QAjWh7ga7qjmqhVfuu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(966005)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7W6tiC7BbgmpvRp38OfEKoDdjvkDONM61eEqHCU1ZaQHm6G75RZCbDU2dnrLUx04TARkbZdEHLVUVIXzP/fJesO8ZbJiI0acFpw4B7Hax1bRqbPAG7PB4MBEGrVtKDKViaslU1PKJBtY0SSHIpy2V/IaxXUnPRVEMagZh6QCeTdsaZ4N5OS9RE4xCMuQJtE2zQmY+whHYpQhp1eTdSInJoGsgxfC4PbX8CzVhm9M+EyMcbrskiWiE2Cn8dehzTA373QXExe5GmV/8oNKYiBIHzDWMwa/qYQlraicIPqHBZaL9Ufl1wEGoCBL/UUEOgJ4UuL1eAvVi8NaiU3vWa0O1Qp83GI1OGfN58C1y8dvV01rGj7/xfJJJ9qqESt1rVRXLfPAYGDSWM8yErs+zbGYuZpaTWkQHwjgTYJYSROsHoyRBydc8qCTTwxloaz+CPAgSLLvadKzHMFFfDU3vR/Lc51JAcvdWiZDw/ncb04YdAg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f3b00f-6315-4b26-0fc7-08d81cb5fda2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:24.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDYSvRfRgWjWd8X06f8uw33zX1FcZoouCE+6mPKRph20NgMKSW7FXYerkSyxtvTGRaG6pJbhWZA76qTQliRPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
index 337143f..3058c78 100644
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


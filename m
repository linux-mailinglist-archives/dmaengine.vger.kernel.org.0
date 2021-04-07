Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C323564F9
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbhDGHQd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:33 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:28417
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349349AbhDGHQ3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRVTsQ9biBiJTEfYyWRs+5EVg3wAiasiIsuJ6yksGSmabLgh5a+N4cvpaPll562PqRvtAh22hc6TFLNxX750F42ts78v2MUl4p89jM1Z+sTfwVsPUPGFomhIYBWF1ow8Wqyc9PDJWr3MPH0rLWrj0XxWQvCeIiFFMcqtugqCh5O3w7hjk5MBNURWziNvdRpIyXPIi6To/1h4V0jl4x/NTda42QZ53oRUBjBazorGO7bb4F/6LkrtrnjfpWKahhgVw1x9TI+hk6anNHEvBrPfgGEVs/Uu4c67vttnNR4ddxVtbjn7pRFBst7k8D3A/E+hQ9sXUeW7mR3fAxYmVTziOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtYuoAWU5nvGRG/5slzid8bTmp98z0SLULmC9zpRUdk=;
 b=PCqD+8mZwL+fLvDYH1FxaFWBYou8EU0fbRsYLS5SoJz+1DZNnKaKnBRWl+rKRkMw78tZtfi9wJnF4CB4lU8QqKwUbpX/l0Q65LeqjFdKdt3y4q/rSDjlRwXYqxa5H+ito6n9hD1TNM7hahK1hZFoeKIYa6+blRINgiBLZz/9o11AVp+NqRPbnCa8FaToCqY7qZbe96pGtciumoOCgByGdeX27CZ+VrW/YoP79ZZF4YxKwrEI0NtytzfmnfgjPIV9Ryy2dlSZzX4BOXepU7lws7GMyueyd4Dy2tr50k6pDUgPm+bd+TkUgS5Tmx4qwbw5b+tF3AxFfCs5QLCWmWB77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtYuoAWU5nvGRG/5slzid8bTmp98z0SLULmC9zpRUdk=;
 b=pGRTLEleQCn9PQBnYOc3lxtMujzGRENg/6GHrMpb4+SKm4NycLKT9upUmct5pKaJzB9+hRyOD/w0styeS1SUtggyC4LI8PCwGekmbnG+056cafquWNTcgUAlmG07uZctu3ziEQfw3vhEi76kobdWy+J3a2/P9ZrqyzvPHH6aVso=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 7 Apr
 2021 07:16:17 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:17 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 07/12] spi: imx: fix ERR009165
Date:   Wed,  7 Apr 2021 23:30:51 +0800
Message-Id: <1617809456-17693-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52764a0-0e24-4ce8-8f6e-08d8f9950919
X-MS-TrafficTypeDiagnostic: VE1PR04MB7326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7326CC243FED9A6B116782E289759@VE1PR04MB7326.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DM1jaOGKckmwEVarXe7DnQ/ilQW0ZYic/eoohppxoiAGcIa2fFj6fWVGIT3U9R5ligpD4rkQNzoSrATSYo7Z0QaubK2R/IaJqkh0NRPmLdimf+WbaKwfOUU7dJ9q09/VoTZZ4YWYi891PCP4UQM+oH5gZkAYnXzXfvvf5Nb/iEoJ3/fgXIFaKQpUV514fpItAJDEthJ6aNml8MYkKBghDOjybS6snMdfdp78ZNpTlCkuy2qcOU0qr1ohpH3w74tfX7nYtbvohA8hl7ArnqAeVxr7rT2P19f4zDQIMwmtlHpMagcmOZbpXe8L/QPSjEtv87nADt1JavHArQEF6OAXPXWNt/W+Cqel9+mD6/z37s310JSYXj6Aagnif94R6Tl67S1VVcL1UMfGC1Ngf+Y8j94zCdjiCKqDLNyWGU3mQy0LS7BPonEVEvD5FmHHo0x8biHJzMH0y9hGM+W1stmg6xoiNWEQGcOeX5QB14dfE3WPAoFSOjva6CnA6Kwvo+5c4lDAM1GxHHkiLQyn5RyuBuyNtziXvFYo+zYRqCMMRzK3nqnw/C1TuqKuPsee6mUCaWvAuInuoPJL/RhC6a9g2QHHiJImrb8Oa9zkrQa3SdDmfrhxCna8k2d0wnnp5i27+sJfgCRx3jBrDOZF0LAYp5ydBRwK3Ganz+wlcBjEwUFNnG9YNX+mwRLVUmmmjXYOOJ4K/txEQaCjgCKQETnUtQ1phL4Jtbsyy8W4uVld1pYFNvHdPvmohAKMxRE8ygyLcB/Lwg0Dhgz4rtl/d8oR9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(7416002)(83380400001)(2906002)(66476007)(5660300002)(66946007)(66556008)(6666004)(38350700001)(36756003)(6512007)(16526019)(186003)(2616005)(26005)(6486002)(6636002)(86362001)(921005)(478600001)(966005)(8676002)(38100700001)(316002)(4326008)(956004)(8936002)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BwaiFF3av62WBY5uMEZAKYmLBxRcvT9nrsQpTkTONIrSOqCqAYab4YpNMfZ8?=
 =?us-ascii?Q?vGxZdDZTHxwtV7FA5SBSgyc65RqgiyVA6z+pizl7Q9IxXc0qhMbKuWFdkFFa?=
 =?us-ascii?Q?2+eaA4HeZu/i2oIcMasYjjPtXwj9E5dmyaPLjnaoC46Y8bO7/Ma6M0Oc6M9Z?=
 =?us-ascii?Q?H5jfBJOe1XnxePZoLThl+it8/+bYfdJykzKQP7izJK3OYDQji4N9IZ/++N4q?=
 =?us-ascii?Q?gvK4GPmRjNW9MEspqTpO54rB4rqYGejMBeUPM8vxqSRQMWIpSPlDQGskLsEa?=
 =?us-ascii?Q?csAsonjREqX++M4ypeoBRx1u5MUaJo2R3ixEUrrB1KljUWEG0ZTvfsOEKe6g?=
 =?us-ascii?Q?g1HxYpRTbZspWzEGee14gKlp02DsOHPSeFE48dc3CnN5Y6929Csvdn/8iGUT?=
 =?us-ascii?Q?IVE5s8TbCPnMlDT5OtHLKqXDymQaQWK/7cUHaI/L+qZ2KAuVW30QPtO0Q+0W?=
 =?us-ascii?Q?kq4PGtlcCOUMZlQWKLn50C6vN+N/6WMPsmAprwdZ+HB9NRnnJqmrLvSsgt8B?=
 =?us-ascii?Q?4iDFoNIsTjdUh/NPLOQ/PEk3UmFkIXkjUwhxxFBq/NapaTO0sQW7R2LzT/TI?=
 =?us-ascii?Q?0PXXvgoYLnqZ+kAHNM9YOOFdhiVMWDpeWKBsGkN1abBiPj4DiazketEZmG9/?=
 =?us-ascii?Q?Ynxy8rgcGZZeagKVPPuOhktFwktbVOnChZ+GRnyhW83mUlg6q3DFlTvVvYyj?=
 =?us-ascii?Q?sLWIJEvIDzTO202C77bLTmuvCXzg+FXuM+o3VIdq0Kf+vhsd6NZYO95YZdgz?=
 =?us-ascii?Q?mBGA75Y7YssFWBvmGtI8ri0Ck+++PMKgdSFGu41FhtYM3OK9L4WmpXNrzaPu?=
 =?us-ascii?Q?ztIbgUeYu+cfCDYoMPSNNc4HkBOYFFCHqXQSGpuTCDsnPCx7hWSfqLFs6DCg?=
 =?us-ascii?Q?CM2LN1xypQJp2ljlJx83mc01+/3ZhYNPjaFPQE+rBJbaE4maakLPaDsR6pHk?=
 =?us-ascii?Q?TJU/ZF6d2T4tjETLBijjsVkZj5JGLlotOfxHNlSNBedKqziMHzFtU6RtDTT7?=
 =?us-ascii?Q?Cv7yBW/5odLgkK/UtXerL29+7cXrRvyl4Fns0exyXib/FhnjchE1w20L5LzJ?=
 =?us-ascii?Q?BvYahS631rigZ1W4TqZjJ0smCnNTmCFmhrdVFwIHgkdhKjAnq2qFpRdGOfRT?=
 =?us-ascii?Q?JSb58lrWh+z7A4b3VsUtvGAdTokYda1QmNjUC30wLBZj+RSTOq0miUWz/sZ5?=
 =?us-ascii?Q?wg5utfK9bVBpSWcyCKW88iVGz02lfr9xWVKqab/5fyjv5zyuaVzPn6ewndR1?=
 =?us-ascii?Q?PJNcEP2r/rYp0ARpux4rtPfX9g6/OjDQnmwYDLSZVqBu5pVViANkapn40cMf?=
 =?us-ascii?Q?F84xUwkrJJPB08nf4sipvngf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52764a0-0e24-4ce8-8f6e-08d8f9950919
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:17.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l4GPDHz00w+AY5wlYYeKJNylxLl0uY3+A7gsHpJVyT0mGKaNoRy5ZCvUmVrBjzmdbxASMH6hc/vtYDcwe4LDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change to XCH  mode even in dma mode, please refer to the below
errata:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4fe767a..cf235b9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -593,8 +593,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -625,7 +625,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1234,10 +1234,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	int ret;
 
-	/* use pio mode for i.mx6dl chip TKT238285 */
-	if (of_machine_is_compatible("fsl,imx6dl"))
-		return 0;
-
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-- 
2.7.4


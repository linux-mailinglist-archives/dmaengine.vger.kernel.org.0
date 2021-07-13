Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD63C6E83
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhGMK3F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:05 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:33112
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235706AbhGMK3D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ/MPoxV1ENp2mvGi6qzJW53oy7ObM0ZqMzoxg2xAEX0qp1ZmVdnGdJvu/ahkvd35Gx7wt+EnAjalUs71X1TvxaD7I5uToVQmOD2oJJevXfEps0RHdV+Tqo+HqtrdgxB4utV3RYOhit/ZXk9q9XSKqZbKB6Q/T9DNtr1fUrhm/4SiXctAXBeVQsxcFSnKVEVe8M+ok+kSNqYzoVP6wSkRlg1GvSrqpskUl/j4PzG12mP7XNwYUnOkc3naroUg8NX61ZC9sqDKdy5rf3o4JC0sTSvlHoTVwMDcy+zGVfnrXdNwzecRAhugxOVpx5SIJi1FjPaPRH5xB8A28e+PXgvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNYiV5p+Zer9BF/iPd2ivN5XQBG3Brjn3etpGvNEgl8=;
 b=LUmWbPESvfQ4nqeiLpY3Etr38XFQKPiKUVo5wwTz3BowJkl1+KY+QktJIRo4nh0tcBN8KzrvOosWTjY0ABoxdNF/EOnkCjaieaPl+N+bfKLrbujbHp5qlkNhGRzFrjyN791EpVrTOhXCCmHlS+RRKD9mk18iRZ5TZWoBNbgcj87pJYDW0Uayebt0PiWGrsuW+5treSXh0rpwXgvs0DlcslKwgA9paiM2rns6jKH2gw2NwZyiOfZ1Ys5llcRosr+Herg2IOmRtclpC96CgUJs/Lt89teTeyY5w7Ut09pQL3wNms08GZTO3rATu7yWG35wDt57zOzZdEu0S+5pqin+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNYiV5p+Zer9BF/iPd2ivN5XQBG3Brjn3etpGvNEgl8=;
 b=MSAfVND2c4MiqsvHj7VvW0HlbvZlGX9IdvY2IJPZ18MOswD9lR8u8gqeAe7FJL8fLbmc9TOaqxIK5vR+v+4WPtYzzrJRyLZ/Acxu+XD/5Sb36pZATcyPsRWR1j5mLchv1n9FcpuBRDS2GtJY6B5FzFn1FgxwyG1xAWNma7TttfM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:26:11 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:11 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 07/12] spi: imx: fix ERR009165
Date:   Wed, 14 Jul 2021 02:41:44 +0800
Message-Id: <1626201709-19643-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 261600eb-471c-4561-86ac-08d945e8a2ae
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288C31CCA229FE11407107D89149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8oRlH5KZPDYU/2PKuOqY5FN6u/Jh8ZvuDKJfJ+0xorLR8L13pokOn4aS2drOQVvHH4Yt8uCwPgvIdYOjPV06f1+xUwIYjam7EZCNfjDoKDzo88a7jn4YkbCJW4fHAmiQqjP7aizDck6KLrM5o19v6FDt1JIpB4L1jd+1u4gStbzxmVX3hTqYE9lw27F+RTYWJC6qb+rOh+eLHefepLBXFOy+4drzHn4aQ21VaKa+PH8ACcsfV9H1gAJX8KsBQreYkShJZiZ14Mkx3GMFUhoKMPJM7aGlTF41/Jl5A6YOWCg41jUCcUBcwtbRGGVBSWzAxLrK+XYnEY0x9FZD0YG21Wppd9gUjTeL1tvQinOO4u28Q0ECMeKl429SIp+1imyfkT5hCmp/sOZVDX9V0FWP5q1zzQ7YjNEaPYGeT7iqMnUdxn295vVESxl5U79XgkRQtSatNU8JNdDJ830ZZoj6A2I3PQLjPK5u4swH7/N5SMYWjGp/G2p+2H947QpnoaAqceCH4B16ByD1KsFZ3ATwhAj8Yv+FC2t5dsxU4ZoNsfNUFFw7zNBK7+r/TjJyCK3wM92Bs5S7Opes3qtnMicopclu+8azagssjCE9K2P4DB3MlQ9ATHMaQxuour9vWDPaE1T3H90sO7GnHWKHbdZCMqGCjjyQNekDDUMZfFLA0ccl7FHWYzJIU2z6bojnKEqxTxUUGXFpqExnfe14H9No+rGcvpAKBfb+l7eNPcKqWIEryPOkHhbd2bEaTL0BVpT/LoQ5pG8P3OvwZDGSSlq91QcwJmbxpIOHXv9/ovUagZhfKjJjSUQs1wxIVPZ1wKP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(966005)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0CuerAGN29Q+tP9WL8vK9/8LaNuUz/ra8S4YdpkSybLz7hN53X9IHqO9Ombn?=
 =?us-ascii?Q?HrQRU8Plc7bouhXSh8k6AsemfFHv77RqVmx1quz59FWHUJADVHh3VJ0PRYu2?=
 =?us-ascii?Q?3MYKuy0Yl2nqaNBaWWb5s60ZvjTB44wQdOqbFimoqJIhjgAW7isoAuQshCs6?=
 =?us-ascii?Q?9Z5/Hbi8/1uQ+TX+x18FQ7NCWoqtV/yuZEa4lWfkqB8gdEVpDl4aavzmwFJ1?=
 =?us-ascii?Q?TUmVcK4Ms4lTdvK4xXAbtrPs3edb8Y6Ajxct03xRkV2CPs+6WafYXYb1wyqM?=
 =?us-ascii?Q?9yY30v82/zAnkNVhDCPyuiprqJopK8VEpAsNm4zNHSby8HPu+M9ghBXKD+ND?=
 =?us-ascii?Q?yWexdRw7HCCr310jYrZvnIe0V2hdhgHI6jtw22Vs1hZJU/9AKlw2ztLTXMi0?=
 =?us-ascii?Q?E0Uy0z+SRA+J0NwdpT/Pyd4hFrd/0wOjSUt0CHavN4tIJXvX7mEnZaW79Q4R?=
 =?us-ascii?Q?a622jCCFeY35rAubQ8KLJGuDETqDtWjQv21dzq6cMLk5xgLFj0wWi+tLH1bA?=
 =?us-ascii?Q?g9ACDyd66169DGHP2bEPKtJbC9MYZD2DF9jdH+cSkX+fe7MKzm/95hWDC7zU?=
 =?us-ascii?Q?lSeppwP0dLKT3uAfBJWXvUUiAN6ukbrQERjfZINM2HcykWAyB5c19oKCedyV?=
 =?us-ascii?Q?o0pE5HFFqZ8ah1ppkCOGpl3dYEw8R1O2cnVbYouCowZW0rSw7IgSs2GStMfp?=
 =?us-ascii?Q?U4DVQaMtZF3YLA3RDiMAB7xGMfWJ4rAUqg0CdA2vYOTVJ3FB4dVT6ZRsRwm2?=
 =?us-ascii?Q?8fIwqPL/Hp7MwM/tpuY6WrHqNmmTqobwzP43zTy0xE+dcPN6x48T6ZGl+8gi?=
 =?us-ascii?Q?6if3ZpHkFt8EGrjJLbSYPXN2fs612YB6kAXNr4VsDFQh+iOxCfN4/xDruA2c?=
 =?us-ascii?Q?mLUxhEcKPsT7vjf/9s8aRp06arpVzbpvrK2vsZDWIQ1tmc8oBNTazpW/xKuZ?=
 =?us-ascii?Q?gq4xgndsN9KpyXQBpqievwMn3EKSHYPN0YTi7cJJiqj2wPx6gWZfZDovRFpS?=
 =?us-ascii?Q?tfSoGFIgC0pTE9RXYNq9Slkd6hpVk+InmXVth4QD0S1IdbO/3bZVswF4695i?=
 =?us-ascii?Q?LmMvnzvTjbPIZ2QNFY7FyXydui644n7NwJWl2RefBvNoIpbsXIQXOQAhND6f?=
 =?us-ascii?Q?g8c9pxf6CnGBrGV1haKeJaoyDfzQm0ieWuzgD+cpSxCefTyEJCJPyQP/k+FV?=
 =?us-ascii?Q?cWF6DYMUQQqjRgaof4sLNT34y8D7qy2FXiHrxsLPYP2lIY2ya6SfWUkO80Kv?=
 =?us-ascii?Q?92A4+B/n4pYm2VevkErjvFik5yfFMPchndI4c6S77VrTIavRHDA6lln8YG1V?=
 =?us-ascii?Q?oy/UHRWaclicvUQwdoiF1A3v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261600eb-471c-4561-86ac-08d945e8a2ae
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:11.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj4VGHipYWsF4Er2CeAaYK3LVm5WlsGMMzbuX6v1ZTXIpr0kfNz+9v29U2WoiuPe0xA/nxIjfM5EUi+qkxV4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change to XCH  mode even in dma mode, please refer to the below
errata:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4aee3db..61e4fa0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -608,8 +608,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -623,7 +623,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1239,10 +1239,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
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


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32103564FD
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349369AbhDGHQg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:36 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:28997
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346438AbhDGHQf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk2UhfLvBoEw4JcUaq5pyZoRNdhyFfrTd3iP/ha5+fCsM0bjRLed+jAvJZk7Y6kelmNlWYvPe90MVXwDgqe5WXNnARRu7AXuPdE3AiqvgMIjeCJ3D2G1AtJoXx2iBwKLECzEMYpMzofPC1jQqMbBKbDRXFUO4Evoy5v+lwpwgn4UC+cVWjzGrTguFsFzBxB7Rb1eljOflZm/gXujkRJ7oK11EJiTAj1oAmLZVFO5AXfE66ypvS6u7FUWlXeq1jQguNGtDTeEx2BtQOqUkcoTIp5j1800aDnLH+lOvuBvg7Dri30/NbMvYyeSvEDMyUSO8kDDxktJE8rPzxKDrPk7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpwm2cmTe5xyTNoXrx30icysSCF1vy3vcYas8FeT17k=;
 b=Ou8LlgMbQ/HqMQ5sc9ICV0KaFTfKcnVGHxPLjqsfLs4fi6Pj4lGEf2ll5GNNm0Ywf3IMs6a2vTGuYiHcPy2RG+f/cNlFFox9l0G9fE1gKEGuDNsDxXEmGqIE/tj7T1qI3gs39za0eISVTL+Fb9gTUCROnzho1N1SIA2pBDt5RIzAs3afX3hvn9U/WXcgoUzeiyDJfWSnYJFaEOj1fQHWmlUfKgzmGHQOr0eFxWHg31h+lbLHhRd/asGiOc65UkGFAb1AK18sZkS3t/cXh5W71wHuZTB+q6bcICPFPF0MQsHGgLxyMnhDKjHp7mkZoTRQXjyGEzwNnyniUYC8iB5uZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpwm2cmTe5xyTNoXrx30icysSCF1vy3vcYas8FeT17k=;
 b=geZTdL2LXh9Ja7VNUXUMb6F1mNI2jotcldFWAUCw1EJRT2M59xsmoaqYLQZhUi+9Tbs5Pn8pxOhTvgvp/evtkmsIAAf+or1+r0F89bVYJH1DqzFj2xdyuK3O1Za2TIGgcTqluLkSfO9peVOrngUj2tYdBLB3xt95kv4Po232SHk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:23 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:23 +0000
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
Subject: [PATCH v14 08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Wed,  7 Apr 2021 23:30:52 +0800
Message-Id: <1617809456-17693-9-git-send-email-yibin.gong@nxp.com>
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
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147cd492-ba3d-4d86-7df5-08d8f9950cd6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6509448FCDA8EF757BF654BE89759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3pKaWtiw/PACzFlaOmxRYKsTj/tnJZSncbEj1gRW425jhi0Q4uLnilA6+hkgG9IhzwU+G83o6qReul/874U4cDwFpubUsxghslZbiLd3FcEk9IxRzaOt6pOg3IxvblUGM6P1nWguWa/nbOgfdvfyQka0cCmfh0ntPCaGIysDVwuoFM1l6rUC6kNNG64556fsAYH3bBQVSKn8ZoDXkS+waCptM2lWgcJDr1KPkjCUFCMMYnzhMtWyOJFubNteFrPFE3cxN3SOgSSRX/vBSvUouMp7qQWsFJeyjh7TyQGf9e5MYLx3lR1Xv9j94soqLpGlpDtq7NkkgEGy0sfxms5CReRGtUwSD6IYD+vS34KpJUF9NpYbcj8hvGh9tAk4bUMQaz10zMIfWEmmwCIaAhlPn1T6CC+KY60BqkaiO3zCWNgOU3uoAmJGlB4LTerOa4WUrDpyeTEoVbqYmHSmbJehpx/Gxvv8cGy6pDqUvAKPwNzuYB1YwlDQmBQB6mFr6ZK9HIwqAogvtRBjpdjYm2YxzR4IZyoGnLDALCie0G4OPjQiIF5gC/8f3RMGQU2lrxHBC6g4PKNhbuPQ1ko//TR5OHJO49NgeTfojc+DeTFhXvMRPYWEICtdk1YWmpAh+aZ/Ccqy2YWBywKRgUJNfl01713U4uzsk2/sf7OR63MnlyzD/t18f4Iaj7Hb8yIQ0LlxUBg4tB/1jwfoGLadnfq8QKpcqx2D1xgQl3qyEPJz9WOsB/6LTzYg5Xr+SquCDILY8XuWWqEladnzUqIaozcHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(966005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OriwH6YCXxEf47jalQVaw1HiJxS1XLSO4CUzgFMBtz8ub3DWK5Rq9oZcfbEp?=
 =?us-ascii?Q?SDn9YmLmbNYbM7EDXzan2LzSTQveBpAe0CeGnOdLQF59YJGHf/N/jBIzo5Xo?=
 =?us-ascii?Q?sfkLNeOG6eGWGNved1oIjNqFmH1saFO/ZAYYVA9SeZzDQux7XcquK5ZHvSka?=
 =?us-ascii?Q?0Ck40wYtf4NHMRGBOf/0dGcItOOktKDRmKZn9ODfOZ8Jr+/2NBdZCa7+d3lh?=
 =?us-ascii?Q?34Ru9sncQnCJAkoOX3cmAmjFGwbInwHP6CksFejRzA5Z7IEUeabeQMxuNBgK?=
 =?us-ascii?Q?MyKxZwGuU5UT/m8GSPpLORMNDXRM/CEYARqIERJMSELMPNGv+7s+aor22XQS?=
 =?us-ascii?Q?mDJpeR9TYinGccbvWFGRmg5w1VGw0iBcKjTwbWI/BR30EcKFpqWh4RwA35XY?=
 =?us-ascii?Q?3MAuafL+JFTbf1gHCx6uH3lgXwp+yf+NMf0vOgaC6DojK2X23BPn5bSXfRwE?=
 =?us-ascii?Q?kV9L4WUq7q0eg8Va/wI14CFFXMoslfM0KUjpvQX5+O9Upb1P7MggMEx94Cw9?=
 =?us-ascii?Q?S/21bCrhcQsKUbdBMHYeY/23/1acnwuwZaNNWpqdFsftJ5i6JxOrKUiZ0+AB?=
 =?us-ascii?Q?THmCuBu+RjojREW/JKBBrPmRCulPxiqeFJYUdeznNYu8lqL/KXzca/q4YaIw?=
 =?us-ascii?Q?9Bp/20XZFWNTMeynlP0a47FYOgZ/9Hm86D6w55/0/oKRFV/zIyIA4IW5+Nb4?=
 =?us-ascii?Q?jHZfpUgpHmMppeXiApjxXeT+aa0hFvm91083dVEiLNepDTDIf6dAW63pe4XF?=
 =?us-ascii?Q?M0ONUqu8vCS3tbIoVuv9yvIxDg7YqHRWARLvAoDVe/bqacohooU+/5Z90aKZ?=
 =?us-ascii?Q?mCr0ZHDarSLXdqM/vQoFGrO3S3/4cqCPaFoqHrDRpNgzfoei6YtQpLKWzVnX?=
 =?us-ascii?Q?xVSDp3RqR9nfMi8DliR6kf+zbpZq6FXuHS/7U7eEpZONGiIzYoOUJhFnjiL3?=
 =?us-ascii?Q?bxtKcJlt6jlFRXBopQDnc8OVpaIDsH1bby/18q4IzxH7QBTUpkmanEXsY3xr?=
 =?us-ascii?Q?c+Qz6wG4Rw5NBFZFGcEXGWRcWdFKL/7q9+0G/gJWC3p73go9YYpQdB9lMxC+?=
 =?us-ascii?Q?vT2JvNAGoEfgeDPRHPLOMr3ooQYXWHZTYV/bEWO6VmzY4MRCzr9bo5bUdr5f?=
 =?us-ascii?Q?D1aSc0b4RaZ0gB7ETI1q2eFwQHdAI7tU5AoxECvSCEMnO3eeH7Mtetm2GyJK?=
 =?us-ascii?Q?wOj9o7PvZhGPrTyi+1a2IWzG6pdubkyhJr2sLi/276p/gTOHI89WlV1xh8kL?=
 =?us-ascii?Q?jPfOkD75Wpm4x/4prfrabhTmjSGIK2Xs/tmy8ivQ/egwwNBkigXvdq2dZ10G?=
 =?us-ascii?Q?lOJaKnAhkBZsQ0jNg0uEXf4C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147cd492-ba3d-4d86-7df5-08d8f9950cd6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:23.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWNXsmSq1ockoUs34CkkKnY7AaIpXoH6+C2YuU0N7+Rb0ZKvar+h+KWNxoyrQom+Qe1f+qMcQv//wSutJqRbvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
i.mx8m/8mm still need this errata. Please refer to nxp official
errata document from https://www.nxp.com/ .

For removing workaround on those chips. Add new i.mx6ul type.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cf235b9..d18ee25 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -59,6 +59,7 @@ enum spi_imx_devtype {
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
 	IMX51_ECSPI,	/* ECSPI on i.mx51 */
 	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
+	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
 };
 
 struct spi_imx_data;
@@ -78,6 +79,11 @@ struct spi_imx_devtype_data {
 	bool has_slavemode;
 	unsigned int fifo_size;
 	bool dynamic_burst;
+	/*
+	 * ERR009165 fixed or not:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool tx_glitch_fixed;
 	enum spi_imx_devtype devtype;
 };
 
@@ -134,6 +140,11 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
+static inline int is_imx6ul_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX6UL_ECSPI;
+}
+
 static inline int is_imx53_ecspi(struct spi_imx_data *d)
 {
 	return d->devtype_data->devtype == IMX53_ECSPI;
@@ -593,8 +604,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	/* ERR009165: work in XHC mode as PIO */
-	ctrl &= ~MX51_ECSPI_CTRL_SMC;
+	/*
+	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
+	 * before i.mx6ul.
+	 */
+	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+	else
+		ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -620,12 +637,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 {
+	u32 tx_wml = 0;
+
+	if (spi_imx->devtype_data->tx_glitch_fixed)
+		tx_wml = spi_imx->wml;
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(0) |
+		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1019,6 +1040,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.devtype = IMX53_ECSPI,
 };
 
+static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
+	.prepare_transfer = mx51_ecspi_prepare_transfer,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
+	.fifo_size = 64,
+	.has_dmamode = true,
+	.dynamic_burst = true,
+	.has_slavemode = true,
+	.tx_glitch_fixed = true,
+	.disable = mx51_ecspi_disable,
+	.devtype = IMX6UL_ECSPI,
+};
+
 static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
 	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
@@ -1027,6 +1065,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1604,7 +1643,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
-	    is_imx53_ecspi(spi_imx))
+	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
-- 
2.7.4


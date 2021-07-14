Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294553C7B6A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhGNCIP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:15 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:5093
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237500AbhGNCIO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFKohOABPO1YHxdoLuWzaWOgTA5Bpy4Sk4laoI9WAWnU71KNkpuaci1CPi5DiUaUuWKmmYuukX1wUE9C4vCL+vg3UNX4HhHBsT6/mjLA32KHEEBaZ1TxOHIjuazr30yeQExWJ2UcZJR4Xoh75+F8HET/4T3lmd4terLQbgWFHo8fHuRe6oofsBGZKyD94NGiHZjab4rpKfpqc22pUoJPoi1ZTbferUbULojFcQ4XyIY0A46u932MnHjkwzjXQoK1n7DRm7E13HRe7UdykUtbeRcBbgi7N2A8CglgqyGzSs3K38MvWa/kgD3tChxAt40ea4nj+13NbcymnGOTvHWqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkkhS/PLf8tVUbflzlvlcoQbnJLFeyEnpWPzCCb4UtM=;
 b=iRZVmIngvN9VSRvazGrsGs4NV9/jaI4b/i2Xi58dBifJP0GshtqrTKE8JQpyFYmdMUiTSFJEFgTtxEfeLb5R77CJaEpGK3Tck9p5KnG/OHD6UVW6Ccvl1YiuEO1P71xX1av1WBkcAFr4MTQkvVT66s0UP+1tyPMhC5KqOiuqmUkSJ1qMRDBkoSg7vZatKhNC4tEzGT2oVT26JPx8NVOxnrhjCNmkPjFvtqGdL8JUqEyCFAJrK3Np5GAY/sksYieBqbJsd+GGuWuwSCdJY7U58oYOrFPfUc/fGVAxTKvhoC0y4LSANgieqVItZR76JwrnwHs43g9sh21pImIMugM1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkkhS/PLf8tVUbflzlvlcoQbnJLFeyEnpWPzCCb4UtM=;
 b=mfI6ihb+180aVHh/bhMN6KVOMWiH2Yif2vR3rWduuvOOn7P5qNs5y9gYiw10PaKt6AfgxiCspy3BfkIkx7IndMOnAa3Y6LHX+r5Uf90spCuF8rI2LxPZfd9g1MM+VeRIaORIxUoQPLkH0z376WYJKOV5f7dLcNAexGA/1Bab9wQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:21 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:21 +0000
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
Subject: [PATCH v16 08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Wed, 14 Jul 2021 18:20:48 +0800
Message-Id: <1626258052-22198-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f268010e-815c-433e-f1ec-08d9466bd5f5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB41750C936DE1CB92E046A4A589139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzZJUg9QdLeTdnS/6UHBgGcHnDT3nDIh55c/u3PKTZtYr7zEPm0Mb38YrgD7kupmX9Au18vyf851MyJKKoai5lxEvUrVma74jEO1isZbcrQgQdYdfLO4czp2jGNdrrFQSXlb8G143DqJ32E50VH0fwXu1MkZSdIXL9JgweadEYRSCZI5BFj280bzJMJ17RvWznuvw1EKT+msmgsMk2tyn2FR3s7/AfEs8hYwfUicfrCyIFZXrK1kOakAtynp9d0PI6iTX7UNdRjrfRRLlVPKT1xXwS8hcVzSR8S1mDz4v2JCkre9bpHfOyjsSdoGLhNGIbP9Yb79nrx5SHJB9p/+hTbeInYuCJCQzx1DN5YHHJmiJR7Q3OvSqBV6BpBv3rX+wUDbOQw7+GCMWmpY36eW4vS94C03js+g67UCzx5PkaVZLln8qR6BxQSXlAtEfvnElcQoAbDhdVpmOB7zmz+NE6CXzd1Vo/MSQOsaWRWFLwr3iRtrFDSlmvj74sFifOZFFEGWn2vPrxPRaa7xqidqelg77s1fOFCJF8lBpm5NNDWDVie8O7emeLrEWsd6vW39Yl/h9yR9q5HB2DC23QFL7OolpaSPyeb6lMaOAmXnArbEXXZo1aTkhS0Caj+cmCZSMLyBn1FE/PYd1nvxYoeP4Eut5AHGQCW6MJwOuYxSi/fcrDmkxg9SlbpMtQFsIA5J1anD2wSuk5dIs2dP0Vke7zK+/L+UJsg6xycAdWpm0h2x4PymclpAPefUgdcgBqneVKB94Cx6ghRP0PrFVjOJKbq/3u/jgB2xF4dQKJU75SbdfNynzvLbHn2reOLgYWegWTIHpffqYcu8+xGBfFmoA+dBYybGPK9b+A7bmiLhMJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(966005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wb1vvwuafwAosLJyats2lG47udmb1v0T0NAJoExsp8I48HO0g/DtaZfsURH7?=
 =?us-ascii?Q?EY+KwQmgNsiGFgs0H05Eoe7JYDA6W4YmOZgFA4rebE8Rry5Oa/ImHPK5RENa?=
 =?us-ascii?Q?YU9F8e4P0BgL0Cv5BJs5FNDjKBAV/N+Eu2Yq6TU7UywjBEasVn27LlzB4FPa?=
 =?us-ascii?Q?vRhay6YfcZ+LNM/dk2uejd7PF0d6T84ryU4Yg/yrAVB6/ynPSV6DBmWyCIPt?=
 =?us-ascii?Q?nIjY+5aow0r8qa8XQgW6/Lcn7mKd3kHsEt+n4WVRMxwXpOHIiKZoJKooD17v?=
 =?us-ascii?Q?9gLYf9Gdk/OmX7IVDOmG6ov+wSjG9PujibbRb0gSw6qlYWXNNnJfReEHlYw6?=
 =?us-ascii?Q?KLbg/WkzvPALAOeUPoKFg4GUWZIa97Afw8EosQsbWAhb6IPBX/fDtiC4zW4H?=
 =?us-ascii?Q?K+o6JlZeGpjmwh9GmNL0ZTmUEWk3wTlnLW/9C6ArbY6Tyr/PSkklPewdsTM/?=
 =?us-ascii?Q?jhxZlEiRYltPzBfbSv88dRjoVF7RvN6BMFW6IimYmGnW1myKRcSgwcSK9+NV?=
 =?us-ascii?Q?nDlUl3VxuGC2iwQZ6TUgAFhmJ7zUH62sebnx82wnOKt4g30wHFcsFn5k5wbj?=
 =?us-ascii?Q?CpWsCx2olxGi0rUfn7omCCxlOhg/P6y4X4b9nuxDbeFtGjMkdyIWkulm6SZs?=
 =?us-ascii?Q?oe9ATAO/YJeG3dxH18IhbtUo6OSwOlBDy1LMcmn1Tm8uDtEsmM4Q+P0IYVdP?=
 =?us-ascii?Q?xvXgHTTMTIPkb3lwrBxWtSiY6WgS8PMneAXbHJm3qqcg9mTDMxj9CeW+5cYa?=
 =?us-ascii?Q?/X25v+yvSJ/RtrjeXNgrBKUbu9UXTAUCkqXIpOSgs8Fj/KDz90YDuArCxQtp?=
 =?us-ascii?Q?rbZ6KLXHkHyCdGcIOF1MvkdmCa81kO9bjjO2jB1LO8SppGoIPkRfBmji4gg0?=
 =?us-ascii?Q?XI/b9QQQ5mwugioYoapdCtffLr2zAAU4+8R4PkWxEX3wV3VFU2B7vwVunWOb?=
 =?us-ascii?Q?Ufh0PMj3wCn8yUB4y4oEwGYtSqWBaD8Z5hTZUxJkueYFZjLMohc8pP8DSss0?=
 =?us-ascii?Q?4VbZWG8oDMMg/BtbVyPYLnAV3Bi0GRfrYgFj0nUKiR9xOQ5JaEOsyQTB2Zku?=
 =?us-ascii?Q?EOAaPK9qy1IDDDDj2Rbc60Pt40l+T1gyc4eZ6pAU4BOcjUc8KO21ARRaoA+I?=
 =?us-ascii?Q?368vwROlICbGhthGywA1mC3sxc5WsycToSAPJZR6y/g5cBuoYRVnmQ0Ek3pb?=
 =?us-ascii?Q?NY4556UHVQpIZ1mvnLXzGBlZ3nDTCyXnoiuABtYnNf2Xc+GTujmghRKfcB7M?=
 =?us-ascii?Q?kv03Z8zaFcY9jjoxfVWI2HE2DAsVgGLLQHP721DXsyrPiyseNI4dYtJrcWGU?=
 =?us-ascii?Q?xRCVfjGapSm9QJBOkGPEUdSW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f268010e-815c-433e-f1ec-08d9466bd5f5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:21.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsBY58sXCXrNL9KLyfErznL9IKX9Tqw4DWjrclGDHojR1zb8dZB0vUCSAfGGIKbrAhWqJ0wbloBqRoJxG/ppUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
i.mx8m/8mm still need this errata. Please refer to nxp official
errata document from https://www.nxp.com/ .

For removing workaround on those chips. Add new i.mx6ul type.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 61e4fa0..63a8d7b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -77,6 +77,11 @@ struct spi_imx_devtype_data {
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
 
@@ -608,8 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
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
 
@@ -618,12 +629,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
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
@@ -1014,6 +1029,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
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
+	.devtype = IMX51_ECSPI,
+};
+
 static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
 	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
@@ -1022,6 +1054,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
-- 
2.7.4


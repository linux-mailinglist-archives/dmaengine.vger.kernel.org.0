Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E373C7B66
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhGNCIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:07 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:54855
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237428AbhGNCIH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LubNKwW79mOFWCnWPrqJYIBYHJ20vASlesqOpH6i/nA+hGD8nYz6SJPiLfnWqAcCwec4luYLfxsr+3U1I8fBopmPs59RrlEvJv29iuGmC0feTBxMaifdxqchrv+rADT+BkMHAJ9bay02dtka8Qwoamoj2VDWt979kbqhAMH1jdv8cuuI24kMVG7r5hHBr9ib5QT05bf1kGDBfr/HQHK3XWr5URUZBZGP2FsfuhF7g+18kdq3Vf+HCiMxaN/ATN9YXlb1JBDogzdt06zHE95MECd+hpod76w1RXq0c4y47atC9R82QhgH08y+/udMirf39GVpE2HBMyUou5wJyCOKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNYiV5p+Zer9BF/iPd2ivN5XQBG3Brjn3etpGvNEgl8=;
 b=bt9pU6agi8mPvA4Hm/1zgBP4m8D7vQ2bWVK7llEURaI0nIuiMl1qcmr3H0M/KyS66+G0uwE6beh1n7HJ0AWyn/ezI2WBYl7UzK7MHZy3650WNUosNXvMOHcc1Syj/+1eGWLMBgtfnzyqbkzmCmjeWMujFvO8LBeKkURbYDgDjx1wShmt8Tya3LrdTNNC30iJWzlDHZCCy1BDCiyR0ttYD/wOFF7gr6/m0YUIzC14KkpxB21qOgmeO3ltamb5fChLtBF5FghDdsLDcs1d99bXCoVgfiLRH8PfFM7P65vy1ztKzjlVwLz7CJyqLU0MQjfmcufDDlOMt79rWrmr48ssEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNYiV5p+Zer9BF/iPd2ivN5XQBG3Brjn3etpGvNEgl8=;
 b=oTiro4bYTnDlF5PNDC++7kfiquVB+4X02tx3gGNYgX1vbpyAnsz2FyE8FRiLbpkm1gopnXRxoFgB3q2YFCRRsiZBTF/OMEqVCvrG/bTEAIA38uYPmuRqkRL8IODzYVXv9YlMqY3xSLiLMQCHVVH/XIHqec7mBonHbAudVhLIOco=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:14 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:14 +0000
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
Subject: [PATCH v16 07/12] spi: imx: fix ERR009165
Date:   Wed, 14 Jul 2021 18:20:47 +0800
Message-Id: <1626258052-22198-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ead7d8-3180-41e6-8e8f-08d9466bd1c5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4175E0C8F836542F232BB28F89139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdlXoprDvwHObC1TBTegO6vDtGBcWY+8KWAahuYEiNCQ2BVra8MSX729OtsyoJk9rmFFi/iN3xjL0R9zSQAB2060GoPMkuHg0qMKBdma6tDtukaCCqvT2+kMmAAe7zWy2c0ClsNYz7a32ZWY5IV5cEgfHefcAYMGvANjpNUjlJIXQ03w0RBwkMmImAs01YjGW4O1qJ8Cd7ZVOLM5VGWBQISnKvZOU8YNBC3+oGI6IZFJJUznkqoTMIoIEWpvA8bnHsZwI3y9DjEuSF7fQPLJhrVMjjeSnNdJOqQf3dalWZbk/LtEqJLFOtHZ644NdqVt8TmvICa5WhUEEz+uGpQ83u9k+pLDUd2H8v6Ap/IZT0UzBt57cOGL4C9MmoJEkEcXXb8oMqn1nk5jFavCuvVm0OuZoRceMnXiwKGhZ6BB8SXZWTf9ZCOQelanr9TzHFgmKg030UTnm0GNHX6BEkKVGBVDsQPseX4V4cxkrFdFp02g85GC8OrAXTSFwr0iMwQw8/Td366JL6AyxteZVt0C9lY1/h5uy1GZ05DPDESzvag4dL3i6MxdwvudEvvvUqxKA/w3DzyIYQmrkgpQk4BYQ3GjulDTLmEgtXzOubA7tqkt39gaDvwbN0xVjIel3K9ZsNskGjLLq+Gh4V1FA1jl5HUMstYxCFXTbPTMkCFvqdtJX6rC7BfHl9OPKnC0pL6MXYilkrO+N1jcYgXqCVEvbiFUr4Osl9ksu0GzCVxH4xVSvNKL1Wa6FVcvbXwO/e7ggj7YHiAzt+MgHnVAEOa1RmrLa+sfjgPB22cLuuUWa34vHupPi+4GJIUikzpUC98y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(83380400001)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(966005)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3Dk2NCZMrPlwXDb7T8ZZTprOnF9ro0z+anAJWVB0a41kyKsNOhWxh9Y9h3n?=
 =?us-ascii?Q?oTczicWL3NWS9luiOm7UZv8eZzfL6/EYaipnEGLbzYyHv7FGzycj8usRk6d2?=
 =?us-ascii?Q?2ZG8sXTZQn/CB1CdbbShrJe5mxZMd4dAR28AjVmSxiyLEixXiHWdIHqDTkjR?=
 =?us-ascii?Q?7XCCmTwv1kDpejUMC67FmuEKRjw3ilb7jNz6XvGRvv/SFNCVIOul9JHmCWYL?=
 =?us-ascii?Q?p2i8f+rOzZo+h85Y9oLxUzhLVD0xyKQTsqlDmrVuuW5YwAuSmgX24PylOhqK?=
 =?us-ascii?Q?LfpxzSUEpP2spELLyWzqbzI3IDzTDGOGKLiMLdjc8vDVgaUHO3/i8uYB3mQD?=
 =?us-ascii?Q?5mR/19AAGd+9GfEUIfCpB6ssbTKJtUdEirDRzs1QDrxkqv65QCmH3KFq8SqJ?=
 =?us-ascii?Q?e+apxFU1X1y1bscQcm66jXxuAJcghy/Of3/GPuweAtDfriaO2dR+EhL+4i29?=
 =?us-ascii?Q?UeFPCY4iDqzBy1seC9LIThtpe3ALOMbrNsZlEUJNHsVY+TPxKwAMI6bjjaKb?=
 =?us-ascii?Q?ysOG7Ed12FhlNNwkBc8fpGOJvoCAb+RPp/OJIyTWK07Q9ig9X8lmspEwGNya?=
 =?us-ascii?Q?CofdAAERlKE/ovsb1P7UmiJ1i7nrEvavGFJ8tR/qOvzuxJnUXjtgzBG4rc++?=
 =?us-ascii?Q?eE2aC3k2SYfz8/VoHngyd19c1iqiCp3JzKh/2u6YoJQTprwcElWhrQZQRttZ?=
 =?us-ascii?Q?edr2X2jE9D7P10cNp6HKd24VL/QH4iHKYszVTrg7JhGeg6skDsrt/phURdoL?=
 =?us-ascii?Q?k6K4AcPOakQgwcjsQPp6Go0kdKTDG2Pn0IxeGEI7TzkKampaGuJ7yivSAKw6?=
 =?us-ascii?Q?l0Mz4yqvBrE4p2AtUL33Qk2ectqQEU1GKuNsg3qNXkxBVtox/SBmtU94AY7b?=
 =?us-ascii?Q?vQxu2rXH7QNxOWvEmcQb6+ypRi2oNtg/Tkf2JwZexB84sLA92/4urB7hL+b7?=
 =?us-ascii?Q?ZPlQHQ9cKJxAcjB6HD1nIr03pDEaDte3ZJD2ASjM08+byxOf1Su98G7vRW7A?=
 =?us-ascii?Q?VYUtSsXK28HJqFVlVH4d3SnMgRzmROiBFjhjcuB/d+fSWBOy4TeXm4XxP84p?=
 =?us-ascii?Q?8An9g3ECWIfrJpYoyshmD22M60L+sJWD5uAahoJZUP8d2CiBJLg8UUvYv3Eq?=
 =?us-ascii?Q?2O73FRfqEON6Bn6cYUSL+QB1VZkRCtDTyaeCkHZXEuT5F5aQmyfCZANf84D6?=
 =?us-ascii?Q?p+KC9XdzGu3AhjkLClP3Ib1ehXqs6k1pyf1fQoCrhGe0Uhj24VN3lh6dnbu3?=
 =?us-ascii?Q?3lfUPpPw4id1dKh2UOFYXv/x9+hNzBO8iyVglY4UO4dP38PEGODy2hT8DvSY?=
 =?us-ascii?Q?9gcleyjDyycA+XF2tjynBZnI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ead7d8-3180-41e6-8e8f-08d9466bd1c5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:14.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZf5iQUGCnuNlqvtX+b258wqBG3MHWIqclSGuLOaAk+OiF86HmzsRj49D3WMO0jjEpgEn1AKpVKQY1lqTF9/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
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


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8117A7375CF
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjFTUOF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFTUNw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:13:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9B19B4;
        Tue, 20 Jun 2023 13:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXECgD2N7sH8xZyLqWGJjO0qZV4yUJZPIQF+QA3u5KqhtKD4L10QRAyXZv8D0RCeCV5Vabh8EBCBEAevIX+t/hFJI2QBEH3ujrNDnetnBp7aaUhMY7qzqAdfkDUFbsbEzhEDsobRjqo2EBIUrRywaJZbSawatEljJNB2Pyivh30m6id63a1+Zl8dv5TJ86YafoIjfJsfLg4wowfRztzVXhzOqSVxDUuVaCOeNShNnFeB+Y8/EdcaovLG3WQBpRFm2OowH6RQka3BigQTc1TVqSnoN556Cp7KvWaspCDholddZ7FRX8e1roshOHf3gskX/o84t7R/NbmiDuupjP+USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=kgX00qiUW7aPuRiq+jm3KOOcaazOyktzxdFh/8RTu35rJo8G+8qq23woY2madGhpJXIRejDZMdvcWRtufYCCGQ87K1fl05JLrPUB+M525G2brHUbaVwyz+ob2uFrjF89d5xbZoEYGHTy3cdSjVZE/0LODiqJ37MN7A26w8+kI5Sh4PqCYBohaERlSDiqijP6n7EWO4sKm/N6rjr/Lo1mwpWL358g/TrCQvOmUQtlR5vu4XirwU+66tMWzYKyQtwyb5wytoAkNCEDGYyFbN4eVSOuGmCTRa8MDOFiU09gO/1/2z8D3Ogq9dpEM2dNpbXhZDJrr+rrg7OwBzAyG3R5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=oA5JEksnC8CUKDb89laKFIvF4WQLGS9oVaeXVYAey7zeUX3CUVe9soPSk1Yd2rHXIFHYHhKSn04DfqY9AT8iAXWAOPn65U6y2wT1MJbMUtkEqY4o95HuE6/On316xwKjgDMbbXY+oGZp4oktJfDLdYeTlMtmiHxxYg52uIiFBRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 08/13] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Tue, 20 Jun 2023 16:12:16 -0400
Message-Id: <20230620201221.2580428-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: f91d0883-339b-450b-3c92-08db71cabe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANxSQzmW7ct/55eQXo2QQh1u63sGTCKSEaRnPLh4Gw36KH3XS6xZpJdruOeLFzrYw3bGIwsW0GC48tINDidYxnevQQnJr1OnD/OzI8G8172Ojgn9u//5bwmOjolbbckeoJs7guvG2zPU8dF+wvYt0fgbC0Pe0Af/jbTVQVRBqLvC3ZIcIrpPHVgnDoL0WO4UuqaKDXPKOopGjLoK1JGcyxcc0SoWo+tYm5taO3ikVLS5HL6CDJ/vasaQvnCUPXz6ceYefHJNUfg3X2L2+9iDM67xoNzgTN5pHY5bsyVTecxo51odavkIb6TyS49EqizpwjDrLFkDoOrzJ0kkJ0HGlAVBC7OWKXzFbzPkM1HVuBQOSW0VXKpZwFvIBw3Lh4UMRPzIp+WbM8PiL2pLLCElu5r9ga3T1EIYBky1KVFo/ZRaziCs4LK4agc8AXT4GbWynpbhnCDgXaNzpgXDRqSY/Rw/X/aWss3Zi3/H5TutVXRwFinuUVi5LOOua2dB+qz3DGGVDfVHf2My64ytPUxYQ5HMykEGqAALXDn4GnP3x1e8X19neuw0tFRb8YT7NdyeZBTY1bfWN8YRwGmcUIOROfYDTp+ftdiuwsbBdJLWwDLQ1l4NBL0FQmiUf7PCdtCrGI12G4DmOdCgdH57iljC+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Be56q2rBeaMeoEc7Lm0/h7P8O9mfNt+mGU3gIdk7GOiiHdglzEi5TXKBcaeo?=
 =?us-ascii?Q?DsFVJUEplvOpe1z70m0HhJa9rFrQ1uMosQ05titnCSlON+vnR4sufr0gH721?=
 =?us-ascii?Q?7bFYS7iSrPGyEnuJBOiOJDduJR8DtYcatvwmg3qLESp3BbmyfnVGGfB9jGJs?=
 =?us-ascii?Q?buSIcgS/Ub5Q7TWb/MZsb0Xs+h0Zb/tY2LIaupUFoQylczvcZ+757G2j9FlO?=
 =?us-ascii?Q?aXsu37nFUyWTIbgBadAe6agQm6VyEHa8z1lzm2sTAOoe5ykQ3JfynNEkLQm9?=
 =?us-ascii?Q?1ds71OYTFFG7VaGTOBAXMMLxoDAM1GcEjGNDdjAJkXW67O+uT94zH0VXn/af?=
 =?us-ascii?Q?4abXz1nSCOve7A4Dv/eGphlvyNuawu9vfR5a5l10yxOdkDO1TVa0KgZ+q4UW?=
 =?us-ascii?Q?VHMJSiJ8uRdQya6ingqt7q7xKLLt5dm5gtGpCR4dbzGa87sTiOc9/9ZVJXG2?=
 =?us-ascii?Q?saRM1ynaz0QUS7fotWbvarjcp4MfRVWy1g6IXEuCM4mPYldzGo0B5ZJOF2kD?=
 =?us-ascii?Q?SHZeOdUqX/jEPbO7Ep602P4gXKzkkdGsB39B2vY8qXxAqco9N5AKcMEbUXke?=
 =?us-ascii?Q?L5U8QDwmahumd9J2hdSIjSyuirbE4ufx8AUfhnMoDZoEmp1Zsmnxe5U6LO25?=
 =?us-ascii?Q?9zftLNRhLClMiVPaNUibrShaBfeLsznoHYEAk3ZYkWsO+Hw/1RJI2ZcaT9Ad?=
 =?us-ascii?Q?Xen++cQs7DLx8g/dZMAiufcraT+PCmyKtjK+TGWReTk0QHEcQWSSQ8hLUa1Q?=
 =?us-ascii?Q?xlel/yb/X8WwTCOtvVQqYUTFg8/m0uyrMyjUR0aEokhwEu6gSR1lK/E1PPJg?=
 =?us-ascii?Q?9QL704Uaxuk4ZqRLkJAYBj58f4qjPY8TN8+gFfOsPYhWLdJDqmGPR7fEYXsQ?=
 =?us-ascii?Q?XLl7npX5Pw5HDVT8FjP/AVnsDud0mkazmE+Ll3U0yYwHIMsPLiwy6wdETLG3?=
 =?us-ascii?Q?6GnlBSSwRMjFoZOyybea4SKM3vIULEtZPp7xsmLyhVCfKm/wJSJsRzoHle2m?=
 =?us-ascii?Q?UQba3mKcKGfjX/fs0MgNGdqTXAZBaRrsELh6q6Ow0AXMLx0Wa6wAIGgh0Rr9?=
 =?us-ascii?Q?z88fJE38hnQZDSMGpOP5owbDXc9p+DQZ1vKI349UhCYMHzNygYIUCjlOI25s?=
 =?us-ascii?Q?3hhnTYv6kKxX41d5DDrKCU3zeCYBjhsBIJOfPQCZ7VP/rpkZqB6jZFdWJ2fb?=
 =?us-ascii?Q?iJnXvC9TqscqNgmeH6DX80L4bSFx/UgZA7HkdohRlYzjHwvBrj9hBEQw8oTZ?=
 =?us-ascii?Q?Hw9TIibHpLtskzPbhsec+FCWNanA1pB1LhUvtEdv/FMVektyIOdiEt9HT81r?=
 =?us-ascii?Q?E74r+5nbLvECnZIbGcy+Oqy3j+BxvQwWr8jSeEUBprmvcmAKc6MP4MiNQnnQ?=
 =?us-ascii?Q?+qbCw4Flw8EDz4BVHaGH4f6+gWpFpbpDGG2rT2ZTc8RJxLkTwa9/kNGAuQ9t?=
 =?us-ascii?Q?Tjcoizqx/CMsmDWyZBJFwlOdG0lAnk01mi1imltgA3ybDjG5Ltuwmej16jW2?=
 =?us-ascii?Q?KjFJjjz6UoFlbFzIel+Ck6YkzrM/mUxCM2c8048jPgOSc+coyT+p6fdwAKye?=
 =?us-ascii?Q?d4yMWhLV9O6FWXleGogkLRVjdqy7VGINPIlgrrfZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91d0883-339b-450b-3c92-08db71cabe56
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:59.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45i2ZZX/ppklSfioFlg+xeAIPfkng1D0vVujvswdc2QawaPQRjZ6R42sGFtPtV9cjo0JVk1jt71fQA4cVAMSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_clk_get_enabled in probe code to reduce error checks,
thereby enhancing readability

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a0e54ca4893c..503e5ad5a8dd 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -266,17 +266,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	regs = &fsl_edma->regs;
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
-		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
+		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
 			return PTR_ERR(fsl_edma->dmaclk);
 		}
-
-		ret = clk_prepare_enable(fsl_edma->dmaclk);
-		if (ret) {
-			dev_err(&pdev->dev, "DMA clk block failed.\n");
-			return ret;
-		}
 	}
 
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
@@ -291,19 +285,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 
 		sprintf(clkname, "dmamux%d", i);
-		fsl_edma->muxclk[i] = devm_clk_get(&pdev->dev, clkname);
+		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
 		if (IS_ERR(fsl_edma->muxclk[i])) {
 			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
 			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxclk[i]);
 		}
-
-		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
-		if (ret)
-			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
-
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -364,7 +351,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -373,7 +359,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1


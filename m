Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D80730866
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjFNTga (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbjFNTg2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EE1FD5;
        Wed, 14 Jun 2023 12:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auK6Y7AZHSIIZ6Eum41vu4kxhyQbZ97TbkrEptKttnmnmbfmhFfbvPpoqZCx19bGCG3jZNPcnCE3DIg0YwIfZ9cebSz0wYl5YM1PEb0Vs6VeZQJlyDPfIEpNMqXARRplGJigTEcSpTPBGoRHW2KVzbXICGCJAX72/qdB7dIYk8hWdwM2WUoM4/lIFgVo6wm3ozau+GTF6C7ynU3B8N9RzhHfnVviTdZv83RpDNV7ZJtq37GmmI11bFuF0w3BImsgmj2bW2mxuAi8tqO9Vyo4N5FieFQbVDG4MsCkWGVkm11ru71jGe5T587D2tr3chNomGHsaDjZnX6l5MUXKDo/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=kiu7BSDx3OMBMVbqZz0OPNv6o/Dfz6aTkCGRp/KaUXNt/oiJ5kGPD34800WbWDu852vaponBpQKHPfGUOCytznfSKy6GCyuJoeRrfRwylalC+mn5LbB5uskoYjPrz93nBcz5ocQbc56rHC4bJJvkl9M5q/RS5Yzi5s1qfDIYi6Z1WQ5bPWT41CmoT0EbyDL8XhjcZ11R/Oyg2UILiCiz8L78TLQPEL72J9i05M+1QwpNqkzwDoTcS1AbtGJtm2FceT8GBWqPozk+TUW57BlmQr9hUq8oS5MTsFViWADyQohXVerB0pk99MsM2t6Cf8XfrcLb8qwRVfMrJh112AKNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=gk7YdFomb6l2NQyrcPSTX2noDYVlt5GrSdBKkth/OPjtiPneN+lerljM7GYAWNgo3iU4WVghsTKUD4x6MLXOaTioyy6alv2JrBEhcIIhipdFEXFKvEHN55tZu1xGiilcOs7CUdQxfzFTxss/d0YJ0AAnNhqG4vgxdMHdA0ViP8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Wed, 14 Jun 2023 15:35:39 -0400
Message-Id: <20230614193544.2114603-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8766523b-2f05-479e-3c7c-08db6d0ea092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNHm5iOqTgtycQEGM3xej8PStfqbCnDkWU8GE+GUXcbYzrWncrZKigNshtBTS30C+eKfhnGC10J+M32OhhaoSBB9YRciILXuNJnkA41MOJSZz/NLn9FbGTUu1+SJyahv92FBpgyr5lY0do5c3KBcWHLo40VabAdLem513cKFLJSMQTnYq0CREjIIOPv4su5c2VniksNXY1i2ZX0B4GnpAPVGrCf8gz/+IDdXmv0D2ECefVREL2aMvW/BuOkgO7TWT1qRSgdLKqMGIYbweFm81CdXkVkMxNc78/Jh4U/OpAZ2XZmoiGfLYXvVEBzvg+205Hsz6+6GryFpGEABiKcJdvKuWtG6n2bYGQfyxhNBisDKrHl7ca2Wfy3aOnhgCHIpFEt0Tat06bTixusQoYlTV8WRS8LTIPtwS9Qg4l2RDLOJ3uHeEbviM9vPP2iSSF6XV1XBAA6L1+dSKyfZHumdxn3RQ4Q8h6vdH1fHG2Jn5JzU61Uhw2CfWafqJv7cskRzqaFscyVdW5Hhn62Vcpm7YYpwyJLZ+hvlN8orWpxtQ1tQMCLylZ4md4fLUxr0D5TZc2UcYjmnaaZyj6bThs+6hqLFRdkh3zHBUUESc+52Q8cu/rGeRhInWxdlEpWvNN3k3WnVYj/l+K0Nh7jxK2HmLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3KntrX+eAbKfKCW/tmOdkS2d2Y1sAe1UvQsUVorY713+S5hARcFv+emFAL6?=
 =?us-ascii?Q?CKcphszhdQS1pwcCzsSlkDE9FXMd5t1KjQVaSBZp3wQp6aUGa/kzdhMz3cZH?=
 =?us-ascii?Q?933llKPBJ2Gt2BVQL2R9g8BxCQVU1oydS4W3JE3VSA/5iukOHL4qjYixSeZN?=
 =?us-ascii?Q?eoS4fxrye/igfLocO6oDn0/oejyOYOphk0JXY3Ik0Glv3xWdciiLPHOUPR4X?=
 =?us-ascii?Q?fBLZHPOPROXqLGcFgB2UBggZvrQr+3wyjzWsRGX1tYlsBFVzPt6t969jgPx+?=
 =?us-ascii?Q?eijyMZ1PsGKZ1TxQnMYpWxuqw7HVDOIdmCr4ZKYZr0Wnt3MhIP1xXxVZ0SZV?=
 =?us-ascii?Q?rQwowgJhk3bMk5svIi8VFoLSrpPY7FD2ljNWMB5sG7YIlZVD89Hs4+mW73L3?=
 =?us-ascii?Q?YkKKRQLXkvtDx8EwtF9gHAo9ZYsbj9Fgv+F2N/vvswnME1sOS3qscCPz8z0l?=
 =?us-ascii?Q?tMcF/IzP1H4gAnP8OK/PJ/HXEoztZAgF03gAXHwAxDR54ZS6J3kMmh99iIqs?=
 =?us-ascii?Q?E/9/SVBZ4L1E4Vrn5y4E/xhlYtjqfgJthA42pVKi3+JloURyLY0KAsBT/k/I?=
 =?us-ascii?Q?Xm8Gwr3Ti0nsjY+Qz/mh3FF3qZY1C4vkOOrUzVR1UfUGlJo6OyrePuawtZvg?=
 =?us-ascii?Q?bxeSV51Tj8svOf4T0fe1G63vqZXQRcRiPV7wu+b7lhQ7MLMjOgRgYbO5TMKz?=
 =?us-ascii?Q?FIZMOciAliIUX1W71B7vZHzPAmKdl6ILNAMoIB0kcCJhAUvS00k7t8tH0MT1?=
 =?us-ascii?Q?oRc8NyK2wqRt3an500UuTtnqXLK9DevAxMBSr6iYGXD+Gj8gAicnV9kYlw1D?=
 =?us-ascii?Q?mEcuQ8colBTV0uDw/YsbwOH/Z9Z/OxdrmjZDMlFn4v5Ijl0Nb8Hkm5uMTKWp?=
 =?us-ascii?Q?onWm4oQNT13dyNEyxIZCkR7iS3dL9xlOchmbPTzCFAW83ZDrIBxypvNbSTD5?=
 =?us-ascii?Q?yzfp0lphmOYuNaz8s7/ZJuyhFtbBCUnNuCja6jS7svstgk3tBYJ4JJtfYt3g?=
 =?us-ascii?Q?7hQjdFmpCnhxR16yn0B0Zog96HY6poKxEpn77b6o10CrU4cdEAq/2lRytnaY?=
 =?us-ascii?Q?/48/WceVFc2bRtlKiRRrqzeMtWp8Ng9UyxeogTXIoJbiDJSzCo3SHbxlGl36?=
 =?us-ascii?Q?FFtwLy9b4ylqPS5h8PhkKDFmoEdrZ314bieFlrUPbN62xgvLTPkpz+li5dVZ?=
 =?us-ascii?Q?bPmnUVC2wmMkpc40q2iWqPRyRjmD7V0no1f5tIirkUVrYOinpkZ4kTrZuTTf?=
 =?us-ascii?Q?a01O9bxSQ7f7TgYiKehzttPibokHdgFUEZZem6wWDBUAX4fCkdGNpmP7trzO?=
 =?us-ascii?Q?BjmASiPwqfEeNTc3HKPkvbdjdgBRs0DhRmom9+kKKdDqKy7DqhsaoG23b6aG?=
 =?us-ascii?Q?+VfdjzlKHUo2ScbfnUx/TZt3A3i9+CKRC6jbfaCXuDHlBRJJBDJlRBF118ZD?=
 =?us-ascii?Q?hLhlg+J/k5WBr/FNuQLeVwJwM5DF3trWDkcewga4jdeBiDcB04scy6SIrlBr?=
 =?us-ascii?Q?UvXoVsW4rx1CyM68wVnPm3VO0C0sEbCeFPXmgQHKQiDji+i4UPcfOtBRzRDY?=
 =?us-ascii?Q?BftdgEBmQCCLCwKe/LUA6ifWPsRTnPBLIK09wZd0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8766523b-2f05-479e-3c7c-08db6d0ea092
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:19.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DLWyzxenCa1cVFXMWPHLZHjpjSYPklGHoQSDiCtbTuZJNbjtAXM91/h2/2PSiCAOECUU2psaWLimVnaz7547w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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


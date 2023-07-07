Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43774B6C9
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGGTCV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGTCU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:02:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133862703;
        Fri,  7 Jul 2023 12:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT4dfCtgOlF6DjeLJZdMvaYzhVwko4m3pEJCZyA6dscWJ57oLoYX9WEq2CmeUpFrnOFSR1n/OIrkbMFUAHTvtdt8FH4TksUexEP6PR1ThN49lecms4XEfvOoESpxvAIXmJJucnrUrd2+EpEFQO+NVql1d3+Js5CAMMdJenNhJbJZ81Km5Tz0vloSVJWk68cz5j8eHuUltF4JzHK8bTCEE/Xro4LsjKFFVKGe5acxiBdQXnjE9fc9hs9x3E+EieruglZG4Z2viHQLH1XIwn0wL8M1BzyJAbs4GkFnnLsJmJPK2IoA98gTiEp/zAedqV/9FmTgYQkVuIqdxKWDaUidNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJmS0fv87A2m8ioygrPmKl4m0cZ6ysbwH8gW689zRcI=;
 b=XJmqzsihht4/aY6wJ2N8yDiySJo/6x9B6oSfgBEb4uNtpb3ygFybWnYNYeVGplV1mQSwlyppjGuNVldi8fwASf4O8//IIzcunv9qTXx+FjWmOIjiBt2Y/4+HbARtlZKNSYA0jBdzw0Y66vkgDb2lC+JVviRbzkTp889iYVWS2FSuoXnXYgjt2/3+W6zIT720SOzzkxCQLonSUhZZv5WKgtJKKkR//eDsOKJvy/16+a39kRe2M9nfVvgGZccdm3W78ZWXJ1SGgov74pafJeZNlSkIb+RyC9qbRo+aF0msTctjPjIDqpdsPsW9oYBz5+Qvz/UHFBvDWXERlOMg4rD0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJmS0fv87A2m8ioygrPmKl4m0cZ6ysbwH8gW689zRcI=;
 b=b3y6BD6+v3IEDK9H1ZovuVVs9lqrZGn27yuccjEzrVReQ8qAzJRotMEjHAf/8C2oLrZILhnzTiqhj0z9IyR8ia/CKVXFvao67mZ7lSIGt3wYY78NYUYVMPFO0a+fTs0eB8xkRg3C/Lpk3q5zUi11rTCFmBmkYVYKzoMxFZMLVyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Fri,  7 Jul 2023 15:00:24 -0400
Message-Id: <20230707190029.476005-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb60481-d08a-4368-7c83-08db7f1c85ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUl2cdn2aGFo+0eJNaDBOe9AYU+fTGC35uh50lUkcs+q48BZ6CvvmpKbjeQXIFLmQOG3cu1mTaNPPNL8bsVyv5CW+w5UVeuogWM/IxWAMl0xh9aZT1CMgxXa6VNk6/uVqbJM5D2iUmxwqjITOjgAKWAFZpMDgZpU/yxeyl67qwUwcHVb8hTLEH5AW2r0SJdmsjgPZYl8JcRe5H3b0QqNmXmzdmQcuuoFgl5KDsm3icHn6baymvrgGvJD/JZ3i9TaI8a5AgnRK1rty9CDL2ff/yjRMXixz3aWzuBajFp5J9sKlCh6gWV4FVHTh8HHSVMpslwyFMPv7zecdZam5tq2l7SEJMz1jUfv30eSCEQ2UgZOK/EiKnCluwbVYCpZesPN+Ga6xnfrXtdmGLN8vgZtjil2IHiEWwVfi0wqxFeGDqLFVmxFFubXfF8V99RfjzJXvFXWi5BSXCvWbY5FiA9lEj4oUxZF+px0rZ8rCBFJf9tnzUOIB279W7OhlAT2JmV/ZteJikxv36p93QN7Wm2PCgyE4zX//8irAs48S2LClNBp3vcCh+vtv4CP09DABwbk9R00DN/wXhmJGEzJ/5ZmXIGSCEoc1Isf5QlxPDUOXr8jsTDPW9cTGKW45+Sku9QX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(6666004)(26005)(1076003)(478600001)(52116002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KX8IDShrTUyDpKgEWcw/8mK5xgaAsmOyuToknhoo8cnugx9K7hQmmVZQFVuc?=
 =?us-ascii?Q?kF4hU3LYkloNxJsnPIfdMA45Zf0akBwJ/PRdL1USEnYVop44XkgynautCvSW?=
 =?us-ascii?Q?a34kTH9dUABe2EfMliLP1I84k+Dz2CA3fwZ+wHn0xi11s8ck+CopOdynCwCN?=
 =?us-ascii?Q?71Mo1p+saX4cC0122DP+QmKmHmeqeb8r9/WVpm0zzYRme6A90T6idHzrA2Ep?=
 =?us-ascii?Q?WgFz1Ub6tzyYlXy+Rqy2pvooC7H4kgHxDn+jrR6Vcy3qHX/TfnRofbmw3KaL?=
 =?us-ascii?Q?EtAt2atP0xuIY2dvAThVAAHO8DwIqGDl9Kij62Jyqs8BKUHsjYm+BlhI5W9U?=
 =?us-ascii?Q?bNxqb5j96c+eEhI0zICaRnTURy35mZXo+QElNyqtl5Soi6dQePNm3EKjxbOM?=
 =?us-ascii?Q?LfXX9dWW5lPEkx8Kw9OzsJvSUOHc/dfbu2JLZ2ai+49+TPb2yEQKWyygcLth?=
 =?us-ascii?Q?7DZqoZfSmyWaFZJKu1MUTHcxX8kGrQ2TE3GB52r9qc9R372/z73RV1IAyTod?=
 =?us-ascii?Q?dMu3Yr5Z9kQi+hSFIbjEHfTZItkadTXb3yogHnEW6dOb3F0fHaH5eD3SkzVd?=
 =?us-ascii?Q?nO0O790pYkH1oBxFVFo4YyGNR74SWEwRtjfPVmq6NU6nqq1XJyPdkBiEfd85?=
 =?us-ascii?Q?4zYbI+9A396nRFRkRnRbHl8n2cqMd+CyTqugaZg/e0pQ3tDhIOMsqUTPPa4J?=
 =?us-ascii?Q?OX8lAWUdnUixKHofmQGyqnorW+bdlpIHZcnAoUKbUiXFRtTPU093Lw3MTK3l?=
 =?us-ascii?Q?CzUeHPZLrsnPqtuYZ4kZSCAL5WDvjM70fxbf8uywgIaCNhVIMVldWJ+L+QqD?=
 =?us-ascii?Q?th3jzzMUBziwnkqyub3Zja5/IJb86L3T6Z4HQ+hyvlZaM42vDMRrXUAG0gze?=
 =?us-ascii?Q?sX4jCgG4hhRB1BGA/X+BV7gCMbauSb3ByqD8JaC1ndfryDQyuiUGCZSW2af9?=
 =?us-ascii?Q?sq4D+Jhta19VJay9VuHWe95oq+XnVH8R3+PVmh36bbNDuOzC4yiqLo5yyt50?=
 =?us-ascii?Q?Yw/kxj/OdFbZ4jU85OIQ7yEwehpJRoHod0bM7HM+KLgQ78pTyWCP0OKi4qR5?=
 =?us-ascii?Q?YnHaFxDzojqx8LiImxhogI6/Kh+8q9Lk7caEOGF29VkcqYHMAzax7Otwp1jT?=
 =?us-ascii?Q?qip9QK22yqi7IKS9ucMDosHNM/HQwStjAljgX+TBE93/fX1kimdwcYVqNbo2?=
 =?us-ascii?Q?qMxOPaIuhZYU4yCwhSsw+ik9MumxPgsqnzdE4nZ9jv1bIEC+5WGVii+noFn/?=
 =?us-ascii?Q?CWznaYW8FdwAuE8ktVWVehAbeJZ02mgOTJC+DY1hYZMNcjXQe2vWDsqMEcsq?=
 =?us-ascii?Q?3rjoD050aZ8sv98OR6OJW9h0HrS0gp4UpoaOcgh/RHf9PGT7M6A3mdeE1HC7?=
 =?us-ascii?Q?g51JffIEXS4bf4AXIAVy3+bB8CD4hZkVI/z4j+Dztvc9mAZloU/6axc19qUY?=
 =?us-ascii?Q?QkYG+rBQA6vcG01qIVUPNrVQm02VGevtw6uUSxo9xqMcj30exSyY1UdKYKly?=
 =?us-ascii?Q?3/oWN5PAtME2BVjMsyEDVNDM57AXpwcsRRQpI+xCADkI7L21xOa0PkJFuI+0?=
 =?us-ascii?Q?zN5hDcmPGK0oiAuZPqc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb60481-d08a-4368-7c83-08db7f1c85ac
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:08.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvGg40tkR7LT7IkE0TOApwHHNefAnFSmKg9JEy5EL2vYMf0v19cqRHXkQeOOWq3PTO+pmI9jJw54yPbpmBF/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index d974db8c1776..e70cd39bf45e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -277,17 +277,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -302,19 +296,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -375,7 +362,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -384,7 +370,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1


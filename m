Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A134D7334F2
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbjFPPgU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbjFPPgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:36:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3E35AD;
        Fri, 16 Jun 2023 08:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYCm/MHKMSgvpiaD9ItGyNbT6yz7CGCVOgDnVHcXBxG0fin8pk/MPBXHxA0gAGY1CBL7af0qEX09iy+gwin8VhYyRZvdzbdRInKPib8qujAkrNFQB0s5Nmr60YcggRPHyVkYoJ+QJ5oE0aKcb4JohJ1WhTEqPfMwEdHY49Qvjm8PLvbopzLNqm/zJ3jVQOZLAFDA34+0eFHwp0k3E32/nkKHDLCyM49qgsFiEMuiKFHlaaOmuOyzB42U80PRp9aWLM1KGDWlOnuGaJxVQxxkf0hdEbQDSymZ8lBaFPf3V0BqEplY5+ISe4bDQjYHcoIyL81Mvv9xE4w7I0qEfgsc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=SvBm3+1OmQKKxw7IFOPk0oOx1qJB8ginPFqNRpHbr6XBCamDJ6O6ZiVd2sUSojc/qtz77uosBkSYkQ5wHbK59kF0ibAkN9BFPHT+1HBbN3FS+/eq/T86GFhD8gVDoTOL93KMM2mDpfA0t2KLmiBYmu4JICx6Au6l6J6TWdOilHpX9JIdCXz+w34a58wj7GkoS2KfmgR/1u/jxniRq1+m52KVtpuu6XLh7+ghpvbvdT0TMD70z4yw4LTZJ3MmKM2O7R/s1q2lkOzQpWT/uYC37cRelkNFiiFreRDr5OQX4HkOR+jH7mVczWuIUSpO/O7+4CkLV9MYrsFLgZnXBw86LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=Pgxo+K2GThxuuTmHWLp5z/NGZ/ek0IpXGP+2F3H1MCNkkaCnFoT0ZzsfW0H3xota9VyaOivZh0EBNMsU77XWTmdXoRcyXNDAjsNr6cX48ibFxFOi7WdefagQtO2c79nG4hLfvXt+WStH6EBE58VjJEVVL7Y+0Jwa9C5L8Rdb3QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Fri, 16 Jun 2023 11:34:33 -0400
Message-Id: <20230616153438.2299922-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: b485f29f-3ac6-4191-bc47-08db6e7f4811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76GdBLGL8sYRu+nCLjII5jMessNYU81Ig3CA1OeRcJ5i3EGY9TbESMdrX08tyojkYSiNrnNNX3p4q9Y+oIvmRWrw7+aDpGLOEg72f1ggL/chxbHPr24AZq6K5WFynSsKi6J9w87VtOcNfG9YqVAu7QJZvgnQEZI8Tb44uOTkFKSTznWgaS8/hCdaOZjC5B4/7/q/6o93X1sosfQE0tLkxrUYqCfCnvhioxXibcAgyDGvQWGP+WkhKFTAq46RNXQK1Tar8Kfx61dHKlq/Y4YoPL/axGDCLwZ6ImsvbIpMOjh8P8kuhXPpg3VWn2YierYyaQ4a2g+CNM1TlnLjReuLTTBqvJCn+dhii/2903HjH9hgJ7xDdeFLmEzqOGELyMhLCTr0N4bdzIoWfpVkck2ljgjLx1LbAiBY+lSObHSlOOneLVVIeLMCqdpTrQT7rDg1r/JtU7rTQ7dMam6eVhWzuzgB7Ldh6Kq5ankpBS8PJ4Fqkqlniw6q0RyRhLBemBK7Xt89hEz9wmJGtnOKN4wMBJOqq6fkiMNgJgC5DKEQiicJrjzqzvqq/PspeM7lRNSOQgqnjqMDJOb4WntELt3Ld2Z625hp6SSFgJAUPMTq2j5u9vU1RVB3HVqBYbXl24RojWsune15aRB6BmxaIJDgQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQXyp5kY0EPwFm0ME38sE93GktVDiotvl+wKZ3JefnnmYbI+NyXC/NdV8xEm?=
 =?us-ascii?Q?/R0zx/4ja3S85d5zJhNf+lnrnWIEDCjN5z9FrFnHwqY6kRedaYDrrHPfuuPk?=
 =?us-ascii?Q?626SRkuo4dmjoaYg9y7h0IVGpF8zc3vClLwkU5ysn7VT3i4ZL9d8fheMSBnW?=
 =?us-ascii?Q?kJ7zamMaYTZNmuOMborKm7rGYIysutzMV3x5DPsMhu29V3RluqOn3pSqKOBm?=
 =?us-ascii?Q?+fuO0wPfFwBWagR8+QRvVm6wpnqIIouw8TvUEuwCPtZb4ziarIW2pXraRFE5?=
 =?us-ascii?Q?H7vItdlJHDu2+HMfYB4k/D/idM2iyDx0fStA5IVfegFmX5odsBGIyGYez1ud?=
 =?us-ascii?Q?YvN08iyH7FPAPACT7YkHAiqMTu4Ym0FqwRk/Zs10208FckLm+Temh70StGGM?=
 =?us-ascii?Q?XVfi/FLYBjUnjMVqT+eYxZbLFCcHui0t5eFSuuwvZrE0F4ttyNEh9sE1zkPt?=
 =?us-ascii?Q?DJev+w2/vtQUbCP//TJKKbVRBdRv7YBq8iMBr9bfYLcYmtPT/PA6P4qxwOdz?=
 =?us-ascii?Q?MwZtobfpBCueYFHpM51GzgCPF5oN6kdyh452z5ASTrffV2Q5T2NMIBaFIRlG?=
 =?us-ascii?Q?GXfCUa8jC+uw/t2+dw8g/n8ekgF/KkUKi5Y7mbuaUDPixVp8KMwbTHLY+Gmv?=
 =?us-ascii?Q?559olxdt7EIMayw0lE9NEzbQqOvrcE6oh/DjLImdDLuuBm2tuJv/mN9KmdiC?=
 =?us-ascii?Q?JOhAAhYSDgM57LbFT8t7BFkf3IBWO2UlONL8xS6CldH6nhC1JIW+mWMlAFal?=
 =?us-ascii?Q?zZW0FUHC6E/WuSPx5/nSIcujyaNa2CNAUKLmFSiXSJjcukMHgGH0RTzOt/M+?=
 =?us-ascii?Q?h8wD+cjeOvIlzuAdqNsIE94zURYmIroAKXv19/LJdmUji7AHzJbc9Oe5OlTT?=
 =?us-ascii?Q?gcD0xCzFJa3KgxachT5iOUoRYY77RKg3Erm9Ophlh8d5urRVYyNDfZntKq4R?=
 =?us-ascii?Q?yRK+HTwgEvQJ6KKSc/ONgnIpWaParqMyBVqPd7Vo4LZQlYxl4Z3poD5EsmsT?=
 =?us-ascii?Q?rdblymWtZGMBwsNY+wHwODX6vGnL2CEQK6r8MIkTDBPTokinmpwHELYxPSKm?=
 =?us-ascii?Q?rd2NQsiTgt3Wqq6t77mJ4fBV6rZTG6vKHUkY/N8uWDupj7F8eZUZ9eCn2YjT?=
 =?us-ascii?Q?8VIDmZMJXDLnvPprqynqj75L0Op8USMbrW8r+AD9JE7NVp6rk2lWkFkX9XHL?=
 =?us-ascii?Q?CvnBJXZbcfemxEMV00LA1CWd6wnamwbBpbNmSCUWLckWGLcd3YB1i6YTIg5Z?=
 =?us-ascii?Q?JKrjSrdleHewQUehz6Q0pVq0BaIPq3XWxN1zBbA7RhZWjJNLhv3gPmAnuJq9?=
 =?us-ascii?Q?sIFQaoPkvs6T95CazZDqVzOqX5h7ikkHNyv4V/jUg+SMqVIAdkXBWWEI5smL?=
 =?us-ascii?Q?dVWPkZ1E5GtEbgPMtzEuhyrWvAPQgBuGvwIs63W+PUMNct7tPM6O959WKdoc?=
 =?us-ascii?Q?Kz2Bevc8MYEOeyCBidH7jxvNMs3od1nqgff7gGAp7cqwzurMrteL/3SxE8FM?=
 =?us-ascii?Q?M8V49wc1/5mOz4EugQ2nezrwvJgDuRMVZvOBrFInvBkR0fJNtkxWpUok9Ywr?=
 =?us-ascii?Q?96Dmis/c6SPWG7bvOtcdIMKMpwZ1K9RqhRdqc5Cu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b485f29f-3ac6-4191-bc47-08db6e7f4811
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:15.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSqsH+TTzti+j5OJ+58fUCHm6SO0ga+DO6aey5cfDl6X45IZPWJIvvvzh6K+9pmyMipdbjb9OV2DZHwqhfNKng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
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


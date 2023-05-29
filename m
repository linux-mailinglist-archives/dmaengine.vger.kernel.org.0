Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281CF715047
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjE2UGq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjE2UGo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:06:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091C194;
        Mon, 29 May 2023 13:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8/CfK1zFSmXcjvebzp8huA5uWkgFYlnSm068AgFkfuCBBcKEgdbqew4dNWI1wehuxc3er6O4FjbJhvYb451kdbu35mC2Q0MjioLLUT2DIIn55DAFMlb7DzzsnlHfPiyJViX+cmLu8+UrpSjPXi5tF2qsHfrYJE3bVpX1tfM7kDN0f4+DIET+QpUBAYecWuQIkQZboTHdtLCOkNC0x99FGDWrcC0AbjfAgKf6kdotYwLb2MHgR01ED20xEnX8RAj6pkimuN6BGCoSTLCWmv6Q7lNpfRPodUcLUGbQcPq4KPvB+FFEjOFwN5jZzVeivvUEjfJT+JnfbIT2e34/l5Cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3P8AoOS+eHwcaqc5bUfUnf+Uxj1PFHD3YCKbldbyag=;
 b=nzBxkq0QuYJpuGs4q9xF2pMahv67UiFxY2pCvDX2wmzVK8B45kCdFwP5NIn0+qCufs9mjC2Dloi+pUQOYM7KNCBH/PJgNLvqcZK/+SzHU4hlkhuSOsDNLBYaordjV06cxgRZxAXV01vRnXqHnpaP0vBGanH+naf9qIchPY85gmE0xGilAACldoUUvWK8acBZ9iibmDsoLpxguFlhiDoBhnFJebqIHMZaMgloHXcKxGhubxAmUrwALI1r+nN5e8zupSaKG6IQRLYqFKVlBA5APZs7A1VzA+N7UUXuD/3radamCumCUwLg02n1T7fiFVjipOpvr1sYqUmZNphtol7W4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3P8AoOS+eHwcaqc5bUfUnf+Uxj1PFHD3YCKbldbyag=;
 b=oYFWP/zOE46/oqwrFinGnUjKJuRC3w4ZsVA+uHfJYO75g5WW0QPZ6ZRkQF+cAStfp41fTFSFyGNjVvKvGxjb0LqNFQW2Y7ec8/i5rG5LVNO4OmPcdDoyipvkKo3H6wAFHZHPfqliKfaRqRurgMojerSS4zWYgGfYUOB5obNjFCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:33 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Mon, 29 May 2023 16:04:48 -0400
Message-Id: <20230529200453.1423796-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: ca88c6b1-5c4b-43b0-5967-08db60800f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB5PyEqHo6hbz04RIqO70xPUt4TmgAJKz9tU20i8pI/XGCzUgxbMFunplcx32+HO1AChZMTLtmtFqN/0umNly7Eqsx9DaPYSYE0lOt7aAjO9ic+VxVLs05xCunxRIIR2XWJ1UM8pJA6NDc65wkIigOgRk76cDvXF9AE6KvvaVbva1ov0+lMS94tkZuj/2xn5vlIo9HIE84CyJ2vAXXz8JYbSMWRBsyZ8ExIEhbABaomYjVBAN9xgLRL0NjsN17TZHF9DSH+PiwcBitrmr/noH2kS4Hk1n7lRFT0COu5XxpHXtbLczATcnDHRvQT+/YPsxir+gH7e4zXlBuWUMU0/RJDBlQlKsQt3vEZSKmeCDBHWZ90iIkuHsGycBObTKib52Csi/5tTQPIXDjeWzfFGg2UJIhFgApUBwIgqNrl9fyK0cblbgWjWxiF++Vo58+8JNUEXLN13YAnt6ZQXzsjpQ+Bj/HLX3FNWOn936RW4epkr9afnn/P11pVNJ2pF1Q0R7HFVktzjdGjJNLIIXbPEk72tKlL1kFwV2qrukNQEqr5LKqLQLzjaQqOKNNYz9eIx83o73QP6saJ8/X8EuP0DeyvWdDB0AvvCqtqO90fULn9nUuhL8YTOgznb3kt/ImkH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kpRt+N40Lu4eb5ug+2y6+hByG/SesFBR9vL7Ba59B3YGDxchez8H9rzSE9HN?=
 =?us-ascii?Q?P2O2TYmig3SGOE+A2FLuuCpCbun55XvQ8ucbu1JLNpurKTBqhjXlHSSFkdaf?=
 =?us-ascii?Q?mRHavprsSWbihwwr9cBpIrnwxmtTOMsvWdmfB9QiOkMmalo1kby8NuraoRtT?=
 =?us-ascii?Q?yTmxGaddAWYHYtfjY5HuET9lFxrv8wMmfI0vsjCbTu1eez/wmalxG31GMRQg?=
 =?us-ascii?Q?Cth+LbeXg3w12jP0Z5C3USmXYFjCvmCdW6bp7y2c5h7D67Ec+LWj1a28s6OR?=
 =?us-ascii?Q?MMJd1yHDQWMUdyiOvJALcB6oyNjbvDXC8RyhUmh6DfB08ZQLOfeSuBglo5Fx?=
 =?us-ascii?Q?CrusL7LiSMpekSCsR/nMv8FFApRgeHAiqBmVgar+CG5StlhumlAa7M1AIMbn?=
 =?us-ascii?Q?QNRKQQqJAf9hODtCXXMvDNMZrChvbUfrQDYEwIlRkk5PDzqgriXmli5n+QGd?=
 =?us-ascii?Q?tz1+9BxQBx46GcRn833yT/Ozg5FMdpTzLv9UwYsL0GeagwB7L957J7Ievqf/?=
 =?us-ascii?Q?75xGY7dHkr4jmRmiWqS+Yg+7wLSfeTsbQTH/5O2B7CBEvzcew08I8/UhILOa?=
 =?us-ascii?Q?gm6fezpH/juPijYBkU7bYHIXjZHOz5ONrAzJCSLw8TTOYQn3tjLAq4aoKBlM?=
 =?us-ascii?Q?y/3UaKOyYn+ugwsBbXjBCsNjL8XMrfC5oR1Tt6/wmC5d36SNX29ZDTMPnhKZ?=
 =?us-ascii?Q?jEoCGW6H0R3A3g729LcR4uvGmCKbWKlCw6eJrdbHLm57Fm88szNAXmTWyhfr?=
 =?us-ascii?Q?ca2F3gyTlYiLI6pezod4x3REpRkoQ5vp7u9R0bnPHniUvmOXyncKb5mVxVGs?=
 =?us-ascii?Q?kV1k98aE6T5jzKTLTHwFEErt86NCEHD0ZDTeIh1/FeuU+QJxeJWioICNoUcc?=
 =?us-ascii?Q?V9KXeNbqGia/d8OZ7bSb/psBIGEz1DyQHgYMPlS17k4Anq4jZ+flCRBKEcj8?=
 =?us-ascii?Q?LGHwb6cn1nvbnyQBqKXqkFyKb+aXYFF6hDTIjVsPz9uvh9/erQWo7FYa9jXg?=
 =?us-ascii?Q?PGqQyMDTXvkByr4d2fMaz2h3YQxP1yjXv3JW7yaFDOAyY/YVHvr9Z/bBWyiG?=
 =?us-ascii?Q?LwMRcNq/vWSM/B2rrrtJpqKHBTYeW8WLtR8OpSpmmwHEgnA1iSlDUPE1SgnF?=
 =?us-ascii?Q?N8ggvNM51hI9BNxezNTtYPlx+SAtGzc/M1bGr19GvRjbS7puIIqR28TsGf+v?=
 =?us-ascii?Q?oR+P9bvWdRFlW6irkdYpqRAHfq9RgU5FOr7vxKro1FpWw5/Dpjxu6LDl92Z9?=
 =?us-ascii?Q?9FPiVQ7xPZIi/JSycHoIsSOWFMKFP00uXiWArxv0o+sBcRcij0vK/5kshTTe?=
 =?us-ascii?Q?/rd5Uft+so6RkwwXB0EfAimGpf40/CSGRIpWeDbTqlBZ/SwVOSY1g6yLn3Y0?=
 =?us-ascii?Q?r1CSxmwwXDrYOTxo9ct/te3j51JArGykZysBtThWgDSAdoA8MaLM4hbrieYD?=
 =?us-ascii?Q?9LsywSoEkcvZ4sn6bMlXRkmwXYvx7lfHlPgd9FrAWsteafeKGwbGdaHQMnss?=
 =?us-ascii?Q?KxDY8KVU6y4v3pO0mW3BzKmKP7iC9QOrYWfVei88fNN2nJhDikjoVROLxmhK?=
 =?us-ascii?Q?cfnkJqBxbGgv866IBKxYLFXPXLB+Z8disPP26UR2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca88c6b1-5c4b-43b0-5967-08db60800f18
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:33.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZDsbsP7Xtuah7duJIClH4NLLaZHsW7+oQwCZBcJecw0WtxrpFVMU28n6ivLp/RGRADURxyWLZaQkrXFU8i00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9c0b6fb4cb8f..6126717fc87e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -268,17 +268,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -293,19 +287,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -366,7 +353,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -375,7 +361,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1


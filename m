Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E497734784
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFRSKl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjFRSKd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:10:33 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831C10F1;
        Sun, 18 Jun 2023 11:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIQAuaSpAXMGher5c0bTcmlmzFJNQXOmw/2Dn5bFsZzEotCSHVEM54Q0MiciGDbY9cJ9USDP89a/waidPQql+yOLsrLZFSxqsLBS8bFs63Eevmr4d00Ihq1/4geBMP75LMpkvxMs2S/gB4rHdCOPoXiQCbk5afwfjlepkxTFQ6yj7l/sYS6RmpFmlJaHh0z+hY4QvjuaVNhxRX7tB1GMtirJoXO6n0WO21swqBw84sNLKyex07CDvGYPbTSTZtq2pwIwnBrz4UiShO+/bkjX7RPd9aky12Pr9uU0LJ5sEhAWBVccDagKLXEWhh4jh5Z2PwXLGrsVuvONBq5X8d/VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=cx04JLiSUx9BeSO62+X6wlhvh821lFcvfR4f5pynbRN51gm+DvTFBV7gQPJLFo2qaEXrHJ+tq5vvUsMVvLS+zzDN0y8nq43piGRgcpXQS0paxuNLF+zGTqCcizq9zLbedG9HwWRRU1n4NOhQ4G3FGJ5b3TBGYdKOQmqP/GOIpiKbEn8UG3WkPTVTh45ojolsBrKH4Qyl8GczEQ1Nwu+QQxNkNPqPR3BK3EKX8XChf7a/MO7tBHLemA5tHADuB4iMzajr135NvLQpnpl/mf+QRNvLLQijVMFxDVRDqVUikaYSt8BtBCI+d2co8HsT5RvcS5FNWbP/P8Ftn8BIa2ehTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=oviwwMYICbcC6zS9v+HJ6/rl4UeGRJpm02K+6PL0U/sxbfznDnjn8+30JXA81LdXPV2T7CpZ2UwvTdO/+/QWqFZYCCMb+qvvM/yaCib2c3CLHVnsGJfzkT4T2UlEAQls19e4bYSJqMc4dGL36UcONGaUu1gDWoOlysPcu9fB4RM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Sun, 18 Jun 2023 14:09:20 -0400
Message-Id: <20230618180925.2350169-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e97bdc-edfe-43bf-ec56-08db70273f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUkSam+qfJfM/nVWTiNsGMVvAlmMK7ejKrYcpveomVGxNHXcr6aP1TAfThvaf4E5RaIxV32KM0Q415e9DIO7WQz3xa4M7W7MH4dKBxzgcFK1uvyslyTtYn9JCwtAK6cn7nXZKzlHGrkHcXDIMo11LDOotBsjMZy5vCg6q1PSzma/bfFaZMRl4hfQXBMKrVc8u+PvHTacglpwolHGlW3WgF1Q0f0w23R1sFhHkycuKJJg1GiT9X0jkhpnI30UhTnlEizvypqG8xJ/7tCj79PlxiDns8CrWlvWtAyabfSzhAkgdmYYy0Yg5zYdl1HmTukczeKY4U+CaweKTypU9gdQtWLThOTREzU6hgGFk5RmNA03S9Qbcy3Qp7T4hv0EmCpnJUCc7JV+4LkQts6TnF/YpsiJzejPpVWDCccis7QF2JOxxnoobj0cFH4Y3kxUNZJ66YQs9WhqHwsfPpcpNcXJKOY3idoQkc0M7bVcS54AIAhVqomsVqwfDGLy6bc3KdaFdHT1fDJ2tI5Mx/wLqMRn7AZ/o4WVp1UZnIT6IJQV1b4TgMSe/ikCX7XQuN+XGbwRHzB/YWapN71bEtx6oTlVG1X6wJZoGmc7+/n2E/pCgBeBehij9WVpl1sL2x8IVddq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMqNpMSBfiFAEySFnyWKczTvgWjziJXel1hp2di2Mqcuv19SxGddoReCw3+0?=
 =?us-ascii?Q?JlofojBXjdOTds5KSOQbHNhqSwrwCY3bnF396nMRdylp5Wb28cve3fgigASy?=
 =?us-ascii?Q?kG2H5zpR0gU/2kaS55xNNYxMZW72u+zsaa8kkN4Nho4SnxKiZ7+hZaE0lQJb?=
 =?us-ascii?Q?uMQ8t9fDFwZUcNrg9MnkLs6vESyIYufYVnC0BgWaHTiGSrEySCfuAE403Lgh?=
 =?us-ascii?Q?GIpjxkU6l/Z9geLEuI4msNkXSi7aE9uMClnyibKE1Pye1b72pUSLoOIL0JEh?=
 =?us-ascii?Q?+L1znoZ7NCRKQ+uivxCO3MPydOMC4/8//vbRX2I2UIbZ4wKzcN0meUFR7MJk?=
 =?us-ascii?Q?SnfiVBl5ctogu5Rs5anAAJGIeg/Jvm4pnr6u7Jdp7FhYKMIJN/C0MNJkujzH?=
 =?us-ascii?Q?ROd39U8fIraCpnqcpzwc5UY2FRZdhwUfxIjwBB8QoU9ENLKCTQN1JhpxF4jX?=
 =?us-ascii?Q?h59nkAuJWgglfPUHF1Bd32oDBLu6rDVdFyCUZKZeNh1YLM5+De080+4/74sd?=
 =?us-ascii?Q?46nJ0zPGmiOi4CmnkA8BcOPLE2E4+Mc1UKgc5A52PU2+B7rDZvsZxynjheJd?=
 =?us-ascii?Q?DpPJuoeFuVbqDe0MkcwFa781B/wYJ20mus3kzHOla65NQ7bO3471Sn5FamKB?=
 =?us-ascii?Q?5pk0B6G+ysUlGAmRrK3KIa3GA4zu9uNbsx6neSi+PyAfOgXXfYIblEzFxgzH?=
 =?us-ascii?Q?CoIkuUMW+GdIaLRKa08EGpu+hQvPXxrELQhINm1p7b8d80NmyJUJxRV/DPza?=
 =?us-ascii?Q?vkGi8WkDcPqrDbvo/4HgRuScBLlDgwln7DTRIplF9eky3fiDyGWBWb7Mr2aS?=
 =?us-ascii?Q?oySP+IqVJVgOIchCfFerk8cWWNupQv7oof1AYC0O+55re0Lc9Rk7YQa8Fq/v?=
 =?us-ascii?Q?KLZ8Vt4hneFWY3QIE+eKFRj4+0IJ1ZA76MnKW6sYK3AY2V0RwHYmV0fgLgnE?=
 =?us-ascii?Q?2r3ch049fkeEeqdea5ZPaWvLDJSQhSNXmvvNocmzoLy1uDdqpHDSTT+Q2X2n?=
 =?us-ascii?Q?srEIhdcxVFE2nozxOvxKrixY5Ie93lfWiqE1BcbsTzmAzG/mfV0Efgp+ZHoN?=
 =?us-ascii?Q?/0j9yN+1DPXjk4TEQr1RGWRMjBhhEYVbcwhOYomFmAf7H74A/CyMTpMlnKce?=
 =?us-ascii?Q?R5lAzifgmrJgJkV1lLdFcFYguDDzWPj5gqD9I/cr5QUO6jhCVUYn295EGx4d?=
 =?us-ascii?Q?tF2upKLxeprawwKiQT4al/KgY/2488Yd1pQEYtOP/QC6lLtwEGJe+laeHin6?=
 =?us-ascii?Q?dn2Liw5kW9oI+pYe+QNXjItnCZ3+8wNwfx9GbIXM5c7OGcHfYho6SO9o+w9h?=
 =?us-ascii?Q?c/v7Edk3EKWypT1kEsYbN35wi87V4TXrY7JsuzntC4plOojEnwngKyYWayNe?=
 =?us-ascii?Q?PPsz4J3D3OlMiSul9ekWu8pmpYOAyr8SHs4iiN36YlqE0ytK32knuu/HFeAO?=
 =?us-ascii?Q?APROzPMojwLaXbsOZwYOrRLz++M0pdFes/UIQu8XHOZqvydZtIfVDXGqQC7m?=
 =?us-ascii?Q?ma+lzS7VDkgv9cEs+a8WUfXYjdHmkGRJMq0HtYXegoC53inJn4Glnl8LcHNl?=
 =?us-ascii?Q?Q0VR8JYGg0BLtWAshWj/7OAm4i+wmeRhzTKc8h0I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e97bdc-edfe-43bf-ec56-08db70273f32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:07.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxykeijE1ouC/q+EVK3KgQJS1AodO2O3ddwvP4jbeB1SMiBtjNexlFXUuWLj6A3yCO4W1znEDOOKDjbT4hS+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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


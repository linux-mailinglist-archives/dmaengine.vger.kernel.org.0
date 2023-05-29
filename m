Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B7715037
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjE2UFY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjE2UFV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:05:21 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D7DE;
        Mon, 29 May 2023 13:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBFfWApCR3S8tKAjQco+Uz4K4szawqqu+97Z4xCEQQZDbv51fGtUqumyzcq74ZmGOULaT6kgkW+UtbDWvPNVxESa00xsXgiSjXlzybXbvG29rg7OnjMsBHmHpAqS1s5nsO8Xb7Wcb8EaxTSiU0vbFLX90cGXBt8d1kafpvfPVWudkdglfisIud3vzvo49zkQTRrqJVGsDvDhg/L6E5hjesWA4yY6Hwgk3dGXgkkOIx6CKsvCVdpSrFFFAcpPsaM1Ilep//Z6Fg55D68/XOdKNA5vRsjpKYzy0tY97zXSKe0meg++xETqR7M71YDJPVyzOHDRdR2LU3OX46tTtT5p/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toliOa1Ni5BE7L0tZ2qu+bbIW1QVGvNuK84B+H1Qylc=;
 b=jtxsVyA5gCFfiU5KAssP3j1lXuNQeIT2IBr/Ag6OZwozUzVCWpCHL4qd/Zz9Mwh/NY5GiSHvWcGREceZS40g+PYTPiXZ7IPgGBS8mCWIpN6KI+QFCUJxdRPltXNgWYoFmGbN5n73E7NL99qJknMonJE5/eCTcO3C0sNcRdHvQ/juMPPWBaE7hz19QoeCEhKh7Bkb3HuYS1vmUkMYdILp+xeecs4fSSPjEUcAEhRm2cE2w5I1jAOq79xcEqyCS8AkMBB4CztN2PfPQBtSn59+ufuR2e+6dm4ci7q2/37DLqJeNEY1jlK1b2P8RZsrqiNxB8tYGWZdxGgWLtJJ1oQazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toliOa1Ni5BE7L0tZ2qu+bbIW1QVGvNuK84B+H1Qylc=;
 b=JHaKLriQdU5yw8fm34j9tHmYHNLp3JTnlL65VnD68KgpauJsXRTXcRtNi5joTSkQPnUCzterGfnYVa//L6GRyFbeX/dXOeVcwLRskkXcsroetf4S47/vUNm6r2FhSXE3ldrdGEe1USkDxLXAya6oOwwLFTL2H7ukOie0Nckzeaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Mon, 29 May 2023 16:04:43 -0400
Message-Id: <20230529200453.1423796-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84681a75-300c-4c94-1717-08db6080060b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoAAe8RRzRwOHcLMhnWWTNrFR8okVhVJ9JMmKzebtgl3Aveo0CvjlmRWvP1k0epNQRuE7ly/NKyDPg676PUy8DucHuV8pxiMulSqE+lZeNWJ2E06qzOlRkxToIiHcsaDWWgzVhxCUNBiXJwICvd+anUgbxnvySLhw+3jRV/nHxa2YHHkkecOJX5fiGV6ECu8PjRLjzQTKE5RbtY+GBWiX6vmItpYci45VLGXnqYGENSZDmcFUqG8jQoFE5i9FcixQjHe2EyLpI/OYp+vnjGFZtHgqxsrWlxn5Gd7NdPw18es66zCI2JESs8mlbZngcD6Mt2d3eTIkQcSPo4XHGS5FoOBfAp4bvj1OVNU8x7Bkl4o3XOhZY6WPqShS3vLGtpvNEa0Dzwq2Z9SX+XWFVPl+MiegbDDq8nvdEhyHe7yy2EF0iV7NvNbfj8pdK0WWosZuTez0GDwFSoNyms9zugHyy+jMVaIuFau6YHcGnxYLCm4NJ2pB0Js+YB+aCItij2xKO0PQYNHYHBowbzdXfr+id+YgOVXRPRefDJ4YV3gAn/kzQgdFfybSH2DazeIqPwDj8suNS4O1EsYFk0IlzWZ7+4qUCmEdFu2arMchJVl90XM7M1skEIb2i7bDsC7Flc7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fF78jNTGV1UDYmiu9Wu4lLMoIKJdneVYQ52tkxGvDfAxqNbGZpIgJMLpjPxh?=
 =?us-ascii?Q?2Grcgqgb9ltB9jXlHySQcjb4RyhfGFYsi2wLSp5iO5F09wpZvx+rVG14HQgX?=
 =?us-ascii?Q?jffB4pFSe1bIgwwmayd3rh8ExvBt/FZx8eW/LV9CqrCdPUAAQHHRpSlD6JsL?=
 =?us-ascii?Q?6eYs0vjaIOlGkUTA4uI3hyPnYsNbsqip6UscNmBf3UKjyeQNfOSQdjD8hxa3?=
 =?us-ascii?Q?gkhlj22Nj03RrTXh/x1p3rNPB5JS4yaMJoFhCSqc/ic7WHp8sXpE/GM6kxFO?=
 =?us-ascii?Q?wZilj+r9bnTNnMSKLWgkkuvlvQuG/dwDxOIiLSed+wgnU83OCp+C7PN+RAOr?=
 =?us-ascii?Q?FM+TTbOFIbVCUjOiewTSya74NA+Ch7U7XEMLcuoQhVzWQUB6JY9zktA/RkRq?=
 =?us-ascii?Q?+emgkBpp+znh/SevbbmreMn9aKLfseK/ESE2NyNm6kKfs8rY0NbJh2RlfMzk?=
 =?us-ascii?Q?nzcx6ByPHQdGms7CxNXMNtx5niwDobi23XuD2az/SWzy7vn2wW8QDA9tDwdP?=
 =?us-ascii?Q?BE22fBed9lyOR6T4EbgK+LnnQv2t0frM2H7bZZeUa1t1Im6I207lP1/Oze1K?=
 =?us-ascii?Q?RgPkcNYGJs+XyUsnrxZ8590tSa7KGUxo0CjprcIWe0H5lfbJogkjG1ZZUgVw?=
 =?us-ascii?Q?xMFLupNaqcQhxlTX5btO9MSYtZR9Jomxc0xtMYRjkou7IZ46C80ePi+bq9Ys?=
 =?us-ascii?Q?A7Mv2k1x+YRzHe4QsLsab9gfp6WZsayfFbrQy6s2Y4xOmbzgtgRpYG0JcT1V?=
 =?us-ascii?Q?IsHdfJZ0LtDhtB9as4Rbb2/8wxi9mLq5aKL/jKgDwN/K+yE1meoD+yih/bn5?=
 =?us-ascii?Q?SGhzfWgN30bn7tZwUN/vqmnpq0d+oOtArKPcQN7Ow6USpErsOojopxDoNeHR?=
 =?us-ascii?Q?4xAKEJNXYvbaMLde0MdnRJrGQaqUmCqWmVGKiX1a56oKVN7MRTTr/O7yWKeH?=
 =?us-ascii?Q?fZIX10g+srQ4woDKlTfFwB88Wt4bE3fy3449eBZpTzx8EkTuGnWicXmrzJsG?=
 =?us-ascii?Q?k0qiRWH0KYjVc6G1xkaRXADcwP24nay50v1/CjAzI8LeOHZpUWZfE5r5Q9La?=
 =?us-ascii?Q?BjUKXJcjTxpEPh0rDMHkVRtBCAgudrHdsSalKZgkdLo19zYKPLCcH6U5jvMb?=
 =?us-ascii?Q?Oi3uNVYlsKDsy6FDa+muqseFwftjlHd9Rej0e2cBr9Ahfibi16SjUYAkRtA5?=
 =?us-ascii?Q?l4Fp53mtNBr81hZgP/ajma5GobwAL4D77KyiqH0+HVZbownz5nknQjPZj0HA?=
 =?us-ascii?Q?sn6VX6/zRHzz5kMlp5mT0dmk1ZrosBFRUC/OpOlACU/kWST8TZZYrj/UgiAK?=
 =?us-ascii?Q?lRvIGlDe8ZrDyXer+EW5pJRmfE9Hq9FTqz1aR1GONjbwhDfvJlbp0tHyB8Qz?=
 =?us-ascii?Q?k3n7LdYIv+q0m0I2WlzrAuGqJbt25e36ikzvNecDEXft1Y1YpiY+tosyr1bg?=
 =?us-ascii?Q?YENaYkoTjboZ36fTIbI0Sop6SGLntwI2rsYjD2bG5p9DZpkdFCMdAj5rsBLK?=
 =?us-ascii?Q?eOXkXrjkv3AMQZKxGGlVCZoG5GOEq6cdEOFsmjjypgMxebeDW6EDzYzE1TlJ?=
 =?us-ascii?Q?7nQzu82qBrF4NmCv+GJBPGuu8BFeBc+K8GJdeOct?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84681a75-300c-4c94-1717-08db6080060b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:17.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYdx8h+H9b6K6eDMeKuODwl8VSZb6/5SKLvoaYNyL7Gge6MZEa+cCB+CZE/hmt1+CZeoTzP5TyhZe759npjWfQ==
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

In the probe function, devm_request_irq is now being used to automatically
manage IRQ. It eliminates the need for manual IRQ freeing during removal.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e40769666e39..16305bb9a2ef 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -216,17 +216,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void fsl_edma_irq_exit(
-		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
-{
-	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
-	}
-}
-
 static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 {
 	int i;
@@ -427,7 +416,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
-	fsl_edma_irq_exit(pdev, fsl_edma);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-- 
2.34.1


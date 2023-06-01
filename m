Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FB71A0A1
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFAOmn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjFAOml (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:42:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD7E41;
        Thu,  1 Jun 2023 07:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUTUR3qgxQtrn00snvHJECx7Dy5MlnLnPC4WZPk4dF3ycGyhmSkXh11Xkp3avwKZECt+hsa5r9nZAGlqOWWqSYLa7R6tZ/lUZ9NKPeDGZVXfCSFuOGhoccoVFE5rIKdF4ygaQZWT9cc+vcWidPVQ12kkFjPYQmS9r1TFk8JGb0HwVc/9UQZroep2EGlwTxBC0Mvog4CJHKxlJjh8nsWRU/4Ipur/iXi/ncveM61fspebfd+JwIB5eCMD/HVG9eKQrRu2ju9ydc7dZ9cSvodurJKhNMlnqZPqdH9UESC8F4LiZF1vGmX7OjrhKjhbV0Hd/dXm0jtRIdNMjHk83ueHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3pVZDzGCH6yRgcJJkbuIt9c+z+Kd/ZTbsElZ6w0CA8=;
 b=iSJwrw2iTklk8YNFrF7ii36keODPSODGBt4HQs8JkFV9RpdOMdsE8QzdmhkYYT2s4UuZoQwlmlQCAJoQD1lsqHc+j+UrjfU4ejxAsRkeT+zXNKKjPlGB7AX7KkAwqiBNOZ2rVOv3mbvqH45CZs0vHn/eQo4AAdgXeiGoyPYJtdaLVq01aCrtutlbwTIo8u+YMvfqy8JSki7uZO8fCHhNYIVVMizsyuvU8utrELTl0dc+UCTOiXy2z5kZ8MMjwRapYew9cdC9oIpyHsJlqUsYMr+jSTes7LMBDv/d6o9qLDhqmV1kjbm0u5uumAopED1i8LQXES8qcVbLNjNMGvP+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3pVZDzGCH6yRgcJJkbuIt9c+z+Kd/ZTbsElZ6w0CA8=;
 b=ZnjEnUGmqDma4/ublPP8M8JEWi/PUYnWyZJj4gvTEHO3njsqm4yW7+nh4qEGDKwtRt+V6uCW8bDFHrBPP5eTENC8NM2zUO+pYF6w7poSeIMepaPpLsygWJ51I35h2vU71Irt1dGMRWcjYzK5nLropUBQdg1mkQshEyKNqy18Q2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Thu,  1 Jun 2023 10:41:03 -0400
Message-Id: <20230601144107.1636833-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cedc8c-5689-417a-fcdb-08db62ae54e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fq7PuFMrqVgiJnQRWAGHZtrLpk/OiAmnu9XDSftzzzzUMZUsuu+4KAqlrw9fvprpyY1kNMWIfhpUa9dGFrcmbf8+ymKRRQ/lGsaxvejR7QkcRWEkom/DqQLk5DDbON7JEPKf1gKAguJ/Z6wN53k/2V87rIuDzbGJxbUxjo1U0exJFzf9Usuz+NZB/uKPftN+8HhOLYHwSh2CaxCySpRpKXd5mpDCl5ntLq0oYN2NV2nms9LnRX1iJttbMbg9+wx1hI55X2mammM+Vrokv1f5zComcmYNQHGxtZpS1IfftASANJXNHdRyT7OdTjUIyzlklwXRTi/y0DMgwGuzQ/aOcCLKluMyVf7KZladh2Gem11uIkcIdE0vAV1NahgHahBujgmumCraUT5OT9rbC6n4zw00YxNPAxP0AEOy4nhVbmnhU7oYw+3p4KXUkqZ7PNru9PQG3lrhgCJTL5Qjb6B8u7JOPXJDal63R1p1KYfbFxVLRnLsWxwhrGQPTXB/5ya7RpbOF4UE3nXm2Knnnojmft//l3DXkYpOgE5/MDauxDs9iqLsOx3C/JlNtpqEPMpuhmbTP2Y4NZo/DbXGwyw0H9x3dv6vqlOFkOSPwj7LRtqvvB+Soc4sNczKnbhpUSZsryLcS2zkqy/Mymv0vfmyCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DygTG4HzEGAR+lcIWbFrlQ0SOa/vt5n/64B15hCIEcKNyQSv533SLMbNx5V?=
 =?us-ascii?Q?qCyvZig2gbr8QVkjCPhDISH5hkaFnP2LUBSmveUnlOPwmjLa2p8ZLUrkDf6K?=
 =?us-ascii?Q?rsstjO94PFKD3ID0eo8HtRagaLajdOhoNoBZEaesaiutSTsTcYNJG2PTFZZs?=
 =?us-ascii?Q?vw5WseAO/EJ7QWuda3kMdgdo1wBhTZiZ3kaqTgv4IBjUGpWqVm3ka6WUaRl9?=
 =?us-ascii?Q?QXFAUbOJToCfjDITAWXLZOzU0MN50rw6kRisuA6YF2dq4SmxQxTHmkB/Lzbp?=
 =?us-ascii?Q?VBq1YaQN0GloyfcJajqVeO2VIP+txGrDc9YCRlsxbuGyT8jOB4iRtZ09Mt4w?=
 =?us-ascii?Q?GiakgZFUHoceXTdaFp8QF0Qjv8Xlx0pU2sFdQsMjaAt08XC52r5ZattHHRtK?=
 =?us-ascii?Q?oaR4Uupw3OnIZotmJRKzWMajr0a6bQIFxYJctKDihunMQRb59AB/geBWUIs3?=
 =?us-ascii?Q?v50Hs+0mAwlTFFWud+S24O4H7msFEmiPatrjQvAN8F1mBrNBYZGuvBfNPdq9?=
 =?us-ascii?Q?RdxDaDTQaEuxC9A5vQodrzkZzU5KY2ficxt6KZ/3E8HWygB8T6QrRNqtKunq?=
 =?us-ascii?Q?RCaBqpdzdOAVLVnmX08FReHYtpZdVCo35EBF9FOjUyodyrGauGx3F0dfd9q7?=
 =?us-ascii?Q?dG8M8MvAV3BZbQk7WTOKRbatYiZ0PaKET+O55RdYRh3IWo9xpGrjbfiAffik?=
 =?us-ascii?Q?JlML77bjX6nN8KCmLYLVryT/cQ6yHaTtGwBzX+T4+KzSfMo+hG57Wnxv46Ap?=
 =?us-ascii?Q?oLU84vPDLYAwUnOft5RmpLRBqys7kCk/ow+OMHWGP9gNivJaIJezhbdNZjdi?=
 =?us-ascii?Q?UHJAZ1EGTrgiFqCNamhQ1KAbdtvPVcLeY0kMjfAaBjIH+nrAOY3Oln64OuHf?=
 =?us-ascii?Q?mzIQVIeTUZM/v3z1+zvYMPA3PRDqJUIO+NVQOsgk350F3PAsIliYsTaXh7pZ?=
 =?us-ascii?Q?EPWGIrR9tYQU10c5B5NRe87gIkkf7z3NTgGsenvxdWC/xGlTca9Xm9yXCEQG?=
 =?us-ascii?Q?j9jkGK1IE+QDnFPJci3gYxr2kove1lnJjuQFSvnsfnVCMjvVsZuodeaD2ZcI?=
 =?us-ascii?Q?v+7LUCIKOCGceqaLCFSUrFjCz6xpCHRpv1sB7PHXA3/WA7CEMqyriD2xMf5T?=
 =?us-ascii?Q?De9HLB5bah/dg2XQ92y47Ho9cKGTNPuIhhrJkvgGIn9BM5ucd5PSb5Yr5LOG?=
 =?us-ascii?Q?wnRiVQSMBwgjMzyEOfXQ7yjNDWUtTBrsRasbysTHqbYftIUMnntcxI8aIf5y?=
 =?us-ascii?Q?N+Ym0gR/P1aeqMd8GUrZLzCabTj0nSbWylg6LBYBVUOFvujl3gHkw2StS/ol?=
 =?us-ascii?Q?X4Z+v/ynwtsCERkU8kUHOGEPc00IolsQBzO5wuhShO2an1PjaTVTLs/Q01qM?=
 =?us-ascii?Q?4lFu7zfUWp9xQQYJf0kH1gWWsNnIp71c2gefEHBgSWBZICvIcRIsSuPWT9pV?=
 =?us-ascii?Q?CaK4hUpNrPpBFnmjHHINSF11HoZcPzGMggx5w2NvFYcZf1sxoNMVvqIDZDd+?=
 =?us-ascii?Q?EspBxtnUqTpu0uxOy2k2wJ82GGxKohEpXuurGAnGlXdUKXtsIxtX8Eslv+DU?=
 =?us-ascii?Q?CUk7iO1R1zNQSPM/XSvuKcOxdOg6kfLpl23ZwbIh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cedc8c-5689-417a-fcdb-08db62ae54e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:49.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R0/qELwoyF/y8Yejv74G6klGF+HYe1vyBVitHI9V400DiopHOGvwzEl4lRRfe6JCfhMkn+xhPcurTSttohVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This accommodates differences in the register layout of EDMA v3 by moving
the clearing of register interrupts into the platform-specific set_irq
function. This should ensure better compatibility with EDMA v3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 70e1a0605025..f7f3373989f8 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -113,6 +113,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 {
 	int ret;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
@@ -154,6 +156,8 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	int i, ret, irq;
 	int count;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	count = platform_irq_count(pdev);
 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
 	if (count <= 2) {
@@ -310,7 +314,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1


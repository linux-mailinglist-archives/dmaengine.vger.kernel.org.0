Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9B74B6C6
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGGTCJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGGTCG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:02:06 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F32696;
        Fri,  7 Jul 2023 12:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8kRQPBcG/PQ6zMVNfhGFOEXZSj8LoMAzIiSM4j4TfQ7LORavvgBDu1PCxICIoqcW4Il3Y6Tl/gZJao/HhY6VENAb8tAMHTtmTfv80IfZ3N+j0RfKaw0F2TlXtJiydp575ZxgwFWv7IMAst4N8t7l5dpk0+WSq8H0FHIjjbd2KFz2L+6IS3tCrmwK5KxHYJmhnw88+jYnmmoL3T/VI2pWZp0CGKGk6/D4m7SlKwuXZE/Mdcy/2W594EsuwjQ5TV7kP2pajmc5o/UscVAmfcnsI1UXkNU6YMVwDKPK19gzGIdAVdpIbkpDWVSbUXJ6j48qh26X/JONDx1UmrJjWZCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYBoFoTV/QstaSfXbdLrZSLgnkkozEypR7b08wPTWj4=;
 b=A0ZfZ8z2nMLEexOxe4M3ktuLsmIpytYSknoDEZQoSetcbeGBgZELs5bdnYCnnIk15kgrFbeRS+PhbYfuYwsfYWSebF5n+2qjhhqvGXNKEk6LmPMkaqhcp3yS7SgpBAYtLVt5AZMAedd3mZlZY7EH1/uHwljWqsRfLhiIdFobvZFnGiRfgbYhtJeHPmS/weRncZ4Fj4lQ7bBy03/a1EzFrqItjOuUTiKCUuR+g21128/IAnTHJ6s9r8X8tQRT+SvPIHbN0yLzUa4OuObQxTHgpQBfS9rymSRWl3lMgcRrxfSmsWoqziHWWjR9xuvMI1NZziCugXQuWBCTryK4GfTFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYBoFoTV/QstaSfXbdLrZSLgnkkozEypR7b08wPTWj4=;
 b=kyI8noSBQZx/6q7GKXFslqwLrMxFh6tEHq+IuOpqv4/pi1acU2JgLZL+2yTmT6PMUd7ovf9dpNmFdIoCaBbPVTkuDL3wRbkyy4z34sQxc8sycIEpl0l1YOlGEsykawqBNVLQBNAHMoG0QGRzqp9r/zsbSbioFOuMVzl9c0IwJRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Fri,  7 Jul 2023 15:00:25 -0400
Message-Id: <20230707190029.476005-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2042b6b-dce9-4fff-254d-08db7f1c8763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcq7wVuhd8n7f8pXJFOckW5s5kOvdmpVsz9HAbmiwoYVcU9uF9RXp8KRG97dDDzJ5iluNhFDu4nvC2YCCJXzjFYGxa1ob44swGNF+Lua1gquLkBSh5Zs4jeX/3a0Y58CJ37BoWxdZfooxn7rE8sb26kkLl0bZmQ3mOzwLhUNl0T6JEdS4jMV9nVo8AnvsY1YET0iOPYKQdoK/kbeXHJd1HDFpyyci8M7o49BRc2jdXVh7eOMbcEhH9GfAroPYB5+2zy6bnNUh50pUqFQYKSwGyE6+hg75pLTuWrupuk29OMErdwTa3HmVAXlvHeh9fW3qXhk3Okl8BH0RSqJWFMZtLL+wmHbb/7U+YvapE3XyIotX2wxIeNvLUIO/wZ0eK55OtYKB9kpr9xE5eT2N5gOTFlBRLdhhjvIlNWzPFQ5JmPKfsvMm94GM/cmI1uXqsU+fJVdphK8qRqRPMcEP51T1i+2ghUviaXOkyp4zfLJRXtEkvo1NkjLGq2pdOWVQU+cqpiXUY/qse/WFrAfZFheokrXjYibxVviG4+RDWBv2kSFoXBGJaCgXP+jpFQzKzl7oZbHFAft1tzTc5ubSD+WtZ1e+g+PMDrtOUExPcXoh1Vn9C7SDPNdMjVLPiHDPYVC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(6666004)(26005)(1076003)(478600001)(52116002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBmle4fdfKhLoHj3o4a29v4t/B12mIT+0e0jyoXc++YA17ZDU50SnIzR0ZPn?=
 =?us-ascii?Q?xaSTb4Lk2Usd7FL6d/oHKIWnD6K4okQAbRJ03YECnKXoi3UxZGdaFNyLPlTt?=
 =?us-ascii?Q?fjf9zhtqzwM7PhqLDuNXd7w1DHOY11ZPOuNf2pgC2VNuLHjO95NhUAu3vB0o?=
 =?us-ascii?Q?ysx+2HSg1Ruod6sbLs157ebTrol7oA8Ne+QFCG7knTcuL87sMDA+XnazXR7Y?=
 =?us-ascii?Q?Ujm0BHHiItgVUGmcEfZmHoCTtFwf0Gb/eU+GBzgaXx6AUKUzYKd41eqN3757?=
 =?us-ascii?Q?F+zdvZfvQjcCkXWYdjPJLUA7eVqfVwpk3W4B5LRl1e8HrDYQVNczIOwdckqV?=
 =?us-ascii?Q?9dQlrJzgSA4zhBpDRb31D6hWRad9Ary2WO0h+m0oTYlHDc3mFm168joNrUKO?=
 =?us-ascii?Q?GiaxRKlcU6R2BvSVkB3qHA9gbMHk2k9HfJT8g2Pokhi6aPt7oGhY3VZnMEDz?=
 =?us-ascii?Q?LpJTL5R3IIWI49PfJAkI1HqYXQ5BlhPWCl3q2GfDFnlkS5sG5sPIO9dA0C6j?=
 =?us-ascii?Q?Qkd4vG5wScdUU7JLE0CjzGCUgOpv5YkEAfy0/vmMTI+6zhcrCUBYKd1hhD6H?=
 =?us-ascii?Q?e275ZCHJSL5UnOGtXMVDfd3+b0Ad17ErgcwYuCviYzxYF4AIGCFFkFn9C0jI?=
 =?us-ascii?Q?VtAYDGpRt5uz+J412SjwTJD5ILWb3YO7bNAeS8i/sYcFFe1PkxyKWNQ9MTic?=
 =?us-ascii?Q?Qjcd7E13BD3kMO+sD+jF6qR6qaYOmGLHSdfBWkERNTvHXYhjg3b/yArfkxfJ?=
 =?us-ascii?Q?yx7Dqe9F89dSATSXIhU8qByAmGB/zZ9rNz6d+Cti0fJhDcFlPC4ZqO07Q6fV?=
 =?us-ascii?Q?falunRD6eAW7qUKSEFV08I784LIjhM2+LWWC462h8WSTtly3jE+tSTSCBIdj?=
 =?us-ascii?Q?gzl7coj/KinmuBYwk68EtNyhbGnaB3V+dQgYmO4n4HrRXJHu1mKc6B7LY/xU?=
 =?us-ascii?Q?FirY0TnPF1ur0E792xDWoSyHroMRxtbh0L0zmFEwiPlUN4BJobvBS/+0/i7W?=
 =?us-ascii?Q?OB7jH4yWGOV8rfQY63Aa+fEE8iKKcOebyc7ftXBtKuKY8v13hze0LAIls223?=
 =?us-ascii?Q?CN33owKWH4i2UpY7cmDSCFhnKRoUlWEPrwZ14EPS/eO3TY2Qr+gdsKVwNkfy?=
 =?us-ascii?Q?OcCMCNBjonMVUh02QGBhTvO/SPVHXmjO9j7+y8Jyu/ehm54jaS+g/P7y5Os9?=
 =?us-ascii?Q?PKk6adiFZyyYeFPPDARmgIVGUzxRIFZo/7eii4YYuHfw4Np64W20WMTRk5JY?=
 =?us-ascii?Q?60NvO/QLPvqCLWuG9rR122GGfPFe5N3zqw3atADx+2ySJJRRL0sekQ4RQ0Wd?=
 =?us-ascii?Q?L6EqdP77GT9Vb7VDfkOB/Vm79be66P3mllj6Y3zCob6SpjwXK1PJcgZyn7VL?=
 =?us-ascii?Q?NSJRw5dkT21vE7EIGosctoggtgFFBUtFft8R3XDEf571ApFVV3mb8GagX5E3?=
 =?us-ascii?Q?j/opa9+SZrS+EgqGVKKdF/PqENdVWXzls0P2bXmCA+fK4lxjrLS2mwZJ0flO?=
 =?us-ascii?Q?HowuLiM4zuP/pYcxFbAsEhXQlcIH/cjZajkc8CcjS5fIqd3No+lxo8JyZ9CU?=
 =?us-ascii?Q?1XgZ4pJPLgKWAsxYT7w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2042b6b-dce9-4fff-254d-08db7f1c8763
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:11.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT5uiU+ABWTME1GXdv3tLWNNH4VxuDiLMWMmmhCTgHAKSSqHUct8VxgeqQ53gOWzEKOOgoodnJ/PD/fepOYryQ==
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

This accommodates differences in the register layout of EDMA v3 by moving
the clearing of register interrupts into the platform-specific set_irq
function. This should ensure better compatibility with EDMA v3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e70cd39bf45e..04c07e9f45ca 100644
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
@@ -322,7 +326,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1


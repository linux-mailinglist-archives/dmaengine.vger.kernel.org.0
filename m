Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2097128BE
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbjEZOkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244136AbjEZOkK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:40:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBDF187;
        Fri, 26 May 2023 07:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N10jIwtL1Qswq/mwLDmJFVPwayWvOzWWP3v6M4WpWNSEtL3qpBTZAVX8cfoCsqf0gXDNGBzVZEXtC5F8jnCSBOZdkI732iXOUW4uZWWRAQF6B002z1DU45vm7mYvmpiAhwSa+ZMdnAdQ/WWRa3YMGVUuujlQAc29F/YurFMJEpy8DqMh0kD4csJ0O8Jql+rSjRy9Iq9P8EE23zY+qGuzy1HXlQl+Vyvrm41uQKSTjOwYSAlazO7St9lharCJ8x4llRBd1iquurEm3S9ysJwxDI0ZNn2j0jX5rTKEKsZhvbJCYj5gYiEO2E6zzu7/ibSLue9oCWuXRPqAnFc9EW7ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toliOa1Ni5BE7L0tZ2qu+bbIW1QVGvNuK84B+H1Qylc=;
 b=bH34B/WwgI9HEOVCHxMVhMXDuEJuqOprsOgAwOx8adStob8gm73bfDU0vVgNoiXulU07l3lckq9VZrxo/bjIDEcWdl60vKRwLe6W0Zc/gVDv3kDRw8h2rfjzXemqvdIfU8a6JwcLO0YU95W3s8edGVJvzdRxNcKTMqLezVcEPKfUkVLDlKqk+ZtjaRQxOOrSAirhfTZTfqxJ7D+1DU7NQNT8juht12K3CX5eMsMBjOThuDWSSDDtYgo1ODFe1y/qBOFf3dMihhKk+4FEXDksFfV0wR+SaMOvBGB+9/cCzMBLu4DZ70JPAFDuvlvche7mIdSt2AYwD7EV0E+8RXHNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toliOa1Ni5BE7L0tZ2qu+bbIW1QVGvNuK84B+H1Qylc=;
 b=UaV46w0IjRhPXoZjys3yce2KkdEzMhq/mTGl+tgaw+T/I3sE4St8xMRn9wWOVL+J7ISsruYgtWEUbC/wDAbZmX+aFc0NneMPeW96riomYsbuAftbFLhXKUMh6l8+6nRf8FK/PCEpbgFLtqiqb6t1Jjjmci2KKOhSEvFpWm8wB9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Fri, 26 May 2023 10:36:29 -0400
Message-Id: <20230526143639.1037099-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: c535e1fc-0aa5-4262-569d-08db5df6abd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLRedlWNoTwGyvOHauE3CmYTNc7O532HO9BtM+c6XMJ8jHkHTs63j6VQ+oFidGD2mGvOkBAYKSDY9AER0LQBmp5yIp0WTBn8UykFVAhs9Q9js/huoP7YBl63hZoM5th5yuTdf5Rv/fBerysqi8zRyBmGfYv0vymLvjYu410/TnFpbCkOCu29HG9xWldpVy17U59b5JFwQwbqHgJ4Li9dytgmk1ECbGss1huZCV1WsJiXW6c/fKKmh5foPVc39gih1XY1srX2EgxNqKllpzagx9MZCe9PATArHht8PFmVPFG3yOSNqXYXMcX6SsJ0qjty/yAgd8raxoWCG5Kaegbq7jm/qW6FnD9TGZ71Ns9mJEuvK9HQ28VSkNdslysY1dnTo+CdTHGnGI6tY+PgZ5gBffUHy/q5eQqPp+epbKH8KVOp1o70m+TxHPMnw3kazyVTzCw86tjHubF4uj5y1+hQPVlB/RHF06sTdV9EUVlQo6945FdBUhIo/0/UiqKuhmi83K2LkvtJDF2DUefT0c4nmItZZDEWK01rJJTrtWEj6mWUnjzoNYjtpQz1YVBkhQz5UHxm5c5sl/rfbSsTQRPK2kuo4tRD2hLuBb9lvZE715euG2yVyaRLkmMIEVGCL8kTg5KXQun5MvVe9tbBks/0pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGoYCh3XJGNiguXeQAhuJVL3sUVW7cqGItoAK7DvvW3/WdcIZqnL1NSbmVuD?=
 =?us-ascii?Q?oGQDvXVISi6QOwQesfI326+bOcJUjqw67rQwGzZpy/kvRf66exNlPyYEdW7+?=
 =?us-ascii?Q?hmn3n3F4q2jn7KWpVZF6VUDvcjMbIi2wmen0nle9fgrUaOo377s7RGgxaa2h?=
 =?us-ascii?Q?bMXNbAufduYYO40vahl+/O0Z/o1xLJLPb8LVSs9lbkGJSpz+mSAx8M2lPI5/?=
 =?us-ascii?Q?O2nZ7S3sNOKc1p9mM9H2T0t2bvqqfllLpXaJUAPrJxZgI5leLyZiqGXZyA3S?=
 =?us-ascii?Q?GuvaxdrWrwFBPHpEj6e91epqUznUFpuPF2RHjMBDDxmQKkuf1C2pQSf/N34S?=
 =?us-ascii?Q?+nbH+qpWTxHulftq1MfraT41bzPkRHhDO48BFpTZLLLwDjePsbFcx8VNZbys?=
 =?us-ascii?Q?jgzPNOFg+EmnrPytEQrfsNF1d1yJe/1dY8g5WpLDmAs9nd0ZSEYStsEGy+rQ?=
 =?us-ascii?Q?Egt8tJ7NDJ1WHuOJMkYfPsYkIemwpJ50ld55SBO+qIU6y+xwXWWzHrjobvRr?=
 =?us-ascii?Q?zW/GShiL21/14eMxpdxDyjK0k8R+x6r2t27zFvhPvDDBOF8Potp+bIE0A+Kg?=
 =?us-ascii?Q?B3a89E5twvP5sGJ46N0RykepQ6Fhe1idXaXoxTjQHdg8dSCfVOU0c7WjHjUg?=
 =?us-ascii?Q?DtNcmlLGC18Pc+H91POEjHWxaoGcH1ln3QpKKbG/yfM3q9zAfANGle+03w6a?=
 =?us-ascii?Q?zLvmpZGu8+y42i9HjjZ6+T1JwOc7Ln6UiDhpC6dMFg6AWKLMjsu+aHUxZg0/?=
 =?us-ascii?Q?9Zq619hrZSRk96/nkK2eiagBfiMAfriZ+12Tl0LjeMsMNZRENEIbCrLXAFnv?=
 =?us-ascii?Q?cGjlMGgFTA+3w+lAw3YpV+kvHtA3d0SuBHqRejeCg3ruM1mdlF8yeHjK0eUr?=
 =?us-ascii?Q?tHGikixjKGiinbQgUxYBfQmREuPFK7gANKb84m3sB9kH3xG2s7IczC6CgpcS?=
 =?us-ascii?Q?PGcOPyvd19BUnvYJiiqbkkh9+LnWrtFHiOxQ/2ncBMmxfKBFJUlTskRZI2Dw?=
 =?us-ascii?Q?laeDcfUBIO3RvnG2VRqbyQwjYKFjpjEQYmZDlKUeTLXp4+rX7Czvu5OJwLBv?=
 =?us-ascii?Q?IyzAFkC2KxczNqCl1XQtA5EvLwI1a1LOEuRhzEqaoCdPlvuHDGTcw5l1mAP0?=
 =?us-ascii?Q?JFFvBRfjdyWYw11wxemLNq738BzHDyCtUu4PWV0YeOLFyW8pSY9qrPVDkw9A?=
 =?us-ascii?Q?nFIz1BXoPPP00EnWTq3n7TQy3Ac+RPjEg02OqqqLOgpHDdXh8cSwu8UGTSS9?=
 =?us-ascii?Q?dFtFcoZz3Oie3mu7eHzfLNn+/uKF6u/OFP30wqnhyw4SJY0u0IAcn6h8K+NP?=
 =?us-ascii?Q?ZOeDtUvyBaO7qvAIbqE4/tC+fkUYFxdmuwhiJtR+GUoFsMkMLj821Kr8TLdq?=
 =?us-ascii?Q?2bTs1+ozBoSozlbd7YEkwx5iQSnJjyOs0XWA0anjlduKiaAtOpm9hIjfIT8j?=
 =?us-ascii?Q?PSRchYrU9DUU8MTn0CcyKvVHlzrHHIXEUe1zEGb2qTy1rAHNHWcx9pcrB8no?=
 =?us-ascii?Q?Mb30R2zraZp20dQ3zt3G2Fvd/liSYwhAZg5eMVU50m3N4Ib8eT8OUB4z13A1?=
 =?us-ascii?Q?fv6Nxn8MJfxJsU+Gr4VhCpZEEoADdesiTp6L2kBW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535e1fc-0aa5-4262-569d-08db5df6abd1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:03.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHVUONVx9mmKam9XDkleUdLYsBSJx7GFjrA75xyeqBDVIAm0mME1IplwK0usvQL58aSbFcg4lufgG6ohFlsj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


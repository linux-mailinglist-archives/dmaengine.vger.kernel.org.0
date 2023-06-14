Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33D730856
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjFNTgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjFNTgI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB471FDD;
        Wed, 14 Jun 2023 12:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/k9A3VneUxLnVlQd2NNW00VPSDFJvGerTFLJeDonovqq4PXu7p/aTR2VtkI9+R3WDvWPLtJtenTooUcAKjv/7oMMq5VGihiqxUmkd7073f4kh+N2qloapAdoDM/OdZSXWL/266GJp/f+AyQ3L2AVmpfw7Bd5nS8ibd9iDtsZ1cu8S/XK/UbweaZV2/mUaXvYgPUrPCh6SlHll2zaXkHwv2xFClNqujy7xoLZr0UhqLWcUy+qPfS++H4ON1ecO1RXfuqCosqnCuMuAsKSkRC/Iyoambh6iw0RYbZryS+/nYaQwCkm+1g7jo/q8fYyMgjEqjmdlCQhNfbS2MDbQ1PPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=OURMC1ab/ILI54n2s06PARv4AZyTJkLsboEavK/upLHCIhPTGS3D/WnPS0SQBBKpN9bVnrXCCQ9ld3IysfEowqNMvCn08GDisM5Phq1bMTda7smxs/9RZtpw9l7+Sqng0H5jo86xKzZy5E4WT7tL1jHp2YReLdrMC/ncyajkwv76LExCTIosX9RG1bA1A0ew2YVlJ5duv+VD2ybV6Y7DKxdHuW3jC9Itm6VhouXvlBzcAwQYPNHH8fk2Ap5vK2zGsD7J3y5iB7TmxiJmLri9XOm2fJ23MuEaKU3+/M8yus0u9YDWE9doNiI1nErCRHTgSRiuF3Ta3iQPCDBkX+2Qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=edFs8weYWu8mbJISeo2G5stw5/6vK45NY/kASEDJ2GkLA+uesNPZVhk6yaqDK64KLmU/Km896aZH+eI/RtFur/Psn/ZZ9LppLlkm74/I1bprxALgcUbMeyIJP7QKzlzpMb89RAxCgch0KQa4zRpelLfYBw6kH58w7KeQC8RvTXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Wed, 14 Jun 2023 15:35:34 -0400
Message-Id: <20230614193544.2114603-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a87f7b1-6937-4168-9cfe-08db6d0e984f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU58cMv1mt/BdVSnBFk2QdRnXMBPF0JAGBsXIHVTjLTy2L/aimj150Bp8L2bXnzZMqttwyHF0h7MNYuAzMmqyrnFSUGu0QdqUojlwkn6tjBfO7UKG3GqQwz1wP58uXa6a8OEngRHhEbNrvmm3kwuU6UPfZH4EJ2POkGZTDjJpe4ZsMy8tHfNHao4UUHOJtB3wby5rilS040C78iQEBbF4XK4Fxyk79KTr1C1oKbfnyMJT/SUrSt1M3/VxqkzZvhzWfw4I4JeKcTsQdnQhQ9fb2k+23T2HqOGUf8ZVMTLFnBa/JuuqIjJfN23ZvDT8t/fnGhUc/PL0VDambMcFmjOOyfoz5xIPc/iMs0Y26qXxGfr1n2GGhvtDd8xOy5Lw7AC1L9e/xbu7bYQ0tg6g9tPuzO2vZfAfwQWfFB44zIqnxck/cTlMBLZFDM+A0tYXq13Ahm2EmOXOqzPyVUUsLQMLnAhXSJHgXd9TJJwLc+fLNFLeHB8R3BW6sRnHbRcnLv6QyTcPdDyI5eRJxjJZ9ht+EfU4+maNO7AfDI8TKx/eIS15d3vxlZsChkcXEt2kWGEafi+HUEBjkob7l/fditz00Slu4KDxT8JfqjTYKAwLOZgGPA/VQ9Wo9Cn5MPmRqF3T0DBopxYQRl4LB2Qwrj8jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ggXCqkXWrTkp313HD/sOFJPIt1Mrwb8+ZCmw345fetzXo8/gwWepyqVYa9YR?=
 =?us-ascii?Q?eDcgq8FVubkk2dLgaI6nudYefP8W23UAQnF2u4hyHKw768UltvtYpDQl8H/g?=
 =?us-ascii?Q?HmmtoRT6jYJfgC1yy6fYtc//gSRj6aKpAOyiL0ubcNZW5ySSH9X8ff1ZMU9G?=
 =?us-ascii?Q?mMqwRW87Uv45q7ldLYXq5H1Wl4GTzPzuVOY8+HW+A0fZaPvpJQj5AG0WK2R2?=
 =?us-ascii?Q?6tBuU24hvHCkhIHZ2pMUnw5YzTXivTlJ7+ut8NIskvKLlDcTojGKL4W0S1lR?=
 =?us-ascii?Q?OTxyLIykQCRXDIvpQGRJTKdDq9amTPj8WPLiFCeSEYOfhNNeTGk0/lk5WgrX?=
 =?us-ascii?Q?yZ4N0eJ+bk/qgWm/FMWahAKqbBX/7aca9ZmWdLuh1FUXrbJwWGRrO+tAHNiP?=
 =?us-ascii?Q?PbMij1bRw826r1a+57na1ai3y2bAQkDO/xCDxoEnRIzqiV+DeuGdLZ+PRbN6?=
 =?us-ascii?Q?mS0gRaO8K9s0pUlr3HLOr0AGzonvleBVFhJrzUUY8H0gc9yQesVP+SpKsoXl?=
 =?us-ascii?Q?y3CfBDeh3GVAui/NFDWKD65HAgJJlwrU/ATNhqkCsS/hFIuWf3Sy5IxUWRKz?=
 =?us-ascii?Q?R7JVOgVIz4IZxxMq62yyyiT9/xQp4CnZYIhp/KEDvMiksigqUJ+6gJ97I4Qb?=
 =?us-ascii?Q?FSPmj4ZllANUqlVXfjFGurfyejAoSN5ZcKHRr8WY4AEPzyHecvz3RhAo1dBH?=
 =?us-ascii?Q?Ypzc0nY8fRWnSO0uk7TwOAqmXWvsbpitL1YtINr2vmfP5eIebPY+aamM0DSu?=
 =?us-ascii?Q?oLGsTLPhAvjTd+WpnsdIvpn9EF4pgJpD9KwJmh2/PQ2drUwrj8XNjpkpxziD?=
 =?us-ascii?Q?xuXDeytUXYXpj4rh6GRKlpYpOC5LdH22oEwqXqIE9q/bCW5t7GpJAad4qNu0?=
 =?us-ascii?Q?S/d1YjbnSCK5CJ5LchajadhiROOkoFCRR3dyUj88nq/+yJoEO14iEVJhLYKo?=
 =?us-ascii?Q?TjacT5w3Km/IRVEKCbSMYRPaNx4hvvH0a1OQ1JDRZ0uvD5WNrlni+6IPEnad?=
 =?us-ascii?Q?m+mv8UBJW2ZzgS0Uw+CdmRuI1fZmT8p9j9xX7Q73H9KmG1sAimWcNFBz8Qgr?=
 =?us-ascii?Q?89/b2JDFvMpRGmmuimpahecX77sY4gJNpuK3pE/a9mVYdpV7MlDLOHE38iVT?=
 =?us-ascii?Q?EuyHVAkSQ41WwNpUxuLqzEj8S92rzaFzgqsEEByumJOOu4JqqvveDD3kljN2?=
 =?us-ascii?Q?LI08zUFq+kvXJusn5Xzsg51L4NCKNO6C1BTwLt+4uOsiy5WzYF47rj9oCsNs?=
 =?us-ascii?Q?daxLm2tLmLYjJbKA/70oCUf724bI0PKdg5JdDjHQTWHnkWP/VkseZYvHFRSb?=
 =?us-ascii?Q?kdLkyfpPol39BfluPbl1TKKP5b4ZXIa0c63B0Ywsg9QqpJe2M23mFmSRgqmF?=
 =?us-ascii?Q?0t7ipprWUWQbyVScDP7/dYVqRCK2EpUUMz+gCXTut6piHEFRBlRRtWs4AufF?=
 =?us-ascii?Q?lG8WXCqDvfWQWtj5cRLqwPNHUXsPjJv2wQA8gFAa43rg95fqL6MfzBTgRejf?=
 =?us-ascii?Q?ormV+iHtefdrkGEEU1pawiCMUQP/lO2YS2LexCmRpB0IMFXjMqykasalYPG5?=
 =?us-ascii?Q?3p2E+VJIqsMmXkWGcQCIZz0VXxX34CRDkiN+wdkz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a87f7b1-6937-4168-9cfe-08db6d0e984f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:05.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ+ghYW8pcW7hOtpmrCWxVAaigosbyF62U/TTHsbCK8+CJFUwlx4qCEwa/yMfZtYGzawuY45iyArWBRmqtqv+g==
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

In the probe function, devm_request_irq is now being used to automatically
manage IRQ. It eliminates the need for manual IRQ freeing during removal.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8772EDF2
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbjFMVcU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMVcQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D9198D;
        Tue, 13 Jun 2023 14:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMonqQWGzcCczcQrHoEzT8YRyHlI4FpV53KDvWGsPGAHEt8XkpEohKsvhSGIEn0xhgUIotAuW7bRXXcqc+29veEli8l4pZF48f+WDF+RB16jyYpypi/d5HRVJzxuQjpjsrwWlrct3Frgm98vcIR1y2+IaRqjGGoJMbG9ZIOtNdAS30Z0uiODOMiBfROdHTq/VbQAhRZyMGL8v7Nno6T6U2hfwAAmBlmH5c3Q7qv11ztr//YyzYS3p3rh/VGd5/bXce+LEzs/TBkD/EhgBCh7/+UFXkMFzetcsq6E32ThvenAqrUvezfAakQROFgwEys1G0MuQBeMOB/5MIhWQ7MVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=RdpzkdL53uOwHV0DSSnpJODvgkVxrvkgCH94Y0CdBHx3eOgm7i5QtUG4eSc6gHDrcLSSk9R6+EZXaF16X6NPeuHz6bJRvr/0/KAzK++FVR4bAYSw2BsTmSe1h7ZKPkCNDUMfwwLLboaLbGqXv6VFXCwPvBVtQ5EoiKLmxbU7VSZ1UJHefK74r9L8bAQ6jeFQBcpMjgZCAc8Au1Hu9LN/WoO5/yrQ63UeH4lS0CMVySo3lYz1z+/sRQ67cZuosuheTSH+DciL1ajekyT1cfHCUWXTwxCL9JH46OXNSbPrv4Jl4KIkYh+fT0z+DdN5M0fBmnKfiHS37KIRPDzbaOtSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=M9PJBhoyWLUPn0nn96VN4e1ufOSuUYuZXbz6pVa2KBFE/By9OD8/ZwpuOyKlgnmSc4zO3aTHcB73xd2U/Vg+6o5G2FLfEJY8lO7bfwfFHUhwy2iI7XL4ShGRmxAXs+eUgqo70ue4PqL80fkWR+cEe7IkRZfRf+lRZw5UvAC3pWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Tue, 13 Jun 2023 17:31:39 -0400
Message-Id: <20230613213149.2076358-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 065189ed-9393-4c68-bee2-08db6c55a695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjq5g7s95+V+lcqiT8et+Twh5n9s26KSwtc5KtnU8W3E1GOwjSAEFhcIRmCRFVvnKgqKL77wrqniBiYyNQOnYozr9nqmybNoLPl42gu0wyErk18cu1Qi/BWKlS4ztrWyEmlgjQ8XRx0dZlh+suMrAH3NpBF1Ry46Sls8nkOu5awR5jxQKbeQbL9wOM+7kF5RTTVcMlgApR/tskJcn2+RmxpW8A1int1oLzSWle17K/xuM4NW04IN/4LMugnxlrlzLZ8D9b7CjOOA2yq85+qXWC4cPMydGOLffAPuM36nwmroW7eCmTLP91bzcVTML6G/2WiKPIL+WZeddTMlhrTu+t1wSP4Ig+CmDJm5Vxl+RUMyYMbR5Ss9quw993jtwsLHJ9AD2EWxkKumkYVf+TQIDlV+KnoUw03uMeYybDTfrgVA1vH7CdmWkpFZKSfEJQxvmSrykm3z2IQfnTEgxwsKa0iz32JtqV6yTOo/l28h2SstrXEftMTsOfi3L8i4HjMrPBs9QfBNeJ+rXlFPspe25JCVKDIbvGp2NXPsAKB6vOZ9AHhTqMewgshFNFGTwXFqu+n/cfPkRU27dJNbGVHI8m+ZPoBSI27ppxQsRfuJFw05taM+OkR454WJFHg9RYnr+yltgnsuGsLtGVvAk6PfLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhH+cfbyR+r6/QcYmsQK3oVZpkYg0tKdv2qawgxaczIWCJVj9MVN/X5j2Thh?=
 =?us-ascii?Q?04KzcA69lTi8HGmBJb6bYVngSDnJ5yJRuJUMQ/QdwmwbajRsK5BZbqu3u4Ab?=
 =?us-ascii?Q?auFZYwVoKO14IIgCXGIe21GrnyxMauTj7nOHubiyMr/Ty6F7AL8tnYfL4iM3?=
 =?us-ascii?Q?kDmJRW01HgbBkL4AQcBeA5uYd71wcjIKgGDlOqNDrUQlR0+pKL/pHzqxmu5O?=
 =?us-ascii?Q?i28tzxpHJ9cm+V59bDiA3zDfquaS7uJ859pSkTxUG6s81H//oUM+2McI4Z7e?=
 =?us-ascii?Q?uMx+Cm1lWsahE8Qnpfq0ZSg/kOHTj/qPGNWa7f532c/yZWCCuCHSNqrsTP9V?=
 =?us-ascii?Q?YrT6DD1jmNUkwJpuU54+fWZFw6mFj2zLxFKiVUX6WZR/ZjK2E6HiKlr6uqSx?=
 =?us-ascii?Q?uIl4Fni4Cn886UodtxSVrgI64+t5qNYMD0e4Flw1iN3Fis4jwKu3EftRVXFZ?=
 =?us-ascii?Q?u/VEfvOWXZhqShTL+ZNEkirsNcKAbZkESHCzEq6gl+n5Z5lSYKuQ1rbYqMF6?=
 =?us-ascii?Q?MLA80HS/G089Zjda/o6fiUzVYpKxDFWvSdYFTu0vEk0JWch2UoJjQwFQ8SII?=
 =?us-ascii?Q?RHIlb/t3zh9huq2MWRUaUgJjW1wNGTmY9J6ln01JQRAL2hhU6Tt+PDNOzR+L?=
 =?us-ascii?Q?aO9q4m3PO3M86ApOQr78ctiFETMbdgP+RpF9HGhrJ4c3/iX9TAhGRDQoPcTf?=
 =?us-ascii?Q?n4uqkogJudvKjrPTf1+IF/aW3dMh5PbeE4QAN0IV/pgviadCqRBzj70OJ/j3?=
 =?us-ascii?Q?ZvoVkIXTlSIAFA/gOIjcusyG6tUlO2T9okzdoLkEepA7ThNk4PTlcvRq1pwf?=
 =?us-ascii?Q?zDpN7QW6Os1oHMFF8bSX8BaKh408KNY1vp/WRZQznGLyes5xOXs1mJz0WSne?=
 =?us-ascii?Q?uTThv5A5DtZwxQQLtr9vhW1af05jiAUvjXzZcwb+tn56whUekKVhVmS92tDy?=
 =?us-ascii?Q?MXlk6TR1w8qSs2rJsb7fg/JRJuXmvEIjL0JfttLAes/Fmswt1ypDPR56g8GQ?=
 =?us-ascii?Q?pPk0Y3snABBNQ/pDmjDHoog9jjoeapJlvA6oqPTpyGzu7nyXSW5xYQxi4KlB?=
 =?us-ascii?Q?se7Ji4I3UcJuAvkyeZeA79Ui3bAgXi5yh7Oe/n8qlB4jlNlu1qWJZ1BJ19Nz?=
 =?us-ascii?Q?8G0NmLvu8l+AR5igqBK2s1bpx3MeIaFKsQ3sAl3tRX1mvwnrb2hh3PCGtljd?=
 =?us-ascii?Q?ADkmm0PQzSbUb2cr/k9DTy6d6a0skAmuO9tI+SRxF0b1D/gWOLZTfO8GEBKj?=
 =?us-ascii?Q?ZHZQ/0HyKd6Qw5tZ8PTDNM2wGpQ0Zqa14+W+RaHyK/t3fDhhBR/peESaLO7f?=
 =?us-ascii?Q?OPP4Emq3Q0Q75c6/HjpVYtb2hVWuqovESObWn1HsGOW8ADOtO/Diry6HvFrL?=
 =?us-ascii?Q?0Wc1or8r2qRDPdwVC/Fg/NYRlOBddzpAEUP1vJM1OB9wgR73vZGKL8qgevPG?=
 =?us-ascii?Q?uJ2+Na9UYngpVID68OV+VrmxMeugLFNbQWq3PqVDLMclkDE1KGSjX+s08Opz?=
 =?us-ascii?Q?2saMZGdDv+orwPgu4tfAWA9R9K1XYXZi/EAxJUtvE05HxPt40xa/HTW1jOM+?=
 =?us-ascii?Q?UFtdeUDDwM73GJdvnWI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065189ed-9393-4c68-bee2-08db6c55a695
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:12.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGEJpUmST6BDd8JfnFr/B63VA+L5f38icC9RtTQsjW92mQIEbbYTY8M2Bgap4XGRSM7bzw8ojdx4DrE9crqH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
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


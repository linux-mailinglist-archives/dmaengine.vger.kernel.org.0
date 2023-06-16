Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1409D7334E4
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbjFPPfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbjFPPfE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1E12B;
        Fri, 16 Jun 2023 08:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDVkV1rlqi2KxqEQ8uQpTkhxmoKppcq+a9n24ixrXSXPYKeYI291J4XoD3XIRwazGmSVQgodE6rZfP0+u3FhxYHNbHzc+Eknz2Dp77XX0xGWecxG46sNUmkTJgrWEjgOk9APU1pDLl0TWKwnayhntjnE8VckJmcqpXbgOpsldszUHCB9nP7IzKbeyFbx13KLOLe6LNjgSvBV5zWBwBQXYnwS4qt0hxXJ/t5bVfyPG9owRGTLvhTYEU3e2jIOzR7j1JGmJyuauL/6d9OgRb1lerNCn21CQxBykaZYbOHWXJfh/NzunWLn4+v3MGy+5KHi1hG4ZBaot5e/KuUfQ6HCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=m5lbo/sRwnjhmgnT1ue5Radt1LLXigCE7WWZVsTBBIfCtg0VnIYzQWoeEj/y1SEnr8fMtLA0svBU5ZHDGnQ2KgwbRvtle64Y5V8PfBL8nhFrMsU+yMxmG+gpGHIbuXZDe/4cLMC0iFoP7iGyXEZ8uoR0hdueSrBQicKOHVMCsDUBpfUjwxytFv6jWofAMNICKPdlSFbumfzLmWzC1bvNlRldf4QFIjgWBz5nR2jrTEGOqqZa9jyBWDD0kA0tfBL/+E6HNAzVoKCd3Rx2gRUyTJVlaQbqRwCrFvbyO852zK5AnU8Xb9rpQwAzDskpfDYhO2LmVBeDsqNNVEeeJA1j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI8n0XPwXsaaH6UZQG+Zvq7pxrcY++lIzGOz4LgaYtE=;
 b=iQ2YMtrTbcNXjbavUw+fI8vFGFYEfTfXzMfWD1+aCRfhZqIYA+pmf846lsIdtF+i4bJEn0Ab9HorpK0pFxTQ4gWMs3K0H3MgIXkXXYqyzyoimwnIik9JltfPLmQY7GXECovP+ULXnIUqprJPIfHuNhQu+ZOxyPEHdgMuSZE43S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 02/12] dmaengine: fsl-edma: clean up fsl_edma_irq_exit()
Date:   Fri, 16 Jun 2023 11:34:28 -0400
Message-Id: <20230616153438.2299922-3-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7ab457-1e0f-42e4-a764-08db6e7f3fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Irl9V16K0otnvX+WDmL3EcBbPryBsi6zJpFAdJh9oP4xUADU6xy7mUjAldndo7ixUqWLGSiD2HvVvTaZnOFfadxfK5GC2tlKD6tx3JyxydCAnnl9wnOMcEfgwsvhYmPzYJb5OT+kTZEHkW39IDMhf0aiZJs+FImASZzIaToDyISHw0EYwStb6z8g7zHtMTvsHWEqtcOYANj4vaS8SzdTKLEcaGrJtVHdxkcox85ev3omoQQe+6N7U7KXN5Id4xZPIA0NaNhKwSYDzp0AJizt1nSJaUIBlctJi3IGV3bIneUUa9elqoyraojD7F/Dwtq/4Og0PlrpbcetnoUWZMrrXAF5T4d9+oRg60aPIlMfs1UcivSnaWInAwhEoYejy6J84tDfm+SFR8S2UkT2TWqBibpRUJwecDqBZWAmoRQug9ewhoVNeaOkMoZQRFTyfEwagxqMWLApFKfoZ4+kB0G9nTt60mgJe1dgXfaf26CZPgrzqZLA+PDS3fgqIEMPWikAS+78t7F7Jlob0BEoeg0O/VbaR3YifpsSmXMgoStbJmV4q1/DGxIMwYcMBzeYlYOomTsxnVRUipQpvCgdbNhIPVzHCiwCgCskA5+EKnbCPEo/eFCXU3Gw7bJQxRRo+/C7mFhuA/8ND86w+sMpu58Irg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(186003)(38350700002)(2906002)(38100700002)(86362001)(6512007)(1076003)(26005)(83380400001)(2616005)(6506007)(921005)(36756003)(316002)(6486002)(66476007)(66556008)(6666004)(66946007)(478600001)(52116002)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Lz8HLf7QURGzVt0qduMa9TNy+4n0hmwfLtD5wZwV3K3jDQ/qhO9PwOmjUDl?=
 =?us-ascii?Q?XSX9hjUsVADxfhdr3BDUoXvfMi6+lx4Kqk2MuzvYeMmerJ9RzCd208zrNngk?=
 =?us-ascii?Q?vlva+BdMFt07cBAfLamOpHiuOcarB4KtsM3WOOqNIxitm/hOlhN5KNFi6XCC?=
 =?us-ascii?Q?3vAZlS0CjhRbEbDSw0kEN93FwQoJqSjgnmAgGInT/a7Y3qH8RVGaG6JXl+ep?=
 =?us-ascii?Q?/PLs45HhtKto8KtgNcU104MZ/JuKS5xZOdd7EV1Ess3tv12E5hmtWJ25zBv2?=
 =?us-ascii?Q?xGOWaACLojmKZH7roI74XvPKq4hWPQ/f99R0uvoQOhWxPaPqrCkoxUoTe9Oo?=
 =?us-ascii?Q?HedqfZdnIf0BWxlJNULXfoVd5Uhb14XoM0RQ8Orr+JFqPx30Dj3DdwSPbh1Z?=
 =?us-ascii?Q?wUendi2VKc/Nhe86y97L3udQpSfPAuA0Q6l0ZTLJd5dRfe0EgkWrKvvUKxGK?=
 =?us-ascii?Q?qoAuU8wtNpr6pwE9nKI4M/muCRquqj9GIAkJFWtk7Xu7q7Wo2WnhWTqgmg0u?=
 =?us-ascii?Q?4kqCgizRfmSo/foiVC2YYwMvRaYmAoPrHed5fvMnSuvmfQeyfc6iR5W9kmOz?=
 =?us-ascii?Q?w/7RLEiJ6fpvE1FSzljmOeEZ29BIm//4jDIqf5L9VfJdThuFj4MPlAaD8BdV?=
 =?us-ascii?Q?SrSGZNyTaOyAxn4hthE2yDwiPWoF1xLwaQyPymP+qNxTiIZqN9BFXCVa3Uy6?=
 =?us-ascii?Q?Co8AdK2IBql5DNakvrvgo4zhQzH8T8D5hBegv9kd5P6bV3W4Dk8kFShBJHay?=
 =?us-ascii?Q?NQSQhaltvIV49aYR6RzHfftlqUSlqwLFg64YmdQKYHXAar5wmGb+2AsvvMJz?=
 =?us-ascii?Q?/ofBObjUZIgpeXW8bqgFq+EiR2FTFdAOdSP4qCmjlGwKJhJEQmzy5+HFNTr2?=
 =?us-ascii?Q?sV28/uL9oOEBpHJrBAxjmajLgGFmgX208X3PkNnihx/fO5x6LkCCm6tjkRWT?=
 =?us-ascii?Q?XmQl1/J8SnbNWzBBA4/Rgll49EUSOflaj754k7/IekiCM5pAeADCStMIBPke?=
 =?us-ascii?Q?yAqTjuv898Ki4iZKhnjsQZxFjYHiZgNF3SJK0AAnjm4f4i92DfolcfatPeoT?=
 =?us-ascii?Q?z553TIshfiLRhxe5gqJ738N19JXcZ/H5REAJ/+enJ0ZV2sVeWACi9/Rb4VBi?=
 =?us-ascii?Q?qLSoO+WYm7aEqSU84UMkegcvdnGT2mO3IuuB2aZn/QABTv5Kz56yBam7eIAu?=
 =?us-ascii?Q?7LCU5X4qgVJ7TLdAULXi6chFfVv2IXki8fAvrB/F8DfeXg+54BXzkTixo3kZ?=
 =?us-ascii?Q?k11bGv5QTPCuKXh8yaBHWLHZd26jqd+v2ujaq+Zsc31qYxAG3x4opJQRrdew?=
 =?us-ascii?Q?vBfI6RFDRvScBodYGO0lKIZObJ7IfmYHzJEXIoGByvVnF4e9wkXEGd9zbWmX?=
 =?us-ascii?Q?iQ4VSpOYl0l7TkiU1n7rlaYW8yljwKPRGpR0QNxFIScQHtyIoL9FYaKAj712?=
 =?us-ascii?Q?G9MU1b54rEdWj/fzaj40h/QM6sCfpKCh3fVOcUBTNuWDW4dAjjLOCXqh1vvT?=
 =?us-ascii?Q?dXflxoILgovOzAfbt3/rHoHEByOmrTtbvYVl78El+a8ZXdMjB4o7Kpppn2PQ?=
 =?us-ascii?Q?mH4xzG2vI0ll9Cb6Wlo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7ab457-1e0f-42e4-a764-08db6e7f3fb9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:01.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTvq3xXvR4ZsmgsiQeyHsO93BHN2wy0veH8aVzRyTnPwopBXABzsNCCKg0HqLIJ612qxLicLUnJJ4r939lZ9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644
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


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD34D51CA
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiCJT03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiCJT02 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:28 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00F13700E;
        Thu, 10 Mar 2022 11:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMZW4m4CI8aetBbaZqrDkSEAH2nvswSRQs5uXrBVsjultTSkP0amjZ//durfW7mNaWV/1qnMKyvLjaW+LShvrTg2DkmE+cGIhJJwmgWbaQeqI8unrJo6P6/7pdre/cJoTbWJgcmw9UdZeWMHHFKIevfwjq1o161uzgjPVgZlZyWwF/Nz3aPvNegk7tGy2JCrrPYNZRMGrV/pV5fdViyPOHkCugmkOkbcsS45EmX/bZwyz84kAzknmHxyIPjIVW11z6od8MGAcuSi+3NpBgCBZCmATfAT+fs3Atll6L8d1PWBGnbclw00QaL5IYtXPnamab0SN12xqVt5Idm3Rwz2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYF4fW+VsXQBRbFMpYnxf6fGmn4O1QU+++8Z/MnDsMI=;
 b=Aly7HLJoc1v0dmNkbFRyyGeeXk15JnwKaeZHMd4TIh+Cabat37XZpfFZ2lcWJ1F8sNu5TWC24l6o1UPyc594kiHhQhRZD5Ok0fm+ImQZAdRUEiGRMy2qsWtPMmOralQt25GBisIJ9e0yXziKWMRHQI6ztQt6D22QjkBUeDhvzZvB3Sz1wAOPMohZK4ZMcwuSjENXd3jg2K9EX9Dt2iBZ7mscWljnkl4+lsjTKl30/pSnYQquqRayUNg1zxIx8hxYJxrWO9Vu7whlAmfBC5ndp5EbtkmE4aEf3NEQsmi8XgB0Npwbh+JSPfHZWLL1ERSYldq7pZyeq8ktGPA93vy9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYF4fW+VsXQBRbFMpYnxf6fGmn4O1QU+++8Z/MnDsMI=;
 b=CZwtVHnP0QWlb8riFly/7hdSgOUPdwgIr2J3957jk4bzxwb1rvEZpDcurlC0jv0zhZ/1gYWW3zL6H463wv9Bvqfb+pNa6iupetR6KTPB7/gYzxta2pFVn0VIAzlGkyyvSQnDQyk3l2MLX48RfV3cmsCYCoe6ozazX46S+BYf1Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:25 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:25 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 2/9] dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
Date:   Thu, 10 Mar 2022 13:24:50 -0600
Message-Id: <20220310192457.3090-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2211cace-7f9c-4511-cba9-08da02cbba1c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB485868239B883D242AC04E3B880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8hARnsk78avM9jpqqfqbmE+F/pNNjRNK7zRQDZwuujD5K8UqnEvLaGiRTWlGlm6yQm9UotsDnmDncCUljdyfIRhoCd9klowTleM5ueblLbVLPhNfsTIlw4e5F2qIA+0ZEjsukStTvhGGklFxcPzh8PRbxGo/oBs2YAaIZmFDoD52wTBFcFmsetC6HQgItMkTjdkCrVqxs317iz8IA+iLoysNGmx/VtcKd+AkMymyjxeiNHG8V3yaXd1tWwOXK9UN49tb8UkLrH1GOzIcbS4nOCFpgqK8bcKrlHZIF/RNn5lyICnYChcTOYBNO8rnUiyPH8kw72r9itkEUMnCdsmz1iP2tlH74cIlD7ceCF3TIqp27+6O2xLrokO0EH28PAkRcbGWoaasCCzR+ULrHn+UGrFk2d1T6ak+8vadW6v2XSN3+pvbtZnH9DURnEIbQMF9ypKOhVzar0DGReuAx9bQZg7rhgIyMCotxIq9DZW9gmDhMLmyIfGz1KGMv4xnpdPZhWUp4b9ZGNohIXLfNf8ZtwvWZHmiC/lzfUJ83EF/Gf0+EoTePRTPlbTW0D5yKYg9tPqFH/lioXCO/a12nh/mzLi9sEToVKQrO5TR+7K+BhCg4ojYy5end2nBiVvXM8ExPayq8bEjP4qK8Uhu3U5wmaFimeOLCG5MxUSzk2N7mwo+RsF/7No+HO6bRHcVuEWHLmbs8BC2RnC4YQmd5s/pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3qNQwmc9h5Oohca2CI/dJfjLStUsgbjxZd+HK+501EQ7M+/dxNcKC+gzIKg?=
 =?us-ascii?Q?ISzYy4k6lFBLNwO8EKVUw7yT0TZbslniWOCcKhd+3t8SKlbPz9PvE/k3BB76?=
 =?us-ascii?Q?85KVpO2Vv/gbY6lYfvIxJwfRfegPWTnEVrtM20a21lPiNzdjIHo6mOxTXTuc?=
 =?us-ascii?Q?1fz1uxmTfFgnp67+TBzvRik8tWB+fd1pafiUR5FXHrw39ljFcFXNBN0Yq4jb?=
 =?us-ascii?Q?/nXLdvangNXICKLrVU5W7h3GTW4DkCu4a5HUPKlF6VpHJ2P6kkoml40ojGL7?=
 =?us-ascii?Q?+Lr8ZkUpwBvsxft4yngA4FPNgzgjH6hJ+tQmXmMcD+n77RS1ICacES16wLF5?=
 =?us-ascii?Q?UNW8/G9t4iAm24K8JkBkr14moJ1VMEaG3Y55ulNQOdNL48ejP9d4OYxk3h21?=
 =?us-ascii?Q?g+12HqWsC6NoHrFZzxfR3Tkm8Cm4740HbA1dQRLnRnR0Dpg+/DxC5uWm0omz?=
 =?us-ascii?Q?YRoZ2mhgNV021p/uQ+LOENCKdkhAcQ2rIflWpZKyReZRfI0dh9lpjaDVzj56?=
 =?us-ascii?Q?8qjofOZ/09IcfDm9E7bdX4DRh0MBMfWbslPpmL7hnsqRbdGHELKSNQRrOuFB?=
 =?us-ascii?Q?y/EQi2oSG0xvozpx+3dC1bj1+xfJwNqKJuyVArJKcdlLBKm3uXrHjrSggBVv?=
 =?us-ascii?Q?RqPk6ILlksTqpwlgSZjuXyYY9/tEDrwnkTtleuOWKAsC3QNq2PDBHh39iyrY?=
 =?us-ascii?Q?q4KO7H2OLE8GJgaFaOw07IoAzDh+Rq+cN8FazI88YZY4mAu121+bljrafWbc?=
 =?us-ascii?Q?Z5RkvVBqq0d4b9ZS8gSt5SetiX+tHUUT3m3zZLePHoACKM+hmIQ0NzfB0dot?=
 =?us-ascii?Q?OH9rTPptyOo2eFU389lJ6AfOXYNuPMQZlLKOhessit9OOyWHJe6bHviS0Sc1?=
 =?us-ascii?Q?ChNkBM9SHFEv3C+ZlPUyFcG3K+pD1S8LcYDsUlQ3IFkBW9j60LUABQOyWcDp?=
 =?us-ascii?Q?iUUPvCNfrGxgk1GrsBybOcolFX0ntJBfKgXNSxxQuBkaK9oTaVBBmSA4i+Zm?=
 =?us-ascii?Q?GbxZIJdBzQk3sp+/3kdwaaXcesif5icohE+wjZDqTic/CijPmHd0QlcU/uOJ?=
 =?us-ascii?Q?j68ENhTjlZIsCzck7eRQYxsFRX2KDm+v/k7Y5/2QEzFEH/1ucLBS0Tx8nrGZ?=
 =?us-ascii?Q?zIXNVDs9kS678b4uvZw9+iI/Sc95kQCBaUjRxqAzmTx5w9Bz4UxPAx/KtGQc?=
 =?us-ascii?Q?2QJePZ6BaTBKvC0I0GyfN/44cUjLm7HW38eJgEAmezeJYLi/wk4zG141TBz7?=
 =?us-ascii?Q?BI4aLK5Y3CmVRPly7RM///2EWVsDq3VAR7QHn1BSSk+5hzRCZEV15usletwt?=
 =?us-ascii?Q?KGHS8OK6wl/djtReK7gQGSZcbL5tqjN0avUa/Nd9WtzO53ZBGooYG6GB1tWk?=
 =?us-ascii?Q?blVGsy/pY8Ke4cnO/aafp4eLwcWz/hYKfBXijnYg9yhu048dsS6/DbHX4fHh?=
 =?us-ascii?Q?SDFNmWAPZH/AnS5NiPoqVkh6GJrZ/ZlF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2211cace-7f9c-4511-cba9-08da02cbba1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:25.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsb4qk2mqjLZpBVose49+558WBa2gNHQ6saxzPIgsG718V5vp0Yr0tZIdUZNGv/hZkjCf3mV0IUKF1UafD2qMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
 - none
new patch at v4
 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 21c8c59e09c23..2c1c5fa4e9f28 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -225,7 +225,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index a9bee4aeb2eee..6fd374cc72c8e 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -37,7 +37,6 @@ enum dw_edma_map_format {
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @wr_ch_cnt		 DMA write channel number
@@ -51,7 +50,6 @@ enum dw_edma_map_format {
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-- 
2.24.0.rc1


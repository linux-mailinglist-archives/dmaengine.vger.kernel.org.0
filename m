Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1641650A2ED
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389611AbiDUOrw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389668AbiDUOrg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:36 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10062.outbound.protection.outlook.com [40.107.1.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F294161B;
        Thu, 21 Apr 2022 07:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAtqtQQX24QuM47Irp9p48UJ9GyubJjnGbUtuPrIbV2tTB160YPjru1JKBoWtiS8lYMnuFLr2cmUR+tCHxsPHtk3W840hqUwx/PMmyTybWzXOJwWemeobs9tNiMClJJZFzfT31OZ1WgEbzXFyR9O46nOeEYYaqX5gq8N98KNh34tmMhiIDVhwxCmgmUd4/orUQ0ZmrDCY0LaSOcRd3rAMnr9h2bQMFEMT/iMYV7AjM0Aw+AHf3AC8INQgqk3Leeeb7006j6wwVh2XvD2TaTsh6syo2QnhHTnhSt30jcGKO7I87JuKEjSGq7NDpA+MHHWCqK0fWmQNTScYD+9AAhW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHsr6FArWpaVgQuSGe2hQzVTSCxZQaRJ7H8H6EDEQ40=;
 b=lGPneIJEIKrcHwM5gl0dW8zUs3Gn3Cb9QGqeithj72QmKXOqyiq32yk1SbuVjBISd8qvRB2DqM+xw034LJBc2KNOpoVMAWRoixMwrdwQdU2IdviZTAFmWVe4TzkUDa1FdoLZ6a/8zP8Uez4MqyK6QPv3y6bbU53a/zDYVVYLJZdQ3D7SmA0IN8mwsFjNtK+0hzYj2DfGV34diwv9D9IOxvPtpK/VdcgZd8K554qbrwsMS0ARb1TZhO2VrWtfwfQM80oQ/k1LCjpxyZeMZriprdHEwQrZXi1C05SbprnsdGFM4S7ujV+GgnJkBdfapdJQf7EYykq5ihs/b4WrJSadkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHsr6FArWpaVgQuSGe2hQzVTSCxZQaRJ7H8H6EDEQ40=;
 b=rbcshDHsXKze2kqyjIcOkoTx4DS6fZ5YvjKkOXWeNo6FzNO2OLp7vTbSxKmTsSZWsq1YxQxXAOHlkKVxohut/lSWaz0A5CG54RyuawOKjOYJVLRHq5Che3iaJVIjqODfdBLPY8auprCOg176dJYDSAP3jiGHNOOinHdDPhYDV30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Thu, 21 Apr 2022 09:43:47 -0500
Message-Id: <20220421144349.690115-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eac2576-f9a8-4709-a57b-08da23a57960
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689F1676EAA79C6EBCBD35988F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekKEPKY1FqpBFEX3uA3fs3T4WM/j1xCcIT3EsijRORNyWSWfMstABoK6uuszhNnc8mHEJuwN/YuHZ3WZK/QClSljQsoou50FVZvGB0kqS7yPcG+Uj3eeIE1k8k7+57lqD2mlz6n4oYIxoI1N2z7AgGQCMbafmY783al1BOo6OueNP+l7yvMxfdQw+cnGpRG+WZlhjKNViSxhy9NpuCCkywrurlHAgACp4/MSLjY0XVqCRLC/HvIYcGanBUHFnQ8PxGcvJFY1ii1HBLac4iVap3k9axfupdrkl1I75zVVaw1PqQ6PMlQo9xl3MtwPMpqDoWBnAHBjZTPBhL0mCDapyZ2Qtjr/wYx4FrgCYte4MJedUBHqLH6Un1NdLtRcrAEoIIdFfvIPDuyTUtfUYwm1o5EKzTkQm0iDow+DJbLuG7fd6vK7db2WHY41R/iupB19UwEiBL8z3UqD0dOQWX08dhRP5Dx7qemNIaQHXWQ0TEVAEW6gWq8MwJbYCrIQheTV0ySGHYvbGKdS7BgqJhKVNbsxbQLY0BxSVtcbTdZVM/f0vqNi8bQC599YoKFnvEnxX0sJ00MIaShWdj9s/vEbT3QhcbeI3+tgy0kA5BXaq3q0H5e/h5PCn6k1neWBJ2LECWSvinQN2Wenv8PKhiE142LMeRR/077U504xRCdY1T5l8KwmtC2AEfArSj2WmTVgCHPDffIkPMF/XLbzFP+yrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2lPGZfNeskdLW87uktkv+8Y1T/fScUUAGjoUMVa9NC7v2fHmeoXf4Kl88hI?=
 =?us-ascii?Q?0IadS5n0SBGmusM3GrSMe75RugVaK8z4Ory2D9jlfgW8gfErqRNm9ONmdMjZ?=
 =?us-ascii?Q?uvVHWj4ACIaNCvCIoktOSzq52znUA41YGHUVPCtSNC7cXEtzE0m7oPoLDOwS?=
 =?us-ascii?Q?xXxSWrN1mQmRBfrn2B6mzJA2sA7YJrXLX7OdEllUqgqVMUpbVnYikvfhEgBJ?=
 =?us-ascii?Q?m5ZmfWKsuxF1Ga2j4dEC69AgI3btiLIXD5ww9FjDTIjE2A4jVMLdjYUWLWXp?=
 =?us-ascii?Q?nWrYO57XkCbwwvTIquLN1lqhdKNbZ0qW65FniHJAdXVLYyS0E0YYKTWLNw+V?=
 =?us-ascii?Q?F0gmZ3TmOyszILtQI10yfffF0izrV8erjD79DKCcBhCUawvNUwM0MYD95KAz?=
 =?us-ascii?Q?mlMFUZBQ8wr2Mm3Yn+FoftYb0zDF71sGj3kiBrTIbFBB4zq15qY4elyXeWVk?=
 =?us-ascii?Q?XQMuVeWtNRBLag7SNUMNaDIvaUWWB9+Smo8/mqQwv9rlv+i5cKmVipEou6V7?=
 =?us-ascii?Q?iFn7Nb+YSF76fM2TKzmbVCT+uqGaIdXWclFKHgXJcZMfzEIXQLFSb8hOBSKj?=
 =?us-ascii?Q?ZYgaW95W6BwrUSPSN2t0NOcNRVtS+yOnyown8Jus/RInFddomMeCZL3Xfzfw?=
 =?us-ascii?Q?E6a8p8Yz27G3kLqrNV4OTc7/ts90I3lEFjLq90t3LnImCgrWm9tQ9uBnMzQe?=
 =?us-ascii?Q?mrj/DjYMYPJV9yFncxhSbtK72UHAVs67HceoFIMVZgw51kjyiYbqyoj1WUmA?=
 =?us-ascii?Q?gAm7EIcqhWQJT3YpIzNHcANOcSl9hBVYNTkOikM37VrRZVWhlv1/JHW6uWpo?=
 =?us-ascii?Q?SAvMrQlzi7Eh5lZkeD4bOpHCcqp/eRojYUVBuY829AatS5Nu5fS3sHUEz8xY?=
 =?us-ascii?Q?940kex3EegkNbp9ZvSdhn4M9gP7ZFg6pREVDNJb22Aqo09WzFX/8dUC2QFJo?=
 =?us-ascii?Q?ZhIyiYusMs43VaCy7cnMERt4mH5mdXsiP82/DUZ6UoRQBv7+CSDeROISZZ6M?=
 =?us-ascii?Q?L19rJFvI+MRO+or7GsUsCuJ6RKx170pSpHsUWLMNWTfTlggN+XS/AtSVqmGw?=
 =?us-ascii?Q?Siq8OG8i373tHW73evKTk+ih5e3ye9wGRdFbWXQwidpdS1hk29Nxk0Y3PEx1?=
 =?us-ascii?Q?whrih0QRm2Q3YwZdvzPrm9W8pWfWr49YuIXYQIkFCex1y5hs9ohwIlG++cOk?=
 =?us-ascii?Q?zfJ3NfLHoTKSxEo0IeDHJHs6XWxm3/JR9q3KOvrKba/w2ck0q6qzI4oaJNkR?=
 =?us-ascii?Q?emA8r0UtkRsNxk5HNqPIwhFdxNRuBuxaI8JLTTvVr8apQZ7swfPlEkgeRhbq?=
 =?us-ascii?Q?g0PQP36oykjZSqlM2lmesFuWBwSqZO7ZVryRDFN5q+P3VU/euKG0V8JBcpId?=
 =?us-ascii?Q?3d6Nq8mwSuocGVHsO0Z/LH4PQgkbz8NvlQjkBgv4mjqSUgUoRftkJjSR4cRv?=
 =?us-ascii?Q?+VSc0innKKUuWbf6akIEhGofTcrFxPpaahbgqQjDMLHocE9RQt+m7GU7/VZy?=
 =?us-ascii?Q?BTrG2Ve6xu2eFassE8g4lleAUaYTcl3R4cBP1kLihC+raRzUWMSUy5egKFmT?=
 =?us-ascii?Q?dwGPAFzCBb9akpcSA4Fz4ahspP8PwlSRtrMmf4EFxAtDDon2Dm5/cih0RbUY?=
 =?us-ascii?Q?CYyBssKfStF/MpyRcNDXB6/oQQFTx/LQ2q/N0fBW37o7R+EXI1WKws9vvVew?=
 =?us-ascii?Q?mW56wzrw3YSweR1sHasZhkIYYA7RO2pbci/DmwWPE/s3Z/8xpAsM9EQ9hDmL?=
 =?us-ascii?Q?SGeaHt72wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eac2576-f9a8-4709-a57b-08da23a57960
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:44.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I8CNuJUnyqxpIbfH5EEfprvziRzj7bKiscAzq1txqrl6VUA+x1Bk+XUf+Yeu4TeFJfYuSRJyUvbt+6G1tZFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a "flags" field to the "struct dw_edma_chip" so that the controller
drivers can pass flags that are relevant to the platform.

DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
locally. Local eDMA access doesn't require generating MSIs to the remote.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v7 to v8
 -none
Change from v6 to v7
 - dw_edma_chip_flags to u32
Change from v5 to v6
 - use enum instead of define

Change from v4 to v5
 - split two two patch
 - rework commit message
Change from v3 to v4
none
Change from v2 to v3
 - rework commit message
 - Change to DW_EDMA_CHIP_32BIT_DBI
 - using DW_EDMA_CHIP_LOCAL control msi
 - Apply Bjorn's comments,
        if (!j) {
               control |= DW_EDMA_V0_LIE;
               if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
                               control |= DW_EDMA_V0_RIE;
        }

        if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
              !IS_ENABLED(CONFIG_64BIT)) {
          SET_CH_32(...);
          SET_CH_32(...);
       } else {
          SET_CH_64(...);
       }


Change from v1 to v2
- none

 drivers/dma/dw-edma/dw-edma-v0-core.c |  9 ++++++---
 include/linux/dma/edma.h              | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c59e23b9f9fdb..2ab1059a3de1e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
@@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	j = chunk->bursts_alloc;
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
-		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
-
+		if (!j) {
+			control |= DW_EDMA_V0_LIE;
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_EDMA_V0_RIE;
+		}
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index c2039246fc08c..fbd05a7284934 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,12 +33,21 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/**
+ * enum dw_edma_chip_flags - Flags specific to an eDMA chip
+ * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ */
+enum dw_edma_chip_flags {
+	DW_EDMA_CHIP_LOCAL	= BIT(0),
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * @flags		 dw_edma_chip_flags
  * @reg_base		 DMA register base address
  * @ll_wr_cnt		 DMA write link list number
  * @ll_rd_cnt		 DMA read link list number
@@ -53,6 +62,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.35.1


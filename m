Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE950BA48
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448748AbiDVOkV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448755AbiDVOkS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:18 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20045.outbound.protection.outlook.com [40.107.2.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A795BD3C;
        Fri, 22 Apr 2022 07:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdaX9JFDmCmrRgXh7Q2ykmaGlJ9cjbvOW2if6LhG19EnliWUymuN8qV6OGFxfJrrUuU7zGKSPCztMmY3P9ehRLaYxlY0TVhz66RUi7udxvGZi/BOf0OLgURFN8jEtEoJ5KwkLRYxDa2wZJyxEjdvlb46CKc9aWmoxEibnVbdBdEK33J96yyH9AJKb04A2gUUWiQOTTRQf/B2J/iip8BafQovDuCy17/NDrjDpHU2lXMXqf7PpkKLCvZI9R+dioM0vSrj4louS/mHBEMLjmw2+6x2lF4Fwy3VYtJwF1xGJEjkHhTYa12MKWy5+yEa7/Xo/3+OwmcbAhLuaeCd9z+2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/7fkcVQv2jzZuX+ZGgpVTQxf6AGLQF4CsV8c2hm9eg=;
 b=P2tALovyiUntaul7xPNS8q/qpLVU7dJrQeux8JsgStm6FIMpU4CWkNXwFBODvFoGz5F++G+apQOORMYUukpb6jscV4xILQTTzrFvlTwj0xOWSkJgB/AHdAsVqUuNrKkhXJfrhdgl23U0NsdCREw05tVefXNOZolJ8Bseqv2/3hf2INB6dDqkH2fEnJ7lTiMHr4FAj1xkLM6ey9vhEnnHd+0KH8ioZHrRf3/qcs6XK1P5TN9itIaXDk9IUcnM1bnDmF6eOk3n51zEmMUR7r5uTQN5q6ErSc6iFsWzOGBf6vGZ0ReKgtw1c7wmfl2pomqInGQo8acRyYvfxpVEvxWsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/7fkcVQv2jzZuX+ZGgpVTQxf6AGLQF4CsV8c2hm9eg=;
 b=iHRMtIUdtXpFC9zRB2l4GFdmpQZ9n19bMqp7RQbvb1OqHmETbdV+LBChSX1cePbhfA2FNyBJbunWLzs21ptUNlamQ1Tbx6iEii22K8xhpjwOpK20j0pXXboxoIHiNoPxknD2jgUdoOq0XrASWLRopwgPcE+G9u7VGjPJRxGP3/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:21 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Fri, 22 Apr 2022 09:36:41 -0500
Message-Id: <20220422143643.727871-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19175f19-097d-4449-b651-08da246d9bd5
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2644340D3C3947DDFCBF233E88F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tTCYzexlUoV4LiTNmll19XQbPJyBRX8LDNnG0yxU+799gCFCKu1grXJemmMeP6NR7HgVrHXOsxlEB35oNJpsnCkP71qDinzMaTf9LqiXz+t7tnXstYYwahII1ZMl/1zVOROTN5Z480pwGgO2Qbt3NMNtn9/HdjYohRjmQ50a3XdkO73U0k+KciBy8yVTc7Y8c/Lei4hJEncl4jPT/zq5HQfWOZ3Ktrxb09EuqTvSGfj6yxJS5SD1pADkAjuAYGwWlsxSbZq+ClgL+m6a+CaDMhH52rn2bSwgjvFV7w/YqiUGkoY1YVixlSUBFtQYdqvnOT0tYd8AXcedOVIzemnbVqtBg51a503DfhaPyYWhodiYIDdwsQywXNYJUOKpVEYhlWvQL9Zz3AJRRVb5jkdIBMUVyqIc0HB9QuJAgVGDVglE0LcT77vDbIMuQDH53BpgORxrBOS4/yBg2CT4VpbU+oh8x5BRlaveIStvW72lKlELlbnaIdUckoPx5AxslbRPlK/SGm/rpm6WByj52H7Jmh309zFH0DC6fr/yxFivpDD5XmLLPx3MM6JaQi4a/dGyuRNIUEiMDsdkVP6b+5QzP8n7u3qE87DVdYSpXdzPwYyzkh7ClhrFd2ScxtZksUu7Vj1PtbUvDyKg0DAZyyn4q/4vQMvBVC4WIGZzWWPRZpJSxtbtsxrpoVlDHXS8Jth8F3ojc6kvxb/Oc8XOQFLFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRHLJl3Xl98PEQ/3ggVZL5OchuDLmlG8H/s5FSKNhmZK83QJc/qb+a0CSXBe?=
 =?us-ascii?Q?8DH6C05oU42R5DAFtm9y5cCqdT5vPB/pKcck3R5gL6sGialHSqdoleHdJu5f?=
 =?us-ascii?Q?GrBcwa/ovjh+DHi4qCC4L04jAK5egOlHStQrM3yAawfuNPddJ3cDFmVWrJPk?=
 =?us-ascii?Q?Qx6nF/VJ7uGV/ujLcIIHCxk0atOqsIjg2z1nQJmFTWbMOZ+YspGa4lZIJbzC?=
 =?us-ascii?Q?hNtg5XgN1fZIjaffD9HGgwsgBjWGVSu9Pd6DDx+n/KvHm2CskldtzXDCc9Qr?=
 =?us-ascii?Q?yVn35Er55m4d+MCMkbgXmSWrmMtLJPFvk4oHO6F6c86kBVeKLK9iPEskH49c?=
 =?us-ascii?Q?/AZIYkK4fk32Lk0XzxTajfFzYdNOCoAQDFdmDf/EmgRgJKU4aX6KI/Xbl0Hu?=
 =?us-ascii?Q?OF9FMEvih7vVXeD0AwSN8tr7f87/SS2CZ34DuiDii/ahDxqhKC8BCQOOZy7R?=
 =?us-ascii?Q?s/DggJx0npqsFmqcJP2UmMEdx62VacDog78f5X4XfSyKcsamXstx3Rh+Yehs?=
 =?us-ascii?Q?Ik1aRLt0hFbjmN1O7llxTkSs22IXFaGudQBKtK0BzH1U6bfBRFRFbJDM7+hV?=
 =?us-ascii?Q?Eb47pc9gMNNI6uBzCwKH/zOZLe6znB6gz5+j0taD6gBnHeWv1zadqylwfkac?=
 =?us-ascii?Q?ea9iWMJRzOw4xe9Yb02CmkzF2epmhulo74o3RLr1uaKsv4vlMr93UBV1V1xQ?=
 =?us-ascii?Q?WBw4dptmbSrk9UCs+Cx8HJkz/Z5WfRUIK2HD5NPdESLoCzZB6zWgndAviipU?=
 =?us-ascii?Q?hMts2VaeU15MQ6IbytxaOCowAQQv2bwezGtJbMfsApvrtW9gfb59oO6QHK2D?=
 =?us-ascii?Q?GNJ/IL/hQUINdQ/VS2TF//vq2WrgLPWK8y05ryfM+1498niePCB49ZFQw5GL?=
 =?us-ascii?Q?eeXrftROqVcaTSifpiBWT8LvGs06sUKm49sKn+ADF1rks4vrusvz5nf58kgA?=
 =?us-ascii?Q?B6xdIaZ+jNja/mSj9YHvJOka3UxoYHTbfA/9djFvsM61ZWY6XfbH4cysxeiK?=
 =?us-ascii?Q?gSD9iUwlMaQbwAJOVoXFzxV+Ti+KbYG3yVaRt8V8Jk74SEBXIVuaGnLC3pIT?=
 =?us-ascii?Q?CvBb+sw4A8gmfSf2TuUV5qBc0MgTBXNAk8+XT5VAVOekxfA01BOG/m0096R8?=
 =?us-ascii?Q?cF2gvx2FWOzU2GnOW6ayYHp/ZPrMixvHlV0vL2c5vDtzKYqRzXzQh9CmLZf6?=
 =?us-ascii?Q?WNTQy+WRhIQsWOHtQa6GPD9AEqthD1wnuwJvvLEpm+LJ1qmPVOd7bSI36sC5?=
 =?us-ascii?Q?zO2Bik19ZEUb23eajcJdRg2/+iaMLkHVmIOK7hiZbDuW+1eIMrOk2DWcI8MV?=
 =?us-ascii?Q?F6zmrdzNbzFbhoaWZjjkDuzVs5itgd0FXDfNx74a9KpjtDGtmEZJfH8WPV1A?=
 =?us-ascii?Q?8Au9rbaRO9E0F9CEPXPk+cPgpw/YXQMNActnyN99ZoCtDzo09NCDIjf1wstn?=
 =?us-ascii?Q?Wl52YakjOQRiVoCIX2VNRz80w+U+FDOFOg0wfL9F9E7WqTOQ4B/JXnns/Z1I?=
 =?us-ascii?Q?IBASGj8zD5gLChLJMaM4THZ/GwJmc07OUtSplITuPP3n1Xg5jh2w+3lF6eQR?=
 =?us-ascii?Q?LumgG4/pqLCeKTxMrdkUWb8SvwARPCBYuSL8FDJWxDdecInIF0ou88a22HCV?=
 =?us-ascii?Q?334msD4oZsAXiTbY8AWQztQA1TpCcN1Bz7L+HxSdlLxmtaFT5oj8x5YaC0ep?=
 =?us-ascii?Q?w4Fo3ZyzOBLEU9Wj4TH6AZkDeuGtOk9jrVek0e8O/Gkz4rSNOnFfrgQNJInW?=
 =?us-ascii?Q?bZykLOpWEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19175f19-097d-4449-b651-08da246d9bd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:21.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByJ8y8v+U+Vjyj8WFwLJERhnTzYRh3o5D9W8dHSQ0Zkjnd3Ur5q1kBjAGEyPGWdy/0wCNkFhEPtufMz3y5MQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
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
Change from v7 to v9
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


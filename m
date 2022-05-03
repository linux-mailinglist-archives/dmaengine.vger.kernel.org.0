Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3F517B66
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiECBMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiECBMx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:12:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7753CFD2;
        Mon,  2 May 2022 18:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMjGLGFP1nxfAd4cu2oDjlgnq+NXYk259ljLnFMqM76bFvds4P9kscuSJCzXgsYzOIDIbmEga4Zr+v36zjP91L3u26ml3pUjiw4EPk6K/rxLPnTO/hg35ZMQOgS9dcNM1sCGsxMOGx8gl6CvHEamjhVooRM9CqPqRD57ZnHNaAHwF1m9K81RhyRW0sTnmD1IqN2qtM2YZDZuJhnTgTJAtTVaKmHgkoRWWjkq5SDjgSW6kUEWuBYlXuI4k5o4IPQDFKqTz1J5KDOgJtaTA1+8C97ZY5Qa484EtTgWaS/bRoRPZqTu1wO8UeNYMuNxjc+I1OcNLDjP+2bFJF9qU7CO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTkqXg94xDti5IXA2HG6nNt1pqTLWNK/vpDAAU61LVc=;
 b=ioHiY7UDza4o75eyVcqTaODb4EfGwfDR60F+6lebv9pNNeHkhfgU72JJjglSD/gRToeb5BB35+Y00tNg2lK2bhrx/t4UrHdNSSB5ZMEhQO4pn3KexKat5Gpdn73N8mH4XHMVswWtC8UFrnNExqqOchAMRCF1AGVF8hO9AA5OAE9jeXPxAx7jYKB5mnfTRFYfYA8bLH9JzTGlTCFRfHD8T+Ss3GpTMgEdLZVQ9TJI7JZZzk8iFpZQJrwMQ69Je1wQd5M11lcwwNTnncWd9MJAxvXtIoH3YLxXYlNm82Rt1/EabKkUJgsaf/f7Um0FcMMG5yTwjf4azp8GvxEmH9B6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTkqXg94xDti5IXA2HG6nNt1pqTLWNK/vpDAAU61LVc=;
 b=dLxfGO9RvVcR/fa+O6cMmJOm+kHnVJBH6UIn4pw9xfPQaUoh4pQIOr6SLssLTrKdyWxIYpuzQvCi9t/spNzTWl+bFjca7LvZ7N6O6bvcZq9dKBP3dg+y61xx5Cf1HjM3ZD0J+IVppM5w2iHDNbC/9doI08FBXYj3XE6DBG2GjYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:49 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Mon,  2 May 2022 19:57:59 -0500
Message-Id: <20220503005801.1714345-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc67435-1598-4c3c-8ed5-08da2ca0154f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB73646CBC318C7996155671C988C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5bNvBecP9jWzSfKO59Hacsj2W4bMr9ilzseSE37UzXAOJdpF+ifkRV4J4CpvOrJ79OdPRXJThCyZSEI2kd0fjJe92ftegFmQ+E+r9Qa772XocjHgXT2R8DhoU2lmhE8SkmwO+LG1mpN4y87/0tR44CYnCfPZIUMQ3CFLwLesdYK+2nJKEUGVfPrVeueHrOwR7B2IHvdW1SkgfTXKFKLVxoN8XJ4HCjaxdeJzCXroY/QCT50Yrr/xWBO4U5+ZDJTFolFEgtkj+tV34cQLZyCIR/v4rUcH9PQDAsL/7OgBseNNEB4br+gc6Pi/aqVNT7jBwN3z2Zch75qzAybswhK4NpwLQEo+93672kAsyMoqxtFx949VVwWR9LVAESRbah8eYS20oam/W6/6ggQ5RRGnVG1lDkNOiKSaEKPXuLvr8YQwaIDXRGRIV4bPhV6IWb9Ql2Tsgy6yFzeB+uiGuoA3/H0fE0X8qZ8tcSSyPk0BQAzZnb+yff1unlClBhsxtA3Vumjl6EE/w5vqcdMkFbPHW8zNsbEF0dOvRdMRVTdgpbRqqKBZAmfz6+mNGb7qvQqBXWM968+Ey10OHdU8i52Pa/akOZ3H7WwcPPEC/rZUO9r1HL491Dj9MO9DdEYYPwbupx3DTHb6j2DhTtwSTE69o1XSh/8DGgyAAHObbW33q/5lrMAQ6I2Wcg4V/S1iDiKjibqPBxpo5Z5hf/LBDyOCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAReQ4v1LCczCPDKjW+ZDfZuGif1u3qdVJmyz0+bsz1xlOlW5m8bfrM3WV/5?=
 =?us-ascii?Q?aFKERCil/6i+vNAbplZEPXdqpVzt8DM4TUnCwsyjnjA0TDqZDTOZH6UKYeC9?=
 =?us-ascii?Q?jxHmjqQxBuIAnvNs8Yt++VGgnUERm0ipgoRCW/XUqmEEg1i5H3uZ0BWo2wKs?=
 =?us-ascii?Q?gE0w3qFZ0QX1irYyZS+PW7b4mnTVSw2qLprHQM76o1rH7uBU4sXCP+FjcB8v?=
 =?us-ascii?Q?CKsX9Twg/R9fMYyXTocTpFGonxxSi3moD3PoEcNpnV+xaybvO2L88iU1q4QO?=
 =?us-ascii?Q?wXrzwi/9fGAHYaN0FTDFSWpUW37plRzoJ31lMtJ+R+XoaQ4vZVmtuKjo+pkT?=
 =?us-ascii?Q?ChKMr9gxrVVot8xrNA546ghwm0LCQ6ALysI5AFbtOyQGHfvBfzmbRclz4Hjd?=
 =?us-ascii?Q?t94rlWqv2Fz7TUh5VCfuVkdi/pQ0TlMd1Ae/ephEkB2p61qGpxBwwhsSEI7y?=
 =?us-ascii?Q?UXjzyIT5WUtYO8jSebLHUol6NABRifmQOezcDH39yAJZk6bDrqig/RiE7bba?=
 =?us-ascii?Q?J2FVqF0xph/AQc6w6qW/b5D8w3SUMGbb1g+XmGRQLnpi2jHG6q0PhkTeREot?=
 =?us-ascii?Q?z6LXCtDtPoVHTxS+6v7RlZBn7s+HtDMhNJYwkxLOvMxWG+zOA+sKAxhvgLTC?=
 =?us-ascii?Q?VnEXR9EcpYi+NR8L2ijDNppOokdUxjQK6lTcoSwavKh5J+GUHjMG9+E4E1UI?=
 =?us-ascii?Q?Zn/i7H4UYSd8fkKGm73gMZ1mIxSMX/F4R5w2SyolX+EpCZuDm6iWDz2+lVyj?=
 =?us-ascii?Q?grRLD6dA7oHy+u7Bk8zXzhz/0jDFZF+JCSddTU65TM0GH99pIuDNZedVNq0f?=
 =?us-ascii?Q?JAM3UW5hCjCvrT/gIB/vZO3e/GGM2qj6DXaeWDZLchgKl1HLzjrGg1RaDOKl?=
 =?us-ascii?Q?w+WomIselyDZe+BE6xda5S2Q/fzr3fIkxaRDbpnKIJ9PEzTiS9ACZbZEyjov?=
 =?us-ascii?Q?X54m6xryQOhHEJLO0I9Sw9BDJ8DEd7wlVOjDx4qlLoUPkJlXRR8NjEDxG1uv?=
 =?us-ascii?Q?Z+5ESQTeI9BIrvHQp/WCwaQSBFB7Nz7f7Wq/0GXs9zpbJmLL5scYfFJ3gN4h?=
 =?us-ascii?Q?58qunj2R95bxThddWudHZb16hv2/kHnrC4H4zQ9/XU7LSPJpCI0vt5aK1HYv?=
 =?us-ascii?Q?KeT9Sz5ALL4OYvKSfe1LJLi4aYguT1oDfjmpucCNxHdTT+lQWqSKyeyx3KFN?=
 =?us-ascii?Q?TcSg0CjtwNIFKkRorD/yIWILtsx7qlM98o/h8Z9+Bk2hwIb63SyG/vlQkuC2?=
 =?us-ascii?Q?1Yakti4kPxLH+aCjc+ggVCV9ECSBLmZtQRzEOyxo3PfJlPDNisC/pnpcU4Oh?=
 =?us-ascii?Q?uFOK1Wuyg2Fv/MMWuyE2eBbTusIeV5MlkynaDWLOO29DAvAs86j2Cw9GlFbg?=
 =?us-ascii?Q?r30LS6gyjg6qujwZhzAhh2RCySjyBnZIGxN3ti5AsKPNCBRS98dWl9obkYfP?=
 =?us-ascii?Q?9fxrmG0ERNFHz6vlgrc7+fgJ2tYvUcUTCdqIooju9PIE0rYHrXTE9Ma+QqoU?=
 =?us-ascii?Q?51j5WxIibmVdL5bCQHjuDfWAkHvkyjSoedZZJThLl0+rr9kJEsLWIXWv4gtb?=
 =?us-ascii?Q?06I9ejfmzpk8JJOGaOZ93s1ZJxOEZGa86dmYfXLl/owRkORd5Rlj0uTkTsHk?=
 =?us-ascii?Q?hGwjL4Z0uxXIEqpZf0WuM1SQUIr/J7IFiyMSYWFnELHnHyHSeKunmAK3ZcAH?=
 =?us-ascii?Q?zhrWJECNFsijj/esztNKlIRV/x30/HjjFzqm5rq47v2H+mPQIshkRyubcoh0?=
 =?us-ascii?Q?NaWtSq1gdw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc67435-1598-4c3c-8ed5-08da2ca0154f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:49.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXF7Pd5sp1wJTla8ELzi5Uhd32hSYOjaDmCMngWtTWMQkkt56uTz+c74IyMz11iXXYx7DgJe9utmM1p1BIe13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v7 to v10
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
index c8b479f1d4da7..7baf16fd4f233 100644
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
  * @ll_wr_cnt		 DMA write link list count
  * @ll_rd_cnt		 DMA read link list count
@@ -55,6 +64,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.35.1


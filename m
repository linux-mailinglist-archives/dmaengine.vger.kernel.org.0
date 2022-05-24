Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17FB532D5B
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiEXPXM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiEXPXF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC6A0D3B;
        Tue, 24 May 2022 08:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDkzMbym0we38pCa9qjvtKvy291ief4x9rAj+i5PB2evtLpsICp80jwalYpyvRkOBKVicovJhL9LH7XfaQSXiEShArbLyXyXRQLq1fIbpVvk6D6mfDZxy2hBw1wnRFaBm05tRAMvBdJys41WGe88oDxQr+YRhFagl5ZuBrhDVTUwGg4FWS7HQA+/EBbEzTU4C9Bjfb/r5p0n0x8y3/Tb+3ZdHPrF/ar3mMgq4vWE7M0BzO0hnq9X6EL/fFFqpplsBjoeasaTfyc6urK773NSnsdGnvy5Q7RzMeBMFSsVpGD0FuKF+EJeTDbmFN0/5Yik1hD4YhyOatiYmejtH32k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aHFPqXCBqiH4vAnDWzIjxzms//3bONxbDu8UVGy21k=;
 b=QddPw2aaPbmDI00VMwwqUOZJ3iIQUUfMHbg79AqAzUtURFr3Zq5zOlJSuT1N+QR1NIhxWv7tbPjIvna5DuKiX6SsB03l3jfaKrSdvzCykjMDZJteyf1l7SOCffbck0umPPVJQD7tsHNbFtLW4LNp/duPEhskRe8lhEOop8HQ7w6NBAaPNjdfN3npUZxRfLynQvYouLb4rG2gRY6Lr9F7ZcTY5YiHBSWOg+DzCVynOYTKNHA0szQ+Vfk8P8CbX9hX4iwZaF6ndEYQ99Bym2lL3ehkd0VVR6H8agn05xWWvSEmDvnWJZgVDvIzTvnyxTrd+kr2OltlkgvuvG5Fh9O6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHFPqXCBqiH4vAnDWzIjxzms//3bONxbDu8UVGy21k=;
 b=CruvoJNLU1dapaq4OvmZ2Ne57sYdMnQJeTW+mwSu1lHNeK2BQah6zQUd79s5Okvqy0KUOFPxtclJ1C/q6Oew2acOWwr5vxF+EOngZOCRXRzHWa6xs1vpyRIB60PfRamkoBKp3qgDfU970ZK8B9bUHt8d2O+JS9PcJV01kmrhE8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 7/8] dmaengine: dw-edma: Add support for chip specific flags
Date:   Tue, 24 May 2022 10:21:58 -0500
Message-Id: <20220524152159.2370739-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe35b2f9-7263-40d2-5f3e-08da3d99424e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB567235B404DABD86C1AEF46A88D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDWDnE+SX3Lh8vUtOPOw/mzwDbMqTTMUU+ZKJ3ozCCywPPo6SIq5OWF85M5rDnNpnDyyebhg+81i7khC4zpW/4pskcZd6T6Bo/QhPZYGdWTBhqfT4bkovteYIXxPjUQZZgtxPZi0n4zeV/SRXkr5c9gJ9wOG0ml6B3LQYUkBM3+wqMO5pIqKp2dhxeLThnHEV9KzrIHwClPURXn2whi5Zwz38ajIC/k6ydmrM7jQ8EFPpJXpy1da4QKJMGtqBzsn9J3NOu98vt/0FTEZqI3i4GpBwirawzlzrqldXgvLGDDXDnxy/FKb6m/7lRhlR995QUn1eCb/2FvOKjmQkGEsE7WXsozpVdF3OyK6JXkREuBaxbdh3ZW/7Zc+DSh94wmfD6CPSOxu18urKHJKSKrkt+64On7E/WxA2wOYq0fjKHLtVpeq4Ni4LrOel5jYif+A7WUdc3EkxOYwLsegqGqQ75QTWXP3q2fL16Chuxr70y48SVrSGq7R3HMnqqB4L5i9Vg3FFch6iNgYRmbf6eKeqih0av/J8YkDssrUL/2mWtbXqHzZ7cwdMZUiAzTHwZo4Gt1uBInUeuuLyt6VTySuY4Bvi23Xb9yJJ26M0L2dZHkaMicssxx0/2R2rqnfu9XzRDLVSUfzTLxXC+xr/LpeHzcDVBIz+XNK4cWFJXMmVbCob1NZFkKEe6zHn60UxsU/8zAQ0bcd8MwWkQPBtv+V7wzOIK4IlwEvugB+RMjjQWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(1076003)(921005)(6666004)(36756003)(83380400001)(2616005)(52116002)(26005)(66946007)(66556008)(6486002)(7416002)(86362001)(66476007)(8676002)(38350700002)(6506007)(316002)(38100700002)(4326008)(5660300002)(186003)(508600001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdkg6KPWoXVNYZwbHuH/IOmLT22KorsJr/0VU2rQAkEd0oxVvgWQoeSnOeEN?=
 =?us-ascii?Q?AiB6xoQlw/htWn7k7PwL5ECjTYeeEphlMqDvt75685K+jvK2eIrgeMjgVF3l?=
 =?us-ascii?Q?3z5c/lyusKfy7sm8qTMDo9USzRUXivXBpw+YsTgCXJXXPHbxgIDjUAqmlI6b?=
 =?us-ascii?Q?4ufHgeg66QP058n66nHLNA4caKmkJ66wtj00cdzM/9o1zXDSxNa/dx0aNY91?=
 =?us-ascii?Q?6vE8qckRt0QoxH6oseLAEe+IemPSlWD0BMq+BKtF27PeXIB/RPpIE8kNW5a2?=
 =?us-ascii?Q?Y1WQMwy/Xw4gfEqx+PE68E/mKVBZyukT68m7C02P1PYuAXIGoRe9oSyBX0rY?=
 =?us-ascii?Q?ZVvBEoOcWTeaXvbZXsERj5Z31hcOZf+4zDvdj4Avm1du22L6y+Q4b+nugrx6?=
 =?us-ascii?Q?oQQWX+bLfl1w3HYZroBXeBaerF5cBvS/3CUbzVMPMx3wyEh1wrm9Fn5XpnwI?=
 =?us-ascii?Q?qZXLO5Q88ueEeq5aL/ye/MdKSf9nYcmI7KBmy52PZL+Mo6rDqgnl+W7Qnd1J?=
 =?us-ascii?Q?D4JopEYf5zqJLV/qGcghEeoeHepD/iufVPCWuT5nl6fiikuzCBrdjOJVcMjd?=
 =?us-ascii?Q?VWlvC4YHP1sdT9Wq5tZpbiEqUCadVL1iGBpmu6s+v1kc83LP3C4Rrk+p+oga?=
 =?us-ascii?Q?wp9dTe903GlUZsASz+4eFy58PDwiiYF1CM7e3GBQRw6M48nPDBOHBcLAFBqv?=
 =?us-ascii?Q?1zGGlEmO4mZMYSAApsG7mptxs3fBsyFwklFe1lD1bLplsHoW7F7rnfGl1+yV?=
 =?us-ascii?Q?ylFRTMW5jJUFZdyM7SgK6hkW172MYZmckK5piaacxM9dLl6k6LDGtox1QOQO?=
 =?us-ascii?Q?JikRujrTTIXQ/v9t+q6akY8S7a05RaSUBu9iNA5ftKsKsYS6kFPyQVLSCDe4?=
 =?us-ascii?Q?30M+WKt73l8SWNWYJ/h9KSk9Dz8b0+BygzFc+EXZandFxGX/uUeIjZMGkdXP?=
 =?us-ascii?Q?gUT5YBT9opMOIJI7P3yxjnAqbwT8PdFMhwYhleL9P/98xWX4B/92mKu3Jcnf?=
 =?us-ascii?Q?vdiGYib7mQaydVrEZztQ+i27vQMgN2eD1C7hvgDF2ti8DdVZz3iw7TbaYzr4?=
 =?us-ascii?Q?OkRglw7z3Oib+MWLInJEOz4b7ocUk3C7G2eB9L+g+co24Pu6Yxcq8Hl0Vulo?=
 =?us-ascii?Q?xjjOmb+/pE/4kBOBYjtFU5eAN1A+Uj+AjC9ZqJqQIo09bYdXGpYom2KMlRb6?=
 =?us-ascii?Q?ywASMLhsPK+8qvmbxupvypC2ETNmROygtjLsjRa123b660MBbIE2KzBBqDDL?=
 =?us-ascii?Q?SLlUwa0uF8dh1Av8sFxsE8FRI2KOF39ID0I6aZe2Yk8y+8QNPl78vD3QM1Dd?=
 =?us-ascii?Q?bAKtIt5iuUcvPOqOf+WxQxVSOLKyZxhYaMwcVoLZH6IwBFHOWhYraUN+YYHj?=
 =?us-ascii?Q?2lJjs/O/GIJgligIoRoCfl32MBrJKEU8m00OFOeJjl/WXqqtRvvP2phgNV3u?=
 =?us-ascii?Q?iJ64ul6syU31HnY5ocV1k9OElw/nVFkSnIwmlgfbPpkYXADXDY0+sd+yDEBJ?=
 =?us-ascii?Q?BHEwp8EKTv2Rl36Mt8tVaNQSi0RSWDvyawxoE3v7THBY0hXzYJfk/48Y5fQ8?=
 =?us-ascii?Q?+96v5SxmMvrkuE6S6fL8l9uchO5o+jiK+esWJyBwNymnRauhKu6eVCbHNnIJ?=
 =?us-ascii?Q?6v7dbUH1sQniX+C2QhFaRBtsa+zEeoAWp4Mque+zaDIUq3Q/ui5OCsJdab76?=
 =?us-ascii?Q?LdteQ0r2LvE24i2HkbM9LOV5lEQca3RHoYwWxmHXisnYV/uLCsxb3rUcL3xu?=
 =?us-ascii?Q?RufL27P7tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe35b2f9-7263-40d2-5f3e-08da3d99424e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:48.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QlM7j1/SOzxXSBrjuXZBr4tanFobpnNDQrjEbMqyBOWibmlTH0RlNxDhOofBTpRkceQGKa9izvO/znX0qcG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v7 to v12
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
index 403ade40c1b1b..607647dacc291 100644
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


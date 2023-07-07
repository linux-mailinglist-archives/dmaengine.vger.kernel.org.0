Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36D774B6B6
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjGGTBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjGGTA4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:00:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8A124;
        Fri,  7 Jul 2023 12:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On8AGiHRlx6GIqzTMzO7Ld/iZuPt7VCwt26m3gLIQFmCfAnV3tSI7MJZR9MyRta7a4xFFcnIfh2Kh1GHiA1ZAF2hrthVGXQ/ofEj23q7u2IAZpBWejn5v2dENimpUFipd4QYpfwggebkfhKyjnX2J9HBdiNom/PNc/4J/akahzCVpSQTkhIJQDKP0Lx8etXhwUdDNU+e1ztPSVqxhF0qZG1IramlnbiyENhNl5H+SzWGLcCauLv8BUf8b6mwDYcgrBqYoXpkSL5hPReJx8Yie5o0hYMwZQipC17c84CnFVQ5xeo68889Mzx6KlE6WgecRZ2NtwVcgVIapLbJ7/DYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZk1c8k1FJIoPWbylqW5yBsHWcRGzoOxvUatOi3Yo/Y=;
 b=mnQn4x7uBFcJ0ujq4YLF6a5lHdvbvEa8/TIE8WzYd4kOE9iecjjCVIxvBrAvBxPJeHnCeeY8lhUotpUq97lf/pbXWNxDao7ZQIZMJWXiFeWBOEyUHZdj2ueWwmUj6qf/SLIx0yTqgkFWUp4Sc0EDaqNPYlvNp2UgUN/zeA9UNjYeyr10ixHb3+ATRm3560QHHaLF9Xd2d/Tbc2bCArGY0Ii4aG4FPY8rjKRb15ZAtJPlNcJT40Lt1qcr8y01bcJMi/GLHOcn0aTfWPR8aXRw/XwgHM4rUQRmRxbFNb3p4xtQ2UINMBf6VdS4eua26lAnhtq7Xid9sYUoZcYz3+Nneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZk1c8k1FJIoPWbylqW5yBsHWcRGzoOxvUatOi3Yo/Y=;
 b=bPQcZyJa9/DWVRpZNsBPR+1Ycmi8vljql3d+xQdxcRcrFndJWlDM9voEzCvzYnc2o7tFB0rP4CmeJ7KOrlUgMcQ8meRNBLziEYheYnBx3WdyCCUPV/1nJYPYs7Js3i3wle0qyNFuWxDWeK2J8xM3xwpywP+X1Sr/ruqjY0gF1dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:00:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:00:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 02/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Fri,  7 Jul 2023 15:00:19 -0400
Message-Id: <20230707190029.476005-3-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 632fa99b-6bb2-4c8c-f736-08db7f1c7d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mv5gw1/rBT9/o65nud/H1eOfIa5C2fo9D4QYXcwybLVPvcgGcuMEQQRRZ0XgvtRYqRmAmExcbJrCyhjxN22TrW54JBZUampVc1iaVNztyjLzmU1CTdGyJSxqp0lNPCXviSqDwkxcXxG/LG0nBTqB+otu+MBaPCCH2y4gNupPds2PgjfQXpeIkXZYTp8PczjYZBknUwwWyavzIPjB7bBAChwatrqALtFRs1rUANOWLCe9+hLa/c7149Ajg/rB2lAcD3CdHYG8Bp53SlMXfwre0rLq4ARWCF9IuU8uFRXMYrejDU5PLuuXu0iV3eLYs/Gi/VCc/4NtYFtwLvJs3LgcWVPjoLt7XF6oy2eRc4VsgtaSWjQVvr713qGDnawsWLK6t375TF5fy4piu2dNLEvnolvytNl1kSE5fmhAT51K8HsNvspPTYdBg67HJeM0zG0igwes0SyTdueAp9dJd77FPbuutWHEOkdhOEjOG5NbMD65NJkxi2MqGo0ORzV7ma21sj2GlY5r+9k0VuyUPNndbkxJBW7IZrwSx6AxiY7vOoNcRJppObFn5uPLeLxI6FRkCIhWqN9mfkPfLkLzjOrhVeF084Axh6dlYXVcrpq2S0dwCllUA2iD/vx+QRy0KIpc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgwZS4+7gfZrROWaTSv1U7v1J3qU2yRQHHILYdcbpXR7lCRsjQIR1W/ncy75?=
 =?us-ascii?Q?BH2zcUI0l0uGZc120ISfdvrydm/CVR1BOmgPAI/jRQBntiCL9xSoK43mRU1l?=
 =?us-ascii?Q?8kO3S2rYNBIDMgN5iZRHOVTtTOCKNcw8IMbYbWnl3HCNYDFKE1jIL2tRPg1L?=
 =?us-ascii?Q?YWCoMiEgpudBQmKf/itgf9AB7BOCNpvjM55PNPNkoe/sBjvF0eV+GtPm2Kvu?=
 =?us-ascii?Q?ktvUWq5/42gVWstscI0SnImyeYKx6QIiyXF3PjDcQctCUkle+5a92UIbRFRr?=
 =?us-ascii?Q?0I5YmGYzUWKL9WICLPo/+QJmokKi4wyQsi9upg9VcVQ2CQMp9pF3tp1c9QHf?=
 =?us-ascii?Q?s7kj6rwb3tMtBUgC/AcHk/+97j4LFKBO4NvHpuqyXi5CsUDNF58qgXSJmAp7?=
 =?us-ascii?Q?w9Pt2tkILvYTLwr4Hw3dcRsMMCFJRz/7NQ2yi3bc46pvejS4jpTC23mV8yPr?=
 =?us-ascii?Q?sWb3fnXJ94sm34L2KXBhOFVEThtE/rg6223VJ/pcgSSXJtMwecxXmxngp56V?=
 =?us-ascii?Q?W5CSTTFvNdIzpCvbEJUKXhilkBE+wIJHvMgdq/GcYdCJh9qcsd03jS5GxU5F?=
 =?us-ascii?Q?H4Dq8Q0KMhlNDMqeVAf4oW3C2UYiEbqLzr8rJ+KMlEQ36V3dmeuz69SdZoBy?=
 =?us-ascii?Q?VUc1Ed11FbdKRXZe9GgS6ioaxNKYfd8jlAeSeNTwGyrINMUjDDhkjS3GpC6+?=
 =?us-ascii?Q?znYCymFYdu215TX2D7lnsd4n8CS2VE6IUNy8eLUOCgf6qAbiLOcRWA1nbYYs?=
 =?us-ascii?Q?r4DHOymOX+4VTrOMx1F7CUK5Ni40l7RylRahz+393vH/++292Cm53bMrl0P0?=
 =?us-ascii?Q?4yRw4eYRQadNMlQj+PzliXQ2F77VwKPdaLrpmlpToMkqoJLcxuvvmLut/aDa?=
 =?us-ascii?Q?+yJHGCkNe5OUnnLsQsQpJjZs1Gc8/lLGQxDipMKUI6FvnEznqgyaJH4Ps2Qi?=
 =?us-ascii?Q?CeBQsGCrKCsZbh0a8AiXCQ6Ut+BJ3tfxWoOq4C/09JNJ5CGMcxddAD2UoB4i?=
 =?us-ascii?Q?Q8Jz8k3WfajgoOzFPDacUEoOYzSpnWFFToAZsWi4NOm943w+ic6uKJUqWmKG?=
 =?us-ascii?Q?QhH9wZAeJ9Udi0SvAMYy4lDlTAARdOK+zcwmZipDqdnWUpmGN/l1fXeOcJ2W?=
 =?us-ascii?Q?WzkNZFRz7b0hz7hnFZAZPYqbQNju/02LUu3IRZxrXt9LoN4ACdYuyhj5i/x/?=
 =?us-ascii?Q?00VPP2UJnJsF/b4kAyXKPoqnL+dU/zONDcZ7bTmU10E+C3c7dFbbhH9ahS57?=
 =?us-ascii?Q?qIpjK1ASud3G5xv3Jb5TRskmzcW/3eEwiYvHpPx6313exe6TLK0F6bcFHIiw?=
 =?us-ascii?Q?q8nhcsJqWUV7wkDLXjDKet17V5UeNjXoCKIerccol8rAJeyjOUi3LyW4CoUX?=
 =?us-ascii?Q?56qIaWjZnaCXLbhacRhhAI1IUNGeCuMA73nzjvpOIEHyIVgf9jpW6OEGkalC?=
 =?us-ascii?Q?GH7ZdgwK/ru2D8ZeeFrrLegn/TzFuvG6+4DfL9YwMev9rS6hzBlMSElbNTvl?=
 =?us-ascii?Q?wt+R14D7PBsGQODIqRhgrNf/HO/KH3bEFl/XvAAXQlNSWBb76EVGBPYMLhuW?=
 =?us-ascii?Q?xUL+KyqbXJZsAWhoq8A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632fa99b-6bb2-4c8c-f736-08db7f1c7d00
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:00:53.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLCLfItIB0tYfzd27w//asmqF0pA4+A/4AcxVyBCRWQyhs0On7oFd/HVNXF3wlHwxlZ6XNslvtOxoedPlv3opw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Exported functions in fsl-edma-common.c are only used within
fsl-edma.c and mcf-edma.c. Global export is unnecessary.

This commit removes all EXPORT_SYMBOL_GPL in fsl-edma-common.c,
and renames fsl-edma.c and mcf-edma.c to maintain the same
final module names as before, thereby simplifying the codebase.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/Makefile                        |  6 ++++--
 drivers/dma/fsl-edma-common.c               | 17 -----------------
 drivers/dma/{fsl-edma.c => fsl-edma-main.c} |  0
 drivers/dma/{mcf-edma.c => mcf-edma-main.c} |  0
 4 files changed, 4 insertions(+), 19 deletions(-)
 rename drivers/dma/{fsl-edma.c => fsl-edma-main.c} (100%)
 rename drivers/dma/{mcf-edma.c => mcf-edma-main.c} (100%)

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce29510..7f3d62c9dee2 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,8 +32,10 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
-obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
 obj-$(CONFIG_HISI_DMA) += hisi_dma.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a06a1575a2a5..89b0d09c13ff 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -75,7 +75,6 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
 	}
 }
-EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
 static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 			   u32 off, u32 slot, bool enable)
@@ -126,7 +125,6 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	else
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
@@ -155,7 +153,6 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
 			      fsl_desc->tcd[i].ptcd);
 	kfree(fsl_desc);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_free_desc);
 
 int fsl_edma_terminate_all(struct dma_chan *chan)
 {
@@ -172,7 +169,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_terminate_all);
 
 int fsl_edma_pause(struct dma_chan *chan)
 {
@@ -188,7 +184,6 @@ int fsl_edma_pause(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_pause);
 
 int fsl_edma_resume(struct dma_chan *chan)
 {
@@ -204,7 +199,6 @@ int fsl_edma_resume(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_resume);
 
 static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
 {
@@ -265,7 +259,6 @@ int fsl_edma_slave_config(struct dma_chan *chan,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_slave_config);
 
 static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
@@ -340,7 +333,6 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 
 	return fsl_chan->status;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
 
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
@@ -520,7 +512,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_dma_cyclic);
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
@@ -589,7 +580,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
 
 struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 						     dma_addr_t dma_dst, dma_addr_t dma_src,
@@ -612,7 +602,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
 
 void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
@@ -629,7 +618,6 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	fsl_chan->status = DMA_IN_PROGRESS;
 	fsl_chan->idle = false;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_xfer_desc);
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
 {
@@ -649,7 +637,6 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 }
-EXPORT_SYMBOL_GPL(fsl_edma_issue_pending);
 
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
@@ -660,7 +647,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				32, 0);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
 
 void fsl_edma_free_chan_resources(struct dma_chan *chan)
 {
@@ -683,7 +669,6 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 {
@@ -695,7 +680,6 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 		tasklet_kill(&chan->vchan.task);
 	}
 }
-EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
 
 /*
  * On the 32 channels Vybrid/mpc577x edma version (here called "v1"),
@@ -743,6 +727,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 
 	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma-main.c
similarity index 100%
rename from drivers/dma/fsl-edma.c
rename to drivers/dma/fsl-edma-main.c
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma-main.c
similarity index 100%
rename from drivers/dma/mcf-edma.c
rename to drivers/dma/mcf-edma-main.c
-- 
2.34.1


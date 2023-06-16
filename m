Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C97334E0
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjFPPfC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjFPPfB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F4A2D43;
        Fri, 16 Jun 2023 08:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kojzKMBhD/0VINxI27+lKOaxQPOqSbpqtHMnw1Mpt5ZnNcs5zroaw0g91A4/r/TISEkWtmrxQxLbBQIYd4ZaYCciBzuA2qoGite4E5dJ0D55F9nLPB0QpD6sUqhUJ/Cmqdkred1pUQYxfCik9y0SRLfR7qbZHNI0rhJTntKptvhbAGF8ghaqP5x2+0lSrnRq7rOpNUi7T1PEkwGrxsFr8i7oMhwx40g4YVzAoA8EX+PTyI+eejc34fWHFVw+ucwMMaja5HRUP13dmkc7TlEsm94V5ighK5T+DdaTRfvBI8o/+4+v2BU5KGX1Q3mR8Pg7ceX9uk937WVn60Gl0WvtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=ceUL1r0QOP/uDmGsC89/J6MoNqMw/WpXOuJbS2YQVnftixCEOLdm6P2TUK9ZzH2Ea0serfRezfkstmfAd/74MFylumPZfkyDu+G2kkGZV7hI7ZKgc7ETYsV+qbB6Ci+wcRkkOeG6fkrbqHxWrL6yx2osiNMi5RQveaXoUitxI0BmNx57DkJCvsYB38UMGVjzWWWfgXV3nwowB+QQzO40DFNMLlBpxjOjI+OBTLVJg95tyUK4SnfoZVTAXvZBV8QhSAD6bY8NXSU54jAwBGQewAobnl+aJgTAfkoaJzpmWSlhfkaDKgsNt2KtgxgWyOTVRiwJx+INGihDZ2VPRtahWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=qeRKCRIjqFvOhrL2dLbxQ2nvy3mROeuBTN7Fc3wxm3wOPZYI04GTRWLh/p5mMQrpVEkHMIha77CnKrCADm8CTQoj45VOOEUCt7GekTAEQ3c4ZEy7ErjY3DTYX5qZ72wr+G4b7dvVupRlNu8L7Z2Byf9eVI0Srds7bQmOdDkkazg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:34:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:34:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Fri, 16 Jun 2023 11:34:27 -0400
Message-Id: <20230616153438.2299922-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fdd037a-bf64-4c7a-7342-08db6e7f3e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsDaSfT3gdsc6N0t7z9/ZbcHYu0TgAheqPy4Sf/flMu5HWJPnIhcNBaSad0nKfvMr/homf34CgCa32tnLAZ2JkoCsvpdUAd1U5Fu4oAk5OTuG1Ws7JQ1FFUCsQzXnCJ6DSCGFTjHC/mElRiR/yl5tTYF6GI4IZmkrIi/jhSG6o8+OQjop+4yRxyLlq2ar7FnUbUF827CCXaXgUR2h7KLiQNKux0jkqcyOFoqDONqwnGdDeO0mhk+A/3Qd6Wys2NHolR6t83zJyZ47kSDpj6i/PqZ7ips1dsf1NQH3hCZyDMwV28MGcNKRpJB0MTDfAe3dx0wqIsC3KhQZyrK0UtkzLo8Pd9uTbyegT4rwHhpSBfVGh7LU23KlN2qZq8ypRbnXi7TPjSjhVDW54BP+AGiSCWPgVEUdE6ddCvSbbz1nMKGFqawKoQOaLDWaIXlqRN6xD7Dlf+wK+aHw0dlIh0EA2yOlSodOWYfbKjkw0j5GR7ZmYyHZYQR8ThRJc3T5mVSpQC8/NF+/cl6dySdvslGwPKICZQx0zfiDvNVl7TTn2n+enpOVI5xEhQC43gkN3hqUY3lPojMgNwZHzX6IsBFn3iRFj5G/a4WkJol3mG8Z/FpCI8dFgDFrRkYxm70t+Qfuvj8BXaiSmbEAOA2r1lv9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(186003)(38350700002)(2906002)(38100700002)(86362001)(6512007)(1076003)(26005)(83380400001)(2616005)(6506007)(921005)(36756003)(316002)(6486002)(66476007)(66556008)(6666004)(66946007)(478600001)(52116002)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnoTYhwtz5Ix8P+VMXzQBxVtIzlhVE6Cmd7de6di6e6yfF+lPTl3JosZaMCs?=
 =?us-ascii?Q?kO2PUeueVE190AIgVGsDQmjCQnPtpcjlf0C9E2rrZ4AHOfkCt1J00w7BS8T/?=
 =?us-ascii?Q?203UGQj3SWBwmWDJjD1Hn7g2lmFQQSjoZ9J6WUZ+MTu4Ynf19ug8rILzIr75?=
 =?us-ascii?Q?UKcCzvgQjqpAJNjyQ1FPukY4JCK2KC5pW7rm0njuFlA/hpyc7x1BFZsZY8fq?=
 =?us-ascii?Q?Q3ryhBqK3PrIsSIE2WOmATwrnD+gmIH89U6LQr8DApjkRWIQf36FJtLdVKV6?=
 =?us-ascii?Q?3y1EOcQ5LUBCYnjyeLImbrcFaNwrZm53tKVwWXcTI/P3mrMS7klPt/qMB3Ci?=
 =?us-ascii?Q?CysuImfUmdTCNPPsTIHKIIU3B6LdO4SUgEv+t/IRdjzHHWED39k+5xrfbeVE?=
 =?us-ascii?Q?Xm0ZVRsZhrQXEb5ph9GTZv9bMYHHKwtUdIinPb0sVMtnr/CFSYqyFYePmd0k?=
 =?us-ascii?Q?Bq4OZjsy54fyoiViy1wB9JqU55xx8gu+QukSGrFwO2yl7jyzEhs0XdPb6yJC?=
 =?us-ascii?Q?qDcVHfMFieVm1EICWpGxJ3umcr2xNj6n4/DIPlqEghFCNeohulLNArtr4z3H?=
 =?us-ascii?Q?p/zabWsSqyCNYJD3BQnAHJpdgAJzz+NqxaUV6/KMW/rYkF1pbBGhAizpNqzG?=
 =?us-ascii?Q?6nnostfoLI0Lcb/z90qHnyv9W/ubgZyTH1BVMMxX+rKCmaEq6CBBJcAjtex8?=
 =?us-ascii?Q?mqfn5SlzMhIACS9jH9K965kZg9fXDM2X+kGhVxfMxHxGpwb01W580xmf6KIe?=
 =?us-ascii?Q?i9xaVlBiCcjyifPMsovQOshCJP9CLr1wQpOOYmOWR8XLt2zcZBnhd3FbSS+I?=
 =?us-ascii?Q?9mNo+LYCrPFmNkgj7y5QX7C0ItMI0eAiet4TYEYGmcZkOVO3f203Vs9ZQjuT?=
 =?us-ascii?Q?hkSNmSzbtRUw9l/IfRkwqOvqixXZWGZCaAX35d7/ju0o1XWKtOp0tOlkUgJO?=
 =?us-ascii?Q?pXWswWcMxwR3MKYz8RNGIZQPUdbhrPhUBdKfbXzP0Nku44OzadxVIu1FAO11?=
 =?us-ascii?Q?lV4WxohGgfeOpScmC3nILeEf5tWqcQO0/xecdsotfFbfkbc1v9X2L82499GP?=
 =?us-ascii?Q?MrqMWrjrdptAw8GehLmM9nsg4QUc1SILbPSS+55tTCZY1EVizwYEyp5OWG+6?=
 =?us-ascii?Q?2ZWFz2K3sQiu1oaZgGnvibpcwhhKhWWaoDM5KkJN2DWMER5bTrnRcOQun6vo?=
 =?us-ascii?Q?ShyOINRMT9o0h9PgPFx1C9C0EdWTjWWcJCSHJ3N73Xe2AUiabNfr8EwlPzCN?=
 =?us-ascii?Q?Y3AYBCk1yBrDLx//JnOVNDFsAOeJRkbDXuA8A7kxAuMLC7M/yEWuXqv84oS+?=
 =?us-ascii?Q?Iw+DNoxEKaqmZg0R31LK9CqDomBQ64SpEIwabqatibyOpV/Dga/9VWBKJXO5?=
 =?us-ascii?Q?HBD8nV2KZSYsd9y2zA5mNIK7M7ml9beQvCe63CQFqWy77mjpmvnckjrKPRVG?=
 =?us-ascii?Q?4otnJceCCgLwaXk6BtVkTsP9v0EW1KS8zbWrAn0HjYOEUCCOvybM15Fx9ajN?=
 =?us-ascii?Q?ANA43lzEps34wVmAKK8lpnwVsFNCYkFdYoL1NapX9QIyAgD2sDAWM+PYPnx1?=
 =?us-ascii?Q?JcvMmxfTXWP2lMaglZk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdd037a-bf64-4c7a-7342-08db6e7f3e18
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:34:58.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUwClB6AXRNZ75OmQ7y8nYCmzyvYhwno34dHMt0CoNE8ibAMYLeS/VRbd0IA+Q6pMveDAecxdN+ZWqH4qprEbw==
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

Exported functions in fsl-edma-common.c are only used within
fsl-edma.c and mcf-edma.c. Global export is unnecessary.

This commit removes all EXPORT_SYMBOL_GPL in fsl-edma-common.c,
and renames fsl-edma.c and mcf-edma.c to maintain the same
final module names as before, thereby simplifying the codebase.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/Makefile                        |  6 ++++--
 drivers/dma/fsl-edma-common.c               | 18 ------------------
 drivers/dma/{fsl-edma.c => fsl-edma-main.c} |  0
 drivers/dma/{mcf-edma.c => mcf-edma-main.c} |  0
 4 files changed, 4 insertions(+), 20 deletions(-)
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
index a06a1575a2a5..ce8d7c9eaf77 100644
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
@@ -743,6 +727,4 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 
 	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
-EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
 
-MODULE_LICENSE("GPL v2");
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


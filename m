Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7F71A08B
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjFAOle (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFAOld (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9036E7;
        Thu,  1 Jun 2023 07:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+IdwpboZAo06u7I9rQzYpSVkQyzXmnuITDP6HoW+lm9k7J7nwTt8uRpmpbq+B2OJCw2tJc4ZA0Xt43LY4jGgZKwPOJv2q1Gur4TudWDE8haFZ34nmflxNWU7mvTUWF2ea7RHHO5iN27dFSGIPlCm8lP4vga9O6KQnZ7LydTONHTvLd7OM2W90uYAaHUQNNXB8OKL9ITebeQOEq/fYbWmwKLHcFS753h/TX/3knSYbgeIjQ6u/YpU3yb1jbPS0OfzMJ0zxCs+6h1gGSmzTFpJrVpqTgpddGLWL3UGcLM7sOKuVHlEnJG3IP33TuCpb3p2Jnz6IkIJjYk4Tb065943w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=eIP8G87GeBavkI14FyxrmTeQ0S/oagicFPdMZ08p7/jfkSxwuFm0bog34ADJRWjffkTajFqu+BbyEbsxWfweJlmr/k1lyHajQ2m5nLARJOPuIbUqGsi6YJghnPqPKJP+naedYkimLOO1jsFqpPoswPpAcqjHRncsP56x0LXfjYpec7WLNYVT1qpciP7GViLg+GeW6fhvQn6v7Kd4ENmmb1whjJZA+43pHTNveqrvfzpf07/1i8CPdTqgk/qA09WPXJouT9BvcKaAwnW5sowveq1rPG2Jnei7hKcWZ6SAo+t3rGE346Y10EAMdPP7TbQuCC6MqKIbuDLbinGa/k0Ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=ZlrSDChqVZP5od2nb9vtBm5CVNoMN+a1YBgOf5VBRgnbXC09lowWrOYGhx2kkit/dfO7uaSSfOcDQmEz8JUEZYMSHRPKRpbJdh5BgSyrLB4Z5+zovEsiCF9dUowwcy2P9c0W9qhKli01CELVn0LDQsMEfoKUL5WCDZpvWDAuFI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Thu,  1 Jun 2023 10:40:56 -0400
Message-Id: <20230601144107.1636833-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ff20dc-067c-44e4-8fc6-08db62ae486d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLg0EZyhlK3mOJMvDlQjz3XA0kOaii0MM+DGzyHi2RAvjveEhtpX/nu1cPe9u5t2Gwevwvlu5ZFJ2jWLt31EALgyrhANA2Es1Xh5rVYA9x6FnnmGnCL3O9dR/9DiTpaZCdtpzpPvxCAYvCPd/MslObg/Ftr17T5ZZ5/OBZekQqUIn+6jwfH21/nj0zueSdSkDZ+pRI0FPSIYVDQapl2Y7d9CRym6ChWG+kX58pnkRIsW+B3L8SVvoJ2sWXUQ+f8jWz9joHL29iHZYna5fwmMWiHAzwwCQZmot8npDY6QrPEsHYbdRmCfOOE8qvOKAaKLQ6HVK1nzZ+PLY/S2iy0690jkyHbrxiDbnwMcyVhJl3vv4kHTjAZugKxqqvIFyhsZdT4/10UXPHwdhEAffjGfejPQciuD+IcD98AdCnsfAqyKY/hdFtncW6eppUWEWOG4SwlKgTwV3f1b3ve86jewW1iVE1U5wrsVwlROyllOy7P3yxsVKjUIjOBOYsYjVlNK596EpZUTaVDx2Sr4BuIATJountzBV3uWkcOuG9NyV4/jfUdqFqwGFkhuvDvC7CWUZsb7x3iiVX2YGdIEapBDq6L0xAS6kP0R+QQTlG5v/UTTr3nvm+RfAWmBSe6jIiPFiQyGag/yipHz9ONZDM7h3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ICHSWQvsbXQaZOVCIFLSKTD1ZiqoAxHGBNvMOzZFtrtkiNv43Jba2f1i1dy?=
 =?us-ascii?Q?W5W3e3lqkwE0ffmDOfaJTvbu1k7S0eYAOGJtxiVRDhSJl8bAKfXIZm5MYSML?=
 =?us-ascii?Q?VZ1IZLHXXAtk50RoZyfOGqVPfwvTxQfiO451d6ErS0vT69jDBV/QF8vF0y4A?=
 =?us-ascii?Q?fC/aTzQkBZaAAckoJoneGXbutn8bPDqFSQYZZY4IXM6JlNquqU5qnSvjPM9a?=
 =?us-ascii?Q?V5RqOz6+GDf6YBdd80pVR/GLv3U9VKGR2bspJFi6Jl38vZ3fz28bldm9y5u6?=
 =?us-ascii?Q?8xP/zeC/ulGub2EYqhJGrIS+1uDmOB/839R4gnUTAXDhmoXgHWvWBNh55Duj?=
 =?us-ascii?Q?Q0jAl3mQ7QbNJz33gtdycdiOLR6chfzGJwOtput+Yw0Rc6PjuZ0ghG8Frpt8?=
 =?us-ascii?Q?t+Uf7Z8LJppzc/WSkwz/yO5lNrkCKjAPmRJr0obLz827t/QLKj0L1wmhtS+h?=
 =?us-ascii?Q?rbj5SxwBbk43PkWKY0/WfQsMLImB0spCLcufBkgKixo95FE1cXsz3AhwxEm0?=
 =?us-ascii?Q?YpNUvbdFlb1R8AOYcs/pNQToufLMIfwvYrG89H3J+8Xqz4v7T7t1PQHbdZtv?=
 =?us-ascii?Q?/5T2V2j/U4TUxUtRS+ap7hkUSPYtQS0qB0omzh9Zm//XNSEJ6mCV4SOTkj4H?=
 =?us-ascii?Q?Ugf3KlfR1YAz0jTT+dTshdjz4LvVNmciv6viVdk5LwYw73A6nkyOKtbHg+8I?=
 =?us-ascii?Q?kDkpSm/dyBkGLSeyLDR2Z/qVVNtFSDpewdILfCk+hIsggHlCz/P0MRWfv4Ip?=
 =?us-ascii?Q?BDCyC8dVng0NcyHKS87SEzf41a13KO1g/15hhqchSMPkGm3kgzbfgHRB5Cyk?=
 =?us-ascii?Q?Gog9Z/8RbOF6bVehzkb9Dk6q/YM504BpURJhya55t0oYLdJwZaDHvLd8Z1g0?=
 =?us-ascii?Q?2wkEHTSJ4O1uGOKwmMchU7juw7/Zwrp2+OCnSh2CacParLtZ1wpvSMWgRAwS?=
 =?us-ascii?Q?Zz9tRenqyiWzvYggGlc4fQPTCKaqFv86DCAGdLaenV4+zC5n1tknnzZtbpo5?=
 =?us-ascii?Q?yfAeiVT/G0SSotBCrHpFd6SZMOO7pU6ObFAi6YsC07pDlkga0SqI9L+4isdm?=
 =?us-ascii?Q?YQ5eeyHZp1wkQBWuPWQVTppFoVVSEa/CInifg7PtvluXqRn/Rmcxi0WNHrnz?=
 =?us-ascii?Q?A2aZGrg7CM352YGpQ1LC8VJ0qFcwdTmu+/1/32rzGlNAzFffjPvmDu1zfg6l?=
 =?us-ascii?Q?lpY7xEXpA4FHyPqa4B16Q2+jSn0/vjqsoCh3ofD18YlE+mcWlmFLQO5VmLAq?=
 =?us-ascii?Q?kwX7Qh2vsO5XyYDUM+4+K5l92qe63XCMrAgcC3wNB3dy3v5IG2ekX3nAw2lX?=
 =?us-ascii?Q?xNy3t6lG1M1DNbA0/ICyaY6KpsZ3PtQz3H5PAez3q16jUv6k94XVoIE0CBQN?=
 =?us-ascii?Q?ey7X2PfCxwk0vsUL+zblC3H1V3eamabQzAqBpQf7yENQe2wDgLqpbVFhstpx?=
 =?us-ascii?Q?n6yth6caR3e19zdsoH7edUo6L0ie1/Xfsb35XXDVtoyd0vZSrHaJaSouT/xd?=
 =?us-ascii?Q?LeDbMdzS1+jCx/x07OTG6AoHWt1QV5PsjV2QqKb8BWCGUuYaG4jJLGLk36sP?=
 =?us-ascii?Q?CmT76F4GKw0rz/YdJ2yUb4F7WpVF189CiZuhZlRh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff20dc-067c-44e4-8fc6-08db62ae486d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:28.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJdnXkIBJPIsr0g7Hk/s9c0Y4HFVmQezBCEG5nHBgBFSmtuziBUV37OdC7Jcm+ItwONoPBDH9Rj0YQqd+PTpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


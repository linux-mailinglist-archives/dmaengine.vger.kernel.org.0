Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FB72D092
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFLUfE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFLUeo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17910F9;
        Mon, 12 Jun 2023 13:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chVWX8MAtl60FaHQq7zVFDUjpnvNq6QJW7NzWtDAAq5pFPEebkIz/SlvZ0R0W2KoasbVzMB9oUEcEsWnoAkaykPWO4RItNbFkyxRVV3h6uk3I41NeZmShWL3mgJaB/mbCLm/GZGhZI8xbgZPhzk8iSN2AglfQ0XlRTxeJgEPI/LcjxcQdf6Agjo4aapxV3rOwBb63jhNIBbZFysmnDiUqUiLwh4BEF5lemgrC06g6ioMxx+PtvseKfMVSRuFR8WB4w2HauSWPJf1JA8hbQ/5AL0LNEDr5q3Yda9HeNNH7HTM63H2ElBgJRHQnhz7pIXzjDSWphpi2p2grz11Pe8fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=VcSArXlQvvCHOiuCWeKcZ41vdSpVAzF0XzOmNVJDt/rUcqMo7aIVSSu/FR/MpHsFI2xQWqglTFNzRAm18vvRRjm6L65d6xkjMD97v/KpWz/n1nIki/nSp7hRohCsWDv60bGjkS8mq+G3cV/z+jP5epNE3F9lgkUGWqm9GcABNaBGPUEsXo7PnNljV9byWRZ3BN+0MKje2uu3wZt/a1lXC7ArVw+OdiHeAd4UEbIb4NVAI8upO4LnaEiL9/68PizxB5c+X87V/MSgF9b98+Z3pcMhXWz1RQ/TiwnBb+hFwrhGESl3v3qqw/9CuKJpP+mgMrKKMpLTYJLcgJcehLdf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=P7IHflzZUqhIKR4VswW+G12jNgAKU3qk7RA9Rxa7W8YW7/DrASkouIdsruVO15xjaBj/yrKj2VKTyKrD5wbfMOsFD82IR2Sk16qugl1ZiE8sVN7u4cQfciSw25i5baZh+qwisj+1o9xmFONPQ8LJggZvWxAi2ObpWS2SurG8II0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 20:34:39 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Mon, 12 Jun 2023 16:34:07 -0400
Message-Id: <20230612203418.2017769-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe9588a-a470-4ec6-656f-08db6b847204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Rf65LNvBmdIIUS6mu1CRbqQQU7h/dyLQZYm9Yfcuq/scvPxPkhU6BxCn3QsB5mLEluAg3mFn/DyYrplXcNaDiu8HBX6ukhBOnohx6kkXj00vJuPHNlkSch0egAxqZd1IceeAGlVwyEOlJhHUrl8rswY98Qnzt1gfqdFzToc3dhcfMOCXUmKOSIOh0+VGQTBo6LtCtD22Ah/jXkpO2agUZ1y9/4TcpOI8yk1kuiiLsMr6fMbkWhASGedty7VGG0FKRl8YIUqOBZvHN1UkKT6EnJPIjh3a1htsdEvmOlv2BKo6cIxfEFjhSub7Q8AAx94lldvAj7u/E9DcLlz1iBxi+2arGcjg4aJOnP5y+u5yOuCwaOoP1Klyv8KDsbEdfiPHUEFWq972oKeTEklxfEzVqpJKocESEqUcFGEaA2PQTavkAWmG6C1GPuPGJEAEIF//M4IkUzKibtDqUaEAZrLrlnJbvwp3Z9/BaPx0e8PE2xQxs1/rVQOTbS1rPvCgPUWdgizBatgfTV27pAd7pfsdtq8ax0xBsBno2wAqy7VcjFeglqihw2sDiLYMdAIvJLfdo4YoeIPKbQ6+rT2mVpSlUiKctcMGgHQzZGJ6FMizT8qJsOfExPamCShMCWVm4w0bl1Dq08w/HbIT+6nHeaOQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(66946007)(66476007)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(8676002)(316002)(41300700001)(86362001)(6486002)(921005)(6666004)(6506007)(1076003)(8936002)(83380400001)(5660300002)(26005)(52116002)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uPokkCLT3nFCST6KU9FZmqfagu+ZNoH6qR5Mp02HQl/ntAp2DyM185fbGF8x?=
 =?us-ascii?Q?6ruO5EhdTddoqWQ4AbSbQyZrfF/ZfUz/XGWsq/J2kx+Rqi5rEpZGsweJVaiJ?=
 =?us-ascii?Q?Y+cxCHeoxmDyvfu5pMQHzOwx9YRIv1U/RAeWte6bbzsD62LfBNfbruYlXdCS?=
 =?us-ascii?Q?gUD9CQIcaJOCrD+Enp0i6OARDoahuoIDnwFK05qTXoUsHCncR3+DfeBvW0gt?=
 =?us-ascii?Q?ibXSttb+NfdhGI2DERxVJnN9Go+NTVay3zaOspln1E5QO92m7hbLZSYr/alw?=
 =?us-ascii?Q?ekuMx6epcRfRu+PRijeQJTIzhp8gwEHE4d56f5Q58gJWZRjeHA8gBhM0vZRu?=
 =?us-ascii?Q?TvbRmQp6Vebjt5hYFssruE1O5p1WZ+js3ttnioWOekCY+980OXDRz3dTTIx1?=
 =?us-ascii?Q?+KP5myH854DuB0eN1fUiY0E/BThQvZ+uDM3gKlyE6aF1udUON5W8Y1EljjQ3?=
 =?us-ascii?Q?lMV9NecXucT0pQNKd3dVqKrGd+kBK+JZUSuOjqrfRbmIVmahqNkgQ6E054wJ?=
 =?us-ascii?Q?WDpMChp6rTIc7JK30hH2kkTo6tuYmuRXsKXLm9Lwr17VEGbCItlQP03H5ooz?=
 =?us-ascii?Q?rNuVSUuJQMF+EM3To/KEOa1tKqZUPlKJtN8TgtWVHZIPxLIdm+2UhfSES+pn?=
 =?us-ascii?Q?CQMjJAMr+Ot5N+GdhiFVzv0aD7FjFI5lgheVs7nH7gd6LGQ6JDpo/KiOQdeR?=
 =?us-ascii?Q?5JnVnKN0rFOrx1PA2TjDALSeOgqvE41YsBekd0b+7K7XbuEU5GNHWxS8rxOr?=
 =?us-ascii?Q?7RPJM8rIdomld1wQ1eOFlGgDG+QPDpDIPvO39CV6zMIK2eYhRCgWFZ3AOFjC?=
 =?us-ascii?Q?M0TnhbDJOwYCaeJEstez5khqpa0jiRK2SewTTzUkuzAAM28ai216Tv0iwXFJ?=
 =?us-ascii?Q?xGMb22qdut0JNZEoPItMneeFbZC+8aOxpgafVNxk126fy/Qy/jIqbosV8m7C?=
 =?us-ascii?Q?3EpNQfzDjqAJuyaxFF1BYuNks9s8kLnwETqCfMUmFEIZdfZFUK9rEbDG904a?=
 =?us-ascii?Q?+T2mV12gOpNTmgl7C8LKhba3ZRTaR1D7/aKpVEImhUupK4GgmtQJR3EEzDmr?=
 =?us-ascii?Q?zqdBbVkEvzBOB8ANb36Qe61bIX4kPkLMzIb4KV9sE6UyS0elA//GuXkj/dvH?=
 =?us-ascii?Q?JGaY48KJawLHB7UTuCIGB8yLgsDZQhYE/ky/udHO7QNj+ullbbup6k3IPn0o?=
 =?us-ascii?Q?XH5xp51Bhohg0hzDYoc1YIszjaXjZxjvrejxQ4Ks0gwf7avSS7PbCnxXrs6k?=
 =?us-ascii?Q?FwENct/CpL0punT6ZG4+mWRRjqhSswT2wgHHZXzSSlgZSfYZ/YiavmVLk3lK?=
 =?us-ascii?Q?PoOoR4tmgiiXByp7kIQsPpqOGAAqALLTq+peH0Nj9zvCKAxt85KPy1EQmbY+?=
 =?us-ascii?Q?lOB0odF771TjhcMriPrjacO7BmmaM38Mlgx/+vbFnZESIjI75YCIRDeNpPoJ?=
 =?us-ascii?Q?UckrwcGPiZTqw7HSy6hmdbO0RU3LWBUx0P6CcyNfUzgi/sMwvxHVMkmu3EcW?=
 =?us-ascii?Q?BWHLzaBy3Vi+GCrXYPi+yborW2qI6u5L6CVUpGjkwmQQL0DJzwvvUyuZm94Q?=
 =?us-ascii?Q?tQrwgdnN9FzAcFWtiNg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe9588a-a470-4ec6-656f-08db6b847204
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:39.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyjOqYvFzQP1aCocwsCJbacCXofUe2g8veSU+3/IqTlMkkWTN+7OZVY4tTg9knVGQrU6e5AHMcreZJnLH8fg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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


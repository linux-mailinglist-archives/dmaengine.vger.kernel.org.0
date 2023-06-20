Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A237375B5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjFTUM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjFTUMr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:12:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2310F0;
        Tue, 20 Jun 2023 13:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI3L6EvQGXiEjSol/nAWLvTawgbEPq3xdy0XXxZ6uqvwzRCibFqq2KoDsh8xOe47rRuFVnBW1Vv7fm0j4P36Sx5TxtVl0KkTuUBGGHkxlLYgAmARFQ7D4Kg1H2kRrUARd4itQ8zUBfWgPUIzDyJ7Odftf4UYH3KCqfmukzyW5febkvTO6abqvB5DBFhJc7FDTw+x9UmarQrG+Z6HzUwpfjGSFtJnU/tnQNKQTN7YvDSAFktroB354gQ8mlMqHrGci44FShsLhNHPZjynO4sZlBRCeIUqiwd6Jk+IREZFRHrMIfw+smcW1xbR5gaGygXlm5knwz8ElUbwH04E33UtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=k557igwHHdp/9zDY7B2yzoUpk4Z1XQdHNrl0jAls2gNnBmAQUkmK5hbmLP2JPsPacjKLUn3+t5TSIy+6uJ/H89+zRtxFbhZm6e/hsXskb+q+/sOMSUYR1FAfIosdAMGaBLCSPTW48QS/u5rQ/xBVeA5ibQthdXWxE50Ru5xb1NFb4JKJETBUXva6XyXcTHJlzXl40Cxsrn+e9ALYSKMPLWPhrNeY8Yc4ZMofIOly+xYbtgybVDA5vTCudB7M40HlAyYwwu6be1vChJFJzdIE9zOIXHoYB4IUfRBVVSwYoqgZVwa0OzhONOTZTtYat6MLGT+RZUKNzrjh4sdUhV/xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=gQ4BIl6JR4VQ+DysI3nAauAiqznbEuMRHDMqtC/SASzL76oeAu0UL4FjiQOY8J1Ez1UZDLE+Zy5V2WGUoZ4H8Ylbhko1UNB0oasjtLkSF4jEyxrsB4C+f9Ts7EC6aKnmBTd8DP+xXN/wuipPbVS4XdUWWkfpoUP2HVc1WsTbYpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 02/13] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Tue, 20 Jun 2023 16:12:10 -0400
Message-Id: <20230620201221.2580428-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcf4cd6-3de7-4a55-4580-08db71cab46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NCM3HTLSb40DQWK8Bigh4SbjN4zUvkUxYXS7lDwXVMh1VRs5k67ofk7RkwZ/OQRM6Dw7q7D8b0QfYS7CxniCTGatbERoCtoROEzaJ6BY+CQVF1aHr6IwiLLpgVqR8wrCMlLhLMDJPdQ4RU5Dzzk0H3dKvjDPWjsgxnrKGAByKRKH/m+dpemxLADTaNhEYikKMvhCv/xqbqs2zcDNsn8GtZ1ZrGN9KeSC6Pqhr/OWuGPhxiAmSo5GoiWfr6+X9obj20BrtayI4cIyLDePqeErUxBYw2us5jXzF4aZ6vArDpEtCzBfdqZnZG2KPJXw52iPmaeW8haoAdKf6067obJYHQ9CHA8Zbhpw3V11ZmhziFW61RGKxJhaWKoy76SMZFq4s8r7gb2MRzUU/t8UUFHHdEqo2XSGEdVOeUeL+VjBzrEHqM+3dyq0b0y+I3h/H0UykupBaPHY5osnbIhSO1DV+FD0rwFD3PtKWVtJjxQTvOeSKwrvAaW8SJ5DVBUf/tMhKZmr3ske66cSH3xP6UONH25EGCN8ZIzQBVNU848Nm/wXpMvcElVyo+NKPhNNXxXkPQk2Cwte15tOjZHHHk0Y4a35hXVGDlGElEiFhBrxK1a3sRxpWbmf93tx6S95GiTRSRyK+1SYzQy7IlakMIJ4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLC9bKKFvxG54CSVwA5mrJhR90fMA39rvzVkmzZllhUpzJB09ugmLxdTAvyK?=
 =?us-ascii?Q?cklwdoatc1RuuIsn4uJU/0rZojVzqa/lKyLVcO+yzBxA7WmqloiKtibYqK1n?=
 =?us-ascii?Q?87BjERTOs/hHWCXr5gHjQacMPsQX4oKmqZQDDWncGLD54C14UV+XJYHEDYXb?=
 =?us-ascii?Q?TIvr6VwORRqz7tdRwLOHEOASlbedrU3+OAhiZjHt833bBuBFygjgRFjyxXxr?=
 =?us-ascii?Q?wMD5j064JqrDbP7dorXF8Y+rC2oCUjTqLvsxZ7zL4DjHEGN6HJMpzyXHoezw?=
 =?us-ascii?Q?sh4QnDe7WN/IgRv+FgToFqqS1oMlMEE5XZEBZgedB/iRANXnRrM1sd43vZ9w?=
 =?us-ascii?Q?yGLKbJvVwcSmKRkanXPWwOgWSQlCTgy9wyjqo7TUyp3XhGidw2VxXNIZWZqN?=
 =?us-ascii?Q?zDXehRYBi9WW8jP2GwNRB3AXKyMsVe9mg0GDyRn3oThG1dkGMJiWQ8o7thyF?=
 =?us-ascii?Q?L4dd8H5KtK8KtApHAn7hnYYjuzf/8ug7BVZY2h/uxSLiHo3evJkPit/q6yks?=
 =?us-ascii?Q?3a5rqs9+3nRWMY9/z3F4EdXn5CKh0MOUqr1LmIw45lVkPey/CfN4aHw99jwr?=
 =?us-ascii?Q?Eye0WnOx3t7qst7jjnYo3L20gnW9FdEWj4w7tdMRVZjD5UGXV6gp/WeorTFv?=
 =?us-ascii?Q?pX+LB43GO5A1O2nsWC/lbpL+DPwVlh9LlYn9E0OaMoEGpp5CaMjdD0pWuykL?=
 =?us-ascii?Q?IOH7HIiUUjtWFAcPeAsXbDJD8tiwX8YkgoKeNpJYvh/AHw5tVYCkjSYvP0Jx?=
 =?us-ascii?Q?1sS4FNo9FdRbpawsfiIX8PM795UgDhDbTDNxw0XuGDVq9JTnan7+ckHR3Sbs?=
 =?us-ascii?Q?C4Q29t04dg7To7A5FaUEO1LnCXEUsgqpDdEKqujJR52i5ojzyu0sGjg4UI/B?=
 =?us-ascii?Q?LBrBWfTSFywlnZdtYQLl9eUuiDPpbjTvZO+fgEd+VqETY3JBcmb8qhAU+gxk?=
 =?us-ascii?Q?y6vv6MEfJFufLzdTHeVt8cP6vT8rWh+YBRMVdviHYWSpPpnm85uh6rJuGOR1?=
 =?us-ascii?Q?9BgzSgMPKp4tUDZJEVmQVRObzPcjxR1euTfDRlyFI05X8DzTKQD9QTVOS6vi?=
 =?us-ascii?Q?nMJ1dQN1FtE0P+LB9QWvMGDViIxjBFtUcG6wGFUiTwtUDAaK6j1NL6x6Dk0M?=
 =?us-ascii?Q?0qhQvHEoDvoq/rupOr3pS/DMTghYTXwCmj0oyVpJT0KgrN4cFo8iZmnKtAsh?=
 =?us-ascii?Q?/9InnyWmDcqAMPDC3wTsXGbLnJUnGK22r7SQuzVC+frg7yPFjE+F3xS7iy6M?=
 =?us-ascii?Q?ueEs77mcq9lxU8K7WplEKjLYStNAwzSrTrU5nqtjZMNcVN5/XkmLQe4CRsH3?=
 =?us-ascii?Q?ZV0aQL0x1zXXVUhCdl5ApSxt1JAoz3uRg5Stg7rgMoAL43gYpO1Oq92bT4tR?=
 =?us-ascii?Q?bTwejI6s794ELBscGSMbvKlBJiVXmHMKxyPeOuuPVkEgh5/d73LfL1HSsRkG?=
 =?us-ascii?Q?qOnzZ1N9lC+cnBYreOPsGRw2Zew7871H6GSvlxg1XXwgmsfb0WUib6HsMlYj?=
 =?us-ascii?Q?GFHwVJNQx6euQZ6H5bDUn1AesUxD+4r9CI0I6llMvN0pCrkU01l4/MN/dfTz?=
 =?us-ascii?Q?r6rKGEFa1thmsKcpTwW6qPSVfVrGWrcCxPun8kE1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcf4cd6-3de7-4a55-4580-08db71cab46b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:42.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79Ybu512vM4oMp/NMIBn0EBTVLE6KtlT69mII8oGDVB2/r4F8nutfADvc4DL5qcNoC1jzVFGO4M2fTIiVMzXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
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


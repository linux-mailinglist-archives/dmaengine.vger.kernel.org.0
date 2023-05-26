Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486C71288F
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbjEZOi2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjEZOi1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:38:27 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E6E69;
        Fri, 26 May 2023 07:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFVQFY52AsDME6NCyyOcidYKBWmymWPhSEp7AIh0804UKYQ1u30LgfKu71nszTX0CMLEOxaXFZYa33xEaXeRz2S+pSBLapqCR/S64asdlQXc3SFUTcbAErq+5PiKU+RqwnW+kE3is2ESjPWwbAYHhsni1Gkwf7gkeyo8cpufwjA2U9b9JXJP0WRycpTGP7RWMcinan3nqlImzW37S5tJxDfu96dFFINEtsayy1pgdoMpzruoxcrWdsZD8PspOXxRxVLvuOqz9wwKhDQ2BhjC7pJ0cfq8ALWi3DyNKxdWg6WhK5eRw3hdzbsDjv7/Zp1tqUBqQkPhGq6gBK/+iMXmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOuNKw+yGPPLP4V7NnJ/FXD55i84pACgcY7tObwFyzQ=;
 b=N5E/Iah0hFeyaP7ysgQXGcuDhXsmbBtN8FVQMOBu2SfsIgYrd2eHScnVDMaQNIRpyqKOtcABPzSd4ljZfgtFYQI26sFMXewVPTM1bpOwbQZyVBmcv0MUWyBsMjSctY/Z7zFgfWMZaG/m9uIv+Rrgk6w8THnTbFuWLwZrK/u1VA9tLqYy7D1Yp/0LEbk0ThaSZ8ADfgn1L+9GEtaRuwVru7w/ZM3BEOI5XbmELF+079FyPvb71EkW+sAFsI8FLdcCOHrtE4Q5FBPqQpB+7qNUZDxCxqO1Rq6WHARtPqV0gO3hEb+5eoXCQm6V1GAlM9El6IIwZh8r+7IuKt/6m4ylgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOuNKw+yGPPLP4V7NnJ/FXD55i84pACgcY7tObwFyzQ=;
 b=S+KoaUHOGLLBGHLumwJUiH0xe7Jn7oEWFT3G9wo/c5r1LnKv6HSudvttSn0lxr8CHEfpDQpUEgzWURHjn2lsaK5SEke5q3iQn4sABpuvEE3Ry/J/cryE0yfwKhk7jhrRFvRxskkVFnKZh4J4Q/H3HqzN35IOY8/BArMVJYNXfMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Fri, 26 May 2023 10:36:28 -0400
Message-Id: <20230526143639.1037099-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: cc00ccda-ae2b-4e1e-4bc7-08db5df6aa18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WchDNgUON5/x8WfW4n50BB05FdjuAdKR1J7nJO3JOmjDFEZbEmWDmlqCb7bj41DWU2azS0rzdvIQXYqftKd4s11p1JyXw5MTKnwjQ0StwCrjlSnubijM3KMtfWx9fxBJgXq/DYZEAGCTdbo6srCLcTgfYstpUicFGZgjGq9Mh6+fH1VBTk7xNSQg3taRQa522YoDG12ATaexBwH7HlMBDFh/GwQANDO48FdWHNBA8v2JAvuGflLk+QP3DWYFTgX7k1ZaTK7waJAaqVMkhOvlqD64VwiYL6GiQbrkGkFbkIttfHcGCsgZsSgUVeRNFlnMPGnysdSiMsj1ePYJoaX5HXLM5QymgGytLop7NUv9zr7XLcgAe6nNh0uJ+/3KYxMLKR/jRCvepiL9UW+Ywo2fgbt5Z9/N9kANocucbyzBPh3/gSGeMrSvDndKhUxkuuQsP0g9j9DJq6ByLrkOYTzR7osGDWGCsKsSodbjn3vrhB4EXhM0OFlrQXZDx+BSpqVMpnbk8xMVPwqvjCFcfYyqTCvDRtEwL7231Fi8+1D6VwZ06w+DZ/hU8TGM0iWuUn1dHuCN0zOfW9+utejD7QDWKU9F+FwL+6I61DxGxEindF0FW2qjVVbRVOLBkjlcoklTfOJEdlE/D5GZz0cAU+JEqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbndXj7UytsyBHPZZ7T3Eh+sAtvEpARP/Tpkr2XKJwWJSSy3jdRuypu1tkav?=
 =?us-ascii?Q?KIJp8wK+6ihudWVF939TSZFEMTa7Yn+jNBT1WQ4pM6E4TWcPr+Ba4+066Aln?=
 =?us-ascii?Q?5qZ2vNJV2kCbRkOcgRbC1p8H5qtuwk0cfT4fHCEmLDe0rhqiQn9ekFVG2pZX?=
 =?us-ascii?Q?zrDiBIPGuKdu4GNYMbmUJL6oMXwetzVQm7/l7zueBzYgEXG6uZs7NQGxuyyf?=
 =?us-ascii?Q?5j6hGt0yLU/0HKB6+/84GqhvxTqAgPzpWASGDAB4QKYsQxQ6LkM6fq79ubDC?=
 =?us-ascii?Q?KVNwpyHRF+IjTSW8EUGA5TKhFGAlHphqytaygkSBKpPspzq3z2zmA3VMW8IK?=
 =?us-ascii?Q?aP+XEx3f4RnD4ZP+Suycv7BtjFU3HXaJ/j1t742JKFsoipLj4+O0Q0IqszRi?=
 =?us-ascii?Q?wAndGG7IE5aykaHNfBskO89qKgV0gsbvZ6hgnJXkPeQ7XqprJaMA2rf6/PtF?=
 =?us-ascii?Q?CDWVwIEo/j53IyvCStBELL2oHnt/B8wcvIZ+9ljB1hwJQp/nueY+O5Xw/Jc2?=
 =?us-ascii?Q?X+e+n15UG80/0NTWC1uSYvHqHfJwoV8t36wiZH9ygIxoNq1ALG7gbSNfTP1w?=
 =?us-ascii?Q?mwY6ktN7H5rmohfhOJfZqmZhI+hZmNxrNsIc4aYw+SDym9FcALmPW//aHXSW?=
 =?us-ascii?Q?A/0ne7gFSFoI+KXYb8XLVcN+He6VhZUJ4akHPkxV+qzlaD9yROa4mX8xPl76?=
 =?us-ascii?Q?2Pygw9BHZtjh4wMU3gWFGR1n9C5O5BMBn0ktMNShIYOySmROEXIgYhhAceIn?=
 =?us-ascii?Q?mavogO6yrhqK+fsZikBN38LMM9SolxZK+JkEzOcTcp1hwV/jubTPOhxEbBcD?=
 =?us-ascii?Q?jembUfvVDJvqXePEEBMOicPBPgCKx5sKg2pPSWv2roryFYNS/IW45Yw173XG?=
 =?us-ascii?Q?Bn8UkmUNXuvF+fF1egDRiIlXxy8TGQPA6TB2LYDi85BmiMw53kv4O0u+c66H?=
 =?us-ascii?Q?eJfARy2gscATr3jhBXMEsKerphbVgmkAXI9kfYxSlsC8QxCTe3IiBic/nFbE?=
 =?us-ascii?Q?GZ8tY8EKjlx8JqTwuYuo0MJH/tK1wnD2c4tQ2IvDfsXnnYcD4//ZU35mXDIk?=
 =?us-ascii?Q?8BWnEpVJPK0rqXUGfKM2DywjjwG3+etgTIqVzI0QPUhayv9XQjzpCy2peWXi?=
 =?us-ascii?Q?Qi09VLqgQ/+AWeVzZ6w/V49MzPuFCL+M6eg+XLYlvBa1TshgMt+lAkrPQVQi?=
 =?us-ascii?Q?x6sGCPAb+MkzKPVMKVovqMcZunNwab+BrGsydgQIUfbf8juvfbHBa/5atd6r?=
 =?us-ascii?Q?4pA4o0+z9QssFdYYOmmH7uFqXGy0fWrnay9v/fr0701Vg3c/9TCtZisTic5r?=
 =?us-ascii?Q?wsKL/uKsylILKEr1qmyWO6+gpPmfaXOkHWo1+WItJqB1PocqGX5Mt0vh7fjM?=
 =?us-ascii?Q?ubbtKJyXkwU3DrDytxF7e8T7OxNjfbNAKGXD0+wDFjrjxrp+mbFZ+LXblTb6?=
 =?us-ascii?Q?EOm828s2eyYLmcwbrwGQnqgVFi4IaA8vpy8TiRjwXlUShsrFSe7CuCfB1Xc4?=
 =?us-ascii?Q?kWO6gtcQBWJ+0BSXiPGzKRMtnpQg4kvB0WTYGHDAVmDxHYwaOtMKjzBPKI5l?=
 =?us-ascii?Q?EKQWcmiB/TuspsMzJ6D+8di4ms0IFld1d42/rHQn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc00ccda-ae2b-4e1e-4bc7-08db5df6aa18
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:00.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXfKeKMqveZt6baaLJElEPJoBZ8ECA/gW83Tf5Faw8TnfExKeQvN0fiDhoxvw0CHP95VoZA3Tz65Y+vz0C4qIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
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


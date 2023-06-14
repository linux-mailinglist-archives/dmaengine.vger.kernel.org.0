Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18C7730854
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjFNTgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjFNTgH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD01FCA;
        Wed, 14 Jun 2023 12:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHGelxCAAzI2NFQLjud5/pYxtY+YGtbdqf3IVuBfRrekzQEonaQUxsDvvYbxcMtaxZiZkfEKKFjzvMBewtn8icbCFyCpcdG0mhuCcJJc5k2McS9hv1o8P+/fa9TEQG+AQW9Cf2a2voRlcVrpoBsK6BNivPU4ECfmcelAiIxpshPSygQPcbaLYJkch6PzYnD+maKbBVDE1hzyTcuUQ8HgcbmoyO/J9MWkN33jebJZKlSGSbQV11c3jv2nnXr1pnhF8N23PV8gVt4iiwUVI5oMfA4DAiVqNIzqKZhTlA4q0ykzQ2VVnQ1ghj85MUcbzLKzjZHFEFhgAF0UqG2M6i0BrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=F+6ueDFm0MzlA7yvaA4s0HG8P3NjW03IMMtiCsBirS8Df3Hzq7tpKUuvt+3yFoJdGvVN4nwixcSR9OvNMW6LXw7nS1gxHzTdVYt9v0lxR56GFPqjHyrXBD1qrhJeiiqjLYjShBodpe4DxWFc/IYcTskDu6rBwV7Sj7AtmDufc7/e7wzNkNJigRdio5Fz1C7S+xH2pNocRkliQo9ys55Gt0PQMEb4ZzR6b1hzMtKkxMr/55B56oNQNAtgbiNNyP/HhNNq2tYdgTdvsgLpeqA9TpkoZg7E4Ta6/3/UZuTDQ5zmhTZvFtITR+ewyZ8Ow9XPMzkM4vwsWffsdLovTXXCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=djZRA5CkpoIGDEuY3w+3FmcBmf+M/x3X8+kzvBfqAkvmLiVdBrOAeGy7+2qF+zQAKC3sBkO/v+ulvhbsJ9uRnE07Rc2IdONN23kJWKau4dJKcEjLTnvaeaEY+atMBtYwrEnKhdyLtst9a3tBn8zSubLp3TDJkRCwYF6eFfxPiUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Wed, 14 Jun 2023 15:35:33 -0400
Message-Id: <20230614193544.2114603-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e47fd9-b705-45cc-06b3-08db6d0e96ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAept+TYd9FQ+GUCoK9V1E4JqItS/QkhNTzZW+Y8Qx10N7ZWN6WVGJLSCTt73XnSmc0bSmrd5IAufZmNyKHrHlAifQQUq175kIItBuPWHOR19Z6TATlfNrE/8Xgf0lkzpTc8fEMKB4TMBbrkj3WITOgfqqhOzXHtTR5uvmPM60cK14ldtRi0jYefEP17sXcWAG19YvAkJc6qYwHoSu9/Gx3d/m3rYnVB1WCeOn4fVTumll5tyQy66E7irP7LVOLFdrcbl1wKTLTt8SI4xNSRXLo2rlUFS6Tvc44gerGu94PzDzBIig0CAlyi+rUFDAISLmOYpM6C4xCK9X9nnEtLMtUDykgDltLDUwWXGWT9ohYNaziKhd+FuuthPwFa3zCk+uaKXPZOOv3ffZROllY2DZLakOFQOedGu5fLqwjwcNlB9pftx98ymUAIIXWaV66sGl6VWAzuQ1Aew1CSV2chvebDuVfcJdN77FHUaeixsdO6lcoUTVIMOw6RSwcFmJR4fcmFlgTEG0hS3r8SEiZSJWyeI/PXfE+RD1C4O0+M4yiBbgRr8DOVOr+XIbOu5sVCQkCAatL2dE+gcTqOB4DmvT6hEsr/26jGUvmsAMSKk/glHjvWIk11BIFOMksaZ8X1IopUL+omkWqALC3S8D+esA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8LQuv8++4pgpcz+SYu0fyxs6WEr3vat+Ah3D2w+XJZwGI2unPbVDPXY7ZxV?=
 =?us-ascii?Q?kTFCvqQL8DsTbq5v6n9NKcIs6zP4aP3IsoGrFa8ZSxAxHyaNbQxMjCAKnELE?=
 =?us-ascii?Q?VtPZBpQ6yXruQwSDcBzy2kJ3Xu9y7AqViHpSMztI/VBGo+k0KpO/ls4VHglm?=
 =?us-ascii?Q?F03NEJ6h/TsVwHcrGDl+MPgRIKFaQhyyTDZKy5LWlS3AsGpaSb7ckziaaKbp?=
 =?us-ascii?Q?kkCoge4r149Bz3gIqHHb972RADTxEYNqi8UxDBkQy6KHCGWz6XJEsCoNWOEC?=
 =?us-ascii?Q?OMOctoOMPLM+sOziRpAWsk0dVEM0jUQPdRK+06b0PGZTexvaUe15ETKNCKzt?=
 =?us-ascii?Q?+czKasgQHDiq4kO2TV9IdVYG/tWyHgOVyZoszzs5c+7QfzovdRFimHfAd+Ss?=
 =?us-ascii?Q?m4MkKJuxAHRUZ2GrmCML1SZj5Dk1/WAnPMSnr9AvRHmrqwHViMcCj95CuOCo?=
 =?us-ascii?Q?pQE38lGHRBhWKpDbAcSWI44bvrIBIgHPFmvgnZ1/2zlghY/iJ1tP3a4m0v/S?=
 =?us-ascii?Q?b5aVvqGhIz7iDAa6Zjpgy4aeh/LXshbe2atjHHCVRbLs780PUzq7Wm/7lEZF?=
 =?us-ascii?Q?qomwUcLTVWlvLt9Y5bKUSIZHfye/h0yEuaXKMBQkxndsS7L9w6HgfjmUfD4S?=
 =?us-ascii?Q?Ll8gKIG8wyW8T5mnZ8svyrga8Rww2THFLWc6lJAgFYfbcX6lZeZvXBqT2def?=
 =?us-ascii?Q?H34yUkRaINL7x2kUFBRfAWtKhky/CLHhctiPVcldrFhDsqkRbVjR5zqFzUtY?=
 =?us-ascii?Q?0VnA0IWTrKPE6usqNnA5+0ECkz2I6bvqr1ygtIdLLUL4ye1WBPaTmRZhD7Ve?=
 =?us-ascii?Q?dNq/vz1UefhDFXg+n1NPolq8rD0ZzxwHixBhHstGqH/j0pGxz9BC5Jz0R1nh?=
 =?us-ascii?Q?6TPokDJsSCogNuxQWplU6vGchXI53sj1z+RUIOFUdbYw4YO5uQCdCV+Q/npX?=
 =?us-ascii?Q?iWUoi94VPrwEDFYvPa8x5N9MiurFF3TEO/6p5okVypKaXUipuRko1MJkQUwZ?=
 =?us-ascii?Q?1m/vKWet+2gmw4Gulu/l187x9tdnXKLY9ALNSP89KPUtvPd3UzxuuIO4cP/K?=
 =?us-ascii?Q?ME+jSyja+GYEY78g6y0OBdYWo3I4tMjZVrACB8xyhzV5IPBhAVDiytm8gANv?=
 =?us-ascii?Q?ct68Zm6LXrIi2zHQg5cDCGFNfp0KaefqrlkTLHYAR9hz0lsiVUVnqDp8X/e1?=
 =?us-ascii?Q?rq8N2mYXa0dL9MXwcPUpdnqxOK8OCNV8p7FI2jNrN2ehhtVL8OXlPbGKpVCR?=
 =?us-ascii?Q?OKfqn8R7xNa43m4dpMU5wLPaNtiUOMumaXs7fIs1+SAxW6EbpstLUGfVQVCV?=
 =?us-ascii?Q?L8Gb69XHipcXJWBm9HU6cE6YRjdNorF/qsCONPwgKT3SIXYN45+3EBLmrd8I?=
 =?us-ascii?Q?EBdnk4RjU8fjtjiWNdFo3MjAJVe6XgFlErNgs4OZ6haMnTBW7Gkrr/fx/I69?=
 =?us-ascii?Q?kdf7gpGCHaXadP6oG8DE9q0UUtDL5SB+nV8uc+ZToDtyCzxanBCxL1ofMvz8?=
 =?us-ascii?Q?NHBsn7JnHAAKs2fJq4BaxncDD4l05laAsSS5n8m+bxqGa8HhbxXhXsdWSN+h?=
 =?us-ascii?Q?J46UysfvxFBShjYv6BjAnrsGTtwxjmJuZSxCJ+0G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e47fd9-b705-45cc-06b3-08db6d0e96ac
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:02.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxTF/yl7TMz9n1UQScQBb/zPtFYx2MDsdz9D+JqyO7eI7FQtTLXThOZHUEXFoTzxfmhqOKKg+6I7X6LIVsYWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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


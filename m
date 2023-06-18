Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D9734772
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFRSJw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFRSJv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:09:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1D2120;
        Sun, 18 Jun 2023 11:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiZFi6su1HYaXxhIfIwo8Y8r349HXT75VvkghuqyIzBebnx0BOXKUci1flWH2YB/LaT6djHywboAqPg5wZr8rAaD98mVO0DY4VOBHY0McRjXZxxSZY8BymqFGdy1sAFaef71qXmha6F/t6mn88867jEiDB7AWikaydODD8hdg1wAMqkxzhk/v2mA7DDTmcs9jyaN7PaAQO3RCAgVMOi6Hq0aE19XyLBDTwnnGZT0FY3KDX7lCWjCRjS9HkLIwP3USclzlV69oTk+jQY5pmIHme43yua/6A9tjR8ciHTx8qrH2lYo31SGhF4zF+7GdUnPD6m5Hu80yE+amEdxV8Vx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=JAkDfuv5WuS45sL2Y6haQjvbyBBXD4KayVLM1eYqR5F67rwJrlXNLCDjzqM99Vtkg5VZ1yWPnZ0iKjIz4Bov/RB6GYGbmDBqlUlyAoxaVBTDOD8hhovvtRSANPM1sQ3gA8h7oGOKcxwbErenHqnp8QeJYUg/JE1tfjRxTKzSwJMEtgB8NoDJrWIm4CWbF+l7FHe0KLuZPvakWXlFKqfzcJRBZ4RXRLkXio7FcbrFpP0P2Fipw7/yZMl8mcoToLkp43EWaw/l8I+nQH/lndfR1zAi1P5d7dNR7sCR5IR5QUoDs9+TDP1GPCTo4wMPt33eU40oMjVp4yzcdW4/m6K8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=l74kXMF+PQW7K986Mv0lr+aRYZtMOv6FcSBUaTmdxrVndDgBDMYnkCqDYpVOWdEHPO52eLAMyW880K0nakDuqHH7pSnNhFLT1Cnjlm5pl0PHrIh1mzB3AjzGbZTpwCy7tWZOEhkYHf7xs6wsXwRNdoeRJVEGaoyLaIznpOUj5x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:09:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:09:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Sun, 18 Jun 2023 14:09:14 -0400
Message-Id: <20230618180925.2350169-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 432bee38-5975-442f-e4d9-08db702733eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee+X2Ahn7C5POKWqaZfj/Uosymidrqfd+cqBXbj3CPJ+k84P11nLF49dysHQ4iMhaCLkTiiaS/6UMx6i/J+VIS1R/8ixBssQ1Dp1RNXfXhh940Qoips11zEOrWa+sdtE2AaK7PkCIYTfCc7oI+cbcY+av8x22ETOZXcIQn+ZfXcptsknSBrWjvksVJm2OZeg9NjkIhVeoVjtt0+HmkxYcVO5q3OCSWtKFQJUTaDM7GXaiTef5SEagW+LaIIgzLnnz/KpnADRH1qxpdhYGx6OxAT+W37/1g/YQcG7OleC+rOqJ79hYliiXdsuGhPOTWaadEQJ1yaiJ4CDGi1+VrRgEldq2PAJlptzYpCQqQLWuBEmG5Ejg5at3FiwKEZq8j6c51nDnuAn7UTtjRyb2G2ACPcDgVnghmwt1R2zQ60OSXqMwzkbLUZRNtzUnPFN+rRHNgeFLoVVUXk+yHeJ+ucGxSoYHcbiZRf6W6T7LlqYUfFMuqndssNE5suZb/hzBCO1WzSVzVa7zEdyEJ8b0hs4bpUiNuZ714qVdu/lHewHH3vV98OX3g08tBs8+azmpV33nNTO8AU1AOVVi7Z06ueiy27T06L33EyCB3lhxfk5ydsTivULrBerBSkxjd33Fg4N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qVjS5IkYas67O1fGzCzMYXZ8USBJLGTJuR6bPasYtafrTM5O/nDlsAKPropC?=
 =?us-ascii?Q?lhiYH5Q5mBsgp2vWHCRK/t7YAWGOdsu8BQZ2Y2Y3I4VpAy/GjvSinHCbQNYw?=
 =?us-ascii?Q?hERiqELLG85y0yQxqiZlcgsMuExX4nJs/eQr7PqJOdPjYLqGSuRJ4zBm3I68?=
 =?us-ascii?Q?YTGkV5uH2G1/ahQRfivXnS7qpS8EVDMTmZrdxCfBmAs6amS6Xvda/FIPNAhb?=
 =?us-ascii?Q?h7ZHAZZ2xEQOe1seKPrIW6xziYmAWGWQ1YfzRi0axc0RbodyMMjOpqfRIxDR?=
 =?us-ascii?Q?Nmbo3RMCjj4I7Ve31Slx9BDOWDVBiYnVtLToDB2MBd/kzknDOaUpsGXyiRyf?=
 =?us-ascii?Q?3c9AU9FwL2y526rDxeQzPVw5mjaXHwvSAoWLZFCPbJL9rWWZw0wg7J41qcw6?=
 =?us-ascii?Q?A4rOer7U/epkak97Aq77RIMgfAbWz3DAX71bkzNvxQaCNA0ihvb0oMgKffzz?=
 =?us-ascii?Q?Q3NGHaA/VUw0WV6EzyKp3k8/jXG2qjJamJcUjf7bENzYDCm+BvT7axkLs5SE?=
 =?us-ascii?Q?JLcAq/6gDFvhYKKt04txRNXu7XDB0cuhRqJ2zzcZk28DUbaNM3uFU99+GYky?=
 =?us-ascii?Q?+P7Mwc7kbZvgTnDb5t7d4sdOXPKgjsWasMM7UzD6kzZB4ZgwaTOZIEpUV1q0?=
 =?us-ascii?Q?Sqo/7/iiGyC7lj+PQSelRqf5ihajUiPAwq1i29DMeNVGReQ5YDwhULIf2w++?=
 =?us-ascii?Q?iA5oxq03y92ixSaXCqqKD9gr050AGWaF/5WqrLJE6U+nhWoyhjAFOMbYQFKT?=
 =?us-ascii?Q?TJddd7XSepez9uNwTOQihWSDIWVTNAgCJVzEkRrSTwaakDdg1QV+Ozw4f45R?=
 =?us-ascii?Q?odeM+R+PtgDO1i3e9pO2RzZKZlfOZwuqcV+pMKKImolbLp8HVR3cIQnO5K0B?=
 =?us-ascii?Q?do/VHqkryKZ61Z2VwGzDaDyt9OrwfhV+nBqwBPSmBXRp1GqlvwVTlLbLXrek?=
 =?us-ascii?Q?2DwOmwGtkicGRGkK0pl2oqaoYanPJLaELtylZ0TgK7G6mxHvXDDo2E4v71OR?=
 =?us-ascii?Q?v4dEdhcKK9ZAkAKL227xIKJL+g90hDbdSnY6FcJCrxIbCJabxTtvdSorWaM6?=
 =?us-ascii?Q?zH1Y2lRGwnfzGVKucW/V9bMtxNHne0iAZdD2WuyrB9sVq2esgU6dKmO3QGa0?=
 =?us-ascii?Q?Fef3rn7F/B9bYCW1RYITbymxi8WqqO0zhzESfHtoOaGy4NmYX7kdAYwWX1QI?=
 =?us-ascii?Q?wriFmhTW/PheB9Xdfwxpw2se3tMpxw+Ehw+r3cpIvUo7JHuJtjbrt9w+87Im?=
 =?us-ascii?Q?wcpzMzDc6bSWX/NRvEKbAz6l2N3COO9harRmaSVuQ+4WYfZxGHcu5HuV9Wou?=
 =?us-ascii?Q?u0X5T5a8nq1umzmrEKCRvKIcWpE4oAFzcUoZ872pa2xJ6UtWSSfPyoCf3ufw?=
 =?us-ascii?Q?XRcA3Mn/qoNZ004/8GeFCSGOol63K9TczWLi57jPNbk2FnUydmCPfBfYfa8N?=
 =?us-ascii?Q?RZHvIEBUPD5SYI0DHiwTfajUTabfvesQ7J43Cf1pcqi0AcMmiTaf53WvzY5d?=
 =?us-ascii?Q?y8lQJ8TKzzgGwS+n25R/e0Kk9Ht5INuqsKHYvQZ4dbbwH6HY48CDvHGGstl9?=
 =?us-ascii?Q?xfmxP/t6DqDaViR84ZCJSccjiFwS28M141/Sd0D7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432bee38-5975-442f-e4d9-08db702733eb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:09:48.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1eTWtkFV6KMxx232H9a4xElm3ptv9cU5V5fiEWrrXosMkenouNsITkva73S1pGskogmpYB7uPyYXL/i4MNoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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


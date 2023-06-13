Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4772EDEF
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjFMVcO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbjFMVcN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E49E5;
        Tue, 13 Jun 2023 14:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+C+c730I6S7FA+5xMpJagkiBFM/ZYiUQ5oxfYMmJKaVWfNpWnz70UcK3j4Ci6hxz8ZRbUhkj6BqmWjZKp7IyWUFcu0KXsiws5+kB26a5gXIGzy4JFlQ9ac1fcMgZaVrZ8dB9mJMy+0VLNdoHiLocUI/0g5qhWy21r09oM70ARutxqD3EFDZ24g0cTOP7WcXdQqjOowDIqO/uoAb2jEN9qp582kb9vqhuLrMphnJ6hGcz1uEd2xQz47kpWZFgk0nS9zyWK2Zt0sLFhgQRj4lRZavYW1CyT149TSqPEAqVc1EE+coyTz10aXLt+Lab0VNx52UAZ3IrN/H+qxClySFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=YlsuLNE3NPKq4Ily/ow9BaeEA7Mbgyy3/tEhcWiYrtnKg1b2KjbnWTt5vPGeeKml3FYSLoiGkRYNOUGhFzqR7iPAHiEpEMw4TEVKFkt0U2Yh2jhXE6vd71sEdjje15u0cSes3nLO7tZ/O4fbymMT5wJcMJBLhR0tPaj/MT6U+gM2n6k3yHq+xqT2vKdYNZmvS2h7j6AQgEEAvwzXdGqz2z66KgsHdExvkRn+UuOOG/FKXLPZAiD/AKvKYX8XcCdaxmAd0M3H36Oz7NnGepiUhkBBAnV1UrCnES/k/dKUsi2wHiAmzoyucDnQOBME1VxArP0rejBGthPftY/rfREl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKzz/DKQcGPIpSzsnHktT8UhEcS2xeQdpWaKphJia7o=;
 b=B4NdiZ65pHDOJZr3TvXNyXSfppaqPBte8n1Ven+b8hMC3Ka8HL56VopE4M103tj4pOv08D86ibtGNrcVedku5ROvTaCjklB74U1xM+Y7vTBLf6Lg2vuYbw3WimpB58jBBpIbQA1CoOrB2VmgaVF9DCuS+F3bNfEqecBJFCqsAO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Tue, 13 Jun 2023 17:31:38 -0400
Message-Id: <20230613213149.2076358-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: de4f1376-b939-417c-640e-08db6c55a4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlYSDY+3eSxx8BhuW04Vj/D5Ad1XFuazz7jlFjdXTHb0vEPIqtas+fJQsy0/2uSiJkbRMU8b2StzFdkKlrNnIxqCkSTVaAeeQzX9zEYyDC6RLLkJcvBRFjim0r5cqml5ZDZxqmZCxuzZB4Fi9ihRJZs/yiRx7PnZKRAQgt6JvxVszv2XPwL3+aYGzBeiBCK0cvDhZDDFWeYWUal9ns2el/nZ5/yDUtGv+EVcbijROA4V+b3wT2YpQCmAffhS7hoOetyb0VqHLQNmn+l6fn7JqMQkzq8AUPMMiYl6kr6rF9SE8fp9+b8moQaozwdaof0RKkd8vCDjHlbhlSwI6pmz9RoGBdQAEbhi4EAJE+TIWhzjgetXBqLV3YAJ5UPuL5YHfYaiHIJyvHrtr9LlbkDbSYoVzyOKZtKNUjRkmf91/VrOxpNcbSiW3E4n3Z0nmTWhEXZ8BwnY8yXRAaKvndCUaP6qmKg4N6Z5wcVYyUASX26yuw+LvtNZHD+l8Q5bEXiTWG+kARaWU+BjPGuiG/zNJ8dTAVWVcP6lCXvJ2Iuyrmfu8Ptb411ej+v0tUlM/SRmQvucS+M3i0a44ObvvhjR6cPygKTRFeQpK3sqQo5HFZD4oDnbTwJNt7Ox+Nc5I+/QB8xfxZZIDGzixP6033ZZuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HP9H/UfmtaIj9RBJCI/BmfwSYz+IL2I/wWcUohOJfBYcryEHLMtSO4Ill7xE?=
 =?us-ascii?Q?v4mOUoHYuAiHh2JiRP+nbFuNvWAMLFQU0mzhf4YKSS1vd+ZmJ70CMgYIqsOZ?=
 =?us-ascii?Q?UMKYsoRn+PPtfIfa2fuqwscC7mc6ZsLSZ2tphiyryzOeBryQePf200Mzi0KI?=
 =?us-ascii?Q?NSRVw60Xw1wbKHC7P0QVD9TtkiPGv71suqnRoRRPZ9tjzgJ4YTEQBw6JEUXL?=
 =?us-ascii?Q?d3vO+upDQ8+nVZuTRuceC3SU8a1M7TtN7iyrG3ZFN4VohHRKOcVajX7yhxkm?=
 =?us-ascii?Q?Vy4RGejBmJskcisfiNqp8byK6h310ygr3rKHfXSdyzcWK+g2PUAvZuXl1C+N?=
 =?us-ascii?Q?oKVcxNavwBxFWV792qxIw5qoo9GbfhWjyL7/XDAgXaQLA6hnN5HmEEW26soR?=
 =?us-ascii?Q?6padrMMR6TAG6wGZ5r2XrKAw/ZlLWSTSDAHmKvvkw+mtvSExPdPrhKETqpSu?=
 =?us-ascii?Q?LVhEy+WePFAHq0bRkAlgq1mGZ2uz5VvmlwfBhHhEuzGCM5JQOTcq+tgh3rUU?=
 =?us-ascii?Q?h3RUmvX5L4NrSJUVcM/bIr19l6zM7qffS3kVJQpssfOzLWptJKGnqhVakMqN?=
 =?us-ascii?Q?hzSclhxbWcNmxYZMZGG9mcjbXFC5+5z83TnrOHiy3mRovNuq4fWNYj5GiObl?=
 =?us-ascii?Q?7H+v+SZ1UcEWbeJGq0CS7JOIygGKRXY68mRkqt8iWo0kpcqyGiDq9JKxMNaY?=
 =?us-ascii?Q?N9xFEWVoBjcqGRK5LiljrJsHDRUqtQ+UiUW1Bk4v0pUNScTFD7XrZ0vFnvYE?=
 =?us-ascii?Q?Hkwn0zqcPYsv5f5pwto+/2+8xYMbH26PZWgPfaOFccwWZ4RqfqktGiK/dBqH?=
 =?us-ascii?Q?HfHuFOgh20CdTOwScKeW/4bHx27xrhyKEUzu3U9O9hLgN+32n34z0+vWz+Na?=
 =?us-ascii?Q?OmCaZSZhYIyo3TZMhGs83JcWL6EKQugN9fDUiYgmUlCGGBFV1m7nDHbn5Ehq?=
 =?us-ascii?Q?2x4UeifheaHHeYZuQVms/ZJuJ9CQ+niUzJ++dLUcwy0tCG3NWndbwEyv2c/e?=
 =?us-ascii?Q?wEn2ShgoY67skexCzUAbbFFg02osLOAAmwPoS3HdM4B8fapoeOCvNm0cO33v?=
 =?us-ascii?Q?+SvmMyiLrlLSmYYDld9iH6R98yBZ3i+oXRQxWZ86MU77xh3BKmXJiHC4h0i7?=
 =?us-ascii?Q?l3eVmLZYCoGgsJ/4CAt4ekfTAMpxOzNaVkFvOxHmRl/6VMXK+U1PBljVRl/H?=
 =?us-ascii?Q?oy34o3cvFUFhtJhxw56c2geAdkuCEvGiFuRneByAZjxA4sChjeiz6eg+QlbU?=
 =?us-ascii?Q?zfABlfvWiJGlX9Yqg24n/j0a4QKiQTiaSeUbOBcYdONk1Emsdyczri1DpQc9?=
 =?us-ascii?Q?i4qIrB8sfnwW5cfiQseyEShpxFpWzBUhyxvgQfYGQv48X+8cDH+KJx88A6nE?=
 =?us-ascii?Q?5m6PQA8pmywnYeY+h1ytxWpc5H/NCSw+K7Mbl8r+knh+Wl0hbaA9gp7zUcZj?=
 =?us-ascii?Q?jupwd/V2YFnfnJynrZLjG06NRXEWDOZoOH35BCpPYNkoNNO7o1rhqRD1HmCT?=
 =?us-ascii?Q?OtKdeZWPQHVO+koHCmQRYWnKfZeaLP5RgUybfiRKlPiHZAAm89d3D3+Nf55J?=
 =?us-ascii?Q?W5Vu6/GvkdgPPHDXH+k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4f1376-b939-417c-640e-08db6c55a4ed
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:09.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cix/oZLp1gnvadBAUzvsUpMNxusWu+PB00oaS95NmV7xz52Vxpc+qG+DPMOTTbYNidNkbF18HBiMKGGYLpOCcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
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


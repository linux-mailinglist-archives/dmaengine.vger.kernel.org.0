Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63897715034
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjE2UFX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjE2UFU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:05:20 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B41106;
        Mon, 29 May 2023 13:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad34pKxjIJyOmNJICJRLAPIoJpytXwjoHfvFM9HkCaVaytQJ5dMBDAXiAXYrS6j/E/ciopyiTxG9DVUL2/01sUHAABvNcc/8CMSLC9mG+noPUBGM46PDHoayXhKfVhHPdQb/Rx3CUdob4Wkh9pe8SNOa4HyWYrV1u+XTRJ7QHNUuOAKQJowIWv5mYaqgYMY3eCLa1mFXO/kJ/iNDEpdv1VDv1gWwuizJkaL07kSSjAqfbY/rpZv04go8vMx2Qn/vWbClGizDcKVnBCZMVJSiEp3Bwb+7UsvTUccbysmLzFaopHq6fAmi/iNp6qoMj/iOabk5S43jvLXjlDtw4dNCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOuNKw+yGPPLP4V7NnJ/FXD55i84pACgcY7tObwFyzQ=;
 b=dOKAB7zJ2ihPR2VkNlEzol7jSqdgzDw8pGyhRrWxH6QQ0tDBqw6/x4z4HD7tiYPGk6kHux943tdaXiXorhUFaAIKOLQBJdMjpJhdb5OblpGsdaUO765A1tDw4nphq4P1S8rUy0APBMZrMT9ufiuSVJcIa5HMc3nox32K0eKnsle/2djh4IcnUDP8XH/wOA2qDHyXpLTwxy/ttKsE3NpBiHilvf3dnh7cb8QsIj9iEOi7DaqEMJMvgWBkTurjRedNn2Lswan2tWAV09tu6parazZz3DngJlvdDK+lQ1hdsXu0HOwmje4COecwiqg0vJV1ZmK8hvVr55bkX7XjVNKdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOuNKw+yGPPLP4V7NnJ/FXD55i84pACgcY7tObwFyzQ=;
 b=K6OjpEj8NgaDluBWwJCJbuE6GPavlkXnp5XYzWMR52O7jdrSIYbb0UMr/h8revFfhHE9136xr0NktVUX6kt7jWKBkf9GGPQC8dRVR9jr6E8h0hqME42MiiBn2uzBZfSBCTbcBrk5EAxcyXGWxLQzbEJVSTYAozOexSZbN70lGUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
Date:   Mon, 29 May 2023 16:04:42 -0400
Message-Id: <20230529200453.1423796-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: df4ce555-58e9-4535-977f-08db6080043c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4Zlj0GT3Pq+p+TLQPOwK1/w3tfQ/11nxvGkL007LYWZHkcAXbN9pW4RsV0X2wExD3QwFUyBGpg4hi6X+4rjIeFpYvBm8+md+9b92frtSB5JqCqBl3XGM5mFAx5ryv9VVlkhSLQOeNxlN3mmrI8zxNQpsr1HoRWhHoMee5Zf6Q4SzUUUIPMswPav9Em8uW8zuY/T4yAYPeLlcU5JeiJDDuMp29vOLsyLRsfsGuPBu/N2lRTbYMad+rCrT1HrYmT7i1n+leiw+wXQ60gEZZOLVjpOvvlot7qCax7fW9Fp5Va9yQzZjE7OsUDYykAJ7/Fb3FbPOgap2pits1wCyj6d+FNrhaG4YwjMQ7L6/DfEOKOhb3T3rJPqEBJuoUBTVuHIU47VyqbAhM5Z7/RBdZqRHxOo4t3RA1Xz2EVOVEPXebSHE1UtkZpTnM3fRKwbNWj7kML5i+2M3ZCH/6RdKdzpqxv5MwoEhiOWEcjpqgdLmRt5vbaw8ZpWeoaSPVYXQyI/Mkpl7guPgmqybiDCt6/F2Xq5A//jS708i2R07iWn5zqitR3jfwarhTk/4ibaYo9qij7m89Yeli7UIb1czfkY3w03L99CEbeuI60Ay2UVZeaGOr7XcalKZ1pYKgxwMTb/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yy3BcES8VWSpV2uMSzRowu7b3q0sB+zoDyPVVMXBYyJV3nIQ11Aryseu7I0M?=
 =?us-ascii?Q?on+GRMRBTsI6HUt1ivN4ZWnmj6W36oTeW/9kkVFaeAzOLVOJ6IzrttqxuSXd?=
 =?us-ascii?Q?Ef/6qtohlarD1cfEFJa9DuRyCgFcsRICSYw3Fro0zUpAwU94PUeFoWwKHi5f?=
 =?us-ascii?Q?1iIINcPvsTQQahKx3fBWCZzZX2qLlIE9fAW1DFftwpB1bgQRPH1HLbj+qO22?=
 =?us-ascii?Q?NP2PP0ftW6WJsZp/dcpCwOtndYhG5jUYT9F/4swuhEgGkAEJMSwSulpFknXm?=
 =?us-ascii?Q?ToF3/8+boUTduqvcJX5gLlZRNQD2oAjSKuz5us1ToVBcY2g8rAW+vpXZYNoF?=
 =?us-ascii?Q?OHWZ1+UzOYERkDnaUxyzVSY6iOMMDpwnluFXyWewd4RaocZCc8t36CIxID42?=
 =?us-ascii?Q?pJlBCxfc6mgCARUpgQtGHbi08G7vvX3Ltve/kJr3FO1czvjORvOeKdP/wR9R?=
 =?us-ascii?Q?Hj7oQP4s6uKJXZoQHTd3nJ6rQyeTj54DGQyMonFHar/YZRdFOrAd5hoqjk8f?=
 =?us-ascii?Q?fcOrJ32Pdm8alCBjCwxR1106YUzW9huKUoqCXeXNKPsHOYBNMlf5x0dV0JDh?=
 =?us-ascii?Q?hbHyEBAfkt2mN4cFyW78zmmgEHjKPL0u8jANfx1VrFucRfwypUgCnsJfkvqe?=
 =?us-ascii?Q?w8rCt1dvsLmfIzCQIUZsrjQyTN2+glWORN+fMIrVyzB86r75nvM9XaIuwYvA?=
 =?us-ascii?Q?L3CeVKHBVoeaf/6fpUFDWfvj9qHx9Sr9m0eC3VYjfVD5l7M9D6c6s+yQLxWt?=
 =?us-ascii?Q?h3hbHjsCR2OSIEUW8J8OAQtBzc7FhTOQYt5s0zWUPWPTAUpS6Jd2p3rf08vg?=
 =?us-ascii?Q?2l7CQcI3O3tYYd+pTo+QdfAuBNgwxRIgMnVBZWpRUAUk8lpcgom3MdaxJL0w?=
 =?us-ascii?Q?hup+uZQ0s35POPxUreaPj3nPFt0YMb1gjE+gD06bkhP6+53ad8Zcwr73N6h5?=
 =?us-ascii?Q?XQSy8/IWzZ+FdBQcqbXAvt4WynQfsfhYxpZZNMk4u5dqe9GPpdQhqeKTFNmX?=
 =?us-ascii?Q?b2DCnZ4l+QZd6bwmklrA3aANMrks4FRVU627MWVcqVZp53I/5hb0usD8mGtk?=
 =?us-ascii?Q?atMOmheKJrYcerXRkJjhL0RphwNZUOFNOUW0Y2zfanhxdicfRE7GAyRYc57E?=
 =?us-ascii?Q?400ExW3kucD6ospqG0vTw86wwkYjbWbsG4MSatWZe5Yc2XSqns+1nWkhYhbu?=
 =?us-ascii?Q?mLH9KvfI9uLFekrXY7qHBxjPTcJEJfDvmLiJeNs16/HAltRaLq1dnK4vSIzA?=
 =?us-ascii?Q?1VEDF4/Gy0j8/zhZNiSuROsJR5UR/xvj98L7m/eeMuVdfbTVc2fSLTLjIJJc?=
 =?us-ascii?Q?YyMlQIJbu8ludkbHjpepeuDCZ2VHpTQ/JteHvrZMpQPeQPnhh0bkue33jyO9?=
 =?us-ascii?Q?2wgBu6eiWZIE9KPnwT3mK6jY9ZHjIWwp6A9wquvaJS/Tnyd3ImqtHhBgXtf0?=
 =?us-ascii?Q?oD8eORFiAlPURRaBGU4sdDENQ4WXy2q3K9VhPUihrvlFswmB9awEp6Ouged1?=
 =?us-ascii?Q?7k+fMTs/FctYsLEBiJSwrrxVLYu+l8szc4LRN9vRorWMZAyKye2mHLRpZzw3?=
 =?us-ascii?Q?TcC/i3JrHk6T2/eJIvyh1T8djEM5ocKd4hUMdrCN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4ce555-58e9-4535-977f-08db6080043c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:14.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en3dbFdSp8VP4IE4Y9oK+j0vAV4eJYN3w203LvKigLQS3gsoROPE/JW0O6f2FwgNW532gzrMhCAg3S/1fkA0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
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


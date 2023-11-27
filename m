Return-Path: <dmaengine+bounces-272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E87FADD1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D092281B8D
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536BA48CE8;
	Mon, 27 Nov 2023 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k4+9nW+/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674B10D2;
	Mon, 27 Nov 2023 14:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv7K8IL8NYIrnSKRLpIIacpdwIzKKe4wbBDAOUni+SiPkDbXoBARJHMe7Ho+swqRVW2rI7IOsMppfjhYwl9i/R8QIZ4qvZhPjPmf7lrDK2Ni9jHUMPse2mHeWBCBlp/eF3dCUKbedbDhZvnq9kYWF/NTwwn1D/nifjyVBZkGKXbrtRh1SWs5EdjkiKhSbpQKOAI6JfJri/6T+5YNjCG00uFvHvAluvG8w7Azx3WjuIZQ3/YnGTb/3CeKuHg7IP/GrZNxCIANseICwP5IIQ+Xi2qfjCL6B88rodkCz1z9rqYf4RrtAgoko7YufwKt2fBhN02WeUeZHZFUbVpBfghCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPF9eFzJj+YtSs5+HBLuPJfxztDwffR/ueEEA4VcWEo=;
 b=ZlGr+Lx+fR8tzUkhg+XfsHRoZp8t5EbZXacnwKbVMcbYbSt3GY6K7kvVbZIah/gHVocHgPSLB+nylUbVXTfHHnckMhXQWboq9aFTc8dACywWMWFcXF8PG5WKWHeNC75MOvDNJhVHeNI3s+Y5OSbxS5qO3PpnTrLpoZqLg3FAlPtmrz76o7ONhPI7X9jA3imSUfGaRi+JOfXTbIKJEte8daosyRHXGLmoybcPbcpUVXTD68xeroBgGEnCa6bAIisCcMoIBN3B76BShOq1ExJuWRPe386CJwiJuik7dfMeedYkO9ubFs5PPfRiLSQt6wNQI7xd8igM2XMiT+Dlvc3b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPF9eFzJj+YtSs5+HBLuPJfxztDwffR/ueEEA4VcWEo=;
 b=k4+9nW+/CkmaYAq4WyzhaQfo/TvhBBMOr2Z85YE6x/Dwt5dCABQsuVAoaWLF+vBALKufI4Yr5JlyyDVPOzSCg+NMl4/lHd5i4iRtAKRo+8uL0d8B8k9yUCAI53m5lu18jqk0ACpViwDFq1+ZW1CN4Wvq+k+PwqrDJ3hKZsf3GZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v3 6/6] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
Date: Mon, 27 Nov 2023 17:55:42 -0500
Message-Id: <20231127225542.2744711-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127225542.2744711-1-Frank.Li@nxp.com>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 8922e824-c887-43bb-9302-08dbef9c13c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oaDmpj8i7T0WaHY3XELWirGcmxUnXbeKUhqnOFuga9m+YjrOas8C0qKq3bXJNW/fv3cxCmiUuoxApBWSfev3uDzgwwS6DOAUm7qqJVeohgcbULHjOerfeRGaesAv8AIEWaXPfc1fhxY72l3U+xBcNReT6JAMJiPsQShqxCXKf62C1WQkZ1CZpJSG6JeAp3UOoHE7EdmdW5P2NAK2KC5k101s827BreKfbzcv8f2iMTcIvjtXkOsnZ8RSlffJL+c12iEZ9wWvzuORYC0UUn/eAzr/knoHjmcLXuwebo07KQSr6JRqXSA6WbwHwlB6KhttjYqNsDin+J6owivIkT/yBl3ZYR4aA0P8JaXy7QXBs8wTBhQU4ikq/Kw4C0GmLTBTKwj1WUaalOZoYctwO3lcEDRV8xS+zseUnSV7+xh0uRbw+ykOlBVYnAX12YsPtcPCyOXi8cZL34G9yy7BiKjfxRyNksCz9lcd2jRp0oYCpWam2/CbMuOHTxaZQoVdOmOG40ZwgxwIo5FtMcPf3Lob+Qw8k2JRgLvy65BGzFzV74t1VqJucAXo30RX8tyPH8i+q+wWSZJGUAlwyUTxpFUuL9gosi/3BF/ZSwNh2M+xZWbFcmq03hGS5qGU2vb8a45U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(30864003)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GXgDqpg4k8yn2g/NnQKzbUZjgofzlOPdUOmFzYDTqKWPiPoBnPCZFHUpa4pE?=
 =?us-ascii?Q?XTHTJpbMCYZ1tTIaVNzASGG7bkhDLPOk11rx89yygn9RH86PBYUf9Z1H/RFr?=
 =?us-ascii?Q?AHY7CWDy04kE0eX7X8nauPOSdZ9uxnCf7VqCR09wjhfUcnJwywYwwNLYo9cD?=
 =?us-ascii?Q?z9dptwAnIt/tqsJbCU5OkfWDSP6NrbGy6ldECXoRYVV/bSEdkwo17f38XBUb?=
 =?us-ascii?Q?2zcE9li5ha1FS1M2daVyX/5JkfqortmqupmWZWC/1BcBl6A18gOjS+8jt4To?=
 =?us-ascii?Q?Ph78ODHJYIjZDpXbHPLKsQGIuz1LJDy30MtlBvdqnt4Wvr8q+dJVj9MNa2Py?=
 =?us-ascii?Q?c3k3NWEc6kAWmRtHl3fNEIHzWUeGYXFK65qdY6r4jQHKwNbkfRtvT8NAltCB?=
 =?us-ascii?Q?pXYZ1AAi2DJEn0Zaqoi+c+mPsrXtAacn+7vERwUGNvlKC0os9viYY9uOKYwy?=
 =?us-ascii?Q?+90W05b1JyTG5vwMdIiAtIe9fTIbNdudpCE6MYMLhUnZsUcLqm2TQANRLVdN?=
 =?us-ascii?Q?nzynCVMb+i5IoavhEkcixZE+9sqRWjuSpxm6lr6K/Uprct6bnGDYdaQopAE+?=
 =?us-ascii?Q?oAZ/3xXDQTxDYnS2Ceji9g9oMJFtNHCBYXIbm1OVVNu24cU3SnTmvd5Pl04D?=
 =?us-ascii?Q?7JilysepmVo8AB1e1/ksafkVKUuiPUVssSLYsJzln3GZzJuBoYSIEPyFjSi5?=
 =?us-ascii?Q?JHPmKxBHhEbIw6hJaL93Yx7wsXms2KktLaZP9EPn5axHhR2+jCQaoTzuAHbQ?=
 =?us-ascii?Q?J+AkaZ+RI4gYNMJR/X82uRl4tf6+z85Z7x9nkKO+EbCTudOrSaQ+4/4pbi9D?=
 =?us-ascii?Q?3juC7KLM3wfHgT35SV5WEXDGnSjCWo/5vZLBf6M16gm90v9yTZHDjcwGjB6p?=
 =?us-ascii?Q?gOnrEEPCdnzlEdju+0wJcQHyyOGRRXvWxvT/sMXW2Z2we7sRw+t9IOg3HLzA?=
 =?us-ascii?Q?18qio8rystepaHTAuMHrabJV3dV8i8jH6ZWyxQERzQNRBAG035D0GjyDDZRP?=
 =?us-ascii?Q?CCnsqTgcLG95VMe9mtxSLBlgEN12NGmrISRgRAapYYVIm0RZv2IkeYISbmpy?=
 =?us-ascii?Q?4W+j1yYr/1v+ZOms5v1OgppL0A6j4fDEO07HNCsdXdIPmzaFSeAZpjrmE6fL?=
 =?us-ascii?Q?+VjOZjNk9T4L5YgxDXOMMUucJS97c3zlDBmKXx2GRuzYR/msfCKv4TBlrj/g?=
 =?us-ascii?Q?XvtnJrNQLrqJ13rFnXNZu5IdPutKWTf+0Czx5sIwRfY8R6Zmg7azDttOyNqY?=
 =?us-ascii?Q?SehWDdyYGDb0puCitM61o6GvIDQjO9C0wgx+z5pbBDSobirWf5WnAwouWki8?=
 =?us-ascii?Q?i2v8jItLaNY1lFT/NeD581a8djl26rftOKi+fjRFOVpK5k7HbsbnhtfqfC3z?=
 =?us-ascii?Q?txs64B7i16ld6LLOV56oy7gdiwgE5i2+4osbbX6CoCeJhR+Btfr30yBC10Gf?=
 =?us-ascii?Q?XiakHJsb4nL3nLoZ/T9OnQmadK3iTtVOJnmQ1tCLLJMrW1u9yYzHr1ZdjJuO?=
 =?us-ascii?Q?5b/WbwVHCxnXI/ML5lCQbaChfpO4xuD0jDD5lsDcvqmJde8YNh0V9SIuHmVb?=
 =?us-ascii?Q?6E4JfcED8hWnCVkvx9k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8922e824-c887-43bb-9302-08dbef9c13c7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:23.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1U8nfQmjhd5LD545Xqk/aL/JWe1FoUtIFqAiVz4tubKO1OJ/CqkkKvFkD+U/1SYC94VQ174TOIIKuEYvwAtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

In i.MX95's edma version 5, the TCD structure is extended to support 64-bit
addresses for fields like saddr and daddr. To prevent code duplication,
employ help macros to handle the fields, as the field names remain the same
between TCD and TCD64.

Change local variables related to TCD addresses from 'u32' to 'dma_addr_t'
to accept 64-bit DMA addresses.

Change 'vtcd' type to 'void *' to avoid direct use. Use helper macros to
access the TCD fields correctly.

Call 'dma_set_mask_and_coherent(64)' when TCD64 is supported.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  34 ++++---
 drivers/dma/fsl-edma-common.h | 165 +++++++++++++++++++++++++++-------
 drivers/dma/fsl-edma-main.c   |  14 +++
 3 files changed, 170 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 65f466ab9d4da..c8acff09308fd 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -351,7 +351,7 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
 	enum dma_transfer_direction dir = edesc->dirn;
-	dma_addr_t cur_addr, dma_addr;
+	dma_addr_t cur_addr, dma_addr, old_addr;
 	size_t len, size;
 	u32 nbytes = 0;
 	int i;
@@ -367,10 +367,16 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 	if (!in_progress)
 		return len;
 
-	if (dir == DMA_MEM_TO_DEV)
-		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
-	else
-		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
+	/* 64bit read is not atomic, need read retry when high 32bit changed */
+	do {
+		if (dir == DMA_MEM_TO_DEV) {
+			old_addr = edma_read_tcdreg(fsl_chan, saddr);
+			cur_addr = edma_read_tcdreg(fsl_chan, saddr);
+		} else {
+			old_addr = edma_read_tcdreg(fsl_chan, daddr);
+			cur_addr = edma_read_tcdreg(fsl_chan, daddr);
+		}
+	} while (upper_32_bits(cur_addr) != upper_32_bits(old_addr));
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
@@ -426,8 +432,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 	return fsl_chan->status;
 }
 
-static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
-				  struct fsl_edma_hw_tcd *tcd)
+static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan, void *tcd)
 {
 	u16 csr = 0;
 
@@ -478,9 +483,9 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 
 static inline
 void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
-		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
-		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
-		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
+		       struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t dst,
+		       u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
+		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->cfg;
@@ -581,8 +586,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	dma_addr_t dma_buf_next;
 	bool major_int = true;
 	int sg_len, i;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 
 	if (!is_slave_direction(direction))
 		return NULL;
@@ -654,8 +660,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 	int i;
 
 	if (!is_slave_direction(direction))
@@ -804,7 +811,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
-				sizeof(struct fsl_edma_hw_tcd),
+				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
+				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
 	return 0;
 }
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4f39a548547a6..6afceb9fded1b 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -87,6 +87,20 @@ struct fsl_edma_hw_tcd {
 	__le16	biter;
 };
 
+struct fsl_edma_hw_tcd64 {
+	__le64  saddr;
+	__le16  soff;
+	__le16  attr;
+	__le32  nbytes;
+	__le64  slast;
+	__le64  daddr;
+	__le64  dlast_sga;
+	__le16  doff;
+	__le16  citer;
+	__le16  csr;
+	__le16  biter;
+} __packed;
+
 struct fsl_edma3_ch_reg {
 	__le32	ch_csr;
 	__le32	ch_es;
@@ -96,7 +110,10 @@ struct fsl_edma3_ch_reg {
 	__le32	ch_mux;
 	__le32  ch_mattr; /* edma4, reserved for edma3 */
 	__le32  ch_reserved;
-	struct fsl_edma_hw_tcd tcd;
+	union {
+		struct fsl_edma_hw_tcd tcd;
+		struct fsl_edma_hw_tcd tcd64;
+	};
 } __packed;
 
 /*
@@ -125,7 +142,7 @@ struct edma_regs {
 
 struct fsl_edma_sw_tcd {
 	dma_addr_t			ptcd;
-	struct fsl_edma_hw_tcd		*vtcd;
+	void				*vtcd;
 };
 
 struct fsl_edma_chan {
@@ -144,7 +161,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
-	struct fsl_edma_hw_tcd __iomem *tcd;
+	void __iomem			*tcd;
 	void __iomem			*mux_addr;
 	u32				real_count;
 	struct work_struct		issue_worker;
@@ -188,6 +205,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_CLEAR_DONE_E_SG	BIT(13)
 /* Need clean CHn_CSR DONE before enable TCD's MAJORELINK */
 #define FSL_EDMA_DRV_CLEAR_DONE_E_LINK	BIT(14)
+#define FSL_EDMA_DRV_TCD64		BIT(15)
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
 				 FSL_EDMA_DRV_BUS_8BYTE |	\
@@ -231,18 +249,61 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
-#define edma_read_tcdreg(chan, __name)				\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_readl(chan->edma, &chan->tcd->__name) :		\
-	edma_readw(chan->edma, &chan->tcd->__name))
+#define edma_read_tcdreg_c(chan, _tcd,  __name)				\
+(sizeof((_tcd)->__name) == sizeof(u64) ?				\
+	edma_readq(chan->edma, &(_tcd)->__name) :			\
+		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
+			edma_readl(chan->edma, &(_tcd)->__name) :	\
+			edma_readw(chan->edma, &(_tcd)->__name)		\
+		))
+
+#define edma_read_tcdreg(chan, __name)								\
+((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd64 __iomem *)chan->tcd), __name) :	\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd __iomem *)chan->tcd), __name)		\
+)
+
+#define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
+do {										\
+	switch (sizeof(_tcd->__name)) {						\
+	case sizeof(u64):							\
+		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u32):							\
+		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u16):							\
+		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u8):							\
+		edma_writeb(chan->edma, (u8 __force)_val, &_tcd->__name);	\
+		break;								\
+	}									\
+} while (0)
 
-#define edma_write_tcdreg(chan, val, __name)			\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
-	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+#define edma_write_tcdreg(chan, val, __name)							   \
+do {												   \
+	struct fsl_edma_hw_tcd64 __iomem *tcd64_r = (struct fsl_edma_hw_tcd64 __iomem *)chan->tcd; \
+	struct fsl_edma_hw_tcd __iomem *tcd_r = (struct fsl_edma_hw_tcd __iomem *)chan->tcd;	   \
+												   \
+	if (fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64)					   \
+		edma_write_tcdreg_c(chan, tcd64_r, val, __name);				   \
+	else											   \
+		edma_write_tcdreg_c(chan, tcd_r, val, __name);					   \
+} while (0)
 
-#define edma_cp_tcd_to_reg(chan, __tcd, __name)			\
-	edma_write_tcdreg(chan, __tcd->__name, __name)
+#define edma_cp_tcd_to_reg(chan, __tcd, __name)							   \
+do {	\
+	struct fsl_edma_hw_tcd64 __iomem *tcd64_r = (struct fsl_edma_hw_tcd64 __iomem *)chan->tcd; \
+	struct fsl_edma_hw_tcd __iomem *tcd_r = (struct fsl_edma_hw_tcd __iomem *)chan->tcd;	   \
+	struct fsl_edma_hw_tcd64 *tcd64_m = (struct fsl_edma_hw_tcd64 *)__tcd;			   \
+	struct fsl_edma_hw_tcd *tcd_m = (struct fsl_edma_hw_tcd *)__tcd;			   \
+												   \
+	if (fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64)					   \
+		edma_write_tcdreg_c(chan, tcd64_r,  tcd64_m->__name, __name);			   \
+	else											   \
+		edma_write_tcdreg_c(chan, tcd_r, tcd_m->__name, __name);			   \
+} while (0)
 
 #define edma_readl_chreg(chan, __name)				\
 	edma_readl(chan->edma,					\
@@ -254,24 +315,41 @@ struct fsl_edma_engine {
 		   (void __iomem *)&(container_of(((__force void *)chan->tcd),\
 						  struct fsl_edma3_ch_reg, tcd)->__name))
 
-#define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
-
-#define fsl_edma_le_to_cpu(x)					\
-(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) : le16_to_cpu((__force __le16)(x)))
-
-#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)		\
-fsl_edma_le_to_cpu(fsl_edma_get_tcd(_chan, _tcd, _field))
+#define fsl_edma_get_tcd(_chan, _tcd, _field)			\
+(fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ? (((struct fsl_edma_hw_tcd64 *)_tcd)->_field) : \
+						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
+
+#define fsl_edma_le_to_cpu(x)						\
+(sizeof(x) == sizeof(u64) ? le64_to_cpu((__force __le64)(x)) :		\
+	(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) :	\
+				    le16_to_cpu((__force __le16)(x))))
+
+#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)				\
+(fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ?				\
+	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd64 *)_tcd)->_field) :	\
+	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd *)_tcd)->_field))
+
+#define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)					\
+do {											\
+	switch (sizeof((_tcd)->_field)) {						\
+	case sizeof(u64):								\
+		*(__force __le64 *)(&((_tcd)->_field)) = cpu_to_le64(_val);		\
+		break;									\
+	case sizeof(u32):								\
+		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);		\
+		break;									\
+	case sizeof(u16):								\
+		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);		\
+		break;									\
+	}										\
+} while (0)
 
-#define fsl_edma_set_tcd_to_le(_fsl_chan, _tcd, _val, _field)			\
-do {										\
-	switch (sizeof((_tcd)->_field)) {					\
-	case sizeof(u32):							\
-		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);	\
-		break;								\
-	case sizeof(u16):							\
-		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);	\
-		break;								\
-	}									\
+#define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
+do {								\
+	if (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64)	\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd64 *)_tcd, _val, _field);	\
+	else											\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
 } while (0)
 
 /*
@@ -280,6 +358,21 @@ do {										\
  * For the big-endian IP module, the offset for 8-bit or 16-bit registers
  * should also be swapped opposite to that in little-endian IP.
  */
+static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
+{
+	u64 l, h;
+
+	if (edma->big_endian) {
+		l = ioread32be(addr);
+		h = ioread32be(addr + 4);
+	} else {
+		l = ioread32(addr);
+		h = ioread32(addr + 4);
+	}
+
+	return (h << 32) | l;
+}
+
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
 	if (edma->big_endian)
@@ -325,6 +418,18 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32(val, addr);
 }
 
+static inline void edma_writeq(struct fsl_edma_engine *edma,
+			       u64 val, void __iomem *addr)
+{
+	if (edma->big_endian) {
+		iowrite32be(val & 0xFFFFFFFF, addr);
+		iowrite32be(val >> 32, addr + 4);
+	} else {
+		iowrite32(val & 0xFFFFFFFF, addr);
+		iowrite32(val >> 32, addr + 4);
+	}
+}
+
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index d767c89973b69..c2c0c3effc8cb 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -364,6 +364,16 @@ static struct fsl_edma_drvdata imx93_data4 = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static struct fsl_edma_drvdata imx95_data5 = {
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
+		 FSL_EDMA_DRV_TCD64,
+	.chreg_space_sz = 0x8000,
+	.chreg_off = 0x10000,
+	.mux_off = 0x200,
+	.mux_skip = sizeof(u32),
+	.setup_irq = fsl_edma3_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
@@ -372,6 +382,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
+	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
@@ -513,6 +524,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (drvdata->flags & FSL_EDMA_DRV_TCD64)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
-- 
2.34.1



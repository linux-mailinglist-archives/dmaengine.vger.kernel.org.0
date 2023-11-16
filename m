Return-Path: <dmaengine+bounces-124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F1A7EE945
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA784B20A44
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C030F88;
	Thu, 16 Nov 2023 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jZl6KKGN"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88E120;
	Thu, 16 Nov 2023 14:28:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVj5M49EA/Posn4JGxsoH4lb/68tEF5h57IwcQ8Ofdiw1iMUSCnKp/NyFS1ShLkb3/grMXMXv1QpsvXsqgTr62R/9EPqpX3USKBGFKog1syE1TvIusPtRoDNRsabM0gqNA/pgOvdpqmPGKmEIaBv2GxETWw2f5Y82X4zH0lrdmzbGUR7ghd9uVW37XlU9jfClYDxTM5ZeVUO9bV+qB0dsQKAs6YLbSnHIQtVppO7ZejGV1oD4GuKH//bm5gwppFbHbFzFWqeK+d5pfItFRIs2r/PvgDtYlOXZ6KIjxZ2Kf2OSdeCpNJJe2tXIBleK3qzCClqZ02r2VIFSouucnOF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2XQt4JIaqObQeTZuxDk9jSe/68X6I+DIUzJY4ku06s=;
 b=UL8rILpSie1C6YCgZHy5DAIQWfBvLQ7ewI62rP29PkXcH8H3PlAcbX5a6PJdYks2XlxabLw7s6AG6OjF5bIlpx7iMfazyl02IT4gTJSmXStZvJkoJCGGDhzDSa3LFaq+PMizdrdZCEXEroRrLz6u6ZjDm1HIfR3e6JD3PxjtOQ5uNQWBrTcrqYYu6KyeH85e0pMiZg1e8cZxthnXS/oZhHf5qn7Smg2G9M9NbiGT6ytCQ3T7c5TEiGTRk7ZvN2OWDjKf+u/lzKufW5GgPztowlcbIcSonoWMerg78u2xkcrVplMIPcEkI7UrXgWwZbQ3ArtiPK1CPCn1oyH6sRUsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2XQt4JIaqObQeTZuxDk9jSe/68X6I+DIUzJY4ku06s=;
 b=jZl6KKGNrbLgAHCAEiSXka50autTpKuIR/cE7T/x0juhnu+PMOrit/G/VUu6rgxX0dy5SjH+dzMWIrRwnf7kajxnq7eGvVgO5AYktYNm7LAEDxKuoW0v6aMhKoY+ygO3d4+Xj7AmKYSf7yBE8LJ5VvLJln8FJFCpXfXhTS3B4ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:17 +0000
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
Subject: [PATCH v2 5/5] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
Date: Thu, 16 Nov 2023 17:27:43 -0500
Message-Id: <20231116222743.2984776-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116222743.2984776-1-Frank.Li@nxp.com>
References: <20231116222743.2984776-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 846345c7-bb57-4c07-d6d0-08dbe6f35454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hKnIR6CqdH1FekT8TXN9HSzJ3Y1xm1nR4J4Pgj11Bb9F6K5vZYXPqytVBmETGbEe7i5AT6srHFOl/Jtsar4DSvD6vpOnDHwUIWPgEnZrfGKs/eDNLabtlSX5ejqmEaGO0ri71jF7Ac520Rmb+l5KQC1lKEMJJrxOoxZtWtRhij3nxLW6C4KB2SAzeabgbzxtr7KE/X+1lj3P/wGbjgckZz3SWiQ3u3EXCp/1vi6L5VC4Nl6rKLZGuNVPGuAAZyMIdykjPPiF3Umj1vtG7epp2Dls/+mUjpQD7DfwcmXtExuaYsv7qhZRpGLj0jcdgy3a0t1m2m00YmNcPnz/SCkao7uEDWz8nw6Nr5mLz1bvUrHXYkUmTmVCwznh2/kB6xok4laF+2oJ9jHs2kFH6wyJfwqg09fSz48OhxXPS0N0oxRutN9qqJQHirZB/3jsU/pjh8bmSTZjjOqpT+9W6CtCN9U2+T0ICYonNxZ9EG20qvGQs0X/ib/yMD53g07aeb7m71iUBvmgc+ErHNoJV7Uox8ySBUY0Cr6K7ZXYms+bqHkHAcqLa1DfkAUHbIAJSqS0UUptAry4a/l5o7q/o0oEh+3XjyDVcNCK5+mT+1EKNIOsde7ulgNuH1bynXPOlrLd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(6512007)(30864003)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXi9gfG/ezwnC6EU4GvENIx+m3HocVxfTzFVYvjaknI01bdGJnnB5anrY6eU?=
 =?us-ascii?Q?CAhbLi0lNG+7oax9fQnw4d4C/GKqYAfXT2Q29CSXuOr5v9+Ahxp3sl0ZS0Xc?=
 =?us-ascii?Q?nkwR317JBkhdtC+XO8BXBddcLGX8mBvtnLLOfAt/LnV7uZ33aSt4LuaNFUR0?=
 =?us-ascii?Q?8zyc6n4T2z5pXjzEKPzP6WOkzjzsGg0FgBYWl2uBDmQeb0ynWEbN9I0OpxJv?=
 =?us-ascii?Q?Af5P2x8PRLLUSa01wMbmg4dpyivTaWu4knftbIqxcYM0ft0w4O/UHEYHCP5b?=
 =?us-ascii?Q?w4zFUrNVJO6CvMybabBqhdqwvNMnQRhpi8Ob9SCxQ8cAkYCqRrfo5FSZwn46?=
 =?us-ascii?Q?o0jDv7NHnSzhw5E5E1uCLKtE8+MQE2dQ0z5ywSBtwKOiYr4ScTF7Kg9i1XSo?=
 =?us-ascii?Q?Sz92IpZrFE8eSYKD0Xj0XsEL1A2abr551o+WOkm6FfTqJrkf9KgzTgC8vBXJ?=
 =?us-ascii?Q?nFzFCSjoVdU/eCwq6o2nzlxW6pPwpEbid4wX1Ij9dCoacT0p3H45D3WIXwWK?=
 =?us-ascii?Q?Rzy7ThglCtFld4Z95c8FcLwdP3Gp0KAa0YF1YgHhJepdy1EXPOo1MI/4ni+t?=
 =?us-ascii?Q?2Kf17Ysbo0aQKfGIK5sqjs8RU5BxYLXI/3qXrsIsXY+VXSJoJguQN0pyG4kD?=
 =?us-ascii?Q?iZJj53XeVPHEDA0aFdmQoASvBLrP05WDsV/s5QzMTj2cY+P3Wt6aAxMP7b+T?=
 =?us-ascii?Q?THNXiKTt7PmbGhv4Wyi7kNG8k8If7o8EdYsL3E8PWlgJ3nvUdgCrB9UbR/MI?=
 =?us-ascii?Q?gFSa4AduBhhnUVcRpMdxPjgyV9Iyf69vIKxBpR5EMVVq9BzseZIv6baJXeJL?=
 =?us-ascii?Q?A44UAdOzHP4h7n7rS71J+hpZD4B3K6qu6rhv34t+RoH51bAD+wtAJ3PCUTmC?=
 =?us-ascii?Q?o7ucVK5xkUAIox7+2QOKHJ+aLLb4ODlWoOeKYUeyt24bJk4cGwk1gz8lx8+d?=
 =?us-ascii?Q?BHbAt2d/s1iv60wBKGcpNtcooNmTKGklQyK80aOtSUaNaIRnKWpDZQiU0lHb?=
 =?us-ascii?Q?QcYf8IhP5bUgOVNqb5ae5yU0ex3rFWqPRbAnBf1xuBZi842ZwrEq2lzlji/D?=
 =?us-ascii?Q?6ybzB2g0TP3ZU+aikktOGn3Fw5VxOaW5Xf7uB01M01jpcgVkj5W1JXU4L25l?=
 =?us-ascii?Q?gKeqG/TSwaDLYheNJrlE9FkkEDesFLXigzK/dDKlRXkr8VPoRreeKSddkTjj?=
 =?us-ascii?Q?AJ+57+fawtKVLRwWuGRZ+fGLvoiW6UoOaTkT0wlsDa8/LfB8KpM11MybY4AK?=
 =?us-ascii?Q?wdeb72EdDrurY0di1PwTpGQT5fZBmGaATyDKgBt8GehAnwT5+hAgqHqpKdZD?=
 =?us-ascii?Q?N3Gsq7/eiPqCeRdKCHojGp3WjULdCebJabvj72wyYRkbf6wxqVwI/xCTvQRm?=
 =?us-ascii?Q?MGo5gULOxgDy0QI/4coEWn+K5bZKKK5BreMk48p/nY+KPo8TxCfjJCYfEaZV?=
 =?us-ascii?Q?GZSzbHOhxb7tfs5hsNOkqdG0FGiwV2rZmNkalRIX2wgs0RwdXKxMG9AKTUVR?=
 =?us-ascii?Q?/1GJnnzZvIrhSuSOpLPB9UGfR1hDc1MdqHc6GQE/94EAJ4mdH0tECqi7bVuI?=
 =?us-ascii?Q?SoB77xB1u6DnKIlO1yu1mX0K56k8l4eztFQZbcpJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846345c7-bb57-4c07-d6d0-08dbe6f35454
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:17.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yITST4IknLqwvwP7N5iaAKQcCosja+WVV960uhj7Gf1XyJWLGsjtvAiZUfidtqaOrn8O/1x7mjfNDuwdCYh1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

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
 drivers/dma/fsl-edma-common.c |  34 ++++++----
 drivers/dma/fsl-edma-common.h | 117 ++++++++++++++++++++++++++++++----
 drivers/dma/fsl-edma-main.c   |  14 ++++
 3 files changed, 138 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d29824ed7c80f..ed7da18b79262 100644
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
index 6c738c5cad118..432d5ae798ae4 100644
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
@@ -231,15 +249,44 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
+#define edma_read_tcdreg_c(chan, _tcd,  __name)			\
+(sizeof(_tcd->__name) == sizeof(u64) ?				\
+	edma_readq(chan->edma, &_tcd->__name) :			\
+		((sizeof(_tcd->__name) == sizeof(u32)) ?	\
+			edma_readl(chan->edma, &_tcd->__name) :	\
+			edma_readw(chan->edma, &_tcd->__name)	\
+		))
+
 #define edma_read_tcdreg(chan, __name)				\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_readl(chan->edma, &chan->tcd->__name) :		\
-	edma_readw(chan->edma, &chan->tcd->__name))
+((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?		\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd64 *)chan->tcd), __name) :		\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd *)chan->tcd), __name)		\
+)
+
+#define edma_write_tcdreg_c(chan, _tcd, _val, __name)		\
+do {								\
+	switch (sizeof(_tcd->__name)) {				\
+	case sizeof(u64):					\
+		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
+		break;						\
+	case sizeof(u32):					\
+		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
+		break;						\
+	case sizeof(u16):					\
+		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
+		break;						\
+	case sizeof(u8):					\
+		edma_writeb(chan->edma, _val, &_tcd->__name);	\
+		break;						\
+	}							\
+} while (0)
 
-#define edma_write_tcdreg(chan, val, __name)			\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
-	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+#define edma_write_tcdreg(chan, val, __name)				\
+do {	if (fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64)		\
+		edma_write_tcdreg_c(chan, ((struct fsl_edma_hw_tcd64 *)chan->tcd), val, __name);\
+	else								\
+		edma_write_tcdreg_c(chan, ((struct fsl_edma_hw_tcd *)chan->tcd), val, __name);	\
+} while (0)
 
 #define edma_readl_chreg(chan, __name)				\
 	edma_readl(chan->edma,					\
@@ -249,17 +296,24 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val,				\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
 
-#define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
+#define fsl_edma_get_tcd(_chan, _tcd, _field)			\
+(fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ? (((struct fsl_edma_hw_tcd64 *)_tcd)->_field) : \
+						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
 
 #define fsl_edma_le_to_cpu(x)					\
-(sizeof(x) == sizeof(u32) ? le32_to_cpu(x) : le16_to_cpu(x))
+(sizeof(x) == sizeof(u64) ? le64_to_cpu(x) :			\
+	(sizeof(x) == sizeof(u32) ? le32_to_cpu(x) : le16_to_cpu(x)))
+
 
 #define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)		\
 fsl_edma_le_to_cpu(fsl_edma_get_tcd(_chan, _tcd, _field))
 
-#define fsl_edma_set_tcd_to_le(_fsl_chan, _tcd, _val, _field)	\
+#define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)		\
 do {								\
-	switch (sizeof((_tcd)->_field)) {				\
+	switch (sizeof((_tcd)->_field)) {			\
+	case sizeof(u64):					\
+		(_tcd)->_field = cpu_to_le64(_val);		\
+		break;						\
 	case sizeof(u32):					\
 		(_tcd)->_field = cpu_to_le32(_val);		\
 		break;						\
@@ -269,12 +323,35 @@ do {								\
 	}							\
 } while (0)
 
+#define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
+do {								\
+	if (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64)	\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd64 *)_tcd, _val, _field);	\
+	else											\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
+} while (0)
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
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
@@ -320,6 +397,18 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
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
index e7a847e010dd9..d0d59961aa072 100644
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



Return-Path: <dmaengine+bounces-64-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C37E7389
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 22:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE89E281458
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A4374F6;
	Thu,  9 Nov 2023 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OFfaF2ay"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6828374FD;
	Thu,  9 Nov 2023 21:21:48 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D604685;
	Thu,  9 Nov 2023 13:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdPAE4NWGITKcDrvtk7idmxnGbNnu57SZ0SLZomAcScVmPsaBcBGKozNdjldrMG3DutYQHc3JEVV+OYG7Bc281NtRZG5MyiDy0E+w3tZ+QBuuIStW4ozOyrzLC0Mw4tCTXnwDX7ibjVebehQOxz5sMRQSTRFmAVQ9uTRSmkx3hUvXm/526vvNT7ltlgF7HGXf2avSbFIZqSI1s7pRUcuBuuRDw/bSTsBx2fKgO3n2upnNMM4rS0AaynRP39FvGqVLrZPYG3vmkt6kOM+mTFG2aZBie33uf1dUS5ENkBcUeZgtFnkMJYTsjYZrzNxfLoAQd7VIELVbkKr/WB44N7yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQoHzXE3TwYgEcIHzl8oBzc/noDppXKryI9BbNaAIgY=;
 b=iqNa9SAN7fUcgMpw24RmhklCfcm0k+lnF+qR4jLOkPVpNwcCN1SP14k7S9jOO85e93pwfB1/MyA+foq0La3+LrRVv+QSXSNHWoaUAT4uqq7gAGt4lIF5wVFSEcJC4tnAA93GBgfIHtcHGY3LjBbUxZuNtZJP/Kj3syeE9aKwXOkRQDNoE1gCrZtjZcZlsiI/lrO+khHxni2iuCrjrWGaJf2301blqS+0v9DTXwRZ8ptupgJL11sfK+QX3SnXy2YXUyIFMq+YWhrWDWweVgSVEUVEJbD2NGMr0paw7yvGrcIuhUmbksbbMWdupO1YWnwm54MCYDZYEiRjRvo3XWBAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQoHzXE3TwYgEcIHzl8oBzc/noDppXKryI9BbNaAIgY=;
 b=OFfaF2ayNat4ilhwOuUcMwG/537vOV97qmyOQ5IPDTPj62KYRqHN1LdFq+7fIVoVNn1LMfClOpUEIYUXipWU2lpmEs/MQaL7E1kNuBwcsMagmleV9ogRfK7366TsNfGsz4KQtpFmj5P+IMvWsDRyvG+XgqaInlHy7K7BXrGIn9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 21:21:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:21:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
Date: Thu,  9 Nov 2023 16:20:59 -0500
Message-Id: <20231109212059.1894646-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109212059.1894646-1-Frank.Li@nxp.com>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 2206fc91-5f89-482c-2d8b-08dbe169dfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n/JjNewS9qlcbOkmUvW+hSEwZeHAE3en2DU+LztWMKOohb+MFUaVzWqYF6NgeFWIOJLfoY5Ep4CNIJRgzmGLbU6eQJlZcmuBwaO8iPHg1Cb+aoy0RP3ALd+NxNHOQ400ZftoEoqan6qz+KAK4+E25LjfoF+dMVtrVHH0BPzREvgNk44dhhrceIRmmobCS7gku6D7YrTny0ZGA/okS79Kk1ze9NEyDEMUhKnnPDAFel2ououGk6X10ZcurL4wmHno0muu5TOW6CwuFKmuMn07UfmYukNhlk5bpVxufxmbp3VZldkpgt/gE93rQB3LKc4ngQ1pMky34xRahi2bIrThhdQVv8RlnAzAuYBsqQAF7lTRQfrZdL8FfJkMDZkZreWNrw/HqIKpQQGo4JSifa+iuIX45u1gi6ZX+lPHsqc/awSmiT6gsCZJOT+6AIPD4brus2bjew2N5EdDoydhp54VbRpkufR7v05CviPvEMxXVFpIA+G4FiVWj3rtSsOmooeDKiTS+LRaAvXKC8jKDOsvtJBs6kqrVYeRrku8sHrpIpw+uiF3TGw5AuNcD/zve0AEcU3bFFQdi/2rZImouUKmkWD5hTlRWA6vqa2JvmqWAghRqENXNxGtx3fgcwIQIXu/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(37006003)(1076003)(6512007)(6486002)(52116002)(26005)(66946007)(6666004)(8676002)(83380400001)(8936002)(6506007)(4326008)(34206002)(2616005)(478600001)(5660300002)(30864003)(86362001)(38100700002)(41300700001)(2906002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xf3/a0og4/FKGMc52Fp1AE6OsVdk+hwtjfFRpioq7ZB2BOB+cLxyuKXgMNQY?=
 =?us-ascii?Q?EygRIfcjbYU8mBCtj6ikzgrvvlRT00xe8fkHIv7gW3hfZ1wv2OgCwRhBzSXQ?=
 =?us-ascii?Q?EcTK+Zx6Wwjho16FLrizTizwffzZEKJuKeHNM4MUIggrgoRuFRkt6w700Nlm?=
 =?us-ascii?Q?A74CD1SI5bed/HS7S6rGVtCf/KZLTCXozC95SctHnXy7tlSjdd1f8OnoXzX0?=
 =?us-ascii?Q?bjxsSCxBVdCAcTiHATWKSWzH4GMOlb6A+AbuyaXb4q283pB74QdjTmeg6LYB?=
 =?us-ascii?Q?rUWa9yfHXRV/CRL5avwaia0R8+CdvvMBdgrzudh1Zzg0OFePlQOf/Glv/rA5?=
 =?us-ascii?Q?89Pw6yRidsoDRrto2oDkvdnVy2QIflP/KFVnKv5HHpKPwO/HNT0ODxxFFkdT?=
 =?us-ascii?Q?47bJVzwulBXsc9lNzkgQQ6u3Rhp/5+teeZU2L673dQmXJC/Eflc63MFYmJ/9?=
 =?us-ascii?Q?j8aZTz65JWFOSGBuBwKGpMRISep4srvQO3MIQFAbgJbWuQSnv4mvdPyKqFLy?=
 =?us-ascii?Q?NVu1Xk47sR6YicIsh5FiArZsfbtQ+SMq2G2VGDUgrjvXHC3561Olq2MXC6Wh?=
 =?us-ascii?Q?1YPlCw5KIopS7WT1x62iAmKGHrLofdYbLerVC5KGlu8OVZuPujXi3fmN88sQ?=
 =?us-ascii?Q?Y3hP1swIZVq87RIPLJ+xtfGMiZfN1p8wD7C5P1dypEW/94pUhyZqNewvPT8s?=
 =?us-ascii?Q?293ZX+jMPinDA6M4aL5xSuOJtSgqBzb3FiGgBMFPRsFDYcxffSNS5GknVxJC?=
 =?us-ascii?Q?0xPJqr0HvSh3wPamOcAG0P+ZnrlllEczgIQsyEbbuJ1cwIa38vRpupXMEvnk?=
 =?us-ascii?Q?AkjfysItsmL8jbuPs+ETRD+pFLTGrvFghysodTbINY5prWGofH5ihTyw+qIB?=
 =?us-ascii?Q?HcxwZMNiA567tuSm4gxFfdtYnChHHTkTz+ETaXO9QQl/zrnddtbjFOWb7rhA?=
 =?us-ascii?Q?KHf7/iJBP6ranFcum8MOD5CClvobGP+UWvrDVC8GZlt3Z7SJQxdSbMqvYmVL?=
 =?us-ascii?Q?uP1Hs0vJjml9B3dhfcUwdv200j4WONZaaAFOumJhYIyBcXQNXLFd07BNSY91?=
 =?us-ascii?Q?LB41+hR5Hzl9KFn/33YuGHn/Elq1JaAsv9SmbqgRAf4R75oK6eetuMy8aB7d?=
 =?us-ascii?Q?gFry5KYd31A38/RzO/Mxfe+iS9uOPdD97HygaKvb+1IETDs3oaisVXz86yzw?=
 =?us-ascii?Q?yWYf4MacFrVFWtNNQiSJEidKJVGm/v2iTifMrUiHoiezPIXjjVl22QUXrsKu?=
 =?us-ascii?Q?hclDA5/zIwEeMaBeU4AIHpk11ECQAGx0yBOhyFNp9uMwKgiU7sv7/dTKVA8A?=
 =?us-ascii?Q?IkvoW3gMqxH4SCSgYrchYC6rC7OdyqBtj8ACtbEvQRIMxVUYGBlbsiVUH7Ug?=
 =?us-ascii?Q?jH+fJ+7wWSAsJx3NYuCN14dLfbttHMnSwm0OCylNHJUTsVYqgfBw+9WD0DfU?=
 =?us-ascii?Q?o6l3uH7v1ndFyuwBzsug7KLVbEcQwlDILrHCcZNupWSCNirLrvvCMdpN6cl/?=
 =?us-ascii?Q?r+Oh7i8HkrKN8jn3CGoROpXZWkmIIj94HHigMShn9ml59Ml1DLpeuV/vMRH4?=
 =?us-ascii?Q?BZMtlO6b1BcB18D2Beo4kovkW4AWbyjy3SdIaM94?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2206fc91-5f89-482c-2d8b-08dbe169dfb5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:21:44.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdJR3aUcMzlaHYKr2LRYHZ9Rbcm2XW3yGygChToHc11Qz2aiAr5BjyWJSWzqTf8hQYjuZadFhyKYnojJSgpa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

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
 drivers/dma/fsl-edma-common.c |  18 +++---
 drivers/dma/fsl-edma-common.h | 109 +++++++++++++++++++++++++++++-----
 drivers/dma/fsl-edma-main.c   |  14 +++++
 3 files changed, 119 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d29824ed7c80f..47ab4db3d98ec 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -426,8 +426,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 	return fsl_chan->status;
 }
 
-static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
-				  struct fsl_edma_hw_tcd *tcd)
+static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan, void *tcd)
 {
 	u16 csr = 0;
 
@@ -478,9 +477,9 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 
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
@@ -581,8 +580,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	dma_addr_t dma_buf_next;
 	bool major_int = true;
 	int sg_len, i;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 
 	if (!is_slave_direction(direction))
 		return NULL;
@@ -654,8 +654,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 	int i;
 
 	if (!is_slave_direction(direction))
@@ -804,7 +805,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
-				sizeof(struct fsl_edma_hw_tcd),
+				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
+				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
 	return 0;
 }
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 6c738c5cad118..5357dccdc1a40 100644
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
 
-#define edma_write_tcdreg(chan, val, __name)			\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
-	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
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
+
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
@@ -269,12 +323,29 @@ do {								\
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
+	/* ioread64 and ioread64be was not defined at some platform */
+	if (edma->big_endian)
+		return swab64(readq(addr));
+	else
+		return readq(addr);
+}
+
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
 	if (edma->big_endian)
@@ -320,6 +391,16 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32(val, addr);
 }
 
+static inline void edma_writeq(struct fsl_edma_engine *edma,
+			       u64 val, void __iomem *addr)
+{
+	/* iowrite64 and iowrite64be was not defined at some platform */
+	if (edma->big_endian)
+		writeq(swab64(val), addr);
+	else
+		writeq(val, addr);
+}
+
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 8e5ddeb5e887f..84a5e0666d4f2 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -361,6 +361,16 @@ static struct fsl_edma_drvdata imx93_data4 = {
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
@@ -369,6 +379,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
+	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
@@ -510,6 +521,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
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



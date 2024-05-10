Return-Path: <dmaengine+bounces-2012-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF378C1CAB
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA8B21C4F
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66154148820;
	Fri, 10 May 2024 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ncxFaTeo"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCC13AA47;
	Fri, 10 May 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310180; cv=fail; b=BhRIj8Cj2bPbaX5+zBrkCCQ8FgaiXLKh453FVd3McB3puOVZsvj87jW4FwjztVoK2X0edWqepLbok0YM+T/corwyA/1mPBtQd453wGMls8TFj6BRQzeDuLQz4NABgzVqU+4LRxgjH2/MLtZtLoGtrQ4Amdo2RptzjtTTYOnJ0YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310180; c=relaxed/simple;
	bh=CQz7wwzJNKtlzy17QhhqI7UCnO5gZ8jOGlea1Lb33TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U3KYoXaBxoWSbI+RDhiqPFquWDDzOXps6t9KM1cuRbiH1P7mpSGBBBeyRTvElWzBFKvR5q+r+Z27IMLsU5nqjpIJDKRFqeBNnDaCIiGmmigfJeX4CvVN6FvpTfjFvkNJDsQ2PMedez+Q58e2DdTDYGhJjHPRetgFsPIQGE/EXKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ncxFaTeo; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgAVqrQMBOMdVXl+WSuWJaJN+jeB/0TBhCsTI2aq3oZkZRe34SwkRsX4ciTYEsJXD3EykKwInl+r1THuOX3YRlr5rQwp9veZCLV0XyfN+crQg6q8assP61owffoTeTsfpc2n+GvVaFO9/9YV4V1BtUJRfJ5o2wB7wk5MxG/paHsCUehg9gIakgyjoi8lhIALTdmptq1B9tLe67PxuHfe0EcnwjQZ9le9f6BWl3QEIf7I8HEzO/wPjR7f/POTLXmhggpRTGbl7HIzH8qPHNcK/TZcXh2Q7NO3yt4iNraerXaufs7jBa9IASXvQ+Pis8jUNVSp0IuL0OPeED3/NwRmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/L4sfpgKZJzLBMmCyZ2F5Gidr1cX+0Kokt0URee+xQ=;
 b=bjpiaz2l8T036NpVoOweOBiDotx39v9PJqfAmsb1qirsWbw3u5PozI4EOhVqsSF+f3XVNzMJjviU7N2vyt6lPgvN8GTa0DfE6D/hk0320JNV+3eQC5iDfjdAGWxod8+8G7HY5Yb9CXQJVTJUDEBprWhX5CLGt7D5HOS4Fq7PSCEttx/cFJ+65yxvIWr0ZS+r4pN6/OMlPEmT7db0X4a39Y0luGPyI/xcb/iN71bm30efRNwl0rfC8PbAFlWsYPvkUP6EhjZwM9lmnePvm4ckVP5BsehFz2Mnmok+hes+6E24Rl0WTIjXr4SydMKosq0FCyYxn5tBODSKfX0adanR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/L4sfpgKZJzLBMmCyZ2F5Gidr1cX+0Kokt0URee+xQ=;
 b=ncxFaTeomUKoNsOS+BOl3SYVWmkwZos/MsONH1OMPhnfnH9HlNUL7a1TQCF5sMY+wl5aoZzluN0S4SuHlLOCmPotVEkaoJeIPKx+iVTQ2msLWO0zDPIEEnW1XQJGtCNg2e76CHapBwAQIMoQnqiTNqW0P0Aylx84OxpAhTltEc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA4PR04MB9439.eurprd04.prod.outlook.com (2603:10a6:102:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 03:02:54 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:02:54 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Joy Zou <joy.zou@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: change the memory access from local into remote mode in i.MX 8QM
Date: Fri, 10 May 2024 11:09:34 +0800
Message-Id: <20240510030959.703663-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA4PR04MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1312e717-6577-4a79-78b3-08dc709db009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvwDSBGvs14AkqVfri3bJrvbv+7mJjWmC7nbLfgz6fOOX619oB7IgcSvK3zF?=
 =?us-ascii?Q?UWn2sQ1/NPNzgTYZ9UsXvyQYrk33igkzTiujfx2MNRzghwNtILM+FJyYNGAE?=
 =?us-ascii?Q?xT17UhuleR2rsV7rysvEfpO36IJKFQH7dLqouB71efjMNPJ4MGfZWnHMAl8l?=
 =?us-ascii?Q?0xfQ1sxuSlGpAI4Mp1VDm2QOeTAVr1NpYWdQV4SOeviTvooBp3NQUZa+4JbG?=
 =?us-ascii?Q?ArwGA4ET2NXeG5/VA0jaSzduEKxdGU+C+sXy7b9s8qKpMpqdFebbg20Rjeqk?=
 =?us-ascii?Q?BCkBK5f8rNBn8hhywa86IEhcp1Vvvd3FZXuyJ+5IVDKgwfG/vbnKivJgWtTi?=
 =?us-ascii?Q?juOtcJhV8/SiBoP0aAathR6/TyIgMkY8Y5kHB9u+uxy9pHkrspSyeje8wF+G?=
 =?us-ascii?Q?3ov9TLRNTFOI7hUmbbvYy7iCF0kXBCjjHmVjuzHZv3OeOLeunbNza3J/ZXzM?=
 =?us-ascii?Q?kFiUDABOgJOD+mXSeDXFmZ75kBDfrm76DPXN8YJWeWvf6CiG22srzucZHs5y?=
 =?us-ascii?Q?Z3qgNefXKBuqV1D9u8aVLqCq9csBi7Akx2FEZKiNgRPqHonxNMT5WAwOHL1x?=
 =?us-ascii?Q?1dFcWgVB7AMO2OnlMt0PXefhBbJxBGxCnf5uMtrsvCqwIaPXCduypczrMDs9?=
 =?us-ascii?Q?cJOQL6yx0P9xWYXRRwVrw7Cx3PlkHrsjrKvOWeZOno4pvk/H5qyAcKIO0Qxl?=
 =?us-ascii?Q?hQkWBSBnEH24tnzhdLCY2gh/dtJtteiCzX3j5QQLlGpHjLadBg9ojtZze9Fa?=
 =?us-ascii?Q?qaUBFjqNB66rg+iay3PO+B2v+IDnTdekwzhwyeIDonDJtAUHCScLUQKTxdmP?=
 =?us-ascii?Q?Dg44rpOMeUwn7l+ZQrgYcNgJUDSpXuofsjWQJCSEjhYgY8J1WLFt2VCpbwur?=
 =?us-ascii?Q?JAmQfG7LcQYlVbQkj5uolL99g1CBlRc+6nGVuCbwEokzCBr+wi8rM+j3B1jD?=
 =?us-ascii?Q?0D/3DOrH2ko98U4j5oq+m+P+UIi1kbaergmpTOFmr9AT5jNts+wL2yXY8NNx?=
 =?us-ascii?Q?v22sB5AfTN9qUuYcKBXUw8x8AcWHFMQbUmEHDcFTDuxnvs+03ekeOF7OmEC5?=
 =?us-ascii?Q?SZgE7e1yQQ7Zu3VN3veo4daYPsDoW+TrWQ1ThJDEiXD0zPrN4+N/LFt7LU+z?=
 =?us-ascii?Q?m8nA9a+ahi38Aeo8D12hMX7VNP8oP9Y5lESF0AMphlo9eP/tXVh04kWJcFs/?=
 =?us-ascii?Q?30YKNQYbIA+4NMjXEa2JvfRac+RPcd62V14ajAYtd64vq7CsZAyfAf9jElAl?=
 =?us-ascii?Q?k2CgO2WPolRF4f+dC8Kdzsl665A4hsoLiSQgDqQzwPa5e4FbPlmcTVolVMjE?=
 =?us-ascii?Q?G1bLVQkGeDnoVtFVSUBufXzb0X92h63tu1bTn04vZtV4YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VEcRl3k+MqE0vDbDhy62mvF6pE0qPl04hnc0MBkMXlPRf9shBtvyLJ/Q3yT0?=
 =?us-ascii?Q?w9V1oDIu/elrCPiTklFuScWmtHbHwe987lb2Cy6ZftsWe4KPYDLZ2GBsZtVx?=
 =?us-ascii?Q?JWhf4/R4/EN+GNwpT10xXDRtiDXlW+KxHMJSTpYvRqO7x+2jjV1zAlJojwqB?=
 =?us-ascii?Q?mdb2klXMWo6iNFh6XGnBGm+8KxTwnemkvVnJBxTQ+hr74KQBfPMTRJA0xB/c?=
 =?us-ascii?Q?0NIfcNhy4eYtnnABpVs9AA4oESMjOgobvKRVyeH5Rd6gF3AlkG/zfrlGSLKI?=
 =?us-ascii?Q?8vT1S1DgtyffF70W1Mt5OGThqIUMftlmpgKAj9pblCLjk4QV+c7Ingbe2Lv5?=
 =?us-ascii?Q?Fycn9pc1qQGD3PPf01gIShCAOGt05gQFEZxi6KdvC9YR65VXlcQsocs+qYdG?=
 =?us-ascii?Q?aYLexaVE35UsGm29dB2w60iobTPj/ASuACiJ1W6l0zOe99m3gYhF6I3lq2xI?=
 =?us-ascii?Q?kAIsoyd3aFq25Jr9BveE7RxNUggDADUNBEETY/VRxqhP6SlCZ8TWHxrpd+BH?=
 =?us-ascii?Q?v2wSbU95B3pKDBdUv8+JbYKMmgS4TPMul9STr1LM/W/binMu4CDEoN4Vwr6b?=
 =?us-ascii?Q?uU/6MdrliINwLC35MuWNHd06FZIJFFcglKom8/8y0tZmPTRlVUyS8+WINyRF?=
 =?us-ascii?Q?Jp+QXsu/ep3mqeD6zJWifeXrhgoKiEb8jIYbxsoKT4nFWSkapQCp96i4gcRE?=
 =?us-ascii?Q?JU5csy4BV2VtlTiOoXFwAUGlFY9ZWW2mGd/7Y7gIyD9dHb1oYJiPvwoJBPTs?=
 =?us-ascii?Q?swdHrNAI0oiqL64xvH1BPINRDasyp0lVzt2lWanBjrPSE+VmPwvEOuoGLbju?=
 =?us-ascii?Q?+G94pGNGQvG+s361jdlLe9KH8MaLwkMi7uTL/qZsCEqcI2xZUHVtEL0ATr80?=
 =?us-ascii?Q?/0/5ZA/hspbzIQoIrRmseBAbAK/QEHmbUI4gRfsKIvLtC7uD50cal+kyF54O?=
 =?us-ascii?Q?K152DZkW8O8CuCTSrnthqhJgCrctzJWKWbGhIJ/xTa8FoCtzeB8u/RdxHxAQ?=
 =?us-ascii?Q?3nRl1SzOnSmCyaNRCBPG55F/ZdYXygySo6SFP8bMbVTi/ta1fJqcrtXGafJ0?=
 =?us-ascii?Q?ewbmkyHk/D2Gqjap+RKzRv3YHrF9fUiq4GojpeHXkNrlSkPy0IyhkxAZVi/s?=
 =?us-ascii?Q?7lBZ4J9RCLreBghjZB47ZLYT3sUTgKGrtUJogpTVfpWUzHeiP6qLFfFnOl1O?=
 =?us-ascii?Q?zKyxzWuH09Cz4p7VZbnA5W7weXV2Q5GYu1wvhmhJAME6AnlhRjluR0Y5QMZI?=
 =?us-ascii?Q?UYzUUgadu1/UeIaUhB/D7X1TbGK+h+2roA6C9/yUabxlp5ALFBCBmA7uErFS?=
 =?us-ascii?Q?Wmyqs/yf9ptba7H5uXHHABxu2Nm4NystNPuYraCxtmKlXAHfiwWS/7YGczXK?=
 =?us-ascii?Q?d62WHfbHHB6POTd58FNMUSj0qcyF9g/twVcmWIwAGelpHjfVKRmqWKVqPVC1?=
 =?us-ascii?Q?RLhoG03qH0RXIZksuN2VPof7f7z5DSczgpMwLm30nJEvQiDLcp2OTSqva8Kb?=
 =?us-ascii?Q?MA32r68nKaxU29qv3wcY0qmQwz0DFkfcVPVPFt9zEmryem/Bu5taSL328kcm?=
 =?us-ascii?Q?JZGdUcOiDMuFz06foCnwHhKgtJZ85U8kiPDOJPX6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1312e717-6577-4a79-78b3-08dc709db009
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:02:54.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMPAZPMdaYRx37ROdXjFIbzn++Xb9PyStZbUJ/tH6SQKMSVulRl3aWFeK0Izuk1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9439

Fix the issue where MEM_TO_MEM fail on i.MX8QM due to the requirement
that both source and destination addresses need pass through the IOMMU.
Typically, peripheral FIFO addresses bypass the IOMMU, necessitating
only one of the source or destination to go through it.

Set "is_remote" to true to ensure both source and destination
addresses pass through the IOMMU.

iMX8 Spec define "Local" and "Remote" bus as below.
Local bus: bypass IOMMU to directly access other peripheral register,
such as FIFO.
Remote bus: go through IOMMU to access system memory.

The test fail log as follow:
[ 66.268506] dmatest: dma0chan0-copy0: result #1: 'test timed out' with src_off=0x100 dst_off=0x80 len=0x3ec0 (0)
[ 66.278785] dmatest: dma0chan0-copy0: summary 1 tests, 1 failures 0.32 iops 4 KB/s (0)

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/dma/fsl-edma-common.c | 3 +++
 drivers/dma/fsl-edma-common.h | 1 +
 drivers/dma/fsl-edma-main.c   | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index d62f5f452a43..7accee488856 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -756,6 +756,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 	fsl_desc->iscyclic = false;
 
 	fsl_chan->is_sw = true;
+	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_MEM_REMOTE)
+		fsl_chan->is_remote = true;
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
@@ -835,6 +837,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = NULL;
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
+	fsl_chan->is_remote = false;
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_disable_unprepare(fsl_chan->clk);
 }
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 3f93ebb890b3..cc15c1a145eb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -194,6 +194,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
 #define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
+#define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
 /* control and status register is in tcd address space, edma3 reg layout */
 #define FSL_EDMA_DRV_SPLIT_REG		BIT(9)
 #define FSL_EDMA_DRV_BUS_8BYTE		BIT(10)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 391e4f13dfeb..43d84cfefbe2 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -342,7 +342,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx8qm_data = {
-	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_PD | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MEM_REMOTE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
-- 
2.37.1



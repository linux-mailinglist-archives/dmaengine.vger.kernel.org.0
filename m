Return-Path: <dmaengine+bounces-994-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E784FE2D
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2601F222A6
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8E15AF1;
	Fri,  9 Feb 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WbamIEfQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F08D294;
	Fri,  9 Feb 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512937; cv=fail; b=EmMX1GmHqi5JnbNQacSwX/lhLsGguycWG0zf+jpS8VxlRLzflDLxZ/fbQ3nkr9cIZOsvQz0mziFVe4pmkGSNvsvL3gej0to3yZg7lMVLf/3mnL9DeQF1vG8Euom7ykb1rgo3ziGxRiAjdqraajoYn93D4BVckpLhe+7wWspp91I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512937; c=relaxed/simple;
	bh=0oW/5nA4MeA3odwpyjmRzeiw3ueX6d+hPZj+MCCFpY4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XoO4ntjtku0a6GigC23Eu+NS79rm4C3ThP00TTVZSz7wcLQF+xRCGf7tYMbheUt1gsxTZXe9Avdt8Jasapwwc3gt3vXZ9SL7AmjF8zH+k6Ef/uZeXjZxkrBaQJIdBPqzN8uLxAAYI3AGFADMaaoSItpPUC83DduLxx9LQNfXkt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WbamIEfQ; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGJKcqH8X+67xY/pwCmZ6yBo//NVprXeWQm/kLZJWvcS2/YkPac9Qe/SQkgNiitXD/g/IsRv9zNJI1mityeUawzeZGSGdg/bGjFp528pZap2k/Q5JHKecwezicJpJLT2dUpvUeLl0ZxCutnrp3Ic05eRusaGjXHKdVDPtKFXYnIve5ULoUDFCYnyVgTRH8x3GSNKB6VcP40pX9GWNIqdozH2BZOZTqrw5RZF1qdiOaTfu2fqzkwUq86Vk8FbAo8R4Fs4k2OlT2NmSA5t916In4WvPh+XK2LKXz1zHj3sGLmLNlXUZUNVjojqFBnQ9ulHBtq8whp4sVVSfU0DYVgGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB4LBb7c46BDd7fVCheisagKzzeCGgNAdZ5lhEMr2M8=;
 b=DMpfPSvPQVYF8GerBoMvZZkQ/fyMW6C8XznnPglTaMW8OefdycLLQPDsg1yslnQXHu8ax66Zvpe9FDNfcOeyIY1x+b69oHN/bD569Xz7iQW8u4PUtnPI+A/l3jj2i4TRb72biiW5jBaMeLHb8CG5k6w+MLu7K/7XM651ovylLIqEi5n/d7905SOrKPdZbDNbygKNPTfIalHTnGMg8yxeObRZXvTzMFZFsgUTZ1qgXI3jAwPgUny2aY51ckvqkl1kP3anJ60bUnrcTDgD/RQ85QbT3YaWcbq+fT5VJQC9AmriGvOqpEAjPZkQ2sb7cMpR570rgMQY/ZaGszxOBZl/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB4LBb7c46BDd7fVCheisagKzzeCGgNAdZ5lhEMr2M8=;
 b=WbamIEfQul7p87fzIeokzkHDveBMoXpGTtMbBHpxJWn/aYEuCEgQvnGOwGPyyTuMX6SOB4VbQU842/xwGcvwrSyaG8O8FVznqgLwUwHtp2t2Ot/azzy/R7uqzZzWL/queuBNSyaRNmf4F8v4sjvRaNz7v/qq5Jg/E03wJ+bhLR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 21:08:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 21:08:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse warning
Date: Fri,  9 Feb 2024 16:08:37 -0500
Message-Id: <20240209210837.304873-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb1f4d6-29b0-4550-e631-08dc29b35180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fK0gK/grNEAszjXfwbWic/AsifZ8IM/M7aTHgS4HzaAeOzACkNzrKg3+YASug9YEoV2a9nm9o0d4UXxK1Qu4V/40CHC9a/otD9+FwOQ8GaOOm40II48zZL6Z+jy+U87GrtrKpVL/YOKyQxpJEIybINAB9hobxhWLFp+wHKi0hcgIHhyaD6QzCH+1ANmdsgah7Sznoj4mE6E4DW1FHt9dFrYqMcycdTlUlxWMKrrDpAuDR9SfJ7B/4Dy/6Emrl9AAeNnSRtKeVw4FhwCO31lrXNbQnVe39G3yJhKNOnSl/4gF2MGb4Q2wVSHFRShiCu6UvK4td0mXk8xDbI5SR+zDQpTS3hgEC6/MxOYZ+7zNdp+y2MmU/3rCw+xTINgDTZVEy4KMs8E1I3Uaj0u23zzPiHK+2iaf9Tui6INXimm6rwibQlvb3IL7s36hlzInwkY3D28krBHg6jhpsWCF810QgeT5eCI7MVcGPB5kFhV94KPLl9MBlAZayAIdhIUaOTtHQZ8ziMTYgMHeuHIxtCdVJwDE8Z4svZZC5b2jygEb4IuY0U86dG3qIJjAxoh5sOMRje+vqH6m0vl3ONLY8bisrK7tCaO/Xw+KYtDFF+9M7Sk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(52116002)(41300700001)(6506007)(478600001)(2616005)(6512007)(966005)(6486002)(2906002)(5660300002)(4326008)(8676002)(66556008)(66476007)(66946007)(8936002)(316002)(6666004)(38350700005)(26005)(83380400001)(38100700002)(36756003)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LcE/rvjsSlNhO0Cc4MhGk5sSRjx2/l4gkkjXe34jvAPeHQZdEMNMfN0OkFhE?=
 =?us-ascii?Q?aNyWAGzQkK+AVe+Y3ky8B5ZuTv3axR/D4DrTvkIyMp611kFvwYbWKwy3OTAu?=
 =?us-ascii?Q?ajafU9SBoKc8o9YQloHQ8fZZHQtFUhA6AFbyjU6xdrbTI8UiClyDiOYIh6wX?=
 =?us-ascii?Q?FpI8FOOefIyPP4yD+zcsGcygKXIVlI7vDNOdDt0JbiCtRA95+vJz4LBDTV75?=
 =?us-ascii?Q?Dx6SXbzy5RDggGpNWtvi7NqEOrOXsLsaMssvuxDAiZwrhw65yZnCI1lHzFab?=
 =?us-ascii?Q?1U72CnAWkoy/emXte2p6JhkA9NrrGmBPmqjPTmYs6kdfMWWx2Fs2CXsb1ezC?=
 =?us-ascii?Q?OrFXHIvH3eBTlrNfh8Tk2wPwo2wfM9sQUDNFSs3+a6/Vb9Z8bUCnF8hA25Tr?=
 =?us-ascii?Q?Va5TmxehNlWU3kQucXMv29m7naLKQEAEehyEgK2jWo/QirPN4F21pwgA4Oay?=
 =?us-ascii?Q?gyfQBtiyVjL4Wo+BUGPKXwiAJL5agptOc002YFfJrpcgNL1/Ug4VOfJjTxr+?=
 =?us-ascii?Q?0IoAG2c28AKxsdx8nhz1L8gowt3lXBeP+cUw3tWiEQI1Z1eN+r9y7jVEZk8r?=
 =?us-ascii?Q?gVoSQvpsHXJWCYG2SmXcdJXzmdVaxzJ7MICxbz8plQZj/slYXwmVKoMypu8W?=
 =?us-ascii?Q?iap/irN34OfzmmI0JhlzuNX/RQM5jsIdj+LNUKZ9PI4xDwmtOQlCGtUuf76m?=
 =?us-ascii?Q?OeUlqCBPjsWtkLylgO8DKasJ8byKdG+eS49wFuJ+qDkOgX3Bnhknt1quSJSZ?=
 =?us-ascii?Q?bh2leAeEoXNl7oX8Yk1NAA1AnoCc1wJMDmxLfN8PwKnemC0Cc4KhBgDrjXIy?=
 =?us-ascii?Q?r1FHKcncym/+fhn3ajW3r/HkTaDt2XpJStCl/awzU0qc/3vA3m/R7unyZKXL?=
 =?us-ascii?Q?xo0Dy82awSb28F9rD/gHkekM1hF/bU44OzPakv+h99I/6xQo9r+otCV1vjYM?=
 =?us-ascii?Q?hqcIlOuXcO8jtJL7U3BkQobCSDaNYAFb6DftMJ5lrCN+g9u3d8/1aTxIXFiP?=
 =?us-ascii?Q?fxCOaGoSCp1XaNX/YMqyNgsNDcbd++I4KdAlRykrhrnI6viKVhtkK/gqi0sO?=
 =?us-ascii?Q?LFWIprZJPNXIQB5oxG3W4lfIu9lOpkiEvGTn0TReQPzv28ll0FRRu2EZasD0?=
 =?us-ascii?Q?lpAP5RIdmnmicSmExMPM9cJPKDM/vjSJ72xeo0Cix28lD8G6PtdqfEsLjZkl?=
 =?us-ascii?Q?ZaDIu4O3kRCJzgydWrwBQFOYE5wnJRBUdfKZ8jNt82tYOPVPXnYzdyefem7t?=
 =?us-ascii?Q?EhqBayJlpw0Q/xJtOJzOzJamPAHHH3+XM8eIFyFTL0ktqo3esX1Tr27cN/L6?=
 =?us-ascii?Q?R+5Tmyx1vmt5CHjyTezNiTQ5eeLXLvda/WKwLKEkPD71IpkFVlJMOpPpBZHk?=
 =?us-ascii?Q?2vwAT5zfjayGL5a91rYhW4vZWPwwiTaF/Ap2PYymwENzZ4hWsDE8635QNOjU?=
 =?us-ascii?Q?vcJfXJcaJb6wIuiSihWMwduXoZ0VGbKd2aEGgnexjMNh8PAs8E8/yDrVkOT6?=
 =?us-ascii?Q?gETxg2R6G78Gf6kH80JGZ75D/LgLCHRmro+pvxdU8eYwZyZZ6Er/DQsyFHje?=
 =?us-ascii?Q?4L86pbuunLi2ksZOcN0cdQg9sgUni2gb4pqtQqEP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb1f4d6-29b0-4550-e631-08dc29b35180
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:08:52.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjkQr9I7RYrMjRguWyD30NMGxpFzYn246qOK4EPnoftaFcg6Crx8r7O634Obb0b6PyPW0fN2g/YkRyMe0Du/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

Fix below sparse warnings.

drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
drivers/dma/fsl-qdma.c:645:50: sparse:    got void

drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-qdma.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 1e3bf6f30f784..5005e138fc239 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -161,6 +161,10 @@ struct fsl_qdma_format {
 			u8 __reserved1[2];
 			u8 cfg8b_w1;
 		} __packed;
+		struct {
+			__le32 __reserved2;
+			__le32 cmd;
+		} __packed;
 		__le64 data;
 	};
 } __packed;
@@ -355,7 +359,6 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 				      dma_addr_t dst, dma_addr_t src, u32 len)
 {
-	u32 cmd;
 	struct fsl_qdma_format *sdf, *ddf;
 	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
 
@@ -384,15 +387,11 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	/* This entry is the last entry. */
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
-	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
-			  FSL_QDMA_CMD_PF;
-	sdf->data = QDMA_SDDF_CMD(cmd);
-
-	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
-	ddf->data = QDMA_SDDF_CMD(cmd);
+	sdf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			       FSL_QDMA_CMD_PF);
+
+	ddf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			       (FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET));
 }
 
 /*
@@ -626,7 +625,7 @@ static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
 
 static int
 fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma,
-				 void *block,
+				 __iomem void *block,
 				 int id)
 {
 	bool duplicate;
-- 
2.34.1



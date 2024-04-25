Return-Path: <dmaengine+bounces-1964-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29BE8B2A52
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA241F245C8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26429154BFC;
	Thu, 25 Apr 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TGGfKRKy"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38F153BC7;
	Thu, 25 Apr 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078810; cv=fail; b=XdeGNakG9RON83jatt61uFJ9jhTbYQen0Ggy/EJIf9peXuNfdhGuTzY+jsNCEvDOwhhmk1hyRRIHSSNmr19PqdTQ/q4EJVMDyAa1I9Jyvv1xKOGa8K7Kch35/AOsckBoqZoFz1UdFWWYuX3ZFKqdFRSqGk1KI8+CujlbldEcv7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078810; c=relaxed/simple;
	bh=XICOYisqZoqPVNMDIIvQSiR1VrwYc0HGYmCyB/FWFbU=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GWvXgmydWuO44+xQQxymg5kNNJzzWjgNaQPitFFK7tkLrBnfFP2NQI04nsnmHLtN2geT/HdSi3fcsNb7oXzIRdw0v1nhNjTWvFIHVj63YK/0HLJtXNFddl+54r4C80iKuYUrH1Ug8+fbJnlWLSbHaGwy8ADCuYqxlxQtFTankjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TGGfKRKy; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr6a35wkzMTJn9zSAooM5e/1l3RH5ZqqEwW9k5ghA6MRIXHQIbCAE2w0t02kIC6hNuOM7wu1OYV+1tFXx1ax+JlMqvEBQ3WopOIRnfkeCjSkR8sNdWo9aoJ7fmwHP6l3IJ/ZUKeKs5XH0R8yRraSd2eeFGM1gnjlklY8T4eky3w5Po0qi7uoQjMtcuji31lcryTkeBL1ylbnURDErIhJnzUhxG+R+1F6dROpkdRpwf5AVmd5dJMHFMbmNb7Km6Ej7q7njve699nAnanp0G+mf55qBSmqPC9wuXywv48+i/wQnHrG2hdL76+Al/hrdIhUih7w34uinC+mlcdDOBrqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfLdSSCulvUTi7rrbd+D+hrrY2RaIh5wwVWGycJuGG8=;
 b=CvwNQj1cJIm+Xn8Mgv98TnlB8C0GCyKpKI/8U0gFlZaovhL9zXlqlcBCqJuYwr8t9PzJBwgqc/JAZ7bPtHDNJNvfOxMPnNJ1FPHkG/cx2pNXtJGxJo7O3vkpygtqH6P+1CC6dHHHBN1BewCA2OoM+aKEy8DbVOQ9e+MJ+Qm7Vp95ijTpaCcyHGwyNuZzBRBi8M9Vm4In7o9OX2ZNXsXvZJ36NN1YlJAwFGwyky5SLqSuIHTQPbzio+mij2Vhn+QpJR0YpYcxaWnVaLxeCnMQ2ohB0c4MsJaqdBO8bpS/ymO4LPrTp0NK+DMIB8OzZsyh4OT2xD8qOnNxnzNfLJK2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfLdSSCulvUTi7rrbd+D+hrrY2RaIh5wwVWGycJuGG8=;
 b=TGGfKRKyY7S9anZgMY33pl6LZfmpH28sjeOOnWbHm+xRUofY139w+VEsTwN821MbRFBoMFVNZx6oNR+xcbVl4tlE5tFLUU2GII2y/LfIbU5jkmWVSEvAfqOYyn4KAR0QcekFBSV46mNOKiKP2qRM978Xtkgabeh2f7DjBX9c8WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8637.eurprd04.prod.outlook.com (2603:10a6:102:21c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 21:00:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 21:00:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER)
Subject: [PATCH resend v2 1/2] dmaengine: fsl-edma: add trace event support
Date: Thu, 25 Apr 2024 16:59:45 -0400
Message-Id: <20240425205947.3436501-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d3a8cb-3bff-434a-cf4e-08dc656aad8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLfyqZ8RQj+i5AilFBJdBGt78V30ZZ1PzhK3tEBd7Qn4aY2hPNz5nFfMedmE?=
 =?us-ascii?Q?1ljoakHr3MVPFTrKEI/VTCufVr7GJ9sXObcHDHUD0vKdLsJ6X5GpKDHcYdvV?=
 =?us-ascii?Q?6fgB+rxyI0I6L9ZDPRJ1rnlV985XxFM9P6eIJPAw9xBhuiecjH3rIKCHlSmc?=
 =?us-ascii?Q?tIwzpro7XXRglhmt4nPOCj20Kq4uWGtBivflqqWWSFmQFF9ao6oU4KeqWEw/?=
 =?us-ascii?Q?LdW0HC4i3dFsfaS+BCBrFgd7PKN9Avsql+ORysJEBV7d52GopWjXspV6Ph1S?=
 =?us-ascii?Q?EQHMRq+G8We5T7Ha6bEHx6sdZHhN7dOPYfrmIKtASKKrCyxHtg/1tflyshXX?=
 =?us-ascii?Q?xNksSdlE+cZCd1zCOPUg4VjIShmEZwDADanfRSZTTwzphbWf1hAw0E53SlD3?=
 =?us-ascii?Q?PjtmxCb+GWQ7z9PmCi6hcmT5Nj5ScdfVFXZ4nRkNJcfowG+sx4qyGq4aP2NM?=
 =?us-ascii?Q?2OIrA944ZWO3S/5vG1tGqbyA114bjhlj7LANPUI6rqKdwtXAnTPjT1zml59N?=
 =?us-ascii?Q?6eRM9K+G7oZyovmzfT6bv7rwsBoGXWUaJdYqp5f1bprNZvDzLov8GEcpJXst?=
 =?us-ascii?Q?63cqDp/XXip2mdQ4YIpo6eTNSnClq0nJ/c38KHT4HaUuhh5zfG+pWE/umhw9?=
 =?us-ascii?Q?oGY1+A1lliOVaZFe8T/PUFrmVyGY5F6WZt7zVN1pmcHCpK2NtB4O81RmyLsy?=
 =?us-ascii?Q?RJBV6zGUARdZ4Qjr1ADaCDU/yjFbox6w7CT9aRMqiMEV7wgW3MBMIkBC07/F?=
 =?us-ascii?Q?Ykb5fFwhYfk/PKZvprIwUXGpQvHSpCgyP4ebD0JbYgBj/eGq7MV9mIpC+NTs?=
 =?us-ascii?Q?0vHLlxoekzXLTpHlm4IKLuDB0ymyAFZ28xY0HCoPpJxXvfm8la3p1dDmIaqi?=
 =?us-ascii?Q?btJKi/rEX89nSjJ1qW7cV4z9LmAuWFrRMy9rJy0yEjsXOZCY5i+cR2ZrKyNl?=
 =?us-ascii?Q?oBpyEV6A96Y/E+JRTC1cpERsdK/35GU07m6Epn+SJpW5rQXDUErCiQvU9Lhs?=
 =?us-ascii?Q?1pnynB7wChlxfPZTUmZQkPO54qJpxrR3PPRMmXvX9A/ZIg1BapBles6wBt11?=
 =?us-ascii?Q?2zatHzpk3FEA1AZf+oKXO+WMBomTJRwDHHCXmtKaX99/4mOxXJK3A+YT6E6U?=
 =?us-ascii?Q?+0FcIYAlKOLrmtx+S/6Hp3N3jwt7jAYV8hHgYVn1LPssOEdDRdKXRMl6pAl1?=
 =?us-ascii?Q?Tm5J+osV2jJvSqMz24zoYxsHrYeWlN81cCa+CZWBf5fwNANur+3DKA5jd5gI?=
 =?us-ascii?Q?WwOpMujwdmYobejdIWfPSd141Gg3nsO1cx/CcYTyBDGandIdFznGh0HMf3qA?=
 =?us-ascii?Q?PxBNRzs+E9mFM9hzqwuZmBem/FX/1QoDTZoUaibiNYgsFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAoqYHev/fdovMRr1NRl9ADgyUlHadtCz1LICnj2YgZVUPYrCFUlq5kF2s55?=
 =?us-ascii?Q?qvzUNhqBJc1xBu414xPf+Yv4Dx585Ax1856qZeXIHbPxhv6IuIaS2UB56iMO?=
 =?us-ascii?Q?rItLMQgiuTsXC+RY16sJAI4OkiRSkx3Joe+fp0HVcmuXJ16LwkiQl0F5TjTt?=
 =?us-ascii?Q?Gs/ZKUkwAU7DfPq38IINUKTAVYoJJ5WhbCxcRW3u9KJ58FxUrmLzxW4e4eBt?=
 =?us-ascii?Q?waTa9cXzHUMuoBW5upU9oxKlQEI8jVlCXEv9+wbQUAl7aeJYTe/Sy/Af9neJ?=
 =?us-ascii?Q?clorq4/dLJCQh+MNCWv16S474GcTsXWfUN/8HQ7j89C0qFcLzHaWBo9+s5Rk?=
 =?us-ascii?Q?Ou7FCCGZQj082bi9M+t8H+mHziij9wtf8ALHVUjGYll6U8P3w7O+zkMZjT6Y?=
 =?us-ascii?Q?1hykjm4G1hWonjZASB2lrIzph1dBG+HtYPvHQ45LFrfPBudbRijWvBBKa8xf?=
 =?us-ascii?Q?SuTXhHwhUZtgp9rPOqantCYDFRR8doQw8eVZKaEF4gU5PD4kKrt9o58fcABA?=
 =?us-ascii?Q?k1vW/wjRa5yZ2Atb5dnwhSSWPEqOQoJ4XKoACDN2+vqkfB/yFPh/8dyBGbMr?=
 =?us-ascii?Q?LM7sHHouH9d/RClj2uwzJt1dKlxoRRvnZM1Nr5aF0Y+QxZY1snJE4ES8uXfn?=
 =?us-ascii?Q?Z/htnredItw1oPifjM2kgcblkGKY20uCzzpKkEedriMBUERbd859Qz1ik341?=
 =?us-ascii?Q?Lp/BhQU/hFzV8cQE2hMLuHSUE5QKZkvJHLb+vRDStSX0iLfm5g7VRC62vk8g?=
 =?us-ascii?Q?iYUMTXL45BFOaF0LxYOR0l4psrM1nah6IkX+pegElRX7FsuZLWyllUwFPtV6?=
 =?us-ascii?Q?niKkVKn6UyvpyiWYN5JuO8NrzGkXRVY1PUI57eG+hGU+TleYePc4RPbvzI1w?=
 =?us-ascii?Q?Xy2JTiUDNzC9GUyLMiadtKM6B/XZWu4WV/J7Rzo52CKnuMRCRmDWQp+5V29n?=
 =?us-ascii?Q?KmF6fupKLOqqGtjN9EB9VGmUzHEchaqD3RYUwmDtpkfYWjokaLvUIZYsDKC+?=
 =?us-ascii?Q?N7D5Q7CQUr1P3DyklkUqLs+C6ABa+loWi/gHtK1WkEWcTS05xpQtzfezkoDj?=
 =?us-ascii?Q?zp8xojod2xVegw2y0EIXX9ExMyKHoiwT57G6D3GcTQ4OTTZdNxnnNi67jiVE?=
 =?us-ascii?Q?dK5abZAZ86CZyK8Cvf6O4RzjpgKn4zsJySdWy6ybkaDYUV8Z9822VDwWZssy?=
 =?us-ascii?Q?x8kbnqsLNd89TtrHN86UVCF22pGPt9ziAiOhiB8jt+s8t8rDN5e83TMXHwH6?=
 =?us-ascii?Q?fnHwPcxgIH8PvEYPPFm8qf96Y4h+gO9DPndJ6JAQhOy72nN88T+FFND0BlRz?=
 =?us-ascii?Q?n3cpBvSG7hfygtZQoev61JUAQynmCDltOfxNQmIf6dw31hhsG5sFtPv+y2/z?=
 =?us-ascii?Q?HITASNkEDUvAQfZ5CHH374AaRbhA650kejsGCI26bdyprD1DbzpNQ6CVrNnC?=
 =?us-ascii?Q?sIv3E1swbRcOnQjohzOcmLnsbJJgxtcUyCTojPDSEhq8PWIuJbwPjogL9ykD?=
 =?us-ascii?Q?SpttYRf5v5Mi0B9YnHPxRS0uR8uaWUciknhyBs8g+TBKImU4gL6V0vhpgxAY?=
 =?us-ascii?Q?Up1ZvKn+qDZQK0H3+lAdNcoNp+A5FlXyJHomPq1e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d3a8cb-3bff-434a-cf4e-08dc656aad8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 21:00:03.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMjAtiJxZZLsyJkeMeGNkHoXbDAh/p1CD34cr0jN7Rr74PpJ/toga2bOgJivieP4usQ/U+ZaPZMIIOpDYpUrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8637

Implement trace event support to enhance logging functionality for
register access and the transfer control descriptor (TCD) context.
This will enable more comprehensive monitoring and analysis of system
activities

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile          |   6 +-
 drivers/dma/fsl-edma-common.c |   2 +
 drivers/dma/fsl-edma-common.h |  45 +++++++++---
 drivers/dma/fsl-edma-trace.c  |   4 ++
 drivers/dma/fsl-edma-trace.h  | 132 ++++++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+), 11 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e4089..802ca916f05f5 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -31,10 +31,12 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
+fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
+CFLAGS_fsl-edma-trace.o := -I$(src)
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index f9144b0154396..8e70319abe5ba 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -547,6 +547,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		csr |= EDMA_TCD_CSR_START;
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
+
+	trace_edma_fill_tcd(fsl_chan, tcd);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 01157912bfd5f..a73af4015d4f0 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -248,6 +248,11 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
+static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
+{
+	return fsl_chan->edma->drvdata->flags;
+}
+
 #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
 (sizeof((_tcd)->__name) == sizeof(u64) ?				\
 	edma_readq(chan->edma, &(_tcd)->__name) :			\
@@ -351,6 +356,9 @@ do {								\
 		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
 } while (0)
 
+/* Need after struct defination */
+#include "fsl-edma-trace.h"
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -369,23 +377,38 @@ static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
 		h = ioread32(addr + 4);
 	}
 
+	trace_edma_readl(edma, addr, l);
+	trace_edma_readl(edma, addr + 4, h);
+
 	return (h << 32) | l;
 }
 
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u32 val;
+
 	if (edma->big_endian)
-		return ioread32be(addr);
+		val = ioread32be(addr);
 	else
-		return ioread32(addr);
+		val = ioread32(addr);
+
+	trace_edma_readl(edma, addr, val);
+
+	return val;
 }
 
 static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u16 val;
+
 	if (edma->big_endian)
-		return ioread16be(addr);
+		val = ioread16be(addr);
 	else
-		return ioread16(addr);
+		val = ioread16(addr);
+
+	trace_edma_readw(edma, addr, val);
+
+	return val;
 }
 
 static inline void edma_writeb(struct fsl_edma_engine *edma,
@@ -396,6 +419,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
 		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
 	else
 		iowrite8(val, addr);
+
+	trace_edma_writeb(edma, addr, val);
 }
 
 static inline void edma_writew(struct fsl_edma_engine *edma,
@@ -406,6 +431,8 @@ static inline void edma_writew(struct fsl_edma_engine *edma,
 		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
 	else
 		iowrite16(val, addr);
+
+	trace_edma_writew(edma, addr, val);
 }
 
 static inline void edma_writel(struct fsl_edma_engine *edma,
@@ -415,6 +442,8 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32be(val, addr);
 	else
 		iowrite32(val, addr);
+
+	trace_edma_writel(edma, addr, val);
 }
 
 static inline void edma_writeq(struct fsl_edma_engine *edma,
@@ -427,6 +456,9 @@ static inline void edma_writeq(struct fsl_edma_engine *edma,
 		iowrite32(val & 0xFFFFFFFF, addr);
 		iowrite32(val >> 32, addr + 4);
 	}
+
+	trace_edma_writel(edma, addr, val & 0xFFFFFFFF);
+	trace_edma_writel(edma, addr + 4, val >> 32);
 }
 
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
@@ -434,11 +466,6 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
 }
 
-static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
-{
-	return fsl_chan->edma->drvdata->flags;
-}
-
 static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 {
 	return container_of(vd, struct fsl_edma_desc, vdesc);
diff --git a/drivers/dma/fsl-edma-trace.c b/drivers/dma/fsl-edma-trace.c
new file mode 100644
index 0000000000000..28300ad80bb75
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "fsl-edma-common.h"
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
new file mode 100644
index 0000000000000..d3541301a2470
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsl_edma
+
+#if !defined(__LINUX_FSL_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_FSL_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(edma_log_io,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value),
+	TP_STRUCT__entry(
+		__field(struct fsl_edma_engine *, edma)
+		__field(void __iomem *, addr)
+		__field(u32, value)
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->addr = addr;
+		__entry->value = value;
+	),
+	TP_printk("offset %08x: value %08x",
+		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readl,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writel,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readw,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writew,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writeb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DECLARE_EVENT_CLASS(edma_log_tcd,
+	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	TP_ARGS(chan, tcd),
+	TP_STRUCT__entry(
+		__field(u64, saddr)
+		__field(u16, soff)
+		__field(u16, attr)
+		__field(u32, nbytes)
+		__field(u64, slast)
+		__field(u64, daddr)
+		__field(u16, doff)
+		__field(u16, citer)
+		__field(u64, dlast_sga)
+		__field(u16, csr)
+		__field(u16, biter)
+
+	),
+	TP_fast_assign(
+		__entry->saddr = fsl_edma_get_tcd_to_cpu(chan, tcd, saddr),
+		__entry->soff = fsl_edma_get_tcd_to_cpu(chan, tcd, soff),
+		__entry->attr = fsl_edma_get_tcd_to_cpu(chan, tcd, attr),
+		__entry->nbytes = fsl_edma_get_tcd_to_cpu(chan, tcd, nbytes),
+		__entry->slast = fsl_edma_get_tcd_to_cpu(chan, tcd, slast),
+		__entry->daddr = fsl_edma_get_tcd_to_cpu(chan, tcd, daddr),
+		__entry->doff = fsl_edma_get_tcd_to_cpu(chan, tcd, doff),
+		__entry->citer = fsl_edma_get_tcd_to_cpu(chan, tcd, citer),
+		__entry->dlast_sga = fsl_edma_get_tcd_to_cpu(chan, tcd, dlast_sga),
+		__entry->csr = fsl_edma_get_tcd_to_cpu(chan, tcd, csr),
+		__entry->biter = fsl_edma_get_tcd_to_cpu(chan, tcd, biter);
+	),
+	TP_printk("\n==== TCD =====\n"
+		  "  saddr:  0x%016llx\n"
+		  "  soff:               0x%04x\n"
+		  "  attr:               0x%04x\n"
+		  "  nbytes:         0x%08x\n"
+		  "  slast:  0x%016llx\n"
+		  "  daddr:  0x%016llx\n"
+		  "  doff:               0x%04x\n"
+		  "  citer:              0x%04x\n"
+		  "  dlast:  0x%016llx\n"
+		  "  csr:                0x%04x\n"
+		  "  biter:              0x%04x\n",
+		__entry->saddr,
+		__entry->soff,
+		__entry->attr,
+		__entry->nbytes,
+		__entry->slast,
+		__entry->daddr,
+		__entry->doff,
+		__entry->citer,
+		__entry->dlast_sga,
+		__entry->csr,
+		__entry->biter)
+);
+
+DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
+	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	TP_ARGS(chan, tcd)
+);
+
+#endif
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE fsl-edma-trace
+
+#include <trace/define_trace.h>
-- 
2.34.1



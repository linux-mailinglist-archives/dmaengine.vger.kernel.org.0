Return-Path: <dmaengine+bounces-2238-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15118D6B21
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D8EB21BBB
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659D1DDEA;
	Fri, 31 May 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ge271NDJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83936168DA;
	Fri, 31 May 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189337; cv=fail; b=KjjyfnklTYwvEgP1xfWz4ieIPX8GNjcZVkj0lpUvW7DUlg691ixghXYgjSoB3A0kpFzeC+ZxuHp6QBDqIgjrq/AEbCm/EPpeq8C/fszS4xzFBTkplBHzF/AkzXwK2qwu3ZVqaEKhP+map89oQJdrx3/lkxEqwGT0PuH42lRHW58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189337; c=relaxed/simple;
	bh=SVplU8gdU6eS+b/C5V78rxQvF/x/SB4HVxXB/vkoFDM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dUoVQ1tupKLqP4cQoeVZif3MhFpPLUWYMgZlQBZoSKMqKY2YbXpRtvdR2p+Wo/QV5ElbXqO+QJkjAmZawtOFfWvbQRInkk/jrwwP+mX5alnIMyWUm7RgkCKs8xNvRx8mrSJ4xtsGinnOjV5sxZKspzHXII70TWMQ9qy3f49Z/mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ge271NDJ; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHTPK6nuj5iQPvQDLd+kl4fqtR7UGVov29c6K4vndwgUh1Kz12Gb4p9jSqUBTg28N+2Cw0WZ/q44r7s92tB1CMAJC5kq4AjT+Kmw56nOJZ3Fw7858EKweQKkFgqFIE8gzSSRUa5WFfjs4To4Z7xJ6kycbWcrxtYVCR4nZ4FNhwTsolrA1gACvOgEB7G1I2knkoJbXelBw07vMj0MYK6YRIJXHO62I1Wtug34wbQVumd8ShV4TnmlTLoFwC8rm86gogwsTmsYW/M1mNTUAwdJBhNOYisA5qadihc5vsTKz/Mt8ClyAZ+UfUCVtZ9WCYbsew6PpCE25XQGT2un1s95WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj5WjfKcEutVFKF9pzkKr3uydJYHPwp9zlz+NiNIUe4=;
 b=ZFcU7Gi53tfnxIp1SSxCVDYa8sz47T4Lfkxi1q37W0vkRIRsKgykAwOU4AgDe5GdLzA7A77ckTzj2skt+nOGrhhFLiGviJyy1GoY84lIO7szcr9jE/o+hZ8S5A9oKmWVBRoN1KZIRChV4X+zutPb9vrvG5dxa6HZHfjeRHn3LspUEe0aNhy7FTKWrYoMuKRZX7EegeC+7nAwkeNfClb8TAv5ZN5firAva4sFiJYIAnSXMhQGvCZrrlMJLhtWEolOznVHHzSa2Lj41JLtFXhS/2FR+XW2XQcuaHUNo9848uvUNOGn7mgBnOdg22klsPBPfwVwU/saGYfP8wuhjojbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj5WjfKcEutVFKF9pzkKr3uydJYHPwp9zlz+NiNIUe4=;
 b=Ge271NDJ53brhIcyOSKWSxbtG0p6ADEJjOeoMSfnLtNHD/RMGAqzJM4oOn6PL4kFNFTLAo+7mMPqgyu5MegDL7yq/mUeKOCM201QZuc/PdY7fiE8pkgQIQar05KMtNPCmdfOEPgwj6b6V9zPHSVyaD3LXPsBs8y9U5wi0TgNvH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9232.eurprd04.prod.outlook.com (2603:10a6:102:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 31 May
 2024 21:02:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:02:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated
Date: Fri, 31 May 2024 17:01:51 -0400
Message-Id: <20240531210152.1878443-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a78650-0b14-4fa8-e067-08dc81b4f151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jy/N33CG6BJMXq5LkUYWyYpW5b7jq+OxSnClF/NsitGzeXZ6NtRCa4xAy7aL?=
 =?us-ascii?Q?QH6TBNn/Wfv2pS3Q0T7C5Db6YAQjMUV+BPxep1qIgCdqg5U3gYjcYKozam6N?=
 =?us-ascii?Q?evjXlz1nR5cYu5QJU2ge8M/gPMvGRg4PVIt7QtME97nNBxJZN6QqwdROTgGM?=
 =?us-ascii?Q?XM4qaVirzoGAz/JCqUhI8nlYnJJPKplIEulpFh4zX9PgBjT3B3NMBmpHFGhK?=
 =?us-ascii?Q?OuUh1f9AwTqoWzns+KYCbukH85gsM8tomxQJA2bzlsTcdnOpwoIfGIPdZIMl?=
 =?us-ascii?Q?VLFYNhQaDPpx+twx7f0emYdTfcBc2Ue51G2m/lF0pWOYlj5faqVSNIgBVW5e?=
 =?us-ascii?Q?JdeOJKM5Kie/crSQyeZMmGrq5UUrTtRUNMHIH3a2NwqkC10VNxtmX7HLBVo6?=
 =?us-ascii?Q?CK6pzV94Amd1EQ1aYsaifzKeSDsvTGa5GMTPd2gtr/axGqN3SfsMEavakTCa?=
 =?us-ascii?Q?ItOx+LkyWXgSwqesE/PKEG0S+YKeb2LVxY02S0iwMINkuEj2BM5lZTg21Ky3?=
 =?us-ascii?Q?oRP3yhiE3+pW1sDHWAp18UDFy+LkKL89CPUa2gp4cOs8JPlVJdVMRrc9+QJi?=
 =?us-ascii?Q?S6adWHl2NKVG72YV14Fu9UNYoF+x4utNasPnIuNtv0GEfLMDkOyr7rUDPVPm?=
 =?us-ascii?Q?HLfO3fljUMqJELRnrAWlKvZ6AD7pIGUjCR8HDMgdFM5y3+62ZbbwWNYAz+AR?=
 =?us-ascii?Q?0maC+3OpAajK86IymbtHBheW56hPGAg6d4g6nA3L/IC0XwYIiPVvMOdYGer5?=
 =?us-ascii?Q?4FAXkZ1VptqVgKcCO292PdH0FYyosoO8v3Zu9bC+ARjgyvw43zLoEc1c32Sv?=
 =?us-ascii?Q?GFXEhB4glgmwwmu7/XADtPWBEr/djN18HxxEX5ThySRiouVB9i4PXKIqJSSY?=
 =?us-ascii?Q?g3MN8bp4Y+sVRWpSGQtBTYQJko13dmYc2Jmw9A8ylrpZvTv/96X5X4/Po/9K?=
 =?us-ascii?Q?ln5e6imYLk79n2cFZ/DiJSExzXy3jMgX2gbuTNirA8cNCtIQRD1MyHYtnt3k?=
 =?us-ascii?Q?/E16a9zzjrixh3k371rQCjZlEgufSTLd/yxmC8DivjJwOixmVQlF96BltwxY?=
 =?us-ascii?Q?Q787qs8sNgcuCJEbLtISQ5l9GN2wUSe8UOingAjx1aFOn67i/Vsa0dnM0lvD?=
 =?us-ascii?Q?WYSHHyTwkI0BY9r24V1JoM+bm3MuI3PW9TfEONcSnr3xxgbZPr4DuZW0+F59?=
 =?us-ascii?Q?5jx8XVQIluz13FENgPskBfCBxlmknQ2eUN7li1tX7wZdo1Crl3an35JqzP4r?=
 =?us-ascii?Q?RKXGpQ/VIM00gqhw5yMf7hfW1caamYV28OBszNL/272Pc0TmJ9lMhYcjjKpN?=
 =?us-ascii?Q?9MG8jtqUs8xKyLVpnAasSRcc/Pb1QESf+N2jHgh3g/fLKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MgMIVQW9YVqGTKV/pgovk5GLO4qM6O6Xk17oGsGyaMiVV3Ga+q+qNikFsahQ?=
 =?us-ascii?Q?4BDIHyA7+DUEidTNAEV9LUDpIBNl0EnahhqqM2jCZbsHak3RPIuU7egyapTw?=
 =?us-ascii?Q?VLcrdWtXFkXOvpV/+wj5v+YeHkqfdSAicSXgFwHqGsuPsEFgOoZPo1dNWUxa?=
 =?us-ascii?Q?R4M+dn328HqOLmSDfYGMgcN4YvI+yWDoVqAPtuYkx0+pCfRdrZIeVQbV0LHp?=
 =?us-ascii?Q?VXFpcnAtcmMd4AaOY1jzpYjWypWaef1IxPE3KAzCrYUF3kjvvb8wPnUZ6toM?=
 =?us-ascii?Q?90yOMQqmlrdwZVNW6nxE48w0p5HChehmyjy0pmtGqRDpXRw81CfArY5kPQDb?=
 =?us-ascii?Q?NOcHB0UaxStWSYQgjCl2XtQjpp+6YCItfjf/2zARJxr74fiIy74pwJcNgatw?=
 =?us-ascii?Q?7/PkmCWbTYzc9w6u4a8peqDh96QAAAE4+RRuItkAbnOZaFE+pp//VbPNYB+C?=
 =?us-ascii?Q?OZQ46a2Zk1tJEG+FxF6Y7gJZHJuvVaF/oDchpEVxyrDBVxL5CxOuuai6HWoo?=
 =?us-ascii?Q?hbNC8cLqluivk6ABQysW3ogpOOvA9ClQkIiEn71vKP27oiyt3bXiNMnc2eKl?=
 =?us-ascii?Q?e7rH/HnMAmlSqFN/e78vdzYvJoPGonIJb7bDfIuUmWmTlCejSvYighd96pIN?=
 =?us-ascii?Q?65/d9SHawQTNvQPf41j/egYFDYZt5xTYVK0N6iG2V5+iZUb8/H9p4mplOOts?=
 =?us-ascii?Q?1al53zRv1UZSxrMjJ7v/qabTjVI4RkT4jMdYEEHx72YpVpu217k3lmW0WFdt?=
 =?us-ascii?Q?U64KTDuQI+LV3plWHqeH8mPnlVwimdAZBcOYSaBj99CxyHNLcVsi4cHjVVZ8?=
 =?us-ascii?Q?nKWcRUn5nCLI/oK9SR1zdktBVcxGv9Vmy3qqIBt/m4PHvKAHPDl2U+yrvTHU?=
 =?us-ascii?Q?Wn3FIxbiyWArVt0cPkQ8eb3Zw2Oq0SwonGOy2AYSKwfByEg5gJrbaGb17wfo?=
 =?us-ascii?Q?w20kW8oOGeHubNxBUc01Ze1Uytb4spwxcXnmajvQ2UmoiTNMkYtsRSMJ+cYs?=
 =?us-ascii?Q?Tpxt+e7Sgb02UqFN4bZVJ7qzm/bAa2d0L49RGIsyj3GNDi3gNVuVvKs3SYEE?=
 =?us-ascii?Q?NhnhP1VjYyLHnpAVtPL0uPgTPVlsnUqX88mmZ2PGMTIIXdafiwSGq908HpGv?=
 =?us-ascii?Q?EjRI0+bIAYa3Js661Muh+ArqFv0sjDnyL2qpnzvGTSy59Pp18+GJKPQCvvP6?=
 =?us-ascii?Q?TVK36CoChpEKxQOjKGSQDIiph53peqdXlO498aWkn97G5FTZbsmBrbZ6itMs?=
 =?us-ascii?Q?EnheU0f9wiBaaBKs8xf6vt8sWHacnqhFPRjUeiRbLDdKwBhHXecVyz2VTs7u?=
 =?us-ascii?Q?DEe32wzZP0GZEj64+xOWY0kScx8qGblM9eCh4LOxd5N8CpQ3oZia34fQQTuG?=
 =?us-ascii?Q?1vYi0ejZJ0jwmCgAI4aIQWhiHQ57cqUvHjjfRcp8+boxBUWm86AvYhvY/hyW?=
 =?us-ascii?Q?dtsTcTg8O/2o+/Roi50bn5xQMx7sQzA4nLey8Lp4n9fjmxEKY+E5rc7ozG7r?=
 =?us-ascii?Q?tLdolf0YQTIaJynm75um8tw9QWHshphFZHjkw1mnVBXXM64gDdK4UOG0k4jA?=
 =?us-ascii?Q?Ll/5n09AzvaMjZvcBHk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a78650-0b14-4fa8-e067-08dc81b4f151
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:02:12.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpMIAzl6f2VJYkOJNcCXtClT7qq9EZonY0MToTXIWLjf6lx348x7Sxi0Ibq7v70oKPh84hz6eSCh8wFuRDz0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9232

The edma feature individual IRQs for each DMA channel at some devices.
Given the presence of numerous eDMA instances, each with multiple channels,
IRQ request during probe results in an extensive list at /proc/interrupts.
However, a significant portion of these channels remains unused by the
system.

Request irq only when a DMA client driver requests a DMA channel.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 15 +++++++++++++++
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma-main.c   | 29 +++++++++++++++--------------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ac04a2ce4fa1f..91a4c11b7cbfd 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -805,6 +805,7 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	int ret;
 
 	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
 		clk_prepare_enable(fsl_chan->clk);
@@ -813,6 +814,17 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
+
+	if (fsl_chan->txirq) {
+		ret = request_irq(fsl_chan->txirq, fsl_chan->irq_handler, IRQF_SHARED,
+				 fsl_chan->chan_name, fsl_chan);
+
+		if (ret) {
+			dma_pool_destroy(fsl_chan->tcd_pool);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -832,6 +844,9 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_edma_unprep_slave_dma(fsl_chan);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
+	if (fsl_chan->txirq)
+		free_irq(fsl_chan->txirq, fsl_chan);
+
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 	dma_pool_destroy(fsl_chan->tcd_pool);
 	fsl_chan->tcd_pool = NULL;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index dfbdcc922ceea..c5a766da02b88 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -172,6 +172,7 @@ struct fsl_edma_chan {
 	int                             priority;
 	int				hw_chanid;
 	int				txirq;
+	irqreturn_t			(*irq_handler)(int irq, void *dev_id);
 	bool				is_rxchan;
 	bool				is_remote;
 	bool				is_multi_fifo;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a1c3c4ed869c5..82ac56be2d832 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -65,6 +65,13 @@ static irqreturn_t fsl_edma3_tx_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
+{
+	struct fsl_edma_chan *fsl_chan = devi_id;
+
+	return fsl_edma_tx_handler(irq, fsl_chan->edma);
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -228,7 +235,6 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 
 static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
-	int ret;
 	int i;
 
 	for (i = 0; i < fsl_edma->n_chans; i++) {
@@ -243,13 +249,7 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 		if (fsl_chan->txirq < 0)
 			return  -EINVAL;
 
-		ret = devm_request_irq(&pdev->dev, fsl_chan->txirq,
-			fsl_edma3_tx_handler, IRQF_SHARED,
-			fsl_chan->chan_name, fsl_chan);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't register chan%d's IRQ.\n", i);
-			return -EINVAL;
-		}
+		fsl_chan->irq_handler = fsl_edma3_tx_handler;
 	}
 
 	return 0;
@@ -278,19 +278,20 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	 */
 	for (i = 0; i < count; i++) {
 		irq = platform_get_irq(pdev, i);
+		ret = 0;
 		if (irq < 0)
 			return -ENXIO;
 
 		/* The last IRQ is for eDMA err */
-		if (i == count - 1)
+		if (i == count - 1) {
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
-		else
-			ret = devm_request_irq(&pdev->dev, irq,
-						fsl_edma_tx_handler, 0,
-						fsl_edma->chans[i].chan_name,
-						fsl_edma);
+		} else {
+			fsl_edma->chans[i].txirq = irq;
+			fsl_edma->chans[i].irq_handler = fsl_edma2_tx_handler;
+		}
+
 		if (ret)
 			return ret;
 	}
-- 
2.34.1



Return-Path: <dmaengine+bounces-3667-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF09B8E87
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1671F263E0
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2024 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4EF156879;
	Fri,  1 Nov 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kGI6Rny6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55269165F1F;
	Fri,  1 Nov 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455456; cv=fail; b=DuheikuWmbNAKSEYUL5fTQhaeDxD272p9+P3xS2K/9AkA2ZVw0VhhLSC5HsPi0TbOUyhBx+JkvAiTELkXUCmtt11GPFFKq4D+HEEyTh3KUcUmAWiNifAlyj3bXZd5FyaWCf2IEfg1C4njzriU1Eo2TexpoCpDihWDmuSX0EwwcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455456; c=relaxed/simple;
	bh=2vaUDbbjH0SnCKbgInmGyflxTp4uRy3bvR9BqM+UjzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ko6UuwE6J71VWLB5rYCXAiIdPb4NSaUCX7n60Ps/gSdBkMemNb7tSxHGtzkuRpSTcVzX9VOsGQAyLbyaKeZ3lKKJ4jZSqh/n6dLse+XMZndQXMv1qvaC1nPgLajvXugoY6GmFbBLJFPGCGkMxgC4KBP0fMpACdL1e6SOdA//SDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kGI6Rny6; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9BKJLpRJnMuH6PykBW6gxg2j4nHtOZYXeRYRIrBQLXDXPo4n4Z+SIVRpCsnX3SAgZl0HcZ8gPV2pP46jXDnbmNF40Y7bEfKDP2CDq2PCUb0Ngpl9Ol40BVBbfovuA0Z/ycpYDOs4J+Z1gwRI1Q5FYr1MW5HhLrhA9oH3/5zredIxQucQyBxFQKiWLjXP5SdEKkVot7Fi7WYVPaVX3cyholInjxwgJNyMHHmSk5BbzfuBN+Gi4+X2eJHSlFsMfXmXVrAfMSpDp/mM+U+xza0L7oG2jSPLYPedZ/AWfRBK34iFm5zOzVIPotZwAnP3fYLvrvO0Cb5r2CO3sTezOzohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goUqK77u6we//E4r9bcReG060QqtPsv0O90z1tBrcyY=;
 b=Zqsqg0WOQNUy1vDHDNGenObp2/OAx7ttIOouq/VQA8V6rGdLSzWg9J51dxtG0pns3ir4bxW9wwsd10n9d1cvCRpvrk0YD7yHfomxDIYCrUDARiTKboQuJxG3bZCf+p9zf9Sq/jhOwONHdGxjKAKC6pgIi/W1o9eigRoXMuLatrji5lNamu6XaYezeqTCwXFi4z78DTpq5q7d/scF+OgQFwhB3pQZdlWFJU+tmoJsv4jUxca2voCdOTI4+1YFyXFzt2cCSdaSOHKqYmI8lBOww3Q+luOFr9c6jkZgToPNSNQVa7mqwxi3jj065wIcg1iNjPxqN5YYopDjc1cCNNe4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goUqK77u6we//E4r9bcReG060QqtPsv0O90z1tBrcyY=;
 b=kGI6Rny6NQ5s0dCql7zPuGYWylAHfB2EFAXAfmZq4rT8jMX4A9znlAv1YsMWgmMAkt2kM9MS5GIN3EwZwVnPIslcoJgpmSjnCASibKiycCRouPcfgmUN/gzEhYzs1SWgcevrOPYo1l2yLZLfTWivZSJFIgldAgc6PlMcgxCRP6WDAWPqlJIEvNTji6vsrrFtEpfujCzNGsWT/F+c5vERM4lYijsv+fxzl9QjEBV4LQBzhaTLbSWmBeOhOmPs2XrmyGbhMzMPfX7g7CAxTPyftT3VHyhb5iaPfY7WD4aHraUgtKXgComvsSViMf8s6sYmUacc9m1CK8BOqc7688F7Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:04:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:04:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
Date: Fri,  1 Nov 2024 18:14:09 +0800
Message-Id: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa50477-f91e-45d2-a2d4-08dcfa5c87fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpzRCh10eBP1T+sQ4+XhM0jTOLriRDWfekMDCnyS74ROQZGL5vzhh2EHowaD?=
 =?us-ascii?Q?CAserKmyw8agTbLbzJbL8T1RobgS9ZhzVyN21Cfvi4rD1Ptaxgy4LTQ194lk?=
 =?us-ascii?Q?LhlPtS1WTdHBwwGpWCKICY8xF3Z6H523taa40NgR/5PPwlhaBvhhg76DdrLk?=
 =?us-ascii?Q?7rWMAbcKhdYA7L+PcSVlP0A1q01IDEeMuMDO1RWgnDAkQDp25CG+W5P9lIVn?=
 =?us-ascii?Q?gZk5dmunenlN3HE8xq4ESPqKzGoeRwg+yl2r5VwzLu0Ynvza67YM/+UAoryI?=
 =?us-ascii?Q?I2jPi9ACuL1RESw9Y0IGCSeDqkeSYP5IPLdH5Yvl2EXERww3O+LTjT2yolNn?=
 =?us-ascii?Q?XG7Sf23B+J0IJe4JnWay2b8emN9CsXwHoJezT7eHFq8jHQKffuOpPEyR7SBP?=
 =?us-ascii?Q?i4YbXAOaIhRvxkyw+/HjTDF0XNznPLmty0JQO4FtEfvnnyWMH/VfBdCJqSDy?=
 =?us-ascii?Q?hj5ngA8cVmM0MjalRuKi+MPvpMF2bVHbJAfPInZXQrbmZD9Z6GZj497j7CaF?=
 =?us-ascii?Q?bb9qJktMbEYC9FH1HVK3P74S3k1wrdZLd2yP0jZCGxOqToDTW14uwfZHbyKH?=
 =?us-ascii?Q?/IQ7X1pmJhE50VRxauyATiJXnBtAdy9r/1oa8zzrTLfFphayvsAwRH7W/xMn?=
 =?us-ascii?Q?oMUSVlGv4CXLHvsYosl+ARHrYeTHISWOwxJ4mfdbR9Q8xDV4ldYRNrdGfcPe?=
 =?us-ascii?Q?O+wX/wYWyh781AcjvOuCVPG6h6MdwcLlYajdG2ioGbIOn/iSNJIwlqz60m0u?=
 =?us-ascii?Q?8mcAfplf8yIOOoDU5aF87/wOxML1hHrtfOCUogW8aiJ76fTqxZ0JxdiYBHUY?=
 =?us-ascii?Q?d2y5oNYrj8y75f8jR+kML9fE1hkoR+I6ueFt0GUBu7eMT/CCrzldpefxZDDX?=
 =?us-ascii?Q?XwfGRZSCX59dY3vu0SxvP+NcZxfjzSMb2yjVF8vq03vSQlWegCtxiMFmSE5+?=
 =?us-ascii?Q?9b+bX/byJjjTkpK50uwOMU0DokWNnHSzOnUO6Wwc5HZQ1vYj3FtSMNFBJxE7?=
 =?us-ascii?Q?WpN9tzY1CV2C8w8iboa9DHmDm+BFvOWiDt/wUGhMjF9QQw0SHIoRsvRWRZS4?=
 =?us-ascii?Q?BPyvGoDguRQ0Tf2fJfnYDFXXWWgNoxfLeNTjZDfU9hu/pkKEfU4SyPVY0Dm/?=
 =?us-ascii?Q?SInrJqlcS8mPBUwEPnAbkuYHJTOGdZBzrbriXyPBv2dvY3f8u7ia0I0N6syN?=
 =?us-ascii?Q?Fjc7U5tvj41wuHYqhsRZ/N+36Q1XJ4zdgqUwse0nw0gsx18iBamXFCqjVRz4?=
 =?us-ascii?Q?LwqjPH4XiuPEkETEzLQpNPm0p/rs5ggWOPB7L4CSNh9/Za8i/NpB2xY3/Tcs?=
 =?us-ascii?Q?BcLxP996vWX22H8GiSvgXNZkC61QKdMzRPf6MPkmAgynpOpukLC+g3aMR8KQ?=
 =?us-ascii?Q?2u958og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODQqXhDXpKtyziyaezcPaKgvUaN7Xf422SCBcS7TbJwkjm6RaRQgPSt4nWeL?=
 =?us-ascii?Q?pRoMKpeOn6AuHvPArRkbguLzzln+4m0BL1P5V9rEsyWpVgMY+8oi5bpdngTa?=
 =?us-ascii?Q?2u19F1H4DridigrrBDwK6hRmvqHL6rW738a022sHp/o/5nEECec3bOHtEJVL?=
 =?us-ascii?Q?ZN0GlItEv5mVnDtNKN09yZzPJwCVY/xEOHBzbdphLy/BS0iylP8sctyI3Huz?=
 =?us-ascii?Q?ym3C4V4wIIE410K2z6naqXNi+lmtT4r5FH9qETpH8NeEAwn9+mBXM3LVnJaa?=
 =?us-ascii?Q?aLGwoge6S3uctIREud8CkQGNr0GSdc8v7AeUpaGB3ZOvThiGofzV+wmfVjWr?=
 =?us-ascii?Q?JgLmn0s1jOJndevBUH0bWutGLXXDDS9H+IbTHg8u53e2IqX3S9AHJJV3ub4l?=
 =?us-ascii?Q?BHMe/9/umCHo64jXFdRTf20v5EaEbfg1bTODcM5pSHV4Z6mfGnrymO06aoWR?=
 =?us-ascii?Q?OBIuovusvRit2AnqZMviTmIoc2nEstPt9gVzvCgvLzthKCbYycSs6OiVjhDV?=
 =?us-ascii?Q?3xiQ4EEQpHQNN4sfJz9EtU8iH29mbqsqg2p7Fm08df/e3v+8Uc9iQguzZv1V?=
 =?us-ascii?Q?zfLvljrnroU25nlOQmhl+ikYt3jcP4sPCxOMPXxKxKDHSpB4qWVyFSN7P8fo?=
 =?us-ascii?Q?+fVuI03TwVx9Vk/091dEhly02CMDTrj0LQ1HiyPWT6hOi1ZG9wEel83tt4I4?=
 =?us-ascii?Q?OKiDBr7bZf2SPwxT2ecc+2toVcgU+10YSzGoN91txjY6ACwV1UrLoko9xpRH?=
 =?us-ascii?Q?XakJl/DC9ZhrzSxN7oIxAuCGg1AicTeux+yckeu8zCwzHqaimX2LIrhMqTur?=
 =?us-ascii?Q?3BmisTCz/EIvrndo36Gst2RzsZh3Cluo9dWDSDy2NA84qrqcY145RThpI47j?=
 =?us-ascii?Q?n4NIRAtnKCGhF5izaRATMwNnRQJY6/7AUe4vkxVZnHdlHTpuLFDMctsMNMtb?=
 =?us-ascii?Q?OVG630Tu/FDDMW+uBkwyy/GKaT+tjjkbWdnRpZ0WEi6fYKHEKlkKHDAcedUc?=
 =?us-ascii?Q?K66PpWIgAc26L3A8S9bVRwqViK8pTh3VD4QCtCyTGWA570xhJcsUTto9nKDo?=
 =?us-ascii?Q?rc9VO/C+6RUCJeIGgio3QsnCqSTtPecd00WIUhL1EXjKUMye9Xv9hMilUgzS?=
 =?us-ascii?Q?D1b8p7aLr8e7IFb6gLZxJS9ZDPMSN6E/j3w3wrz2eCYlMv18iW68Q1oOjYM2?=
 =?us-ascii?Q?khfznEEIfNwzasd4Mxc7dlxPnQx48NohyIJhokwGtfO1UBSu0Ww5iHXIZF2D?=
 =?us-ascii?Q?5RUxpQDKdAa4zSWpU36FKg4F3kJoAQD530T9NM+hzBJYdcN/98xkqurSOwmx?=
 =?us-ascii?Q?L54leb/k4+uoXD210BpzJ1JQjyZTEL1vNBJqN1B2lAeOTy28NMJr97JtBn4J?=
 =?us-ascii?Q?MA1aW3NIlPFHPDVaMSj1ALg4iFTG1P+ca2GBzbBbQ1yCTfrWNC15RXvlR5eH?=
 =?us-ascii?Q?YoagzVzbwsLbx6vNSj1wX7GKkzTYmGKkzrM4F48W1BjKJiaqwEH2i+f0UjvQ?=
 =?us-ascii?Q?9TpOgfOurx0pySC6I/8518J8XZcVWwg0QGYleKWYb9OYL5iZd7JI00fi9dW3?=
 =?us-ascii?Q?XKdoC36WG8wGvNI/OlOltryC3l0RWPCoZKcrtQA/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa50477-f91e-45d2-a2d4-08dcfa5c87fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:04:10.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPNrNhy3p67vBCWWUB13/Xvsna6bvu3vtx/vPVMNIIjYEGo+H2HpEFMkNJ+itTEe/kNslVJKej5qCXAIs07ACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

From: Peng Fan <peng.fan@nxp.com>

There is kernel dump when do module test:
sysfs: cannot create duplicate filename '/devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0'
 __dma_async_device_channel_register+0x128/0x19c
 dma_async_device_register+0x150/0x454
 fsl_edma_probe+0x6cc/0x8a0
 platform_probe+0x68/0xc8

Clean up chan after dma_async_device_unregister to address this.

Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon exit")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f9f1eda79254..01bd5cb24a49 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -668,9 +668,9 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
+	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }
 
-- 
2.37.1



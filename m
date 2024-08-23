Return-Path: <dmaengine+bounces-2939-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E795CA52
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92851F2142C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCDB13AA3F;
	Fri, 23 Aug 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RqISrgSL"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94F17E006;
	Fri, 23 Aug 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408399; cv=fail; b=Ur5uKaHFhTsq9z29g1cwZleRhxyjnIQjyrdPYta4lViK7KmHZH2x2YPY+uSmmCMMYQFBuaIOnAq79IHrOjqiBw2v4eR3TpfaU07o5d457QeTqA+TJM/glX7YnPB8KBw2TGd+kXDVhlMXdlRHLLp64FS+bI2O/4aa2XRH4CxzPaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408399; c=relaxed/simple;
	bh=qiUHQsxda2JlbDUHPsJcR/8nIUB8bwNwi9eJMzRqFqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYUeKd599v64bFlCHuYD83T4An7+nqPfmGkrQmoFGj1HWrd2gXugatGoqPv/Tf0ZQ7OH4aLS3/Kz2hAMuaap8Wk3jHK4uw5YXuZAtKTfAsNjS98aybQC9OWW2p62F1EK/WqnYDbBcABciL9VIZ7GMMGWabutF1jmxPs6gZh6wBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RqISrgSL; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALPxwe5alUos9HrzzTxk6cKemH4hh+jOUz60lILPO2IxCPZ5PKBOY1ImEiYz4eQtF04AQ6ti23K68khG1jr+nlD37PGu0cFoQaoikkxNdzWStoFgYigxBnCmCnnEXghQIDNlGQtm8fDVVJ7y72blLj+GktyHMoi2LhnmBx559oXHxJ4nm2Zrn/SzgZQUGkLcMIhZ4pBp8EHXzkBgXE26C0fzzA7Imm1l8lVn2shgcBR6rfQDedljEpPKAXCUymkEXtGBOy69QLcckz4Z82V8BZSSmiBhwgYynCubB8gtENmIDGZmn72Y3zVRqgh7WSk5V8zZFVvzX7OTu+wfAdNb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8seUex0RD2SKfh+Sl7egdxEBbYQR2pQwRBCpA5Wan8M=;
 b=piQSwUTxCpUokIvXrFq0EkDaKMQCbqtijbAqCpa5SQ7Ru6R+/63YZWg9SK2pEjUOdY3bjEeR2On4aURlONWqx/+4siMdsEgZW7lual8R1Bzk7+6C/fjTL2ie36Csd2FPROkdT2TFqin4FEKX1CDleGwVVh/1Mv3vbkWHOCXkZ643pWZaw/FYudvz/0mx6NYUq0ZmyLIAaRRFt6E0MdVe68WVSuecEAPggvjbaterJKdxu1KbrlUu4/dV9jfqkJGcNvHAHigeixrpUE5xqVpUryE2tIkcLE9fdVs65eGYgua2u0p3tfKfg/Llo77Hg+AlFjnQFA40YNOEOFKVG1LVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8seUex0RD2SKfh+Sl7egdxEBbYQR2pQwRBCpA5Wan8M=;
 b=RqISrgSLJ0AHBdBPMDOVD/T48SB5KbcQXrVfU3ohrPrw9xJ+omBOzsWzMDX9JtlslUOX6/3trJL+XcqPSOjX4qbwvqH1vQlag8WOKAXB8B1bO5ChNPjhiguJjgsGM9Pb3Y/7gdyf4Xnuo1/B3lSFauGuHn/LU8KOK4MUR4o17zebfrumrdIc477E1hFiNsGZEAuRnhF3R7PyJn6dbQniSguzVHKT2Z4CofhmflpwKiXim0tf0KC1VCSxs3tZnrhDmvrq59kCpALjuw5kWRoS9x5SI3GvPT6/yBL5f5AUVSGmLtuaglNdRVF+g5oBoda9xLRYn0aMJNuroXZ+HP/pzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYUPR06MB5873.apcprd06.prod.outlook.com (2603:1096:400:345::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:19:54 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:19:54 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 1/6] dma:at_hdmac:Use devm_clk_get_enabled() helpers
Date: Fri, 23 Aug 2024 18:19:28 +0800
Message-Id: <20240823101933.9517-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-1-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYUPR06MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: d74f1b3e-8cd4-459c-5664-08dcc35d21b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yz+tImNTnCUN59sp91Njvdxj7XJ8vVHEwtdLjivi3zHu+CPbLRKQtjeMugCA?=
 =?us-ascii?Q?3Xis4Jt5vXitse013u79bN7F7k9XhNCkx+EzTmF7yhm888HPf8bit2BqkLGH?=
 =?us-ascii?Q?HEAddVsZNsK/gSDmz0D4zQzn8m67qXP6wAFENLGmDjD+X4ySWhOeIw2745EG?=
 =?us-ascii?Q?2cNHJ8ddU3oEk937Bo7fc0pi7wvhRUC10CCTgHLX6ON6D+4iijvHipQOXSoI?=
 =?us-ascii?Q?sK6ATxcAyxripfzMxYN24IUoNCnxG+20gNdHND8UVHAM7lVj73ajBTY5DVRU?=
 =?us-ascii?Q?1WBINkug3dj4mBdNJRhFbV/+IpB0yoNjVovtTCLl3EwmuO7df7NsvWrL4931?=
 =?us-ascii?Q?6fyHEJ0Z6f6LepoMeXjgQAvdnrwaMytIxuPYkHUDf5+YOiRGjalcay+RU0/p?=
 =?us-ascii?Q?CK+etxEru8TyHYTCnrigvnmum2Lh0+f/ORDsL3zKS675EPVEi2Uku91t1xll?=
 =?us-ascii?Q?cqgrGMSQS4vExCgsrKoyzZZmxjb57BINuHz8fuK+6jJatmzRkKHMs8doXcYn?=
 =?us-ascii?Q?xJebQmGncbrakzQrMITDLUOTgPNI6VpbchOXc1rKBnwYRz1hQo00D/aN1MeD?=
 =?us-ascii?Q?BaxWjEOJw2XPFUSG4qMBLVn03kXM0YuUHqOlIozKnQZLodsDP0wiGXm2Hf2/?=
 =?us-ascii?Q?8+JGxL6tozhM1wdCas5tgTnjnzFSGjzCUp/y5HYbTUvv42BOukvOX6FbmZYJ?=
 =?us-ascii?Q?/CThAzKBIs0gQHdNE8J48Is3l58foBmr7jBZDBrzhjCeuM2Six5RwUqQKDBA?=
 =?us-ascii?Q?Xx+f5yMZxqYhO8tU5wMoV+dEsb8cow7berIr4t3h/Wrag8vATO2TOm6aNarV?=
 =?us-ascii?Q?DGGzEck8YmPKUfGgw7tSm6blXGof66EhM0d+GaVSE/SgBDXtmiVzCT/ev9i/?=
 =?us-ascii?Q?by7qfgw9Vi4f5vlAiU+x1K2HhCkL/bLCprBYbPsfMfgy/P8yq0FLUQtHuVYx?=
 =?us-ascii?Q?jKHjM42wFscbdboaBBZ42d5XJaFKhZtjPOV1cqzgFSA61SUpZW4sMoChEJJU?=
 =?us-ascii?Q?n9fXOwNTRxZAUQa2q0vYBpkum1XOlLQEv3Ye56P2r97OCU2wPhkU5rEBbkEK?=
 =?us-ascii?Q?+RRmPFncAelw6ReCHP9Jccrpym2y3pf54t0AqT9Udy20rQTtCFP7VirsLwj8?=
 =?us-ascii?Q?N1TfYRJi9HGHUwWjN2lTTmTlk+uu1a9rpvC7y8zcn6nPSICmPmb7ms91iOHr?=
 =?us-ascii?Q?io1z4L9MhBRWOv7Z0VIULGm1iJE7cCZXgYmULHjuwl3CCih6PruKTLKkl3dX?=
 =?us-ascii?Q?l9grEtGQ2bWjJkdFAaVrcjSc4p6fnwRQmay3Ak0EFAZpsdOT9perpm+icCDS?=
 =?us-ascii?Q?PvujevW1CEznlQCgDgEh5XwtkbwElNpv91vbvxEb//HmIwIG5gVsoFY8EY4/?=
 =?us-ascii?Q?Jx4fJIcdQPNn7pyXlWob3fvO0XUNPr8fkC45YZ8Uu2Y9hzdrxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AOzcYHh3GUqjrb1UMRhiao7aJ9Txm2zHqswmERRjbfAnmuiXpdFf+OTT+JXG?=
 =?us-ascii?Q?ZAs7R2exr27cUJE9CZzyZXxrXWYcn2Tuj/+q1VSyZbHeVFsTenrmS4wqFHdn?=
 =?us-ascii?Q?f0prYgw+xJdfYx1l9oGfdJLTmLUzqgou2RJRcgc7qFTnOqdlyRdcDHlkRe+C?=
 =?us-ascii?Q?zMCHqhODKEcNxlJDgAEA/ApZZsK+zi5q/RppTAlfRRZa0zb/nH1CwcbZPnGm?=
 =?us-ascii?Q?W/PqNVkjtK64NM5rtZzX3WlyJy0accX52Q3oJsmdAM8My0cQBWwGsP8OVSDX?=
 =?us-ascii?Q?ELDHwNffgUtMZAiS0tPhu90YLHsf/gTZoVrUjMw8yevnFbryxr7cC7vqkkDN?=
 =?us-ascii?Q?Z4SwxhUyc8R7llrRJlbGAWTnrN4d8ZX0PgTTZ0178odmrXXlOoagft6QIyZt?=
 =?us-ascii?Q?/iCwz9Jvwh0jfvqjHo9e4sHnV6VvVDDfZKW0eJZSajorA3xetkCVjMTNk7Lp?=
 =?us-ascii?Q?p4OrxcquVxalZGkuugQ4PgpvdaqPKrQFqow4DBhYosH/IC5LYVc0oO4DOBmn?=
 =?us-ascii?Q?G1KbT7JNNaSyDomgrioilufUtnmmt8fNoLF1hhpMC3k55OakE1JUykm7DzjU?=
 =?us-ascii?Q?wvWH8VX6bhvM9BCb15SgQlF17/GXmgJMBWs7AzPihU5LE0aK6RPRiWD9eds+?=
 =?us-ascii?Q?bNjQRh8FanLJasuqez2VkKvDd2K3zLgEU7bNp3vOklXgLGZIXRB3waYygNfC?=
 =?us-ascii?Q?5D1X/48rm5awCtKuAezXd77bcvdsT9u6MLBSkQZQcLOv47y0zyEIhD8YSdAX?=
 =?us-ascii?Q?0ODwaucKRs57g9aWRB7ggDk+qhW/FZa/SIgFq5j6xQvLn1+UwNzxtB1tnAqE?=
 =?us-ascii?Q?defefL2RuNw5Ku3FVg+NL1z2Y5P5rrhgKSePDG5zo+zZLkmFiNr0G92+Ll50?=
 =?us-ascii?Q?7FFi/xGpk/1ksJYW5yc8NvQILDPmBEYdClhPXzx8iXtD7U3OKX3fguRPC5qd?=
 =?us-ascii?Q?yQBW3JnUQ4RrEmH1doDMI7sZ/b1HbHR/fCv/Nb7RJMeRWFJ0UxWhX5UQTgfj?=
 =?us-ascii?Q?xoT3OmM3SRa/t4k/xPjgInml9s/gIf090yh/4vYS3G4RySoqVbi/i/pYnzr6?=
 =?us-ascii?Q?p64IiUk+XRF9/YVuzArsGFNwanAW/NRTwohSTGRvvpd3wBg0juxTBEH4YnJ2?=
 =?us-ascii?Q?67k6SoX46MBZRjyalxZVIVZ3w/rh9s1NN+51lF+nDySfTGrgWpp8FoBcWKN4?=
 =?us-ascii?Q?i5q8TZqrFpG2GISFW+O6oSkm8feivf99HVlXNmE4VguepEXPzGu1KXcyjE2J?=
 =?us-ascii?Q?9ygVqNB3TAZRisRMMEFARqaWJVRGt2rcRL9RYd3RmimEEQKDeF9lUE79aubY?=
 =?us-ascii?Q?leAVOvO0IhVr7DL4lP4xGU3HD/pJncHCidKrizbUUeSdSLz7wMOG4grALDJQ?=
 =?us-ascii?Q?4LrMdgSEtqZkNT0/qdSnwFL7xI+OXe4RfTTf/KyvXtOGWNAfgrZQIlBmmKAf?=
 =?us-ascii?Q?PoUAJ8M+0HQVm5YBQztT4F9MG09zoFscuMdZnRblqQY6Ox+c6ppLAG/zkFaJ?=
 =?us-ascii?Q?PZKpPzaYw7AOwIBAuPnd99Or38uI/v/xze3xE/tFKOJBI0f0sFv+Ik9EV5oB?=
 =?us-ascii?Q?MyVEw0wfR6KD0phJ2feAVfCn5XmVWmeYB+uyTsLl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f1b3e-8cd4-459c-5664-08dcc35d21b6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:19:54.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXX0v+Z/vFE7jupz8DGWbrjMb/sFV5hZSi65DmCxry9KtNB6UtNM9KZCloivd7bSQrhAvYFGVl0A/4ZVzJzrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5873

Use devm_clk_get_enabled() instead of clk functions in at_hdmac.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/dma/at_hdmac.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 40052d1bd0b5..b1e10541cb12 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -337,7 +337,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * struct at_dma - internal representation of an Atmel HDMA Controller
  * @dma_device: dmaengine dma_device object members
  * @regs: memory mapped register base
- * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
  * @all_chan_mask: all channels availlable in a mask
  * @lli_pool: hw lli table
@@ -347,7 +346,6 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
 struct at_dma {
 	struct dma_device	dma_device;
 	void __iomem		*regs;
-	struct clk		*clk;
 	u32			save_imr;
 
 	u8			all_chan_mask;
@@ -1942,6 +1940,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	int			err;
 	int			i;
 	const struct at_dma_platform_data *plat_dat;
+	struct clk	*clk;
 
 	/* setup platform data for each SoC */
 	dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
@@ -1975,20 +1974,16 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	atdma->dma_device.cap_mask = plat_dat->cap_mask;
 	atdma->all_chan_mask = (1 << plat_dat->nr_channels) - 1;
 
-	atdma->clk = devm_clk_get(&pdev->dev, "dma_clk");
-	if (IS_ERR(atdma->clk))
-		return PTR_ERR(atdma->clk);
-
-	err = clk_prepare_enable(atdma->clk);
-	if (err)
-		return err;
+	clk = devm_clk_get_enabled(&pdev->dev, "dma_clk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* force dma off, just in case */
 	at_dma_off(atdma);
 
 	err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
 	if (err)
-		goto err_irq;
+		return err;
 
 	platform_set_drvdata(pdev, atdma);
 
@@ -2105,8 +2100,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_pool_destroy(atdma->lli_pool);
 err_desc_pool_create:
 	free_irq(platform_get_irq(pdev, 0), atdma);
-err_irq:
-	clk_disable_unprepare(atdma->clk);
 	return err;
 }
 
@@ -2130,8 +2123,6 @@ static void at_dma_remove(struct platform_device *pdev)
 		atc_disable_chan_irq(atdma, chan->chan_id);
 		list_del(&chan->device_node);
 	}
-
-	clk_disable_unprepare(atdma->clk);
 }
 
 static void at_dma_shutdown(struct platform_device *pdev)
@@ -2139,7 +2130,6 @@ static void at_dma_shutdown(struct platform_device *pdev)
 	struct at_dma	*atdma = platform_get_drvdata(pdev);
 
 	at_dma_off(platform_get_drvdata(pdev));
-	clk_disable_unprepare(atdma->clk);
 }
 
 static int at_dma_prepare(struct device *dev)
@@ -2194,7 +2184,6 @@ static int at_dma_suspend_noirq(struct device *dev)
 
 	/* disable DMA controller */
 	at_dma_off(atdma);
-	clk_disable_unprepare(atdma->clk);
 	return 0;
 }
 
@@ -2223,7 +2212,6 @@ static int at_dma_resume_noirq(struct device *dev)
 	struct dma_chan *chan, *_chan;
 
 	/* bring back DMA controller */
-	clk_prepare_enable(atdma->clk);
 	dma_writel(atdma, EN, AT_DMA_ENABLE);
 
 	/* clear any pending interrupt */
-- 
2.25.1



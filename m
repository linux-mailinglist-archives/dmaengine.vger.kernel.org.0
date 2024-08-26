Return-Path: <dmaengine+bounces-2966-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41795F138
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09DC1C21C73
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193213BACE;
	Mon, 26 Aug 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="R8O+D19T"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD031714C1;
	Mon, 26 Aug 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674937; cv=fail; b=k0/eD85/52m/iqGi7iQvGwWEJgU1QYroVWAhHvi2MTcBxyqd1fkxW3cHEG/Z/QBJbVJG/cKqtyBZfQUVCnvo0x3YRPHtoIIBpMbafTzW+7h7+nrwNr0G4zcsrUQ7xbYw1gEPGaUSnu6nDCKKnh4zYAKxw6Frp1bar4QUTP6uuWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674937; c=relaxed/simple;
	bh=Zng9Dkq0VJmYiEQ5/mqoyz2BtOH/XgfxVEamIofta7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/zTRj38sZdngsGo3QX5kAzGgf58ubOKALfLyQ5mkxjWUvrmQy29N6j+gLbzk3AhgRH88+a1A+XdicZN8rEeGF+W7Biwjhmf231Mhm0ZdXBza7MWVoVg2BKOJ4ZbCqFj+OZip4aT/p3t+xIyS3F/YUtd2j8WhZ7B6yBssEvGN8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=R8O+D19T; arc=fail smtp.client-ip=40.107.117.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrQ0dDpxUxdZpbJ0Ti9aoZfBMIAbqK208epn9Gif5U/o26TNNMC/baMV7LVDSvkBXU/1StgKbOkBsL4C2cwuqARHY+S+o+DP4XbB/GyO768BZIsou+vCoPS71QIzj7VLNCzfOCxaEWK0VW63RZufiKemYMUvQ8tTusWR0A0pMFwKh7pz4MuRgOq3DfCj4uYGRQSyY65nG9ZeqwTYnl/r3XQJcg9xo7U1moniXXuqu2FgDbuzGga8zXxC/diVM1wMLXnOz/b3RJgI/bD448jM4LxZDqO9YIgVtUxO5jZg53cpjsgQd09CRekAov9pzDdI2Ydt4vZx+6hgpocchWCzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6FYtsFhEyMFGAEXQO/gNbqqqnQUPVCJE0i/0b/U9fk=;
 b=tiFvTv1eV6BjKoGAB/y/rWZFA4y1RoYR7ldh6kNOMeHOG/1qsNssF9/Jsz78fRUvXp3ioNQDr4PAI/Mz2lP9a+bfeRaORk+dwQTN7Cqr+mdbzO9lV5EVjXjGZU2qkjTXkbph9eld8wGXP27t0Fa4EJKzqHqxc1TXM3tHH7c1JBFQ+GUW0lnoL2GAGSk9p+MS8JylleKYzLTn7T5ROCNR5eQ3zKxh+d51+TnQqVPZXiIJQQWbksH2nHetcLA8C8Sr3eQmuNKsKk+Yd3lcFV6BQHD3Ke9algh5xlyNvNDHTPyXhLBnFf1DAL6Ff3sXawo4qfeBYcwMzJH8O/cuqJRi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6FYtsFhEyMFGAEXQO/gNbqqqnQUPVCJE0i/0b/U9fk=;
 b=R8O+D19T/IOoniWcrweNyBMnCpOGTvSlaUh+xzFjiSjvQtiaJqm9sFfQmgsmhjIZEytNToTkH4C/WXxm1m3WlSnr+jTL4Q3S5YpXG8DRcJf+YKgoYZdTEmthOwf8hAn1LBMAU+RX5ESM4WQTkfMVDob6vzpKUFeZvfzeQuyoGFBxoXF6EjdaiX+0iLs8SIe6yRHSDjDvBd1Q7hehqR6Mg1xG/oVi7zhBK0mG8xC+AIUqqRPrIXdpRB23N57r0a5tzR1mhqan0/R6wZ5yFEHEHq9EIQiu0CgU0CkV5ngIGMtlgYAMkA6b2hFFhvgehbBYbiTLMXkScavBHh71642u8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6904.apcprd06.prod.outlook.com (2603:1096:101:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:22:10 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:22:09 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 3/6] dma:imx-dma:Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 20:21:56 +0800
Message-Id: <20240826122156.27038-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823101933.9517-4-liaoyuanhong@vivo.com>
References: <20240823101933.9517-4-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::36) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5374b087-7d75-4f2b-eb4e-08dcc5c9b4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7DJd0wyBHJLXZVkzYpT7jpjNcsQzDQpO0cMr+ftoosPOcvtWxjkk6G+6oTL?=
 =?us-ascii?Q?IvdnsrvxvuZ2swXccHjxiE82BmNAriYl1IF8Rq/Hu2lUI4+ZDfNEi/u0tbuc?=
 =?us-ascii?Q?r2KgdHpDwNFqjMcNPr9gXKX4S81YrOUAjYUPc2Zt7wi3+DEEgmD4Dj0/PWTB?=
 =?us-ascii?Q?ePix0Fz+MGNtwwSVm5ROur43SQ94vfHX2TJ094FiyqjtYLE/YJ9O1ngX2SLm?=
 =?us-ascii?Q?VYB2nXT3ZZuG22nYF/RWO/YhokolOLfkBrb8UnGdv+GaXkiAJRpGKwgkSLR1?=
 =?us-ascii?Q?ApxHZZ6wmVXFtcLPmoKRKmdk5Yio70ZiqKPWSgsAAGDObHn3+Sv7QhDL30KM?=
 =?us-ascii?Q?wN3ziXjIE4wAgHINTy4Ap2mcxKR7rYHDfbpTyub81M7H6Hhi306DcHFAX54s?=
 =?us-ascii?Q?BXhY5d+/z38gGwjFjU7otPiv40Fa9Eig1dxFv6JyB6HFpR12bvIOeu+Rhpvq?=
 =?us-ascii?Q?zQE8F2Sr2XvWMdH5FKh/eyO30ZjgJodXMHQfC6b5rWdTdAVvihUI/zNULVIm?=
 =?us-ascii?Q?XwJ3KuoC5aEPZI0++WcrFSv3Ul4QqO8PE68ErQBM0OTQOShdKF6QGX2vgj0A?=
 =?us-ascii?Q?svImNv26aM2eU2/RYHk+NYp6IVzY6jyfkM5n0t1cg9NwlKkaOb2DesBFJS2/?=
 =?us-ascii?Q?4dnLSWQ6OGNzrdQOmN4oX4rp886uXQOi2Ws9uPU+ODw1glzMrJrnWByoxEho?=
 =?us-ascii?Q?d4u2rL9nedgj4D47h+za8g6wrcPFbUI1Ph3eKtZnqVXOVSz9dNzTOoSK2DfC?=
 =?us-ascii?Q?ap5hA0/eUd5B5Rc7KwWPu7n6FaOU3hG6uznLUOGCpS+MldUQVCRI0ugKTuz3?=
 =?us-ascii?Q?6xtSXVM+iIaKTR0VChvV3yeWz0SjMRAY4iLlqhaqESpZDjuSt+iYHBQpJiRs?=
 =?us-ascii?Q?a5FHg6jInBaO2IiSe45x36g52MlDiD2Esl2R5mZdqShVOWoztkUyPw+WOsjk?=
 =?us-ascii?Q?lHv7akDYStCo6qV8qMtYWJ4Dj9+mu6saAIL47fgL1Zvuk+GqcRhd8iO9goJO?=
 =?us-ascii?Q?SbFqmeKB3PN86v9jL1BTLdKYvalBQjPTgA7HYDAUeQ/2gQLU+bE5mFj8bsEI?=
 =?us-ascii?Q?AlJkywcHAE9Abx30EjN36h/V7lHRjv8A4p8CNV5mkr1orjqSA8e00+69RCoE?=
 =?us-ascii?Q?BSLk8cW6Jg5QsGUAR8I5k0EtOqYXENlfzTutp0y/eiVPk9MBOZxilAz6o5vV?=
 =?us-ascii?Q?M8JQC/2VmwPcSrnUY0Etc2PB4LAIJCv1+S7xRAWsrthFG0Inf/TFQd+zWkV4?=
 =?us-ascii?Q?2sJBDrDIO0w9BXu3HOWKtBImRtf0mpzio6cPuNsz9h6WJNWGrueDV51dHQL1?=
 =?us-ascii?Q?HT125op2cM4tcPcqLBQH5hJhnvsE7UWuxdps7eGhjFXaO/x6Uyf1vkhl+mJg?=
 =?us-ascii?Q?bp+tdj09nuywxUM9w4vhkhoI+O0pzgC0IvPUuKEsAi0T7oWcDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXVfpr+Q8oDmq+3gy7CSdT/ccPvcCbccIgCyHf/F5ShcNudjYNa7ntZBUX0w?=
 =?us-ascii?Q?Z7x4sZCRwEyyj4gEYgtSHO4dN3ycEXDv/Ws0HMJ5W8rn3yWeuypEkKIFJx/7?=
 =?us-ascii?Q?JLLv4X95ezj2aPp9ZVIefXFf02Qnx2fc7/gzw2HwA2MnTpBXvr82bC9nBfUl?=
 =?us-ascii?Q?IYC3ReYRIA7mDEgeUvt5XRW977Q/3u675bqJ6sMOYhEfvLadUbEXeWYa+4sy?=
 =?us-ascii?Q?gYjUU3u4adUXbLK47dTRlgPfT7zw63tLZFyYae7CyZc/MkXaB/4M+GUAT0bJ?=
 =?us-ascii?Q?/AfRU50cwYXsJLEDPN97TAtPHWbqr0qaTCPlOKxI1giHpJv+n25VZbMqukuF?=
 =?us-ascii?Q?JOZod3eguUGnMMsFFAV0yPsyiwiWzOY5F56kIAC8TleeVAwSS8yl63Q9rc/W?=
 =?us-ascii?Q?pAvVS4tOjllTIlDpNkyl0xWD1ftVRY0Yl5kBz8NyS/xta6demE2aE0IAOUbq?=
 =?us-ascii?Q?SD3FswE5UintNNhb+rDQAkXVYVfVrMQoDQYvbs2PJv0UHpazBbu3E8TZxt5V?=
 =?us-ascii?Q?oL4dzDR5+y71PfEMfMJ5SuYzkhQc8+67Cx/EFRTyFqSqJSrB24c8Y6+Gsmzn?=
 =?us-ascii?Q?KhudHKWJLppuv7kXnbi/6yo1pepEXwl5WkCnbqxZVA49RlTPUZnFKtByOHuU?=
 =?us-ascii?Q?TuWIk1fsaHqYyTeyKT+jCOJg0sGnwt8VZtUoLvcf/o7wrgD5gIsxgIBhPFTW?=
 =?us-ascii?Q?Uogc+N52u8m3UKO3+E/ett0wUlOFLuJuqRUIr30d6V1OpsfzJOB5s+1jWrJQ?=
 =?us-ascii?Q?qhIfRnlSOdJtQXjcnaVkyo0vXcs6+ZkXIYEYQGYm0bsq1oz8kT/zLdlKLCA8?=
 =?us-ascii?Q?w2hfyEaqBEvkL4oatV0b18NrRnHAb/N/VtDHcp21Q0o45g2pHoQfS3pCP+Ac?=
 =?us-ascii?Q?p243rV5fO+8vXDuzHXt8NJ4BD2Tv+KFDklcmD8qYwn+yo0w2THj61ztCO1sy?=
 =?us-ascii?Q?ilyv8vML6ZvnuFuNBYhruF9zwSJhloT9uiubhW/1BGJ6SqJAGX+ofERDIgS+?=
 =?us-ascii?Q?gYu42JP589Yai0QmWJ5qKfHO1Dm6oSE03cnhxdsyiCO3G+evR431Fs9yGkKJ?=
 =?us-ascii?Q?luUNez46Zkred+Fe13zUoXCg2lNgftQbfeP24wGytiCzkYjJJz7yFJ0sdiDD?=
 =?us-ascii?Q?/PWZ+PtWbfvXqGJ96olPQ7ygJCOtLcxJJiW8VHv7jc0kopVw7K4NFpqMt0PS?=
 =?us-ascii?Q?sr1mn5lCVn7boPWzgoep5Ner+AUnnFEhltLHh8ZSi3nYFFQ/ph8uOeie4559?=
 =?us-ascii?Q?fNf3Z1ICr9o2p02g5oi5x5KNGd9LLHIJN/TfPFjV9IheOYb0WhNf6YHabHk2?=
 =?us-ascii?Q?je0LSd3LBZ5z+5DnhDiFtLwpZyq1jh1hTRstS96Abr6ji4bzJMeQ79DvV0Id?=
 =?us-ascii?Q?349kV/KPZNM4+Rubaz+sCEOqRbucK4jutRk3E0qYutReAWRicFomnNOlNbi0?=
 =?us-ascii?Q?6Ib6+qkHMdt1OwxItuhNlC4043yhewwdINLCJohvQKcaEWAGHCOgnyXKILDB?=
 =?us-ascii?Q?dwhqNPnbOghX17JFAONEf4sY6lcBnGgurK0Dhtz+Bzl8xXrGyyIcvHSEUfOg?=
 =?us-ascii?Q?OlYbtMZ+qAHyPjKyuw4/t4//b9UTgmUSSCYQojm+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5374b087-7d75-4f2b-eb4e-08dcc5c9b4e0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:22:09.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwzzV2SJcQyzuPRuh5dnAwVOkY5m+kmz3yrqJ8VwBjBgbx2Z77U10+tg6PjSHchb/abeVYeiUjEKzzOizqYv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6904

Use devm_clk_get_enabled() instead of clk functions in imx-dma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
v2:use dev_err_probe() instead of warn msg and return value.
---
 drivers/dma/imx-dma.c | 59 +++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ebf7c115d553..a6ad50734f2a 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1039,6 +1039,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	struct imxdma_engine *imxdma;
 	int ret, i;
 	int irq, irq_err;
+	struct clk *dma_ahb, *dma_ipg;
 
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
@@ -1055,20 +1056,13 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imxdma->dma_ipg))
-		return PTR_ERR(imxdma->dma_ipg);
+	dma_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(dma_ipg))
+		return PTR_ERR(dma_ipg);
 
-	imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(imxdma->dma_ahb))
-		return PTR_ERR(imxdma->dma_ahb);
-
-	ret = clk_prepare_enable(imxdma->dma_ipg);
-	if (ret)
-		return ret;
-	ret = clk_prepare_enable(imxdma->dma_ahb);
-	if (ret)
-		goto disable_dma_ipg_clk;
+	dma_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
+	if (IS_ERR(dma_ahb))
+		return PTR_ERR(dma_ahb);
 
 	/* reset DMA module */
 	imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
@@ -1076,24 +1070,22 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (is_imx1_dma(imxdma)) {
 		ret = devm_request_irq(&pdev->dev, irq,
 				       dma_irq_handler, 0, "DMA", imxdma);
-		if (ret) {
-			dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
-			goto disable_dma_ahb_clk;
-		}
+		if (ret)
+			return dev_err_probe(imxdma->dev, ret, "Can't register IRQ for DMA\n");
+
 		imxdma->irq = irq;
 
 		irq_err = platform_get_irq(pdev, 1);
 		if (irq_err < 0) {
 			ret = irq_err;
-			goto disable_dma_ahb_clk;
+			return ret;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq_err,
 				       imxdma_err_handler, 0, "DMA", imxdma);
-		if (ret) {
-			dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
-			goto disable_dma_ahb_clk;
-		}
+		if (ret)
+			return dev_err_probe(imxdma->dev, ret, "Can't register ERRIRQ for DMA\n");
+
 		imxdma->irq_err = irq_err;
 	}
 
@@ -1126,12 +1118,10 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		if (!is_imx1_dma(imxdma)) {
 			ret = devm_request_irq(&pdev->dev, irq + i,
 					dma_irq_handler, 0, "DMA", imxdma);
-			if (ret) {
-				dev_warn(imxdma->dev, "Can't register IRQ %d "
-					 "for DMA channel %d\n",
-					 irq + i, i);
-				goto disable_dma_ahb_clk;
-			}
+			if (ret)
+				return dev_err_probe(imxdma->dev, ret,
+					"Can't register IRQ %d for DMA channel %d\n",
+					irq + i, i);
 
 			imxdmac->irq = irq + i;
 			timer_setup(&imxdmac->watchdog, imxdma_watchdog, 0);
@@ -1172,10 +1162,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
 
 	ret = dma_async_device_register(&imxdma->dma_device);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
-		goto disable_dma_ahb_clk;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
 
 	if (pdev->dev.of_node) {
 		ret = of_dma_controller_register(pdev->dev.of_node,
@@ -1190,10 +1178,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 err_of_dma_controller:
 	dma_async_device_unregister(&imxdma->dma_device);
-disable_dma_ahb_clk:
-	clk_disable_unprepare(imxdma->dma_ahb);
-disable_dma_ipg_clk:
-	clk_disable_unprepare(imxdma->dma_ipg);
 	return ret;
 }
 
@@ -1226,9 +1210,6 @@ static void imxdma_remove(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
-
-	clk_disable_unprepare(imxdma->dma_ipg);
-	clk_disable_unprepare(imxdma->dma_ahb);
 }
 
 static struct platform_driver imxdma_driver = {
-- 
2.25.1



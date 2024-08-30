Return-Path: <dmaengine+bounces-3042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B358965D38
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F621F25C7D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84A17C7B1;
	Fri, 30 Aug 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bkksAvBE"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336B17BB1E;
	Fri, 30 Aug 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010907; cv=fail; b=o2o5wDG6G6gdo2AQkjr+VoUrDTpJOiETbNl9YrLj3kHZV6At5Dmxqi6Ewt99sT5hK2QfJfjgMW4HoI4PKUo9r3VtDuzJ6BPoNcnQiArzttC8rZW2ldTqN7zwedb4iDOzeqx6k5nHttR4v8XO3bguIsKHYWZ7D2TdYJFc4SK1YyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010907; c=relaxed/simple;
	bh=aUZ0Z3ianJXDx1xT9J25RFLohoDAnhiAthSlqVT654c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQ2RBM+iGUo4OT9jDFEt/nH83CgXgQ5QcpSylD4SqFXHotuNy3UqrgiSAQsvurx5E52LqZHFYsF9l9haIqM0BaloDas7OuHhCVJXOllIR6bpq/BZuzn6QzZmOsov5PHHk0omOVu6XP55YZ2Ws/EnSnyV8y7ujLhgXVmyt3PJQ3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bkksAvBE; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1IBMwc/nNWA2l8IkDk6tGQTwREqXajHWYT5SR/jEPTSu5Ka2mJl4WJsbmCjCKoID7RlL3gBP//YxIMmLvU/JI1XcyUjpYec3V7I/UKnQ768tU6Hzu0+QUbPUxWYu9VM9uLjOB2We+2ZilkhHPG/tTtYoxkdP4pRqepzoK3WydsLhth3WVw0hd/XnSZEBJHHuFa5jh1PxmMw0Z8QPpZxBKTuY5X4l/HfTYBRzqdmdBtopO0WPuNT53ha6T4gQZUsoXqqlnYohomcW2ZciWe1ll2cz2cQruXrp/h5/66Dm+7n030DdEhlWkw2kjpMFnjuEH68XRVL0It3PcOwfM2K7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4zfr71ATHpl8x4CGvq5JmbNUkA7OrAKFkK1TBg1Ys4=;
 b=hvexd5XoMV1thPhiRiiN4d0xDQcS404Vpa2D6JVlprojuIyI6wdQMvSh9UpHZl2zsTBsUAtpSWIwUoYYzf6w+hlyTnpNKfHt90MdVDvfRzlSxWVmGVC87XkFDBPQ9vxYpQH+l/f0SMXpVh1CujZAdlruBcYvgK1fk3uQphVIsUQ8D/h0zbqdELseWzXzHS9W73d11adUkynqLUpIYXotMEozhiDeTEtfMqG0b6kp7M8sTJ1qXOnZfy1VCe+dQJOHm9p02pQxNSuDisxDzeantkpeDk+Ybubo0csvczRj4CtT7dPUQZ1/d/VtpmyhmyUNmMIQj6Hb19o3IIfSBIWdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4zfr71ATHpl8x4CGvq5JmbNUkA7OrAKFkK1TBg1Ys4=;
 b=bkksAvBE9v6lv0pPxXdBNXAUnSuhFee5XpPqt8oGVff1dhuzSFmgcAk37dcZ4Tsw5qIaDAywX8PqWyHloD2oM4R2NHeSvgpzD25nIkjaDkyGFMQ3J5KLwx1D3m1RlsttJ9It7jzPWoFqwTF0UNVo+ijKJiSnQRcMTvHKupz2Fp/kFvO1oJ3D5bB46sg2kXWAOyq/laU22FimSrFYRU206xgjC7zgFpe35vlvwlvtZHEH/52lui17KnT2zm00imLYZTrVeW1r0HmMSr8djz4ZZJLWiVZ+/kmrAKbVvvadyB/8FxSWCg4E3ro4ZDLuO/t+OUBpTMQ/i1FJAip1r1LioA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:41:43 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:41:43 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2 5/7] dmaengine:imx-sdma:Use devm_clk_get_prepared() helpers
Date: Fri, 30 Aug 2024 17:41:16 +0800
Message-Id: <20240830094118.15458-6-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830094118.15458-1-liaoyuanhong@vivo.com>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a66b08-fc85-4cc5-bdbe-08dcc8d7f507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?75XUrXbdkZyXDHcYrfJcr4SMg4A1C++RGrMBFXEPEEnQyYBggp/F0/d22lmC?=
 =?us-ascii?Q?vTn5CkBdk85oJy7eA4mi51Th+XG2uN/0g/2Sv2irA0AO9jGQLIIX0a3eP4rV?=
 =?us-ascii?Q?de/QXvsjMSyNCyktcNwl/KBCwwgZm5BcEMU4jCBMZi/O1Qf4TYVZBQ2Mybtg?=
 =?us-ascii?Q?6bBGkvQXPj29b5NqsLr5oUBHRI4Ey8OVIjDVbjR6z+bbrNjjXovheAvOcC1j?=
 =?us-ascii?Q?FmyX1n0VCdvqAMExgYHXygcEzEjDeo1mF2JMAKV+NfMvDfXUPtn49QjsI8p3?=
 =?us-ascii?Q?zpPAqEVFLB8Dh2phmEEkSjn4LR9HeCxvbEE8mEk3gBXaFpAKNKoZ0YX+vC//?=
 =?us-ascii?Q?rXliLWEXej1KnZiofYcgptWE20s7dArR4UBLAY7PCVeolk6kfnzo3AJFNG7Y?=
 =?us-ascii?Q?e9hVKe+7fgyCWFJp96/TeymJf3sn7wY96nr/++N0DTNYKlO64JQh+nL/lODF?=
 =?us-ascii?Q?S5sUG+5UXkqT1Av6p/IoxOr7YckWFpOKOQ0mo1/NndGEJDskKA7HU0AtAXt+?=
 =?us-ascii?Q?c5ceWoIi5GQoT04GJSkF0zmb7146DG3r+PwQs4Oxd+ANy0/mwQ9IdKJnie01?=
 =?us-ascii?Q?+gDGrDZVuBPnMhC375170OBkrlsqCFcHSnPBuZcCVBM7jaBIUhmEpA+3EJET?=
 =?us-ascii?Q?e9ge0op0w7oy+iaoboVVIA8GI7qdM3vUBBVwI51TafqFx61r4pKgWcfZVDNe?=
 =?us-ascii?Q?0wpCIHRVH/bx/SdZ935RksyROe+Fvj8MD6T5w/NkUmampZakV4dO9UniXiMC?=
 =?us-ascii?Q?91Z0l8mIEQLPMJEFVgPbI5zyiKpE7axq6d6Ve05AC+pvtRAAfnpmcldQMrWa?=
 =?us-ascii?Q?MVodGy3GPA5qfxt4uBInYxHN/6prJPP5s7uAwbZL3U7g3fO+2KdaWr+j17uG?=
 =?us-ascii?Q?WJi+GnwzQNDxOqLizrt68guHw4WDS/66CfFupoOVWm+eypSufaDP88Yowolu?=
 =?us-ascii?Q?VSShKcSx3Dhihoh9inuAn6i2Xir+H/kLqnUsZIijNTYGL327y9fVMQ5lSYTu?=
 =?us-ascii?Q?Q6dsc2io/e9OuvccmsLYYTOaITjtH5UlN8l936cgH7CEgZjWIZJOUW4/rQ9F?=
 =?us-ascii?Q?pPNuTaWEcALvhjkba8aaSmSTHsDlOUMdoMIPha4nJXHAsTKZr159TgkaqAKp?=
 =?us-ascii?Q?5sjPL7AMkbGuTK5W+YH/6O8ZhHESor5tIoIxqCRUYQT5j0OsHY5+EuOsjpGH?=
 =?us-ascii?Q?qHIb1FamvFOwEEDmD8+7fN1nCoooysXE/6Ei19HN+dVM6sAUtXALKVT0oPPr?=
 =?us-ascii?Q?9xFI7xiati+nAvhbYNyPTAJ41ooRKYO48uccN2Smt4Z/Kldmu/YjbFOjPSVP?=
 =?us-ascii?Q?ICEz338frWENUUUd0uZ/Gyu9jmDltdUZOFN8tAcGM3AdfWWAl4RBNW2IMt0p?=
 =?us-ascii?Q?oa9Hs7NdEOMIc6bt7HdXXEF2ceW9z4QduPnudWqeABWKAb93wQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEuurZeAnjHSpPhqHqcYbPH467obSjE00RBATTXomRcAQxah57kkVLytYLTm?=
 =?us-ascii?Q?UjdS3XetE9UOrnmj0ZPIfKNdn7WIMo2E1dV20e4qw6cu9tNVkLKrM0MraQ0q?=
 =?us-ascii?Q?CZSUtildm8wybZvwUmCeWFlWMxJwDaBvzpLiH2axbaouEtLyu9M1+9q15wwE?=
 =?us-ascii?Q?fw/HOUPnqPqFeyiNo/LbsvRur9n1WOc1RrM73v2M9zh8HGlYoHTZm//eYWWd?=
 =?us-ascii?Q?O1tFHDEn10tDSk9SQce9QcPLi9bnNUls3pUcWLoZzpJiXLWpB3fZJC7wxIfw?=
 =?us-ascii?Q?Xay87y4lAJBGF9XMVMylFRA1BGLsFvmsF3yljeGlBBCDg5HLDFLRsBydL9jD?=
 =?us-ascii?Q?pI4tBmulOcygKVE5zUIgHrD6ELN2J+n6TpU8F8hd9dA0iBTGyLo4aQahuyJd?=
 =?us-ascii?Q?rXY+MKyKoySJsoDFhI3RfKYkVFXiYXCGzhx2GsU2mshH67P1kvrOo2OPoYaD?=
 =?us-ascii?Q?QSOl6ESN/24pn1Imfp1CPL/CFFebn5+aaaCy07SKWVd88DosA2ecIF1Ey1xS?=
 =?us-ascii?Q?nXVlY+OVD3fwEc+0WBwzvjxyNTAxAsx0q6sdrcyOgc2IuCIZ188uQnYiinGN?=
 =?us-ascii?Q?MpEmwWtXH94yU7XkjZw/xJhHJN1GV34TpL9H4LVw0l1c5U/hR77izE0GuyxD?=
 =?us-ascii?Q?v7MQTnYN1GtKOfhTmMkDjGavNeJQTWb2fYnfgMrE9xVVFXzna+fgdPivD15T?=
 =?us-ascii?Q?HxvSEaqKg79KIJ1rpRlP/ktwdUNbF/ivv4va9sIsql3ljjhy4jQc9K4Nh8mB?=
 =?us-ascii?Q?pLG2kdA5k6be9nCJOMhNL3bk9cBqYaCeRlPB0QhknFUeHfvUNfD+oYtwr3Aa?=
 =?us-ascii?Q?rxjZt6KUGzcrF8RJICakCgwqIxMwKDOylO+INCR1GkbROCJ94/OsntuP84eD?=
 =?us-ascii?Q?nAp0MUqmUmSMP624f1sJXbnPCKaFyoKtjV4fWrzqDqOFFK1gmOnmJgUJVJbk?=
 =?us-ascii?Q?BmuBXm+RwzLdCrUM2J/Zbws0dPPzNRiEkz1y6lEjlQYaBsfJdJUBAdqwmsXz?=
 =?us-ascii?Q?nlt7x+tfPvk6kraE5UxAVmBbyWRU6qPx/92wo1EyrbInb6vuNRx5oNECuZuU?=
 =?us-ascii?Q?m5lnnpUaj3yaeETaMxZ8YiQELBm3Lpv/ZbxokrYdw2TiYGrjUb3Dz6BTwrC6?=
 =?us-ascii?Q?cyGUoriIwFSvs2+grhOUrTbvFEL1LH7wkSbs+KP7TiTUWgTAfiiZqkS9EpNL?=
 =?us-ascii?Q?7s3j4jSku0f28xrKW/oKH0u0NrHQMaxOcjfqiuJGvACLn46tlUJ+LjCkvB12?=
 =?us-ascii?Q?If+jEMQ5SJUGGfineecaWrwNmriAOLUC6xCpFK177Zm9V9rTDhAxfqPL/zfz?=
 =?us-ascii?Q?KQ2JeWpV14Jwy2mvLJYnWa9bcypw39BBJETIQnCetvuYChIWvzL0rfNfhclS?=
 =?us-ascii?Q?CPRQyw5AhF3/EHsddPe5Oh/AAH1fQdvj3rtagFnR+VGWm9ZbxlEBo70O6AMa?=
 =?us-ascii?Q?gBquerdBG13pKb/UrWovOKJTPjTfPiDH0kOvO9dzUfzdB0H1jpxs07t6Ev6M?=
 =?us-ascii?Q?A/hYHSZma0ChkfW9AVOfX21br1QTVCW/B42WKnd6sZHKxc1PDURGe3orzdSH?=
 =?us-ascii?Q?elMYKIM+hktSuuajWoRblOYr/0mQbbBsh76p9G+d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a66b08-fc85-4cc5-bdbe-08dcc8d7f507
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:41:43.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr0XbRRIkgVE2iJ13fLu3BsjYv6I66AwweQhaVEtLWLVUL0EZm8R+Ir2omqgr7y9hlE8cwoM3EiJCkfIfCJVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5203

Use devm_clk_get_prepared() instead of clk functions in imx-sdma.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
v2:remove all enable related modifications, replace clk_prepare() with
devm_clk_get_prepared()
---
 drivers/dma/imx-sdma.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 72299a08af44..07a017c40a82 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2266,33 +2266,25 @@ static int sdma_probe(struct platform_device *pdev)
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
-	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	sdma->clk_ipg = devm_clk_get_prepared(&pdev->dev, "ipg");
 	if (IS_ERR(sdma->clk_ipg))
 		return PTR_ERR(sdma->clk_ipg);
 
-	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	sdma->clk_ahb = devm_clk_get_prepared(&pdev->dev, "ahb");
 	if (IS_ERR(sdma->clk_ahb))
 		return PTR_ERR(sdma->clk_ahb);
 
-	ret = clk_prepare(sdma->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare(sdma->clk_ahb);
-	if (ret)
-		goto err_clk;
-
 	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
 				dev_name(&pdev->dev), sdma);
 	if (ret)
-		goto err_irq;
+		return ret;
 
 	sdma->irq = irq;
 
 	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
 	if (!sdma->script_addrs) {
 		ret = -ENOMEM;
-		goto err_irq;
+		return ret;
 	}
 
 	/* initially no scripts available */
@@ -2407,10 +2399,6 @@ static int sdma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdma->dma_device);
 err_init:
 	kfree(sdma->script_addrs);
-err_irq:
-	clk_unprepare(sdma->clk_ahb);
-err_clk:
-	clk_unprepare(sdma->clk_ipg);
 	return ret;
 }
 
@@ -2422,8 +2410,6 @@ static void sdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, sdma->irq, sdma);
 	dma_async_device_unregister(&sdma->dma_device);
 	kfree(sdma->script_addrs);
-	clk_unprepare(sdma->clk_ahb);
-	clk_unprepare(sdma->clk_ipg);
 	/* Kill the tasklet */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
-- 
2.25.1



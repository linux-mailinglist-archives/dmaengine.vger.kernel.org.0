Return-Path: <dmaengine+bounces-12199-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E4CbArGsT2oxmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12199-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:14:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB140732100
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:14:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=He0v9Xw7;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12199-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12199-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E153830AC522
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0612438021;
	Thu,  9 Jul 2026 13:59:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA643800C;
	Thu,  9 Jul 2026 13:59:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605591; cv=fail; b=Ur3MjKkN1h1NPSnFurTAvrmSCoV4Yhmt4mZMN3bkaoJIqYaXRUeEmWCmz4loxQqHx5DLX3d9AB0KwiH9xDR29+v9vKJdzVRdxQbUyPhC0gDE1dhY7PD4DdNg0ym1IyD+/55BhHfjpTk92QOFXPrQRbRAwWq+o2DKHOfLZMBjyVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605591; c=relaxed/simple;
	bh=cPpa68445J/XMxW4BMpQJND9vD5VuIEDxonVHRckdio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+BDaMnCz06nlC5b67UP3fAvxrx2FU7/6gbVIwargG00u/b4mF+dxlAvkGgW7yJLVaXCWOQFEmbQmItP9yoSCTuuLzr/hQSJfiL2lXoIJSaOgWyvobKV+x3USPfAFlo5VkZWG2QfsT1kRX+HNZCk0Icy176fDnZG1pWHmBGkPQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=He0v9Xw7; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix2wUBwIS+UXa0ccJZNVGgeX/lYqA6Aa8VC9+OZCG0nVkLIu6wwA6Do1YxEmY91xUQNMfv/YyUSCj3Dx3ETSOwP+nt1yOflxOTVL4ol9RgZT8HCFay/RJjwLTRKaRkhqAkl+amyw8/IFFpxym8i7r3i04zLrNnMUtWkBsofS3IrJFufr6Noxr5btTrZiDg4ATjv5X17dwEgzt3tmxqY7u5xc25q5Y/CGY16MaHzz4T5xKf16iZWrRng/2kmSHOL4YK72BN0r/NPLqtL/2X2Ax9M/aU58SdsGFa9a+K9tT8al208tdltTV+YDfmK2qmmKCjJRSLwwWTx9wwFpd9e/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEv+eGpOr9G9Z1/z4b89EdAa3gHWDW9PHgDZOmGZMvk=;
 b=gBSB9SiP/Z80S7i1gaWbQT6uub7m/AcQBxK7MLOt5MFXY1r781Ie2cqQP2tRSrT/8QGjv+Ki9J/gHI6WdTvsY4z06+w7DnR1myoTyCimTWWzo061WBR1H5IN+F00PajMLtwuLpuMb7XgrQIoOTeo+VwZJLuhsv/Ibq/ypx5HotKdxGMEvr8kKmKQ+bQ6Pfe7Us8Htz+CcxEeaqlaQqYMrrNTp4l1xjAG31WbvN4EoRKN6+2TTLIdSUGDvjdDg2LmcCICsuA60s9YRXbiTdfTyvG8xsdCQFwl3/jO82o4z+7uuQIW9XBFEKc51aawHyp3HdmyjJ/Gny0as+gAOlUwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEv+eGpOr9G9Z1/z4b89EdAa3gHWDW9PHgDZOmGZMvk=;
 b=He0v9Xw7uprgzsdJRpg3qSis7wSKxS22wXSbgXDARmrMrpyQ5amQMkuI+1976YZ9m4vo+ym8n3Ub8CHttp1DGA7pom1xB74LJiJz9WcMFfvFdizBFIPCcSKL1hfBylnfQ01AzslLkKwX+Eb2AYW3MGpPmGAKLZUypp9meEW2AcmwhrDgFqRpbwoKE0vKd2jT4NoYCpV2mmRodogYYs7gk7u9gTnih4xtaZkaf+klrgSUyZRowkgvWB4rOuHWwQO9TspLHcjzlzS+DzUulspqvLx7QKJVP7TE56ginm7tPODZj0ymsa0mi9zn77tZNdLfWuB26fDj6t2CPeoZnLv7SA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:45 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:45 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 21/26] dmaengine: sun4i-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:25 +0800
Message-Id: <20260709135846.97972-22-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SE2PPF271E4F3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 76688458-0151-4b17-a639-08deddc254b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	u5KlUFnN3bNFuzFput8fIFNgpVUi6U9Q+VqKg3IxLz9Fq05WmoH8V48cWvc/22KWSYFLQ59eqbrRLnGHx1OJ54Gpc+EkIDYzkkX6qK7YINFe2S+YPHZg5UXuYGRxf8/2avTJ+zFhX29r8lV9qD7ejH4cqFFY6r+BHKFwBWyt/r06RnLfsQsNyd1B3gWFQfBeXoQ7XRJTQcPbxDHZpQ3IAgt0NP9MwoxoE19KOlG/6cLux0oyJ4FMX+ixU+a/J9jEoDEFYfq3Xvg3gNqZJAY1AxGv2U/06YviHU6pWo4I2v+EeL14coH7jBKqUghxeE+yrdPmYK1J/UgmlF4PJizk5Ry/lISfVTBhxu5tb06wRbG78PXr+MpMsH7VYLKyHw0JANfpr9iAadfOxAINxPxU3XcXr+oJqsVnHdV99F8v530ghTQSiHRFv760yH4RhhKGhxQjA0KtfZMI6SxIM/QUx4Gxj++elb8cQIa7UJuRNXWq9OVasJY/mhq7o5t2x+VMp8cDhXK/BNmp2QW0BaZE7Sks8Z1yh28Xx9ZTb5fuRkCNIdUdwNE7AkbhDv5ZK1FaCrUyHbhxQa52RsgTMrfqEL9njyMhOtpvw762avtERxTZmSj1Gi6/ED8zmAMZUBP6Q934OAh2fGKgKxSVeNJu2PHSY2muJo9e1hRjLKVVmYUjn7Mli996u6ThOiXEmHfaIJYDDKnZumCCoCg3IujWpix7yaXtsoi5n3h6uyuclmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFa/yuuRqM024gg4BeAsvp4l4wDCaTBSdR5ERaSh0JtYsr4LYopt4YUhO/yg?=
 =?us-ascii?Q?RfV5Y9Wqti++pDpu6lteIw4PzzbjGaON3KK+E/xLKm5X56NSv2npWmqowt0b?=
 =?us-ascii?Q?173FVsko5MEKm7NL13angHZVXr5J2N0uWAR3Q6mzVvaaT7ZNYsL5nOEvRR7V?=
 =?us-ascii?Q?qsrg+NNAwGAVi7eVjqgY7E9FQ1iwM7lUnm8s6/G4/3QDYxml4iCcaGnfBoNZ?=
 =?us-ascii?Q?QPDNAHLfW/XLeO7+qaSSzklSCnKcIEOkX/wLtHHeion4tvV1ubrKlumZn17z?=
 =?us-ascii?Q?yjwjdCjdDGy3ZbI8z0qTOAp8sSF+I5gLURAOmMEMx6usq3auqb6W40zh2ZR5?=
 =?us-ascii?Q?SDOWrHWDEyXGn8tCWgbAs5yqE1CMBKYvpjx7y4brZ5o5JK9PvFPZ8s65/WkU?=
 =?us-ascii?Q?0ERyO5IW5ODtIWp3SqN+0U3LWklAThH0rKcFgJtUHt6Pi9F8r2dQCP6erXW+?=
 =?us-ascii?Q?rojyTrnIq+5gLtmGQBnPl7FIdFCPQhbUYlnES3oQQBhdNMPdpvHqYfLF6orc?=
 =?us-ascii?Q?Zhzt3nWiwrETHTczZzHL9ochrL0lYU0zXvy0tCLQZgryuwtTibr2bxgyuzLy?=
 =?us-ascii?Q?Gq9Ch7GeF1B1lBHMXLqhDGSphFoB5AIEcFLFGIeA5jkBYO3A20Dqyb3zUUC2?=
 =?us-ascii?Q?Pr0L5pA2cGvUo13trC/k05SUp5py5szwzALbGI2vbp0CRoFZ3nQKbC8MUhiu?=
 =?us-ascii?Q?g5D7V+mbEAeix8Ws2QyLMmECG/fPEj+9hVtnTr8e8xuTguwPqfQFPQZAA/g5?=
 =?us-ascii?Q?l+00++T+g5GsbYHGpvEyXIrcgE6zM5xRnMUhtyGfdX4gntauQ3hx0m44z4Fg?=
 =?us-ascii?Q?bWVgTZJteKAxD2YEWDbJ/oqwMMZif7PDgWrq5vwVf2VoZ1GDYQ4Wqm4X9Cxu?=
 =?us-ascii?Q?BCQQdsyQNizAGhikgkYOfEZZhvHo522zq1g07Dl8loinOBYWNeGSWt2uT//G?=
 =?us-ascii?Q?a4v/7MslHW/7wg9z2xX526YYxJ59svmR5Bqcp5O5MdXLXKu0FAGX6gM6wd+N?=
 =?us-ascii?Q?uJliOXPk5o0xoVQsesR7RyXCZPTPMgpXUK5+WY23TQHgVk7vCI0wJLHdUWcd?=
 =?us-ascii?Q?qiYJBO9i1OuRU0xa27HAa/Gc0AHryducN0GfoG+dV4AzQ51nWNTZ1sxnLiqK?=
 =?us-ascii?Q?aMTXlZnugKKxqJeCUeD/8YPbo9nZ54Cwgo3h1lTq4Fb2SbrNZ/aDFJDmtUrf?=
 =?us-ascii?Q?4V3L0cOLMSY+oA07RqzdBHG6m/YdwoE9epnRcY0J3F6QLdSx2tiOmq6BrWz/?=
 =?us-ascii?Q?i5/nEkV8MgChoqzgDQoJ71yPFWOBiRimFsZDNK78SnUIBK8xWEREJqeA5JKP?=
 =?us-ascii?Q?guDbwjvmvDsTGzTkqPCjJT8vd7rZeyDJFMoIR0Y6HE3MuqcmqIhRkgmg+pvJ?=
 =?us-ascii?Q?d/9bZat2iodBQT4TqJeqGmcysHcHwjVKp6J1oLf+ftVIU00yQYXQlpp4cDSy?=
 =?us-ascii?Q?OIY001+9yqx5xU+sJqm01thGgl9LBfJHSvwmlHwhyFtID8D959qUEfWRHV9e?=
 =?us-ascii?Q?XOrKNWb/+Ib0hhVuoan1BFx4zx4+fgv434vXboF8xKVBD++r/vk0M59RX1zn?=
 =?us-ascii?Q?U64xAsnxCBrvIW8FgkXyaL5iQICJ3Un/I4p7FjDfFwiLBtdMYK3bL8ijOafL?=
 =?us-ascii?Q?Qj4bGCYJzHG86HL6Blwi4XFD9FuZkS3ndz9bIFavnBjOC4oZQmBLijPgNfQ+?=
 =?us-ascii?Q?2OdZGI4aGtmxbpIYyWjoPhaObMXGvvTzoEDnim0Esa5JjyIObutipbMiaL/q?=
 =?us-ascii?Q?4hcVXbkPsA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76688458-0151-4b17-a639-08deddc254b8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:44.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/o2SGs8m2SZu2EKmoFRy4Ox4kQH4eYQiq73meVyaW8bNu8SyI71fUwszQHlYXSC8vpwSMou+gVn7+HspA4ugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12199-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB140732100

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sun4i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index d2321f7287d2..303d71ba0ab6 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1337,7 +1337,7 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
 			       0, dev_name(&pdev->dev), priv);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Cannot request IRQ\n");
+		return ret;
 
 	ret = dmaenginem_async_device_register(&priv->slave);
 	if (ret)
-- 
2.34.1



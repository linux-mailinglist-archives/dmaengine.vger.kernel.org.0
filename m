Return-Path: <dmaengine+bounces-12188-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GKcKCb+tT2qGmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12188-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:18:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695F7321DA
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=nYCXYfoL;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12188-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12188-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC42F31E7143
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F842EEC7;
	Thu,  9 Jul 2026 13:59:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0542DA2D;
	Thu,  9 Jul 2026 13:59:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605564; cv=fail; b=Xa33Tc+8to238Gg4VOoHGXcoVHa10iS72QkwtqJYENcI4y65OJ1HU3szWHLRD7jatgObLEFwIgX4OXR19yBl08wmRxdZPYlf5omu4DyClWrP5LP+goC9ngJDp4eiQeAfPLc63nIdgLQ9RsSfI+b52NYD71vvZ6VYJfbpsOJG5rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605564; c=relaxed/simple;
	bh=TEo5lZwrXEOPJeM7avcDVPaNg0fK5iFUmQMDfivy2no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3D3hMZUNfeZSwznCgcW+e0XSuhkTILbM/RX7Qnuh4l5YnbHEruYVcvhazO08P0Cvns5zSz10FHaS3P081mSdH/WHB59MoQTuuaivGYch+BJgvkGmawj0OUC8evbnVf5jGzcpBCgyDfuoQymiW3OpZ3YgQNkYxolBgPvd9Ua5Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nYCXYfoL; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMqpa3f+Ib85RXCCvvNVvprsN8NaPf7k5ANf6Op0jSVCz32fvFEThy/McHNqGmvD7vqPNXyNzqT1K5voGql0RTcQz8Xf6zA7mudYWr8fU1zWl05+jio+kjP5n0hlJCfxpV4ShgFstOkBEvdfcBLfWV/Ph2+PS/6Z0FEun1o4FxnVAtlsnoq1gvqj+BRwlo2miPvZCnRDYuPQlSg8Qi8f6W+9picgkrXM96qz2JJxR5tVfZYHA7ktKr+cb7crx4E2WC9ouApxSp7Jaiwbh+u83vDgrF74B2c+Nkdawj/z+MyZ5ShZkSagEvPKdvW0aJrsQuxPuSSJZ9tce8OLYjNHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LT/QluWSGQnUo2rz8/huOeuXkMX7Osav/MM+7geZ6E=;
 b=LYbv6ysaGAz3FrNQrL07Bxeiw7Iye+2Pg7yR+Yt2XoyKc1HYdl3xe325RLD80lg34tA1lR6ZOnlE7hTo2W2kbuIEldonlYRCfJMpAFUdiNu0QGfP58a5sbo6zYUPFPCzEhG4qTPZfz/MSttjhy17MRQ8F1ZVSC1qbcu5nNS04p512NqwhH0Rh1P8vNYNwZFxW4f2bkhT2UVb/ZhwgnkVWLFaItdK8CPuIcgqxYWmzb7ISem076/ipJ+33+ZGNFgRk3/26MtpQZcRoM4Bgc1yuCPvMwLpnyBNruQ1kk0x1Rln+Ud5dMwqM0AdvqGBeV3DswfH2Wb8Rn/66wJJgy22Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LT/QluWSGQnUo2rz8/huOeuXkMX7Osav/MM+7geZ6E=;
 b=nYCXYfoLh1RHBpUZICXVjjWhvNxIoZyTOhP5k5eK+yd4UQ81JJIEGK/JHTYZkLwWsonaUSyoFc5xbDQi8R3rAMMvG05DW6k4eZLWNuBPEGMOns1JIRChEpXt2LqG8AC3HiK+px6xCqGfGcY6pv3LNyR5a9d3O1wk7VtyArj+kj1SA2wOMrlpRiiZJXMreV4F+aBxsZpv2K2myh9/4d3FmUeeYM+i9ZIt0YcssT/nav1tXLjhMScZCc+DXIgCdQcbPpCyKGlBrS3QUjelU783pMaTS3iK2Pc5Li5ehqlekj+En/NpR8zujmWu8Wc/YNqQnW4y/sMFfOsVPK4Z//hQLw==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:13 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:13 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 08/26] dmaengine: owl-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:12 +0800
Message-Id: <20260709135846.97972-9-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 175829e4-ae10-46bb-5e64-08deddc241ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	G+Jf9Sxsq2zfesy7AHy2UYQ3U5EDDG3euIMbe6micphBHr92KLPeMo5pkQl09aRzzysefqz+cm3I08pUO9ivz9hnHW6G49JvH3+FWzF6PGqh3FYzhxCxuV37wWT3DHd+z8nMpmEnvbjDW47oxWgmFm7aK+0vS+4iAw98KhYVzf5hQAtlytM5nEXiGXUADkMtES5CAyvR8QWvybdbz31ig8pDh4mEXh7mS6bK9zp2Z/x+MsOG1ESzNbO4jZFvoyNF5WWq0dQgQLjyGnxCdFQhQt+P8Ahz7AE1WoxK566i1IHegwdFKTHEDdEH5X3nK/qPNu1l8+zmetIXbk1yXZuwTTDBzmueWN2pQHmv6ZfiHqtCv1Exs4mR6IVOVQ2+uIQz6h+WuBVZDcUCKHmQBrcm5Fp4CbRN6kIAhpDTqVdb8MZpwb+CIN8LB3a7BHrVxpWRWH4e7v+leB1rNm2E3vNIgiWGo+hrLwUD6KUhbztBxFqy80ZiFxWrLWqGj6iSd8SoN+zL3HfJICcVKms3ciC4/M85LGyYFci8XA4wY/yPnwiGUveHTGG+hIt1bUYzHHXxLTP2dVfTWBTanX6LKEsQ5YKVvEFqnTidOfb/ftKvGbCC/usxGwqzv84o7PyrtT0TX8W+kn2Jg/DVYwVbsCpHOkbm3iTRQw/nwoWtCmdiey5KJfdcMqxQBEhzah/cBXOwBeIMBmZ2LoszVGqRPQBxRbOMbjiZB/zvqLUbIV8CfW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohO6DTqzkrms3K6LZt9FBsWYpVaWriQxQH8eP+pNUcFRqBB8picB6zJmAduc?=
 =?us-ascii?Q?KWp1VmCNS9GeHC/HkgUrgnEtYXWCg9228QPiZSGl5nzbQv67nNIASCjsYkP9?=
 =?us-ascii?Q?hrdxbkwCUy+o6Yeh3yrsCucmNUPvUXiK9Fvjh80g7dJngckbuy9HMBhYOLiX?=
 =?us-ascii?Q?o11BLRKfYjisS7d4Dl8WaVSHh1v7xJOeda9hROQgzJUE/ggl+fZQs4BD8Ep9?=
 =?us-ascii?Q?gaJTRAwzz/+tPg2ZwK1VStr6Khy32DKvqfPgUwBinlR4QgSsmbdyXFG7mDrH?=
 =?us-ascii?Q?YXuQP6BuRgz37dq7DdFJ9GxMbD/6MnXmhJRIHb3sxTZEGTzl+lcEy3Wey528?=
 =?us-ascii?Q?qzHFX5flfRqlGx7kwCQCDgY9qSq3jGnhM6hDpDYKpXutDRrlqWN2Inj96pAj?=
 =?us-ascii?Q?VUj3fLCgo5jetlPY5QpiSGBXsnGbdNMdb1jDmW9FMpzZynjK04GgY7KGm9WT?=
 =?us-ascii?Q?6g3UIsTOiOWb7akWdAjdxisSkSfOlAVBVAnB+vLvRElGyqJs9ok20MFzQIU7?=
 =?us-ascii?Q?ouxwmX96CRm0yatb5s7OiBEoFhliXWRiylC1lIwkvgTkJ0fwdu/N/a3/5cNd?=
 =?us-ascii?Q?FFbUhvofdAFPThTYr9In8FNlhfZph4tUh40JHQSv9VrfGRV7IF274dCsBjTK?=
 =?us-ascii?Q?WhoNaafC5/a9DO0nMSbV5N48ixmKN5QatNUurHU6LCgyFVic51Y9TOtd59ZY?=
 =?us-ascii?Q?c10hewsUb9MTCkpbWwRy4shkJ/9RoYxBl8MNjZGs8ZyR4mbiufE0Pn9jwtnP?=
 =?us-ascii?Q?KXzmRy982oyQOrvQyRgc6xf0jff0wKzuz+kZmVvF5hd7T8HusPAWc6A3XoM+?=
 =?us-ascii?Q?z5oD3uTzsUaP1+gKSJHMB8w21yr/ngO4L1FY0BH/w6O5i1EN4dUGo15THRGS?=
 =?us-ascii?Q?mEum9XJua8sG1p9+HwLLE8h2ArxqQ7scJxkbbLEf8l3p/VWqjyNWd3XVylXM?=
 =?us-ascii?Q?iagvavml4HpLVAIijI76vqAK1VqEUO2gDakQIvy6CTR9ajAheH1v+TNcdXf8?=
 =?us-ascii?Q?wNnNUBagSp6QAFa+U2sPeLdGmVe6RWlLHDO5CasjfSGkjBZhEUsrsQgGu/Xm?=
 =?us-ascii?Q?TeSRc6dfVXkKXeggFXkJ5cnyl7Ve9QLAvZcXyEmAPwhBZVdcCSEo4orvSaAv?=
 =?us-ascii?Q?ZE2rU9wyiwnCxkELeUc3zXqabvqX52uJP9WirCeI0ATo9uLpwFC+sj3YMRkc?=
 =?us-ascii?Q?FHNEk0k1gEi6TZTgKn9GZSfTp6elimoQ4KoBPPOZpg2KE3NGJhm6PMBYv1n1?=
 =?us-ascii?Q?kcd8JdRXpipEoJq5QjomOTcjygrRuIkMdP9IWsddXzNNbtyWQSxTT8iYUw+s?=
 =?us-ascii?Q?4fmzkDFISU8X72DVc0OUW1vmcVH4EuzLONDgtGuRshrVYPDwHYzsK2Aw1CUE?=
 =?us-ascii?Q?z8aAbnqevI4o0MJHKbbqhN5SBz18rtHXGML3MZxSijix9DZEyh+CZ24TrpLD?=
 =?us-ascii?Q?Dek9ZqInm0I0AbTPQf/AvESfd6+rjf5U4/LkdWZpR252Tisxkomx+zQJ40+W?=
 =?us-ascii?Q?rW3upJy1nOpTGjnW1kBuEquq+2VslgXUAymya/kX6exO61ZfTDuNDTGZvpe7?=
 =?us-ascii?Q?KbQAHSsDET+XevA8RaFi7Hae2xAHXNj5Z7L+31c4qFmChM9OGShjWzKwRubQ?=
 =?us-ascii?Q?W6P+G4ZMOJy0zBTBOmU01AohzQcNZVa/XXPxbQC1WDNg6/Q8Pa6UOy+oSTPc?=
 =?us-ascii?Q?2Ke811C3bEWxTJrK4fJbddSvwcQZpGW3aFYbiAPExxqFMqOlAmcKYqEzncOI?=
 =?us-ascii?Q?rQmynHTeAw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175829e4-ae10-46bb-5e64-08deddc241ce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:13.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG6AAEwxhQWWsildcJnhGpiLaUdikgMvIJ4mLTkNp2r4DNbkCkrZGtuGC0ApNPT187cS4DphftxwLlYG8rBZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12188-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:afaerber@suse.de,m:mani@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-actions@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1695F7321DA

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/owl-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 7c80572fc71d..71d0b15968c6 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1163,10 +1163,8 @@ static int owl_dma_probe(struct platform_device *pdev)
 	od->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, od->irq, owl_dma_interrupt, 0,
 			       dev_name(&pdev->dev), od);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to request IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	/* Init physical channel */
 	od->pchans = devm_kcalloc(&pdev->dev, od->nr_pchans,
-- 
2.34.1



Return-Path: <dmaengine+bounces-12186-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDDjBXutT2p1mgIAu9opvQ
	(envelope-from <dmaengine+bounces-12186-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:17:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABF7321A2
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=RJTkUgpv;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12186-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12186-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDCB7308126B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6642DA21;
	Thu,  9 Jul 2026 13:59:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCB42B332;
	Thu,  9 Jul 2026 13:59:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605562; cv=fail; b=IVQTaeQc3MOxRVqYKpWQh2OVh3ecDy0NPOP+K2xCd+gPdGixrwYyfr3u8eq/FxXJfcgk+kvAv2LV6iKPso+6u1nJ1Mw/D/tc9okM92V9VfWBwpE46LMGdX8jzln6i8WfbOEVl/C2LrSN7ZXEVM001DbhS8905taLj27ywAj9h08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605562; c=relaxed/simple;
	bh=Jzn2of9oS/kNUUv07R7IfnU2vUkZLH2C06XMSlWOVyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LMxbI05TJX2Vyje58M28LEdS7VPnoX2vmPP9s4Ea5ImPyZ7P9G2Q/NbhF4CxRhN0z58bxn/d4zCoA3bOtRMaMWI/JRpFeQ0dLZ3jYnBy6vvW2LyUvI0WC5RLRZFCFdyY3wMvaYdZsiklyDyPugTqJDpkFnH9QFkmHi/lIXAjneE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RJTkUgpv; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2PF3Ts6rHPzu+vVTtNg7uDJ+wxaK2XKqK9nfRB2c2izygJHDMdOfWH7WU85zBY1JbaOj5wlG0hZZnwVYhMJPOfmF82ZXZld8omkvCv2mE3k1x1qAIL+C1co1sVvXB/4HHfVHkRdVBlBpdKo23X3jDEeE9EZ5Zst8RnecYU3kqzPQcb6wwgMGB8qZ8Z0rqNsj62b8LmqDSMZFfZ4mXjo/3pwAX+jUXlRbzygD/B436FMyxGdyXqWl5JuK8oSXvVsgW3VZd6zKcJEnmnEue/Vn4MgIUpwZoJVHW64D7Eq4AqHM6jALybitDhTSHIizL1k71wwcLrEFv6mBNMYWKqffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr760TDhJhno5UNtQ71dCYBwpHGYqq1BTaPx1piC7vw=;
 b=DKn7zTHJI3BEQ6jbyZzqG65YPaNhS++QU+JRL8aZK23D55WVRAKTXSDoGHUv9L5fdbkk4AK+4wR+HJDrt5pZGefCYgk1uAfwntPjoOaZa/7h1qAHpDpZccGXmTEZR9o+xFsNrcdrfOkRsQiF6IjMXNmzU2ByGxiDoywlV3KyC+9bHjhNAk1j8bVvyGOYzgDBJzvgQ32dWs/TFyGsf1unJ72EqOpLm8qjzShrDtY5JzaOhdVO1aQegE10+qYGVPZerP3ht8op4859gHg1zxXL4VZeXGpfjbY7/E7v90jrmI4twY19iHjG+4HPemLauA13uto1UuTs8H2F7VYoDdpsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr760TDhJhno5UNtQ71dCYBwpHGYqq1BTaPx1piC7vw=;
 b=RJTkUgpvHVrayHfCnCMhqLDa9enamflWDqoKwphaZ5aFOLegMGOnAkXUQaSXNrIj2iSA3UJ49BAD6/DtPUIyXDlOdd7yI6ob81g83vVpUqyUHwpW/qrjW1L+5aF8ZlW1rDvVRaJmrjEAJZG833rCz47SvWNFIbiCY/sDUQRWO2rW5D689qg6O7HuAYjkpWWilC3X4xK/FHRkwun1Gm+WL9jiYmjVjrwgcwaFLBUYFEF+IADo7A+zRGwUX1tAol7KnqxmkmklvlGOlWQKgYIMIeh4umRv1iM+Xj5dKoom3+LasJw2ki4DNlw9sM7E+HGPpz9U+cIG15zA0k6hgHOkbQ==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:11 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:11 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 07/26] dmaengine: moxart-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:11 +0800
Message-Id: <20260709135846.97972-8-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: efaaa406-183c-46b7-a81d-08deddc240fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	CNphOeVAm28JbQMAh98XGUFd4+WFb6ZOA2JLpAvHF611PVtpghupe+sQRMK1OUEiEFYzLSDz+OINVg1AFVM66TwaUpb/9n+v0B3TF2Pzclzma2Mv25sTWOviiwHzerdV9JbXButjhssYHQSjpzbe2xZfiC6OPOEr4BXzQgTbtIaisM3hRagCzWH87ly1J4zwiex37ZU6jhKjgSPprTAiUqSx7Zk8DX443hF1wYYcyovuWc4o9pLkz2C2P0tUc6qYAIcOA2CeNRBUX0tAhYRQPD8kFxr+j8z6l7qGILhy+IEM7QgBGuiXGN8rFlF0Afyl/NHHbFXVKL6QZ2gVVflgXTcEommwaaHbDfOG+HIhJ7o7oj2nhjootvV4C9NvZbTGDksfMzctzaDmEPANVA4Djv4YeUR9nvj1p9vUiZcp++wodewwQU52WbAgNvWVEP4+sChbVmtalHXw+mXfBu+fbKGqg1rWDAuH3vbwSKStF9gPC7bRBiWVi9EtBp8GsRjjwB7RfT6eCZ2xDANTM13aGvFri5FWDcR3Fel/VvCgio8TQjX6io+e8Dy8yNzd2PwDySk7CJYc92/EpXzMO1RpRKYqljnoBvyCVONuBHRKcv9Fv/pWwqZ1qicUoupOuRiosPprFb+GfC4d6ODDcn1mdF+Z7xnBFwqoZ35hv43zUxHWRWRK8J+WcAIexUdSoOXHj0bzutf64xOnBW88TeY9V8/G/7eeWfvgNeQmgum9iio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gEqocjEAgMp9n7FMkb3oJKvKdN5Km94De6PWURDs5l5Av9b6B190HL5Qq15I?=
 =?us-ascii?Q?9IQb1eW0ULd7F3z/urMw8OofA//CAM3Zw6rO7YKzJM/t9XsMSooUWpuwIy8F?=
 =?us-ascii?Q?4tx5psl5r75xV8N4t9WwDm1xg6qgaHZQJhHHyazmNn4VFmhetjONHWXhIbQ3?=
 =?us-ascii?Q?/M16z9whEe4FW4Q7wEy8EB88ISvz4t7VjyPWRDTL6Zu3FRFRf3JyvakggJaQ?=
 =?us-ascii?Q?LEjUQVIt55moQjyy7Uktlf1bkj91oceBiCN3C4pdKnnSISqwap4Q5jkPtJ8x?=
 =?us-ascii?Q?gJNPViVqmuJ4JsD8xXEzckVQ3iG6YV+asyjJ8PodW8vb+t5PWuzkUfkeTDlz?=
 =?us-ascii?Q?1v+2o0+tciAE23KVNBYEQL6RlYHypatbNqlL1kbygBiLFwbuxkAB8ZweBjGt?=
 =?us-ascii?Q?eD5qNJumJ/NmsJSYyaQHlxkxLNwOWAi+qFSCgigbqyPcQQ1RymX5B0dudF/X?=
 =?us-ascii?Q?/Ju2p0a4zpe+zYVi57fcMjklM4NW4iRlYaJVLUGCKIkv1j9yfxK9uD0f1860?=
 =?us-ascii?Q?5S4ABd5kZf8G1hSN6Upx2o9zwjCEKkEu0yVl5QgSkclSC+O8d1Rwqe/cX4qx?=
 =?us-ascii?Q?1QHbMrzrC6GXfunALVv7LtAELbwb+leEyRJuNHrObiwtyMfOLJkztu/4Hnpm?=
 =?us-ascii?Q?cRzoYOkWsrPUstMX0GgvvNE6yA+YTNsYAIOpIw+0+tCJosS6FoHkY2NOCw9x?=
 =?us-ascii?Q?RDmF8YfMTg+VCJTqLth1c5bc8UF6eW5Q9DGOYPCUqM/iL3yLTHq081p0umhu?=
 =?us-ascii?Q?cvcP2Z+fLgd9cuVqRD6BQk+rIk45g8Z9ZK6wo0mNUE5g2a/W8JgDacbrNcMV?=
 =?us-ascii?Q?+mf2nTi59VZKptpodw+YlZPHEwch/stv9dcSfphkdWtM0wcYnoI5Js++C/97?=
 =?us-ascii?Q?yF7+jf/PYlFyfoz2L6Ba9D762SAjT7RrNOaiqiWE5wXbif/Dxm0mvmzeiHTp?=
 =?us-ascii?Q?Xx7BvcRgsrqSESvWwBuFj2+/SJmWQ/6jjIhqnOBcXd5YFREAwAzYIqyb6Ncz?=
 =?us-ascii?Q?oLFkqB4qTW0Ob5FrX2OGITDjJ8pBznMiUaR3X39LWZzeRhWwLBDOA804sydG?=
 =?us-ascii?Q?lVOFH0A7PSEj5yOPkTKu4EUfKNIvzpK8jzP9f7kZqsDvUDFckjxqhtjiFHDB?=
 =?us-ascii?Q?7XJFKHQScBTwi47W33jtstOIQ6ONbCMvbqOMHHvq7sJFVpDwmq5+bAxgj44W?=
 =?us-ascii?Q?FbPIkVYIIQlbphuFjMOuUeKc0r6da0gwmLuM57WfSPEYxD6/5EN0C5OmidI7?=
 =?us-ascii?Q?dJwLI06HuVfBVSDnyjJWB2eZUUBbGaZa2sNbYow1090LvVY27S3pf7rSrs+m?=
 =?us-ascii?Q?k3E9mXLit+Vox4ptFeFMisyAqUaohMKsgJz9wU1OQxbH6bZTnA1PDLoDHO5q?=
 =?us-ascii?Q?Uv5Q8XWFPgCK39mZY67CMMZO4Lqm+/v7aqkCIAN+Kp3aLt/gdAeLUj64A3t+?=
 =?us-ascii?Q?+kyBAuGI2pAyOd6xGL/Uv985lMnlYC2JBMHyNSH3MB1IK9SJibYaGj2XMWPm?=
 =?us-ascii?Q?7NvU/6WQh8y14ouAKz1C79+cjqhR7Jmv6Guk9p6uGvLNx/xl8uWzaUgNJh0Y?=
 =?us-ascii?Q?AvdNbuJRJ3+R5vg1xvIKcdejJv4NwI96bhpUWc9oMQ/Jk3uBI1P2jum7tGZd?=
 =?us-ascii?Q?Sgq9MadGOGzAjP57lK4f4IxcDgO02jlRx2dIu0oQ4cVAtCHhY9Pg07VhPd/u?=
 =?us-ascii?Q?mGZdLPt7lceuS298G3YixiKAYU/ECMf+QfZQssC2YKFyeVB0E1iGTyyrnU2F?=
 =?us-ascii?Q?YzdPT+bQaw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaaa406-183c-46b7-a81d-08deddc240fc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:11.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DeGAH0gK7bK9oO0XZeEVibLa+eDM9qK2yO2gi/X1IUAnyXLehbPKRjEM69GB7lu+O/synl6Mmdb3rbXfg6lXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12186-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EABF7321A2

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/moxart-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 442f5aa16031..16a14a5179c1 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -600,10 +600,8 @@ static int moxart_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, moxart_dma_interrupt, 0,
 			       "moxart-dma-engine", mdc);
-	if (ret) {
-		dev_err(dev, "devm_request_irq failed\n");
+	if (ret)
 		return ret;
-	}
 	mdc->irq = irq;
 
 	ret = dma_async_device_register(&mdc->dma_slave);
-- 
2.34.1



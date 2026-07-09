Return-Path: <dmaengine+bounces-12194-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FLfBK1WvT2r0mgIAu9opvQ
	(envelope-from <dmaengine+bounces-12194-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715C73233A
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=TQCrAHJR;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12194-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12194-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69BB230797BC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84373435ECF;
	Thu,  9 Jul 2026 13:59:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF1435EC7;
	Thu,  9 Jul 2026 13:59:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605581; cv=fail; b=ai1DdgSuj5Dojzwg+m7/VRVX9w/7mZNbCijM++GghRGjgqJx3buOCK1ZAHe1UgxZCKOInA57yUibKgcYcR6A1EUAX1f4mHVc7cdoEMyOls34ITudXIj2jmRE2/Y3d594Wum1LS6y7IMOCZr+NwufotgglyIFOveoUfYfGazzZpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605581; c=relaxed/simple;
	bh=bpZp6IM48iW3G3MELj6ro/pJ9KcUQ7l3fGvE+F/aSWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gv8nbSrutotNSE+4kpycO/7xWqxlMfkUDOimiYTEP2TmGeSUpd5geg/cGuqhhJr1+iGL+SVjLEJi+tljR4g7BuDtqVh3UN/wWFQzcQWJ+e5O8M9HS8L/Ppw1XICl7INw7X6ZuoVA/A7NNkNmuXTw977sDK1/o2RfjriTubgvn9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TQCrAHJR; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waBdf2aKskUPcxwILcTKP7MsueBPmuw6io9bSRFh2kaxlkMtMZKJ0bYpgFYQ/cD2Z4wAwx1N1XGTN/DJsICn7dMRof5/3e31DywmGx1wnumVbqBjI4sWjLTRt6LTcZf8p4zplSmJX17Dpl3jaaAHBOsukZPglmYR+zRAMnfdb4P0d+PI4q+Su1U2N+mlfyBbot8htKDT0Jw+yRvWCWAevx/9hTa35pv6Cr+w3DPXCmxfAChblA5Ay0l1o3K8JXrGGjVsWyWLSC95l/FHaDkn4Gmgu45iIEtiyg24aH8aC3SI3NCbW6vYqUloinWdKxqXm+Tz9tWDAoYdWeUdQolg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nq3ka+n34XjU3BquP2hJ3xn++OpumyRwO8Rp8UYJCk=;
 b=RrgOwY6VAx9KTAhiqvWzI4iQY6ZJh5AV8Dsiq6j1ayhieb3slujpUgsUXU0fe5+t1S6v7tXaLs31ZeQuerR5vbeRG0LCGiRz42ZrZxTsLSNr1z6Jp2vBy7AOUK73rs5Yu4fBZbxASPWxiIKLflO/sXaQpW2xJGpbqP8jmaksZzRHEtRx0pXxewg3qAYAV8Nvscw9F5jcjH1BCbrWeT4TK7JNf758l30KV2l+ok4ikJaCoAoio3p3Ss/mbnwo0baNTZZO2tnh8o9ZbqSx21opDOx68YQ4Iinp5OlZKZQUNax7KRsMVvB0U9Iw4Dwivt0Hpkt2xpWUv4K7dJ8e6IwoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nq3ka+n34XjU3BquP2hJ3xn++OpumyRwO8Rp8UYJCk=;
 b=TQCrAHJRmBoA7CShR6ZR7AUnZxBa5R1QRMy9NtOXksDe6ooB5fjGgJQlyltOuL9tIWLyERQc2sI7si6b+y1plPC/4i6P74ap72fsHp6Wn2ThKYmNzM2hn74yKCHQXxmYaufZrDKrJSKpmsD2iCsLLcF/IHL20VbL7JcPb0UpHztbBaDSfShGIg0H4ZYIIx37PAaKY5Q6QbZHzw9Vw/jZ7JvrfPM9RYiaR6R+zNXgtPstJjrWtVr9UP7DhjRLLqfimOb6tI1okYVysMAAj4OV4RZi8yb3QE6iwsmztHZKWXE4EVIQ2g+7sZ1FmloNnINv5nCYmLZB4q0iFLPtqQ0O3g==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:37 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:37 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 16/26] dmaengine: sprd-dma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:20 +0800
Message-Id: <20260709135846.97972-17-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 300f0333-3d7f-420a-60de-08deddc25053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sN5REAZbK6SR7tVob5sFAKPmLSgb1hT/P4l5eSrYUz8UZII2xYBapq5fyWowEapmHqM4GUr7F7LypFtDe4Z5U7q8xKCDnoKDM3Yo8tu9+fuQZ4lYr9wU465OcRft+2lfdc8Q7MViAjvhGztC4t8AA+5sgkSi+FMV33apDtW1QG1KtoWKzG63cOwLmGHa/zCri83Lu4lAONMRelBF/kAsKGxLZTiv+C+1wrb44tXKvX4+ttoGP1KVgpoFyXh3v+sgSJPUxh26EW9qb7viPGWRlnbUklcyTOHDtvS+Rjdyysc5PpT8mYp/ONqov23eIE1yweTd5lDOKcbayjzitY6Kfr7dVSicnXXAnVEHGIranZrcS92sGBQLePCipnse/c9O9FWjwxZhBYEUg4fN/Z1FACPVz506TvP9tYtg2w+emxrwJm4a1HJ87b3HgpfBI06aqEeX8kxW8TC7jypLei45cZncmowGrVNemLwn0IJyqutznxIxGXRsGDEKIKRUPwz36DirvGZLPAN6GM+oCT5IYsl3cxkpJHZ+XLwJ5Ld/nhU2IyHWsc+8XnM83PrTa86S7VZ34WIaOTHJ67hUGZZd/i8XnzDPpz2ER9LV8wm5qBQj1DzzT9BjYyMdv1XGd3qGQrzSXuhDM9ssFOZjAFbHbwgH1Ax6Z/nF37pw58bo+5BJwQFraIpzVZLvWHO7K/0DKGzGN6fC6TTXP+MaOF+cphW0NjFTzZo9zHktMK1f5NE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RQrnHhchg7NMZifaEfl5TaggU7Czib7cLJa7YcKALJCpfE5d3vMQuY36TzHT?=
 =?us-ascii?Q?MZa3CE5Njnd7M/UBB611C8my9sf8oLh/YRPjWhJPiEreiTwQV3n8+93BF2DZ?=
 =?us-ascii?Q?08TdcHWsJ8snf8zNK0CHhuCnWVDpL+m0j6yxXe+WyBjoGuKxg753nAX683J3?=
 =?us-ascii?Q?1fXJWCpFw+tneW259q+t2h3dk9EZUcLsw1/q6f2rcQK5eyexDWM60DlL92Ai?=
 =?us-ascii?Q?Ie0gf86IqMfGbcpKzHdil0RwmjpXC1V7f8lXa/Y+jRB1N40C/8Gx81cBOZB9?=
 =?us-ascii?Q?b38U68fK11XcEe+tNWA8/Saa3l0shSxhlKkmH0VXABmr6/QJVKX5UIcvyJL+?=
 =?us-ascii?Q?rhvPws4sb03pBxQfUZwj2mUCFAlNjyUVAJTn9rrErqP7EnlE4KoGtfGHNKG0?=
 =?us-ascii?Q?4bxgyOsDBiDFwal93Uwhkfg8aerfIeNtraVzWczPIyHi8NqIAfHGEKzbGM7O?=
 =?us-ascii?Q?ZCpaX1aoxKfacgXriuIFI/OMOoc1RNJ28dBjW7Gw+WZfGRjUYStfkI6Y6pgA?=
 =?us-ascii?Q?h/UsdaFy7rHvrOovIGRNQokOdxXo6/w/aHNmENKF478NcOt5qWpn02hqQO8r?=
 =?us-ascii?Q?n/TuxtC10DmgTMsDT+mPqn4nBN6dhVzVRSvfix22jEZOpJw/MG6rQgCuBMyB?=
 =?us-ascii?Q?Js1/LPHy/2sqVG4/fE9fErEsA3goq3tPkkPCJ347OkT8a5gRnRhTrzlXPS+B?=
 =?us-ascii?Q?6bsWc1X+N1IOTnsjn+pBAEqQKjVbwD71yxyU4yKLrUYfTpgchYw/V0KwL/av?=
 =?us-ascii?Q?W97SVB4Zxi1/eQwG9sYb/n0wKLG2hey+pIcJDRFL2WvwNIBBmracdED1WcoT?=
 =?us-ascii?Q?PpatbAs8dceZCJkJPV/kfovh9T1/oWnj3b2HBQIUKlQ7nn/xc+CGRFYjI5aa?=
 =?us-ascii?Q?ORVtshQS+ZQ1LueoGpcNZb34ZqHtdiDGSMwWklMmqVNCaRk9aP80wtLYf7dD?=
 =?us-ascii?Q?qkl6nUakW4VN55U4gq8txpJj2NxJCLiiMZdf2PC1UA/xnvL6xu9wldrzIf3N?=
 =?us-ascii?Q?tyhppqGlGfaQyyXNW8HzzQKnwOgd0wH6M4lDHTIJeZo+2xkI3bJULbySSPfF?=
 =?us-ascii?Q?zNNc1VwUERLnZuRVn/MvzCizpd9mvj04eatWT3YfDnnJZJYj+0KWXSk3vPVr?=
 =?us-ascii?Q?E1N8+uFWnf8wL7BEqAVkpb8zA/DnU0ahG1LdM6qaPyE8CVfEXp1kEaX2ho2a?=
 =?us-ascii?Q?kePKQ/HOlhNfIk8zNGu0EZjJP/fS5yBQkOZSkYFZRxVa+VTqPyWW7sVIrweJ?=
 =?us-ascii?Q?g0fqGjb/iOth6/ZvjXBkuwB0BJ2G6A5SCpeHpFepIzikRXg9e9R1xDdbgOxX?=
 =?us-ascii?Q?RDNS82lxN4GUTqcLe8SvFclaKZgTvPKZ5wjP9v+q/XvfR8aBm2B5MLj+ZRfA?=
 =?us-ascii?Q?fsuswbXcGz+mAyXNYmklR1mIRFWxEgVeIdYqAfwpg8H83rtm8h33ou9XXPUB?=
 =?us-ascii?Q?s+HI1EHSClEaugXFD1lTEdrFy3J3aR+KidpuIzKzCBZzQ43zhsnfwIldeEIr?=
 =?us-ascii?Q?6gsYHSyO0E04PP45Go77E70BLANB8JJ7ir6BnTK7YfxqJPOakk6SeSYBxNrb?=
 =?us-ascii?Q?VdC91ZYGzfqR5JUA9jsa2ajeSzP9uXnIBQ2TNqMgpUs9icnlBHHbSLL4iv+2?=
 =?us-ascii?Q?WZijDl9MG8qEBDuTI5AOpEebA6W0NABRacmPOybe2Q8VA0KnRynwtBwVrJgE?=
 =?us-ascii?Q?gcgjTX2B6yd4PL4Zf4V8ch9YH/z2l2HYZyDJEJNYHxovif4uaQntIW304QRs?=
 =?us-ascii?Q?UIOvoStTVg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300f0333-3d7f-420a-60de-08deddc25053
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:37.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovVeSDw+b70xBJNhWTbMl51WfHrNDG06A92EU+PoYR3lh27ACHKFGmAwpoUHskPWuZI5u52VXx3oE1XaA+zk7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12194-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:orsonzhai@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:zhanglyra@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0715C73233A

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sprd-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 087fea3af2e4..dbf52ff88b47 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1162,10 +1162,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	if (sdev->irq > 0) {
 		ret = devm_request_irq(&pdev->dev, sdev->irq, dma_irq_handle,
 				       0, "sprd_dma", (void *)sdev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "request dma irq failed\n");
+		if (ret < 0)
 			return ret;
-		}
 	} else {
 		dev_warn(&pdev->dev, "no interrupts for the dma controller\n");
 	}
-- 
2.34.1



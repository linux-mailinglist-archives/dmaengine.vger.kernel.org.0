Return-Path: <dmaengine+bounces-12197-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jaqvH/2tT2qcmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12197-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:19:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE3732221
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=TdHuNWfE;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12197-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12197-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D537310D525
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2D43712E;
	Thu,  9 Jul 2026 13:59:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D1436358;
	Thu,  9 Jul 2026 13:59:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605588; cv=fail; b=DXEvp7ESQ2pCXeIEB7tGWlO3KHhUNizjMQ/csItbyarJVY7N4I/sj94WT3hDkxhDZKIqy7hJag12cPiY+L44fZjw/vH/ou5u3KM7W2H1duFfrJP7iCcwR1+994+7+jjyJstAcrsS6m3OqYPpMEvbNmw0GmXOtybFA8pDTDnrDms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605588; c=relaxed/simple;
	bh=UUsLNz+OSb3rHqyac22KDFt2VEYntdziRzAd1Sbivas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueLO9EVSTVxVxPCYqmLjLjlsQBbO6+1sqFUeg998OHqZh59s7qI0OJFsvn4/FgH0Q7D7yPW1QkZdt6vUtJfbd1kSRopxQxxKvYXyi8bmMWFgMRhoZWTtDQZ1yahU5E/qDU5fGPjwBGbGSSnL3eSrpbZgAZHxRGOVz1oWDXXVZwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TdHuNWfE; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfCY8zvDyRbfiiA6JN5YPc5geSrsDBd/Om7Pvr5gkh6VQuwWeL18v1+yqqp0W/2sCfniXhmhtY/tpEP/LXHrgf4nP3hzO9n1Iv7ezvRT/GhIXmmZOEpL+qLfCwwOteynLg7PpjexVsehPTH8mBG1tIokVmBDyFMqozAmLEfu4AunQfLd67+hXA2Pwellh4HWKC5jvXEaWmibzQwcdr3EUkBkXxe8/CrmLoDdNyLLxgucY2AFle1VpDE7HwvD3xNq5J4s1Uv5UWQbNdkHBiO58v7I4LRMcMTPQ5W+MsiYTNNEhe2ygz353kcFMZdSBy59ugVhLKpkxtoMUCrrpP+Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj+jq+4k3J35lzLRn7Tyh0IxsilfX1uXZ4AEr+ySruc=;
 b=H5xNaK9Hommpk90YofYAs5zyAJVFRRa9rqh7YXmHynPdQlqmcqBzgQMM/q1AELiC0b6kf8eq2hdzsBEQp1foBfpq1LJOUKdYQzl+Ig2vl14SJxguHgvyk/LIHpxRMTZ0/rKLj9W4u0A42g2vC3ogjlBOGo2iJu/ssD6/GltrNnPmF67r2bSZQiVMjSQAgDn0JQKD6gsef+IkyW43w+n3c/8cwRdvMZRKzfk0LCoOVlG0rqN/XjGz7pwEMdP/GUy7KiiltjJ99zkBr0WuBcvfCqF7npwd+hHgseH9EfhrdUJtPzVB3oO8pP/Fg1RNRCJLSZt+6IKKg8/6VzWt8JwY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj+jq+4k3J35lzLRn7Tyh0IxsilfX1uXZ4AEr+ySruc=;
 b=TdHuNWfE9JzZ2aiqxNqns1LJwtYEltJZjFMOuHKsZ7ybj9RWceQZtv9ZFAJ6Y//HEZYjo/bxEUnfdJ16i9vgxjQEBDZ+sCQ4twWceBDRuAzep61yj5qM/wx/TgpMRHRsYmTjQRpXuTLjzM4dH8bO8zFwWwKgPwMWjcJfEHN/Tk6cJU6kJASkKhsSkhve7+2kj+w/nS7jKzHKZIC0cegIKsZskKSzMTQRhBVJd9Te4DJGoZKPbCFyiwQdbp42UZ0XkTvEV4G5IO9f2e//TGPsFn0xlxmUAj25y8vlyj5ydIvQVYCp7cQHo6+pHSQK4ZtFF99SQeNC1EbiyERmqskvmw==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:42 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:42 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org (open list:STM32 DMA DRIVERS),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:STM32 DMA DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 19/26] dmaengine: stm32-stm32-dma3: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:23 +0800
Message-Id: <20260709135846.97972-20-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd50d460-00a3-4b4c-5299-08deddc252f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	ywTcV2+vRJm0rdpyPyMD68WydP5nHVxKSidKGhkeUsfx4HiHFNS0YUHDKLwakHtApBOOAVLE9Z2OEe3jlOZer89ZS0JO4HzM7yEM2zTYm5qJQdBUaGNpTt3pTZgkSmtCiaQDZyfZBJkMPxN+kGkVRPpd9boNwxDSuS/7JSwVgBScAu5O17YlBWsJeszMHTJklzTepuIVA92/9mDZnOwbv2F1FkPpOS5QeG3um2z/EpWXNvPil42zTjavf6SuRf1oE3KBWutdEFaTBDkHLHapS9RoXwTXiYgVhhOQAIHSXa0nkU9QkO2BDobffpYgRUtgrDz/NaGrPfwBwpJvZ/8o7Ibd3lahMH4cOawUSxhXeu9UdUlSQKp9zOlluOg9VbwWa8dFmFU2/A5CALLRnbg9MlBq1i7eMFAtQGDvy5vSOW7z09ndy3f7eWlPLIT0Xy36ai8tVoHC5U7eu5VewP5dWy373nKhbT+bfQ8Ah/KHYGIsIZL8i7p6W4PfHnmnywZfp8d3JIhYb/Fb2d2p5aRqUl/XtEq7OLOhiwMmC3TYHXENTMDdsw3tT0OJp3ZSRVQSO5hiSfql3jaGVTE6j0baOsgSmSA2LzzxctSOkOa+vp1CrawOosLP4ob3WNyeVfp9cbRiCz72a2UbCSFTffP+HPmHGfAmyOy2OFkGxpIYRsikEO6AB3u+XKDhFr6+QqWX6saM8SuSeyrlK3ZNRcO0MpFb4aW7ngNeK9UpK7lFpbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USPcUMr0U0MhCr5H2J01V+iZi8XnxwJQSNgd3rSbGoYMM+mBQrg629482T6V?=
 =?us-ascii?Q?DfWCN3nRP4UBWjd6musoouRLzWw5h5m8CzA3n8J/zqJr9ifN7ojxcbrABHZ/?=
 =?us-ascii?Q?lZB3oaNWmixROmSDPI3UoCbjSIEt+rqSLMG/ECllp77S1mJ4Rb47phP4m6oz?=
 =?us-ascii?Q?Fws4tLtTP2ekiYjKzwKTTe4X4uwyfO2b1fbZtdlhrEe3OYEH6hxKsbSA9ThD?=
 =?us-ascii?Q?Q8eB+ojWRk6D70H3TOGa/T7G5SdR9n0rYaFHKY8gzrLb3asMPZpmpRXu/wjE?=
 =?us-ascii?Q?uCvUUan837SbDoJvgGD/mzgWDBrZhmpsP6BMXSA8jSwNi2IaFzhm6OUdS5Sj?=
 =?us-ascii?Q?NcnUKDkVq7g3ccCkartpOBUwsEAtXx0c5K8xtZINpCUl47hctO/m2SUdG92l?=
 =?us-ascii?Q?lJyJ1Sw+uMJtCk84eeFxt4u7+fK+q06bxJ2gyISKvuwQxyJtHudarqN7YjZa?=
 =?us-ascii?Q?uPeBZGy6egualJmpTapzJSb1Jr1FUqgBq103ly4IRiz2KPpj1GWnKmj8+blL?=
 =?us-ascii?Q?Te0e1rtRaJHjOv96oZ5JN6RDlsdI2hn3wmZ9/x1NWXXc0gF6c4jy+dkNJhMn?=
 =?us-ascii?Q?2ddxYwQS7gHpkqLiInBelb0jzObJe68m1/wF3eji5EP6yvkOpuhYKAIZvtsX?=
 =?us-ascii?Q?mYuhcLQ9XuCBiFEXhpvFN8O0syYBs7IsTzzgOW303BlMSD9hhsqHNxGiWoqT?=
 =?us-ascii?Q?gpyVJQwg8dfN0exkvaAryjWKJGho9+q/7Mr4+N4AFeEhPojYUjr1Q0PLjgC+?=
 =?us-ascii?Q?pskMMSykR9QhsfP66dkCyibJ6dkbKfiqymSlVZKFAI7OMCA/ly9n/eQ8q7ba?=
 =?us-ascii?Q?JwiewahvhEpmZekJwQJAKngZTxWv/yuO6yVHZRf1m5f7u0UDWN4GJEpCn2jl?=
 =?us-ascii?Q?w5JXVFieWYGT1BF/rlMKd8GXuphIGybBaVBQA/i8pn82LpZh+KiC8gU3oRax?=
 =?us-ascii?Q?IavSpevdPYzmjB1HBcHJpOQpFKILJKOs6LyNoMOE+oHRQlr41d+uVHA+yAAQ?=
 =?us-ascii?Q?vX3aqQv5W+F8j4G3XAHyoF1SIdugCCNzCK7ySZ1Y6go+aZN/aQsqQxpZn+1v?=
 =?us-ascii?Q?0hJqNM8My9kANniVlIgYHWgKZ4rO8KrpxnflbM72GCc5KLxiWi9UKXHNzVFD?=
 =?us-ascii?Q?4dJ3DtcKbzK6AVam5Ui/JOXVvRJqB/PLrj1gy1CGRb5hZUBZ3hNZLO0ttxGM?=
 =?us-ascii?Q?w6w/JnIZaimN2siZUsWME0aFmK5Hx8hk6f2SxCILelWm25O2qXhxyxjrOwls?=
 =?us-ascii?Q?oCxHDkcu9aFc4vKdpotunTIXoMZrdeyKvAdE+OdVQ6K25kg2rQnGkwio+dAZ?=
 =?us-ascii?Q?kZr8brB8f+3wlfYnmu3o15KuXmoP8rOqp7FGJ62VlMHzUaStec4m4nvBhJV/?=
 =?us-ascii?Q?Atpbr66KEKvsvBkPYqz4xlLX6jfQpenTKALEqgfLwxLOoAJ9XAWRfCYDlMYT?=
 =?us-ascii?Q?UIYQlsSNhfkPXf/9OoPf7fbxQtDL4X19PjIXE1Gud7X5mw4PIPGqsE6odfMt?=
 =?us-ascii?Q?OmbZqb5TeQmXQcyXD4lzjfw3JJl9yDT+gBQphw7PNFdg4/4f2Z2z/7smZmcc?=
 =?us-ascii?Q?r3DQCmk4IiWckyw44rynbUFLs4LY5RPvqjAUWiKfD44u0fBOFoJvX9XjMypV?=
 =?us-ascii?Q?V9jQa1Gfkr/T/+7NXL6COTWzrdoKc8N2RKbvRYaovGW+dxUsBvN4POYmk3zk?=
 =?us-ascii?Q?Qm3PSKx+8l/TPdXygIRrSBn388JK9/Et8SfNmFOLJakTfFJGCsr0tTZfcSVt?=
 =?us-ascii?Q?zTgoRaE4Ng=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd50d460-00a3-4b4c-5299-08deddc252f0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:41.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhiaFSwVbMbQNFoOwQIOIzT7URNIVZJnR4lqYlhvctmXqP5V+6DGFd1Q0gqW2dAtosH6SvJOZM0Kr7UhOxlIqw==
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
	FREEMAIL_TO(0.00)[foss.st.com,kernel.org,gmail.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12197-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amelie.delaunay@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dmaengine@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20BE3732221

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/stm32/stm32-dma3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008..68ed1d695f1d 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1893,11 +1893,8 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
 				       dev_name(chan2dev(chan)), chan);
-		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
-				      dev_name(chan2dev(chan)));
+		if (ret)
 			goto err_clk_disable;
-		}
 	}
 
 	ret = of_dma_controller_register(np, stm32_dma3_of_xlate, ddata);
-- 
2.34.1



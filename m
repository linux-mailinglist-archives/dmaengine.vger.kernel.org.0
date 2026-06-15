Return-Path: <dmaengine+bounces-11534-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9x/wJsQdMGrTNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11534-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98838687D2E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=F+0NWS0Q;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11534-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11534-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68A51300CF2D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333F40961E;
	Mon, 15 Jun 2026 15:41:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22503407578;
	Mon, 15 Jun 2026 15:41:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538101; cv=fail; b=nGpUp8hmxAAGA3+bR7iI6FNWTXgw0m7WG+93pksvoyJKnB9DcOQmCt1PtDosNQpLNY74c1Q6TrVDuW0aQpvk0CxX36XQPAKgq0okgnhb/LIjxTa+BK7oX8k+O390LMpZfwdt4Z/0skyJoGsZ9BxjBdPlTG3onJ+2kqpmV9Df76w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538101; c=relaxed/simple;
	bh=qwi2T5EPKfB2B42vsdG3ZHeyNUP5m7HGAerRGDInRQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osK8A0t+gPeaJF/zWIyuJxyJ+RIZn6Ef+1SVQGC+9BTcONl4KMsfkX8cmAFVieNam3V88Cnc5iUttuDxFibkGPnL7cm53g929vlsR3Isw+aYeoeHBNx/p70DLqJElnmLH+CJCRDN+nmiQC58npK5BCx0Dl53h6gAxglq2ddOhdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F+0NWS0Q; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8NDRuAmrL3PLHrKcxkYUlW60yD2IhVnN6rcR2V0BqLDxWgyQ1SvT/u+T55LN/IpeWZ+wc51uy+Yev2GXlYSlfIPw/Z7cOFWWT+PvurBf45vnnOjPLAb2Bf8/5LMh1Gx4MLb6frb58RDgmoqVhXnIXbkB4oF1+YF0yRl405S9B533qEj541tT1PUBCPDw8w70dqPUToOnl7gLM/3YECXsIXgefx/ZEeqfHY/Yr+0MbAkdYawltnWFHu3LfH3OUs95rV5TkFY8c1eXQkfNg/A93bg5fzD/1Nf+uSRnJPwKZi8oJVNM97Ejiwndmz8T+qk0eaXglP82AjoqWwEu7d7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh6SFmJsWdAopziuCIf5Fs66H0ifbHot4SbvM0gpJWE=;
 b=h1jf+4LisMH6OHVz0qyu59SX2EGMj/KNhG5eFUCOVpHup7Qsq4OCDFtZR70GMog/ny5qnbS7w6/UEB/CXs3LKnsLbxNiDthvVGVIZAqtDtg3F6PLe1tG4WtERbU1Dl0Lf9dzJ+0pOLb9CKq+Nh/5hEXqPvCj6QeQhLwxmKtO3a9VB4orJgfloVCqDmkRMbKQfF/4g3qDMtXIrzBOH7uwYnZElnbQUQ0WJ5dVIm5+5J1MzkS21h8K6cdhD/dTrXlldHiw4MlNgP81TsuTBe4pZSFw7GPgWjHgylKp23VlCwJGymx/3CZ7luwSm5pnxib/dMXiuao0w7Fvrsb9lzhphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh6SFmJsWdAopziuCIf5Fs66H0ifbHot4SbvM0gpJWE=;
 b=F+0NWS0QPS752v6gxfakvj9fNG+QGxYhS0uAuXaAuuB8n7mWBoz91CV7N0f+ibRg9EYW3Lg3gGODn++he3UNLwwMnnK2jF7cJ877kP1GZFUetnqN1Er2haepXQjAMofRpZXdxTA0KJFSC8KQKtpQ9phJs86LPkjy1k5CMPvHuX4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] dmaengine: dw-edma: Clear LL data entries on reset
Date: Tue, 16 Jun 2026 00:41:06 +0900
Message-ID: <20260615154111.2174161-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: f70ac441-1268-45aa-f110-08decaf49249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vKngz/M9GZhAlsIK/m1dFdIwQ9b/WQeQlI7o3rAFayMI7+CfypOLLpouf1YbohB++QcOeIeqw1BnPsMr+UTIHS/0jFGZTPvXeOpDml3GnEdLr33ygORlh6ToCNa80XjO24Na/txUrook2c3XTg/ts0ay2i+2vvovvfvK7UIbw2jAwMI8LwagJnLirWWHqEtLKKLV7dd7uWwIiIjhWyyk7gV0tucuAAxLqpgKtLJLS9X9VrwJGHhRuI7r7pyXDU17UN/zL0SRKGxk+UcfFEPRNZmxpHvOcBasUnhZODpuhTG0fDB+l47n0JfaI/Iq5bRzXNdBmfmM/ybvdDZKb+YEZsod7JZcUPwKIB0wzjzG8XYXK0cwkzULeB38Fhu7Zm9FIFIrOynpMKEJiAmuYEKFgkWL/9nSXK3C/scUOyA/2E+NzNWQtX2jmVN79BIwnuzUqbkcS8QqYzOJwNKc6ezqKHaYk33yTApSeE/WrovNA5EAIqFbQYIB7dx7J49dTkRrwDxtWxiXHi5NLBGOrDG1M0Ts1TfWFu0Q4FPDqAL6LDjSYLlwDxTaIw+s0L0LGegE83S5Bs4Ep228ca8KLWt919O5iw/Suae5i1DymQW3C/r5y7uM+KbK6+cMPCNzKAgEVxnv4/h1opJCkQlXIf4vgrozP8bicoAG7XUng7sAlLU6+zQYHe+ToecHdU6pwKgsSgOANd2BNnfohlkQkzXKWF8JpYPYf62DFBFWcLDDXEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imGAxU/XNt2DseSjM9xU164FJ5eHfuNXB7ffh/0HthlE4cwnjmDZ0eQdRkgy?=
 =?us-ascii?Q?DUt//1shdJxzYshdebwhDeSrC3vo30VX7zR6oPxo5Tbq1mGu/zJFqfUStbt/?=
 =?us-ascii?Q?Vf45haDEwKd6qrXKFEihYSuBOSHI9X/rXrFjkxgAW6FNe008uqLUeYd7adyO?=
 =?us-ascii?Q?TgLGcjYFu45m/4Mem9JRKYncWYwRfwYUySRxlRwykDF1h41LjxhbxCOJfALX?=
 =?us-ascii?Q?hkmcR38HWesgmOSwKSC9GMSnN3xxQIySuDBTE3f0CBMHuog4AR011Xb2Ycbt?=
 =?us-ascii?Q?BVkGRDNpAACKnYOxxPuxwt/0i3tVEq9rnNUTd1hFAkbspWkVdmtPhjK8XU8K?=
 =?us-ascii?Q?fN/18rkFT4zOIncEGIUWOJEYZU8nf/VSVrp2au47pXH79kUcT0Xd6goJKd30?=
 =?us-ascii?Q?5NDEH6s6MY/aHK4AfuVP8WRWILwOcdJyy3epCI72wyYQzoGHxQmDaTZCV1uC?=
 =?us-ascii?Q?wJQE1ZJh4NXf0o+FuXqj2WRRWTAPT6BMQOP7pSHUsgGg0j5oYNLYIM5TyTDM?=
 =?us-ascii?Q?QkhjUgOi8AnhjrQvBPGP/3NXU0NTySP2kETIohC3v1IsKAjWRDW+9+BBfBuE?=
 =?us-ascii?Q?gAKN7CYaKPY4Ul4SXjy9T+V2JOOulBmzBEnWxnyV5cCG2G+++FnbmrtX0tD6?=
 =?us-ascii?Q?VPrYXD55Y1hbID18IjQCTfT1tSBxE+s+FRMGwpvQ4cRsKBNmBl8/GDnRljHi?=
 =?us-ascii?Q?142q8dmD4bakCfD2zR46aYJASoBEmaY5rISQ9XFVw/ncsUSSAq2dXBMZ+bVd?=
 =?us-ascii?Q?LfgBBYDfdZERPntCMGRacIKJkmSw66+x3VVjrWeF7UAhNcU/aQVMeb8tpwZc?=
 =?us-ascii?Q?MmruJUsP8AHiHYvSKeOo/gpzeqsBkVk4qyP4luq4He0X0loSBSNyDljvNTjO?=
 =?us-ascii?Q?P1nelho8e4CsVvc2c2hmON4ryfDOdO+o1KI71O2RStEOMwlW+f6mJhwkzheS?=
 =?us-ascii?Q?Gh15ucDNyilYLwgLJT1r+g5MsT1LKEG2s2SkMuTra63EZt614xD+ccss8COM?=
 =?us-ascii?Q?6EiP4yMQpE2Mo1IQntcFXKZunIpifhX1I1JPng+Gl0xaEUCa6ZBAeC4GFpSg?=
 =?us-ascii?Q?5A+tG9maMhUgT2Giqktzc1LW5M9hLb0UnD1LOvUJZ0NkSR7p4D2CbDAZN6+3?=
 =?us-ascii?Q?Qc4IbBbEA+NI/korr9Ay9hpFFj9yNwJHyuhuhNnQPv6lJ1Gp0GICpIYLDWhJ?=
 =?us-ascii?Q?9A368tZgkGpKfVt8dQjWLfibROFffozxJcYlye7XPq4/+oOPoCR9vN7v5p8l?=
 =?us-ascii?Q?OE/MuXZbMaIg5RRbB5ggOi8pMzce+P+un+MAxbEl5u4xzS+uyZ1FrW8xF+4k?=
 =?us-ascii?Q?pMtM5Oo93C4LyFGf7f6iK6IFeVU/83rP8BD42F/HVq6Z4mDdo+nuUbJyfkGC?=
 =?us-ascii?Q?mN2cgnYdyQrGKrNWm+OvgRndX4H5tlH7WaEahcMH0xUrZw5ww20wRYO8Sa4K?=
 =?us-ascii?Q?uRH+pbsHz12m2k8sJHRGTPXY6Uj78tj3D6/pvD1bZL/jM2fvFyQqnXfmtGv9?=
 =?us-ascii?Q?Vy/UH1BQvXGwUakCm6KQJlbDgu0bct0ke5htYq91SjADvTjEBNVN3Qy7L2bA?=
 =?us-ascii?Q?hXpTltLS3kTw066Zro9OwpuPXzNLbWbb3HTOHKnvZbLkuSFzLGspe85EQfJh?=
 =?us-ascii?Q?YmvdiF+YhD+aEpy20NrVnD8nt3qXex1nzhF81myIzGOBDscdBhGvAvyUscxr?=
 =?us-ascii?Q?c5foH0i+4JrwRMKWAjXj3THbP8djZFyL3hyolFQQ5KSccx5TGoJOkmaZiPHh?=
 =?us-ascii?Q?e7/pZ38d87zjIbx+7DUqEjiWS1UADPE+WFlIqplC5BROauDfDghE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f70ac441-1268-45aa-f110-08decaf49249
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:30.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL88QzWEfjVe7l/6E6YQycVYvbaiQhS86W+7k6Brzi1j0jdK4KLM+JNGUIK5hsu1PlK03xJ+29AZFCKxrdtmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11534-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98838687D2E

The LL memory has always been reused, but the circular LL ring makes old
data entries reachable again after the software state is reset.
Resetting ll_head, ll_end and cb is not enough if a data entry from an
earlier lap still carries a control word with a CB value matching the
next lap.

Add a core operation to clear a data entry control word, and scrub all
data entries when the LL ring is reset.

Only the control word needs to be cleared. The reset path starts the
next ring cycle with CB=1, so a zeroed control word leaves stale data
entries with CB cleared and prevents them from being consumed before
software rewrites the slot with the current CB.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    |  5 +++++
 drivers/dma/dw-edma/dw-edma-core.h    |  6 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 16 ++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 16 ++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index a289d8f8cc17..e76d8e0c6fa8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -63,9 +63,14 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 
 static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
+	u32 i;
+
 	chan->ll_head = 0;
 	chan->ll_end = 0;
 	chan->ll_done = 0;
+	/* Drop stale CB bits before reusing the circular LL ring. */
+	for (i = 0; i < chan->ll_max - 1; i++)
+		dw_edma_core_ll_clear(chan, i);
 	chan->cb = true;
 
 	dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 9bd0a5f2f08b..1252d264c1ca 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -150,6 +150,7 @@ struct dw_edma_core_ops {
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ll_clear)(struct dw_edma_chan *chan, u32 idx);
 	int (*ll_cur_idx)(struct dw_edma_chan *chan);
 	bool (*ll_irq)(struct dw_edma_desc *desc, u32 i, u32 free);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
@@ -255,6 +256,11 @@ dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
 	chan->dw->core->ll_link(chan, idx, cb, addr);
 }
 
+static inline void dw_edma_core_ll_clear(struct dw_edma_chan *chan, u32 idx)
+{
+	chan->dw->core->ll_clear(chan, idx);
+}
+
 static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
 {
 	chan->dw->core->ch_doorbell(chan);
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index dfe0483896d3..265eefbf2ead 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -495,6 +495,21 @@ dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
 	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
 }
 
+static void dw_edma_v0_core_ll_clear(struct dw_edma_chan *chan, u32 idx)
+{
+	ptrdiff_t ofs = idx * sizeof(struct dw_edma_v0_lli);
+
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
+
+		lli->control = 0;
+	} else {
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
+
+		writel(0, &lli->control);
+	}
+}
+
 static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -544,6 +559,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
+	.ll_clear = dw_edma_v0_core_ll_clear,
 	.ll_cur_idx = dw_edma_v0_core_ll_cur_idx,
 	.ll_irq = dw_edma_v0_core_ll_irq,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 9f5b11350f23..ad5e8201eb63 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -319,6 +319,21 @@ dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
 	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
 }
 
+static void dw_hdma_v0_core_ll_clear(struct dw_edma_chan *chan, u32 idx)
+{
+	ptrdiff_t ofs = idx * sizeof(struct dw_hdma_v0_lli);
+
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
+
+		lli->control = 0;
+	} else {
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
+
+		writel(0, &lli->control);
+	}
+}
+
 static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -385,6 +400,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
+	.ll_clear = dw_hdma_v0_core_ll_clear,
 	.ll_cur_idx = dw_hdma_v0_core_ll_cur_idx,
 	.ll_irq = dw_hdma_v0_core_ll_irq,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
-- 
2.51.0



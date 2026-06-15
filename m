Return-Path: <dmaengine+bounces-11526-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zHzXKXgdMGqtNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11526-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:42:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A551687CE9
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:42:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=OnewtKAT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11526-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11526-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73CC3300EEAD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA07407593;
	Mon, 15 Jun 2026 15:41:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385344071F5;
	Mon, 15 Jun 2026 15:41:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538093; cv=fail; b=ZH2dBq3JtVou8Omx/31eUUZmJdJbTqxgIm7p8Zt32Fqocx8oBEv+OT0wflAeL80UcP+6OB9scOZPQg0Eub/fBPrD9J/Ao7YeoUC91cL6q73o7mIsZYtOUCLRXDyWFiXkqZ4w7/H+v3OSBVLEjmGS72qP/FzE74OvCY+GouXRTXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538093; c=relaxed/simple;
	bh=t3JqZVOdJbOmSTe2Vor6WrmcVJCYECBfyBLXDAZ5NWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2B+qKZfAPh/EVdV1OH8U3sEHND1RNWXCejiOV3aPZAWKonmHhQ9qQdM7q45NQbxmzGxl4qmIlZmRxk4fEUTO2Ywh7EhtRcElBzNGDxoSIquKCcIMSsd0kTE9WXlXiVUlWjiBRt5b0M3wvhMG6cwuiAzXkJjXx2S1e80i5M90d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OnewtKAT; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uuh8GlQX4+6HOIkzQ+Z/yE2b3o43PccRXQ3m4YhPJtJW6M6XBmYMyRoafX+aCuMHkf2qIGVAjewttXD5k0DXA5yNNR07nBEXmuisV9Z2FH6LKtyYmjeFCnl+d6cpG55ml5yDmid5mlS0wdr5EtGZHqx4telDU0rXmHXOhC1w0tMxMLw3K85HvoUohZbYD8Kr7OzdkmF+QfeK45PIvSjAEE0l9p36B5IsuG7QUcvXuF+qz2LzOSQewcGDOquqv4KDYYNMCpqG/DHyK9O58k5nVkiLkH31ezhrU+zmm9kYGkXr6HwJpq6wIsBBUtpVOS6CpC1pbeoUiN5ST4RdY4Y2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggLYp0e/oaoTEaaVgTufCHc5tjAPEZYI0Ums5aqP3RE=;
 b=HRIfB0jmtX2//NTXg0/I8LA9bMRzNlQ69CvmZiLLxpHhz47e9mNmxkj8cQPCH8po4YoOkuA7TB/hmPNoBi9TG9eyFFzHEDynGHnp6msXARV1mTDoQJR7eNkhb/qX7TAHl3Yp1ytOVz7z6GDzhSPaHDEyefQNMM3JelpXWEUH++Gjn5QWdStdGEhr/LyLxh4INSs8GFuO/g9KbCjB7Ln4bMcTJ95wKmHgyYvt4K08RWIBqR1zgurBEpt0OQYoyJyhJGqK3KlX4mfz2Om5wWdFR44Bmt2eTP9MlxFyGUPZ9DF+EvNCh4G2KaTPqI5NXAovVzETYQmXxT2kaYULqew8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggLYp0e/oaoTEaaVgTufCHc5tjAPEZYI0Ums5aqP3RE=;
 b=OnewtKATd50u3FCgO4hCgmKFy7ul3WKgCNNClHi28sdoh8kuFEjcGVV2LNIqWgNB/2rgqtwjA6WhIfijcpIVRkHOJOAMe87Xxk5stij0+iPnDDyPFnwM70wOZZz6KV/sm51mwj4nx9L7x5KvG1RK2TRKSIwuk2lqGk04sbuS4Cc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:25 +0000
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
Subject: [PATCH 04/17] dmaengine: dw-edma: Clean up vchan descriptors on termination
Date: Tue, 16 Jun 2026 00:40:58 +0900
Message-ID: <20260615154111.2174161-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0117.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: d25cf4c3-b06e-4293-1343-08decaf48ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	iNJDom1zxAa6incXJVevj/w8mGKrm+1f5k6cQtD+E/bDWtgkWkV/dvt+QondXa9HQyM4xB8qi9Nk9GBNJa0+wG2fmxQHZTlICo2jATkohNtkJliPQT1QtEUsad5iyhOGkE4zY9rEI7W5O6IHnJ+SYurrrIpckJ0u/nywFCLZHC3plL+jSkPXsxtWpI/2hdbLB05K6AqjuTrrFG9CmgbPbj1U9uTmBNb8G5W/GSOCg7pSU3kpNYDzoggQn7Th31LjsTM/KpqFCopeqn91sUfdfDLb70CI2DNgDU4yZ3Qg6MvpsX6VR16xqUrWvwl5DslfSeXrqPXb1vM8H8YKNyVM9ZHKihccboAK4qO9kAACy/52TaPKz5iMI3Tf/wo8YDXH46sIBVUCfGQQgMZh0ySXDDsxWKouHjOeQm3e5DN/sf+9RKfhm/J7bdz4ucfma87NKBaA4SPSr5s3RkGtF2/g9/MmU2+X9DFqp+7wGenhnmD0uWfBQ+xdjXk7Bbto/SZLCsjIVjUmUm0uclTm/r6kEMMLoFEloSlS6AD5hWfWcGlH+VmUDIk6R9OhXep0t3hb1WB92hapzp2DbBAXsMHkOd02NW44nAxD6BMirtDEzUukgb4XWC5PulxXvoS84Fi89imQNFSSk7T0sx3U+i/MunNkz7hInefV4aq2ttvt2hl3yRBOr77MrWcZ5wURgugAfbo8ODYRrtSAYuCdzdtnriGwA7pAQoOD8mywvCd2rJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZP+i2eGt+GFIqUvagnbQ9PfOk3WP43qWyIZe6LFSg+MiWtHjTfLpN/U2cA9A?=
 =?us-ascii?Q?eG0JaZmArVs39NCZr0b83oflSRB5sMpm3SzoSzZJJIHu/sHcXJzSo9Sqm6f0?=
 =?us-ascii?Q?5ZXaAnSc0lB991mUrGprUL1da7yqWzAEfZcU/LALLUizy1kh+iSKsZCqLKTc?=
 =?us-ascii?Q?Ml67SZc2IvEgTxeWBiJE7kCxtVbKATsDZOayDyvxgFxbIwoWjvipXSxcPPH4?=
 =?us-ascii?Q?dXLsr4if5xDM6O4nXn70eBbC6mSJ0jIQfrJJ0IFu85CdHW0lAPEiz6nSu/WW?=
 =?us-ascii?Q?a4+KVLrxRiZtOJL66WXJPF03iDPc7JwUeL+bgfNQ2fCHsUhwDhI82SfLzfw8?=
 =?us-ascii?Q?FDC25iVKsS7kLIerXderJDWRR1ztkKNOQIAYrdCO53u9t2VEFglQJMt1xTLe?=
 =?us-ascii?Q?fOqwczvjIl12/RvxnMBXUQBDyaZnBDNlgus5Z9BN3X50Z+Asp9n3+qR37Avn?=
 =?us-ascii?Q?fX7NJpBPzzT6pE+hehvvczP1KYd5QPEp/vPtkhKF9i96orPySWL1kKzBHgU4?=
 =?us-ascii?Q?hRQKQH6tBxJHTOWHgrU2oc1AHsucXBxfCRHWcbH1xYOthvc5dR32KAIWt/0t?=
 =?us-ascii?Q?HAzj1ZmVMGVaPa3y6eyYe9hQD4TRbIKziw4rzcEQbQzcHommq1WxmvXJkOcV?=
 =?us-ascii?Q?hZmLlYv49RNQMD45CcrPRhogDnIsGk7IneTDWDV7pMicEHmWxWJV38kMRJs+?=
 =?us-ascii?Q?zNdRUz9T4U5MuimVaDyUR/AX9Jlj6eZTXRHZ9kg1RZwncCo3DGmlq/aLT73R?=
 =?us-ascii?Q?JteJ3uIQRAbSIGg3+8afbyHdpVjnnSDkLRNrhZjGe/RIFMYFUA9WyJRojzAv?=
 =?us-ascii?Q?XhzpkKlVvaWusCLrnZOjdCYXkY2zeCF52lHMmbe57nvZfAtZNAt74L/jgN/+?=
 =?us-ascii?Q?/JRipoIDtToWNJvliKJ0itb7Z5ftFAMiL7cxFbm1Yf+3gS6x4a3iJlWvsOOl?=
 =?us-ascii?Q?BL2kF1G+nXABaJNSYVak3dAfFSjJ3EfZLa6hnVgKlK3OYchoprjZM/2eH7GR?=
 =?us-ascii?Q?nBkmTeDX4TKSKPlQno4kOWM4xzhOuw08y4qH1OwSptbF8XzqFfoJPoJSLVjb?=
 =?us-ascii?Q?SaFGPS7crAihZQLOWLCT/Stb6PTs58Wi0wK5wpsFkPOPLdmljvkqHDnpQPSy?=
 =?us-ascii?Q?9AWvLBan7gd+/We1rlmeqM9c2zM0um3eVO2/W96y7xwu9/X846l2K7QKIr+F?=
 =?us-ascii?Q?DwSDWTPwReZalTRWFTUq91smilwkXjUOet/p+yXITi8YlhDJv3SdU9T95dGr?=
 =?us-ascii?Q?BwsamYqInPzfkoaqe52QvxZrPILJpcl4zIkyy0gFP+28+ahPPrf3DJTfBIJq?=
 =?us-ascii?Q?zDxXH/99BjKIlIQABE6jjtrsL/C+vE8xdaGB4qYoOnU2moaRC98ibno3eaPS?=
 =?us-ascii?Q?eyFAK/2pTV/V7ue3XjzJ7aMizHfucFt4BanBLQUwc4vL4IrRXGSsl0AVj1Wc?=
 =?us-ascii?Q?RY2TNFxtN2m+RPEBP2TwSHfiqsId8RFh29HiXvdcjP4eE6zndN1+OGAH3x0E?=
 =?us-ascii?Q?kZ6bGEeYq8hLh9Yxj9ayjOLzqkb/j7rP2UDPG6rP7IpUVQArnSfUvZK5Y8kW?=
 =?us-ascii?Q?eYpyPDWfCEdBlMyK5jMXkAdtgaNBj+opGIa9tVP78KGY1ZV+aSUkzn5L7fxA?=
 =?us-ascii?Q?R5re8yke9hNtvbucy98bbL4wmhHyvNfGd73A27SRhHkQ5pBAh0wExQYTMsNp?=
 =?us-ascii?Q?i9G2XZ9G014dyyTwm5CF7O2Gce8RU+kZbk9z0x9wA3LBSduV1tNtqP59m8+i?=
 =?us-ascii?Q?5uK96rGA9+8UPbv/3vTw87EgNLvdvbPRPkX9dzfFcoMX7iSc0L0o?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d25cf4c3-b06e-4293-1343-08decaf48ec6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:24.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJm8m0GAxe40KnSlM+bHJPc4GMmjG0oEA4zk6x6Il3BwgG1v4A1WLpbWlfZEKZvQKOV8Jk55X0h2DJvD/LLAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11526-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A551687CE9

dw-edma resets channel state from terminate_all() paths, but pending
virt-dma descriptors can remain on the submitted and issued lists. A
later issue_pending() may then restart work that the client already
terminated, possibly into buffers that were already reused. Descriptors
that are never restarted leak instead.

Move issued and submitted descriptors to the terminated list whenever a
termination request completes. Also release virt-dma resources from
free_chan_resources().

If termination was deferred because the channel was still running, wait
until the STOP path deconfigures the channel before synchronizing or
freeing virt-dma resources. Otherwise dmaengine_terminate_sync() can
return before the deferred STOP cleanup has moved issued descriptors to
the terminated list and before the channel is known to have stopped.

The old free_chan_resources() loop usually broke as soon as
terminate_all() returned zero, so it did not effectively spin until the
timeout. This wait can now last until the existing timeout, so use
cond_resched() instead of busy-polling with cpu_relax(), and warn if the
timeout expires.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 78 ++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index bedaee6d30ab..2777dc0b2aed 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
+#include <linux/sched.h>
 #include <linux/string_choices.h>
 
 #include "dw-edma-core.h"
@@ -113,6 +114,28 @@ static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
 	vchan_terminate_vdesc(vd);
 }
 
+static void dw_edma_terminate_vdesc_list(struct list_head *head)
+{
+	struct virt_dma_desc *vd, *_vd;
+
+	list_for_each_entry_safe(vd, _vd, head, node)
+		dw_edma_terminate_vdesc(vd);
+}
+
+/* Must be called with vc.lock held. */
+static void dw_edma_terminate_all_descs(struct dw_edma_chan *chan)
+{
+	/*
+	 * This order must not be reversed. Cookies are assigned when
+	 * descriptors are submitted, so desc_issued contains older cookies
+	 * than desc_submitted. Completing desc_submitted first could move
+	 * chan->vc.chan.completed_cookie backwards when desc_issued is
+	 * terminated afterwards.
+	 */
+	dw_edma_terminate_vdesc_list(&chan->vc.desc_issued);
+	dw_edma_terminate_vdesc_list(&chan->vc.desc_submitted);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -190,20 +213,25 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured) {
-		/* Do nothing */
+		dw_edma_terminate_all_descs(chan);
 	} else if (chan->status == EDMA_ST_PAUSE) {
+		dw_edma_terminate_all_descs(chan);
 		chan->status = EDMA_ST_IDLE;
 		chan->configured = false;
 	} else if (chan->status == EDMA_ST_IDLE) {
+		dw_edma_terminate_all_descs(chan);
 		chan->configured = false;
 	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
 		/*
 		 * The channel is in a false BUSY state, probably didn't
 		 * receive or lost an interrupt
 		 */
+		dw_edma_terminate_all_descs(chan);
 		chan->status = EDMA_ST_IDLE;
 		chan->configured = false;
 	} else if (chan->request > EDMA_REQ_PAUSE) {
@@ -211,6 +239,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 	} else {
 		chan->request = EDMA_REQ_STOP;
 	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -544,7 +573,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
-			dw_edma_terminate_vdesc(vd);
+			dw_edma_terminate_all_descs(chan);
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_IDLE;
 			break;
@@ -616,28 +645,49 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+static void dw_edma_wait_termination(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+	unsigned long flags;
+	bool configured = true;
+
+	/*
+	 * dw_edma_device_terminate_all() may defer cleanup to a later interrupt
+	 * while the channel is still running. Retry until the channel is
+	 * deconfigured, which marks that termination completed.
+	 */
+	while (time_before(jiffies, timeout)) {
+		dw_edma_device_terminate_all(dchan);
+
+		spin_lock_irqsave(&chan->vc.lock, flags);
+		configured = chan->configured;
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+		if (!configured)
+			return;
+
+		cond_resched();
+	}
+
+	dev_warn(chan->dw->chip->dev,
+		 "timeout waiting for channel termination\n");
+}
+
 static void dw_edma_device_synchronize(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 
+	dw_edma_wait_termination(dchan);
 	vchan_synchronize(&chan->vc);
 }
 
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
-	int ret;
-
-	while (time_before(jiffies, timeout)) {
-		ret = dw_edma_device_terminate_all(dchan);
-		if (!ret)
-			break;
-
-		if (time_after_eq(jiffies, timeout))
-			return;
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 
-		cpu_relax();
-	}
+	dw_edma_wait_termination(dchan);
+	vchan_synchronize(&chan->vc);
+	vchan_free_chan_resources(&chan->vc);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
-- 
2.51.0



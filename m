Return-Path: <dmaengine+bounces-11536-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SsMGHwEeMGrrNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11536-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:45:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C8687D53
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:45:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=CLUZt0z8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11536-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11536-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80C68301A088
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A51407596;
	Mon, 15 Jun 2026 15:41:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DA409612;
	Mon, 15 Jun 2026 15:41:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538103; cv=fail; b=Cf6sMr+b8F7hSE+v2Xq0L2R2mP6RMIC5lhmfleMBnNswbGEih72Mba8H//r6Nqxa+YnEp75N5hx5FWevwJcuHYDIUYkrhclAjF56765gq3cxkGLKV4Ob5HyN3jYCZwG80OZqX1Lea0YafFFygY6pwnhOsu1JSkoD+GtDMEhwihI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538103; c=relaxed/simple;
	bh=Em/KXvmQJaKcwjq7BIggkVcW56NLan4HqQHsQ8DBlx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OilDb3jzqw3lVIZKBDD+MZk/4vZnTSVRpqLoS8+hQQCkJ2fbKuHmmygzRPAsKVwMn/ryyOjerbwgmhqiWiy1W00ajCKBHEWYDLvpHLBL3FrFdbr3oizddt2dDZA+A4dMWHiuFY65NpGQs2cqCGbNDKk81Wy/ApN/scxpOAECanU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CLUZt0z8; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKz/z1gi2vKHtqX4s06L7yEnlK50/Tzyyhm8TqTqfnig54MJ0v302Daxj5G5/WWZEPSBbftDJyse39PMasaDK4BwMJwgc1CaiK2wUz28FuDpZ4UAlUKb+vJLD8zxZJ5311MvGeqAph8c6vbspESoJz4mg86k6n9dGViaeRyYsanX23ZG5bB1PxYjrvMeJCmR2PB5F46oSv+UUKeGGp43BDRBszj0piXDpkSDYyRgoi3TlXy2dRnFj5Gu//SE7ZhMHJPEkH1dW+btfFzLYeFFxeQYkmQG/wIkR/9mKvB2JNA1NIjiW5zOQN/yGNoW/+3XQPla2IelJ9hseI5b6U+zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWNmrt0t9MsqunSDnFBnnV6Z4NlkYfxwEAZer8SD/Mo=;
 b=pQOd0kXGIamSmHlpy3HWpq3GJX19z0YCYUWGKaMKcMA6nXu7vZq328GDLTUBNPnURPEvNEeorYuV6KplJ5CPqaXlp4lmPcUg4PL5uTv7zhNkrP7TZ42MgKnlNKc46H4ZzmVp5MNYiNvNCjUpHyoOHba1Otoj9DaUpyMM1iygyUNb6NJb4bzDow3A+exGU2ZwenEOEei5QPUKFUjPc8BSgWi/NZOKI0N0XEJO+53TmM8aNoJeXS3ZhJ15y47Z2xMK8Db6ulWAYDSs5iOo88LXlHQtfjRuk3YOrcRHfp8dtYA/WFjURWdEFykN033TknI1B2QpJ0Kp0enoXGSVIOdiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWNmrt0t9MsqunSDnFBnnV6Z4NlkYfxwEAZer8SD/Mo=;
 b=CLUZt0z8RKpkk7LTOC5YMrIuLTbB7/gtGctKb2rPeLHBBiGC5kd1IPejX4TzOzXgHDskLvuu/blMsaD6/VY4wqz+I67wjDn+ncGmAnK0JhHTOPlIU+qdmfRHRiNNUFM/fSNBqNdApBzCcHF1pnwy8vtxipiDH8R3aXUbYBqrqGI=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:32 +0000
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
Subject: [PATCH 14/17] dmaengine: dw-edma: Reset LL state after terminate and abort
Date: Tue, 16 Jun 2026 00:41:08 +0900
Message-ID: <20260615154111.2174161-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 462f6ccc-e3e9-443d-a27e-08decaf49325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jdSmrhPcgcF9q8pkj2dDNHPDgnHOlVx+6boWrxtevdTVlSxry6c2Qppe/bHkABYoieuIFQf0BK75cpE3iMSzfzoK7XwrdxfGZx02jco8RH4pMdNx5yCVSEGprftF8bGM9i8L+0HxPRoI/73Oaj1sr+LJfHG4Keqd9bt/eFw0oZkNaiYH1IbXp+A0wIJ0wKESr8cj0JWrgknj/UaaPHGpBdGpRGZQwsx0vdz0QHmDyCCjfyEVslIUFTPkByuBbpo0CPiAMcgwp1aAAQcV9Ussj/sjU237h45TXTYTqayCPuZu82bFqA68l8mI9bOoEof/UOvfYjF3ig2GEXwVuWAm8ibQ+PAWmHHQJg3GqsDLSG9QoZKan02M7uL8zLz3kdFF+bEXg66eUxxSTRe6VfkkzzDND/aSM2KM1rILefeUMiRHumMKVYLQUjXxPlvEhdEtckfxMMXxazQ5u7ak1UaFQ5n/JtZqi40ifboxgsM52STijRkCeCd5EfHWSk6G6M37I/EXtesQUQsR+rnDqKLwoMDqfSHhrWuGx6IhRkp6KPvAlr7Sre+BTfejZVfZfm/+0DP65pG18RVNrlCNilSlqqhtefUCIUs0IO6iahIIO/sczGcJFHJT+VxBGeCXvSBsfQh8LdUEozhRQJGPNuQWKZsj47xTDkC70H4z4EqSaLkbQB8mI/S7EjcR4vgcAIWOF8CJaOMWZIzFVdTua1y+sNKeSndEaqACnU9DiKf9fxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6BgLAzAgG5VfKrwmJM9zysc+s/xgQipY6T3WNVZd5Nejx+z6ebmV4BnRdJv?=
 =?us-ascii?Q?3E5NcJGThMuUxcsJhrMakj2zWyO85+fq+rKRfCEVpNrrQ9YhxmlJK8+vyc4i?=
 =?us-ascii?Q?6VFeEmPR+Brfga/Iz6iNORwcPkgFrrYuzyChabKWAsjyrtvTSUb5RgiMn9YP?=
 =?us-ascii?Q?4VngXsfdlbEErconP9NK7bjdPBWpwikoWTY8E82Zl5caJ1FKLSnhKoB9hLHe?=
 =?us-ascii?Q?PSroKtnTMIokG08zYhgLqRRPPh74LXK6NhaAQ8Gc9h4Hut4kFl05sxlZDnfY?=
 =?us-ascii?Q?QN3gxylv5XxtgVGEhbxkreknl6O7Yi3BB2OdMJfVWNyVSBGx0kPC+7V84hNP?=
 =?us-ascii?Q?bCOaENVngQDY348fGh2xBgfFQk0VsluahyTxBndVlk8S6kMTSJ6fL62SAlXL?=
 =?us-ascii?Q?0qpclVfANMw7319TSmnzR+tsFo4O7SfYCYCTR7iEIKBx/Y6JFbWXlHlktSbp?=
 =?us-ascii?Q?59XeBQDi22Ywg82ylqHw3Hz1r+lWGhcsY11TzOeBOy3/UFPk6DTJnpBNGder?=
 =?us-ascii?Q?FCfED9CN8uCd2uSMQYBSQOdWQP3k16llH7gk385Iewua9Tdv56WdOJNtbAP9?=
 =?us-ascii?Q?DQdXeBgbYRg7JtXVdy/MhI/0vHk/I6lpKzaH9fjYVvByjp/t9fbdvECvX7l1?=
 =?us-ascii?Q?Q16SNF0T1k6EHLNYlzE3WIDA7euYP/qcG2EXJV24geZLqV+XSHL2EK9nmGIf?=
 =?us-ascii?Q?DrA1Y64eEwF1EWUZI0g3mPusXyUYSQpGiaNi8addY+bMxI0bsYPRtXAUUaJw?=
 =?us-ascii?Q?FcTrSGDaKbvTh4pgqqySdqtrGji0hVi6Uu+4O3bX1AcPs0wZuThgLVk9r5nU?=
 =?us-ascii?Q?8w6Kgmvza4d/9lTZJB2RpMs1v4IoRQheIy7w+do6AYu+7WsaEgedHRlTF6kj?=
 =?us-ascii?Q?DYY3G2XwN26Yu9EygSLegtXUFKVYbmBV7VAUgUsfFbbVrE1MzLDGuKfBvZdK?=
 =?us-ascii?Q?MD8vE1gh2fLfPs30eyLBBKGM1Fs6Fv7cVRkui7S8HB3u9XGcY/kkelTi8saw?=
 =?us-ascii?Q?XIgzJI7CMFInpsWmlv9V1YDytsC5eSA+TpeXysvd4ob0Nfym2tdSnT1D5IIz?=
 =?us-ascii?Q?eYYZ5xAtt8tVB0ybbfXE7mESE4ypdQKAYVW3oht6Y8SS6a9wl7lKRObOt++t?=
 =?us-ascii?Q?BVM77O37sNwrd4PpyyTQ0ko5WF/RauA0Azqd33P4payUmXyPCzF7DUf9edBw?=
 =?us-ascii?Q?jjsGOyHZwyYer+Q9pTF+KNavQ3KMj4nq3Hu4m0IRpfRGKj7P/ZSmyLGfn3O3?=
 =?us-ascii?Q?31ywCHrwtw07tnpBOnwYPT04tcrpU6As/dyL0vrlv+sW98RfkSFHqFSxFDYz?=
 =?us-ascii?Q?B9h/RDpOpJ6X+/of1zZ8O03CVwIXwwI3s1P79dsSzFmZoWyBqgc6ROeqvIjD?=
 =?us-ascii?Q?GFXKCqHLdZx+XE2x3OBTBIX2eWxkRQ9SiGA9GoyRYKbUE4toJIdV1noao3DT?=
 =?us-ascii?Q?VFlz11xAnPYfSm5C01KDxSBMC4GpBES76zusECLVmJtAKeYJgwJeyzo/vWmD?=
 =?us-ascii?Q?3q1r21BeYBLGtuH+Q5DzQxY0ydOKeSzJFSiplAoP0x03lgqf35assJ3hvwcs?=
 =?us-ascii?Q?AVBpPEs7ryOOJUebjOW87IRuV0MmAv6wspVxt6RiUiXP0/9Ay+HBnr3WjRKG?=
 =?us-ascii?Q?lLrpN2Pf5/RDlijBXq2fO5S8rn/GpepH6TKfeKaEI69sgb6+3K+o+7wr/ULn?=
 =?us-ascii?Q?CLoh/n2qPaC1FE6HxaqD5+MzHniHcrl0JabhacTzaQ2NOamURIHgrQEmmUqD?=
 =?us-ascii?Q?bIUvI63zk+xu2af1nMPHfn+rmXaeNWCz8jjuZSqfiPjA8/4WstN5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f6ccc-e3e9-443d-a27e-08decaf49325
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:32.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfyBSENabPjffwlVPX5iFrHvxSLoKROdrz+QMCDE3QLRBWnD79WtmhJanR8JEFGfJkgSwUBOlEvC9ol6hFChzA==
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
	TAGGED_FROM(0.00)[bounces-11536-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A2C8687D53

Termination or abort can leave appended entries in the circular LL ring.
Reset the LL state before the channel is reused, so the next transfer
starts from a clean ring instead of stale producer state or old LL
entries.

Since this now resets the hardware-visible LL ring, terminate_all() must
base the decision on the hardware channel state, not only on the
driver's software status. If the channel is still running, defer the
reset to STOP acknowledgment. If the hardware has already stopped, no
later interrupt will acknowledge a pending STOP or PAUSE request, so
clean up immediately.

Once STOP has been requested, do not recycle LL progress as successful
completion. Move pending descriptors to the terminated list without
callbacks and deconfigure the channel. For abort interrupts, complete
all issued descriptors with DMA_TRANS_ABORTED, reset the LL state, and
leave the channel configured for reuse.

Also handle STOP and PAUSE acknowledgments even if the issued list has
already become empty.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 60 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index ae38ff0a8b83..4036adafedfa 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -397,34 +397,33 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
-	int err = 0;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured) {
 		dw_edma_terminate_all_descs(chan);
-	} else if (chan->status == EDMA_ST_PAUSE) {
-		dw_edma_terminate_all_descs(chan);
-		chan->status = EDMA_ST_IDLE;
-		chan->configured = false;
-	} else if (chan->status == EDMA_ST_IDLE) {
-		dw_edma_terminate_all_descs(chan);
-		chan->configured = false;
-	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
+	} else if (dw_edma_core_ch_status(chan) == DMA_IN_PROGRESS) {
+		/*
+		 * Defer the cleanup to the STOP interrupt. This also keeps a
+		 * pending STOP request idempotent and promotes a pending
+		 * PAUSE request to STOP.
+		 */
+		chan->request = EDMA_REQ_STOP;
+	} else {
 		/*
-		 * The channel is in a false BUSY state, probably didn't
-		 * receive or lost an interrupt
+		 * The channel is not running from the hardware point of view:
+		 * it has either never started or already stopped. No later
+		 * interrupt will clean up descriptors for us, nor can it
+		 * acknowledge a pending STOP or PAUSE request.
 		 */
 		dw_edma_terminate_all_descs(chan);
+		dw_edma_core_reset_ll(chan);
+		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 		chan->configured = false;
-	} else if (chan->request > EDMA_REQ_PAUSE) {
-		err = -EPERM;
-	} else {
-		chan->request = EDMA_REQ_STOP;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-	return err;
+	return 0;
 }
 
 static void dw_edma_device_issue_pending(struct dma_chan *dchan)
@@ -713,11 +712,11 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	idx = dw_edma_core_ll_cur_idx(chan);
-	dw_edma_ll_recycle(chan, idx);
-	vd = vchan_next_desc(&chan->vc);
 
 	switch (chan->request) {
 	case EDMA_REQ_NONE:
+		dw_edma_ll_recycle(chan, idx);
+		vd = vchan_next_desc(&chan->vc);
 		if (vd) {
 			desc = vd2dw_edma_desc(vd);
 			if (desc->start_burst >= desc->nburst) {
@@ -738,18 +737,17 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		break;
 
 	case EDMA_REQ_STOP:
-		if (vd) {
-			dw_edma_terminate_all_descs(chan);
-			chan->request = EDMA_REQ_NONE;
-			chan->status = EDMA_ST_IDLE;
-		}
+		dw_edma_terminate_all_descs(chan);
+		dw_edma_core_reset_ll(chan);
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_IDLE;
+		chan->configured = false;
 		break;
 
 	case EDMA_REQ_PAUSE:
-		if (vd) {
-			chan->request = EDMA_REQ_NONE;
-			chan->status = EDMA_ST_PAUSE;
-		}
+		dw_edma_ll_recycle(chan, idx);
+		chan->request = EDMA_REQ_NONE;
+		chan->status = EDMA_ST_PAUSE;
 		break;
 
 	default:
@@ -777,19 +775,19 @@ static void dw_edma_progress_interrupt(struct dw_edma_chan *chan)
 
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
-	struct virt_dma_desc *vd;
+	struct virt_dma_desc *vd, *_vd;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	vd = vchan_next_desc(&chan->vc);
-	if (vd) {
+	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
 		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
 	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	dw_edma_core_reset_ll(chan);
 	chan->request = EDMA_REQ_NONE;
 	chan->status = EDMA_ST_IDLE;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
 static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
-- 
2.51.0



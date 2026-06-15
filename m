Return-Path: <dmaengine+bounces-11528-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHo/EKYeMGphOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11528-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:47:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE73687DCB
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:47:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=huszM2+M;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11528-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11528-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2D56307C7E5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176E407CF2;
	Mon, 15 Jun 2026 15:41:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD6407596;
	Mon, 15 Jun 2026 15:41:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538095; cv=fail; b=GkfYmteFxIdc5DthUeWxrr9pPLv1w2kq1mHBaD1vtrGFZHKYX+DkTjDPqZ3K2kujhGsniey7pZzXro3tlUI8KboC8YbF+N9c+qlSg7tG0+D6MgwooQCDQE6ZRP4tLQZAJsNRctfSnS/76VUWyhzSugW7ERohiSXDxCpX8UOgOnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538095; c=relaxed/simple;
	bh=WYlnvwzYsw0XhGH5win62zl7fhHEeqpZQoO/lH2MXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAdIbf3kJvZed74DyuMOfYn6JPp6VDnHC8CU/jqhsFN9+uxGcL2LaQFT0Pr7tjeGciGbB8ycthI+k7OqQaP2kvpu40CLZg+qLQXrEY+D05O1g/r7j2O7Eq8g8jFq+VKzTDuY07JPsz6/V2x1G02Aohd/RviW17arb7+3RuD4IYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=huszM2+M; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA2Ydtkv0kCKKR9aaVprZl3+Akx1Prf6p31VoGMQDVayyouoYw17+zjOPJaZzDWek8wYPDVkEdg1HrEFNI3j1+v2Hi7bXFdHKqB7Bm6ESgWrWatuLPmqtccTiLLsUBLsjfYFar6IHrPvvv5h9mjU+FKLvCr7Pimtx2Oo4/jkYDuwwtoXpbTr2FqMLfVEpcsod+42bN43R+ZJ50ph8M/7Tv9qjuRhHlypSti7h87kP61Bflcz9OxAoey9RXS8leoSmYbn/QGeDMuvTqa1V1+hwwj1Ze/DQFfG4Dzc36kQoJgXbaEjuQnxcBs6W+7c8tpbO80srngcyHz0Jx2WRN7WYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuOsSDsUx11TYy3/3bfV+Ig6YJnG/RfHj4j9u2SEgN8=;
 b=IWGys2iex/IwUtQNDd7wdtngmvuEn+z2Cw3a6JoLxUp076VyS32vaK8ANSkUtB2mt8Nrzhthi6z1kgg13OcBHsvGlNt1vLMHoUqTg5oUNai7uX2/heQ1X1/h0EyCKvCyo5pefBnisdEUbci5LzSg5CU+XyRxRfLp2itbQM96fmfWG8IDAAw6pIf+Pa5zXt5BryOOeS/kJvg7MXht6Mbnusj3Vnq3aTIJbXXUmJR0qvvYlZymCYmEctdftIxsKzhV+nKjGEFAP+hlGhc3eksALnuqwNQTCykqAeiRU00JG0nBLeCkjc6NBotUb+u/wMPLVNOX4oidwjGgiGycBdxi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuOsSDsUx11TYy3/3bfV+Ig6YJnG/RfHj4j9u2SEgN8=;
 b=huszM2+MCXqtiDEJlwIEGP+75sDFBvZVHZkhDWIVn0njEyeQlNNc8GC+Dcri0KMLjR8/y9knfi8czCg1SgVZeFxtfTIlbJPE0RVPAMFl2SkcQ3CopL5FVxa26XGAlC0S/IoUjAHuKmnLYBXSJ09J0QDKxK7iGWrnoxZoHPQOKMU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:26 +0000
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
Subject: [PATCH 06/17] dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx() to get current LL entry index
Date: Tue, 16 Jun 2026 00:41:00 +0900
Message-ID: <20260615154111.2174161-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0113.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ae0ec0-b278-45fa-803e-08decaf48f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	MNB6kGxD8bZEvqtwYdIZO26VkA/KdNxqkb1d4pYFRUe9OZ7lDj3TjrY/yIzm4PO7p/29BeLp5wIILcmQllMrVoFIr0OLu0rrgGBb36XuH9cQF2OuWmIZ5x9ms92SsN/QFwDdJOtiAVr6Ygn0nfGXLxR+B0hfAHmxSfgyyLf/NAIra4xicJdtNPr5RSqzaGIRnKdA0a9NODq5EMukuitKKfhdJ8W5SgEjQzD82k5Mua7+6d3D61lOD1hjIGxciLMKJRHaf3VRvI4bvniq53TsNn8IEmpwfkXFA5xA7RLIEx3tq4mPPCUQeCUvIHpq1TKTmBP26uQEjTKYAEL52YLDLMNGLDLvYKHb2MVGLbaoNqMWX8DNezTLX4G6MeY1hnQa9i/Y5MjHmhPYy5nXc8u+Lh206W114yhQId42HSvrHZNxpvf+NE1rXwj6KOhXfofh/K2bk9j2pZJfbaAuCJdybnBNOGkrhjG9tgDSFxuBr+2wruHPRMPbCWdLJIsE51r8KtD04ABQCQwTSPRh7/0zbWi2f3KupCbWUmLU2Q56M9ZlWEscvgUeCdBrAI4Yz/RmQAYquY6YLSUh8/9oQma9GQHQFP1lIBkZt34rkOj6EUW2TTVUVio7PJwKMDuaWafhwcl999B87/sdrCK1RUG8GZpI4jivIJrpBRQmMl6KnN64oVtYp2bYAn7GYJOPJ8M6uFWgB57U0LJjCUexkDxCUYjYf7itcOcxIcqqE+Hp6xzB7aW19zwfXm5M6iURy7lG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wuvwTNfIgQNakozxZyulFlDNuMJJAGh0DcnhMxZLBD26Hp1zEol/bTueeBKF?=
 =?us-ascii?Q?Rpi8Y7hpK9F/ZT/GbhcRdgmv+9q+eYTuMRoQcx381OKqpwEUHIz0QRzEETlm?=
 =?us-ascii?Q?0NTA/toK597YnQeqbnFfUbwQewoWuHkmIbEeiFa9WRNIM/h55liwJ4/4fRPV?=
 =?us-ascii?Q?UnmB3Sk4a5U5BdqIWB1IJFiAbrQOLWV/uFtSEBMIlKEt3qskv8wxgDVSZ+da?=
 =?us-ascii?Q?l7ew/90Jexks/G4N8D+qcrroH9B7/xGCqDqdcT5I5/kaf5TDWvwQt/iVgibd?=
 =?us-ascii?Q?aqAdg2r3uKlqYb+4TjLiP6WXo/ct7gSQvlGHZncjiO0eLcPtQMps0v2l00Bb?=
 =?us-ascii?Q?UhygJlP7esIdvATTGNxOVOSXBbdDoK0jTU2P3R7vDVYRjhFXC6KsX3KMbZ2E?=
 =?us-ascii?Q?x/y7K2KylY1LNSLRIgarwZxWW9H9bfHb8i3ZiwDdC+VgtHGrxA7IGnCzcJz2?=
 =?us-ascii?Q?PvP1pSCb0w8oK/8K//IiPCTC76Ape957SkuDr/PLsFxgKGaGj0f9dEcMMoy2?=
 =?us-ascii?Q?Il6/7/DzOwySj0MuweMs5xQWkwdSdeCb79TWkD/ErJbO3Xn+2m8gvzfICHGU?=
 =?us-ascii?Q?lbUap0QFvMH+6gwPavThS7NgsZCUioM2WpgUHK/OBpaPxoNbypuEmPorYvfB?=
 =?us-ascii?Q?C+e9dlUqmUvqDnd2EJmlCxlYc1spNUQCy1k24hWVxXPtou032wuAShHyAP/1?=
 =?us-ascii?Q?DYZXbo1AZD5OFS4xkZXUr8VTBi1r1ImR2szUrOLXOXim5gQqMoZbAEOxh7YR?=
 =?us-ascii?Q?q/FZCnTqGySK2KW8bo8HozDwwfDJJSxA6Y8dqyhtZELQLn4Xoc8wUY8SxlSM?=
 =?us-ascii?Q?GF1trK3zf/N2md6Nm+SN9rFs/OWZ7XhVx9TEmql47z2lFAtBNoOEsjxaWXiK?=
 =?us-ascii?Q?EL3JW2v4lM23OC17qhwW1fGPKE5ytOfr9XHzF8FcYtjULsv5T7P3cpSCSbsh?=
 =?us-ascii?Q?cDkJbLXfORh3eKq8RYOapXfM3WExqu/7BN0J38Thuzsbuy0CwnbDJqIyWZtu?=
 =?us-ascii?Q?QgxDEr0KxsAPrEneOX+PWI7Xc0t/vZ0W9IqsE901m/rizY8+do4N6fmbDEbD?=
 =?us-ascii?Q?o2NBL89Yq/3tvfQdsK2va9T48tO7fcwrmDNqRxokph+SFuFu8UdNj5t68GF1?=
 =?us-ascii?Q?nzfZ3L3UzNxahZZlJWtJc6Bgt8J81dR0uinCc3WOT7e7+j6xDun2dcXzacbL?=
 =?us-ascii?Q?kLsWKUclnAXmBzwSpOkkxbxIZ/78Fmiosv5oKuWivk5RKl7CsQ56AZoHahrO?=
 =?us-ascii?Q?Sa0UG6OmFT1waBfv3FGl2400p7+u94zr8HXxh7IBh3tYR+XBAFlo2HRPxbDT?=
 =?us-ascii?Q?aVh4NYdwlCAtYy1BcXm2MEq1wkLBjMS44x2limHllOeON0wQ8ie27cY6pnk0?=
 =?us-ascii?Q?saSvtwjlG1h4OkLN6wCZTIMqosovjlTjfigSCam69OZuQKRc9KfXAebsq1wD?=
 =?us-ascii?Q?hPCh3nLbYQ2RBm2oJ8gSD/KSHeHCjuaBU35V3wO+Q6wrQORwcOuC/9WVdLDF?=
 =?us-ascii?Q?kz2UuP2tNdNc7g4Z3DoHNyjig/zzs8QjBAUhkQvT8JKcU2J9wymNRWoWp+R5?=
 =?us-ascii?Q?aikL6coMfFXzlAJr8Aq78oRYxL/4fYm+7MUqafQrJrBAR23qAUeQ+/p2tWQt?=
 =?us-ascii?Q?p9rIYkqKo7VQkELPywogYx2+mfHd270L5Hx+FvYK8XusUJaagEKPhMvnXiLY?=
 =?us-ascii?Q?8U5bx+XMSUoyzKY5Yui2P98S4oURUbPZSkJVHF1KYLJqjUUwrjx9bA7kTXK7?=
 =?us-ascii?Q?dD3cPP0ix0khy8u7Ihlo24WrhIkdbbg2sNSeoOeeMrU49Wh5Q+RK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ae0ec0-b278-45fa-803e-08decaf48f9f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:26.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjKbkNDFrEa4E7zgV8LxjaVvOuZOCxiV1tBh7YsWHUukvcTr9BmVV4RakUcDaOXAV3Im5NazBtNXmpKASIW61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11528-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADE73687DCB

From: Frank Li <Frank.Li@nxp.com>

Add dw_edma_core_ll_cur_idx() to get the current LL entry index and
prepare for dynamic addition of DMA requests while the DMA engine is
running.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Unchanged from the original submission from Frank:
https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-1-9a98c9c98536@nxp.com/
except one trivial typo fix in the commit message (s/dymatic/dynamic/)
and commit title/message updates.

 drivers/dma/dw-edma/dw-edma-core.h    | 10 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 31039eb85079..d68c4592c617 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -123,6 +123,7 @@ struct dw_edma_core_ops {
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	int (*ll_cur_idx)(struct dw_edma_chan *chan);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
 	void (*ch_config)(struct dw_edma_chan *chan);
@@ -164,6 +165,15 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+/*
+ * Get current DMA running idx.
+ * < 0 means channel have not initialized or hardware reset by PCI link lost
+ */
+static inline int dw_edma_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	return chan->dw->core->ll_cur_idx(chan);
+}
+
 static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
 {
 	if (chan->dir == EDMA_DIR_WRITE)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 7b4591f984ad..edc71a4dbc79 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -504,6 +504,22 @@ static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
+static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	u64 paddr;
+	u32 val;
+
+	/* LL region never cross 4G memory boundary, so only check low 32bit */
+	val = GET_CH_32(chan->dw, chan->dir, chan->id, llp.lsb);
+	paddr = dw_edma_core_get_ll_paddr(chan);
+
+	/* DMA have not setup or DMA engine reset because PCIe link lost */
+	if (!val)
+		return -EINVAL;
+
+	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -517,6 +533,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
+	.ll_cur_idx = dw_edma_v0_core_ll_cur_idx,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
 	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 862375c8e4ba..677416f422ff 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -285,6 +285,22 @@ static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static int dw_hdma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	u64 paddr;
+	u32 val;
+
+	/* LL region never cross 4G memory boundary, so only check low 32bit */
+	val = GET_CH_32(chan->dw, chan->dir, chan->id, llp.lsb);
+	paddr = dw_edma_core_get_ll_paddr(chan);
+
+	/* DMA have not setup or DMA engine reset because PCIe link lost */
+	if (!val)
+		return -EINVAL;
+
+	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -298,6 +314,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
+	.ll_cur_idx = dw_hdma_v0_core_ll_cur_idx,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
 	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
-- 
2.51.0



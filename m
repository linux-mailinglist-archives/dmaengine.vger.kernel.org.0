Return-Path: <dmaengine+bounces-11530-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WejbHqsdMGrFNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11530-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:43:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF81687D11
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=PFUW8PAJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11530-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11530-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C69E93026E76
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B8408616;
	Mon, 15 Jun 2026 15:41:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0D407CF7;
	Mon, 15 Jun 2026 15:41:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538097; cv=fail; b=PYgZKkGck0f8XJym7fGM/w4UN2+tZELtv9SRvXoDV5LCSlIC9GrE1T0NtILucdcRwWQ3WmGj9C1k+2PzU3aIY695EfIDeZihQ3rVs1HfACnkRXaf4GqeK51k0b7mFucbQP1pq27uiAwpJeu0a4fdduluTyGC3SeaQjgHAQlsEws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538097; c=relaxed/simple;
	bh=I6/amgiln69fOCISQeaYGTJXiADofTO7Sge9Go2XFY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvfxajJr1cRyptDvVEkbI0sG9lbEbrruVHeQ9COk0wTvBn4hPyXCIXzIDcrScRZmW64QH3wuBJVW+CsoqobjteP4AER8WXBYLbQ/1vdFBXHI7P1MVGzpY+wB0kUr7MReTLwYwKbJfWX5TXp/8/CW3fqjHJ6scNlEumTGS49Tnyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PFUW8PAJ; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNgUSaDsd8M/phjlv234icKp4mbZFW9IdhqnllvCVdA31jbYlNkMPdxm2Yh7ZT2fsGQGApnm3dRotoVhX7JvNLwN/rm6QeGYkVOFCzjh4Tw7IdQOzDMVEdwsKEVaouvBzKorqS+1ZOXOZZz+GvYqHo67XOsaqr1IhZH0kOzlVbDz/ZB7twwsGD2mlsb/C+pumt0SjnGru+SDXKE0L45ZtcwmGN4ORaQtyQS8+EbKAw5mXFmOdRevdeoT8CJ7ud8npOukPs6KeF1oeTxtqzd5lNZHwRTOpUyDgrEwcMCE0E6Or50EUf+ZN3tWqtHIlGgkPkXqmkd1oZ4x4CqQ0cLYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec/+hAnKHdYDOs00RNoSAX1zt7u32Ipm4e1owPtxs9Y=;
 b=JHM+OJb8RQ5XrFO4D6UnPsTlu/vbPrdKsXVDfLPgcsNOykUaJcW1VZ6rZDlkPn0wVi3WAXJzflYaiFrrH3IJY8kLxxuQJ5He2d6+jsW+BaOIC/3tdrMYY/r/itm+GNw9sWg06/25OjfR/s2JKVrkwQniE0muV2QRhKB+NS7tKlCHAJUsmuBvbs1bpOCmPvI60koO/MywTHkrYXok+RvRY1z6UWJhofBK5GktmSULsurvfKoTGfug3eXqPtlABBW8vBQJL+EifMlon3ArDe9zHX5k6m4SXS5AjF9raaP/qyRzmh+FngoYXRl+py9ZeRXUp4e7AgM3yY87AUyM4OXchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec/+hAnKHdYDOs00RNoSAX1zt7u32Ipm4e1owPtxs9Y=;
 b=PFUW8PAJseuvgFxihNaLXJUGIodztinSLPrHSe+rBlWSHm+YAeHv67oFClqH7BBWlTzw9/Jjgx3C6uXj9kv5xYtzvJoOz3aNarFIoe0AIpHFV22wGVd+HD9sv2Pw1Z5DmEyFC2gjLZW4bMdaZuill7Bd/OhBh7bJ6n1dI48fIG4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:28 +0000
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
Subject: [PATCH 09/17] dmaengine: dw-edma: Add LL interrupt placement policy
Date: Tue, 16 Jun 2026 00:41:03 +0900
Message-ID: <20260615154111.2174161-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c61612d-735d-482c-e769-08decaf490fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	54GzFFIsDohCLi/iD8AfqtIDXis8IT5oR0WvASWKKlxBAS9+NHazGjUCr0VCs/0IPQzWSsr95l/HAfp2wAAYCVwO1qtgmDWRr9v+t4LVza5Vv5QRM05E6ieqfcszqkGAVzpsnHOhg3nVxSxnnMvJX+jzfdAU/pWUdHtFNnXmLrzceEYmg4F3TJdo7+WfikLGRK9D0M2HicgAWYVnWW+7pia0boYetYxrrw10YqMmlyp9XN7oNb3/pGG56CaJm/dfTN3PuEwg7oyJKOMD2ESNm6SFAETRwcQVZ3+F7NcRLdO0zQJZIP0r/a3ajyMbzKZKyjjbHhnd25F4wBWmA3U+gG0jce+sCTYGSjpdE45+jA2jzuLT2NJl/Zh2pJcjKsCo79/ofo2wfLmlyH14lNQ+0nVwkKBxENKNbvRGXRGmv23o4cWINiZbCAbtWoKBLAGVixv/KovD6ebm7qO4+DOKsukbuXVZHemgquYD/ZNrD2NX4UH7BkogNwhGNwPS3X14lMQ6vpgQwLeQDhbLihcxQoOe80Dgd+IZLDukBR46ihtSLiTbDfdXGihyA5TEVDmpB09LTDJc5RkTMAWWz3EOFwSbftSLblnyL2UOUemi1eTxAvAJJGtRmvaYAkKi3CPjEDsiseetCsC2zaqSm77cRJN2MZ0btgUliRpAGubeQya1/lPKvwP0gWpu7QJfkc6Di2ydju8K9LgGBz/clxyLcueZcxWWh69jhCcz9bNpIr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2mC/zmKBrqwnCK+hhgvp6fslpXh6KyPRkEHMO41YJ1vbTEC18GGHxxHqm0M?=
 =?us-ascii?Q?twPXUHHGSaDG8ZaYZoFunQQGMIFToKVqH7HmFxmhagehb6oRBBChjcHswZtm?=
 =?us-ascii?Q?WhrKwsya+GHawKza3FZQx4AlZ4GiP6Squ5vbKneGGFPul8iDvJGnKXBjOuY6?=
 =?us-ascii?Q?JVBQYzSMyvyQ00Rw1I7OrG//GPqGbFjrqy7kwQ5E8QXF0rTWSQHDH1qq1xoU?=
 =?us-ascii?Q?aGyJs4DktZg4iNqOJBwngPnKi9gfz8LVvw8JI9q1JwNqX24EUu0au7XqLnAD?=
 =?us-ascii?Q?1Js12INmOkTda+rZr/+W8DTlEucy/E8TzWeUfoDicE2aMG1JBmuHQqfd+h+Q?=
 =?us-ascii?Q?I44NS7MnDtC573YSP0AjLsUSFHX8CmG+es+xEoGU95GWAkHhRqoDn79vd85H?=
 =?us-ascii?Q?BMWy86TxxAVOLe1Hk1nE/GHTuDEXa2kg7mNk9zUT/VodTFessLZdKexKrYov?=
 =?us-ascii?Q?nVN5HJzTazGBmHGIi5iEa6rhzQ7ldkaP04j3Xb+COiAFv7yipKP5hSJWLGRy?=
 =?us-ascii?Q?n5qSlLrfSSJ0UvNlmxZ2rcA2MES1jpCmKqOFwbkXzz5uh7sbOmKadQfZjdu7?=
 =?us-ascii?Q?ErZjR115kpKIFKKi0/vpYp/VoAhcFfbHoe8thgo0e74Uu5uoMzce6Ww8ReHs?=
 =?us-ascii?Q?5UBLBrx1zEdsbzeYS3xNNzSoAkibztrQfYAUQsBEyBUbW/0SXY8EAhEpCzoO?=
 =?us-ascii?Q?v1brwzPi9F/PSSRv3W244sGFlmE4CMG/FDJVEn35JOoJ1a/bGaUw2m8434dE?=
 =?us-ascii?Q?znFzqMUGi8tDAMKP9CTz/LnhsyvCElmx0TpdOMWSAv3+O+nRt38IcTVaAsKY?=
 =?us-ascii?Q?hVI7L1ILUikuI93ApcX6oHxQluCO0Dlk/N7AMrjcMN1hBm6OwzFP0B+Ym1v5?=
 =?us-ascii?Q?lMZiy4naQneFfjzfcuszuVqmvE+ORY9eFM7sxf7AnA6/yt1y83KthsjdJbGP?=
 =?us-ascii?Q?rh9dnSZfBr70DWw/ZXij7jdRHMCtNnSADVc3zThYlC+v9whtZS3tqckDaHeQ?=
 =?us-ascii?Q?FXdSq94WYT/1pFj5cEF7A+UFt8q56NgWf8VCAmh/IPJNbB/nzLy8VY7bxxdL?=
 =?us-ascii?Q?IEPbhMVMYS8cXYDw6R+kkqB4XZYK7C4FA6s7GXpBejSeoK4AglxE7IbgmWpv?=
 =?us-ascii?Q?jxW2Pn+7ACno+htKOCk7gE+C3HxPLBRemtV1dzYsJJl3PhXFueiMdzK6cR3W?=
 =?us-ascii?Q?NvXn0z4ajmd1VX3MxqgLMC7fv32VkO1h9edh8N/h3nWBsnmQjfqSoOq11+qZ?=
 =?us-ascii?Q?LLzxo9qyWwqUUfdACO1qvIm7gc16E4K8G3+lo/X3QxuZyv/DPPbbK7P0ChMv?=
 =?us-ascii?Q?xnryArnh3s26xATUC2juDlUDTfPcCv2LgMtV4pISGXItdVZfw4h2jR2XuBv5?=
 =?us-ascii?Q?Y/n96jnCoHL/CQrmIWsdElkPTuCOg7wcXX58bLT3lyUgfQjkadW4gPr4x35n?=
 =?us-ascii?Q?FcnTxueo+g5RWQYYgu+Yc6E3Hl1i8W/q/k2N8U4An+BwW5YauIrQbu7MAyP6?=
 =?us-ascii?Q?lxvcb9JUB85ULLJyRF1V/yFC+DzUKV3rO9lggwlE9ofU04Fs1pReTJQ01B2o?=
 =?us-ascii?Q?xAnoXRfey5kjddU2EpF78yYNaBxJ1bSLL4yqIM6IDjuDx17+2DOohuu/wKT0?=
 =?us-ascii?Q?aZ+IPdxIJcbnuq3Oz8fsIM1yQ3NPb5OY3JewhEZAZQ3512J4uxJeokCiGUQ6?=
 =?us-ascii?Q?xFDkt1GVM7bvmO7a2YwHPg1qPgUNrZYtIOKF6+zKfVtUwmXWosL0sDiGrkur?=
 =?us-ascii?Q?OFqwRzLEHVGEhMrPjDnAhlJJjFmIOu+jgLe75u4DJquprRkNb2hb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c61612d-735d-482c-e769-08decaf490fd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:28.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxsUAQ6/JuRqYznSDkeLVXKk6LKwxlCLjoclttEjWlr5mkA9uR5Gb9v/sDx1DhTPYzamxbHq75qwEFb63lZ2bQ==
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
	TAGGED_FROM(0.00)[bounces-11530-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 1BF81687D11

Move the linked-list (LL) interrupt placement decision behind a core
callback so eDMA and HDMA can use different policies.

Keep eDMA interrupts at descriptor ends and at the last free slot,
matching its existing DONE interrupt semantics.

For HDMA, use watermark placement as producer-consumer progress points.
Keep descriptor-end and the last data entry before the link element
unconditional: descriptor-end gives completion accounting a progress
point even for a single descriptor, while the last data entry provides
an end-of-lap producer-consumer checkpoint.

Add fixed-interval watermarks only when the current descriptor cannot
fit in the LL ring, or when another issued descriptor is waiting behind
it.  This keeps low-depth traffic from taking extra watermark interrupts
without making large rings mostly STOP-driven. The interval is a driver
coalescing policy, not a databook-mandated value.

This patch only decides where LL interrupt bits should be set. A later
HDMA patch wires those bits to the hardware watermark interrupt path.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    |  9 ++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 +++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 31 +++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index cac03c59bfe4..2165f2fa5398 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -83,6 +83,12 @@ static u32 dw_edma_core_get_free_num(struct dw_edma_chan *chan)
 		(chan->ll_max - 1);
 }
 
+static bool dw_edma_core_enable_ll_irq(struct dw_edma_desc *desc, u32 i,
+				       u32 free)
+{
+	return desc->chan->dw->core->ll_irq(desc, i, free);
+}
+
 static void dw_edma_core_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -103,10 +109,9 @@ static void dw_edma_core_start(struct dw_edma_desc *desc)
 			dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
 					     chan->ll_region.paddr);
 
-		/* Enable irq for last free entry or last burst */
 		dw_edma_core_ll_data(chan, &desc->burst[i],
 				     chan->ll_head, chan->cb,
-				     i == desc->nburst - 1 || free == 1);
+				     dw_edma_core_enable_ll_irq(desc, i, free));
 
 		chan->ll_head++;
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 46af4ea3ae5f..ea9f4292c40e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -147,6 +147,7 @@ struct dw_edma_core_ops {
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	int (*ll_cur_idx)(struct dw_edma_chan *chan);
+	bool (*ll_irq)(struct dw_edma_desc *desc, u32 i, u32 free);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
 	void (*ch_config)(struct dw_edma_chan *chan);
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index edc71a4dbc79..47faedd14dc2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -520,6 +520,15 @@ static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
 	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
 }
 
+static bool dw_edma_v0_core_ll_irq(struct dw_edma_desc *desc, u32 i, u32 free)
+{
+	/*
+	 * eDMA reports LL interrupts through DONE. Keep them at
+	 * descriptor ends, plus the last free slot to refill the ring.
+	 */
+	return i == desc->nburst - 1 || free == 1;
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -534,6 +543,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ll_cur_idx = dw_edma_v0_core_ll_cur_idx,
+	.ll_irq = dw_edma_v0_core_ll_irq,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
 	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 677416f422ff..b9e193774714 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -13,6 +13,9 @@
 #include "dw-hdma-v0-regs.h"
 #include "dw-hdma-v0-debugfs.h"
 
+/* Empirically chosen; can become debugfs-tunable if needed. */
+#define HDMA_V0_WATERMARK_INTERVAL			4
+
 enum dw_hdma_control {
 	DW_HDMA_V0_CB					= BIT(0),
 	DW_HDMA_V0_TCB					= BIT(1),
@@ -301,6 +304,33 @@ static int dw_hdma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
 	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
 }
 
+static bool dw_hdma_v0_core_ll_irq(struct dw_edma_desc *desc, u32 i, u32 free)
+{
+	struct dw_edma_chan *chan = desc->chan;
+	bool needs_progress;
+
+	/*
+	 * Keep descriptor-end and the last data entry before the link element
+	 * unconditional: descriptor-end gives completion accounting a progress
+	 * point even for a single descriptor, while the last data entry provides
+	 * an end-of-lap producer-consumer checkpoint.
+	 */
+	if (i == desc->nburst - 1 || chan->ll_head == chan->ll_max - 2)
+		return true;
+
+	/*
+	 * Additional fixed-interval watermarks keep large LL rings from becoming
+	 * mostly STOP-driven. They are useful only when there is more work to
+	 * feed or the current descriptor cannot fit in the LL ring without
+	 * progress.
+	 */
+	needs_progress = desc->nburst > chan->ll_max - 2 ||
+			 !list_is_last(&desc->vd.node, &chan->vc.desc_issued);
+
+	return needs_progress && chan->ll_head &&
+	       chan->ll_head % HDMA_V0_WATERMARK_INTERVAL == 0;
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -315,6 +345,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ll_cur_idx = dw_hdma_v0_core_ll_cur_idx,
+	.ll_irq = dw_hdma_v0_core_ll_irq,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
 	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
-- 
2.51.0



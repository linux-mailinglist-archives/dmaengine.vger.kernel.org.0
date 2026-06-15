Return-Path: <dmaengine+bounces-11533-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6vVCHkwfMGr4OAUAu9opvQ
	(envelope-from <dmaengine+bounces-11533-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:50:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DF687E45
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:50:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=h0+lJ9VK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11533-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11533-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6132731480DA
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AA40960E;
	Mon, 15 Jun 2026 15:41:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F07407CFA;
	Mon, 15 Jun 2026 15:41:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538100; cv=fail; b=abzpi82TL8C8sGtVuP4+DUsRWH4NRPCADT44cLB4LZLgUzhM8vIlduY8/exi90EeaoY+VC17a3SfWiQ4ZL+fFgJlbWasdn+MO2WhBhRVC95lLIr/ILZgDzhxPBNWCPSZUgJrDZgbDlKAp4jsT5VXPNOqiqBxgsNnc+VmGaU277k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538100; c=relaxed/simple;
	bh=rYvI7j8nET/SALaqXexDYMaOZaZpPOjPTTw9LkOIfgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yb/zDjIxUWLuP0GZ/XrKWQstn4V4H91wi/dkUHPOdUS9KOsZ5i7wBogZ1S/p5eORCVG5BvGp7VT5exszRMR899Y5OL3GPrMVEhH9Zs8Ndub+BpAabx8S91B2FBJsRzPwUrmdUy5NmozHdOOkh1C/DLXAq1ntTQJn4QwuVX3mj5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=h0+lJ9VK; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNC9V3QdhqOMJiWzqHq3buGaWWkgfXMrO+iGpJgpK9J7J2K3Pq9EjNYGWKUkbq1sXI/pR4eACEpR32z0iuSOXNTDu3nJjjPT5imAxVt6E+DUNE70UOfWXHFuHL0PwS7k5a0//C9mFsqLdKiTh5IMV8qAQIt+Ot8nFzdehuEX7BkoKHaUPJefoT+klHpQ+f0kiM21XILWmR18mVcV/p50oRZnNIThXph74RfkgaSVqeoDTczZYNLvL3Hf6WMMd+N03w1feMTW1Nn11NTZm2rbJgG1cRA1Hgmd7B38/YFctNj0dMSeEKewGSsNzZd4uJGys8hbjdAc3Pe4H3FX1ZVESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOSj+ErIzf7CPvNqscI3XmKXu8FF9JCVrpryWyIEdyw=;
 b=aKr/Ww5aUjJElaJJBwJzen4rbwn/sCogD9Md6EiOha9dvT7ZTPn/z33uLRNNuDESWDhHHmVYkj8YyRWGZqFswLNA1C3joBYubzgA1vuINaEHRj10ILAXGgNXwItHqTOzYXvMERW4GCTzgCmVsyaG2H5E/Jvewqqj2a2qa2LZrfMobKVKT1k0fTf9puF9X7CyveySurHz6lXrY3u7Nz/+KR+GfKNZL46SE49N9xln4no3sXDh2lXWFQZtaJ6AcgRdvAhn+cNcLYgjxwZuRvHfQutMbQDRd1Mv0+dXjpY6+TrIWuY9KHl4fJYnbKD1IpqTdo4uXG5FWK21EUFiC3GHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOSj+ErIzf7CPvNqscI3XmKXu8FF9JCVrpryWyIEdyw=;
 b=h0+lJ9VK/D3kWA4JFrSLrBPNAlp5n3TBDSuCol3Nd228KG8g8Wp9crhrikSBpXYuCAb2QbnCxAaEdd/Bs4Hjawzqzhavpv4rSao/B+b6X5B3aGCFOrKs8R0x8jio2nqdTGPozye/7HpdS1zTqC0ML3lDEkptI0wSNqjovk5ZXb4=
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
Subject: [PATCH 11/17] dmaengine: dw-edma: Use HDMA watermarks as progress events
Date: Tue, 16 Jun 2026 00:41:05 +0900
Message-ID: <20260615154111.2174161-12-den@valinux.co.jp>
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
X-MS-Office365-Filtering-Correlation-Id: 012b6849-85c4-4e72-5188-08decaf491df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5CksNP6QPVDqqR0nOksEtz79k1VD266MugLiGqjyKFrQ0bIj0Wcy7CSBTua6CvWNfXxZYSFD3eAdVWC+mylINLI2DYl55/dAZCsSer3PylpDanzfxcq5K/ugIC8TMi1UEQ864pgnUAkfVD9mn/iYl2EIFjG7lAO4HAkYXyZPokMpwQSLIs9l4+HmTjfEDlIrZPTDvFWUAuNfv+u98sMZSKV2BQWTd5HdV8nki1g20Nvodfj49e+80B69XxB/XgBJ+hZ2Mv6JqbqTBWAKKCYCimG/L1BRvgo/vwhLi7nZabR12wMFfxIjbVwHQfF+TDgMZLXqYtFdkjtfzGujDGtOWiafKkvweJ4CxNU4PcBIsY456kf2bSwObZ7NL7Tl4mW/CDODVmTctpkHy0eYAjOGxU4651eW7Sj1iLmBNqMpIPPREJRP2sV3V2Bel5P0XsTaNS2zTOHwOhrcJr3YIimofc7/+GttT1Io3uFxqNjG3BvnkZ5x8/a19BLKwR/P4Lc/9d0DHWZF/wnrfn8R4GENl+LF0yIRxpMhcUYM1U+sUw/HentRYBFajDJMz09/lzvXz9FoOKGh8hIugNNXxTnjWqMwRuZNSFtbpBQbzAgu5PmUlMmdH2Got7T0D+F+zZkYdHx6n1xvoyX0C39HVr2xgHVAGSCjlYNaqfovVN+w+/yf/CW+NEoBL6PYAtlRY+DqDdNgrLzrhiTp2UWCiI6HSWVBrWWGFtqpNSElTAOnjRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqhIoaKr65HcNg7vy/HPQRxTgqzem7ikh88KHEUYSzwnoRYOHWQLzPvFsx85?=
 =?us-ascii?Q?jFOeinj9u7GfQkoo+TA7DHOWNVWNuJZMxBzxz1Nu9QA5VjvZONO4z9RYGvXV?=
 =?us-ascii?Q?mkFSmJnpAbyOPBpHy6mzJqRMVQICZUdipeolDLp1ZSqba98w0XMYQVlmxdzQ?=
 =?us-ascii?Q?uDsaYWVwbXat/h0vCeoE7G1KQtK8PH/6I4Y20l8hYyp2HxLoW1h7Bey+uLWR?=
 =?us-ascii?Q?gphTYDhxt5khQ5I1VjlDyUlzfWgzuM8nAi9+jfsRrMIzJauHAOXeX8j0Bera?=
 =?us-ascii?Q?vAj2zcJ4l/zwF+RIuDs51NAqYBkGTx8NP0p47mnaBUL/MFpW630rXX7WLuE6?=
 =?us-ascii?Q?EOk+BeVDyjWwX58o89O7XWi7O6lCoGpC5QEvOOlFhb61sYAsDxeF0gaisO07?=
 =?us-ascii?Q?zorvrOOjF8WrTyAhaSmq7D8TItOh7bmrp5WxYkCgiKGPO5ZGYVAZTMw5jGVD?=
 =?us-ascii?Q?5A3EoTdg3OThlL4uVAcb2RmRupcZWi1la8PRX77ePB7GteesGjKFKQYRz57i?=
 =?us-ascii?Q?SbGEjZd14uZWdzZA+iBt+ijcdv7zZvnb3TmDDU+bZMuYbceGm+ppgqxb8qx1?=
 =?us-ascii?Q?ORij63dJP36GIJL4pYXMz2mzyZyLO1OMtqhi78h5ToGmnD/gzt3usPAYhl+3?=
 =?us-ascii?Q?6hppqXwH3mNDciE3qScqmgsoYqaV8MdhOxp17MZfzdC7w9cAWI5vlOS8GGuQ?=
 =?us-ascii?Q?kBcPKGIG0GsjdKCezOsxEyhNl61LLubNPI1WC4wWs6jarN3IX9bcaCCGFESd?=
 =?us-ascii?Q?giqVJvwVkqIgYwZoO5HXGI2hF+nJhTp177/29X7DnFldwNbQWmSo0JJvstKi?=
 =?us-ascii?Q?hcLuz4t3nh9oxYbKIBLwyrIWNEwin8PhVO3iMkHpJfDC+6O3YxZ0w03zYdAb?=
 =?us-ascii?Q?VuwZPO+F56iJs3FjwMIVfB4JAOcu7qld7K9r51YG9cixEhfNjky9HFKUXSjg?=
 =?us-ascii?Q?/3/DasAZh7pN+wyGM9odgbVCtij/39/kMWkiAlSyh5FwOveUZzpPvzIPYhJt?=
 =?us-ascii?Q?0PIYyCmPou70ktg2uIGtO10fOO2iW4cT2thSV9nYCVXBNy70dTOVQvHlyBjG?=
 =?us-ascii?Q?JJOD+5+old8m3y/1CRcNujsdStnbEVoGJDqwM+cOIupYfM5uI/k3C304nbHd?=
 =?us-ascii?Q?41pe3XhC+n4m9yMHjPIdZWFdddr8O+jU50KTzPT4BH24BihBco9MWJh5/FSq?=
 =?us-ascii?Q?07cgq7fmsSDg9wW7DAo9KFLPJ2FRHJSIFDY+RHjZl9XT5NJb47Z6QTIZ+cU9?=
 =?us-ascii?Q?BAh0w2KEgrvYlA3uVPsy0rif26dV7nRfbjQZd8/Sv/TCkk1hlPgcgIsJul3v?=
 =?us-ascii?Q?qsNRFZ0yhawFmRJHwh9ZcjHtrhDCdphk7O1eJa5+Q9t6y96IyJF8C9h0rIXk?=
 =?us-ascii?Q?Hg/61MKQvWcIpjK3PYaSw1iVs10S31OJgJU4mm/XcOxngKMKBVLhG63BIJwQ?=
 =?us-ascii?Q?cunT3LOJMNF7cQmBYmxbItZSXEm+HKoJ41UQU9+YluroGmrm0QfoawTpKJnB?=
 =?us-ascii?Q?4AuxF3Z3I+prHUg2gEhkRKypXFEVQeeFNNKoFTeQ0RiSbNwOUdgJHgM7Y6T4?=
 =?us-ascii?Q?o9U+mZT1s8QtcTmj/0NSkTtElJlXShFAMmdAT6E7M5qlLpPLG7F54MCNZrah?=
 =?us-ascii?Q?V4CvgUmChggfe/fzcfBNsTCoz73KPtBaZ65SSdKqgEdxZkPodsZfSQHvzjIy?=
 =?us-ascii?Q?SBS5qUtfIlC69m74J8UloYkGLSVzx8VmOLD0BOIHMIe7tPBQH/NgJnLiKwc0?=
 =?us-ascii?Q?VOKp2mlpRIvswjr6iVT7adaCYQqzwLNzzuFmQspTMfAMZQRqqgmp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b6849-85c4-4e72-5188-08decaf491df
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:30.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88KpfQQSm9yasL3STD06N/vy8XpI9DP8AlDLruw43iyQd4CHJloGbT0Tq+AL5pZsjz5Rk51+dI9GvjcQcynubg==
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
	TAGGED_FROM(0.00)[bounces-11533-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F22DF687E45

HDMA updates its running LL pointer at watermark points, so route HDMA
watermark interrupts to a progress handler instead of treating progress
as a STOP-only event.

Wire HDMA watermark interrupt setup, clearing, MSI address programming,
and LL LWIE/RWIE bits into the core interrupt path. STOP remains the
HDMA done event, while WATERMARK only reports running progress.

The previous patch decides where LL interrupt bits are placed. This
patch makes HDMA honor those bits as hardware watermark events and
dispatch them to the common progress handler.

The progress handler reuses the common LL recycling helper to reclaim
completed descriptors and refill the ring while the channel keeps
running.  Do this only while no channel request is pending; STOP and
PAUSE requests are handled by their request paths, not as normal running
progress.

The legacy eDMA dispatcher keeps routing its interrupt status only to
DONE and ABORT handlers; the new progress handler is used only by HDMA
watermark interrupts.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 27 ++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    |  9 ++--
 drivers/dma/dw-edma/dw-edma-v0-core.c |  4 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 59 +++++++++++++++++++++++----
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 5 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 839bafc762a1..a289d8f8cc17 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -299,6 +299,15 @@ static bool dw_edma_ll_recycle(struct dw_edma_chan *chan, int idx)
 	return true;
 }
 
+/* Must be called with vc.lock held. */
+static bool dw_edma_ll_recycle_and_refill(struct dw_edma_chan *chan, int idx)
+{
+	if (!dw_edma_ll_recycle(chan, idx))
+		return false;
+
+	return dw_edma_start_transfer(chan);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -739,6 +748,22 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_edma_progress_interrupt(struct dw_edma_chan *chan)
+{
+	unsigned long flags;
+	int idx;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	idx = dw_edma_core_ll_cur_idx(chan);
+	if (chan->request == EDMA_REQ_NONE && chan->status != EDMA_ST_PAUSE) {
+		dw_edma_ll_recycle_and_refill(chan, idx);
+		chan->status = dw_edma_ll_pending(chan) ?
+			       EDMA_ST_BUSY : EDMA_ST_IDLE;
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -762,6 +787,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 
 	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE,
 				       dw_edma_done_interrupt,
+				       dw_edma_progress_interrupt,
 				       dw_edma_abort_interrupt);
 }
 
@@ -771,6 +797,7 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 
 	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ,
 				       dw_edma_done_interrupt,
+				       dw_edma_progress_interrupt,
 				       dw_edma_abort_interrupt);
 }
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index dbc4af0eab59..9bd0a5f2f08b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -144,7 +144,9 @@ struct dw_edma_core_ops {
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
-				  dw_edma_handler_t done, dw_edma_handler_t abort);
+				  dw_edma_handler_t done,
+				  dw_edma_handler_t progress,
+				  dw_edma_handler_t abort);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -228,9 +230,10 @@ enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
 
 static inline irqreturn_t
 dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
-			dw_edma_handler_t done, dw_edma_handler_t abort)
+			dw_edma_handler_t done, dw_edma_handler_t progress,
+			dw_edma_handler_t abort)
 {
-	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
+	return dw_irq->dw->core->handle_int(dw_irq, dir, done, progress, abort);
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 47faedd14dc2..dfe0483896d3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -232,7 +232,9 @@ static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir
 
 static irqreturn_t
 dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
-			   dw_edma_handler_t done, dw_edma_handler_t abort)
+			   dw_edma_handler_t done,
+			   dw_edma_handler_t progress,
+			   dw_edma_handler_t abort)
 {
 	struct dw_edma *dw = dw_irq->dw;
 	unsigned long total, pos, val;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index b9e193774714..9f5b11350f23 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -59,9 +59,13 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
 	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
 		SET_BOTH_CH_32(dw, id, int_setup,
-			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			       HDMA_V0_STOP_INT_MASK |
+			       HDMA_V0_WATERMARK_INT_MASK |
+			       HDMA_V0_ABORT_INT_MASK);
 		SET_BOTH_CH_32(dw, id, int_clear,
-			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			       HDMA_V0_STOP_INT_MASK |
+			       HDMA_V0_WATERMARK_INT_MASK |
+			       HDMA_V0_ABORT_INT_MASK);
 		SET_BOTH_CH_32(dw, id, ch_en, 0);
 	}
 }
@@ -99,6 +103,14 @@ static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
 }
 
+static void dw_hdma_v0_core_clear_watermark_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_clear,
+		  HDMA_V0_WATERMARK_INT_MASK);
+}
+
 static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -115,7 +127,9 @@ static u32 dw_hdma_v0_core_status_int(struct dw_edma_chan *chan)
 
 static irqreturn_t
 dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
-			   dw_edma_handler_t done, dw_edma_handler_t abort)
+			   dw_edma_handler_t done,
+			   dw_edma_handler_t progress,
+			   dw_edma_handler_t abort)
 {
 	struct dw_edma *dw = dw_irq->dw;
 	unsigned long total, pos, val;
@@ -134,16 +148,29 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	}
 
 	for_each_set_bit(pos, &mask, total) {
+		bool has_stop, has_watermark;
+
 		chan = &dw->chan[pos + off];
 
 		val = dw_hdma_v0_core_status_int(chan);
-		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
-			dw_hdma_v0_core_clear_done_int(chan);
-			done(chan);
+		has_stop = FIELD_GET(HDMA_V0_STOP_INT_MASK, val);
+		has_watermark = FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val);
 
+		if (has_watermark) {
+			dw_hdma_v0_core_clear_watermark_int(chan);
 			ret = IRQ_HANDLED;
 		}
 
+		if (has_stop) {
+			dw_hdma_v0_core_clear_done_int(chan);
+			ret = IRQ_HANDLED;
+		}
+
+		if (has_stop)
+			done(chan);
+		else if (has_watermark)
+			progress(chan);
+
 		if (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val)) {
 			dw_hdma_v0_core_clear_abort_int(chan);
 			abort(chan);
@@ -204,10 +231,12 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 
 	/* Enable engine */
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-	/* Interrupt unmask - stop, abort */
+	/* Interrupt unmask - stop, watermark, abort */
 	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
-	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
-	/* Interrupt enable - stop, abort */
+	tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		 HDMA_V0_ABORT_INT_MASK);
+	/* Interrupt enable - stop, abort. */
+	/* Watermark is enabled per LL element. */
 	tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
 		tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
@@ -247,6 +276,11 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	/* MSI done addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI watermark addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb,
+		  chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb,
+		  chan->msi.address_hi);
 	/* MSI abort addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
@@ -263,6 +297,13 @@ dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 	if (cb)
 		control |= DW_HDMA_V0_CB;
 
+	if (irq) {
+		control |= DW_HDMA_V0_LWIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_HDMA_V0_RWIE;
+	}
+
 	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
 				 burst->dar);
 }
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7177e5..bf13e451b1a9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -17,6 +17,7 @@
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
 #define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
+#define HDMA_V0_WATERMARK_INT_MASK		BIT(1)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)
 #define HDMA_V0_CONSUMER_CYCLE_STAT		BIT(1)
-- 
2.51.0



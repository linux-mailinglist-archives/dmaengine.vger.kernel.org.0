Return-Path: <dmaengine+bounces-12294-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uYG7LbarUGrF3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12294-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:22:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFC738634
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=XDkzse39;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12294-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12294-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BE273010485
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A833EF673;
	Fri, 10 Jul 2026 08:22:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76B366079;
	Fri, 10 Jul 2026 08:22:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671728; cv=fail; b=Q9Qf++ZS8ZQ4s1jKL55MjdCoZW1KVh+078FYDjbHUxg5gcFQJKDtdEGTwyWi3e4od/4fBODP3TH6plwNQ3VD3uWc/YZPxCYs7PYNMucw5XvWz6b49HjW1Dh0ph7167qQBynnVJLFBFUjy/wtj6Kljwnc/koMqwqQzYR43vkPvCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671728; c=relaxed/simple;
	bh=xzX8rqrmsbwqTUNeb2svHGMEYsv3Wz/Lid53+COnAlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEWQqudPgAH2VktrKc2BrxGK+JuaILBXW7UxqVYZtWrsTDJY9nMemkjijCMLp87J/IA4ngKp49u4eQoutsFu09jgIecLCS/1Sp5UAK6jzCXdOo0m7qR4MLbSe5B4OduQC1Ai4XMmictnOegBICddf9KbATtoQ/P9RbCDNRQDKW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XDkzse39; arc=fail smtp.client-ip=52.101.125.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6JQt9mwCN4Xqnca59tXQNrzxelKEkG5UldvhzhrpDn29ecehKAX77v7VdpU6LfNxmscAr0uBUU8zCcdaGs66SGQ1kHH72oHdi2/G16Hc+p2EPc45ddFS+NM/kZbya454YwCBNnTbs0zrjY5+TFNrx8qW3pJx4OSWlpMPCsHKWqrFXXccfK4xibHAEeK7NMCYLRpjm7SrCT5FaHKsDM2B56fAbNDPxqTYlBJDkugTyuk9rQJf3DkNSrDKDiN3M/ZPXPrGSpcNmaAyRBY4NTAYJIGlBS2ULt86I70bH8AQVVIYdQvQS+ovBTPPeny3Tb/qORejn7bJA513e25K/J4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+uAlsP9rykDYoaKG8SSofefd5/wIY2+oO3/Vs9FyPM=;
 b=K7SgeTGraWlh9d6wx3v63bxb1pGmYmQeFLloYJndtTxSseL3ix5xFZ27nEWkk9MmVyKwyrzxNDMlIp2brHFl1lzFdjM9+gxkS1d+r16JhztRrSRTonoRUUD/05pNA8ecC788KCZflV0K9iFU6Imz4c/OHnfSOhZ6VjTMrrJw/YjfFAeMWnTilkKY4dGek/UAEiXajdp/dOIzTzWgDNgSYHPlRN0o1GqwMLiW4lg0rxlR5aLEP+1pLE6CSVyGzdmWyprdnYpMxfJR1ufrh68yfivhdVGdPzRDRXCVIQj56IOrUm7oO+ABRoeI0uaxdWVykBQWQnC7uki2RK/fgFNOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+uAlsP9rykDYoaKG8SSofefd5/wIY2+oO3/Vs9FyPM=;
 b=XDkzse39rwosA1Lfd5ZYdHb55XVM6+d9AfcwvHIGZq7VAEQE2wI4VnFLlOLMLtSI4p6+Jh3OjxM6dqcl/6Sf/vOqlVgRPZh/F5EeANmjZ+Ht/3RXB11z7Dafog4EHrfpta3wP5nFFBPSeLqwsC3jwCY5s8vX3RykPRmTCHkKfz0=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6531.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 4/6] PCI: dwc: Expose endpoint DMA resources
Date: Fri, 10 Jul 2026 17:21:54 +0900
Message-ID: <20260710082156.2395844-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5b587c-071d-48ed-3748-08dede5c52d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zKlif0kU4aqf4E9qxq5vo+jcZa2w0rood1wGbiek5izvgFe90PDRqTuGrbrmsm6kNiOEL481mmHsD9XG0HkPplDQxfeGVpneQPLVj5UURt3jgc3+L+CnScDaTk3dNoVONqEn/iaL9EalKk5HHn1kNG6XEYe6GrdRO3M6s2vdPCJk3i+oiZXTbuW47W5vV7uKOVKJ0lgMMrki5/OzjMuMhdrGOvtD0EvvZSX3s8nJzF8Vjrel8IWej+tU/yvJA0eW7oju68xHTlfi4g6PhoT+ygHg7MrV78zJo9f9Trmqz/Q2lSChMdrpwGPLIHhDZwqM+mbU+uQ+bIcz0/5co+ARbNfN59m6vU5G2zB5LiwkGprzu6nlB02C81UbXuSWGeoME5PqNc8Q1xNOwrxTjEwrFFXI9Btwgua8z5FD1Yg9zPNWhp4gyg4Nz8mMNF0VeuFj7iFSZr1JKoa9ReTzY3/opQAJFb15VuVxRuns7p8NTQZxcPhAqA6nCdVz0aGRYJhByFqE2ukfgvz+kePLV5EjxAUzoIJRCMnzx8KL7Vlwcu8SOWPx7tgi0UcbHwCUxYAAHQ5xqbB6VR3WKBhV9l/B/jpMtl1ylJxR4c82diGDEzZhWmzZ6Jh4mICkUzoP/TWfxDC3U1LjRwoqlsnGM+9WNejLrMsP3k0CqANQot/ZPI0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DyxNuBH+eDEgIx/mRslDeAfnS4VAovjbHwL1673R/O6gp6GOQVQw5O3Qz4W?=
 =?us-ascii?Q?AQnp21tgOEglSKvQp+OK5kln1beQT25kpba7JCqNrAMWXJHKHUcBwNCVnCOh?=
 =?us-ascii?Q?H0A+Odoatla+SxtndiHhav/JJTQYLEdFg9j1KRhFkuUOUDR5S17cEjCndbBi?=
 =?us-ascii?Q?lpU5T3EWsPKzuz6X3SkDP4CxRKSTRW2Pl8IiElW+7xxvnWp4dS+OThQTb1qo?=
 =?us-ascii?Q?+EVtAJZf1TPxehyqR+/ilY6bo4wMAaJdtRmjOoymJS4NhcoFXOWoy9W9HtWs?=
 =?us-ascii?Q?C6lxfGUG7oLK2/p/VrWSBgUQOFrSyc+AUWT2+qtmIWcVNC1RObEKi/tIVMlY?=
 =?us-ascii?Q?KGOV006SyAqyUvE0SaNHBgh3HBkd8gbe1gKVxmPlHWrFAx7q0zeWkchZgkUC?=
 =?us-ascii?Q?zWmluzgQkYKhueUp55H1O1NiS/KtnLsDvpj/D8rhyJh1VldWcSDl/1W8NiOd?=
 =?us-ascii?Q?sYB9Jyu6bY4yVsgIugAcXbCHrUD3v+VdR0SmMbkjJgK/4cvo3er77FDwpkPd?=
 =?us-ascii?Q?LBUe8+gYAo3Rsq4eFUOs0SjfBI5lRyZc9LQ8RS+Xo9VteyI0j85s+qmTzTNt?=
 =?us-ascii?Q?brRZVI17DdxnmQHpCIW7/aszNTwo2qCC2GI3uMuyfUD1K7VsERBEnNkKPSNo?=
 =?us-ascii?Q?mZTBnmwWdiISOiYcDcAgrchAxr+sYoQ/u1qDlc53yUq9ovtWbK7WHSJPs/WP?=
 =?us-ascii?Q?maomdmxBQnJmoSKE9JQP/D4zROErsisz9pCt6c8u7PLwGT4WsPiDuApCwTFs?=
 =?us-ascii?Q?m5qBSAq/d0SjcvaSsRCb51Joh6ccsNdVeHbzJ0gYyg8CgfGLjw2InS33R6BI?=
 =?us-ascii?Q?NjH3+oFdILE5PgcpFHvBKXmhECh8VPjW8b1HExsaGKcBTynQfLW445vpZXDy?=
 =?us-ascii?Q?RZ7IXSIENO3/4IRdsuxhC0puZFJRXtH2B5qzPESJSmMQRIJNyZyv0lnRGwYe?=
 =?us-ascii?Q?8uKyE4GapyoiFYIGXtWlvup3qAc4NMUeZ5eO65TSwnh9UlgapOLeFHxm5E7L?=
 =?us-ascii?Q?Ox8Gtqdj7hxxJkLX7ZIIFraX26Opvd9+/ZupuifHccqzsoqMzN3gIimHGTUd?=
 =?us-ascii?Q?yCnf702fRiUBFC8OruTlUJcNjYdZO2X+oY3abZHJihqfe6SIIFgdPhQNIarB?=
 =?us-ascii?Q?y5rxdJrViHqk68pat9SW8Z7i8bSF43tTLc0qW9itv2SNVHm0IrJqoHdrGYfT?=
 =?us-ascii?Q?+mCz/gq6IX+eGG9hrNGd922KSxrq/1nKERtQwM2Hwq56pzWRiqdXGrWLOXUG?=
 =?us-ascii?Q?HN7KGWaARnwnqU7GlI2JJdlfPEcUSM6yO5U7Lc14Sfct02Z9c6D8ihEnILH+?=
 =?us-ascii?Q?7RSdTtFQ3kR3cSeQ5JLwHx9bOhnN/REPTYSKWeCtaRxEDa/A3o+oZ83IexoI?=
 =?us-ascii?Q?2hKiztcNeWAk+BuGrgbOHrevq1vyq8XCA3/EpSYjAfKsj2TsWbY1q+7aROmf?=
 =?us-ascii?Q?C7sR3nv/ZdA/mSvo8rdL4CjTRQBBlOweUiZjqLM5OCDAvziLpMLdu/AlAC+M?=
 =?us-ascii?Q?Yo3dBw8dnjxO739s3INMqxd7lAHTVgNTyy1tAWHxQkyYv0yf8jAwE1Exresy?=
 =?us-ascii?Q?4DWqz8LR3z382q+adFe6tfS4tQ3il16CEk1hD+p4jcDG7AMHbAN5wVu/vmGB?=
 =?us-ascii?Q?JkbK3apEZKlHhL0sp4/+aoB7cXdzhqZ9ebZSBP83W9kKBEuDX8xaqAVw03oC?=
 =?us-ascii?Q?tcKk6jW0uzfqWkHfDFxudc8sPn0HpguFYqckg1dGGPW1oEvYdkMnp79ldzpY?=
 =?us-ascii?Q?G0B6zdPq381b5n/oXxxLBu+Y3SSe8ew7IPsR9GwoC91nTSXx6J+j?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5b587c-071d-48ed-3748-08dede5c52d0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:04.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkdGZ07nm2nwJg9zUS3/Xp19RUuClhh5sgUiEEWxnciEqX38gYmV0/quqWf/knCrc3k9PFzuLMyql5z+C5XMUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6531
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
	TAGGED_FROM(0.00)[bounces-12294-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jingoohan1@gmail.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:kishon@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18BFC738634

Expose the DesignWare endpoint-integrated eDMA register window, logical
DMA channels, and linked-list descriptor memories through the EPC
auxiliary resource API. This lets endpoint functions decide which
channels to publish to the host.

When the DMA register window is already visible through a reserved BAR
region, report its BAR and offset. Otherwise report it as a normal
physical resource so an endpoint function can map it. DMA channel
resources carry hardware channel selectors and refer to linked-list
descriptor memory by ID.

Expose DMA controller and channel resources only after the local DW eDMA
provider has been registered, and only expose channels whose linked-list
descriptor memory is available. The interrupt-emulation doorbell remains
reported when its register offset is valid because it is a standalone
resource and does not depend on the eDMA provider. DWC non-LL exposure
needs a metadata ABI and host parser extension, so leave it unsupported
for now. Reject VF auxiliary resource queries because the
RC-programmable DWC eDMA/HDMA register window is assigned to a PF BAR
only.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Drop an unnecessary ternary as dma_ctrl_bar_offset is already 0 when
    NO_BAR.

 .../pci/controller/dwc/pcie-designware-ep.c   | 131 +++++++++++++++++-
 1 file changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7d2794945704..dd47537f390e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -858,6 +858,38 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
 	return NULL;
 }
 
+static int dw_pcie_ep_check_edma_ll_regions(struct dw_edma_region *region,
+					    u16 count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (region[i].sz)
+			continue;
+
+		/*
+		 * To-Do: Add non-LL support to the endpoint DMA metadata ABI
+		 * and host parser before exposing channels without descriptor
+		 * memory.
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
+{
+	/*
+	 * The DWC endpoint databook says it is not possible to assign the
+	 * DMA/HDMA registers to any Virtual Function.
+	 */
+	if (vfunc_no)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int
 dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 				   u8 vfunc_no)
@@ -865,14 +897,34 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_edma_chip *edma = &pci->edma;
+	int ret;
+	int count = 0;
 
 	if (!pci->edma_reg_size)
 		return 0;
 
-	if (edma->db_offset == ~0)
-		return 0;
+	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
+	if (ret)
+		return ret;
+
+	if (edma->dw) {
+		ret = dw_pcie_ep_check_edma_ll_regions(edma->ll_region_wr,
+						       edma->ll_wr_cnt);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_ep_check_edma_ll_regions(edma->ll_region_rd,
+						       edma->ll_rd_cnt);
+		if (ret)
+			return ret;
+
+		count += 1 + 2 * (edma->ll_wr_cnt + edma->ll_rd_cnt);
+	}
+
+	if (edma->db_offset != ~0)
+		count++;
 
-	return 1;
+	return count;
 }
 
 static int
@@ -888,6 +940,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	resource_size_t db_offset = edma->db_offset;
 	resource_size_t dma_ctrl_bar_offset = 0;
 	resource_size_t dma_reg_size;
+	unsigned int i;
 	int count;
 
 	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
@@ -909,6 +962,76 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (rsvd && rsvd->size < dma_reg_size)
 		dma_reg_size = rsvd->size;
 
+	count = 0;
+	if (edma->dw) {
+		resources[count++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+			.phys_addr = pci->edma_reg_phys,
+			.size = dma_reg_size,
+			.bar = dma_ctrl_bar,
+			.bar_offset = dma_ctrl_bar_offset,
+			.u.dma_ctrl = {
+				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+				.reg_layout_data = edma->mf,
+				.ep_to_rc_ch_cnt = edma->ll_wr_cnt,
+				.rc_to_ep_ch_cnt = edma->ll_rd_cnt,
+			},
+		};
+
+		for (i = 0; i < edma->ll_wr_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_wr[i];
+			u16 desc_mem_id = i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
+				},
+			};
+		}
+
+		for (i = 0; i < edma->ll_rd_cnt; i++) {
+			struct dw_edma_region *ll = &edma->ll_region_rd[i];
+			u16 desc_mem_id = edma->ll_wr_cnt + i;
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_CHAN,
+				.bar = NO_BAR,
+				.u.dma_chan = {
+					.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
+					.hw_ch = i,
+					.desc_mem_id = desc_mem_id,
+				},
+			};
+
+			resources[count++] = (struct pci_epc_aux_resource) {
+				.type = PCI_EPC_AUX_DMA_DESC_MEM,
+				.phys_addr = ll->paddr,
+				.size = ll->sz,
+				.bar = NO_BAR,
+				.u.dma_desc = {
+					.id = desc_mem_id,
+				},
+			};
+		}
+	}
+
+	if (db_offset == ~0)
+		return 0;
+
 	/*
 	 * For interrupt-emulation doorbells, report a standalone resource
 	 * instead of bundling it into the DMA controller MMIO resource.
@@ -917,7 +1040,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				  sizeof(u32), dma_reg_size))
 		return -EINVAL;
 
-	resources[0] = (struct pci_epc_aux_resource) {
+	resources[count] = (struct pci_epc_aux_resource) {
 		.type = PCI_EPC_AUX_DOORBELL_MMIO,
 		.phys_addr = pci->edma_reg_phys + db_offset,
 		.size = sizeof(u32),
-- 
2.51.0



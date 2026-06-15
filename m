Return-Path: <dmaengine+bounces-11532-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5RzlJsQdMGrUNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11532-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BD687D2F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=wCymBvMt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11532-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11532-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF344302D4DF
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EF409116;
	Mon, 15 Jun 2026 15:41:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C9408033;
	Mon, 15 Jun 2026 15:41:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538099; cv=fail; b=BG4EVO+cMEV5cojGrNnbfGKBtunoI4ccta70fdSh2OPWH8zH80yMVNazpUa4xTHuIRAu4cMH+j4r2D0AmshzqQNon1krF2GuezO0znifOI3blF2zyCY6svP9XEvXRTwmNESkbBwGqb2+YtaP3UHzMZA9TFIMkTMerDZjWk2xlzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538099; c=relaxed/simple;
	bh=3yWDyQ0Hl5+Yu1sioQTLJqB/D8oF3DefL4LEUymotZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOQJtNYFYKG7p3KyA5I6dU/WZmi+HDmrG7mb8B18ug+NsYbXs7fIpopR9mv0CIo1LkRjrcTRLgrZKCNcHZVMvg5LzRzRmF4gsBqOC/C9vizdAoFUwg998x+rjJBcIaFXhN3Sg+wE9Psime7Wui1Gns03Ze5QHD1KhTCj0cWSuGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wCymBvMt; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEwUoJXD7iroXTfVq0nH03aL9ZkHFu2mDIbvLOKJTugGpAkxPEUaI34BvKmQ97lgB8SF07v0bjwEuC8234geb/YAPuq3C8rPJoBb3aOxVJjzH+gP6hDznSURztb8VBBOIV6HKbhI5Txt7Bb5bwX/lrU6XWe1c4BO+d6NOFhnkFJKquKJQ+1JuezVvtCxZTeFRAv72UoQ68AxIYs6AphM0XiecNcCIlVA7/PqorarZ8dKqAO4P80tTN+ugc7rRNMsEW2wuSJqmKyiXQspp+o2To+EsyO4Pqc3xVL5vfY1mI2pNsxR+XYXV8W/clAjRuhhPUS0K0p4EVohxLuM33PnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbmEZPCB9dM4hTEGJBcuOCB4Fno3gvsxRSwpnqL+CAw=;
 b=u8Hq102l+Qr3+hfktI68y+RFF4ZtwOQJ8mt8PDRZbeReVafBNlJ6fiOeHpohgyi/WhESxc0lD2d6H08lPpN0Qo2yYtinRBCUieHEQq9T6STC2riJY8YYqP4NX2Iw3I98qpTew1FRh6FeL9wvRKp9HWBLiqUljnz8/NTnRvVVDsrz5adl6TbqBUzme+cGURSilJuwzdxlkB7MZ00ffa40cc2NPiyZ7mA4LFH5/u25x5ErDMOiVweDNxo2wE+jsD2urb12yhDZfP1pV4UHzNzS9JaxmXdV7vSkXvInGFIq+Mh05teFc3eZeeDVQYu9vyBr5XJjR9jq8joqrSV15tH4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbmEZPCB9dM4hTEGJBcuOCB4Fno3gvsxRSwpnqL+CAw=;
 b=wCymBvMt/64z+BTWR5FdhEIKGf80XNnit/2qNK8GieiRj1DMkTn5TWP9/+P075GhyB4rne98CrHYV39SlFGrO2WI2seUeklQUsNuKl47qvz+yIajKDfi6fU4mXnoVhKdtlRBSTjLXxqZAM4C2Ylb/7EtGFUlLngX96TvrJ8YwEc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:29 +0000
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
Subject: [PATCH 10/17] dmaengine: dw-edma: Reclaim issued descriptors from LL progress
Date: Tue, 16 Jun 2026 00:41:04 +0900
Message-ID: <20260615154111.2174161-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0204.jpnprd01.prod.outlook.com (2603:1096:403::34)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: b208c723-7d47-4022-e928-08decaf49172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	d73NH659jLz3hbHZYjRKaiVFRB7yCM1ey+kzETr0wwN6doWR23bGZ0pYB0eiw3zlEDU6ttcbrbO7TLZih8l2S7473B7e9RPzR3qnBYPy8s7JWE571NUQqQYER2TOHF2GhQEASaehoUiCv8ZLl/SO8omcHqjkLp+dQrthpE0MZLhZmvXVPScBkHO3EDev7867w4Qpl4t3/uXZ4B/NWqO0/wXm249riV7mJWIt9BbKPAaSQQkqxLpeCmnCTyukpAUVJ8H26DNOP4GuYsc6Fu6rm7Vk3UQC4e0HqAx6GcyeeVPEDT858lxLpqyHxcKh3A6UaYyTPjtWAf54WiHtCJRIvBhHldXv3xYg1OTpMsBb5wz/wBfOpC7ycypvYEm4FTCRZpYFab9LkHfQUd04CPwBQEa4ydCgqtKjFMr/Gk9D5folGR85BUMw8GX02UFWf/lxaAi3fPid1hJd4fg3B+Wk7vp5HPNe5xjmnpoI/J9EjmTYjvnxB1QaEbRjI8XwYU6V2Gy7mos+eqGtcB4fFwn4I0YE9L/s1oDdP0TtWAcUOwyHHUo4e4FHVcSJH1Bf1Oof7liKoMcvRbR3FZk3QbV4kokHs7u0Sbs8j1Ewp+q32B72gWv7q5ozDtlK+81755MZa3AZfqsTEPVPwPcZikTyMVl//GbDE/QzTazitHd40XL5I2sl/D+x6TeCSyEk2JcAnvnXuDtQk2Y+vkNfO2mQ8XNVmMDUisFQju5aLtAdDKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dWBXQv+r3TXTnFykDkyznvj0L2f13DR5H2F5refT6c2CSPrtzwQ8afZfczw?=
 =?us-ascii?Q?/IoihQ4YiJeGEYEalDvlG996w7HtW/QzIA3c1mP9fhmRb//nCZR98YI5rI3C?=
 =?us-ascii?Q?Gzds69VrYsui+/QLJsiMj3yB6Mz7eYqVrYHFfxoJmOJ/+ZMnCgjCHUgxbPSF?=
 =?us-ascii?Q?GTJc4VAF0O/UhloQFz8ZT5W1OWqS9fdCqJqe07t56C2j3iVosTd2kLcv5E/j?=
 =?us-ascii?Q?5KNInsuPBSmHBLMn5SG9YVlqvrD/Cv3b3HGW1Sr/K9OygvxAHIi57kamY9PB?=
 =?us-ascii?Q?qeWtOX7TqagStj6PcB+YCCbOWtQ7aGoA1D5NOyiLfcxWEt6sIdABeRU94s1y?=
 =?us-ascii?Q?NCuXSavTUd6RB8MsPClnHUpZfrmbXJl6njpUFEFsJljN+syEprQ0FXh6bJ28?=
 =?us-ascii?Q?aVG3tVMsR069C4vRHDNMPU4T//Px7FYOrPL6O3mGu289XMuohMA+C5lv/jQ0?=
 =?us-ascii?Q?ALGGMbcMfNC3TO1rj0EWb4Hi1rqfiul271KnRffJ91rrUlNVkx3O87jpEtWI?=
 =?us-ascii?Q?/vNOoN2N7daSAGm7r5N5+tbaii2aJc7YZ2aKCN3vJf6v6HH+fUKbS5xd/TjS?=
 =?us-ascii?Q?OntU7R27ePmsVxES2l6/fx7PhI5bnnUUOahjhTnunnxEJeGxkDHccQXhhzdW?=
 =?us-ascii?Q?JE4MmpBnX+9bF7NrrdUAKg/o0lQiceHTnkL3bw/Yx9xF6mKX3orHYBIjnwD3?=
 =?us-ascii?Q?0uBDqMxqajo9cbnKFa9GSJnUF7a++x+ft4aEfuLrvY/bRXf/NPsqQaqr40OK?=
 =?us-ascii?Q?ttvQ2z9u2e+kOsPRhL2haeMVZm0ZtS8gtYbzr2QBRb0DCDN8OSwCfQR1tutC?=
 =?us-ascii?Q?Y0R/riqDHN9Id+ghxOreNfYigah3O4Sb+LGQf3+zVlrnnemXX+/bHRFxym1a?=
 =?us-ascii?Q?uxCk2JcxlB7Sb4yIhz/1jGQ3xVxXtNr6/CFVN8VW63wC6EV7kN1tRRj5G0Of?=
 =?us-ascii?Q?pae42m6m1Dei1ao/79oqCvuIzCtmijscX0Kcf8tR3kOH05bdGlvDHaLP/fyv?=
 =?us-ascii?Q?qZ64KCoFmkvRWNGPFHTgbNuzEKSWCyyZgrHqaogjkThxQHXQ0UWFhHD9uM8P?=
 =?us-ascii?Q?BSisj226k12bDC7Nq1+zA+AMn67TagRDH2YbiH/LVe476AM9/p8Gw05on6G2?=
 =?us-ascii?Q?qx64stJ7zi/12bTQzYKQMNT+k2mbTOI6URbuIfaqrRsEuDoTro11KDw77t1r?=
 =?us-ascii?Q?cb50j7LP1KJ7+trJ8pNezgxwhZpwCbcyPudwO/BonUXl/zEIVSz89eVxtNkH?=
 =?us-ascii?Q?d2Fd5xufKTQ76+lPQhJq3C6gQvBJtMVuiE267SXff5DBd9H+40UQ37faFph7?=
 =?us-ascii?Q?gq1jgwmANclkODZmrIL5O69GSH6M8suV9KES0DvVokir+0REmXX27CJfWPev?=
 =?us-ascii?Q?DWTCs+eQWG0dcRhtBnHgi5oxaevMJEaTSq2FQN1DErti5PDTCEY6WjnT69uo?=
 =?us-ascii?Q?BvqTfUGqooSD5CXEaXnChc379IpD8BlW8sE8qIfa+Ihvdm2ZfRWsftbQ/ij6?=
 =?us-ascii?Q?FxS9JwgIc7Alc538ldQ9kxT+8GAzU4hrm0p0Qm+WzqGIxcGAz4La4r7qo9OV?=
 =?us-ascii?Q?+Uq639WlT58gqX6xsVeJlIoARR+4WxivambnMtwLHGxBS4YlmPPHWKINWR9O?=
 =?us-ascii?Q?adalEpwPadS+HFuN7n2vTyQ99D+AX7s778z7Vu3M4lJtDtf71ixvJXYOfZt3?=
 =?us-ascii?Q?Is8elO/nvwO41cX/gM0l8CCs3ZMx/jbyxUrd+f0KprA6CZXulU1/7VMrC7Xg?=
 =?us-ascii?Q?gm/navYeBtna1jHulSj+9q18FDQnOg7bk+rHo2MmlmoJ1CKNQK1K?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b208c723-7d47-4022-e928-08decaf49172
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:29.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9C1xGVdxszxUCmFe8+LLugHTdKLdaDyqY6PpNieG6aaVVPH1EPZFp6spJi9NpOHmw/4NFr93/jkYfRzZGxu2FQ==
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
	TAGGED_FROM(0.00)[bounces-11532-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A2BD687D2F

Dynamic append can leave LL entries for more than one issued descriptor
in the ring at the same time. A DONE or progress interrupt therefore
cannot complete work by looking only at the first issued descriptor.

Track the hardware consumption point separately from descriptor
completion. ll_done follows the LL pointer reported by hardware; ll_end
remains the boundary of the last completed descriptor. Measure free
space from ll_done, so consumed LL entries can be reused even before the
descriptor that owns them has completed. This keeps descriptors larger
than the LL ring moving.

Keep start_burst as the appended boundary and done_burst as the consumed
boundary. Complete issued descriptors whose fully appended LL range is
covered by the latest progress segment. The ring keeps one data entry
free, so a reported physical LL index is unique within the current
ll_done..ll_head producer window.

For eDMA, LL element LIE/RIE interrupts are reported through the DONE
interrupt status, and the documented producer-consumer flow reads
DMA_LLP_* on such interrupts to recycle elements up to the reported
location. HDMA STOP handling also uses this common accounting. The
following patch wires HDMA watermark interrupts as running progress
events.

[den: dw_edma_ll_clean_pending() naming and core idea are borrowed from
 20260109-edma_dymatic-v1-3-9a98c9c98536@nxp.com]
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 111 +++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h |  18 ++---
 2 files changed, 116 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2165f2fa5398..839bafc762a1 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -65,6 +65,7 @@ static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
 	chan->ll_head = 0;
 	chan->ll_end = 0;
+	chan->ll_done = 0;
 	chan->cb = true;
 
 	dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
@@ -73,13 +74,34 @@ static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 	dw_edma_core_ch_enable(chan);
 }
 
+static u32 dw_edma_core_get_ll_data_cnt(struct dw_edma_chan *chan)
+{
+	return chan->ll_max - 1;
+}
+
+static u32 dw_edma_core_get_ll_dist(struct dw_edma_chan *chan, u32 from, u32 to)
+{
+	u32 cnt = dw_edma_core_get_ll_data_cnt(chan);
+
+	return (to + cnt - from) % cnt;
+}
+
+static u32 dw_edma_core_get_used_num(struct dw_edma_chan *chan)
+{
+	return dw_edma_core_get_ll_dist(chan, chan->ll_done, chan->ll_head);
+}
+
 static u32 dw_edma_core_get_free_num(struct dw_edma_chan *chan)
 {
 	/*
+	 * Measure occupancy from ll_done, not ll_end. Entries consumed by the
+	 * hardware can be reused even if the descriptor that owns them has not
+	 * completed yet; this lets descriptors larger than the ring move forward.
+	 *
 	 * Max entries is ll_max - 1 because last one used for link back to
 	 * start of ll_region.
 	 */
-	return (chan->ll_end + chan->ll_max - 2 - chan->ll_head) %
+	return (chan->ll_done + chan->ll_max - 2 - chan->ll_head) %
 		(chan->ll_max - 1);
 }
 
@@ -89,6 +111,29 @@ static bool dw_edma_core_enable_ll_irq(struct dw_edma_desc *desc, u32 i,
 	return desc->chan->dw->core->ll_irq(desc, i, free);
 }
 
+static bool dw_edma_ll_advance(struct dw_edma_chan *chan, int idx, u32 *old_done)
+{
+	u32 cnt = dw_edma_core_get_ll_data_cnt(chan);
+	u32 done;
+
+	if (idx < 0 || (u32)idx >= cnt)
+		return false;
+
+	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
+	if (!done || done > dw_edma_core_get_used_num(chan))
+		return false;
+
+	*old_done = chan->ll_done;
+	chan->ll_done = idx;
+
+	return true;
+}
+
+static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
+{
+	return dw_edma_core_get_used_num(chan);
+}
+
 static void dw_edma_core_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -121,7 +166,6 @@ static void dw_edma_core_start(struct dw_edma_desc *desc)
 		}
 	}
 
-	desc->done_burst = desc->start_burst;
 	desc->start_burst = i;
 	desc->ll_end = chan->ll_head;
 
@@ -164,9 +208,7 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 	if (desc) {
 		residue = desc->alloc_sz;
 
-		if (result == DMA_TRANS_NOERROR)
-			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
-		else if (desc->done_burst)
+		if (desc->done_burst)
 			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
 	}
 
@@ -204,6 +246,59 @@ static void dw_edma_terminate_all_descs(struct dw_edma_chan *chan)
 	dw_edma_terminate_vdesc_list(&chan->vc.desc_submitted);
 }
 
+/* Must be called with vc.lock held. */
+static void dw_edma_ll_clean_pending(struct dw_edma_chan *chan, u32 old_done)
+{
+	struct virt_dma_desc *vd, *_vd;
+	u32 done = dw_edma_core_get_ll_dist(chan, old_done, chan->ll_done);
+
+	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+		u32 consumed, started;
+
+		if (!done)
+			break;
+
+		/*
+		 * start_burst is the append boundary. done_burst is the
+		 * hardware-consumed boundary reported through LL progress.
+		 */
+		started = desc->start_burst - desc->done_burst;
+		if (!started)
+			break;
+
+		consumed = min(done, started);
+		desc->done_burst += consumed;
+		done -= consumed;
+
+		/*
+		 * Descriptors are appended in list order, so later descriptors
+		 * cannot be complete if this one has not been fully consumed.
+		 */
+		if (desc->done_burst != desc->nburst)
+			break;
+
+		/* Hardware has consumed this descriptor's LL entries. */
+		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+		chan->ll_end = desc->ll_end;
+	}
+}
+
+/* Must be called with vc.lock held. */
+static bool dw_edma_ll_recycle(struct dw_edma_chan *chan, int idx)
+{
+	u32 old_done;
+
+	if (!dw_edma_ll_advance(chan, idx, &old_done))
+		return false;
+
+	dw_edma_ll_clean_pending(chan, old_done);
+
+	return true;
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -600,8 +695,11 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
+	int idx;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
+	idx = dw_edma_core_ll_cur_idx(chan);
+	dw_edma_ll_recycle(chan, idx);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
 		switch (chan->request) {
@@ -634,6 +732,9 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		default:
 			break;
 		}
+	} else if (chan->request == EDMA_REQ_NONE) {
+		chan->status = dw_edma_ll_pending(chan) ?
+			       EDMA_ST_BUSY : EDMA_ST_IDLE;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index ea9f4292c40e..dbc4af0eab59 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -75,24 +75,26 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	/*
-	 * New LL entries are appended at ll_head. Entries between ll_end
-	 * and ll_head, modulo the LL ring, are owned by DMA; the rest are
-	 * owned by software.
+	 * New LL entries are appended at ll_head. Entries between ll_done and
+	 * ll_head, modulo the LL ring, are owned by DMA; the rest have already
+	 * been consumed and may be overwritten by software. ll_end trails behind
+	 * at the boundary of the last completed descriptor.
 	 *
 	 *   software-owned      DMA-owned       software-owned
 	 * +---------------+-------------------+---------------+
 	 * ^               ^                   ^
-	 * 0             ll_end              ll_head
+	 * 0            ll_done             ll_head
 	 *
-	 * The link entry points back to the region start. ll_head == ll_end
-	 * means all entries are software-owned and previous DMA work is
-	 * done.
+	 * The link entry points back to the region start. No DMA-owned entries
+	 * remain once ll_done catches up with ll_head.
 	 *
 	 * Software always keeps at least one free entry, so the ring is
-	 * never completely DMA-owned.
+	 * never completely DMA-owned. That keeps a hardware-reported physical
+	 * LL index unique within the current ll_done..ll_head producer window.
 	 */
 	u32				ll_head;
 	u32				ll_end;
+	u32				ll_done;
 
 	u32				ll_max;
 	struct dw_edma_region		ll_region;	/* Linked list */
-- 
2.51.0



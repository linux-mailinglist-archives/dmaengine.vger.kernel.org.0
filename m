Return-Path: <dmaengine+bounces-11549-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HFb0OeXeMGrKYAUAu9opvQ
	(envelope-from <dmaengine+bounces-11549-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 07:28:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED768C2D9
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 07:28:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=g9irXldG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11549-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11549-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5C3305247C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2743CF66F;
	Tue, 16 Jun 2026 05:27:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020134.outbound.protection.outlook.com [52.101.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F93CF219;
	Tue, 16 Jun 2026 05:27:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587675; cv=fail; b=rUtidlXzTIRS6mkVSXUwmBc3a/HeGOcXpfzyIBW0r54qj2cNiVN4De/y8feiu0pH+eGQ/FuIC/JKtCssoV7H3Hgk1xZRQHdF8AfpLEpkIPAkFL5m4JEc1+Wx6FAOKP0xdT2a16OUaojNAlDbHkLhqTblDw4WCWhwnHu2Fj7rCqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587675; c=relaxed/simple;
	bh=G1uSkPTnenVY4UDYlZAivkvxhaVOxccnQBbuxryPRP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FsZUU7dn0y6nBxV7hVz2xQNVZ6Ie5ZedDzmkh+iMU3g+yr9VYcs2LQX4AFNFJPrU74JqKHYlI0RRLZCMoLQWcJBWNIby/Zw0R5v73k6yJpaofea7HocQUpIBbeTdLkT61l18cVcKlQZx75kgFm9wTBafyXWXV+gnQ55GY6vl/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g9irXldG; arc=fail smtp.client-ip=52.101.228.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpO1F52SL20PXYpwxtJVJrlSU7aAysIQG/8rFgx9k1ETKUTuJTQ/s1PREcDDEaxpvkpMGbSyY8ofFPdeKy55UgsSWUAYB1gOQKiEw/Tr366cG+JsK45uY3GLVr4ceT4lCaTPAY2WdZXIDcRs5PPn1sG900Wqm+kbzEzz2byLVlOqzZjYGdkmpBWV0b/9xuDhfJelHlUD62SDDyA02y1bqo+/L5f0ig/JSpEH72gJeE/SRSU5hL257HQH2S2/qnOSyKVQo+mcy60PAZQIxXMWtoPtDvaWPwVqrp77pJbeWLVwEgTXI/MveFPE+IMHXOOcV8IdLOTYeZwHQ34qhCkQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az06tPSv8XoBjQM+H5fXTh7WgbGNW85wv1ED4HvQEFU=;
 b=vEF15Z6cEDfHZQWY3vD2JVCzODIbKXNjXvaJf47abq8hqWtjmbiZH9VWOS9F+SOrTN7bFpaXIlzoE2eJWYiqfp5hP1VFNrZpWdsccrl4KnbQ0jTi/aR7758tYMgJmp7nxSXEfCFEJptixgr4mi7zJ/AH02OpO53SXBCTgRgeaJaszhCEc4h3AATYGGrW1iWSVqwdG1yTlGj9ZWWNgmbpeqtiSDh/lU7A5ORwd/WuDuIhDkzctAa08lSDLQ6G5wf8SIQ371U2eJ1VnUw5TVVF6KXWrsT3qcwjzX/X7gEwo4Llg+8CQiq509oMkxxP9CgSkfHRXWk9SyRSHWpl+/ElCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az06tPSv8XoBjQM+H5fXTh7WgbGNW85wv1ED4HvQEFU=;
 b=g9irXldGvVSrBd1Lh+5eSfIGtArOnkLWrfE1B9wugj61Mmc2OggDjH4Q09460fSjICV8BNg7LoXu+chwECzf6BgYGiwxu9FjtNXbi5nC4uJuPg4u9L/K4VES2OKq1CUtEOwL6zN7fjO7O9IfS+hbBFy8OT7vrV3HVZfOtMch/Bk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1943.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:27:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:27:49 +0000
Date: Tue, 16 Jun 2026 14:27:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Kees Cook <kees@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Serge Semin <fancer.lancer@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Niklas Cassel <cassel@kernel.org>, 
	Devendra K Verma <devendra.verma@amd.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] dmaengine: dw-edma: Terminate STOP requests
 without callbacks
Message-ID: <ovv4nrimfivsrzqbfolvoy5kojv3nmxmvngjxd5a4rbshwlzjm@4ct7ikwgsn5h>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-4-den@valinux.co.jp>
 <ajBGUuooEoaFSWfS@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBGUuooEoaFSWfS@SMW015318>
X-ClientProxiedBy: TY4P301CA0101.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b50f765-7f6a-43ea-1f0c-08decb680138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	5UUFUfW094ypHioLH8WwwTeJSGVK3GIdByuKLPcm2XDBweu4uxwqqJl5BeoowkNAFGRLeLGvjZUX0kAiNYB6SQ63jTXx89C5nNWhAwUrSJDrcbg7kYf3GV0hkZ/hCHI/r585rvRikHFhwPrumL/bi1kdIDCg00vm5jKP09/prPETzjqn4RPEu69NGyCGUcuZXFGiW8p0kIlw81SGdRupX6xKdr64EmJvToEiuTQvgr6LN1Z2L8QSfOHK4JpD2kqJKZeawZ87/efyva3bPQXSGVoEw9V7RvGmVrC5T2C+1mMMcrF1zt7BSzxYbm8k68wrWDTJ2ac7jCZq1O/sX/LPlUEm7fNJPTNW3n8SGYErec7vzV3kSCEHNKH8bJtrQcpQCSiGSOX8sHMtHkDXS0h9VOvuLNVm0GjzbOAyjhQwAmGJXkPvUJcCOgAwDEgtlIqWX4p/E6f9RBTB2ZfvhRNSNPMLMVTwkMbt6CqXNvebSfVP8hnKUNSNTgoRv7BAZmjsMPWvIb9U5qQsQIV8jTx3MsLNc0KCF/sxyh2rKNc7GFgnaC24YvD2jwIw7xAuz+VWPp/4UgeVMbyMoVsfoBEdvA100+LsqqrqUd5WFjaneXCvJQIISa1O5WdzzSJo54WYDPMZMMhkaEZFYVdC9QlvFClNFWw+MS+syBOxXh97z3FJrTTB4tnqh6yGmIPE6BU8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzI/JuN8+3ihARcz08Yc9TwchDSP3XI+d4u/Zpnxd6HDBF36kWR8FIekK+BG?=
 =?us-ascii?Q?iTFFKm3/YIXu/BlNoamMRp1QYUD2BHToORMqFn2m5h0qxcXWUT+/XQrRPd3Z?=
 =?us-ascii?Q?V4PzFGF1/ZIqdS7Qwj7zSE76wFzNncRXg6aElvUcRHNjwh1CwIWP+jKup2qM?=
 =?us-ascii?Q?p53cokoHWyPEKxhEJFvdl5DWAXMVsg22bIgRH/ZdYiZSxuuB704ezN3y/+K0?=
 =?us-ascii?Q?9ryqtcoZfAYSZIp7RSs0pFMLGqaWeSxBxsNMgDLvjY6iS8YhetqsFulpRk2y?=
 =?us-ascii?Q?DrBwYaUXYUWv2PNiAs1fQITgHRFklLQSoXAEgyvMhQhIPPuWvXHMLexYHGF5?=
 =?us-ascii?Q?KPcD00obyryGtxuE57VsAupXZ9L+HN8m1L0VSntI1l53w4JBx2IlKhfc2EcU?=
 =?us-ascii?Q?4zwjejA8Lg6TH1fzfayr3AvnA0e298DkQxptU7Mq/IyX9hNpwWjvmoIDwsoO?=
 =?us-ascii?Q?y/+7rTodFiEuotkhn+Hv0PhK0GHwFJE5NPKzxV6XkKWKybKmWR+s4NJ5YxgZ?=
 =?us-ascii?Q?G3IWhC1rypH5wh9MfcXyVPCzGOQN4/3B+l+2FJ6qi+Kxn/UvF6l/Hy+VWJc4?=
 =?us-ascii?Q?HI3SaelUQxgL0iJDrlS8O/5284qjtK6aQdRXcdEziQYcsyo39X7pYZNbsCUV?=
 =?us-ascii?Q?1Y9K81Yu/uNtLAjidNPtlpNAygIfLHYjrHPfjye4wx3mbe49Wl9jBFSkYmYW?=
 =?us-ascii?Q?n2E3lMOC23FR8OKyNN/0bxI3iQXHSJQJN4aaU3MSV9MJkfwIZL3Q/Kch4xWQ?=
 =?us-ascii?Q?AdQj7T+fsZ2Vuke1xg7mL5TzvfdGFY6MaIL8lcEiBEvLdJzVhvTI84J8pGW7?=
 =?us-ascii?Q?CXWmKpKWLy3hnsI7xbKzFBSQIr7Qh99LwZNrV3ThV2w3vFAwqcT8IvlQaijh?=
 =?us-ascii?Q?nCZZUvzHeUrQ4v1CvYf7kXPWhX/yAA2x1bolz4tzy0uhSzx0JyQASvGgH7Kf?=
 =?us-ascii?Q?DQQU63BZ88SjTxiS/hCDEYivtIjaxB16IPCPDJCc4+hCeuWxO9BanlHyDNt8?=
 =?us-ascii?Q?ISlrbx2Gploz2dR4SaQLw8ogaE9E0Exh+JCvEcCQnadGgRZ9nqszAv5JFIWo?=
 =?us-ascii?Q?29ROU+zN6HXVXBn2CxzptP0mrhSNPFLr29YeXgpNoHXMBNQmwMOGp8CJlXMo?=
 =?us-ascii?Q?DKZMGCv0GoHNxh5SsR7kRs7WQDqKv+VJ6zhHTI3xsTe3psxE8gbmeZCghAlp?=
 =?us-ascii?Q?GbbE0c/+HXCkP70jlwcJEN/CkDr2naculNjMV4A1TbCuKYamHUFaniTnSZvd?=
 =?us-ascii?Q?BB+sjM/yREmRfkrpi3bpsaPxrDJhxX4Mn78ONOFzuqaxQxHE7IPDOJBYqDBA?=
 =?us-ascii?Q?GNmKE4ONaiaaBveXr1yUlHEwuMTwE/Wh8tplwlBqDJ5UvmxGDLgEohJZvi+v?=
 =?us-ascii?Q?Y+qNyZVXEvPd6Ymri4uzvtajbuzqUZ4OIicrQIl1mdDQrYxisQfwdU67ubhb?=
 =?us-ascii?Q?LtvJ7MWBOZtfNPGpkoxPKqetqXfZ48u55FhrrQ0a96g6HX9YWEDfnvs0mIUK?=
 =?us-ascii?Q?8nKd/gS3cDwA/umK3s9Qmr9cecoDR81n8fPBzjmDobF54K9App7nQQqDseLL?=
 =?us-ascii?Q?4D4Q/RZ4SRFGoJSxeaM3azRKnRYVDlAv0ZgWYjsKm1zunapxAMeBAMlVjt/X?=
 =?us-ascii?Q?UBC9wgXOyXL7arDniFgu5ABJlMOdg/VztNt+zQ4z970FOd2NVHLy3GnnD1ra?=
 =?us-ascii?Q?C4EB/49oKIWYx96gsDmGWCS6Q+MzwYr43QDZg0ZEl99sHdG7amCw8zok6d7B?=
 =?us-ascii?Q?Xt6QFrRSc9mduo0HQc0sSdbTEJ03Pra/cyUUlGtMMKT4X7ro/9PV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b50f765-7f6a-43ea-1f0c-08decb680138
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:27:49.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfIdUGUgd4RnuExQLARQHVHR/kIwEoGuKv+8wYc1LOXOz6P21tsQqzQClPV+vELLW/xg3T879Mxls5kXI0I/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1943
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11549-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,4ct7ikwgsn5h:mid,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49ED768C2D9

On Mon, Jun 15, 2026 at 01:37:06PM -0500, Frank Li wrote:
> On Tue, Jun 16, 2026 at 12:40:57AM +0900, Koichiro Den wrote:
> > The STOP request path handles device_terminate_all(). The DMA Engine
> > client documentation says in the "Terminate APIs" section of
> > Documentation/driver-api/dmaengine/client.rst:
> >
> >   "No callback functions will be called for any incomplete transfers."
> >
> > dw-edma used vchan_cookie_complete() for a stopped descriptor. This
> > queues the descriptor on the completed list and schedules its callback.
> > A late callback after dmaengine_terminate_sync() can dereference
> > callback state, such as a request object, that the client has already
> > freed.
> >
> > Move stopped descriptors to the terminated list. Complete the cookie
> > before doing so, so cookie polling observes that the transfer is no
> > longer in flight, but do not schedule the completion callback. Add a
> > synchronize callback so virt-dma can release terminated descriptors.
> >
> > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index d99b6256660a..bedaee6d30ab 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -106,6 +106,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	return 1;
> >  }
> >
> > +static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
> > +{
> > +	list_del(&vd->node);
> > +	dma_cookie_complete(&vd->tx);
> > +	vchan_terminate_vdesc(vd);
> 
> Is it vchan_terminate_vdesc() missing call dma_cookie_complete()?

I think it is technically possible with some adjustments here and there, but I
am not sure it would be worth it.

- If vchan_terminate_vdesc() starts calling dma_cookie_complete(), all callers
  would have to pass descriptors to it in cookie order. That is not part of the
  helper's contract today.
- There would also be some fallout in existing users. A few drivers already call
  dma_cookie_complete() before vchan_terminate_vdesc(), so they would need to be
  changed, or dma_cookie_complete() would have to become idempotent instead of
  BUG_ON()-ing on an already completed cookie.
- Some users would need ordering changes as well. For example,
  xilinx_dpdma_synchronize() currently handles pending before active.

> 
> > +}
> > +
> >  static void dw_edma_device_caps(struct dma_chan *dchan,
> >  				struct dma_slave_caps *caps)
> >  {
> > @@ -537,8 +544,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  			break;
> >
> >  		case EDMA_REQ_STOP:
> > -			list_del(&vd->node);
> > -			vchan_cookie_complete(vd);
> > +			dw_edma_terminate_vdesc(vd);
> >  			chan->request = EDMA_REQ_NONE;
> >  			chan->status = EDMA_ST_IDLE;
> >  			break;
> > @@ -610,6 +616,13 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >  	return 0;
> >  }
> >
> > +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +
> > +	vchan_synchronize(&chan->vc);
> > +}
> > +
> >  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
> >  {
> >  	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> > @@ -723,6 +736,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  	dma->device_pause = dw_edma_device_pause;
> >  	dma->device_resume = dw_edma_device_resume;
> >  	dma->device_terminate_all = dw_edma_device_terminate_all;
> > +	dma->device_synchronize = dw_edma_device_synchronize;
> 
> Can we provide generally call back like, vchan_synchroniz_dmachan(), or
> change existing vchan_synchronize() to by using struct dma_chan *dchan.

I think the former is possible. We could add a vchan_synchronize_dmachan()
helper that calls vchan_synchronize(to_virt_chan(dchan)) internally. That would
avoid bouncing back through the driver-specific channel representation just to
get back to the virt-dma channel. I can send a small cleanup series for that.

Best regards,
Koichiro

> 
> avoid duplicate it every dmaegine drivers.
> 
> Frank
> 
> >  	dma->device_issue_pending = dw_edma_device_issue_pending;
> >  	dma->device_tx_status = dw_edma_device_tx_status;
> >  	dma->device_prep_slave_sg_config = dw_edma_device_prep_slave_sg_config;
> > --
> > 2.51.0
> >


Return-Path: <dmaengine+bounces-11726-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0+DrAXlcOWp2rAcAu9opvQ
	(envelope-from <dmaengine+bounces-11726-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:02:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B36B6B0F31
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:01:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=rjtdwMKD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11726-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11726-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACA63037164
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5973A254C;
	Mon, 22 Jun 2026 15:59:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B3334688;
	Mon, 22 Jun 2026 15:59:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143982; cv=fail; b=DEcjwy9PRyGF6uuomAVkcnEeOCwfEJ60v6F2o3kefMvkKi3lnW/PRL0hnSXOHlZBwuZoZHGEpUEXd/ZVJ4i8hLGEiL0C+DyfqtmaIfendvkmIIBMvkai2Jr8/fgLvs8zfxNkzX+XnmIs76NoMbCkNrNipGSfnwXfpMU1sWjMVoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143982; c=relaxed/simple;
	bh=4CUftPnKKXtssnEgbtbPWZIZvQS/RUa2RGRAvkVRTD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k26T50jayuzEx5ntVWLoNsvYNQWpc8MRxRSl50tzmq/SUv5kN5ihyOUOYiFyId9P1QqizUc5rpy97Vv+ic66W0xwHvzMtszHbTvbPJ6AQCacrv/Tr7meCdxtbXIpZ4kY6LWGDM7F6raW+oE50yuIDwy/hX5RiFzhQUl6otYubXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rjtdwMKD; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWd0OHKuAsvvkuqgQ9Cn7rnlPe65JsGL1ZlrlQE/eIjsiP5ieWMe2qREq+lQNrfuaML0Eh1RUho2txhNX0RaUv1GVp2zNNaycDGDLxp3nx2i+YZLaSuq7KEwHjqg45PDGuSMacsS3kTqx9R7V8Br6Mobwu/xKnxQoLhnSx+fd8QORMNlHwiRfTfi/UZOCcbLjxsxChZYdz66r1kjCquEVFymGx2ShF1AacUIGYflN0YMhoKWBgCXm79KcJTjbORBrgyKJHSzrQkY9SerrEwct8j9bn3DB3GyDoJYkwNIrXqjOkk4mRH7nyyJTy4c8W6kAEE50ZoB11xJdxHtVPkxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtGKmEymH+B3R8a7u7LpatUnAYbwEZabepokNkRQvbk=;
 b=MTNQs0wyvaawabww2P7hhWzoJIRz5VRcQj8cf7XmN5aP0ECgg+Akj89Z8FimlNE9pI0mgVId4TuUNxqJHzcbg9i8HqU64EE6t1kmrRCkUdAxYy+NJGNloh9syVTm8044WB9jXJXQAG4Qv8/mpDNDAPgBfyW65fk+dsDsFMF0gXGFtd7A9q7DXLqN7FckYtsQs42eXaHjN8b4nUTz6j6RnxW+1i5UYrsBYCSccJYHW9yIOmna3X+HozqVax5yBnb2XKQc9VEqlxZr53f+sfW1OQ59xkyqdLwBHYuCdStl/iC3tZGBUUI3yv+TEQBXIvpXFKNadNEyXsopNHqxZ+8vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtGKmEymH+B3R8a7u7LpatUnAYbwEZabepokNkRQvbk=;
 b=rjtdwMKDQVEY+ieehBvFLA1v2Kfp7BdCy/u/lC86aauSdobLSAkwSdQdWCnLbkzsPk1GMon8k10QgKzo6oHKt/c2fzRHUuu+ZpG84XlIzqrEdkE+s2G6Ltb+zdHxNr5mFko2k+3GCENTcve1gVFrAzwDEosAS/t+Auua/5E63e2PzzLMNFXtbhKtOdTYO3sCYW56a00oNPTCOmsOZYzqqALZvpC7KM9gW67wP+zQd2FaZ7RHlZOvNbwvufFamQysLcPQIoDleh7qCtgHnOkKhnjX0xgPQ1JvpM+EE5PEzpdpwKxUCCFGUMl0EEdgJSHNFCaI0ZUoWftKpAgZNGPGlw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB7135.eurprd04.prod.outlook.com (2603:10a6:800:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 15:59:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:59:36 +0000
Date: Mon, 22 Jun 2026 10:59:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <ajlb3oa8OZc2OWYK@SMW015318>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620170040.3756043-6-den@valinux.co.jp>
X-ClientProxiedBy: PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b40a6ac-bbca-4467-d356-08ded07741f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|366016|18002099003|22082099003|3023799007|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Wc88i6aRlO9fX4sVWBagZwpLGCWLChyqLPSwXUmadEf+ZLRVDxx+0pykCy7gpiXHe+5UuZQBfCmiuxKKwBpjWvj6TuDnDgPV/EWJsrIUOFAfxSj/5FU7yHGbM4vCCjyBqZV5vuCTyKe8k53NQvEA9sUZRx7zBxf+pMZzPHM7VrYAw982y5Bp+2Fq2jzzCZbOagPiHG3Ng1GVXtyKHSlFXPmrLG6w3dJB4WPGt78FJ7tR6RbZVP+SQqbgQCaE/m+JodPyXZLny93vgHsLid8sXYFpj2IxvEyd/OUGVZ8H49JIlIsx0953EDzHpS/g6k1mfJZW4H0oJ3Fg9Hr36C6OWHE1woDr5dhDAs5wARduv9vmK8RqaU5QZdsIBqdJkyYtgQ0BMwFuCO0eltVtOU1OGvaRXxXgCQ9Bt+QRCPFOmqAKfREIJpL/RqK5BCJ+s9jk1Gx+Dlx+DxI5FBO2fuuGlFGXPqgsu7t3pLLZ/+dBoefO1vZyR+4ONdN9esDtfMTc16aScvX/QoPrLMurFaYVThE31mASIvfHQQWxI6x6B/G1zvF2pBMU1Tgv9GVRQpuJ1TG8d5rD2L8msblftC1Epso+jxJ8EIgUB48K6s2m69E4KN9pEb2335bojEYEln5iuLezVwmEQyvT8ehUJ/x50jOBQO9HWjM/ulvCZ04Yz0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgsFcfO4YWFcEXN0FfQ52ws/4u0JolJGPoeisYarOHLpHm2xiEMKfws2LIFM?=
 =?us-ascii?Q?AT2neaURomTx8TRu2LpbqUPIUxqX4KFb8UiEPohDAwRqdLQW4tWRUfNMYrGQ?=
 =?us-ascii?Q?QR0FrKwL6tR6ovq56sbPNYh2KZnLSNd1XqVSdbNGHHkJkTE31Dyr0UZMkGAq?=
 =?us-ascii?Q?xTI0+8cQ7xlARGPU2y+hXNZ/PPUzVnPqCUsF/bzoQ/35BWmfbUZuZu0mEc5V?=
 =?us-ascii?Q?TpqhE0wcaYA/ATLCf/pfJLLImSX7namvSFaEzwtDo2z0TL9r3a8xY495kN5P?=
 =?us-ascii?Q?79Ec6zu8OfUnMZrhRSMuJ6u8pIxulHci74wsSHf1XRpA1ve61Ds2bCryCRxM?=
 =?us-ascii?Q?DKhMiLQhADu5UUCmXL6QJaGkWjqTzM9y25yJCmrUbcX0q5p86Q367n04TxQe?=
 =?us-ascii?Q?tZ5GtsNUz+kLPotJpouQC3LS0sBgd6fNet6AY/o8I711l+9BQSTFyfFBAX3+?=
 =?us-ascii?Q?Ws2LzbLjBnE4qEHkQxx3slR6Ca/d3p6WNj9Fx8Abgg4uZlb4gLPtW9LELZ7k?=
 =?us-ascii?Q?bjJS35JK74OiKUaBlI6KDY+IWLuLHrcNM7Qj76rewxBaHh4A/szQxyarPlcj?=
 =?us-ascii?Q?qczIT2NH2hR1Ex7gXiJ/wuR7MOZigcTSEE81x2W/0FJrEU6APLxVWqJDDf6s?=
 =?us-ascii?Q?SLIFVQ4Rm+6h0bSu6QOEgpGv58iGojiC+sIothDSClMX94aNH2SZCZxLoQvU?=
 =?us-ascii?Q?3DV9PRHH0SXzgsLK7OaQ4iJzGfp+JA6iAj0xSxiV9mYd8TKDmSH8Rj+oFX0W?=
 =?us-ascii?Q?SCEeMAjWBqz4C13k9gIODRo93MrNhKRLBzpVRfhHUiJNn0+0ylDRQm3pFm02?=
 =?us-ascii?Q?3ECBq4XstHPKTGan/LwvxiQeMXUrK4AsmTBICds4JBDwn6O5UgQfjkOWAd1l?=
 =?us-ascii?Q?AvY6uKA2J5ieGRB7ZxjuQCKhDHeR0LDd8xAphPtwFUcDg2W0pO3K1/Oe88Fp?=
 =?us-ascii?Q?IL5WPFwlMOuKYb/UWStiRzW6T4mKQe9mOvr57gdsY56iAxMlhFaHX38S4xh2?=
 =?us-ascii?Q?f89pj6fh+Ji+6EwtzVZ7lE1sjRqabyh94LRB4FFJccVc/tUjVMsWOzqYwAXV?=
 =?us-ascii?Q?/bdhWpuWWhlUv6YSeLsm/oMDLJfh+Et9+kXmXvgWwUHxvI+vPjvNzHnfBoYH?=
 =?us-ascii?Q?QzTZNRUmEgoTb/OvAuHwMswTu33rrk0rNo0JjsFrNfHbAqfRf/Byw4mLOe0a?=
 =?us-ascii?Q?2MFT5r3bmaS93zH2fa5JFXO3cj7Jb1WiNT++ZcyCQ9uxJv2WhPN4Ei1RzYuG?=
 =?us-ascii?Q?MYkED8icRY1hXs6PdsQtauAqRBw0jl9eaZJS6uqrKZ0yBWuu217nv068INLn?=
 =?us-ascii?Q?DepvnZQWVgHN+vhVWEKNsCBG+vImoVFLu8btE8h+0UIwARBFyAP/Bur7UYBN?=
 =?us-ascii?Q?uezxXLQkLPQMVQiZ350gp7MiAUkRcZflcHRYh8LYw6HGarsVFDnS1kEKmeTP?=
 =?us-ascii?Q?HTNQFb8PXUFZP6uymCQZhx0JGhVKYy0yNdAN7xN4gD7r3WPMUc0VMH0eX6bN?=
 =?us-ascii?Q?PLHLIrpmUB7ZPSrrWPMKuBf/JHT4UP7bkwukkfKnmRF42zZGejgYOlWO4kSS?=
 =?us-ascii?Q?B81q53fX9TlzuHLcDQNNwlgzA6qAD77eH6xRF3ihpjTMUBKjCyNjvDnzmYjn?=
 =?us-ascii?Q?Kp/4yGjRaNAAk1UKerWObMXKFd9Y5HN+AVBkg3Ct4ki2Zex4NnJXSehAIx9T?=
 =?us-ascii?Q?wYo3CTfkjPvreqoocMAfCqatFKCbvVOHdwXPiJEwHcukI/KKmxbJDLI8fGHS?=
 =?us-ascii?Q?ie7cyvoq4P8iJijBmpH3Mkw3Qkbyp75U1DvP6xxAsa3uxdJL4dNQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b40a6ac-bbca-4467-d356-08ded07741f8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:59:36.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUiLaN2z7Ud/hPcianmB3oBDcsgW6lgtL0qp9IYYkozIx5m494fHA3/3g06ky5dIruBgGQ1PYo1hsAjdI0A1a+56gz+veBMofO76usytEnVtGhDDBG26FFpR3To1CzJ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11726-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[den.valinux.co.jp:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,SMW015318:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B36B6B0F31

On Sun, Jun 21, 2026 at 02:00:32AM +0900, Koichiro Den wrote:
> A DesignWare eDMA instance may represent only a subset of a controller

s/a subset of a controller/a subset of channels

> that is also initialized by another OS instance, such as an
> endpoint-side OS. Add a partial ownership flag for instances that must
> preserve controller-wide state owned by that peer.
>
> In partial ownership mode, dw-edma skips the initial core reset in
> probe() and uses the limited quiesce path in remove() instead of the
> full core-off path. The flag also makes the driver validate the
> ownership granularity required by each register layout before
> registering channels.
>
> For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, the driver programs
> per-direction registers, such as DMA_{WRITE,READ}_INT_MASK_OFF and
> DMA_{WRITE,READ}_INT_CLEAR_OFF. These register layouts have at most
> EDMA_MAX_{WR,RD}_CH channels per direction, so the capped hardware
> channel count still represents the whole direction. A partial instance
> can therefore expose write or read channels only if it owns every
> channel in that direction; otherwise two OS instances could update the
> same direction-wide registers without a shared locking protocol.
>
> In contrast, HDMA native uses per-channel registers, so it can be shared
> at channel granularity.

Not "shared", each channel can be owned by local or remote indepently?

>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Allow partial ownership for HDMA native, which has per-channel
>     registers.
>   - Quiesce represented resources on remove; v2 only skipped core_off(),
>     which could leave those channels or directions running.
>   - Revise the commit message.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 52 ++++++++++++++++++++++++------
>  include/linux/dma/edma.h           |  7 ++++
>  2 files changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c782eaa12021..d87791205837 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -750,6 +750,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
>  	chip->db_irq = 0;
>  	chip->db_offset = ~0;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		return 0;
> +
>  	/*
>  	 * Only meaningful when the core provides the deassert sequence
>  	 * for interrupt emulation.
> @@ -1081,6 +1084,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>  	struct device *dev;
>  	struct dw_edma *dw;
> +	u16 hw_wr_ch_cnt;
> +	u16 hw_rd_ch_cnt;
>  	u32 wr_alloc = 0;
>  	u32 rd_alloc = 0;
>  	int i, err;
> @@ -1092,6 +1097,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (!dev || !chip->ops)
>  		return -EINVAL;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		switch (chip->mf) {
> +		case EDMA_MF_EDMA_UNROLL:
> +		case EDMA_MF_HDMA_COMPAT:
> +		case EDMA_MF_HDMA_NATIVE:
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
>  	if (!dw)
>  		return -ENOMEM;
> @@ -1105,13 +1121,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>
>  	raw_spin_lock_init(&dw->lock);
>
> -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> +			     EDMA_MAX_WR_CH);
> +	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> +			     EDMA_MAX_RD_CH);
>
> -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	if ((chip->flags & DW_EDMA_CHIP_PARTIAL) &&
> +	    (chip->mf == EDMA_MF_EDMA_UNROLL ||
> +	     chip->mf == EDMA_MF_HDMA_COMPAT)) {
> +		/*
> +		 * Direction-wide registers are shared by all channels in that
> +		 * direction, so a direction must have a single owner.
> +		 */
> +		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
> +		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
> +			return -EOPNOTSUPP;
> +	}

move this check logic to helper function.

Frank
> +
> +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
>
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;
> @@ -1128,8 +1156,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
>
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}
>
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> @@ -1173,8 +1203,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
>
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		dw_edma_core_quiesce(dw);
> +	else
> +		dw_edma_core_off(dw);
>
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 0ba8a1143fb2..3c730c88f0ab 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -55,9 +55,16 @@ enum dw_edma_map_format {
>  /**
>   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> + * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
> + *				owned by this driver. Controller-wide state
> + *				must be preserved, and layouts with shared
> + *				direction-wide registers must only be shared at
> + *				direction granularity. Layouts with per-channel
> + *				registers may be shared at channel granularity.
>   */
>  enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +	DW_EDMA_CHIP_PARTIAL	= BIT(1),
>  };
>
>  /**
> --
> 2.51.0
>


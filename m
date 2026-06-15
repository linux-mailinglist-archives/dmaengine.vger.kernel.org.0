Return-Path: <dmaengine+bounces-11510-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzhmFJ6ZL2o1DAUAu9opvQ
	(envelope-from <dmaengine+bounces-11510-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:20:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2192683B95
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 08:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=FnEUNn13;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11510-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11510-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40C26300BBBD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5F3B19BB;
	Mon, 15 Jun 2026 06:17:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F33B0AE9;
	Mon, 15 Jun 2026 06:17:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504270; cv=fail; b=p/SiW2bOsoFkhtEyU+8n7MA8wT5u5rTPJxg/4Xf8hD0O8/P8HBjEHUk+tphevPvJsgJuCRqUhoClCgcKHla3fv0MnCXkT35gSo3IfEh9XRTtOYw5SbG/sb+qWezcL7BTFj/AEhj8JgjI8C1M8RNTJnHPOVFqP0FeVncIDilB3x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504270; c=relaxed/simple;
	bh=4L1YTJTvILFLTalCIPLfcBN428CCSKqzcGgHHpDOWU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l0ktYWOlCYqbcrwmhTGF4HBbWtPMTLF0SWyfk27HHbQ8w1voER9Dppien1iZfn3z2gd+JTh/tyzU9tJoNs2eekO1O3unBgbgzvVSmWs4kW+qtwPZ3SprIwhFLGnAucN/quMvanT1ZU90yJcDfUAb+RNrr5fsbuFL5vGMq32B0bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FnEUNn13; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJtgku+rLiq4xsGQd96rYs/8THFNiKZpq7hdwOgiPRnPE2YdwcLVCnAfj9jv+klQ4fZW6lH79O54SYKbbVYxVGGtEXp8AXn6pEXzOEtylb1plK6zYBvoV5n6nT4PgPK+ZrtI6pLELjYogJKbMfn783hI/w91v3hHN3yCtRdOgKik2U3M3jW6TxmuHEP2ivuTutwKvzE16JiMG+GBjltuQG3Fiv5gNAegf1P5rzhPTXI5rcS21NLqmgUE1YPKQSC0M5vf2BVrgA5zF0/WyXt1njsbqLD/ls6RjwvVEcNLP5kqgVK2ZFfHzM+nj3jNwNKTZlq5oF4NMAeBzA/nrXki6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGSikzDgjztdJ3Q7JkFPGEQ7ryVkE1QRQC8t6acVk38=;
 b=F2Gmp+N7+5WbSTDox9tS3X7pFPPjEjv+gFQ0MO2vK5bFe9UTaz52WpUdG1DnHCvMtQbitpWSJUnwcNRHULUTlNOEaCJm7PBOJeEjmkwqCbzWjLBcQZLdaSmWe/pmKs2q1Sdff1ZQYUwh1wAOqshtUyJaaXufU/FupZUWJp5HDRl+u1x2lY/Kv5BqsTv8OGaJAZtKfB6h01P4pSbNhu0BcocZUax9hLrfOM/NqJoO0XmMyP5ow0Nq4bP1dC2rsU9/URunMtm3+Uy3COP+XZxCbdyJ+ykyN3JpoEY7lxOWygHMWIFznUW4eSQhEJUulXYq3jwk7WW5uBSBwPdMODeUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGSikzDgjztdJ3Q7JkFPGEQ7ryVkE1QRQC8t6acVk38=;
 b=FnEUNn13czUd0yGypei7QYl3b02mnVSGtMfoIQGqlUE9n8Y3T8TLDT89WbDKY0vt10xhUhBZe+Ch1b9VLM/az3VrhKiYhf3NLe7eUSnbYWzRDoMwI06YeWEUwHKDuLIqRJIlE12WXu/ncPOFeJXb0FyNPwrIXS+KB+yC3JPhbB6lzSxfWqfBgElJFmKJwDrK6ehBX1+bNR1xMyDAwcGbxu6y/HlCVOEJDYzwz8cqe95rT5pd4lbW9l2XHGsIYMPhco49Jbx7obMUdFjqQW2RfkbsHXM926svm+K2tUBKlX4Jm/uuNm7giNmwlCiCBv5Q/823u/hWGNFtQXqm1momzw==
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
 by AM9PR04MB7697.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 06:17:46 +0000
Received: from VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de]) by VI1PR04MB5807.eurprd04.prod.outlook.com
 ([fe80::3da4:2827:d637:37de%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 06:17:46 +0000
Date: Mon, 15 Jun 2026 14:20:56 +0800
From: Joy Zou <joy.zou@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Frank Li <Frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] i.MX SDMA cleanups and fixes
Message-ID: <ai+ZyPqPy1q1P3W7@shlinux89>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <aZ8cVP7E-BOEJKFu@lizhi-Precision-Tower-5810>
 <4srixmuzaay4tetvlgribjtri5rm7akycy545vrg3d62ifmjsg@iflrkv65u3k5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4srixmuzaay4tetvlgribjtri5rm7akycy545vrg3d62ifmjsg@iflrkv65u3k5>
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 VI1PR04MB5807.eurprd04.prod.outlook.com (2603:10a6:803:ec::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5807:EE_|AM9PR04MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: ba46284d-ffcd-4eb8-8175-08decaa5d115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mfDGz7Ovbld/4P4AKqz2u6IST/7UIXLeoEJxMi0TPLRfCzshe52eixr+nVKtLJoOcRRlx8ux0Douqh6f7kUnXukoFAorOocXcjRcZ66/ZenxiIxRLLH+CtcVDRt/A6qyAC5xozWHlki/cVQVBuaAZI9AXIdKFJa/rOwMXzxjH3YVKxlxHA4qKQOy81y4UXxo2QWoSGMyxo5DUHs6QV1grFMvj4KGgZeMTUDm5uvZIKcT+O4XrTrGDKJf/pGSmoShGMpJPEB34HGuYLpcuAAXoeCyZHsVQ+WxM9IMdkzaPZoYVGCoIwP68RCw8G/KUTS00GiURNyicH08DvmJRXEC/GFonPX2w1cuVs3kmycd1PC6ywxDi+9rqokhm/plC6wN9rng6vTM57lm4FarKDmr/Ta1pfnR8WGuS2fbAueerAPLlyfrI2YJQEjp6j7zbRskYXUQlbJlQbD/sUacbMBixh453byESTqpLyfI5f6b2FlV7mpiugrlEO5ODUVJHXUKAbS3WpqSltKj1yKsWzuhhmpfKEZfExnEdzSiYYtGD68mQTQJ93PNGiyIwnfFX4M4kTqBkJRvHMVnMAbtps0P+0Dqu3tMZVHRiNDziwZWjG9Qkfw3t95vZConoSutOyeuiI8tbO4eUP6op/FPBaQfMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5807.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqoIqvwXuN2F7cP7LdsKsZKVz6q0Vp3vPCjjwKq2komHZHAFhB/Ubh/fADyJ?=
 =?us-ascii?Q?S0tUH6cB/z8lqI73veXRPS0f2/XpeF49F+XoJC7yXYZafVpY9ej90q+x85fL?=
 =?us-ascii?Q?g1BVpQKYbh3gFPyhANJEfaIuKkJZKt5NvwHMr5F07MGijOqEUkshSIJWQQmV?=
 =?us-ascii?Q?13tmd9hIvMUElaKtkNNOoYIQ7UFMsppSyWKB5ohi5IVkoaFxdckHtYXCJeYE?=
 =?us-ascii?Q?Ki6AtZUjr13C8b/vr3LOBka81mFzudhqsevM09yBE/m2UtmkcQ3QnD6Rzu0n?=
 =?us-ascii?Q?mmArMIB09n36UEMQKmfRurKHEnGBwCy/KkY6bSJ0Jw5EOptu35ToyOadkbp6?=
 =?us-ascii?Q?mS4EbjzNLQXtyB+DCGLFxl1+8AiXJEvEGA8m2Exh2eoDuFbDauDo0XX/cGsb?=
 =?us-ascii?Q?z83hcyjN2NC2R/19OKFxGHqmmZYwY1iuBB1XkT/M2kFcs+1PToJVfxLcDF9u?=
 =?us-ascii?Q?NlAl47r+0MVrUzPcD+tFsetJNx4w71CVqnLEykn0cKrZTLGJRP6RblLO2lc2?=
 =?us-ascii?Q?08kWEbzu5jc19bDEQYfnB2T58VVEZkB0XkanycVhLmxjCzpgEVZRiwXqAC95?=
 =?us-ascii?Q?+YxjmU7cVg+i4zn1VKl03VqeRlazH3TbXw15r8irN1nsrvmj5qn4XXvbms/B?=
 =?us-ascii?Q?IyL4n5tS2eyaMsKcsW+AD7yQhu/jFrd864K4F95xz+269CqTh7sWGIQ1IbRC?=
 =?us-ascii?Q?72Rm39dqoFv39HHfJrsK6J9mQ407M/Ee8j2raaRcEPnlE5KOS2ciApcga8N2?=
 =?us-ascii?Q?269b5VqewRzr7AIAWbvyIyJz5vuswpm1RwrfOae1TgnUrTTTeil/vwO5oG2U?=
 =?us-ascii?Q?QI9y+v6/AZOwJqY4TCwIaCDjo9AjyfIxKG+0xHelEgsQPm2wz8iGZodQIYOT?=
 =?us-ascii?Q?/XSRHbOFX5/Hyvc3ITj+C7H8qBEF9rZwueb4PvBpg8sPWymBb2OA0NnrAIs6?=
 =?us-ascii?Q?CedLSe1qEhuVdXynQp0mhsO7Nr28qzlIdods5a1rxM5BwIOUAhs2Dfi8kl/a?=
 =?us-ascii?Q?yED5B90eqqDn9jBmQfKfkNbtI3b/DEq5cKc/dhiICZCUw4lc9pz9HlTp4u91?=
 =?us-ascii?Q?ChouBjux9QYrVTELGxkC2MhmSEwSx7HFPAf5ew16qq/UHtOF8ZAdITdcRsfl?=
 =?us-ascii?Q?HT7jylOopn8AqEiRxAnPryy3tjjNqHueFQsLdGRG2NrWS5zQ/6OOZcDRA+ky?=
 =?us-ascii?Q?4XqHtOT2K74g7FGvV9u9NkgXnTCjQjGSPhnCS/iM74Sn+C6Iq7fvg1qxbn5y?=
 =?us-ascii?Q?ASnrXhPr7Cf0cbckVzqn43/iYRdXijVJcLjxCwLo23SSKTs8LkKtJxf82gK3?=
 =?us-ascii?Q?ZaE2gwsQxHkhZ9TNy1viUIkpLHFJG4DOAsZYj0BKR06JAQAR6pik6LJaMsBl?=
 =?us-ascii?Q?8boB0ky16KUT3f99g7ZRhNGxiHw9IY25Kx6qOY9pjOWEfDgHA5MhOR4VX5Pr?=
 =?us-ascii?Q?lgwjnOeXzQiBpoBOt959u5KXWsNItyO63Ja1pAAXOBl3i6sDLf3l79axZRST?=
 =?us-ascii?Q?nCjWqn/1xpBeumFZGSfRwu/giQOijK3HZQ0XfRjEBUqwPKb1oo1yDokZnHjE?=
 =?us-ascii?Q?y+DDw48F1rcuDxmDI8LZpxGntypdFWYhujXYQuJP/oLAe7IFdydsmP4Ryo+G?=
 =?us-ascii?Q?G4QIqxg88j6tZdLoAuWRmC2MfxtuXDPzlNHvMd69xUdxQ1c6744wj8S2eQa/?=
 =?us-ascii?Q?rdva9ndpyVWxxubZbJvSqXPQoeBwgqYZp643vfX4Wok/YYWXeGtEu0Nesgp0?=
 =?us-ascii?Q?VKljFyt9ulY1uF8Cxb97o3WkgbrnYYe7ciOTT5mtq6QIr6MfwlK5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba46284d-ffcd-4eb8-8175-08decaa5d115
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5807.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 06:17:46.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW8O1fryhekT1YJrjrUIS7x5zdZYfPS4URKaIsrBj6sI0oaUrtNsX8ztyuz7P+2nz47W07kBIIB9gOgzwVc3veZXSP4eeDVkqpu7BnhtFpgFrJMQ2BwKLxWB+WLTXlxm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7697
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:m.felsch@pengutronix.de,m:Frank.li@nxp.com,m:vkoul@kernel.org,m:shawnguo@kernel.org,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:jiada_wang@mentor.com,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11510-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com,mentor.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pengutronix.de:url,pengutronix.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,i.mx:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2192683B95

On Wed, Feb 25, 2026 at 06:05:33PM +0100, Marco Felsch wrote:
> On 26-02-25, Frank Li wrote:
> > On Thu, Sep 11, 2025 at 11:56:41PM +0200, Marco Felsch wrote:
> > > Hi,
> > >
> > > by this series the i.MX SDMA handling for i.MX8M devices is fixed. This
> > > is required because these SoCs do have multiple SPBA busses.
> > >
> > > Furthermore this series does some cleanups to prepare the driver for the
> > > upcoming DMA devlink support. The DMA devlink support is required to fix
> > > the consumer <-> provider issue because the current i.MX SDMA driver
> > > doesn't honor current active DMA users once the i.MX SDMA driver is
> > > getting removed. Which can lead into very situations e.g. hang the whole
> > > system.
> > 
> > Marco Felsch:
> > 
> > 	Can you help rebase these patches?
> 
> Sure, will do.
Hi Marco,
	Are you planning to release another patchset version?
BR
Joy Zou
> 
> Regards,
>   Marco
> 
> 
> > 
> > Frank
> > 
> > >
> > > Regards,
> > >   Marco
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Changes in v2:
> > > - Link to v1: https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de
> > > - Split DMA devlink support and SDMA driver fixes&cleanups into two series
> > > - Make of_dma_controller_free() fix backportable
> > > - Update struct sdma_channel documentation
> > > - Shuffle patches to have fixes patches at the very start of the series
> > > - Fix commit message wording
> > > - Check return value of devm_add_action_or_reset()
> > >
> > > ---
> > > Marco Felsch (10):
> > >       dmaengine: imx-sdma: fix missing of_dma_controller_free()
> > >       dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
> > >       dmaengine: imx-sdma: drop legacy device_node np check
> > >       dmaengine: imx-sdma: sdma_remove minor cleanups
> > >       dmaengine: imx-sdma: cosmetic cleanup
> > >       dmaengine: imx-sdma: make use of devm_kzalloc for script_addrs
> > >       dmaengine: imx-sdma: make use of devm_clk_get_prepared()
> > >       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma_device
> > >       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma-controller
> > >       dmaengine: imx-sdma: make use of dev_err_probe()
> > >
> > >  drivers/dma/imx-sdma.c | 181 ++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 96 insertions(+), 85 deletions(-)
> > > ---
> > > base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > > change-id: 20250903-v6-16-topic-sdma-4c8fd3bb0738
> > >
> > > Best regards,
> > > --
> > > Marco Felsch <m.felsch@pengutronix.de>
> > >
> > 
> 
> -- 
> #gernperDu 
> #CallMeByMyFirstName
> 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> 


Return-Path: <dmaengine+bounces-11335-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ilwLIH7JmqnpAIAu9opvQ
	(envelope-from <dmaengine+bounces-11335-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 19:27:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050265939F
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 19:27:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=go+4wNQQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11335-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11335-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CED32996F7
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C03769EB;
	Mon,  8 Jun 2026 16:25:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451533F8D6;
	Mon,  8 Jun 2026 16:25:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935940; cv=fail; b=M88Yo/ew2iw7RCXfo3yXS0YTcM36/3yWB+FjoOcIEoaQRUodSOxF9DCeCYNecdp0jkDMOJ4u1gPdMrriC2y4aYgu9w54Se7uSX1+FQ57zn+2vNT3W9/FfD8WVJVMYeZqpgS4G8NvjXeze4QkB4OwUxK7MkyefHN0SSXfwgyMLPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935940; c=relaxed/simple;
	bh=KWtO+Cm0lNTInBgJnuOAA7rsS2PQlzVHcG5eHNk6Df4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGju17R0LvcLxlrZXMPLqZgLXr5afzXGv1JGqofKD28xRGSDrVInBeK9cnm4vA7cCwRmafmkrOqooTHdiM5C7qjAwjq/FqWAfq3OoIpSicyGG3gR1rTXyboerW33Fq3RAHt01aby/MfZgNcYHRF6XPazdfvCNN1HRQXYY3OPie4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=go+4wNQQ; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1sMeLAonbI6AkqeNFOvg/BbSgMooXtZDUJi8trrnrP4LV/+OWWxRY6CiDwYbtxH3z/bwoLoymrh+RZubb+jM8qv6ZDBsGki2QJhFSLSCe6Dp/hlpXN4JfVQyU7ybKtXN7SzzRcUDe27wfDSUnGf7lJrsT11nReWt20woChFsKCvuqa1ufbambTBCoJqmlHcNMPN2m6xaxJC6DunSN36xiaRifwIPSIMfIV4ZrTXP8r1joqVueZ01Fr+BAzMU0kVOYQBnWNJppViDmO3UtewbxXnD5mQ7tDcEQ1JUwHYgnx8ZPDl8nPsD6yZm3wEYR6XV74txSPFKZuas39uBWfbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWtO+Cm0lNTInBgJnuOAA7rsS2PQlzVHcG5eHNk6Df4=;
 b=Hf0Ee9q5Me9R+jPldAQMFdj8lYcUXIkSKXvN0dYX4tzcQAlR18CCZlenNiQL0/kI4J5x7eyieBQtCI9WYaSQqi/6fnKnMc6/HRFfdjroz9wjDScfcG9vTDN++9z75zBMVlmPZVymaetafBoOhMdFWwcbGg+gPWNE0/Xe7p7yg/gN/pzMRSsL9ZdX1KrhipFXnq27ZI3RmeeZyrV9MC7dOmKM3xunUfg//4uUAFL2rsEsLhujP58Cj5eSoOb8XxuJvIcQUEOTShKemwl7Ue+n0bvAfqiLyW0ndFucn9vJLrXlbnJXO48j2SbAq/k7HGj3AenTsaJ9UcTbmEYDnyyKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWtO+Cm0lNTInBgJnuOAA7rsS2PQlzVHcG5eHNk6Df4=;
 b=go+4wNQQeKd2ALKLcaW2MtEYdpAuIi8mjUYaCkvCtxBa/DC1qRD5xBNI18I+2Cf6RuFQdMzocy2tYDecSAa+fIi/9y1eRZYy2qHno8HUS136RujPeOh/MjvsFFKACVQxKT5Evuu5ZI5heR4NnwEC/BVRdBFdVKA/jupR8YQor+Q7cW21AT+9uf7kzdJ0KSSNreiv/BUpn0kx6uGSnTh6JUbXk9gkVVJUIp56xRfyKqtJb5uUU0mWGqP5mZzbZ0PzUJYfABuUiEwquGSLPAnvtsoQfc75JUd/kQoaMLEkTXRj6ryg7G1CQundj1DfQG937RiSWxMcK01Tc7M1cqvhKg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB11560.eurprd04.prod.outlook.com (2603:10a6:10:608::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:25:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:25:36 +0000
Date: Mon, 8 Jun 2026 11:25:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/STI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] dmaengine: st_fdma: simplify allocation
Message-ID: <aibs9gb5M4-gbCFY@SMW015318>
References: <20260608051829.7390-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608051829.7390-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB11560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9959639b-9d4d-4b71-3d07-08dec57a9201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UKn+sgmXV7whsM+UyGDFah/m/Qou4heDJ7eZy7lKKoXlen8m6NXJ332Tr/edVIY8tWAfovkdNqz0cAG/XwuAZ8OS++9RFJmkEFM0sFXHuLJv0kiJLhpFSXDQgwnvjNUq8ioIw7qajpVL2UMiILkaR6TBXlQolg6HVgu/137hDG73GK9g7j1/tprYQ3uxAsWaGBHStlqkIilw6dtSLcdg9ca+YLOo36xXIvU5lvQwWGJSX9EeZXDDEFzGbDN9bCmVC0/+RHsB3D5BcpNW9zP1jMoARes4Xx/y7QwcSzkRiqZESyp1RMw1hriQqbSb5VkXe+9IIy04B4Aq98VQDBV/zkj0QmRiCzTcq7+mWTcflnAQ14YpZhg85BE4lHDIUDklO0yJ6HxgA9f60hBtun62nFxeU0xLO/K2MY/BLl1qc2I/89tMfQ2QNHMc0AIyp0T4s9A4n73dNSxSeqe8cRk9gTuGCfb5GtG7DmuHOSK1fRvqC/i+y+xbRlUWesAmYH6caP81v6f31Pn6DE+RSCw/pz5GIJaVeaQ3J72axXXZV/z10+1yihOtzCC54RWQG8sOp0Zisi8SlzqvqVr7C2gF+u3bj8dUIbUZv989G1sbsbC+yYvn1I+aYGVIXHQKnEWLqfCjbAVrYIbJwlY9kInEsSfVxdq9i+5tfgbwlx98EgPSfGfPA54USTgtOysw/lj3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXDbEy6oNSopdTDMxXVs4a4ACm5Zb9uAj1nd7zejFrZMM46SnUyGSPARuYwK?=
 =?us-ascii?Q?RkhVOfMrLKlyUewqE3eY93dZiiC1eismQZ5CJo28a4Obm7jU97m8mEvuN4dr?=
 =?us-ascii?Q?WbJoHd3FFZp+t6Hki69cn9h2oRx/n/zBxyh/I+S4cRXc7d2Fiw0q7XRZ0T1E?=
 =?us-ascii?Q?qyqysrfdHfoLh02UVgTDvERHRVA9+3DtSRcZNnf9i3W+LJv/W/JO+N9Xyqk0?=
 =?us-ascii?Q?rLnIFbYoSEGA0xUt8UhclUqNns4Grbw/OfqX7p6Mm3/IWEBxKo6TXadg+pdk?=
 =?us-ascii?Q?nF9t3TaSfWWvRY6jv1LA1a3MOasNVM8mvQ3nHatBoCrICCc78XzHUOGmNSuE?=
 =?us-ascii?Q?bLwYCVB8uAA8t3kW5+OntsewQmMxZXv7nx6/jDVM4hEE6Y9od8CKOxg4qMuj?=
 =?us-ascii?Q?WD3uj/ci98wFcv+Ga79jl3I8yf/lBo4b9527+sGQDuQD1Z2QTi0HzN7sgsi1?=
 =?us-ascii?Q?35sXnCRhNjtwmMfeLwmcNNzhqSFtScaafxDVXWVzmitZjumLTOPBZY6U2O/K?=
 =?us-ascii?Q?GNXwEeswlN4XLpnPW47fQm+gy8vUA0WJLJl9ApWv45I/YTWDjxkseIP87SR8?=
 =?us-ascii?Q?A6VgPNUQrbkWOhzcbjmuZmCx7jCmFdwyyzr4yUqrzPGHVCgjBaWACnDLSEI6?=
 =?us-ascii?Q?t437grx6qG/IZFFMG3vsI8yqyApJ5yBAIYKjr4x13OD7CtgK66ki2Em1gZeF?=
 =?us-ascii?Q?AbFLJZ2lV1ZOG3yRjG4uY23v18UWKlhDELi2RJoBcxAPWSn4V5hbBWcWNUX9?=
 =?us-ascii?Q?16/m6m/44CFhZ03/lL9IWmY/v2SMxdC2BKi2/ZMTrhFNVMHFLmUKEYzn64vj?=
 =?us-ascii?Q?bqo2IVqOTJjp3aMC6O4RNLBGA3gbUVi6g/+zBkUdLWkZz7YB6O9a7msaxiLm?=
 =?us-ascii?Q?t+kft5YIqMdSW1IyPywt17dPtZLlB5fZ25r3x/ytP7R2NYMNwEBL2wqm/aM0?=
 =?us-ascii?Q?jiuYxm7A0uyk4JR3gAeOI18CrrhJCki3fhHiDs5ulLXV2llNB9ddIhwGKBSm?=
 =?us-ascii?Q?y2e9dVYqnB3jFNIdGqWFybBPaIUKFk4/bCn2sJFtul0E2hWZCEN7QIngwpBg?=
 =?us-ascii?Q?NKlEPFxoHv4E7HCOBQMqDRZzcKgqFP7Xz9DAYLhWfwbbBMftwFotY0MH7Tw+?=
 =?us-ascii?Q?sn4vTZixKHG4fRMp3hcYYISP2NCw3G4CrTRkpYl2CeUM/+qZJIYks4fhk46+?=
 =?us-ascii?Q?Czk5ANArGi2h6O8Rw9q8wTO+OQRPFvmur+vu7m1QH5Nw2xzFeL3iOY10HV6w?=
 =?us-ascii?Q?UMT9FDZntiCvqSINzsDvEBh+KHE1jOV3/Bx+lmp4qwW+KmVbOCYSnPU1a+f0?=
 =?us-ascii?Q?No84e1ZH6gn/zVRkhOxeZhiOlUrQg5zn9vNJQyzGsMsoU1Tg3/WGhVFyY+Lx?=
 =?us-ascii?Q?ZoL5qFdnSUGqLIGXburcmXGZohBGnqBnZt/swHd8C40Ot+RuWYfDJKT3OgKs?=
 =?us-ascii?Q?nhfD3ODbvWxAGN6iMcu47Eg7v02zM2xO9fEVwV5r4uOmwbj/xpKdETGWGFeq?=
 =?us-ascii?Q?WstQ/lD/Yu5rKMArjjJyRl+46hnPgMLEDjYuNWUpnZu8oCTG21KKYZtWFrfm?=
 =?us-ascii?Q?gHejsarZiw3QiuwotNHIz/n13AW77ncw3a96erTD81jogJnx3vz2ud13MpYo?=
 =?us-ascii?Q?vfGIM6xyQH4obaBMK6cXPejk04zYIh+9++xAc6gRC8n6VaMAwv8Tqms0qbmT?=
 =?us-ascii?Q?6FqjPf94JoFvvsRo8t58WEa5aPcyumSvqjBCf/X0h5G8kaYzsgOfcvYpiGHG?=
 =?us-ascii?Q?7vS7+JcL/Ht18yG0/bA3niePivMnU2Q9RLwEwJCEuOYBG2eNmstU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9959639b-9d4d-4b71-3d07-08dec57a9201
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:25:36.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+vkisIt7eau71STZEajW5dhhDuE3Vfhw0ZpGlJzE6wQF2Ax2VszFvwqdNGsKDPmmsp6tQT3S/C1dAARedM4CROtiWDYUQ+JE63xcurD6JDwRY3IjDEJn1NRQIr8/kyZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11560
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:patrice.chotard@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11335-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1050265939F

On Sun, Jun 07, 2026 at 10:18:29PM -0700, Rosen Penev wrote:

Nit: dmaengine: st_fdma: simplify allocation by using flexible array

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Use a flexible array member to combine kzalloc and kcalloc to a single
> allocation.
>
> Add __counted_by for extra runtime analysis. Assign counting variable
> after allocation before any array accesses.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>


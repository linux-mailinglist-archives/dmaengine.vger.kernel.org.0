Return-Path: <dmaengine+bounces-11562-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AvBEJV96MWp8kQUAu9opvQ
	(envelope-from <dmaengine+bounces-11562-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:31:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D6692296
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 18:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HF5VM51v;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11562-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11562-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D171E3091C02
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10146AF02;
	Tue, 16 Jun 2026 16:23:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3944DB64;
	Tue, 16 Jun 2026 16:23:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627035; cv=fail; b=D8g6VYCSrx6tpSixTeDfOvtFcpgNH6KxeWHtPBICAjX6cM0e/q7fQa+rxr9Kb8qL/KTh5E9LodEzI6HavZ8lMWHthYhdKqO/YrTlrVxO7+E9FDHTmi8h8xeWREgMtgXYCE47AZ2OH27Unw5o2W4Z7Yevqoj7uz7UigirawA8rJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627035; c=relaxed/simple;
	bh=V7lx5SWNkq6tYOPdkNmXTbWurj533bkQw5/iFgdMSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mZTpaHqa4KlpgI8oJB2OG7yYLxdtzxrH8ujpjzA16g/nTnojXYtI/c5hkx8msSTmLoQrAhfdRyq/HU3m4sDDF2Z3gEEHHhMbV5ceVg4Sw7Xxilr+4w1A3lYRwRtWbbOjYp59XLphPn8Egm/0o1WBW5qboYAMomUeaMsP5bW7OPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HF5VM51v reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btVCznf/mKMarziZkXJria3PZF8omdeD6INsHonUuHeTHEvlyDs7sulr++SuvszaQoja3KEHQPNSgV1qsUJ3mX3O3tJNzcDsXMO8QLySkTdoTU9kiF2oi/0bsgZqLah5HEf0YNt8tCf8cmetaqeVsGBj05O70bEV1TgX1IJXz5lJVYLlAJMIA4p0Sq839k1NIDXwaJXGiwxligp1HIuvgb/hJpWSgoDNpqkkZFmaHoOzo+bh4KU+rx+zJ4d04XfxItQq5qj6bq+2U8Hd8bI1th3uHXrdjhWEE22v+aYyhUoPR7WWKkcD1V996ehF8mo93LQ5+UpxLAwhxcsiBVrSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upZ5KzR1nE1ByuHLf/9FMocqvMBJX5p8fcQ7wNGkmTE=;
 b=YuK9IkyeGD5tMKDUXURp3fViMCZoh/VTKD413/tpTYdUkCD8usZTR9MAwkSr1isKgnJu08PLYj6GsfVFjbia5VMgWGT9/xpWB8aRnvuZ8PHDuX7v+txTskfUw90bNCKGb+41+RY+R9xdgv9Zju1I39rQMRDJHrUrR/2vfCzhBRUw6fLsC5MjFg1iYR6OqjojTaDKkghpiI6TO1l/6Y6T8ZD783LRaut7WMgBwYNlOrgicwl5VU0DxREduXvR1tTH8LlgqSg9EbGtx1WIXpCzNxg2vHQ/5uGU9RHb4bKk355OYsZvE793EwQ1Ama57AvXccLCrCnS0MJszEfJFW6Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upZ5KzR1nE1ByuHLf/9FMocqvMBJX5p8fcQ7wNGkmTE=;
 b=HF5VM51vdjdEiULmIK4fp/la8PIBLhhg/nym9Z8HLAT+7AsgeCTAL3p4Q5x8Ls00aVx9ApjQU+eP5XC3wT7q1ghNY4Jv6C8sv4f38zWfVCahLvznjM4Z+he/0VtCXIEXy/xcXNMIsQwd2QJgwbJkgcWhZi9WD6eAsNQnPSuh7BnccrUCDR3z/6JnW2vhEnQ/Mn14y4I7yPEZSxkzwpdJX3vQis6bzZTAtboloVMfWRk0uy3CX45aPYvpJx7Ei7eMW+onHXP2JXiZKAPT2xwzT6oRDDrdfM8BFhlFH9IT1PfDjAz/RxcCAw1c+YWWHcEH//Kc3sbdC5BtCYjj0L3ePA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11616.eurprd04.prod.outlook.com (2603:10a6:800:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:23:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 16:23:48 +0000
Date: Tue, 16 Jun 2026 11:23:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajF4i3o0gNRtUelb@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11616:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cdf118-7052-4e69-2f07-08decbc3a4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sZBGPssAUkL01bu5OHeATTkuK7xr2CGCUJqZea4q7KNavYw2vWKIScRfNnh6MES8NpuJAIavVr/Ao/54smus2yYwsials87or7v3cDXFgosqlpvAdxyQ6YPscebasxHWtbYT5+BrfEbmhR3ljEFFATRtGeXF+sGNagVBZsSjrZ/swUhj73Mta78oTomu2S82GjH2hWIYCU+rPMgdy0h7yfbSSKk0j6N2Nl3IIOKKe6LpRYatBWIq69yw0cftWje4F4N5hMnIkGvhFULATQ2Egjri6IgqAKsPepSEfyzoT3IKNtK1pBu4o1YcAU1shTr58YUiHMS16fiptc5uJf0K3KXi1Vtb80qLrjKi9NjjQ/kC/R4eEpcjHDq+OSoeImpmE40MfBf6ofscSgAXTmvjkS/HEUWF/r6A18i/TdL/g5ZcDOvlPjy8bFwGjYPZ+er/jSp/MkyAXW7pW2LbJ3kDk7UY0jXDQCo6w1CPQUJ7jrkWcZeINA3cFiqvvkhE2rmeWWXD83rLXYDjhIjccu7QlfKxYe/lgfgsWWAgcsO52a9d4bF38i9wuEZe6BVaRu2qwQonpNlFIm8Bea1tu0kX6KIwV+tX869iHwWaK77m78ZmdDckycWqVQP8DWMdy2PObQhzbaPq7M+JIUOAuBZ68S0ug+ehKp0hv0rEsGIwSdNsElFIDbJjGGPzZFfTjI58
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YveHV1CTcPZ21yyoE9cF464gJJkjnFyKnF5ZJOdeSqh31dc+FYC2TJJaBv?=
 =?iso-8859-1?Q?d8ORnPaaTm6wi0z9aCD6uZ2DOd3luGvPqpSWaKfBL2fcKyMGLXAyMk1MSa?=
 =?iso-8859-1?Q?Fqgm8s+V6xnWcTeJk09S+Hu06hzaMkxZwDDBs/J672wjn69raykqQDulai?=
 =?iso-8859-1?Q?4XXxLijw8sDPT3mnrLBRK035CFpfPkLhWLgZhC93l2CyR0P2VPUJvWT6wo?=
 =?iso-8859-1?Q?ZcrvkTN8ZbfxzHJg6PqQwHrhiTDDI5onwcyG4XTQIuEptVr4UcDFRWWRDZ?=
 =?iso-8859-1?Q?gh58aBsfZhx9WHKt3rdcgbG5c1+N3J0mnJMLP7xB1AIdnDYlA/JDWrpO++?=
 =?iso-8859-1?Q?iIQJpVwgMzR3CUTyj8gw2DyXadIkXGcmyF4YhYDHZdC4bn/8ke+YoOSnIh?=
 =?iso-8859-1?Q?2GWQmpAXOVsKg84aXZRbFefQ0M8YCJCHGJ0/B7OSRAHYITpVuAHsWd7Krl?=
 =?iso-8859-1?Q?ryhEdg2hu1vGkZD7aH73XL7dz2fihfQHim0iHmjpRNRy9WtDMv90ifxcjw?=
 =?iso-8859-1?Q?VaTcTEO23XMOL753ue9J7ATQLpOcm57XssXbPog07ntROQOhxBEirEOq9P?=
 =?iso-8859-1?Q?w9PUlmvVLED27F8IoGoIxme3B8qJJ6tl02+TL05DZjvZNBh80tA/vmJfMY?=
 =?iso-8859-1?Q?WJGjrdYurwAXWoWxMfiCV2NhEys35+9khM3JzkRIQdD6nX3Vrql3lxx74q?=
 =?iso-8859-1?Q?cGdOoYsoJyA1x2gUZq/K87BsnEk40YxeJt6QG9OVBaj3lw3O/T5V7VsHL8?=
 =?iso-8859-1?Q?e1PN6/0GtHE74swrwrYV0VZXZKxnZf3ri0i4U40ZEMaf2n9UgNempvHS95?=
 =?iso-8859-1?Q?hKZPkuqkj+64LcUq/b+fR7FhbBWNbn+8YFX2w/SyMOkKwIfpB7jbBoYzo+?=
 =?iso-8859-1?Q?bc7w5npUOzO4Qz4Y2VTak5V2z8irnwgKsYlS5enOzwATLParHdBBV5OGvM?=
 =?iso-8859-1?Q?PLGgrySaSDknOhBrUPMAvjoodkGCICnRA3fYu0EY4cCFsmzCYUGPeHf7Of?=
 =?iso-8859-1?Q?WPx587aI1bA+jKlmKSsYrrfn+X4nzSduxJM8cyRFrXXNQTiuUd9YCajSyY?=
 =?iso-8859-1?Q?gecriWwzjwGn3dfFqFpkLJ4famFq9HYyquF89ULXvey0oIMh6RS6RZHOAj?=
 =?iso-8859-1?Q?jKKAeQiJoDzz3+oYReErxSsTCL+T3enmjTe11ThEdZ0Gxj8J2GXiKZDwpo?=
 =?iso-8859-1?Q?cKJiwiPWA0i4rcMUGsNoQLB+lgnOiEHXaSDN94GCOLEHNPFU+XV/vWAAlp?=
 =?iso-8859-1?Q?yrez+Vvmi73gKghM+5RxcgeVTsB/Nzrxzk1q/XZaBXlkND/Uv9ptpQlPiO?=
 =?iso-8859-1?Q?ECAOWxQROQnUz6EETRmgs9/Wbu0bynSIT0IodOv0Ea7UFYSyr1uHtqnBSx?=
 =?iso-8859-1?Q?1naOB6A9LLldn6zqhV3AllMfIFXs5hVtmwnSxiwji9fI+MVY39v7iEOHNt?=
 =?iso-8859-1?Q?WpSOJNCQD1VXUYk8XiEuTZr7QkqlUKgbu9iL52g22VADdaOBT3fvP/pL2U?=
 =?iso-8859-1?Q?XOqR0JUC7Kj26vP6AB1adUqbImr/2iRaC59A2ZQWPTZ43R1bcBsBLGAV6D?=
 =?iso-8859-1?Q?p8W1DX3jpvE5L1hGtr51ysE8JYYWXvf+qI9xRRCUkw2IllGK2yMs6iDhE1?=
 =?iso-8859-1?Q?so6YxJd6Bxiw6si2JGwWyvy8GkWhaL0kY3UjJkZqpB7L6LfddbBniK0hFz?=
 =?iso-8859-1?Q?KU6l80rRMonqpNG7iPQgF2PFFPHfANAtqeHo4QLizxIdDsz4Ejf8bajvHq?=
 =?iso-8859-1?Q?u6jyxwLpurKHDjzwai2tcTuw0mh349LAOBo8UTolWmXalvDi6qMFNda5KN?=
 =?iso-8859-1?Q?qUBg7PBGCXxHhYzzdv+UTiUCJ0z/1EwOtlsWBRSa2cULa3Zz2yUT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cdf118-7052-4e69-2f07-08decbc3a4b2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 16:23:48.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4QZ4rrCS+J9PqvVg9so5sXHXwL77Nz7+87N+wqi6IpETNPgd+C87x9UprS1ZMZ6bTRpZ9flY7XMX0CTcNLuTN9fsG7faWVcsqRDMsH+ntN3rm8oECtOWexfv2EMspEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11616
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11562-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,aka.ms:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 057D6692296

On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Advertise the source and destination bus widths through the new
> dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> BIT() mask. This moves the driver onto the representation that can
> express widths of 32 bytes and above and allows the legacy u32 field to
> be removed once all users are converted.
>
> While at it, give the channel width members their proper
> enum dma_slave_buswidth type.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index d47ff27e1408..19c258d511ca 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -152,8 +152,8 @@ struct axi_dmac_chan {
>         struct list_head active_descs;
>         enum dma_transfer_direction direction;
>
> -       unsigned int src_width;
> -       unsigned int dest_width;
> +       enum dma_slave_buswidth src_width;
> +       enum dma_slave_buswidth dest_width;
>         unsigned int src_type;
>         unsigned int dest_type;
>
> @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
>         dma_dev->device_terminate_all = axi_dmac_terminate_all;
>         dma_dev->device_synchronize = axi_dmac_synchronize;
>         dma_dev->dev = &pdev->dev;
> -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> +       if (ret)
> +               return ret;
> +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> +       if (ret)
> +               return ret;


This patch is okay.  I think most system only set one width once, do we
really need pass down arrary.

Frank

>         dma_dev->directions = BIT(dmac->chan.direction);
>         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
>
> --
> 2.54.0
>
>


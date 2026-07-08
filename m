Return-Path: <dmaengine+bounces-12147-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gJy5BFa5TmoITAIAu9opvQ
	(envelope-from <dmaengine+bounces-12147-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 22:55:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81A72A575
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 22:55:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dLu2Iegp;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12147-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12147-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE5993014265
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2BA3EDACC;
	Wed,  8 Jul 2026 20:55:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5F3EDAC7;
	Wed,  8 Jul 2026 20:55:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544142; cv=fail; b=SkRi7dKr4Ywa4O3x788HAe5wFwNJfgVX+5JzyihbGPvWtVBM04hGraxkXaYVoO6DEQXk8wvbCcKyN57XUqarSfX4ArwyOf+MtanTFa25OgYu8N8osbWRXAsg1RFaqj1Hbzt0V+stJVlezIyUp0S0yDhOur4H2PEesXb/00hAVzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544142; c=relaxed/simple;
	bh=JW3a+Mj8tQUJ6gZ2p+DPHMQXxvSDlQp/anKowc+dvmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vts0zMq+U8/H6Ij4Zy+xZAcex8tk21+WIZq7jihxtMOMQ7AQSvTbhadzl4NXOU2R/vtnnWcPJtcoJCAV5L71KfTN/W1QPP3BECZ7sy+h20Mr154nMXBXkKPumhcOgpMTgXqmWmblV6Dd8qagI7gQvieTbhIrSleS9GtFEFQFQ5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dLu2Iegp; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmmLZEPxrKwlSVe8L/FivvgqmdoPtDZPF+yxs/yuQlEQcJD3/DDM6m3cMpqBE0I9A2GLqdyaFYSkNmz1jm9zou+QWu9AazOj+YMjCt6l4Irbzg+wdXbTig0UwFW306wjuhA85bCJ8DnZ8ac49LOPuMCKrBJ4vTCbdAFWo/EO+AQpvknrDOmgvHcAEKQoXFAU22n80KTt/4llaU+n6+/W137ugRx7sYVwxzAIWBt80pciPcBId+3heo24+ngUjvjJtdn2nI1Qz1G3wbYyNXxvJBgwg0FhpmFfFKqM3dVqMW4SJCOzKr2e4O4bAWjZ6cxMpTk+Vmb0VvJAd/JbHiRYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0NuBzPvH/JllaoI9BAAtfgehAn/KRuLi39Cj+cP0GY=;
 b=IPVj/Vdv8Ihxmt1i0O9M8hg6UvZ9a+FuVlDIO4/squxY17NEuYgO4zIlwdMqgdHi3ZuyJPztW4hjzthNYGTe61CPC7GnS9dADZd9NDG26EbEgK/61hwYkF9EbCNC20f8W16Ch1+DKb0eH/CSXSJJPd4DkBIFHxqm7U39Wx6BtPfa5xNLXqHkAaT/8kGj4zsqKORnkEixnqi+yLfPQkDPx7I93oLIzuPZiSLJhPUqefGSpPlJddBb4N8vOh5ABSW1ddJJYqSXNZX2RyK4bhi3K8TynSokXy5cMlleAcG3bjeM+j8NBekhPQkl96ZFMi9IA4ji09FkNrfzuK3lTDquxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0NuBzPvH/JllaoI9BAAtfgehAn/KRuLi39Cj+cP0GY=;
 b=dLu2Iegpwqdc5UFEioUOzIcoCW77mncDHXPoJ+5TmVIHUr6+wOE7jwxQqqoBUrkjgs0bWQ0pxMwKTwvyLfwRSgcEfuZNTSvuh/LsmRK1VnfYt0+56UJIyfN4Au88lo5GYMjBKCeD2HQs+ZxY56AqfjGUpmBMTbJhB71eEN7z0qKVnvgwslyQvcqtHMe/sXJB7slpquFv0gQhszU/k6f2iMIDy1Ek3+6337QrEA/wou/UVQDI3fkugTRiQBDkM2qEkMAu2IHA6piTyKI5tJQrv9yncq2Cf7NKA2w71dnKgTFNhrR5X41N4xHV5mTlKKtOF1xfe9BWaeEgJ3iLIuaaCA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8815.eurprd04.prod.outlook.com (2603:10a6:102:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 20:55:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 20:55:32 +0000
Date: Wed, 8 Jul 2026 15:55:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 00/10] dmaengine: dw-edma: flatten desc structions and
 simple code
Message-ID: <ak65OTg6t7mPnizf@SMW015318>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <gfylpnuieclkt52xzbcghzaza7oirunstgzfmru7aqpnapdlit@dpgmjrs6ww7u>
 <2z2ba5kwgtyjzipkhxqf2jxjscerbx35ep7jndedv5zk6l6xwk@esy2ayjyhcoo>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2z2ba5kwgtyjzipkhxqf2jxjscerbx35ep7jndedv5zk6l6xwk@esy2ayjyhcoo>
X-ClientProxiedBy: PH8PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: ff959fc6-e83a-424a-47cc-08dedd334024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|4143699003|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VvVLlTpvNHkbfrcLfYnT8XCwHZT0av3NQ/N/aJStAO7ccYsXmvYvdD8piHolEtaK30zc1kJzqm9/HfIILODaKnoiyyRrmSqdQ5/FAAq+7O+EZ3ZVpsVKpXV8s4u4R0ykCRl5B9Pl0YyAPRkMmzujzo1hYJkHFmdt2L6OjvvNRejA2HoTC5xBFepz7TaTALKNSGQMVLnUOwGH87Q5f/wSz1pEr7Z4PINpaTIIxiUXb1fFgtl3SG7yIk5wKJ4AkDK1D4wxp6m+XYT2asevELjmn5NuvM/SSv670B/HokFjq9Lobyhse+45zIB9i3qvLFEcx8d3UBKq703wkquBVrFwVhUAbhLZULGVWQ3mqAWH8sWxlfQi1LRhYm6KLKT9Pq3GdvxStpMGvpAxNwa6yH/xdSP17UwWbKawb9yayXLSaPcbAgvlganJqerUhvMUBEp6ofhZXdJOmTJog/dZT0SXAKhiubzG7ZPf9j59+jUvE6ZkrvKGmUIgNaYMGrd5yOns1PoW4Jb4cqE8M80I1NOQrQPyv1k6sNzQCoVddm1YD/yRG/t0800NGvmhXOhAy5b0BSKSvZPx1L0mxqIn62+KY5hQ8lpgaWX8T2GE36hVKm9DaGTK6AOJE7kgsOx7ygHeYMRw2pOSl9bBR1l0Uh2z5d4vUjLfM3AdNNYBrci9u8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZ0YVRWTnFoSWl1UklBV1lpbXI3d1pVOGlFODk0R0RnOTdzRGl3QndrSDBC?=
 =?utf-8?B?eWQzRXkvWFVEbzdhYWgxYVpPR1o1bHpLNy9XT0ZOdnBQTTZML2hSZitNb2Q5?=
 =?utf-8?B?OU9sMnNLOGlXdVlhdVo2QjlxWE90NEFtcy9ZSkJseFM3N0lobit0Vm1jblh2?=
 =?utf-8?B?YzVmcmxncjNERytJYUJRMm1TdXltVUpzcWNlem9uL2MrclArMVA1d1RVOXhY?=
 =?utf-8?B?WURrd1VzY3JMT0ZiazhscDBXQVEvZ1dySFhFOW9BU0tOWTN4OTR5NjlmaHdo?=
 =?utf-8?B?cng2ZFBCRzZzRjdseUtFNHlaQmpQRVNpM2Y0aTZBVzNKVlJ2dUEwZ1ZwSHY1?=
 =?utf-8?B?eVozYkU3MVNIZHBPK25pN2YxV1lDbXkwS2hTRS9OOC85eFZ3RHNIenhZYmRI?=
 =?utf-8?B?dUN0RXNoSWV1eERRNDM3UTJHalIrNGtuTS9kS0lZZ1lBNExMMTEvMTN1cHNK?=
 =?utf-8?B?dDRaZkIvbjdFbFk3ak5QdzJDak5ocHZKUXRsazNrcFg4MklPNFBwT0hLN3Ex?=
 =?utf-8?B?TmQzV3BZL1h1aVhOb0FtZ2JiRWMwRlhxWXA3OE9DbDN6cVRMSzVJeTZqWUJJ?=
 =?utf-8?B?MGdvSnpNOUhzQ3NhZDVYUmN4UzluMU5mLzlMVUUrQ2pvWDhiMGQweFBUQ0t3?=
 =?utf-8?B?UVd1VWs3MkRVS2FadFpRYkkvZ3FteDNOaE93K2hTVmFVeDNwS241R2xWZ3pZ?=
 =?utf-8?B?K2w2MEtWZER6d0RmN2Y3V2I3ZUtYL212aFd4YjlMYkZUTzZEZm11YjQzVTZu?=
 =?utf-8?B?aTlZK3pBVFF4WjdYZjZMTWNReFM5aHFCWlpwUVgzU0F0aVVlSFFqeDdEOWdy?=
 =?utf-8?B?RTJEbkVWcHhiT1AvZ0F0WjR0U3RNK2VuWVd5clA0WVRqUFJZLzZQeDZuSElu?=
 =?utf-8?B?ZlJNenRERmIzYzNGRE5sWGJuYzhVS0VLMUt6RVRhUnByVWNjdkkrUTByOE1k?=
 =?utf-8?B?UVBwS0V3eWcvRVhZWTdhVE8wMWUra1RIS3FGU3NweE9Tci9MRWdhMU1aWXYw?=
 =?utf-8?B?T3g2aGxqRzFHMlVnME9iTGNOT1NieHBXTTlkemdTUm0vZFdSUE5DUFNKV3Y3?=
 =?utf-8?B?UU1GT2FFcjZ1OEdQSkRKMU5naS9VNGFRS05ZYWNtSGVSNUk0OHloSXQxemRG?=
 =?utf-8?B?d201Y1MraU1LWEpWRGxHQ1hCODVoZVJNR0hmWDRGejliTGN0TWEzalVqUlFn?=
 =?utf-8?B?dTdyOFA3UlNUSGljNWhNN04rN293MjRNRFlCdGJLMFZLL3dqbzZHZWJpYzRY?=
 =?utf-8?B?cVJveVdUZUl2c1V0b3g1dEVNNk9nM1ZnY0ovZDduK09JeUZrY0Z6bk9ZMXJu?=
 =?utf-8?B?MGYrV2NYS3RPQ1Jzdy9ESTV1V25xMFhWbVhlQmpRSDBPY2E1eG03bnVUd0FO?=
 =?utf-8?B?MjFBYnZONzNlQmV1MStHV21ZaHJaczRrQUxVYy81MTdQMk1MVnUxcUpPekwz?=
 =?utf-8?B?VWh6NmxnOGJ0REx5UWJMckd0RkcxL25kYTk5YUY3RW5veGJuTTNkVmkvOVpx?=
 =?utf-8?B?WWFMSHhYOGtsaUNxNHNFd2xKQi8yNUdCeERUMk0wM0Zwa0Iwdi82SkRFQ0kw?=
 =?utf-8?B?VUVjT1NMem5VdERXUnVURVYrY0dPeFYrT05xWjJaak50eEtwWEpnVFViL0ZF?=
 =?utf-8?B?dmwrcS9kTzhGWENaa0Q1R1ZxWWJIcE1HWG9WY3dCODZQeGdOUXp3bjZHL0pp?=
 =?utf-8?B?QldKdVEzK2xlOTBHY2lrck9CRnFQMWJYTTN0SHlJZDI0eW5hYlFMQTh1WElS?=
 =?utf-8?B?elpWZWU5a1dJOXJ6eFNUcTJHYjQrakJpQTJwTE11ZW5tVjV3c3J0RnU0SEdh?=
 =?utf-8?B?OHc0WjhLcVpjUDVRb1ZIZ3V3THN2WE8zUVB3a013akUzbHFjU01wenZNWFZG?=
 =?utf-8?B?cGpLcncxamhWTVhwU1E3a0N3aXcrVkF6Qjh2emFqSmFjSzBJQVFJRGpJbDcy?=
 =?utf-8?B?cmx1b3Fxb2wxdHZiY3gxYjVIdU5LVGYzL1cwSDAyN2xQNG0wMXZueWovYi9x?=
 =?utf-8?B?M3BsYlFCK2xUVG5kRU96a0JRcHhjRW1GRElUa2FCaS80Ny9HNkFTY21rVlhH?=
 =?utf-8?B?M2pLVHJxcUYzeEd3eU5FalZRRVFaRk9YUnBTWnZsZ0d4c2dNUGR0ZEdUbnBN?=
 =?utf-8?B?c0lOa2lWTkVkeGN2c0FJVnA4YzArTUFpVFkxV2RkQUVHaWY1ZUFOYTNBM2V1?=
 =?utf-8?B?SXYyd3VyU0dYZTRtZFVaa2ZENEoxeHg5VXdKMFprU3BpT0o2dXV2MVczOVRG?=
 =?utf-8?B?dFcvSU5aOVcvNS9qb2tneUI5MjZGTXFGSnVNMjJ4TGtQVzJPZWMzRnVZM3pY?=
 =?utf-8?B?VmlmcXhHUFhzanRZOHZGb1o1OTREVExFbmpESXNFMVBsQWF5cFBNcFlvOTN0?=
 =?utf-8?Q?Nm/aLCPnvXa79+92sFVmx5MiS1rSdjCmIX5Qi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff959fc6-e83a-424a-47cc-08dedd334024
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:55:32.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXnFXL2zXAHxsozS1j/JgbbZbylceXUt4pJbwyFU6AyRVC+ds3mrD/6tK5KIEkWlKXLYXkQkx0nsBiiU1bxNoAWHqZ10aLvdvsAHLvvttAPw6sAze4amWmOjcAA5y3SP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12147-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA81A72A575

On Wed, Jul 08, 2026 at 11:59:21PM +0900, Koichiro Den wrote:
> On Mon, Jul 06, 2026 at 10:20:38PM +0900, Koichiro Den wrote:
> > On Thu, Jul 02, 2026 at 05:21:20PM -0400, Frank.Li@oss.nxp.com wrote:
> > > Koichiro Den:
> > > 	My hardware temperately is unavaible recently. Can you help test
> > > it.
> >
> > Sure, I can test it on my side. I'll report back once I have the results.
>
> Here are the results. For the series:
>
> Tested-by: Koichiro Den <den@valinux.co.jp>

Thank you for testing it. I just post v4, but still have issues reported
by sashiko.

Frank
>
> * I don't see a significant difference between Before and After, but I don't
>   think that is an issue at all. Most of the differences look like normal
>   run-to-run variation.
> * Each full fio test set was run three times in alternating order (B-A-B-A-B-A),
>   with runtime=30s and ramp_time=5s.
>
> eDMA:
>   - Testbed:
>     * Endpoint: RK3588 (Rock 5B)
>       controller IP version: v5.60a
>       ll_max: 170
>
>   - Summary by group (BW delta %)
>     all          n=26 mean=  -2.3 median=  +0.2 min= -28.0 max= +11.7
>     read         n=14 mean=  -3.2 median=  +0.2 min= -17.3 max=  +3.1
>     write        n=11 mean=  -1.5 median=  -0.2 min= -28.0 max= +11.7
>     qd32         n=16 mean=  +0.5 median=  +0.3 min=  -3.8 max=  +3.1
>     q1           n= 9 mean=  -7.6 median=  -6.7 min= -28.0 max= +11.7
>     small 4K     n= 6 mean=  -4.0 median=  +1.1 min= -28.0 max=  +3.1
>     large >=128K n=20 mean=  -1.8 median=  +0.1 min= -17.3 max= +11.7
>
>   - Before mean -> After mean (MiB/s)
>
>     Case                         Before             After              Delta
>     ---------------------------  -----------------  -----------------  ------
>     Rnd read     4KB q1  1j         33.4 (sd 10.1)     32.0 (sd 10.9)    -4.0%
>     Rnd read     4KB q32 1j        196.0 (sd 28.6)    202.0 (sd 29.5)    +3.1%
>     Rnd read     4KB q32 4j        196.7 (sd 29.2)    202.0 (sd 25.1)    +2.7%
>     Rnd read   128KB q1  1j        497.7 (sd 12.2)   420.7 (sd 181.3)   -15.5%
>     Rnd read   128KB q32 1j        2248.0 (sd 6.6)   2277.3 (sd 34.2)    +1.3%
>     Rnd read   128KB q32 4j        2381.3 (sd 2.5)   2386.3 (sd 17.9)    +0.2%
>     Rnd read   512KB q1  1j        627.3 (sd 15.2)    585.3 (sd 78.2)    -6.7%
>     Rnd read   512KB q32 1j        2376.0 (sd 5.2)   2381.3 (sd 21.4)    +0.2%
>     Rnd read   512KB q32 4j        2379.7 (sd 6.7)   2386.7 (sd 17.6)    +0.3%
>     Rnd write    4KB q1  1j          28.1 (sd 4.1)     20.2 (sd 10.1)   -28.0%
>     Rnd write    4KB q32 1j         120.3 (sd 6.1)     122.0 (sd 6.2)    +1.4%
>     Rnd write    4KB q32 4j         124.7 (sd 3.8)     125.7 (sd 4.6)    +0.8%
>     Rnd write  128KB q1  1j        318.7 (sd 44.7)     327.0 (sd 4.4)    +2.6%
>     Rnd write  128KB q32 1j       1080.0 (sd 20.2)   1077.3 (sd 37.6)    -0.2%
>     Rnd write  128KB q32 4j       1069.7 (sd 20.3)   1056.0 (sd 46.2)    -1.3%
>     Seq read   128KB q1  1j       486.3 (sd 138.3)    402.3 (sd 38.0)   -17.3%
>     Seq read   128KB q32 1j        2245.3 (sd 3.5)   2258.7 (sd 26.3)    +0.6%
>     Seq read   512KB q1  1j        662.0 (sd 29.2)    594.3 (sd 13.7)   -10.2%
>     Seq read   512KB q32 1j        2375.7 (sd 7.4)   2382.0 (sd 22.9)    +0.3%
>     Seq read     1MB q32 1j        2380.7 (sd 4.7)   2385.3 (sd 19.3)    +0.2%
>     Seq write  128KB q1  1j        342.0 (sd 58.9)   382.0 (sd 101.1)   +11.7%
>     Seq write  128KB q32 1j       1080.3 (sd 48.8)   1070.7 (sd 37.0)    -0.9%
>     Seq write  512KB q1  1j        509.7 (sd 35.4)    502.7 (sd 39.2)    -1.4%
>     Seq write  512KB q32 1j       1043.3 (sd 56.7)   1074.0 (sd 47.8)    +2.9%
>     Seq write    1MB q32 1j        989.3 (sd 23.0)    952.0 (sd 57.4)    -3.8%
>     Rnd rdwr  4K..1MB q8  4j       841.3 (sd 15.1)    841.7 (sd 12.9)    +0.0%
>
> HDMA:
>   - Testbed:
>     * Endpoint: SpacemiT K3
>       controller IP version: v6.30a
>       ll_max: 170
>
>   - Summary by group (BW delta %)
>
>     all          n=26 mean=  +1.1 median=  -0.6 min=  -4.4 max=  +9.5
>     read         n=14 mean=  +2.1 median=  +0.7 min=  -2.5 max=  +9.5
>     write        n=11 mean=  -0.1 median=  -0.8 min=  -4.4 max=  +4.7
>     qd32         n=16 mean=  +0.6 median=  -0.8 min=  -2.5 max=  +9.5
>     q1           n= 9 mean=  +2.0 median=  +4.4 min=  -4.4 max=  +7.9
>     small 4K     n= 6 mean=  +4.8 median=  +4.5 min=  +0.2 max=  +9.5
>     large >=128K n=20 mean=  -0.0 median=  -0.9 min=  -4.4 max=  +7.9
>
>   - Before mean -> After mean (MiB/s)
>
>     Case                         Before             After              Delta
>     ---------------------------  -----------------  -----------------  ------
>     Rnd read     4KB q1  1j          66.3 (sd 5.8)      69.4 (sd 7.0)    +4.6%
>     Rnd read     4KB q32 1j        300.3 (sd 45.5)    329.0 (sd 21.7)    +9.5%
>     Rnd read     4KB q32 4j        312.0 (sd 51.1)     341.7 (sd 3.1)    +9.5%
>     Rnd read   128KB q1  1j        705.7 (sd 34.8)    736.7 (sd 51.6)    +4.4%
>     Rnd read   128KB q32 1j       1507.7 (sd 25.6)    1486.3 (sd 5.9)    -1.4%
>     Rnd read   128KB q32 4j        1549.7 (sd 7.0)   1534.3 (sd 16.9)    -1.0%
>     Rnd read   512KB q1  1j         848.7 (sd 9.5)    858.0 (sd 15.5)    +1.1%
>     Rnd read   512KB q32 1j       1530.0 (sd 27.0)   1536.0 (sd 14.8)    +0.4%
>     Rnd read   512KB q32 4j       1519.0 (sd 66.7)   1544.3 (sd 15.0)    +1.7%
>     Rnd write    4KB q1  1j          64.0 (sd 6.2)      66.9 (sd 2.2)    +4.5%
>     Rnd write    4KB q32 1j         199.3 (sd 7.1)     199.7 (sd 2.9)    +0.2%
>     Rnd write    4KB q32 4j         199.7 (sd 7.6)     200.3 (sd 3.2)    +0.3%
>     Rnd write  128KB q1  1j        558.3 (sd 18.3)     533.7 (sd 5.0)    -4.4%
>     Rnd write  128KB q32 1j       1248.0 (sd 21.3)    1237.3 (sd 7.5)    -0.9%
>     Rnd write  128KB q32 4j       1248.7 (sd 23.0)    1238.0 (sd 6.1)    -0.9%
>     Seq read   128KB q1  1j        640.7 (sd 60.1)     691.3 (sd 9.0)    +7.9%
>     Seq read   128KB q32 1j       1507.7 (sd 24.2)    1488.3 (sd 5.1)    -1.3%
>     Seq read   512KB q1  1j        866.7 (sd 45.8)    847.0 (sd 32.2)    -2.3%
>     Seq read   512KB q32 1j       1532.3 (sd 31.7)   1516.7 (sd 40.3)    -1.0%
>     Seq read     1MB q32 1j        1550.7 (sd 7.2)   1512.0 (sd 32.9)    -2.5%
>     Seq write  128KB q1  1j        514.0 (sd 34.7)    538.0 (sd 15.1)    +4.7%
>     Seq write  128KB q32 1j       1248.0 (sd 22.1)    1237.0 (sd 7.8)    -0.9%
>     Seq write  512KB q1  1j        755.7 (sd 30.0)     739.3 (sd 2.1)    -2.2%
>     Seq write  512KB q32 1j       1248.7 (sd 22.6)    1238.3 (sd 6.7)    -0.8%
>     Seq write    1MB q32 1j       1248.0 (sd 22.5)    1238.3 (sd 7.6)    -0.8%
>     Rnd rdwr  4K..1MB q8  4j        869.0 (sd 8.9)     865.3 (sd 1.5)    -0.4%
>
> Best regards,
> Koichiro
>
> >
> > Best regards,
> > Koichiro
> >
> > >
> > > Rebase and compile test only now.
> > >
> > > Verma, Devendra:
> > > 	Can you help check if block non-ll mode?
> > >
> > > Frank
> > >
> > > Basic change
> > >
> > > struct dw_edma_desc *desc
> > >        └─ chunk list
> > >             └─ burst list
> > >
> > > To
> > >
> > > struct dw_edma_desc *desc
> > >             └─ burst[n]
> > >
> > > And reduce at least 2 times kzalloc() for each dma descriptor create.
> > >
> > > I only test eDMA part, not hardware test hdma part.
> > >
> > > The finial goal is dymatic add DMA request when DMA running. So needn't
> > > wait for irq for fetch next round DMA request.
> > >
> > > This work is neccesary to for dymatic DMA request appending.
> > >
> > > The post this part first to review and test firstly during working dymatic
> > > DMA part.
> > >
> > > performance is little bit better. Use NVME as EP function
> > >
> > > Before
> > >
> > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
> > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
> > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
> > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
> > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
> > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
> > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
> > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
> > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
> > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
> > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
> > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
> > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
> > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
> > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
> > >   Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
> > >   Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
> > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
> > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
> > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
> > >   Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
> > >   Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
> > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
> > >   IOPS=261, BW=132MiB/s (138MB/s
> > >
> > > After
> > >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> > >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> > >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> > >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> > >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> > >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> > >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> > >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> > >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> > >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> > >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> > >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> > >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> > >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> > >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> > >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> > >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> > >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> > >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> > >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> > >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> > >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> > >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> > >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> > >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> > >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> > >    IOPS=266, BW=135MiB/s (141MB/s)
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Changes in v3:
> > > - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> > > - rebase to vnod's dmaengine topic/config_prep_api
> > > - Add non-ll-start() callback to handle non-ll mode transfer
> > > - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> > >
> > > Changes in v2:
> > > - use 'eDMA' and 'HDMA' at commit message
> > > - remove debug code.
> > > - keep 'inline' to avoid build warning
> > > - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> > >
> > > ---
> > > Frank Li (10):
> > >       dmaengine: dw-edma: Move control field update of DMA link to the last step
> > >       dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
> > >       dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
> > >       dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
> > >       dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
> > >       dmaengine: dw-edma: Add callbacks to fill link list entries
> > >       dmaengine: dw-edma: Add non_ll_start() callback
> > >       dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
> > >       dmaengine: dw-edma: Use burst array instead of linked list
> > >       dmaengine: dw-edma: Remove struct dw_edma_chunk
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 216 ++++++++----------------------
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
> > >  4 files changed, 302 insertions(+), 388 deletions(-)
> > > ---
> > > base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> > > change-id: 20251211-edma_ll-0904ba089f01
> > >
> > > Best regards,
> > > --
> > > Frank Li <Frank.Li@nxp.com>
> > >
> >


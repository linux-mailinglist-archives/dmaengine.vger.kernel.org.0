Return-Path: <dmaengine+bounces-11697-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z98tFWxiOGolbwcAu9opvQ
	(envelope-from <dmaengine+bounces-11697-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:15:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B46ABB8C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:15:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WH1heRzk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11697-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11697-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F3DA300829B
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2D374E40;
	Sun, 21 Jun 2026 22:15:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E53749EB;
	Sun, 21 Jun 2026 22:15:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080103; cv=fail; b=lUkNM1sIisadfh7eaKPsmEFReh6I7hicM/kKqh4Sr1rRyGcoLH8eadGK9SFS0idstYcV6hlBD+YGim/6CMR23HlpKKODx4anVyLhkbdOAAagngQtbesCCMLn3qhtoxDklOxisb0M17qDd33U4j//iPs61HoOu53U+mTFBQCAWGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080103; c=relaxed/simple;
	bh=WE0rAZSe6FnIoRFsUW8rogSvovDrBpZfZddYDwVAyFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAWKY9IpO6TgOB6I+t/73K8oDUS2vjLyq7UJsN0WXFE7GqKo8jkPGZVMAU00r/rKqq81VLdISWyxZemJFnH2XT1631poIKKKfZq9GlDN+xOIz4Y95ICUYlZ9QOJTKkHISQtNcpgczWPouQi/vIIO/zJVVs55KhOgJ/3Q0RQjwyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WH1heRzk; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn28hnXLCs7uXEWydYyzt/wSSXb0nnGqo9WbDZvY5Eet69ORv668JVnQNSbtsHrnVCwD3Lr0uJ7i41tW0jY4fKDtZn5Xbd2/ZmEazM9UnIYGaapUkcBJl5bbyJiA7eRsBE1dnTBrqpQ8lI4xggyBfDZz9qcNiQkqMp5hgXFdwXCSWzt3l7yaQ3ptlTSvrmB7lLRckFEJFIZpyxfPkoMRPqG4ypUp868/xLpybKOV5RDKoL4+9UO5ZEZ0F3ORBV1kNxzCUoX1HCP1TLjgJZbt2muL7JiFr/PV4TDhDRdDK+V/SjAiyRO9Uw4CKjB65dy+KBe4vEWxig7CLVxUQDY5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpCgrBzb0DNpiIvZ/CXqgHXBpvcIHyarwB/jLwv1aAE=;
 b=V80y11gaS7JCtnhqHiSy5f4aChMCW+55R0ivNp8w6xAWwFRQndBiQE0ri4k1BytTr9dLOxn+YJfuRRJw8ufisYNMRTVSxS1bbWbWvF6opWKDXah9gpQNYf0YgnqUF3PTEi62F2uJHF2btFQfHK4fLkgMLW7Hpo8SGJ6NwUmayg/kg5LVxDvjYCuhMMWxDM6PCPAB4BkagCRHPXRDvxDVjUx0qiTFd35V+gSwOayM3aOyyieeqkxik4L6g3E31vjEQY8ofWwRWtPalZYG/winH0RQdW5n3y5HY0nEd8YIywiSx9OVhaugT9917kdjgr6b1rGZGktAKrEEx3lPeKzyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpCgrBzb0DNpiIvZ/CXqgHXBpvcIHyarwB/jLwv1aAE=;
 b=WH1heRzkeCxHBQIJf1KtXTiokUzIWDmNnjBhWqLE6whguJoDdUK1kmfjEkJi6Zw3iS+vmG4seTMsRpzivMm2xhpnIEWsYAlyVD+bG5Fgqr00La7CVyoBbGRgwgDuqAFN1MqC2cPV4xTd5mx9c0cpHgjLCfG1iq5ZFMIiG5S4tkdzse77RQxqMoDx2atdmPibxp+JQ+yX+1AajVC6Ccnba2v/rayQncx3MSOJ8hu+r3QFYyc7DnBV7eRJ5Vtb9Yz2c85TlNyEWKZgIcBU8oj5I5skdiz5wbYW/bY9OPChvD8dUG0uX9yhMP3mtGZNnpi2aXnN/AHSn7D7B4G6MyFMFQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 22:14:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 22:14:57 +0000
Date: Sun, 21 Jun 2026 17:14:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Message-ID: <ajhiVSti7HNZcEgB@SMW015318>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-1-340f205891cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-sun60i-a733-dma-v2-1-340f205891cc@gmail.com>
X-ClientProxiedBy: PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::3c) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dba20ee-94b5-4250-4330-08decfe28705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/8l/QY/GltZGrkiD1a/38wFR4d0cP3ZsCAytjuBJ1t46MXPM/fchtEnV8fFF3dGscP6odL6jY2TdUrdGA8hHwkdFk269lKXARQ62r5M5HeJ9E6OHmcJZjsMCW6s0wsKBAnL6VrV6ZijrPDqtMxbOrUYKrFWte1mX9oJMSIhmfPK7IvuGAUDXayQA4/JMC/Lh/X0VVGmuTLjx+HWFRwB6bQwEqru7TASQhqUO+k/E3oU+rP95Oy2AHM3YhheRqy4FS9LoVDOYJMjYEWqZ6NuFqYfhQTZllJIp9HkVxRISpvCDZlMzh1YLvGiNrApKT3bknLyp0gZDAI6nnKA+D6XMnfMb75juZilqlMCZ+Fz4jEARvEF7H3xQuI5oHxoM9KhySAZ3qIsclhQPZIueUBYiIsCqsfCobxx+9SFmaA7ZCRmlNvO0St5gK3YRFYRMdlfdT5thR7WUpFZ/S2N5lERVO+iuk4JIbRuDQH/24YNK+JIv8eH3zDHQZvds3e93iB9sXG6yvSY60VTwQMSq5UDFX8VYN+QcoME5OFm99jLq9+ZMnvVu/N0IPn/Q9AjV0cCoVts7Oh57Aw7pZT72sNVtRCV3PLoSjUc0JgpmpIPB219OEDCVDEwgD94KfYZVNETA4xeG9O+IzTDXDOhARgWfTI0Me7Pb7K/cgsFEAwAs/N8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5R24M3o5LMF26dkmp2BF0AiZT8Bvoip5haSQwF+oFnKInNNiNf4CNVl3g/Kb?=
 =?us-ascii?Q?zU3NDs54Tvkko1vHnZ1uxm8P0oFW0hUnD/arklJYW1MJZYKbkaCmW17cfEes?=
 =?us-ascii?Q?9GM+VSK5XKE1ZW76jh2qB7VkObKBu3p99JD+r6jkjN2682sK1Z+qa53Vl/br?=
 =?us-ascii?Q?efeF73NRTY5B51t4Qfr9hoh3wZUMxYICatMkSIYz4aCe2gJlWFWJwsyOLUQ6?=
 =?us-ascii?Q?JNvDR5GcWi0pQBs5yxXWsooH46HVtOW9j0Bsway/gP0DkQXObF0p3CFxjEAR?=
 =?us-ascii?Q?5ncUvrZ2/WsNvy78hwMaPeTESBYjopkQlu8dWEQX/QtC/G+u8R3MAWnuzzs7?=
 =?us-ascii?Q?wqcCo0meIl7B99NLSxCwSaEzCHnq5wqWa8g33dnIqWaPFyZu5xrHetEm82uI?=
 =?us-ascii?Q?G1xlrg/3i7yT2RTeCT0JN4On2ICFb75QFhNgDMcjnXr/MUtcQf8kchg/7x7i?=
 =?us-ascii?Q?R080LeqU1T3lwswOA+WARO3Hiu7NNKuM7gXyCvpWPaZQSz96gvoly9mo/+dm?=
 =?us-ascii?Q?blKvupW/O0wceSMDgSSWNQvEiUQpbtxN61e4Z1aLeytvgT+8B8F1nZ67P/uQ?=
 =?us-ascii?Q?jQwPBfqNVrzWcXrcnyRJv1o08gbHmbhvc0v8RouHvThBFthW89ORw94tgwnn?=
 =?us-ascii?Q?kykYe7l3l+DEJnScY4IPPmm1+xNik3Z+CySR0tLIAbapmqCQXQli5E13FsTR?=
 =?us-ascii?Q?LdamQJM0uVTg536VsBRXdRGEGowQw7+V5/axRtY1Dgpud4h0Jc/pGR+vQpnb?=
 =?us-ascii?Q?kWvid/hsXGIFQxODVvia1Um93xvHAwjVVfujedfZUVx6pen4bx5ApzHoNFAJ?=
 =?us-ascii?Q?UPEX7DKXePmGaumFBtSK5/R7LR7EkzOx/HpowtbKarB9s9RDM7k7cLX7aU8W?=
 =?us-ascii?Q?hS4SLuENhqW7An1i2g1tfMiRFludQSjvXM+X5cpor2RVwjPKbO11GhSbcJZa?=
 =?us-ascii?Q?190t5qhfh/KN4eKozU7wUMNfPldsFjM0EyBz8NqklHmZycRepzkthJQrAqSi?=
 =?us-ascii?Q?O9b+M41snZ16GZYq02n6YYwmQrAWXojCU8PFx5tGrRxgT4ZRg9Q+MmvPHkHr?=
 =?us-ascii?Q?t2un41VXuOwH0MnmBwsVaXpDFhVsMGP2TdzbPraPlyzeUs7WYQaQFct95/9j?=
 =?us-ascii?Q?EX5MTsW9vcMMnv1BsllRXwWbFIdPrdHQGaXD7OHqdz0nyHQpUnxZYB2IdlKG?=
 =?us-ascii?Q?azO0X6BcLYvg3dLE3Yc2Y3LlCseISiN8pcIhMlreXxRIvJ8jLvfA8gieP+Vn?=
 =?us-ascii?Q?Gm24rVhM6qwNXxeY1+MDdI1ISpDKJ5TLQXIuu29cRPSI2nGsP7J7suLQ8bhZ?=
 =?us-ascii?Q?56ERieBq/O11V7fwinEkzV7i5aySA+BZcnXnPwyIVb5vcCcEHMkEsvQB/RIa?=
 =?us-ascii?Q?osB3XrmoZncSbrWgG3dFQJvgPH+V4JISjhira0BBGfqRZure6LPWH3hOKLbv?=
 =?us-ascii?Q?BImuzx9WoC53v/Eo/HYpzw1IwfuObp1/KIj74Tt72gIJiRMEF2BXQp+NCSpK?=
 =?us-ascii?Q?sDbMdgQJHCPRtIVs2y2cNZv1SheI4n8UVpiqiwyLCQoM5vUv0s2XQKSCvK5J?=
 =?us-ascii?Q?SXbrl57AdezKVlvhD+R/vDw/7xuSIgfHOcddvMc1khq73B8PphRS3kcw9cKS?=
 =?us-ascii?Q?+7T64zPqzBHuIm0LGtv0q+TsFQusUW8uBnEJiOn72z4gjEPuPuyPpuuorTea?=
 =?us-ascii?Q?H6W62RjHvJicVubFlBagsF0PJkSkvp6dNLw4mdmP3pFIgOIr9UK14XxdgYTA?=
 =?us-ascii?Q?aF7fERTa9oyLCC2h+qoGmikjOXsokCOBQLj9pwQ7tGMbW8O1R6xK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dba20ee-94b5-4250-4330-08decfe28705
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 22:14:57.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soHKNJu1k+n7lamofcke2Vi9YALazVjS9EPTLD5s3REMex0PvSqPi00aVUMvr8T9hqjL17irV65eYfFalzqR4xpU76tzEGlU8IYjTMmFZVRVb8xClFptGkFwxgNdOdJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11697-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1B46ABB8C

On Sun, Jun 21, 2026 at 09:40:54PM +0000, Yuanshen Cao wrote:
> Refactor to support the Allwinner A733 DMA controller. Currently, the
> `sun6i-dma` driver has several functions related to interrupt handling
> (reading/writing interrupt enable and status registers) and register
> dumping that are hardcoded.
>
> To support the A733, which has different register layouts and interrupt
> handling logic, these functions are being moved into the
> `sun6i_dma_config` structure as function pointers. This allows the
> driver to use a polymorphic approach where the specific implementation
> is determined by the hardware configuration assigned during device
> probing.
>
> Changes:
> - Added function pointers to `struct sun6i_dma_config` for:
>     - `dump_com_regs`
>     - `read_irq_en`
>     - `write_irq_en`
>     - `read_irq_stat`
>     - `write_irq_stat`
> - Implemented generic `sun6i_read/write_irq_*` functions for existing
>   hardware.
> - Added a macro and updated existing `sun6i_dma_config` instances (A31,
>   A23, H3, A64, A100, H6, V3S) to use these new function pointers.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..ef3052c4ab36 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -138,6 +138,11 @@ struct sun6i_dma_config {
>  	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
>  	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
>  	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
> +	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
> +	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> +	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
> +	u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg);
> +	void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status);
>  	u32 src_burst_lengths;
>  	u32 dst_burst_lengths;
>  	u32 src_addr_widths;
> @@ -347,6 +352,26 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
>  		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
>  }
>
> +static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +}
> +
> +static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
> +{
> +	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +}
> +
> +static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_STAT(irq_reg));
> +}
> +
> +static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
> +{
> +	writel(status, sdev->base + DMA_IRQ_STAT(irq_reg));
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>  	struct sun6i_desc *txd = pchan->desc;
> @@ -460,16 +485,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>
>  	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
>
> -	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
> +	irq_val = sdev->cfg->read_irq_en(sdev, irq_reg);
>  	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
>  			(irq_offset * DMA_IRQ_CHAN_WIDTH));
>  	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
> -	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +	sdev->cfg->write_irq_en(sdev, irq_reg, irq_val);
>
>  	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
>  	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
>
> -	sun6i_dma_dump_com_regs(sdev);
> +	sdev->cfg->dump_com_regs(sdev);
>  	sun6i_dma_dump_chan_regs(sdev, pchan);
>
>  	return 0;
> @@ -549,14 +574,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  	u32 status;
>
>  	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> -		status = readl(sdev->base + DMA_IRQ_STAT(i));
> +		status = sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
>
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>  			str_high_low(i), status);
>
> -		writel(status, sdev->base + DMA_IRQ_STAT(i));
> +		sdev->cfg->write_irq_stat(sdev, i, status);
>
>  		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
>  			pchan = sdev->pchans + j;
> @@ -1101,6 +1126,13 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
>  	}
>  }
>
> +#define SUN6I_DMA_IRQ_A31_COMMON_OPS	\
> +	.dump_com_regs    = sun6i_dma_dump_com_regs,	\
> +	.read_irq_en      = sun6i_read_irq_en,	\
> +	.write_irq_en     = sun6i_write_irq_en,	\
> +	.read_irq_stat    = sun6i_read_irq_stat,	\
> +	.write_irq_stat   = sun6i_write_irq_stat,
> +
>  /*
>   * For A31:
>   *
> @@ -1132,6 +1164,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1155,6 +1188,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> @@ -1173,6 +1207,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1200,6 +1235,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1221,6 +1257,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1244,6 +1281,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  	.has_high_addr = true,
>  	.has_mbus_clk = true,
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1266,6 +1304,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  	.has_mbus_clk = true,
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  /*
> @@ -1289,6 +1328,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
>  	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>  			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
>  static const struct of_device_id sun6i_dma_match[] = {
>
> --
> 2.54.0
>


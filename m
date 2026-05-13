Return-Path: <dmaengine+bounces-10438-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCE+CmzZBGq9PwIAu9opvQ
	(envelope-from <dmaengine+bounces-10438-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:05:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB8753A520
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1021E308C2BE
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93B356776;
	Wed, 13 May 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CvZL+tk3"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99C3B2D04;
	Wed, 13 May 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702528; cv=fail; b=XZsMbZC19yWI/tM30wq9nzBUoBe40Gd9amlgm6e9HSQhsJjs5bb6jitb63TKUHeFGgoKzh0R15qfr3FiBoVFMcRsPAka2E7Gp6JU2xk1xl1emk2Mq/9unFHiapj7OelRgKv7HgCtcT0+ezbYEwMYHIRHInWpbAWqtS9IpdybovQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702528; c=relaxed/simple;
	bh=etsvsByZVRQSFgNrYH8kO6CE1graSCzJoCbGaUp6jL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIChjcPN2rG8sOtTJw+a33BwVoKoqJbW8ynR4lhbL2kkrQYlyUe4GlA3Gvw1lbbUp2px/6HGDDY0P6DTNS5tVvG/4d4AzivPuC4th+h/pLyeQgfjQk5ZG7Wzsh/N3aH0ABoUeMQE+QhxTYMK286WJb0LMGzPdysR+yFLKNCF48w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CvZL+tk3; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRAqFeTMeY1ZkQxsPjKsth6wlhz13eQUEoNQI9+6g399DZbbgx3CExFHHxebeGg2wRMusf5oiiWDJENmFP+EHNvh/0eVyZh6Yq3Kzv/m4YnnVU9YyxmlUC9/cNS7ctigo5bb0GQKY9ZZyRWMJA4rXrS5Dgz5HcCwDvdNjzB++mgA+Pf/J2dUDOMB5Dzh61hKJz3n4gTIugM5TKpozfH1EO4ySJzkmUHI1uLxdUnJAtY5X20is+ZSvfqfZPnT1mxhvawB3awGXbakW9i73kDhdubH5A3UVqKLCB4cfTvQn+GbKAE5nmrbSH7SJ9aX/aZBFYuXExAG+GTUbvQaKElMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxVGY6ZomFFsxcAzoqaARvSJ99j79UJxDISKXFZOQg4=;
 b=XuYI8kCG7LUbDpiONF+UV6NDRmUZ8t43a+oxMQLCgtO3ZeWI0nv1uMeVyGBql25+7nwSrk/UttUcyWjmRmYczHqQCJ0ZAa+ThsKJN6x7oqm0PW89lAbpHlphkcYjnfVB8lZjqJYmvP65Q6uxkstm7fA5c9eH23/1lfEvMI0UMHkobU3OkG8Si40ctLzwdEkG+GSgQl55oNR50K19QpYwyeDJ9BsiJ5s43lqhX6LoGWeBhCNe54uPN9TX6TgjNBmCrCnSRT0tEFPwv+YoYnJmwelcO70ErxILGV6RhZrUNegyr/u9iwPFp+vs0B2jyLdmryjfyuB2te/umyRMJpO5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxVGY6ZomFFsxcAzoqaARvSJ99j79UJxDISKXFZOQg4=;
 b=CvZL+tk3rkczodIrAPql8D0cEhOxGGC4dwP4yXLmYS/GAIJrV6IrY5C2qZUrmyEjHF175AQk84BfTiPyH2C8mM4JzIyB2wmEX53NASGIykrYnaMrZsP8wK1IcVgaTKCXpAzDZysQKdvtqnnZk+wNECEPQkCPTrG5Mr/Ol6aGRrFu9DtWNGk5/arf0WUeEz9ZYQjxteW6gS2dyfptiunrk+XrmN7XwSJ8CZbGN/Tu49E0/HgqWnSUvIangL7k+k1th8f6j6ezOT5OxQxJZ4XJvZTR8+QiVD1qIfXL57kAZ+iW6pDMTFxGfk9/DrrV41BsmxRoExYQiWPw6Oyt0khv7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:02:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 20:01:59 +0000
Date: Wed, 13 May 2026 16:01:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Lynch, Nathan" <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 23/23] dmaengine: sdxi: Add DMA engine provider
Message-ID: <agTYrii5kLS3tHsx@lizhi-Precision-Tower-5810>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
 <agJAeVtiJnQ1In6_@lizhi-Precision-Tower-5810>
 <187196b2-fe7c-4d1d-af9d-0df7bf1d0159@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <187196b2-fe7c-4d1d-af9d-0df7bf1d0159@amd.com>
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d36fde-03fd-45da-d5a5-08deb12a7e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|11063799003|56012099003|22082099003|18002099003|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FWQ9vPKw6yClzMJmNp7pB5H8Ycb+jlqvtVwnwsSunBeXrflgZl7p8Xsc4Nz85bsWx6ONFPrT70n/5CLIDyHP2F0lWyA5u/kQ174yZUJs5T/pNt4X6Ms/hTCYesUvJ8xGGinabjq3jXmmsWSwvja85bbv2VmhCQ2acq6sl7ifhHYMYXpIWTLDlfBs1lcqrZxWMbsmCDAbgCbjCf/s8w1vsZgnvC/n627PeCW3mbhVIi5oCcpIgy3/PsbiTzzfZ2zEUUD3oxqhhL4pgGooq7gIeLFuhXBRN7jeqyGBtYU+UlWYFc6Qua1oFa9JCubcMFBUgkV4xY/DTAw6JJkQdtQK55IpoJivqZy6eclSJKAVVavHhG6w53GCvQj6IKV3gh3b8gHRt8VaFb7KI2+h3vzbJEdBwBK2w5SoZVnGiOOxxTaikx+fG1NlWwRH1Zn/nK3QaWC3FyXYhNPy9sLjbqYDBW0GkTB1tEYGs5C5Wo2un9n3/MbOF6r31xZqk/rgoyehw16Fnlz0hcjlf6XenGMyd6n55zLX+D2PnHolI3EKOunyAEv4xtFkdWOnhKY9ewmvfYkneFa7cfzgoWTbUthkvwyuqI+qD6EVmdp2tXDR44vKputYwHZC/xBzzAdsc8G7nq5ukaN3ReaEGpykJfXXb77X99X/F4s4PcU8UHXGBla5F2D98DmhgeIDZkRCSaHGsj9wyrisYry/dNNP0nHQnpRHPV6SlDNkbqxMgHpvlilEW3BZulOOaeSyOGP/NhST
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(11063799003)(56012099003)(22082099003)(18002099003)(4143699003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5fSyvCwEwqQSFfF1TGGyFnu3YFGj7od4+lHzCDDqlHHi3DzUEkm7CDe6EQN?=
 =?us-ascii?Q?zMUzGhqsEJYX9yKTadOHswUjUSxxX1P43wCLYA27xj4D2f8mLSEp6GWzP/4r?=
 =?us-ascii?Q?oYnVU5exEuTzdR6G7Ma3qVzlEl6/aScCBuX4VuyG1BlNR/ypvQzs79GCXvHW?=
 =?us-ascii?Q?47Wxdf4IWCOpOqaNOm7FTO+WaZQSK0VYTCS44c1qpMK2xt/DCLFSzocsnurh?=
 =?us-ascii?Q?bny2OYwOeOsP06tRe0/PmJ7RxUKth/GFrk9TM1jRWP3yMR00hCzvdvkubzTV?=
 =?us-ascii?Q?7M0jXz253Q/fB9j/bFGq2SC1Zjlw1yMCGUyn6jzAWDtr+DExDinwe+Tqzl0Q?=
 =?us-ascii?Q?TS9bi6yLZ+0XkBju1k2dc6f7r58GEWD0rMtHAUhhaSmqK2Xje1AeF7zHihAc?=
 =?us-ascii?Q?8asylDZFQd+U3B3jsUfd0HRyM6DLL7F66XijO3VfuFwZYwIZ5K+8on6FKi49?=
 =?us-ascii?Q?bpYfxtFvPIzSCuowSW2KvjXvJuqK25TFmAO8sjm4P1NHaRE7W118pLR0hWEb?=
 =?us-ascii?Q?OlnM8pla8k62nc7+7ipxnbG5yLjzuuOFBftVNezvVXBYaas4oB000cr1O6FA?=
 =?us-ascii?Q?dA0TizmS7fCEZxww7b7cbP/kvGmaCS5X4PEHj8AipRQwZtXEPGP8txHpxVJ1?=
 =?us-ascii?Q?3KezrQJuSkuxRlGsEaZU10/PQmaEDPu1HQFSzqq78ua5kn7X9Eko+S1uKa+h?=
 =?us-ascii?Q?lemshuKy/tFeE2ctT4OI3yF9EPxh8e4UTYn86gS7ovnvSz60CkLrByg/OPMc?=
 =?us-ascii?Q?hEs1znsv+pXxR73IL1UIe4dVA6jqq1q4pIoVjZw4zyfxwmTt3MAuqwdIeLGc?=
 =?us-ascii?Q?bWtOsz/wOJHSYfAm8y2Ol8loSGSwbzTwUNayCkPq6sgnqcFJM1Ju462uPnHS?=
 =?us-ascii?Q?UBy8m/q4RupzPndYyWOh/HjbVpAr5HHK8RmLzoGSBIQm8RsW7hDqfYbjf5f2?=
 =?us-ascii?Q?45egWJFWwKcBUwgvkr9Yk6GGueOE3nkQvQHLOfMkPfq8GB/vocRq1FipEXPl?=
 =?us-ascii?Q?cuqfJtqWk+ucckLwVnXPRqMsv+z60LbdNmKKbI9EYav6H7IUMMyHxR0NrGBN?=
 =?us-ascii?Q?N/AgBGONg/mP0wfuHsRf4egsKjQ6UC8a9LFLz2puDwko/X1SWYVa6qNvTfdt?=
 =?us-ascii?Q?TK1OnPogBmwo2K4Q7JeP6LRmPU7Y49xp+3i1bzm25gXWKlUAu7Cfa5zGHjyP?=
 =?us-ascii?Q?tlRukUF8RnRb7pzNwck+NeZRnvbwRblNXBHXXY6HDs0WHKBmRgN/WmjM3UZ/?=
 =?us-ascii?Q?v6BgtHyVUMKrEFB2UTKgRmjstNq+rEdIy1Zyvw3WdUWReF6QdoInht5PbGKi?=
 =?us-ascii?Q?Edu6sPS08zDOght23qh8DAFvsAuqIoZaSjXEc5d9QOgkIzJm2G/dDcQjslIo?=
 =?us-ascii?Q?uEGXUeaN5es42jyzu3XoxXooPRdZCv8PtV8klqFjCCTrqUpC17JCftD/dWsB?=
 =?us-ascii?Q?NENBeTsEtcaL2pq/A0O7k0u+/Ui2kP+DW5n3WEn5rh2PG+gD3H77xUQNtXCq?=
 =?us-ascii?Q?o35UP17x4Q46WEwBAA3dgDs1Tk6d9NBWYgLMu9p8gT+o8HFbE2yzVKVE2rLU?=
 =?us-ascii?Q?orbuuLsfqzqGR+meF4DzHP+dqynDjbHMBaixgYLZUvpex9Ig0yFp4eMFatk/?=
 =?us-ascii?Q?2Iwmje75jM5VDaT+QukQ4gWT5xxe4oAhyLfp9VnNyXndxJDuvW45ZyyzMxCL?=
 =?us-ascii?Q?EC5yIz100SpG2M1v3kVzquc4Ct9wh3+clNBKVCTdXGCJY0M0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d36fde-03fd-45da-d5a5-08deb12a7e21
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:01:59.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpfGPD2GQ83q0KUhdBKfbQGy0wMGHGJSU2DWZyPlA8JgfL3OnSZOVbvAFXluS4+tGayP9fZbcluCuolGuDZFfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200
X-Rspamd-Queue-Id: 7FB8753A520
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10438-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:28:01PM -0500, Lynch, Nathan wrote:
> On 5/11/2026 3:47 PM, Frank Li wrote:
> >> +static struct dma_async_tx_descriptor *
> >> +sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> >> +		     dma_addr_t src, size_t len, unsigned long flags)
> >> +{
> >> +	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
> >> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
> >> +	u16 akey_index = sdxi_akey_index(cxt, akey);
> >> +	struct sdxi_dma_desc *sddesc;
> >> +	struct sdxi_copy copy = {
> >> +		.src = src,
> >> +		.dst = dst,
> >> +		.src_akey = akey_index,
> >> +		.dst_akey = akey_index,
> >> +		.len = len,
> >> +	};
> >> +
> >> +	/*
> >> +	 * Perform a trial encode to a dummy descriptor on the stack
> >> +	 * so we can reject bad inputs without touching the ring
> >> +	 * state.
> >> +	 */
> >> +	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
> >> +		return NULL;
> >> +
> >> +	sddesc = (flags & DMA_PREP_INTERRUPT) ?
> >> +		prep_memcpy_intr(dma_chan, &copy) :
> >> +		prep_memcpy_polled(dma_chan, &copy);
> >
> > Maybe I am wrong. According to my understand "DMA_PREP_INTERRUPT" is trigger
> > irq when complete.  without DMA_PREP_INTERRUPT, don't trigger irq when
> > complete, not means use polling.
>
> OK, my choice of function names there arises from the dmatest 'polled'
> parameter which selects the completion signaling mode. I can rename it
> to prep_memcpy_nointr() or otherwise refactor to avoid the confusion, if
> that's the issue.

suppose only one line difference between prep_memcpy_intr() and prep_memcpy_polled()

prep_memcpy(dma_chan, &copy, flags)
{
	...
	if (flags & DMA_PREP_INTERRUPT)
		... enable_irq
	else
		... disable_irq
}

of cause prep_memcpy_nointr() also okay.

Frank

>
>
> > for example,
> > tx1 = prep(flags = 0)
> > submit(tx1);
> > tx2 = prep(flags = DMA_PREP_INTERRUPT)
> > submit(tx2);
> >
> > issue_pending();
> >
> > DMA Consummer just expect get irq when tx2 complete to reduce irq numbers.
>
> Yes, I believe the SDXI DMA provider satisfies this expectation as
> currently written.
>
> > If using polling here, it will reduce transfer efficacy.
>
> The SDXI code does not poll for any descriptor's status unless the
> dmaengine API asks it to, I think? E.g. via device_tx_status().


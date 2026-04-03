Return-Path: <dmaengine+bounces-9876-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD6bCRouz2k3tgYAu9opvQ
	(envelope-from <dmaengine+bounces-9876-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 05:03:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0A5390930
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02C8B3015313
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2026 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3134DB6B;
	Fri,  3 Apr 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8IbWJEB"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E02848BE;
	Fri,  3 Apr 2026 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185428; cv=fail; b=gzVPv5DbJ7EVX9cMgZ5jpfGuWRwSqfJlEQOEbf3/mfnzLov+hDaIgY/nlG+X11mO4ik5o7gnYHdogIaPwbnpRhLYShrenjiQeI86bsDUhG+IFmAdN7z/5cHK+XTkeGDOI2Z0+7HNE5dE3U6pdcOPopbVWSmMC+gUGQDTq+l7ePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185428; c=relaxed/simple;
	bh=dR6zc9iYwyfp3jMywGHIaCCWEUkRpxi4jOAy+jlslFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZcBkH2o2Lm0WpcrCt0jRdLMR8SjyO4WgwjhHW6+n9x0RWMK8Z5pD5MpuvKuZZROFAGNdUo5vFiKjSCzMMzPNPPbcJMWe48OO5zUZkBHf9t14uqjYsq0hM0nR6HhXEAImcdvELD5BNvfoZHqMycTnqWqzq03xcTBq+8VnC7qz+Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8IbWJEB; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7Ci9IgjBYJmxjzNiZTt4utv/NqVPTHnsHfIL+Gs4mIuMEuDEKOkY3A8/cQljKeqkxR8tkYlqET6O73rOSZvP7SUzF82fu9HPqV/GjDWCFWiAnQV6cqJdi+iUCHSV5PvwE6vlv/wgHTKmzdKHvunhjcOAZez0txRjVfoV2QCVZubW44JE1suLo2PAfGDS2PbqI54EOcFWDxRQ9g3X6M5chZtBupyyiVnN5vkEtDwkWrKfnddq40t5xrPd8BvmNqwfR96eCs4XevzJlbCHbsBwCUvXUU9/TVWYtTVJFuAKIyYhMHeFDQH7x8p7f4RRLfP/XGZYXhVGJEwjwfwNfM3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgSfHn5mNE4VeK4DWKmdDgsReN/BlvTJow2Ir4X+9F8=;
 b=nWppCWWj09NIxqC1HfhFvJa+9UjjFetukqHtis8cmvRHXJsYXyJLBFWotiv2Q7zi2W122hrERnKetKu5RPh3PPVHlf6aiXQkOWN9EkLz6cA1kpWbqwFMxeT6erT03e8+WmsGk+s1WeF8vcOoI12MZhDru22N2AJV2soUwjpzqnhytkmaOGnA608zEgeFrGwLKQIx4PvhfhrXraL2zOM+fm1k/2xi5dtYaDHCyBdRutsZJKIFSZxTUVGZ0qn8XBeeUJWYhglb5QsF/Cfw95FXF0ZPI6T/EcHI8OpJr1aHOkjgyjIDDDexUo5lbawPbjKgDzlXnQKdIc/l2KBUJLU9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgSfHn5mNE4VeK4DWKmdDgsReN/BlvTJow2Ir4X+9F8=;
 b=V8IbWJEBFJ+Fzw5nCrtfsjf10TMGl+N6GcrG7Ta331Q6Q28PJF+iRZx4acuVe8JHdTVJTNlfEFskciK1pQkEenq2AIH5PgcHhhW/V95YT4oDOxYjw9v+H3QiM4Z76qzDXnhTv/i6cn8TyLcZP1goQh4H4vULP/zn95HFfkfHnKhFxCz1QEBbFli+yB5lVeaNj9ro9/vtGE4G8hXIO6nghNeEMK0HjvQmhlVJ/WxQMvRSBHb37zjjCnlqh1F+PW3Lo+eWeVegU0taqMJziq+/g7TURvV62IJyq6DXTNCfCRuz63FLT4EbNqtI06sREfmh7Uh1WUXGb7v2Hrp08TK0/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 03:03:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 03:03:42 +0000
Date: Thu, 2 Apr 2026 23:03:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sheetal <sheetal@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: tegra210-adma: Add error logging on
 failure paths
Message-ID: <ac8uBTemDHCr4T6V@lizhi-Precision-Tower-5810>
References: <20260323083858.2777285-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323083858.2777285-1-sheetal@nvidia.com>
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c403f58-2df2-4102-5eba-08de912d9c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|1800799024|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NzQ60NTy0jQkUmj9HTwRWo8h86kfyLO2Cg7oUFMV/QGoCkqcZn2cMIMrpqLFrnryIokYy1mbLm21zGB/Mp1a9cfr+pJ65x5eHex+XOjNgjsOY27e0t593usZ+9PrNSqHwvgi/RxKHkMKXTJM+IjiF5eR+iIqv+BC2hPoZ2BEbVI/G6xvEyIFI+21Y1VmJhS70ucUUNQeas/snuIKowEIM5xDnpy+2QG6LU5o9qfE23KbUGr0xAky59ymRFwIxL4wZWDMpU50NpCTcggWDvGusgBj9xGMwECql3rrvQ2q1vwkUe3vSr7OVnltxv8Qboaazq8papK8NL9ZZVXCTgQJvgughuFFP6DxRdOgSsPx8iDukYIN4pTz/siN5bpehDRtRw0e56CQbEejae8V8I1fhmsqSzznSURVufI4jhSh79HaMlDRT3Mt+CXuvSB8Yv92MNVSK8xbprYdjLkiKA7yrm07Bus8Qmv98kzq0sC1HGAPJ7nvrPW9g7GFJ47KkefqMYDbpI+ZJ6UPYwnX6IQbtwI+Obww0Kn4pBgeO5ztQe1rkIN7B8JqyyyBNqamgrMTZPiPb5qIwfqofl5B2tpMTPrcqqLfbSdWGRBXSPIMS/2bytCGpE55LKlWv2hyKh/aeArduaGo/EoD8xLVZoZsKwiExtg58I8sKeQfrrsPmMB2MWtsAaSqVCyuLrjTPrT+zYDeCSiPfC+vc6KH8ztjprY+SrnV2uxO7W0gkdWv15ULq7ToKOzYYPhAEWmdL+i/Su45aE6jZHPnvU3Q+Fb8qG1sGJVBi3fO83n23zlQnE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(1800799024)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E376JGMjTcE9d0aErurlbiPF7SJEWm3cVW4obOPCWj0F6b9rAMvqkKsua6lW?=
 =?us-ascii?Q?VvICEdt4XsCmaQlX6Rny6XqLQcbAjrNqFGP9VAKxg93n9OiYSvQFzA7/Vust?=
 =?us-ascii?Q?xMBPDgnsNJPCVBedNGz6rfl8UtCzJESfRPEjIVLN1hLIkhAdTG7f/GHStczl?=
 =?us-ascii?Q?+4Mxw2FduAk7mu7awFwajdpjA2Rlu1rlVBdBZy+VwLtke3RlqnGmuzTt5wi/?=
 =?us-ascii?Q?Xze9Jo+DdinqRYg1mkTnhxVAlRcngtP5ei3lqo0VeZoyx5rmZoBuS/XSEakz?=
 =?us-ascii?Q?q4L6FtJ2Ws7ZpLqJ6PDUaxQ0bZ8e89Jd0gKDOomTnUfu87jSAWqlVJYl45rf?=
 =?us-ascii?Q?2g6qm8X4ludI4lvZeAt2KY7wiGo51etelazhNcnvukfuNyat2KHk24dXmFTm?=
 =?us-ascii?Q?V93lTZe5l8mog7CEKS3oyeumCwK5TvlGDE6KVI/XLlc4EialPgo+/xaODyGz?=
 =?us-ascii?Q?wjURi3exatEDdhe7pTcVlh6FH3jiqSps7SadcH2hWCxoE3giqe1noyzOXn5K?=
 =?us-ascii?Q?oB3E5Zpgg2xLEbp6m5veSpKCcRwS+lIMp8/5Rjkbv51f/KuFU0pRZGPFkzmw?=
 =?us-ascii?Q?QOMKT3cg453/SXnOeCamvozXquEHb4muVVM6HTxaiFgJc9AhvZcvuo0QdpMO?=
 =?us-ascii?Q?z+EFDeJdwa0d1+PezNl4BZXYMtrq8Gt+ncFp5lG53KIxLYCBErX0A3Pffzo1?=
 =?us-ascii?Q?1v15K4q5tmn2rNiWhdWUCwmOYpI24cHjCOZ6fwH2sZzHcD5AeGSSp8I1qqyS?=
 =?us-ascii?Q?Z5OwSPAu51TRLQ+MQalm27ygK9KwqZREHkW5GlMRIqqa3kRk39Dx8YiO7xj4?=
 =?us-ascii?Q?GEbwk7oWd5TtQTNa/iIKtMcyRT4vcoRrbznFz0JpiX11ilo/MqzUH4ivReJc?=
 =?us-ascii?Q?Sf3BJDiUjTi97njBy8Uwwl18f8cG3j55ZGGBAdzZX95FOcVTt2oV3FEIHFtn?=
 =?us-ascii?Q?GFblw9Ja7iYgIZAw2IBFcUKV9Ok2QWHkM6OGaMQpZQ0tpbJdLzCzBRbOd22e?=
 =?us-ascii?Q?EfB9jno6wKnlByUtXLPxAQPkLCw/YTydssfg2mqyZ6V57r8fBdTX8inQWz3J?=
 =?us-ascii?Q?ZFwbN2H/7mg062SxCLcFrh8AEyd5PY28H0xUgWOkh9hknAEbhvA2dDg7of6d?=
 =?us-ascii?Q?KPQXQJLuF9TaxMcyYNtpVEmciGCFQN8oRTM6m0yBtGzrvqqONWM/JIfyL5Bt?=
 =?us-ascii?Q?XlkTqvsOAEWj1o4jZiJK1hO6MCJTFhobtdZzY0l7ZClHoeXBX0crCB/95jUO?=
 =?us-ascii?Q?8EQYMwpIRk5LIgXWEd5q7/f+bcrLxWew/tijZpc92evural9o3eHBjNUp1Ur?=
 =?us-ascii?Q?393QplJpEKKb44pxK+WDMxJraa/WodLXANdqPcbJDkN7TzHlHXFOKVt8axJv?=
 =?us-ascii?Q?Ub2+11Eq22aveusy1UeKOWpqF8IYqc7SypaaN/EcmmUqCbAur3PuYV/4f3ID?=
 =?us-ascii?Q?NjUCjQ4PcZE2ZtlNb4m6i04g/aLajEdUV6WAhwOLHKFja9sfi/anJWOmxypq?=
 =?us-ascii?Q?Gijv3rst8YoqfhhmEHdtVjG8uLPrgrZso5Qa8i5FDmn2ISGj8aFZZ4R1KcRG?=
 =?us-ascii?Q?zmjSLZVjchwVVLH1ysR7s6d+gbyMCcrzoozy1IXHfAFPIBXQag8Jt8V/HlJD?=
 =?us-ascii?Q?fS2Fj9yk4XEAOErFWYa7ZMJf2iAMdg3L/Ndxx7l5W81dQEus5hIqpwIE7X0z?=
 =?us-ascii?Q?11n5YH6mv3TMwveG4tVDQaCzRYuBXbKG5890AciFIKYk1lYs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c403f58-2df2-4102-5eba-08de912d9c96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 03:03:42.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM8zSs+Ag4iOvVK7i+UoQWMCXMNSo8hn2CQZaxynzr+qUI52Bq9ww9UoMUChracosZPTF4FUrDiFSY2Mf+06cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9876-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 1A0A5390930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 08:38:58AM +0000, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
>
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
> Changes in v3:
> - Cast page_no to (unsigned long long) for %llu to fix -Wformat
>   warning on 32-bit builds where resource_size_t is unsigned int
> - Remove redundant dev_err for devm_ioremap_resource failures since
>   the API already logs errors internally.
>
> Changes in v2:
> - Fix format specifier for size_t: use %zu instead of %u for
>   desc->num_periods to resolve -Wformat warning with W=1
>
>  drivers/dma/tegra210-adma.c | 37 +++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
...
> @@ -1047,38 +1058,45 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
>  	if (res_page) {
>  		tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
>  		if (IS_ERR(tdma->ch_base_addr))
>  			return PTR_ERR(tdma->ch_base_addr);
>
>  		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>  		if (res_base) {
>  			resource_size_t page_offset, page_no;
>  			unsigned int ch_base_offset;
>
> -			if (res_page->start < res_base->start)
> +			if (res_page->start < res_base->start) {
> +				dev_err(&pdev->dev, "invalid page/global resource order\n");
>  				return -EINVAL;

It is in probe function, return dev_err_probe(, -EINVAL, ...);
check other place

> +			}
> +
>  			page_offset = res_page->start - res_base->start;
>  			ch_base_offset = cdata->ch_base_offset;
>  			if (!ch_base_offset)
>  				return -EINVAL;
>
>  			page_no = div_u64(page_offset, ch_base_offset);
> -			if (!page_no || page_no > INT_MAX)
> +			if (!page_no || page_no > INT_MAX) {
> +				dev_err(&pdev->dev, "invalid page number %llu\n",
> +					(unsigned long long)page_no);
>  				return -EINVAL;
> +			}
>
>  			tdma->ch_page_no = page_no - 1;
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>  			if (IS_ERR(tdma->base_addr))
>  				return PTR_ERR(tdma->base_addr);
>  		}
>  	} else {
>  		/* If no 'page' property found, then reg DT binding would be legacy */
>  		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		if (res_base) {
>  			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>  			if (IS_ERR(tdma->base_addr))
>  				return PTR_ERR(tdma->base_addr);
>  		} else {
> +			dev_err(&pdev->dev, "failed to get memory resource\n");
>  			return -ENODEV;
>  		}
>
> @@ -1130,6 +1147,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  		tdc->irq = of_irq_get(pdev->dev.of_node, i);
>  		if (tdc->irq <= 0) {
>  			ret = tdc->irq ?: -ENXIO;
> +			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
>  			goto irq_dispose;
>  		}
>
> @@ -1141,12 +1159,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
>  		goto rpm_disable;

can you change to use devm_ firtly to elimiate goto first, then change to
use
	return dev_err_probe() pattern


Frank

> +	}
>
>  	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
>  		goto rpm_put;
> +	}
>
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> --
> 2.17.1
>


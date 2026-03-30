Return-Path: <dmaengine+bounces-9727-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHPXFBuSymma+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9727-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:09:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E035D7DD
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C791D30321C1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20094333727;
	Mon, 30 Mar 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1X6w5iO"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD75324B31
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883044; cv=fail; b=AZQV43YP1jiwQmH0Kl5EpzES4AKKci9em2aBN/cQP3vb4EcmjXGYx062Wx3eu6OCHRcHqGHun+XEPOJOzZqqTBX//TQxJXIUX6U8gDKzqJhQDzHXfP8i6wyS2ZMssHSkvAO6cJAU8eiMBMbhxPIghQm2q/mguTdhoOnMbyzIm7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883044; c=relaxed/simple;
	bh=DpD5wcK2F+uJrqlDunFKzjFd7ZGVYKrcl7H4yNCO/Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jbeDofi5DDAWYldBefEJ7HFZ+XYhTSMMI/73A7N0UviHGUl5p/VTKu/qvbfunZa4mXTUJ0UohcCY+JbN32txmsZMiqHWiIlNo2ScNrlb6LGOPPIKsf9/iwDrtZGjmAM8VK//EEIK4YvA8HtzxK0NwkusrOdXDjUVxdXGU4eceSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B1X6w5iO; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0P1p6Ny0b5Im7eSYRq9QNVIs6FTqkHgBTCV2jYExg1JdmmLUY2G06ws0H/4GSDpAnpeJNYafAg47LKV2HUqpZQctrfd8EjTfUSRjRF7crLwYIa0zA5o8HgvuvxHpY3g97Oeeq5OfQa/dYU/k15HN0pqFQccjA+DyHVMXg9ZNiIBN2jJmKEDFXMNG+BSin1eqcd4B4wo+mNAjciaCft5CWRVsecjQ3alF9jzJlyN+C7KjzAXTZNpGitiv0R8WLjIaCgkaOcCvs1UPqBteRBiK5Kjfkob5nRkmCSX2hG5oOrkd6+ZNd4LZC9XgIuXbbbDkNYeWl//V+DvWGNT5SELPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNZ7AQl8E41XlMJWe9l4Qav+6ohTQiuqpbzzWk6kua8=;
 b=uvN1LZ8iSiyRYwsv08FIeftzZgIAIwAHBQBZVlGyf9VeSQkTufZLPI8ic1r+6uq9zEvMWFmXU/AxxnlwWZumb1tSN/BkWdynTJjsFoOnfipEwFOi4WA3HR9aNeO5yhN2ezPTlSL2PE5DZo+XMX0Jn+SB4xlh3GNspvLepFhl5XLvrlAlJ2GlqU4QksydtnoYrFnqm5Eqr1MpwIy74BZ7W2RdXPeAjX04DRvuYs/ivWMsBgLoEikrGr0wRSqK2cYqFyhzlte6xVvb6ls+VEe+KbxVc8IjLcWny78TYAXeYAU88BNXHesFN+4R5arW4/xdFsRwGMgA9O6ti1TlPauMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNZ7AQl8E41XlMJWe9l4Qav+6ohTQiuqpbzzWk6kua8=;
 b=B1X6w5iOQI16qWT2mno9DZE16gyiNUgOLf7uv1HXv92Fzu9rMcQpJVKwsYWlxOJ3LJjzFthZmfHaYMAnbqaCSd5BTzBcQIErzYP/ULEgR4VjGeBClrN3UXq4akuWJvsTYngbMUcl1o+YAt3OAprbF1pLe9A3YTyzgPZ1qF448+mtMppyWQQMDfCzVKRBNqVv98fvFidEJPzaisswwW/sb0RhyNvOnxE/Jf57aVeslXmsxWxSYUG0+mvWFkdlRFyN16mfF+Wslpz/jRYPF+olQ9gGQRaljmaL5bJsHCQiFOay/1FHULMbuH4ggvIFVJmg9sjsZ6pkbyEGy55ZAIY00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:04:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:03:59 +0000
Date: Mon, 30 Mar 2026 11:03:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: David Carlier <devnexen@gmail.com>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: switchtec-dma: fix FIELD_GET misuse when
 programming SE threshold
Message-ID: <acqQ2X2iWPcJAnGM@lizhi-Precision-Tower-5810>
References: <20260317083252.13224-1-devnexen@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317083252.13224-1-devnexen@gmail.com>
X-ClientProxiedBy: PH8P220CA0065.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f39d2d8-6db0-4d04-f498-08de8e6d92ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	QOWWE7seWM9BjJF4NbKG7yIYuJFizFj5wNo0DTGQXeOBwlPfoO+P68QI8/ofvDPUyuwAP2x0s0fkoqAlyRnfN1lF6WVhBwZNW6G5Ca6NYexiPDFTlQmYNexuLkstHIDQUKYWMBAyi7zzLZW/5j5iN04oqTC9cDqofIfXHaQOyAl1ZToQZTKPs7/q+l+WQm6WBYERyeearker376aEy8YlpCA6YDPtw1Y58OGFtDmzvu3tdtU2sVMdVGEODbQ6SzmUfNjWwnJYRhaYeC/cUyIb7TGB3Tl5vZTwZiq8EGNY7fRQE5wZBbtPBaUTJJG1c+53JM4cw7uP2guKlB/XLipJ5Y7uOzuluZC4hK/xWU3N14rozf10XRAM+pCU9d1ahe9I0m6V6NDDwIzdSI3J5Dz5xH4DuxBH6g99nlAJO9cSwFacRLpy+v5UVE0VGV/AMk8gBDRS6WtGQNmM8kl/kw4KXoOicjszRrQaBzgRzmmB/5uBAW7Unkn2HAPiMOpt1+v83RIGOsaePYXvIZj3WaQ5DjQ3/5XR+OLdlk6gLerBMfLPQNNjq13jj87GGvg5OGlPj99NK/pulbAYk9XpslCxE/SC7E9I726Oi7g4Y7D1easedluY6NAEnNb6b0mzBqVokjSgDHc5S9szPDq1QYjqEHL6vNw5mrYlMLWcFDaj3gt/YVyWEzeOnQZWroFDfkvFvmSjjsBkKSkTWnuSSKB4bKzRui5gWHYW5QcPCdfStm9Uta6hg6wmobzeSNjUh+ICbESJySdFpHs4AIV/TSroq6zZ04BuH1T/9+T7ElpRRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOXJN2Nw9bz5DSCBOOz/a2zX56OpiewPlb0W9UwWXQBfV+Qy9t9LH62PYQaE?=
 =?us-ascii?Q?3tnaF51lwkGqEtwARrpz6oLXzoHGo45mlDGKxXJP73bleFb7+NF+GLpnqZrI?=
 =?us-ascii?Q?pV23OrE/E58QGNkqau1OCbFf2IatGCx1tAjCjVBWovp2NFe/QiuhaA0R6TJl?=
 =?us-ascii?Q?FroFNnid/d1UaXZpJSJwcr0or22cvCFKWnhi/cgxvPmdtallKQ5dETMEKB56?=
 =?us-ascii?Q?+gE59QEtNoOGBHCqpMh6McmghMQXkhYg1xFQpgsRo8kehkNmsWJh5D6gbQW3?=
 =?us-ascii?Q?q4/9rcM6dNTuDL0DkLr8RSs+3nTrDarlBcwgqt2ur1whmHJukv99k8YvUVzy?=
 =?us-ascii?Q?v+eIoH3DXyEXCMqh8vHqdzte8BkTba/2ORkfUYmbJVqLdlh9p1wrqKXnIJ2M?=
 =?us-ascii?Q?QSO3Zr0nI4VOu7sYU1GfXas+OoeF5Vw6Wqi6r0EGQqR9XSTM8Gy/ibFSOfQ2?=
 =?us-ascii?Q?1bKP81kRZQUMgfyjeJa16H9CNzLn0NUh3YinHrDgrMLrt9S4wM5gC9F/WQWl?=
 =?us-ascii?Q?LXft4LHipLQTovZaIIF/Y9sYJiEo4WfEda1xFv2fOwqd0ziTVDN+AecxRLbT?=
 =?us-ascii?Q?8iHaA0Bl53duJ8Dt4Px1Y4uQ4bcrCWU5gk3kegGEvgE8DiQXi9FsRb4hsnuH?=
 =?us-ascii?Q?FfaKnOWDj29WFUTfPsD4KrTb3EQzvs6lyBFu8+z4DNuRZfzgVniRhciAUXVg?=
 =?us-ascii?Q?ckAquYx0Lr165ikxz6EH31i1gmZtqy7HinvCD6PknyqQ5q5VPHB8q+ByHqjd?=
 =?us-ascii?Q?4+YGjN8zgi8vY58ngi8eyC47WnKnk3Od71OGzd+9RIRvoS0cD2ln4yOSezYQ?=
 =?us-ascii?Q?N6gDaPIXRq4+5f282h8gzqJPsicLkzje1JR9KTfyXBoIv1Rx8HlQsq1Mu/Ve?=
 =?us-ascii?Q?aENAiafzsRMFK1qNrth9J3Rp5IzfFvGVg+7yJws8lbfYqfJ+WPWTOhggJtjq?=
 =?us-ascii?Q?YFyhe4IVOMqWCI838RknlG1zkOHRBoHPjGM8LYf5CmLczySJRGEq+i25Ps5T?=
 =?us-ascii?Q?2zx6UKPhsWMdx2rby49zUP5t81it1ncMsm17d8fmaJh61GIbFK2S/7KKyFwP?=
 =?us-ascii?Q?cGvLV42NzSjAPlxxJeF/K6emOxZ6XK5DrWa28UN/G8eyTVuj5xVZsxNNuD2f?=
 =?us-ascii?Q?PIPbkJ7imbbMBbRyHc3JkXCPcpbTeKWC+IsnofZtIYnY6HP18nARfzAGO3ts?=
 =?us-ascii?Q?L4pndGeNbDzZmgcL48r0VL7kwksa+PjfU2rrtRVU6KDwtQcDN86Wfi+UAWfi?=
 =?us-ascii?Q?S+rGmaTNt5qsMJMk9Q17MNhOA3JNp8TQkmefB3SbSyS/kn13WfHSbExbTsGw?=
 =?us-ascii?Q?jCUgmt88uVby73r6pzs8yHSSt6luC5yBFEKyOen9M4TkiLPB5I7OCcZpMFq3?=
 =?us-ascii?Q?TbWPV4vP2VDuwFH5IkP8mqvewaRrU4Eu9w+lQ8sZyLJk/wD/VKBV57RMG9I2?=
 =?us-ascii?Q?7E01ERtztIdc99CcegPrDkTtnW28uDN+nD8/d0o+cekBcwtlxxlO+IEPKyBD?=
 =?us-ascii?Q?8c3lSmHwI2HfRJPuVCvdjFaR8aw9gxENA0CJ23ybtzJjDrULwDy+xaqq8c7H?=
 =?us-ascii?Q?p5NGfdad4bRe/o6d/VuQXpUnI2VqgQgi8sCKkpTNsE42QGdBtlNS3TrM8+1t?=
 =?us-ascii?Q?OiPDuV20PNgH7Qh2cw5xZmfsfj1J7mWKwz6yXiqje+vfh/Pi8Sl5V+x6pNTg?=
 =?us-ascii?Q?+0Wsh76ZQ/K+hVYpd7Z8ez0TCjw63L62evIP1uO3FccqH8qnQglRjsXPCixP?=
 =?us-ascii?Q?B95ievv+BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f39d2d8-6db0-4d04-f498-08de8e6d92ab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:03:59.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbH9hJth4rVWR3yrBnaQV17SzZbKYeG9eIyHw63T1BRYtNLH4nIKJOx2SfoG0dso8Co70AXW9h/EoARsf1pFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9727-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E23E035D7DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:32:52AM +0000, David Carlier wrote:
> FIELD_GET(SE_THRESH_MASK, thresh) extracts bits [31:23] from thresh and
> right-shifts them, which is the inverse of the intended operation. Since
> thresh is derived from se_buf_len / 2 (at most 255), bits [31:23] are
> always zero, so the SE threshold is never actually programmed into the
> register.
>
> Use FIELD_PREP() instead to correctly left-shift thresh into bits [31:23]
> of the valid_en_se register, consistent with the FIELD_PREP usage for
> the perf tuner config just above.
>
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef928640615..71d9868ce613 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1099,7 +1099,7 @@ static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev,
>  	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
>
>  	thresh = se_buf_len / 2;
> -	valid_en_se |= FIELD_GET(SE_THRESH_MASK, thresh);
> +	valid_en_se |= FIELD_PREP(SE_THRESH_MASK, thresh);
>  	writel(valid_en_se, &swdma_chan->mmio_chan_fw->valid_en_se);
>
>  	/* request irqs */
> --
> 2.53.0
>


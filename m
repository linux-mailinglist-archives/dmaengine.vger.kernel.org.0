Return-Path: <dmaengine+bounces-9730-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMbkF0OYymla+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9730-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:35:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF035DFB4
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199A0301FFA0
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8463446C7;
	Mon, 30 Mar 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixP0eRAm"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1233F8C5;
	Mon, 30 Mar 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884141; cv=fail; b=WY2iz4zKSIXCNQHk6Jg7EKLaHuOWR+jJwfrWkdWyzTG1GWa4lR46qjYEoG+hwiNX2ZK0HYf2OX2QwFlrJ5r5seDy4mg0XRCOkAZXVzZEkpdKv5Q8YHPJrFazVkVPeya4oMUFBsrXQBofppI8PXLMt0TlQogG2EDKSvkxjN5Hny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884141; c=relaxed/simple;
	bh=ISCBC1Lcg3kiOpSyxtiDRHjYLPnxWtPaA3QfxAsPD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmgc7Ct09+Bnv/UsY/bQxWazWyy3hgRQXL5E5dvv1mAM+q0dllrh+0aC0/ZR0uvRNkkK+yH5E2fMvP4dIinOlpEHcoFidYNRWqZrNq6PSO5bUddMbG4pvk1zw3z8yqbm7q5fJxbfqy9wPwY04Kk5zvg2Oov5b/S8Xa+GK2s4/gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ixP0eRAm reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIF1DVZMOHnLKFrvdeKAd0hoZYlGVlARZbQzCCkt00HDlfBRKurkwzU6Vum0qiGrMXWw7xP9NVVfKDp3PSVmMcWYV5C8gFjZQ3+va/I1qUp0Y4zYgjDzp/b38xSLVYOzrcCYWenI2ZelZN4avWtm232JGoMr1rSi/Alk2ePnit76AtuA8PA52IaQIWRDOFTp1F70cr5MAbeIqmlm8IIqxzv4rPGO7KlJcm/luUkoEsisI5SG+PkKxIhXu+h291hDhJ5y6L05UTCONrK9iNpwYYwb4k5MjTKEVZMiz0aX9fK8YO6y2TTrrx7jj13N3NsQtwjKdAx6FlC9JG+xGeSCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT0xyoLD9r7N/UEtBn9QLV3W4V5+SrRfZDXrbvQrnrU=;
 b=dtOMIRXCQGdvsbhRGhnLM9r53IMZzzYG310aJEwSM/VzbARG/Vo1mr80Eyd5xj9meolVfrmbJePFOnBOrx6s1szmyThCWn1KFWWPT4j/UinDCzfTcGCDFCVs6yoYKC6BP4sGf6KNedvWuxQ2N2JobLcSfij6J4sb20G3wtZT+bNs/3k62SFE1b0By+CEqCG75A3l1T3PSYaITKoMaXUngm6cZ95GBYEYd2dTSBTi2EYZjOA4AaDsLMOvZeTX5eaxV2MPdutRhUoENmTC6RJAp/xgeNBZgzAzc8EzEafVLYur9uEwrktLPKTPmRpGnXyJxwAFFMHWzziH5i7YVf5gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT0xyoLD9r7N/UEtBn9QLV3W4V5+SrRfZDXrbvQrnrU=;
 b=ixP0eRAmPlC+KG1Aix306BTYqgNB7Z3xc5HjYXc7QTN/xP9V0N81XaGbzamtYZit+bVK04TS49PS8pU9s6x5h2ggTfwkv3BYtIfE4E3g7Fa1Lqb4uS4PPMUJ+DMHjm1cKDlruOtsXqRbN9HaRCsG0Tzi3Y25BgzJZNYFNuqxbOL/xWvvwkpm5HB4vA0YKZR87RxO1esMKjOlxSCTx9giHnLXjxvutHjFmkMd6Lysf+lQEc/MFEagSu8Eyrkwq+XkiYokuCwQs09x3IaUnQB4mzFTrpLTgkfDigOy6XIJqOmZ1xkuKi0ZrfhFpabBh9RRm0Zos/Fg+R0RlkbAtkuw6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:22:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:22:17 +0000
Date: Mon, 30 Mar 2026 11:22:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 3/4] dmaengine: dma-axi-dmac: fix use-after-free on
 unbind
Message-ID: <acqVIrUwtIM5AaG3@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-3-021f95f0e87b@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-3-021f95f0e87b@analog.com>
X-ClientProxiedBy: PH3PEPF000040A9.namprd05.prod.outlook.com
 (2603:10b6:518:1::4b) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ec308b-1aec-4f9e-36c9-08de8e7020a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bmDOuGT0GTIq5Wk+zJ0zsNU9lxEweeP7CQM8utDgCNz2aFTdEQ+DY9HwPLGMZbgv8xM5VleCp5PIqoh358xIVdtnxuyYN5L/Rustc6FFZfIq0i/DaR5GQEonsDFg2Nkrh5TANPY1Lr55J2Qeq3QF4r7uiFnXdv/I7vjcbT3heL+MLaRRyoCKrnXbXFQpXZm0AgZOmBkSyFqbXZjqMVaSD4yD8Tu3+VlSp5yWoYSOrzdq2AK47y1MtIl/vHfs9OxNits1xCsajKhXnZM5K78vqMwMUtNvB2TKMnEZJ92PrtDIbHYOqrw5T4N3ZUlVtlvQo/de7H+MIL2mXOnW6cq7Owg++viEidOWsV1++lzs0muhzMI1J8lSi1owGMuHAUZBfpGGBVexZ5XABata+2INgRIzsYnxJ7clGXTqTILvCiqpGFHkRBjsU6TyB1SF1xpzDoWbLaZyi9MXieX08NjgkqGin99NZ39KHcBZP/L4G7Pdmov/IC95rOXv5c2XiT8bNxkDhGrPtdA8LaQ8P2LbHbEB8o4K3PwZNbHyWiy0yDmhMh1TWoFZSYaXbSu4wNR045YPigZULjGExFQvzLqgAf0d5nDTkCBe6OeR7cqHuk1TXQsde8K6p+SpZn1Qt9oHbPXoVRrCYIHHZ0jPW4Nrb/wG9bDPwhYYRGWtqv2bM8eqlw2+TVILg/U9l6iCbOrlckYNWmvgUVj1R9vGtO2+TTnI2Si2UEhaFMujuyau+Sy0w6MQ+fVyTIHWk/rlLIF8X7lNokPlsztKY2jZwBoQHCwXZ9KeSVzX0WcJPGhWvaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HE+j/GlBhDSXbt/CcOne/ahhQdJq011h+DVFniHdXaPMWEzrQ1VDLs6jyl?=
 =?iso-8859-1?Q?stz+am0AVpZLDMWszoi03Tt6Bi4zctKH+7QqCaZp7kcnb43oxO1HezERfs?=
 =?iso-8859-1?Q?46QnFrqv1kQ68ZXI/rp70dM4PWagcXkY6QPMgebCSRyT729LfNNhVeyII0?=
 =?iso-8859-1?Q?G3TmQQVND3dqDJvlspzoMwldUiqQwT6zstYvNRHoqk7l/TnRJ9UZxFD7q9?=
 =?iso-8859-1?Q?Zc5zwYE7H9ESKUTdAANbcN3CTxlNnoJbJHtU6g20lh593CDYbENJr7UWrd?=
 =?iso-8859-1?Q?DWVNXjQtmBcTrSf8Q4zMbnKRx3N3Yo4wAzeQsQ4TTUIGgjVy9gzQvkLLYg?=
 =?iso-8859-1?Q?4xeK8ja8pdnD2dj384KY/3xJAHoDIJ590NxU7iUdZ/MFnlQG2SZBj2FS/A?=
 =?iso-8859-1?Q?tFW24KBPWlIUnvyeBuxzUyr05qpCnRVrAhLGeT7C0qCX2RZyMD7FoNAL+T?=
 =?iso-8859-1?Q?LvQyvOY54aeW5uuVwWBWR3UuM1W27VHA1TBShgzl4DoQ1JK0+P/6iyPJ0Z?=
 =?iso-8859-1?Q?VOtTpMRu+GCR85YTNM3Gd+sSVxAtaq6YAJUAU0sP8V4JoFfxBqUV7JfWqQ?=
 =?iso-8859-1?Q?lgJVp1iXLZ30g9mvH5YKirohQ4M29MYMis7s3XZ5Vdw1sV4IoL5ZvvSGdS?=
 =?iso-8859-1?Q?HvQZsdF1AJq1sMWoPEAriBzs8Bq2OluevWOklh8VpyolVwV83h9IQgHHMC?=
 =?iso-8859-1?Q?cPEN4wzKTcJA70BbqvlPCUdMvfGjQbZIl9hc1BEMExPcqAQoImoLFNDh6y?=
 =?iso-8859-1?Q?27AC3vZoL4eSrkrQQf55l1RXjfc72DwSc9sT5+i2S0FpRYz7SYx+Hp1B8d?=
 =?iso-8859-1?Q?h8wrZ0UK2QwnYZiJ5jFT8I/4Gq/h958DbBtXk5C3G0+nTQnc6A1kjVkvDf?=
 =?iso-8859-1?Q?Mika6HpTDGnk+S/DZeIm6NXGbdxe+a3fMgnvXbygoM12oCzKup8niSnRTE?=
 =?iso-8859-1?Q?LLk8AUM1UYWOuUT+SAB17LUtOWk1t+lU5EgF/HWmwOnBaKmRSTCzFzTPtH?=
 =?iso-8859-1?Q?OvYUoE/MZX5706kHI2do0NgFx4x+batMgcYhpgkEboCh8mA0ARSAGcRXJQ?=
 =?iso-8859-1?Q?xRRJXZGXDsQ8PSEsLo+oFVOxfW+H+4rDaTE7GRY7kGIA3TqICTrE1prB9d?=
 =?iso-8859-1?Q?Dwo8o7LZcmnm+3F5wSS+XO/sx2WapwOzALWdwVq5HHWhUzsAflRhiT5/ib?=
 =?iso-8859-1?Q?d2HGLsEXmzQ7FldJr9XWFYorf2bAG3YN9T8vZcnm/CBHnFQSYHzvNsZm/+?=
 =?iso-8859-1?Q?7fD3ZoDhZz876dKwstwGqgHYj4VNQ8DaOze3WhWR8uVGBIpYA5X1RlnEA0?=
 =?iso-8859-1?Q?XaaxS8OsBOP6J4dFRyG07B23Iz58ezhXvjvg+8ioDGNjEsJe2PDy8Z/cUi?=
 =?iso-8859-1?Q?lzcUbuYGq2+aVI+hPtFmNhNShGoD2cRl3AWQ3kN+J2IxrleOHuPhwurVny?=
 =?iso-8859-1?Q?D7iL0/WRxVNCQf8eGa+ISG/Z0mkOUrhtkuzb/spnDGcEB7+IMRIJq2w9tv?=
 =?iso-8859-1?Q?/3XqRAHYT+vkw162BM/jU6ngxSLR+YGE/8tUqPOgTV/57jNcljdFR9SBIp?=
 =?iso-8859-1?Q?6UfV2Yz3Gp2TQrGqIDBpfVgoEcL1CZayc8/TKaqVrelp0cHuULhmHrFH9P?=
 =?iso-8859-1?Q?gpZ2AGb6z74RPWl0FJuDKybD1Xa+PujA7bCKa2wG3IhaoJfNiOTIyG02lY?=
 =?iso-8859-1?Q?CYP/eQny6YMrpnbp9QkpZeMbtYS3fO4OBsNCwFlsPyqAD0QNozkbdnzClm?=
 =?iso-8859-1?Q?edK/nLSfsLxDEFdy0ykpTQ68mAIADIVFb03H3b6fdoFgjD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ec308b-1aec-4f9e-36c9-08de8e7020a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:22:16.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo3UWBQbiFerbwuXG2ryliNYEMCfrJ83KkkuPgC7Wv4fJF1LWdEjx4/giTTvutADadPBUkhUz1NSxdUKk2Du1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9730-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: B0DF035DFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:58:40PM +0000, Nuno Sá wrote:
> The DMA device lifetime can extend beyond the platform driver unbind if
> DMA channels are still referenced by client drivers. This leads to
> use-after-free when the devm-managed memory is freed on unbind but the
> DMA device callbacks still access it.
>
> Fix this by:
>  - Allocating axi_dmac with kzalloc_obj() instead of devm_kzalloc() so
> its lifetime is not tied to the platform device.
>  - Implementing the device_release callback that so that we can free
> the object when reference count gets to 0 (no users).
>  - Adding an 'unbound' flag protected by the vchan lock that is set
> during driver removal, preventing MMIO accesses after the device has been
> unbound.
>
> While at it, explicitly include spinlock.h given it was missing.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Not sure if it similar with
https://lore.kernel.org/dmaengine/20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de/

It looks like miss device link between comsumer and provider.

Frank

>  drivers/dma/dma-axi-dmac.c | 70 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 127c3cf80a0e..70d3ad7e7d37 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>
>  #include <dt-bindings/dma/axi-dmac.h>
>
> @@ -174,6 +175,8 @@ struct axi_dmac {
>
>  	struct dma_device dma_dev;
>  	struct axi_dmac_chan chan;
> +
> +	bool unbound;
>  };
>
>  static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
> @@ -182,6 +185,11 @@ static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
>  		dma_dev);
>  }
>
> +static struct axi_dmac *dev_to_axi_dmac(struct dma_device *dev)
> +{
> +	return container_of(dev, struct axi_dmac, dma_dev);
> +}
> +
>  static struct axi_dmac_chan *to_axi_dmac_chan(struct dma_chan *c)
>  {
>  	return container_of(c, struct axi_dmac_chan, vchan.chan);
> @@ -614,7 +622,12 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
>  	LIST_HEAD(head);
>
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
> -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> +	/*
> +	 * Only allow the MMIO access if the device is live. Otherwise still
> +	 * go for freeing the descriptors.
> +	 */
> +	if (!dmac->unbound)
> +		axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
>  	chan->next_desc = NULL;
>  	vchan_get_all_descriptors(&chan->vchan, &head);
>  	list_splice_tail_init(&chan->active_descs, &head);
> @@ -642,9 +655,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
>  	if (chan->hw_sg)
>  		ctrl |= AXI_DMAC_CTRL_ENABLE_SG;
>
> -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
> -
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	if (dmac->unbound) {
> +		spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +		return;
> +	}
> +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
>  	if (vchan_issue_pending(&chan->vchan))
>  		axi_dmac_start_transfer(chan);
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> @@ -1184,6 +1200,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
>  	return 0;
>  }
>
> +static void axi_dmac_release(struct dma_device *dma_dev)
> +{
> +	struct axi_dmac *dmac = dev_to_axi_dmac(dma_dev);
> +
> +	put_device(dma_dev->dev);
> +	kfree(dmac);
> +}
> +
>  static void axi_dmac_tasklet_kill(void *task)
>  {
>  	tasklet_kill(task);
> @@ -1194,16 +1218,27 @@ static void axi_dmac_free_dma_controller(void *of_node)
>  	of_dma_controller_free(of_node);
>  }
>
> +static void axi_dmac_disable(void *__dmac)
> +{
> +	struct axi_dmac *dmac = __dmac;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmac->chan.vchan.lock, flags);
> +	dmac->unbound = true;
> +	spin_unlock_irqrestore(&dmac->chan.vchan.lock, flags);
> +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> +}
> +
>  static int axi_dmac_probe(struct platform_device *pdev)
>  {
>  	struct dma_device *dma_dev;
> -	struct axi_dmac *dmac;
> +	struct axi_dmac *__dmac;
>  	struct regmap *regmap;
>  	unsigned int version;
>  	u32 irq_mask = 0;
>  	int ret;
>
> -	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> +	struct axi_dmac *dmac __free(kfree) = kzalloc_obj(struct axi_dmac);
>  	if (!dmac)
>  		return -ENOMEM;
>
> @@ -1251,6 +1286,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	dma_dev->dev = &pdev->dev;
>  	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
>  	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> +	dma_dev->device_release = axi_dmac_release;
>  	dma_dev->directions = BIT(dmac->chan.direction);
>  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>  	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> @@ -1285,12 +1321,21 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * From this point on, our dmac object has it's lifetime bounded with
> +	 * dma_dev. Will be freed when dma_dev refcount goes to 0. That means,
> +	 * no more automatic kfree(). Also note that dmac is now NULL so we
> +	 * need __dmac.
> +	 */
> +	__dmac = no_free_ptr(dmac);
> +	get_device(&pdev->dev);
> +
>  	/*
>  	 * Put the action in here so it get's done before unregistering the DMA
>  	 * device.
>  	 */
>  	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
> -				       &dmac->chan.vchan.task);
> +				       &__dmac->chan.vchan.task);
>  	if (ret)
>  		return ret;
>
> @@ -1304,13 +1349,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> -	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
> -			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
> +	/* So that we can mark the device as unbound and disable it */
> +	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_disable, __dmac);
>  	if (ret)
>  		return ret;
>
> -	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
> -		 &axi_dmac_regmap_config);
> +	ret = devm_request_irq(&pdev->dev, __dmac->irq, axi_dmac_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), __dmac);
> +	if (ret)
> +		return ret;
> +
> +	regmap = devm_regmap_init_mmio(&pdev->dev, __dmac->base,
> +				       &axi_dmac_regmap_config);
>
>  	return PTR_ERR_OR_ZERO(regmap);
>  }
>
> --
> 2.53.0
>


Return-Path: <dmaengine+bounces-9246-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EWDNzBdqGmZtgAAu9opvQ
	(envelope-from <dmaengine+bounces-9246-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:26:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445C204377
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083D93060B10
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16434DCCD;
	Wed,  4 Mar 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="feaXTKe+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE534DB4C;
	Wed,  4 Mar 2026 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639325; cv=fail; b=oJKgmA1GudGpP0G32M8AIdSbHoadebISr3i+NZcmvC05E+MoaA5mS4xgP4keoOniL3TXyJe2n4vo9ORPfwe3Z4ozSkyawHbxTuRO1W0okSNLp3ExfW0CPV5X9xkjXgNziiz2y0dNAu7qlE4SVlAHY/G676M7jBIHNFmrGw9vt+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639325; c=relaxed/simple;
	bh=ckzeYE679/0ADuidZfF6kOqJoEIB5nYmMUNuatgPfpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BtsGFjga1Xc48yypFY8rmTiza1c6UYXTyuLVmt0jMtrUp/ELYHWmiuXD3ElNEFOmra/HubfDBpJ/3pLYonFZ7UY9sV1pNY9BgCVdpIAV6p9d9nsjc8URRG1GYdbyAg9jYcBWqMwV6TsSKWSSkYN/ai9RDr6KwPA803+DMaRpRgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=feaXTKe+; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X57Akml8qfC+742fUF9DBWGu3mUN1xF0c3U6I9NqB6+ehpk8qKrsi1ogon8tbWXQ8v1VQDzhUsIuUMqVbaPDa8bO0012pqGB4uaGdiFlsHu6e1Y9waFRjATy7vl7+rsRXcwNW8Js6Pm7eL6gkDUBzwUwpBCh97mmqurI9qwBU6ebgKrX4LoRL1B/GYGYgmNqk82h0sX7Q3Fh1wMhvRMqEa6ri+OFHC+eyol0FRyOpxBlHc0ysP7jfAsH5f2YodOYDA4hpfaiQo+588JR5TNjs5R2HbMiTXMgvXj0WImuUYarhpLoNqGXVTXaNYseHZNfAHSStW3Yk3ARK7sf5UvRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDv0icpq4UcezhzRt3XEn/yOhcsod0ZnktSqB5jJe2A=;
 b=XKl83EYY0+sGOz33WGjpjGr1aYVJscmFu6pJ3W5Q3D+K5QMDXrRFnRbYhiSaCUYsm1SmEU9Y96tBELHw0YpbKqYBm9js2LpaPZnF4zvV41Z5D8wQMlGyWDL8U+MUudQeoKWQp8ccPgJ23HmRCYIcWTdJNXnfbp+sMI3i/zfTnTrnS16+dovBhGjdEqEuPM0Lj/12FNU/kPcKuup8DuB/QYimzug+dMaD8Mjt2pYO4Wq4E+JRi+Up2lQwRgzq1a5nZl8rTnV35R8Rz0886pXvYT2Ry2mB1nhPeThX4wvCkoug5/XbINnh5I1s2HzyHAbgMCqYhbkdKYGkL+111ijIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDv0icpq4UcezhzRt3XEn/yOhcsod0ZnktSqB5jJe2A=;
 b=feaXTKe+4f7ZSVHJtXV3iGT+t9/1z/9Z4EM00BSS/O92S1JBTOGeTw8RdEe+w3zPV4uqmpFsdm6MahC1qBn565aMaJdvQ39SsyNGVo34ab2mDLX3boMTRgRqIwAvM4Vgu9a1VSBs3SHILr20+0qWPTZ2jHS5/x9VkVX8FdLtYA+z9raV/88w3lYIDdbkmrJfemawhcEqtGt3B7n783I6L/YQv/p0ErETYO0zLVFwtHr9+ba9L2LaIQX1amc7hC06YqhPtHCl5y2OmgKRyt9qU3p3hll9g2Nynh8hK0syzvSKIsE4pq52id8NMku9NGqtIfZdiXmUkJtQh0p+ZrNzHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11797.eurprd04.prod.outlook.com (2603:10a6:150:2d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:48:38 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 15:48:38 +0000
Date: Wed, 4 Mar 2026 10:48:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b043f5-f4bd-4b50-c3d7-08de7a058073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	PqeEbK4KaW3O1vIBNsqBeZtYnpWQkLmrgnnLZEH3ghszQVrVkSnkWruvKvAhM3YC2W6GI5sbaNLpdHrTf+5f3VFszCiaZtiWPxuBxV6JPQJQcfleeYOKj7o1Yzp5OYQaa2VBDN2xpWNJMovbCkN2rdFfTBJ0XNCMGcXhRiUGJ5LrTpRpcJ3IkSbvJjONDiAmDAIvHwIbjLzL7pCPuBWSAANKkMbP9k1LgGkCdPIXOmohKlWxQ1uACH10tE6xMbThDnzzJ/vn2py8hbJV66kRTKasQzkbPZougtZG0+mwaMEvh4bpqsPtY3wGjs9QK6Iz5g3I45kFxuAbIyCpjCVosDIurhFHydJJFRu/J7FuUHAVrzqkC6HU4+eeqp6OyU4XAvXQH6rpB/hY8Q/i4ZI87IZNv8W+23+0SrpS998bnGIsPOD2I2EZn7wvy1PTRCtfMd+bY3K3V2qYtmJ+GoausxZBP046AxQZG7dYrY010PoLm9XSH1zRxG/6u0BZloj7/9PZsl2gEFFGGAJPvo2Ts7lUcAlyrb+ObW7KUoqG7rwIWrHCU2Cr/xW62EIiXFpo7eBk3hivpwpUaeEhq7TUgtqd4nkuHPHkJCFlDjzCbu1SvBUIlyXF3HeNiGsP/Or15f3iABkAQLY3aKObWqsWMLV0y1L5zkmxz1R545A7TfDSJoMG2PujgdL/D8poHBZRAM2CKTsnS07yKLG/Kihs4USfy0useRx/oILCVmw9mtXYr/zYp2qmJvZikpC8T+5MXnWP93phk/7ohz5Xtgi5M4KIpEcNTKw5vviJUbbtq0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4JPdsbPnmBIzo7CBOhwJO2WriEF8sC8SUMDCJoo5pjPuvF+WIDBzJfhNXoh?=
 =?us-ascii?Q?pTbsxET560qH58D3iv5ZChsZOvR7IV61GLhZMbaq2QbwzY4o6G8LJoz94eHe?=
 =?us-ascii?Q?TOAY1/eRLS20Jz9sK8V2j+iJ8HBmo4FdgjNRMpEUiqMKtSVneOta0igwuluc?=
 =?us-ascii?Q?HJ89JzO7v6q2cBQ0ZA+YfDEZ00eBZZuQpFvYEh4z7K3lbkC6/Y1WDVgJSYD4?=
 =?us-ascii?Q?GhziD+p9Vp2xp9aSBkRrJbdNZ2kQPIS6qTzkua8OlAnM1d2SIyvSon7w/TFO?=
 =?us-ascii?Q?oFwpq5mqChXHySnQFN5MY6g8e3K7aT0YSI5dNmx2EPpwZMKWTryCB+rUmZRG?=
 =?us-ascii?Q?CeQeX4mYBvYR3e6HNoJPUKLScUKQhC5k3uxyIyiK/7yWVke4ZwcrWGGITOj5?=
 =?us-ascii?Q?jVKw1MW8aVCtjBKjNAZUI5PADlKnpV5AfInNFFfxBsnmWmey39OZ3Mlsw4Ir?=
 =?us-ascii?Q?H2SIIpIDAQL4XU2Nf7ijjg9SdltZjio/PpB8D6J14l9OccTTNhGLd958HvTM?=
 =?us-ascii?Q?t6TU2zyuHDMP81SMAMjHT6b+k0pC7ooGA+xMmgJ+1mHhvZ72tQem96n4Cjeh?=
 =?us-ascii?Q?a7t8tZJ00kCHDkRbOk4VVy9wr+/aGsLAvIlZwV2mMUMPrAOCNxi0weTF0MDy?=
 =?us-ascii?Q?+BMdTrK+JrcR/hL/+GYAkGZm72dO/NOA4DyvH2LRQCfxfjsnDF44cSVh8ldx?=
 =?us-ascii?Q?mMMbeGUuX7URDW81WY7J3yV8TYvasMwJh06cO5zwD6JoJ8r9N3T4+MkyMU0j?=
 =?us-ascii?Q?pnEorKWsx/9sM2h9cj42yWJVmdUg0pypsEjMR8HtrCl5/FSh/ARC2rqWGhnJ?=
 =?us-ascii?Q?XY0uH+97W+MOMC5HXLeC8GzzOl4QY2urQBoSCICUIUr3BCbjopxU5bpJPVR9?=
 =?us-ascii?Q?yrMwafgb1ReU0ISBysDIkX6L7P8cCrmHAhgXX0hc3ke0JCojgCdZlb7hxVEG?=
 =?us-ascii?Q?1qnZA1RsjDNrjde8nQW4A2YIk1mjyEf4jrfwnNxaIJgsly7K8SXkiBlY3DY5?=
 =?us-ascii?Q?trSros1n/c2WIa7cqzrJ87wnZYR9gyYjhDfP0jf/Rf9iIOy5249vnH0024Tt?=
 =?us-ascii?Q?fF7lIcTHgyl29/rJDOs5XPxlLzzw7uEWaZun1Xun6DaCMMThW47/lsdsz72Q?=
 =?us-ascii?Q?T5/Pc2t/5xBKrDJZEB1VL16+WfHEYdndncm4sxZaeNh8ii7VCqHC7eEjxm+S?=
 =?us-ascii?Q?hOQ4sSI9UPMNWbf5YlAv75rkmYwjViu0rg99gkzxxvyYKof4Zm746SQVvkzK?=
 =?us-ascii?Q?vDkjffQV3mUdLfcRDNhABaN+MuDWB+YOvKWrMoiFSCNjiHjxdGfP5rhXUwXW?=
 =?us-ascii?Q?gad8zFOfqfl2wRmPGAdi8CaHgk9EwHUTXTd9QFv+SAeEBWt2YHWzaLaeiCwa?=
 =?us-ascii?Q?c7IZWnTGjsPJzKAi3dBj+LQhi8Fc0H02Y4TrTAZskctTlPfvp8iLleWHcopa?=
 =?us-ascii?Q?TePEEbZoqyUdh4EQ1xUx0tgnFVHkGtjXg2cH+ogvBBRi80CBGpNubgwgjzCs?=
 =?us-ascii?Q?z9n0XN+xDI8RN03JWCucm+fKzPJvROF3+eOnJK5lX+anMaZWuXw3CExroqEJ?=
 =?us-ascii?Q?72Yvm9L0R7zlXazqK6Abe8wQJzOUW6IJB481Sl1grw7usIAt5jQXcis878zE?=
 =?us-ascii?Q?LTVZynnmO5QLdf2m+wAVXYYZX+YG8qfDUre/hs0v9uBCLHIYLARBDq/iZFcm?=
 =?us-ascii?Q?LdhepnEQFj4ch6fCT//i4X+EZX3ZnPGpOwRNeb+eWnQ/5MJU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b043f5-f4bd-4b50-c3d7-08de7a058073
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:48:38.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go583+mNaz5vtWuBGX6rrRvTCSQ7siP3eucK/U2fLIK9f3ZPxzyWNVdpnTpCRXK5dC2R9pCuYysupfKI5PaMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11797
X-Rspamd-Queue-Id: 5445C204377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9246-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amlogic.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:14:13AM +0000, Xianwei Zhao wrote:
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/dma/Kconfig       |   9 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/amlogic-dma.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 595 insertions(+)
>
...
> +
> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
> +
> +	aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
> +					       &aml_chan->sg_link_phys, GFP_KERNEL);
> +	if (!aml_chan->sg_link)
> +		return  -ENOMEM;
> +
> +	/* offset is the same RCH_CFG and WCH_CFG */
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);

regmap_set_bits()

> +	aml_chan->status = DMA_COMPLETE;
> +	dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> +	aml_chan->desc.tx_submit = aml_dma_tx_submit;
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);

regmap_clear_bits();

> +
> +	return 0;
> +}
> +
> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_free_coherent(aml_dma->dma_device.dev,
> +			  sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> +			  aml_chan->sg_link, aml_chan->sg_link_phys);
> +}
> +
...
> +
> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	struct scatterlist *sg;
> +	int idx = 0;
> +	u64 paddr;
> +	u32 reg, link_count, avail, chan_id;
> +	u32 i;
> +
> +	if (aml_chan->direction != direction) {
> +		dev_err(aml_dma->dma_device.dev, "direction not support\n");
> +		return NULL;
> +	}
> +
> +	switch (aml_chan->status) {
> +	case DMA_IN_PROGRESS:
> +		dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> +		return NULL;
> +
> +	case DMA_COMPLETE:
> +		aml_chan->data_len = 0;
> +		chan_id = aml_chan->chan_id;
> +		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> +		regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> +
> +		break;
> +	default:
> +		dev_err(aml_dma->dma_device.dev, "status error\n");
> +		return NULL;
> +	}
> +
> +	link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
> +
> +	if (link_count > DMA_MAX_LINK) {
> +		dev_err(aml_dma->dma_device.dev,
> +			"maximum number of sg exceeded: %d > %d\n",
> +			sg_len, DMA_MAX_LINK);
> +		aml_chan->status = DMA_ERROR;
> +		return NULL;
> +	}
> +
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		avail = sg_dma_len(sg);
> +		paddr = sg->dma_address;
> +		while (avail > SG_MAX_LEN) {
> +			sg_link = &aml_chan->sg_link[idx++];
> +			/* set dma address and len  to sglink*/
> +			sg_link->address = paddr;
> +			sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> +			paddr = paddr + SG_MAX_LEN;
> +			avail = avail - SG_MAX_LEN;
> +		}
> +		sg_link = &aml_chan->sg_link[idx++];
> +		/* set dma address and len  to sglink*/
> +		sg_link->address = paddr;

Support here dma_wmb() to make previous write complete before update
OWNER BIT.

Where update OWNER bit to tall DMA engine sg_link ready?

> +		sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
> +
> +		aml_chan->data_len += sg_dma_len(sg);
> +	}
> +	aml_chan->sg_link_cnt = idx;
> +
> +	return &aml_chan->desc;
> +}
> +
> +static int aml_dma_pause_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);

regmap_set_bits(), check others

> +	aml_chan->pre_status = aml_chan->status;
> +	aml_chan->status = DMA_PAUSED;
> +
> +	return 0;
> +}
> +
...
> +
> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status = aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> +
> +	dma_dev->device_pause = aml_dma_pause_chan;
> +	dma_dev->device_resume = aml_dma_resume_chan;

align callback name, aml_dma_chan_resume()

> +	dma_dev->device_terminate_all = aml_dma_terminate_all;
> +	dma_dev->device_issue_pending = aml_dma_enable_chan;

aml_dma_issue_pending()

Frank
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
...
> --
> 2.52.0
>


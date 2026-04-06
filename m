Return-Path: <dmaengine+bounces-9889-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bac7O+iG02kEiwcAu9opvQ
	(envelope-from <dmaengine+bounces-9889-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 12:11:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBB3A2BD1
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6E230131F9
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DD3195FC;
	Mon,  6 Apr 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KBrV/ulk"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6D40DFD2;
	Mon,  6 Apr 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775470309; cv=fail; b=saK8TZwlTOiWtfR4+qX3ZiXH3Bv2/W1UsZjkslgi1KU2g6xnw0v8XBrZipRKVP30JDwSUYb5poFOqIprZTcRbEPI0me5KXQqZGs8Ww91zbPfUeAfdooGpSVEg5l7NyAgbVc4kC/UUkegmpXLRWmn2g+whRGEoNQbOYAyUbJ6JfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775470309; c=relaxed/simple;
	bh=IJHlNDugciROhQE2lkWrjwncoy+mZFo2get7vs5JQcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gerN06xarJ63ZwyXDeamBdEoMHbvo8HCBvKuy6FEceZy+6Tc6/qcsMq+4QEo+jaykKSac4Aw4cFechwsHyIAvEC/1TsphowxeKU9XiNyCY60+5h24BsrfvfF2WLKGTE51L+NB6Y9Q6YpthcF0AeQXQ4E/brtkyCEpVgzYFC1A3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KBrV/ulk; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owMyJJvdI4T3Et2N+mACDk7RY3rKiPLnEnCoimpqNfnGsnkiOCs6Ogah6fyjxnSN/oJ3NWM6nhQRuQmIXjg6mvrTJBWYHakOFD5ZSKZdEF55dpi+g1zNtBu/x7mEGHjvSj+Un0DiyWXDc5ChSdg66s+WOvG7wBRp2NW1qucyrL8Wvl/QZq8BfPvypzELPh/909UNHaIHKz2Hupy1vcEIL3208+HWxSLTr9ZirUu1nPG+qqMX7pTT4GxAncMRpbrP4FNAreqgSYrRfRnFP11kMxW27r/w3mkj9diGZxg3uVXxBOdSABGOkDVLPlT0UoMWlpKzN+A0fU8joM2uqNzKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ltpzylYkcBgYs3VteiRCwHaaXieFNDr7gtb7gR1KHU=;
 b=TNGgrUl0l0vE8u16It/W/lV+c7rNmOFvf4/05f06YAmM4lv26A8qWw1qn1ezHyvEaCIJszShFkrJ/qgTdQSnP0UESTb2TqKqNaJ5q/XDfnIYr1XbfyAVNdobLkjNBRELUulbm6T88i+R2qHM8s8xLxqoXlhkkUDq0mcK8J4BDptxr78S8MtiW5zx2mDVq3hJ2uRmF91m/lIp1RLXMi1EOPvjwvblsJIxECSkjHKZWjC06NOUPQ7Pf8Rtn4EiWZcYfQWUHuueaZDArKalKGDFKjWSd+mIjGB1PhCJJZmj2TPTCnZ23sv7TgQOvuZPEoA/D4g0UmAfMPot2N39itI3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ltpzylYkcBgYs3VteiRCwHaaXieFNDr7gtb7gR1KHU=;
 b=KBrV/ulk68UjdIAkb/6uX7F7lmQs6VinkUNKQIdNV6lhk39EjQbyWUOCOFoU1bgdiPPx2ymRUZCyobCyTtvzysYsi+6E3FTcg3yzJJQdTOVI8c0b5F1RWNVRdXj0L2QD6/o5L/DCGEciBX6cBEdQYwlol+lnLoBIwvJIvZ+K3y9AjVHldzbkHAQflglY5mwIshKUcGejjXhRVau+srKXTkTCTrJDYDdIvgVk05kis+z5WIQjuFDqZk1dDOqxWnsgxEq0HuDRnoehx/qtl7Sw6/XZB8nNKYdZdCTxx9Irif+iemrL4DRbdiXY+g5brHfSurB7fZ5VAgbeFQOHESWKbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 10:11:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 10:11:44 +0000
Date: Mon, 6 Apr 2026 06:11:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: simplify allocation
Message-ID: <adOG2NfePcz7sSlE@lizhi-Precision-Tower-5810>
References: <20260330211128.12319-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330211128.12319-1-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: d04a438d-c686-40ad-b9c6-08de93c4e76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Rm7xaYVmHB8UXg1RhSHJLlt+BSCwNfNOIC3LU/dufw9pkX84m+oLHJwVAP3Xnjs9xofcPOqwl7VcgXqYWIzS/MbDZ1wDASdp6LHg5gtzBYHYPYW6DI6X0ZGvIVK/BHkMC8evxy5A6nvzPG6WgBlFTtx3iaysrX6OgbAJ9eeaAc/FSuq6Xrd/6KnUx0CBT4UhVVPVeA0IyRAIzGMPJwEZVLSuZ8Ci2YvKMASQ9a4B7CqJCzg9WVbxL6M61SqOtCIbXNZWzcH6dpxTtgFFoJpvCHunLBmVBjD1W7eCtyrvX3aPH9IXLt3khPQdpDKQndN+WlVYlMT6+c29InjJVxBjttoqsdoE0/it1bx4+Crsy0g7qjKJ6ExT6WwPnAZ1OM2F9ZShML/dIM0ulr3tQ67isB0HtfSa4/rFsdRiT9OhAdsNKJ7qj6R7aG9KY9c2p4rEKkoKELzcdY/scRm05a3NvY4pGiOVToyRLvLEz70OgUJxBqAMWG3GkCwbuZjbG33n4wAJRoQkwVvSb67wGONMjOk59xCyeSVpYZSxN245RX+fX0lgwb8ROsxk0c2u6pAyuSfImHHc6LpEoZQzMiJ9df9Encg2IxiY7NXOFYDk5bZO2VZWcGgk5hM5+rKAbnTgANBA8W8jxcJqXPQd52kprhG1nUUtfhek8fJhYxgF3mhw9T+vK61zxVAx+5zK4PXtQSkue/AqyEhBOlAWfxaMtJd2cxg9T5Rxe4qhU5U+1K35Ppp2wLktsUO9v+QjZEwe4VG2/+iMxUpvqI1bOLPCRt7hXpQ61q5xnTMTbTWmf+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hcq1DLXQfDJ0MgMGJbIjUJlwTjqHXkWSRF3JDKF9ftqYwWkSnNcx5hixtwmN?=
 =?us-ascii?Q?2RlBCs+a4xByB7fZQ7CmNdrfBIL8oeQJTEq+KR0y1kgIIruEBHfgf+fNLpnL?=
 =?us-ascii?Q?FBCNwKxOXjKMXzIXbv/0a7jnJrfGQF629rtw7av/IbZYYpehklZ381GrVzzk?=
 =?us-ascii?Q?iYhZ/lgSTdDpJdo858mr61tCP7h0+HJj/nSxaJ9uYxsqiSWtHnCSmHryuzDx?=
 =?us-ascii?Q?Fvgkkbyd420gbf+cyKKgqavRok0XHkGSH6w6J7aIp12pwkkM/SLy738tHvG8?=
 =?us-ascii?Q?N0x2l6rVDaZ5Bz7Fi9kbL/W4gz0ijgFFb81nImD4LB0gnMl3DUyZUAPepXcv?=
 =?us-ascii?Q?Y3bA13ndEYoTV87+v4x+2iDc5hkkjUkj0SrDQKQKVnXmCMmFUywKGwyHknH4?=
 =?us-ascii?Q?a9zHzt3KogXqRcP+gbpdk8TMuvpXJFDkVXVg9wcjWWQPZRDvkoEY4hCOSHJI?=
 =?us-ascii?Q?dM9yN0yYpc0c0l3iYYfUZ6u+EBzzE2vrO12ciOs4ez3k4qLAMEl4jDDIpLyV?=
 =?us-ascii?Q?WSg647Z115Lj7ZSswzCmUKOzcknBU+hAssZIrAhqYuCd04qvlhe/PM9ZEVSy?=
 =?us-ascii?Q?BJuyTRW06sDFM0E85xMWaEB18/a+0bpDB2h+R7sfMZqc8lpQ9s/jXPhGRpKh?=
 =?us-ascii?Q?NeRhwD5N7MttgRprD3jW7sCd8wDkXiJPSVuHt+FHLjcFeSQVox3yvW4YpHuM?=
 =?us-ascii?Q?90fxhT5zMVyaF1uG9/Dfu7FX9T1pz1wqw8Iytj4qOOBObqrBl9wxv/JYQ6CB?=
 =?us-ascii?Q?UfHxdwf/0y3dBHIN6zNpjUumBPCO8HHjx4Fa3OHpLMQvQEGsoXFvNHNA2L+g?=
 =?us-ascii?Q?Irxrv7/OVWV+5ohMXMRTj7aqpcvu1Qbl61QBg31ApAsM41eufbBfzcPv33pc?=
 =?us-ascii?Q?OECWLNr/S4Ae9jqnTRHZKL5k/HfwATHIqN5I/F067xk8gDNDB75q0KA00rRa?=
 =?us-ascii?Q?ClvwQ5ZFvLX1yEZ9AKFcOiGXXSC07708Sekv6S+UajVk01Rm3ZGmFDfDAwbv?=
 =?us-ascii?Q?iqn8SZDxN1C5W0e0ALebt9P7CSNGd8DoLrAvMLf+ZdFdRM1H/ZZifvxdCV/z?=
 =?us-ascii?Q?ECznFJtsBwfHiuRiNF37QW+H1vVe8W+GfSKOpvaQXeYXsNNo7kg8to2WGNfg?=
 =?us-ascii?Q?zEYNlZ82o83ClWLW9cjnn7iq5eBajbMz+CyHjJBmcKB8aJqe7A9rdexiX359?=
 =?us-ascii?Q?cqQQvggQV2lSvFxLWOkvfxC7VX4YaMparYfcIlzURtqGQTBRaYCQI2Fmm0F4?=
 =?us-ascii?Q?36w9baMM+XRcywW5owX3g02B7ta1cijnbaYJvNAOt6PVGTboFUiJKEkdxN1G?=
 =?us-ascii?Q?fuJDbkSgtKCm4PGIjQoruo4AVqvcv70MWkfUq/5V9Xqmegavpy7mfQ+qJE7h?=
 =?us-ascii?Q?tk5IQYvjHW81r+ndqeoR1jHyDJ1a4Nr01nqj3ljG0D7nykJ9oZxSlfutQxSE?=
 =?us-ascii?Q?rQMcSULfrxExkqR+YdQafmDZ6yWMd+jb/6E+ndOohEFvbfxWsg2r+cCls4nf?=
 =?us-ascii?Q?ParWrxZrfm2YoY+RWALgNkG96dV3CF1qxbkYXxrB5gi27OUv2IHBzDs0AhIr?=
 =?us-ascii?Q?QzC1fuzQAsHSiTEhkKXIxdlPOyaJSkMd6b0e+OTtnrnDOoJF1v5M9UoPia9C?=
 =?us-ascii?Q?xgdCPolX14fbEkLOS/Pa5flKhLzqp024Bh7o/0AuxdGaevL4XehaowMXCxkt?=
 =?us-ascii?Q?6fXdlVzx6ag/yiPEl6XzkAHay7HzFfqaBF4zmVtDPmy/0yQ2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a438d-c686-40ad-b9c6-08de93c4e76e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 10:11:44.0431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBR6QcO0Qj0uR3dWh7pnsvhlB0g+Qt9Zl9BQaxc592C2Yy3DbXBbpGLrZIZdFQVihXKIgexoogLHJLNvYxQGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9889-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45CBB3A2BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:11:28PM -0700, Rosen Penev wrote:

Subject should
"use kzalloc_flex() to simplify allocation"

> Use a flexible array member with kzalloc_flex to combine allocations.

function name need add (), kzalloc_flex()

Frank
>
> Add __counted_by for extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e9d2..d3ca202dc478 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
>  {
>  	struct axi_dma_desc *desc;
>
> -	desc = kzalloc_obj(*desc, GFP_NOWAIT);
> +	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>
> -	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
> -	if (!desc->hw_desc) {
> -		kfree(desc);
> -		return NULL;
> -	}
>  	desc->nr_hw_descs = num;
>
>  	return desc;
> @@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
>  		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
>  	}
>
> -	kfree(desc->hw_desc);
>  	kfree(desc);
>  	atomic_sub(descs_put, &chan->descs_allocated);
>  	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index 67cc199e24d1..a04a4e03eb3d 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
>  };
>
>  struct axi_dma_desc {
> -	struct axi_dma_hw_desc	*hw_desc;
> -
>  	struct virt_dma_desc		vd;
>  	struct axi_dma_chan		*chan;
>  	u32				completed_blocks;
>  	u32				length;
>  	u32				period_len;
>  	u32				nr_hw_descs;
> +
> +	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
>  };
>
>  struct axi_dma_chan_config {
> --
> 2.53.0
>


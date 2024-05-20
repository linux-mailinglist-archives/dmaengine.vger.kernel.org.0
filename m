Return-Path: <dmaengine+bounces-2109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305A8CA216
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662CD1C21059
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216F13848D;
	Mon, 20 May 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kPC9uE3v"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED8FBF6;
	Mon, 20 May 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230524; cv=fail; b=rOft/BIx2iodg9is4hCcRGhBJWMLqcGLYaRnYw3FprB9O78YKYa+z1tJ8lRdhfh5bGX5/Y+AXk1UPWAK+5pzLPK9VdIzzLOK3JHHUuwZS1Zszif8AL+/E7NtOleBcJlCItG3U24um9tvgoG4jtLnO0De4wFawEqPQAAYSubU0/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230524; c=relaxed/simple;
	bh=WQghg0P8E0tmvIMTMX7OfujOWHGsCXYJXKvVP7908as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gljHcUvUK3SSo+ioXCyZPUrgeMbVOZeAzgg4H0V85YgI+IxrOSBzJC/Q5aZMFNzvaS/gbwZ/fSjIxvyGzQx6Lw7IgBNlA5qwOMjxW2jI/mlKeBbrIEOy05uanooVS35my7arlDpHRNG67knxVJa+m0jeHOoJaQSDQ7m/ue/U1uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kPC9uE3v; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND3GolhKMFq6iHReELf+Kjhm+Ryv9p/EuXFFeJBhhb4me4jAYfbNWX9MCXsEEQ5zw3iwfO9GCWPnYKGi2Eq+WehzdaRcjSCwKXjVFby1k1ii/U1GY/IN1+dO6TZI9JoD94JpMVoxGxicLWdwNE6ziXghJbvPQgIm25Vu+v8kYfosQ1zFc30LNdguuLfS5ZQNJ7OVkD1K0MjooY3ohumFSr5O8P6UhBKsBAiRNApbmsWXgFU1qSda22PpRksmG8iW3CUd4HMli8eCa8hD+INKRPQ2jsCmwa5DCVRNtVYoveiQ3se2NWH+An76Fala2Ts417SLdlX0ykAanjKayrlHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rca1Z+Uz8bYbZnY9g1TGVGAl79smMRzHSPSMZabE24g=;
 b=ZclRCZv8uIy0BPxZ9pa1dyFfABLpqvFdzagcPqhDXT1p76bvjYbwr0gn+nxbcwolchwb31AY2aiNSvgl44AEz2tJQ1mqUVx688OOdbsyY/yUvvb5Rr9jeuAC0MFX6f59LZEhP8m73zH9DtcaeIKIEEi7SPwpOMT6vgG4kYWhOiL775wW2uBO+GENZbGfPMwkCVGtWDmrvBYmchr6Adw/OEeHqJSYE+xhEVodBxeQailta0+zWTq5SlsViJeVXy3njPFaEtxNk5fnV7Rh8MH8SW1U2iiFmLRhbQaY0rEdc9X6QxrXJNkgQeloWhKHPXa77svh9vJ8rOBLfRa87hWbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rca1Z+Uz8bYbZnY9g1TGVGAl79smMRzHSPSMZabE24g=;
 b=kPC9uE3vBwLIPmcjz62njjY/Ah3NsAlzFLahMEsSq4WIJKGdhuFzG3d7sY6o5RyCTZvMeQyB9ksqo6b1pq17JEH0sTQzzRfF6T7/kpgXnLkdfof+iERNbBDenYDbxehus2534Nmhpvy8QWMLLyr1LvowqhEqIXHwRawEmVo3r/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9285.eurprd04.prod.outlook.com (2603:10a6:20b:4df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 18:41:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 18:41:59 +0000
Date: Mon, 20 May 2024 14:41:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 06/12] dmaengine: stm32-dma3: add DMA_CYCLIC capability
Message-ID: <ZkuZb2I83Q29kW6s@lizhi-Precision-Tower-5810>
References: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
 <20240520154948.690697-7-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520154948.690697-7-amelie.delaunay@foss.st.com>
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 18576f6c-68e2-41d7-861f-08dc78fc87fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYVLd0OuQCMqM6suF1M9oDRiaLSYqqNPU1FqAx7+6/aM9j7qm/3KVZGP83W1?=
 =?us-ascii?Q?48baq4/36Wzs1bfEzaohROMECg49bzQoEG0nD9+aJZ3WPIUzGPQ7nmFIlJaM?=
 =?us-ascii?Q?jEnjxJPv0kPmUJn8ZjCIG51YZWd0aTmiKSaVeO9/wB/zVa6fI9+ot2jZSZXW?=
 =?us-ascii?Q?YjRWU95Wb/zLRYtI0wO2+9mAeW9IauxwjsmMfsAt8DpJ4wlEOAaHT0QTSwEd?=
 =?us-ascii?Q?HpoW9X27jFyErptrHUB76a9ZYLTi/M77sgEgZeX4G5X21iHfQ9qWaXCB6D5D?=
 =?us-ascii?Q?7Me4vNW3f111guPFGzUbQu6AeJWlCwmZT0Lmh2aosvNSjpXIZSjYyvvC/Z/5?=
 =?us-ascii?Q?CsrUWe6tLTZwDBVleYp3fPg5dZ/GT3kZSa9yWolGpqNf2TnweM/tkCcvdfTM?=
 =?us-ascii?Q?KF0iKYNMT7Nv0UN8VWosq/DL8fVcl0+TcZJgNBPTMKkWf2hVRIGA1I/CLPDI?=
 =?us-ascii?Q?ko6sfMTEPOs/C7zrZw1a7SnGiJ3nTnipYyy2SJi/JimciRlTxFJdqQv+sBsC?=
 =?us-ascii?Q?OM04eiyGXT6MHT2W18DqHzeipx1jWiq6gauRMjyT7y6nsdV8icDolB8Ikp8t?=
 =?us-ascii?Q?WQnp5bVZdo6ChDd7I0TZsEY0z/vAIz6GCymYn/eRKbjQed7ZZGjWli4wW/YP?=
 =?us-ascii?Q?Fh1uRDtuBoJyJrfWUEEk3BhAh3YHdJuW16IRL4OrZ1VF4c8gy+AERzUyGbw4?=
 =?us-ascii?Q?sG3YtZu8n/y01bTkvebl64Ymce47NE9vHhTRuAjj6svUCdrQEhB1r1sGG/GR?=
 =?us-ascii?Q?bVejXaTs6KeWfQmDnDHtiYqHHLBdR0Tebb6KKi2IpeGX+2Onf2eStg1G1e43?=
 =?us-ascii?Q?uc917l/OcdqzXFfWO9g/j2M7VhmvCHoZAaQQuSLSNkMed1SKBqBJ3RroJP3r?=
 =?us-ascii?Q?OGaovCHZqrTmB02L0ETWrwFRaUpSLzPHSvcOoLi9+fyyNaxNHotR3L2itpG9?=
 =?us-ascii?Q?JgGzVkyfgz7+TBmcMWCZOGpMYsHUdNobKRmUW4gp3ePi0ODzmsciromv0G8E?=
 =?us-ascii?Q?Bv5mtwpdw5XUGQhPFkRiOJFE7TNJsXbdd2s+TGAMjaSDm6Yglv8YsG+cn3GE?=
 =?us-ascii?Q?sfnK6XXQgdNOumMc0ptL93tbA4c/SAj5pGoZctQZHcJHJXBPVipN28Bt+kB2?=
 =?us-ascii?Q?OZJleNK2BgoWHdit64sKU5y7aFmI36Y3egrlAv7UX9OZjq/AWK+kRJAhIDYj?=
 =?us-ascii?Q?AuiPI0RHr3vwrtXPbY9nuQ2RWyTUvUxe34ZlZ/XJVSDaLUcPbY+rvgp4Id+z?=
 =?us-ascii?Q?4vN7h3Q0K/G1G3STBweSoLi0Kl4c+HacObEAymOc0PYgrw6s8j4rN7D4Hp/f?=
 =?us-ascii?Q?QB1xbvtZw2/PQn3j9UMawH4gK6EFhcd/Z/9idFocckP6sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IT1UsjhHMF19dY+1HROma/C0/v0J2W+YBkY5LN6LaF98ly8Ng1KIu+24f5ZO?=
 =?us-ascii?Q?GDejg7Z/Dj4mNSHraagLyTtrngLyn0BtCg0p1M7vWjJQLrhHGeb7EM/ndMY3?=
 =?us-ascii?Q?e7btqq1G9HrcOo4ROalXGruBv/ve0Z1ifUWAjWbMVNfo6eduA1MzK6r4fIgT?=
 =?us-ascii?Q?OsmCOngurqXh+AyuLWOW5k8EkrLo9IUKTV+DnyAvFzlFBeqoy6iasOZiNtuy?=
 =?us-ascii?Q?Km8nIjWbjV9/pYoNwRDUwcx0ZDNgEqpEpzDJ/3R2OPilWX07bMp53MJmpYXo?=
 =?us-ascii?Q?6gCx5Li7s9NninGVzpPDK5mHveyzpfYtOvwwPgsjF9Fq/gWvdrM36hPgZGqQ?=
 =?us-ascii?Q?jopPNo8W55wrnvLD4J/upN6YOouufVcmDfJJuMYLL8k3G4jRabauNlvUrFXj?=
 =?us-ascii?Q?8eLRL7s8R1txFgnahRJarcR6s0IKv/D+VcUzQcjnHS40j2sKT2o6pfl9SZvt?=
 =?us-ascii?Q?Lwyq3lc64c4QATTpSgG2DPGNRVVhE4DXOmQsXwBLZSrgm6p2Tn9KwKHsrBxe?=
 =?us-ascii?Q?PPppwgSACIGuDGKub4jWz1wdbfXGuNBbJ9XENLJihupCF91WD2nKbE9R+8th?=
 =?us-ascii?Q?86KILXPYd98RUrfS/UPVIlu4cBqZpK0wMjyPLA14qJCpU8Jdkgm4Nvg82zLM?=
 =?us-ascii?Q?CiMu6TxsyMvsr6nxgol3aVrY4pcxD1pbX/bdG9NikL5KxJ3XvERNx8PGlPXH?=
 =?us-ascii?Q?yXXKaT9SjMYf5zVGzrsavl+XEu0+0V3yWBDrfFqRhCASzJNY7LQrEutWddV7?=
 =?us-ascii?Q?GQKF5s8gWLM9rFovJfNEB3D3UY7YwdLPZNGCS6MXA47IwtlapdXUv92AkhRo?=
 =?us-ascii?Q?D6mWDYwUmS5RH1MjTXBqs3RFgMxGFopk6Oym2BYUZRiOEpjVwg2Waw43TV+H?=
 =?us-ascii?Q?aJcKiEIsZF97KWDsF5xboryMih4lh0bwAEclrDJFBFWNnNmszQ4qGbiLSezd?=
 =?us-ascii?Q?vp3/ra9eZprjcybGXXnNC60O5gXec6hcHVHHLhKVmnebFXqqjql3kZTXSagY?=
 =?us-ascii?Q?8o7vje9N2XeiXeucIo2cBb3YmpKCFenKMkJAumeaFob3x1Ksmuj3FDBAmm6M?=
 =?us-ascii?Q?Amquz7+tZioDta0lOt9Ja9sYaDk25LvWPmpQiddC3s4GpnbD9ZPa2xP6J2W9?=
 =?us-ascii?Q?XB079nJtwYZwC9MnmCJaB7c39X2DNTglvbKJUnAsoFZOazGcqTQhxod/5afS?=
 =?us-ascii?Q?Btev7AreleB3hXkl5ogHeAaUgqGv1hhFASmLTkWn/pbjI+CtVjTBrQmcLLDD?=
 =?us-ascii?Q?IzrFSDUskwXsQvjbJtdYZ4YCxt4gPRx6h52kJf8uDnoJDxYgJQXlID/jidFD?=
 =?us-ascii?Q?3kvQN1BQadjhO+xh/5cBQKUgkfkcw45zSReydxqrfS4J+guWq/9jCG3ADmxz?=
 =?us-ascii?Q?j5CaMKZH9U406tKpM/yl0COlPRj8fNn3mWP3CtRcYFjffGqrSjqv4t3dA7io?=
 =?us-ascii?Q?PGzlPRGKoKU0pLHQoRn1s2Ah3gUKbZVBN9PHpjhF/vOVGSkT9WEhZetyhC1R?=
 =?us-ascii?Q?1a0GZgfLDbJKFZUvRPL3EB6SzVm84B3s/VxEFlRSF4r7TjNUG2Dzb7cwHhrE?=
 =?us-ascii?Q?o7Fu/KdCFCwZ1FaWltxx/QClRXTuI1fvaBLvIRZ9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18576f6c-68e2-41d7-861f-08dc78fc87fd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:41:59.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDJBI44qz58m7PYizLyLi6HUc3VBRtdJTYw62XlnP4TgxjfVb5wzQkKWzD5y8XvtBMKzlkhbZ7du/uzmjaZP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9285

On Mon, May 20, 2024 at 05:49:42PM +0200, Amelie Delaunay wrote:
> Add DMA_CYCLIC capability and relative device_prep_dma_cyclic ops with
> stm32_dma3_prep_dma_cyclic(). It reuses stm32_dma3_chan_prep_hw() and
> stm32_dma3_chan_prep_hwdesc() helpers.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/dma/stm32/stm32-dma3.c | 77 ++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 134c08a7ee96..aae9fc018b1d 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1021,6 +1021,81 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
>  	return NULL;
>  }
>  
> +static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_chan *c,
> +								  dma_addr_t buf_addr,
> +								  size_t buf_len, size_t period_len,
> +								  enum dma_transfer_direction dir,
> +								  unsigned long flags)
> +{
> +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> +	struct stm32_dma3_swdesc *swdesc;
> +	dma_addr_t src, dst;
> +	u32 count, i, ctr1, ctr2;
> +	int ret;
> +
> +	if (!buf_len || !period_len || period_len > STM32_DMA3_MAX_BLOCK_SIZE) {
> +		dev_err(chan2dev(chan), "Invalid buffer/period length\n");
> +		return NULL;
> +	}
> +
> +	if (buf_len % period_len) {
> +		dev_err(chan2dev(chan), "Buffer length not multiple of period length\n");
> +		return NULL;
> +	}
> +
> +	count = buf_len / period_len;
> +	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
> +	if (!swdesc)
> +		return NULL;
> +
> +	if (dir == DMA_MEM_TO_DEV) {
> +		src = buf_addr;
> +		dst = chan->dma_config.dst_addr;
> +
> +		ret = stm32_dma3_chan_prep_hw(chan, DMA_MEM_TO_DEV, &swdesc->ccr, &ctr1, &ctr2,
> +					      src, dst, period_len);
> +	} else if (dir == DMA_DEV_TO_MEM) {
> +		src = chan->dma_config.src_addr;
> +		dst = buf_addr;
> +
> +		ret = stm32_dma3_chan_prep_hw(chan, DMA_DEV_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
> +					      src, dst, period_len);
> +	} else {
> +		dev_err(chan2dev(chan), "Invalid direction\n");
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret)
> +		goto err_desc_free;
> +
> +	for (i = 0; i < count; i++) {
> +		if (dir == DMA_MEM_TO_DEV) {
> +			src = buf_addr + i * period_len;
> +			dst = chan->dma_config.dst_addr;
> +		} else { /* (dir == DMA_DEV_TO_MEM || dir == DMA_MEM_TO_MEM) */

look like comment is wrong.

DMA_MEM_TO_MEM will return -EINVAL at previous check. 

> +			src = chan->dma_config.src_addr;
> +			dst = buf_addr + i * period_len;
> +		}
> +
> +		stm32_dma3_chan_prep_hwdesc(chan, swdesc, i, src, dst, period_len,
> +					    ctr1, ctr2, i == (count - 1), true);
> +	}
> +
> +	/* Enable Error interrupts */
> +	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
> +	/* Enable Transfer state interrupts */
> +	swdesc->ccr |= CCR_TCIE;
> +
> +	swdesc->cyclic = true;
> +
> +	return vchan_tx_prep(&chan->vchan, &swdesc->vdesc, flags);
> +
> +err_desc_free:
> +	stm32_dma3_chan_desc_free(chan, swdesc);
> +
> +	return NULL;
> +}
> +
>  static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
>  {
>  	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> @@ -1255,6 +1330,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>  
>  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>  	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
>  	dma_dev->dev = &pdev->dev;
>  	/*
>  	 * This controller supports up to 8-byte buswidth depending on the port used and the
> @@ -1277,6 +1353,7 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>  	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
>  	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
>  	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
> +	dma_dev->device_prep_dma_cyclic = stm32_dma3_prep_dma_cyclic;
>  	dma_dev->device_caps = stm32_dma3_caps;
>  	dma_dev->device_config = stm32_dma3_config;
>  	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
> -- 
> 2.25.1
> 


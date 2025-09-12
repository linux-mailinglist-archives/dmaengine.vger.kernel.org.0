Return-Path: <dmaengine+bounces-6498-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20172B5552D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACB83B06E0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0C321F57;
	Fri, 12 Sep 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3ehPoUF"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD271FCCF8;
	Fri, 12 Sep 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696291; cv=fail; b=e/6Hz9KLEb/ktjts0jXNv8qbY+dZ2Fug39AQCU/nO1OBTbbiwDYr1m8uKO6mhMjn8G6gxaZLUWeMni+7ZYmjxA/SOmNIrA7yRwc1jUar6VqpU8lIajbLhi23TDuDk7bwhNMobXXlHvVtB8+p73FOc/5rJ0F46yJmoK6CnhApilw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696291; c=relaxed/simple;
	bh=fh7us68O7az+RO6KiM+XpBaNnNStj0F6TxRJ52OCCZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CB4RPb50uhondZINLivxWcz4o0wtPuzf97Zlj6+Lds/bn1/XdXZp78YkyQNivN4SrM/f8l8pB6nGjjhm3j+hliMqVN/HZUIrFZA2V+P7N+BgaArCUjIWrpgBjH3ReLRRMkMDxYZeZmsntyTfFi/1b+b5sOpnYUh3lxo10TDYuws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g3ehPoUF; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKr3EEGOEcu4dhYBQuhFw89ZbO9XrLh9t5BMjFbAW+FCqXdpFEwaYsMOOobDjhRo//zKW+LjSFFBf318C/eq9Dzlx71G3CjY+InqsWbZTi+oFpvjHr69fLeJXFMQeQrKTH9vU9v/Wxtp9WiMcHCB1DHLqxdAurKBmhEnsTvTJx+GpFOoDtqQd0rHjHkHDaD7810fwm2cm66wIdoLfRwaaG08PNZWiFxqyZ9zMWE5dNPo4gvvIAjiXXSmWitG10BcY2bi+YSFAa/ChVbSZfVse5jLTq+50n0WPMfWJ913dHteyNgJJ+/noUVmKouV91eW/vons5pzs9xKiUwQmgadpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx9a6+IanqmBwlLFf3RJfzvwnQkgKzYeh1PH/rel6vA=;
 b=C5C2UHTnx3bwriCfhggOilKAuiBxBQwWVo5E6Egekn9LC0EKQZl/SM/1aJ8A4t5wnlZY3D84XU435vS2oDK7gfDScoOb/6RdvISAXUBPmpRdeWz3C9vwXlnTHhNULr4oVOlEnXXx0lfF2C7pFR1/jW5SQhD02IxrI929U3VlIgLfTT/wyZyUBAA4IfWW9wZWQCWuGPxYToeaz1PE6RXD7+56al58sgjglO3EUfKCnddlMgs0F56KWt3paF0wE8e23eL57HrBs7UgQrbktng2GANUiq3bhuhHY3wC9ZWve3zTPXm0VZr8LrvfLAF5nZwJs2xDg+MlgDBOXklKVxsNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx9a6+IanqmBwlLFf3RJfzvwnQkgKzYeh1PH/rel6vA=;
 b=g3ehPoUF9WaM0alxpqilbnFL4nls4FBw12bGQzgLFfYum1xNtHxMg48cjGr/BoyfmbIO3dX/5hKGUE+ijlpj51b1bITBteJqJTNJ4tCzWYSf4FoaDwyJERE+Z3X7HqC2Ap06QFKm5QysxA8MCwSa0ktXT4+mSM8DM/YnM6TaQ+Hcv4krw/5Rp0bhAAmtZlCq2drMfaBuvCQ93n+DIHckR9slbDLuWpQ9KMrtIxdwudD7+m5rYXcsBhlZzp9NIWn6oYJ9yWnhGt5h5VavIPK8xKsyaTkOydSX5nwZDYjn9i6SzSuxrxoryI3XO9ubS8RoWAGYegW0h1PWFV32oJ4wuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 16:58:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 16:58:01 +0000
Date: Fri, 12 Sep 2025 12:57:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <aMRRECxBqzRqGYwf@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
 <aMQ53pZQD4tj+GvN@lizhi-Precision-Tower-5810>
 <20250912152748.gn66fmmrqyqlqdrb@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912152748.gn66fmmrqyqlqdrb@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d0e52c-c3e8-4293-75e5-08ddf21d8881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnGTTEywQaXu4j4KV8zPkD2nKBrW9nupVobnlgJW2LLVHLaqoyzgr+izUI6b?=
 =?us-ascii?Q?PK34LspCpPj+enwnEscoSE9FiLGlln8fEOw3bvjTZffs51Vt3GhlKOd5YxTq?=
 =?us-ascii?Q?aXgz4SX0ISp8jzCQreUFAB1mH7V1eTLNS4VfVI7G0GdIA54kdn5SA6sGAVWx?=
 =?us-ascii?Q?kVA2WADjOOq6X207DFRup8gPxX5CUlfzP51RAb0lT1uzdxlE/hfih66JeFR9?=
 =?us-ascii?Q?6k9TZ8OMo4PjKLdQC2kRZTLD32OujGqy759UKJqyk+4LaDJPnburTlf8paQS?=
 =?us-ascii?Q?rvvIBuW2h0DqAV8thr6MITUyfr88mlipHMPZn3TyoexiHX4roPz2/FjNfNUh?=
 =?us-ascii?Q?hQcb6kY7QwFyVjh5uRHymZ+KsKCuu94ly25whWhlOFAk7t9zC05N9exVQO4p?=
 =?us-ascii?Q?zY+FgRsyv+Orqp9VbxxY1QNsNC4fN3JLbm6QDxTZeUKeKX8ef3L6qh2X9fxH?=
 =?us-ascii?Q?/OuJXQwbM+M5k+4d7oVn7hdKdvFTD4fuAkPaEUAT3MpDbi2iCrTwPJ1qAwuQ?=
 =?us-ascii?Q?UWoJTxBKN6EzyLZec2bd9wzFa3HDgx4QxaCGGerDhZLUavdxCE2YUlYSDOv1?=
 =?us-ascii?Q?QPQ1qELzDIG0LCw5TyrFVvvL7r6qngbAe0adg6SZzS1RxybB5dFVYsHruSNM?=
 =?us-ascii?Q?KGofjfflZEfNCtiSiJIPyq9Rgz7cTM2Sw0fFUN8sPCyD0u+MAV1qWnbUg4QZ?=
 =?us-ascii?Q?UNnYYQdl7lSgb2O5uDh11EyOtl3Xw6jh/hJZHSoZ8RaenUDxQ7YQPrfbYkK/?=
 =?us-ascii?Q?GBzFFIoec1esiozwSgyMkPaMEkTjYGVF4QkufDGTKra1UbBF35hLLoYW1Y5a?=
 =?us-ascii?Q?PqN3KUpFEtjyxyt5bv7a5S9gZksKJuvW3hdwO7Y487k2LisCoYIt8Iusz+Hk?=
 =?us-ascii?Q?6gi549KsjW6i6450lM1DNNJZyr4tchSG5CSftR2iuBDNTVBXjvUw1GXhTi6n?=
 =?us-ascii?Q?NkqSPN/d/YxqQiuUrP1DUZQsQ839b1dwVkmjECNjIS08OuLjFsCeuZ7xBV0C?=
 =?us-ascii?Q?Ky4OyA6Cqs/Ei0LCIurSAlqnPPJPNkPiMaraFfabdqlGvrgpg6MwackxPuhU?=
 =?us-ascii?Q?HkF/xaFB31ktRyKqPhy7ti2KP94rcHDCRNkGGNzlNIWOn5sUR8Zx22v8GgHj?=
 =?us-ascii?Q?53AVtVeDHvGwxtF8pYgb6OCqCdKmvS1+xognPljnCRlu1D4SLc4RLB8Tvur9?=
 =?us-ascii?Q?kSp+VvjHisGMClwT5dRmaf9zo5t/xPosPjjueOyFWqH0zUWQs8BWFf+3bTuS?=
 =?us-ascii?Q?5NAqxNOscd1tx7Yw0L/9Ibbd4HMy74vSZMDnKx5KHvEpqGB1FeTII1D+HcGb?=
 =?us-ascii?Q?x32zkuweZxVfafmURu6I6FDgh5V2NVVSg0P8MFJeEKrNT/0GZtnbeltRj5r5?=
 =?us-ascii?Q?wZiqe2/B1fDdKDpp62a1kTD0iOXUmO3qiJU45hZKzy4XmQkJgJiAN5OlgE/z?=
 =?us-ascii?Q?RG7laOlKY47tdFZeM8+ZqnnqO6/2QUWKcd2rBt+WJJjOvWC7P2HKfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAq4M+zu79a50yVFmT+TjcdIlejKasQhNWgSbjybZyUyb2Dlrw22qFM5C07H?=
 =?us-ascii?Q?0KQLQ03lnnTOFmxPMv4GOWszNNikhCs8SINFBgTJr9/qwoP9y7O+klOPv5vV?=
 =?us-ascii?Q?K5JWD9sveca+9LBA6pUazUblrzJeMROavWQBnO69pzIxsMyBCcRIO2ithEU/?=
 =?us-ascii?Q?INNcKD/DsohL03J2xdzupx2ur8fyz5CcidFxSqxKrHmU0YrlQBC+evmbb/vh?=
 =?us-ascii?Q?9/ErBx5X92I/9bGiqOsFesDKuV1ukP0Z7vJ+Kbj3JdFrSTo480fWeXL9m2V4?=
 =?us-ascii?Q?/AlKEkL7HqSbIot5qZ6QVPFipdKYcGr9otF3iPlUvXY74BkhZgAD5FWx8tSu?=
 =?us-ascii?Q?xMuBTEvY3Jj4EtF1xCp74ZxN4rvitl+SGt0BCzbQ8aqohmZLq7RYkBk53u/G?=
 =?us-ascii?Q?5Q9mVa8GrhzjrQMh86OU0qMXbNax3AVF153OacztEajeh+ixrtWJsMxu29oW?=
 =?us-ascii?Q?Qa6ubEoYc+naWXcgIuuQc9fMer/ijAS2zusCsggls8WC6IMLY1Xjh50WJTsi?=
 =?us-ascii?Q?O4udOAK6huNBfjvpNK1B/dbgaOoN11mWbPWa7GHjNEsVptDBrUPaBfmKWTLr?=
 =?us-ascii?Q?TfjqKjTUHcq3z0SVWCEE/hvVaiuGEvLIK1eXEwsSZSpfRp9wCdo/vNfJzlI4?=
 =?us-ascii?Q?KS7TYvOgVHbKz/CBm6Ci9jc9aIWDy89dIvQFcX2FWSaZd9LnmD4YVoex3gxV?=
 =?us-ascii?Q?xIX36MLja6Ky1Tduv0GY2j0SXRmgL19XRN6DVsbFWVNJaGYp9UYl77uzba2U?=
 =?us-ascii?Q?sh/vxg5B9Gim+0ERCfHQPLF0FuIIgjRWV9stSxOZztMfuDRqQLC+RTLI+P0j?=
 =?us-ascii?Q?9XHXwYFJA4tQfwDBcxYvOq41MaFf0YbG/DV6JnjwM0yfcUajC8BKQwLnyF5+?=
 =?us-ascii?Q?bRj04PX8xIw3y9Yj65gNJGfOp+Afa2VZ57CaQnNS0lTAiWc1tRhJTvOelniE?=
 =?us-ascii?Q?5WkZKSSZzagLhWSB6TEAWFViUhlhvhI+xnqObox9USiNPyjNvp2H3xneEh+p?=
 =?us-ascii?Q?fPooX9MG7FDC1LG5BnPanNfM3qanHpYtoYe6mMJyfmbtnS/JsQfPOy7UP0G6?=
 =?us-ascii?Q?FFPdRIAb2gcztXVDly3LdKRsCMeHHRnrq40Yal/UzjHzjOOR7WzKmza8bsGZ?=
 =?us-ascii?Q?lxOcr80tIycozvYn91NITge6Q9aC80Quiop1YSKKy1j9H47YCMkaTJJ8T3ky?=
 =?us-ascii?Q?trlmM/sNjVpVC++FxRAzLxto2fe7fXKZInwEefC1FmtEuxcg5RYq+S627T2b?=
 =?us-ascii?Q?ArivqucmW9hLHEJ9DNE2LTbfROqlWvPeYm2ERZXDtg1rrQ+v7mYm4NyEOzPK?=
 =?us-ascii?Q?2XVohbp4fwZ5EMr3+ghTyjBHwqZQw8s8bZvoMoZazQ26pnyF7qpieqU2RyGy?=
 =?us-ascii?Q?hBmu+BtECjr9OeXmZ5UXo/7okwGsxX9CilNPt+z2BcySGSCZYTZGHyIlWTJx?=
 =?us-ascii?Q?7G14iza6bwd7eDHPDPcRUg8nQh1bSx7F9f/r2lu02y+2HonqlFQCThjRWwFO?=
 =?us-ascii?Q?zIdMy/LyBshh7brT+jqXUoANU5po3/pRUbOCcTBl+RK2GKs3j8B+w/yLuH6R?=
 =?us-ascii?Q?4gVukp3UylW+Y8M0LZwT/ZwUEsju1e1kORPVJPhL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0e52c-c3e8-4293-75e5-08ddf21d8881
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 16:58:01.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOWHnXaUM9lmUBghyRfx2wVS+A92i0OcKHRvz/n9rhpVr/dTvcpws/GjbHy4rXwDqbaY51zT3Vqk0VJrbNeQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

On Fri, Sep 12, 2025 at 05:27:48PM +0200, Marco Felsch wrote:
> On 25-09-12, Frank Li wrote:
> > On Thu, Sep 11, 2025 at 11:56:43PM +0200, Marco Felsch wrote:
> > > Starting with i.MX8M* devices there are multiple spba-busses so we can't
> > > just search the whole DT for the first spba-bus match and take it.
> > > Instead we need to check for each device to which bus it belongs and
> > > setup the spba_{start,end}_addr accordingly per sdma_channel.
> > >
> > > While on it, don't ignore errors from of_address_to_resource() if they
> > > are valid.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> >
> > I think the below method should be better.
> >
> > of_translate_address(per_address) == OF_BAD_ADDR to check if belong spba-bus
>
> The SDMA engine doesn't have to be part of the SPBA bus, please see the
> i.MX8MM for example.

which one, can you point me?

spba_bus = of_get_parent(chan->slave->of_node);

Actaully you get dma consumers' spba-bus, not dmaengine one.

And I also confused

 +	if (sdmac->per_address2 >= sdmac->spba_start_addr &&
 +			sdmac->per_address2 <= sdmac->spba_end_addr)
  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SP;

 -	if (sdmac->per_address >= sdma->spba_start_addr &&
 -			sdmac->per_address <= sdma->spba_end_addr)
 +	if (sdmac->per_address >= sdmac->spba_start_addr &&
 +			sdmac->per_address <= sdmac->spba_end_addr)
  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;

what's purpsoe of this code, check if dma target address in spba_bus ?

And only here use spba_start_addr!

Frank

>
> Regards,
>   Marco
>
> > aips3: bus@30800000 {
> > 	...
> >         ranges = <0x30800000 0x30800000 0x400000>,
> >                  <0x8000000 0x8000000 0x10000000>;
> >
> >                         spba1: spba-bus@30800000 {
> >                                 compatible = "fsl,spba-bus", "simple-bus";
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> >                                 reg = <0x30800000 0x100000>;
> >                                 ranges;
> >
> > 				...
> > 				sdma1:
> >
> > };
> >
> > of_translate_address() will 1:1 map at spba-bus@30800000 spba1.
> > then
> > reach ranges = <0x30800000 0x30800000 0x400000> of aips3
> >
> > if per_address is not in this range, it should return OF_BAD_ADDR. So
> > needn't parse reg of bus@30800000 at all.
> >
> > Frank
> >
> > > ---
> > >  drivers/dma/imx-sdma.c | 58 ++++++++++++++++++++++++++++++++++----------------
> > >  1 file changed, 40 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index 3ecb917214b1268b148a29df697b780bc462afa4..56daaeb7df03986850c9c74273d0816700581dc0 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -429,6 +429,8 @@ struct sdma_desc {
> > >   * @event_mask:		event mask used in p_2_p script
> > >   * @watermark_level:	value for gReg[7], some script will extend it from
> > >   *			basic watermark such as p_2_p
> > > + * @spba_start_addr:	SDMA controller SPBA bus start address
> > > + * @spba_end_addr:	SDMA controller SPBA bus end address
> > >   * @shp_addr:		value for gReg[6]
> > >   * @per_addr:		value for gReg[2]
> > >   * @status:		status of dma channel
> > > @@ -461,6 +463,8 @@ struct sdma_channel {
> > >  	dma_addr_t			per_address, per_address2;
> > >  	unsigned long			event_mask[2];
> > >  	unsigned long			watermark_level;
> > > +	u32				spba_start_addr;
> > > +	u32				spba_end_addr;
> > >  	u32				shp_addr, per_addr;
> > >  	enum dma_status			status;
> > >  	struct imx_dma_data		data;
> > > @@ -534,8 +538,6 @@ struct sdma_engine {
> > >  	u32				script_number;
> > >  	struct sdma_script_start_addrs	*script_addrs;
> > >  	const struct sdma_driver_data	*drvdata;
> > > -	u32				spba_start_addr;
> > > -	u32				spba_end_addr;
> > >  	unsigned int			irq;
> > >  	dma_addr_t			bd0_phys;
> > >  	struct sdma_buffer_descriptor	*bd0;
> > > @@ -1236,8 +1238,6 @@ static void sdma_channel_synchronize(struct dma_chan *chan)
> > >
> > >  static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
> > >  {
> > > -	struct sdma_engine *sdma = sdmac->sdma;
> > > -
> > >  	int lwml = sdmac->watermark_level & SDMA_WATERMARK_LEVEL_LWML;
> > >  	int hwml = (sdmac->watermark_level & SDMA_WATERMARK_LEVEL_HWML) >> 16;
> > >
> > > @@ -1263,12 +1263,12 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
> > >  		swap(sdmac->event_mask[0], sdmac->event_mask[1]);
> > >  	}
> > >
> > > -	if (sdmac->per_address2 >= sdma->spba_start_addr &&
> > > -			sdmac->per_address2 <= sdma->spba_end_addr)
> > > +	if (sdmac->per_address2 >= sdmac->spba_start_addr &&
> > > +			sdmac->per_address2 <= sdmac->spba_end_addr)
> > >  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SP;
> > >
> > > -	if (sdmac->per_address >= sdma->spba_start_addr &&
> > > -			sdmac->per_address <= sdma->spba_end_addr)
> > > +	if (sdmac->per_address >= sdmac->spba_start_addr &&
> > > +			sdmac->per_address <= sdmac->spba_end_addr)
> > >  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
> > >
> > >  	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
> > > @@ -1447,6 +1447,31 @@ static void sdma_desc_free(struct virt_dma_desc *vd)
> > >  	kfree(desc);
> > >  }
> > >
> > > +static int sdma_config_spba_slave(struct dma_chan *chan)
> > > +{
> > > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > +	struct device_node *spba_bus;
> > > +	struct resource spba_res;
> > > +	int ret;
> > > +
> > > +	spba_bus = of_get_parent(chan->slave->of_node);
> > > +	/* Device doesn't belong to the spba-bus */
> > > +	if (!of_device_is_compatible(spba_bus, "fsl,spba-bus"))
> > > +		return 0;
> > > +
> > > +	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> > > +	of_node_put(spba_bus);
> > > +	if (ret) {
> > > +		dev_err(sdmac->sdma->dev, "Failed to get spba-bus resources\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	sdmac->spba_start_addr = spba_res.start;
> > > +	sdmac->spba_end_addr = spba_res.end;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int sdma_alloc_chan_resources(struct dma_chan *chan)
> > >  {
> > >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > > @@ -1527,6 +1552,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
> > >
> > >  	sdmac->event_id0 = 0;
> > >  	sdmac->event_id1 = 0;
> > > +	sdmac->spba_start_addr = 0;
> > > +	sdmac->spba_end_addr = 0;
> > >
> > >  	sdma_set_channel_priority(sdmac, 0);
> > >
> > > @@ -1837,6 +1864,7 @@ static int sdma_config(struct dma_chan *chan,
> > >  {
> > >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > >  	struct sdma_engine *sdma = sdmac->sdma;
> > > +	int ret;
> > >
> > >  	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
> > >
> > > @@ -1867,6 +1895,10 @@ static int sdma_config(struct dma_chan *chan,
> > >  		sdma_event_enable(sdmac, sdmac->event_id1);
> > >  	}
> > >
> > > +	ret = sdma_config_spba_slave(chan);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -2235,11 +2267,9 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> > >  static int sdma_probe(struct platform_device *pdev)
> > >  {
> > >  	struct device_node *np = pdev->dev.of_node;
> > > -	struct device_node *spba_bus;
> > >  	const char *fw_name;
> > >  	int ret;
> > >  	int irq;
> > > -	struct resource spba_res;
> > >  	int i;
> > >  	struct sdma_engine *sdma;
> > >  	s32 *saddr_arr;
> > > @@ -2375,14 +2405,6 @@ static int sdma_probe(struct platform_device *pdev)
> > >  			dev_err(&pdev->dev, "failed to register controller\n");
> > >  			goto err_register;
> > >  		}
> > > -
> > > -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> > > -		ret = of_address_to_resource(spba_bus, 0, &spba_res);
> > > -		if (!ret) {
> > > -			sdma->spba_start_addr = spba_res.start;
> > > -			sdma->spba_end_addr = spba_res.end;
> > > -		}
> > > -		of_node_put(spba_bus);
> > >  	}
> > >
> > >  	/*
> > >
> > > --
> > > 2.47.3
> > >
> >


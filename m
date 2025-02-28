Return-Path: <dmaengine+bounces-4621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0CA4A39E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 21:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D619C249A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3C82517B7;
	Fri, 28 Feb 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/8VE9lh"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7622517B3;
	Fri, 28 Feb 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773041; cv=fail; b=R2J0Q3CzTmCbeGkc33U9bWeCOWd+pejDVVj1HWmj1os1NHOmB2VqOp6ILtzey2HiRPiMy7NI0KXKfjvvZYRAJjqLX4rzmlKCzssAlD0kzoS0lMjkxsZ0T1mtwG/1iJpK0svs8QGKjk3GwU77dXrumjqZ6Xm9HzEkTbKlp/2ktoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773041; c=relaxed/simple;
	bh=iYKuM7edjTQ8ty24muLZhy2zh00Y468a7qVwF6oZO9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A34R0bQiMqVj5CWyU8YChskgxid9hCKkxT5tL3ixhgMwHVuTJKRtWq6uOhQTarn2iNFmMWg9Ixpcbm3fvWJ9CUFw6+CnYfo1b2xxylLIbRSctNUC6fiTjxVFt6TyauVQzj8AxFHYoe8cfXFVlHnFXCiTefVbnK/OG1+wiGtMfs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/8VE9lh; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9ll7RUVF+k6Pi6DXAuFVI4RzCIQlHZ+xydGEOzsP3gmU18hb2wzp/NtdS5RneLfyEO7NfVIfzL6FNpYq7pnl1muQ9/eS08JlBTBbkmz2RSjT5gyiavln3+Xe38ZP8T/47yPENSOIJ4dnRA+rrTECQGHRyg5BxoCbPePM9Tqxd5GN/F394tpnIJx04qHD9gEkJrNrN2Uk/jTv57LRVjhu7s+zgaN7jPeCwqHYmPyuiGuGRuNXBDHFKhefVB9pnZpmsGhGbkAPDYoMo+SZ1axtMmDuXRlg2WLsPp3oQyUvMaKFX/E8eURPKKKq0P+GWzaLlHhaKZ61Hr9A0LvFjpH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/BRI/bKZqbeAB7Y4NuuTyl4uG4VITzDebuAN8g909s=;
 b=sKQDFQGBLWk3ByV8ZKg29N81dRRDkG/20Qst7JPSgUYErDBviXs9y8gDc7dB8uowRLMNt7pPJfxlA6hF3LlQAqxNpca4JuPjrHYHlNXYjDNBxJkUbtd9bJGA51g6UoZ/7UsKFzG343Zb/tnA25hMwS3dZULsTbSjclXgYdHziBrP2drRSsfw/2YbG/JxghL2tbE/raAZhYAzOrS/sihgx3Jo8KLQQP+2YJ8LPC3/rXJcrgW8zVXuSWB3KbqKjb52vA6ORCAgSGCBnFl4tqZ7BpXwuDxClGqRxZ6hbsnMA/1dkzp1qn7vkNp6QKo7lcYzvtxeKoeosGpW9Zw0kWPaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/BRI/bKZqbeAB7Y4NuuTyl4uG4VITzDebuAN8g909s=;
 b=i/8VE9lhM8kOlp+WL42CD5xp8GamCz/lFU5gCwiuYhcQirSymOuoZS/uE19VouVX2TAUXTX5lAgsjsqqhNcjQ+mr47frTEC0yTm0CD8mBVcOoCc96q+4BNqwbWZDzLKjyCskplbuLBDN7kNXMrOhvIp2/YWa68nf4vMNKwdIgiecGOaguOnoISDDWw/1PmX8aWFMNOGN1rK8F+1aYuHd0sbnU9GgUyMkLsE2AswBpvJ41BVTtAaPoyjTFmbC8B1RI/e8cl4pqEvgtlYxwvrJRUSsAFqmuADnOK+y21K5mZTBHExrnlVMfenmUJ1qk170eWz7CaJExsuOymKp5VE0cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 20:03:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 20:03:56 +0000
Date: Fri, 28 Feb 2025 15:03:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Message-ID: <Z8IWo2ssQEKHlujy@lizhi-Precision-Tower-5810>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
 <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>
 <20250228-frown-caretaker-4e3e3f2533e9@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-frown-caretaker-4e3e3f2533e9@spud>
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0538e015-9cb7-49b8-9cd5-08dd58330826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SeFVJy48UqYHb0cB4iU/2n09H/mfCN2gy/2dQeMjSWT2Jyipa2pkF4sC4fNI?=
 =?us-ascii?Q?4num8NH6XfS8vHy/KMOyRkHjZ094PLmIurDVfJRZbmuKR5yCYjiZnoP1yoZK?=
 =?us-ascii?Q?hJ6yf1DLCpFEgh7Bb4Y3/A9efuoA1bayUoZuKCTPvMmmWfCElrzV56xuGH/E?=
 =?us-ascii?Q?SHW1TNKHMv5nnBENQX6/B8ggYnRNlBbfs1SQua7eexSrhkGp5uI5vw7CBdNA?=
 =?us-ascii?Q?c0QwpQbAm6X9fk4To6IDoiZhOfIqJD12faPHNGv9tMmPBU0k7ht8OpM6Ux9N?=
 =?us-ascii?Q?cio+VrApXDc2IsbMLngKAvIPGcVTw58M3Y5I6yGiw92XY2IJfPStSlyw+h9D?=
 =?us-ascii?Q?rluJ6TvQrCdoFVum6gY2S0qV/yoNKG4TpSWEbEdzXLb0v/YLcDCK0G+laXQg?=
 =?us-ascii?Q?m02xR9LwWbsy2sHplOXELbw0TbkZAxGZ/GFi8Kjn3Z6myeKAd3DtYNropGi+?=
 =?us-ascii?Q?DaOSTt1erNCLeILyYeR0Rxgyu31tUfmeTdJyldfQMN2ui8d5IcxkO64eyeCR?=
 =?us-ascii?Q?oILdJ2qFc+2DJ0Y5BcPrJuGIpF8jJzWMn83k9lpMTI0XczFHQ1JZtDWVpOQ6?=
 =?us-ascii?Q?jafw9JvYnZakAM0+vLOQ1FQeIlpJITIT2BXioukUPVuVRd/48Xq7fiLmK0l9?=
 =?us-ascii?Q?kvYv8g1KJ+pMUPoQ4F1EkYUsg12BkVepL6JwL+IC+Nb+/dDuGJEiD0kpllmL?=
 =?us-ascii?Q?k2vwBGNP8/0s2xcO0aEcv10B7VrIT0vzOYdM4Pgkk2xDUl9t1x+DF4vIYTGe?=
 =?us-ascii?Q?07wK1Bzra4H5NPiOWTP1BGdtq3TvV+S2cU+5FMDAAvOScjhpanP0W9Wy5qpW?=
 =?us-ascii?Q?WQbLHAxPgMc8YDPQpVGkel/EJw61QMpaqEUuZaqFmWff2ozx5U3h92HIhHs5?=
 =?us-ascii?Q?AQ7fjIAmVsgxGwg9ZVB9rL3y8+IG1zKF4pQvdBYJF4+r3nTZrGvOtBVc3E4R?=
 =?us-ascii?Q?VjVXD7v1t5IKzL3/dU0j3zsdnz2R5qU6gzIzXnQJa0U8dOp4y4UY3YKKi/J3?=
 =?us-ascii?Q?Vrbp4fGNrN0EtQn6okNHRkGvJzEFhD8VTjwgvyD3kas198b9qxJyiWXN9Bru?=
 =?us-ascii?Q?yu3PQyNsystP75OwrtVljIhQDFAzd5fdQB3UAW3ZssdytC6pDlVD6NvIrsjn?=
 =?us-ascii?Q?mqhJtVB72NeFZqUoaeDH61gonXLS8JV9rL1GaF0YHPjIu3Afl56ewxS5Bd7m?=
 =?us-ascii?Q?VKyD6sLJR/SdB8Gi8MxAZ8X+R47tuOASXicrG8cAYdmx5PJdNcENDpuWQfHF?=
 =?us-ascii?Q?ddZ3rJKQvkrX5OcQM9D/z5cv6Oa16w/hbjArJXUuJ9qzQjm2QkRPseCm481D?=
 =?us-ascii?Q?+eSyqsbT066SImW8nWCj6aEwfZzcmZ/gVvsOOs3vzxl3lU/rml/p/+OAx1RW?=
 =?us-ascii?Q?6sxHMKbCGv+AylurRHotKoN37A1Q0XcMyLeDXuCxhHUtKIOxAe7f4usYVagh?=
 =?us-ascii?Q?8t2lzAHXTFgZqWA3LVZkggU8xRs4gnLc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZG3965GaW9dRnDv6l90yCdq82dO5NVfUmxsMBpYe54dmWnJh/wYbAFqWSPA?=
 =?us-ascii?Q?gSjdB3u2cfZPW9c9aAVQE6fqBQHN4Tn1u5HsDc38R7XApzQRBf//HpYjIHP+?=
 =?us-ascii?Q?fV0MS9OjQJOdLumFg23T1oWS75EIl9q50MQtV2SDPlZYQ/CKb7/vWKK5kA3h?=
 =?us-ascii?Q?8E79ILGTyQF3ZFvGFy4I+zwIut/viMZN6v5YP3gDe2ByqAGokXRjIpVnyi3B?=
 =?us-ascii?Q?8TJsjD0v9bOSMMd/AZ69UO1vFeQyXQFUSyCq3jUX1Spg+a/E4s7Ui449tSSq?=
 =?us-ascii?Q?jQpb3WHiTAIoRTnuJCsNpuHwwCYcbGZ2da9ndpvXKwqgF7s9GsX0OJiozLlC?=
 =?us-ascii?Q?FXqLhjcaEtezb/YfzsBH0cOqFk1OP1aYJs+oKuXIkf7g6/DUgnoc1Vy1xMo1?=
 =?us-ascii?Q?0cyCrm/Ar32ui72dx0RG2/78EC6oBKoMmEjsFG1Dy0p/xxYFiZXgkxMd/G9w?=
 =?us-ascii?Q?PQwADs19+smVXyLZ7VVXPKk0qhs6g3r0KTpp8GqlmXwDhxUCYmtddw0ejh4d?=
 =?us-ascii?Q?yInjplwxhDkI9Ctp3kSm8VtB+7DPEibsz0n/crpR4hKmGMpVEdaoJAMd59w5?=
 =?us-ascii?Q?V2/eHCwfj1KsO0yEwucLc4JWyB6b1T2rmNyvCcpySm4koH90urCvC3MvlgUb?=
 =?us-ascii?Q?Y0fhSMxJpa3FHFXditwCCCe149kGAPGcBrTAsZyVseIfohhBpKMZ5ISBdlMR?=
 =?us-ascii?Q?Bo6nixWmboDklo3BRLjGzcYpCuqSnjBHWvHjy312CRfR0lbQzxXSZryqI/wl?=
 =?us-ascii?Q?eYi9ysqKcyoxROnO75mYHeVvsDnCB3yHTanRu3sw8hfFJtTDF60+nxT8dK/V?=
 =?us-ascii?Q?c553Dxz44D+r62C3Gxs0SUkGJHdButG5+eviX0gQOISatAq9QGAXPLYc895t?=
 =?us-ascii?Q?JbtplvquUuzxnnohPXtJDN6OtEryj8GjoPdh5p1i3+NSx3T9n0oeJ1Ky11xr?=
 =?us-ascii?Q?jBwqDoj8/cSQt13s/IAqs12XFDepA3xQLKFmcuUlQxqLN8Mdjx6j4s8QphGv?=
 =?us-ascii?Q?WxNsBfntDKXu/hYqeyWyDHmPcMuAGiqcD3mX0cFPh+PKteT5FxmHX1uyWWbS?=
 =?us-ascii?Q?VqzwsdbhUaLvMnuQtgoQx3jaC4eugqLlMF+U2wRCWtYzw1vSd1tOOTcaaWTZ?=
 =?us-ascii?Q?olBlHo66I+9iYzcnHr7imuBYssNbASiHO/T/GdB/9SIfq9Ua+gdzL3lqGVtO?=
 =?us-ascii?Q?dX6r0trYsbQMtKgU8I9hO/UyxmnghfAI/M2v388HWw8kjWlBsl+4GAllQdoO?=
 =?us-ascii?Q?f6K9knijsfjMO6SXtWhvA3AjtaE3SA1iD+hKCrDGYx/oUsbh5T5AO0ZLS8ri?=
 =?us-ascii?Q?QPqeMeurLe+nd8Xn7kkgkk6CiEN5x0dnT5MNx41hPSKyFpM0oebPql1MNOsM?=
 =?us-ascii?Q?aIIWdZkzm8v69izf7Wc9ZXHjxdkGQC9cmifodGDAZoD+GCwr4l6wjTrTYHjA?=
 =?us-ascii?Q?DNwafcPH6nms/pFFeYONdZsRjfDvVnxOHt5MPUVQK+yS3qrZ9yDXneF9wep8?=
 =?us-ascii?Q?LSnmUg2/CgmY6Guq0rh7aEWn7AMolfvI0LMWThW7SX0DbRHPw9YdOcvAdvi/?=
 =?us-ascii?Q?ouYGfrbT4SQCdGVsrVU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0538e015-9cb7-49b8-9cd5-08dd58330826
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 20:03:56.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgo1nGj6ehJkw6iBPHM08XhHdZXsuAJDsLF2LglBfbGuIYFAkoGThOTd1zarv/cTLm6+Yh/3dvXXqjkfwjZDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

On Fri, Feb 28, 2025 at 06:13:50PM +0000, Conor Dooley wrote:
> On Fri, Feb 28, 2025 at 12:42:03PM -0500, Frank Li wrote:
> > From: Joy Zou <joy.zou@nxp.com>
> >
> > The edma controller support optional error interrupt, so update interrupts
> > and interrupt-names's maxItems.
>
> This seems like something were you would know based on the soc (or
> compatible) whether or not 64 or 65 is the correct maximum for that
> device?

Not exactly, 64 channel is maxium value, which IP supportted. There are
difference instances in the same SOC. Some may only 31 dma channel, some
may only 12, some have 64. Each channel have one irqs and one shared err
irq.

Ideally it should be property 'dma-channels' + 1. But not sure if schema
can check such case.

Frank

>
> >
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index 4f925469533e7..900170b3606ef 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -40,11 +40,11 @@ properties:
> >
> >    interrupts:
> >      minItems: 1
> > -    maxItems: 64
> > +    maxItems: 65
> >
> >    interrupt-names:
> >      minItems: 1
> > -    maxItems: 64
> > +    maxItems: 65
> >
> >    "#dma-cells":
> >      description: |
> >
> > --
> > 2.34.1
> >




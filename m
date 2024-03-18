Return-Path: <dmaengine+bounces-1413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1987E4F5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 09:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03F01C20DF4
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFD22086;
	Mon, 18 Mar 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AQ+gSPyI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2039.outbound.protection.outlook.com [40.92.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EF17BDC;
	Mon, 18 Mar 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750616; cv=fail; b=U8jNWfy2988PC5+pEJ41WNWVEME5GuLtf9z2NxaWmuOCedUY8R2CLRnWAiQQTVHFuwMYCPIbextKipEk37ZDAXF8jB9FJef37dUI36UcwXAkjfp4PbrhzAwX7a7s4+JRZN1HVjn8ra1Gfec1k7TGYSfrVSKrGofW7Y4XO8T3cQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750616; c=relaxed/simple;
	bh=QjIb0vIXk19HcDKJ6cFFJjhODgu4qs8InZE60hkGN6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hjLmMMnjONIUYcZuqK7/2hQiBGS93BJhagb8164TbK5KcUbiTNokQBhAiyEC4fJ1xXZJUBdyOQ7a0Z9CmUAwEKT3H/Z0Y+bmOzM+HpO758ma8CN4X1E2ehlo+S6zZz5CM+FOX7FVuFFwnSR/H/21wR9mTsx7MYqu+RtasRG9pes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AQ+gSPyI; arc=fail smtp.client-ip=40.92.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXMld717AfOdv1RD6H8hQGMqCDOgp22y4NF8w/oMZwJkTEbov4UGwZQUtThMrnXGIzaZElN4W74+XJjek3+O8sdJvvIvUUmNBoAr+PPcoUv1lLJw4WSbrk8x4uS7ZEA4liO7kedNKAS0jnKzbTunfVPyVQnMorBQ92Bb2ffX5EqGbaPF/fkj6X/JocRumNNH0roXp5p8S4MQoFKDSlTTWbgx3jT2TXqXV3vy8f+CRfZNxdjU7zcNHXVNDmlwP2iJw1ZuOAhEfxV0GGHkUaO/EX5D9NQEW08ERCP0yVlpEnEwi+rZdWNdNuM2PiL0PTudVgrxXwgdag143S5KjKf1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSuQbLzG9bDftGjx39pS6oDQgXJE9kXmlegv4Jg+rC8=;
 b=djKfmvpqo7PunnCoUhnHp9jJOAhqXw71Z4NuewfK2TY3AURdNJQjXrze2Y+xTjyeWm4ptG9CQCv93dEMxPcP0evpqcSE3nFmxk3H/uClj/xDMS9cVqBeFJjrAriu4jZAAoF0pETVQv3B/z1T55FjGcbWPw8UrypxI28zxF90A2gXbZ0dtIArqq2VhQ+yS8OoVEP5TqGVXGHDwEIfA2NrW+2D0t4Us2ZU7WvRWg4D7Q49pKTkw5fTdjOS4ckkvlNCpGnmnYb20KFhfeHrsM+eoizucvW0aNxGbG+LeK4EW9Q8joxTFDS19OA4xMpqcLvBG+UxmHq9mJFpUKrKnr+jZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSuQbLzG9bDftGjx39pS6oDQgXJE9kXmlegv4Jg+rC8=;
 b=AQ+gSPyI6yKyuw0obPKyrXtNLHWgXchRbTb6GX72ungEX3/G7CWRXDxFTzQsB8cOf2FEjIR91aePxYjTBmvxzNF3a1TF1JawWjHbzksnPQA7CfRhgshSNS94MTY1O5x9S3rJFePU55w2YXITNlnpqCBRtL1waZGIrrSZOxyCI9l6TldyEJ81RlFGcUP2ldhOCrDxDtRg7a209vu0RrgA+wxKjXd80Wcky7XLIFg3lzw4kT2BbAExn9TCdf4dIpXY+9eF2hgZl26OyBoSm7tAJ4PO6ixXFOe+YAA1eOydTYHH118Fs//U87I3M7OEdSNO9IIWSd5khU1cjryOQkDbgg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4414.namprd20.prod.outlook.com (2603:10b6:510:13e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:30:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:30:11 +0000
Date: Mon, 18 Mar 2024 16:30:08 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB49537B387D0BC4052AE90812BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <6da5b070-e61a-4526-833f-1af1bde988e1@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da5b070-e61a-4526-833f-1af1bde988e1@linaro.org>
X-TMN: [gKgNG1xWPl6k7tXVpsh6Ffu+39GkPX/qUKVVlYXwWIk=]
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ywjjghvaf4aneseugcexuxa4jgk6tzxusu6xxqzzvdlw3mhxsh@y3wn66g4plne>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a244c67-0d8e-4f4d-b80c-08dc4725a048
X-MS-Exchange-SLBlob-MailProps:
	98ioH9+sI7/gmAhNpKNDewo8ixzCPKFKzAcTTNcY3NEai2pI/9F/0ZsiafqN8hxuwU2pKZa2/mroRgWg56zoRrVzcs3vGxp1IFp3Op1SrNzk/Nr+Zvr/29vO3aLJin1X3Kixg4if1Z1yY4oEtIm2HRLhUW3HbiErebT5o8muWaFfDYRO0sZnYyWoxnKqk1J6R2EcLjg7JumZuQNZiNHmis1ZWmYuDD7rvDZ6HygBMTs1SaFoXUtQ3k5xiXFOhKngLxKz/v0xHi3zFr6dwOjLtxeL6JAo43esSEuHVYqwNuC4+DTJnPhM4ge9nyd3XwzcUZkh7ucZlaeE09P4brApScki6/x1QgD3j19QL5XG+s3/Xgrp3VHl4PWAiTWf7SXU5QVZwmImcdbEI2TePos18a5YTHva8r1QqpNRLsCWT2XTHs9pOkVgYaZLLFfrpI3SLFpr208lLdm4gM70NbifuOsNijVJb6WHxpKb7y0GKYGaHus2nMgZ7Y9OMp3++9O83CbEUDPTQ2/5YZmuUOPG7Z42nZksp7cKvD6rBHUkQuY6PdFZIa9B9uY2b9s+7UwNu28COU1JPsOHN95JxyW6fGdB6Jpm4puDBmRSIl+RUypMcaCDfFzAyW8PZefoUPFMOeAfXuKhNCGRdgDmfXeRFlNybXZb0LWKyIxZbzZdOHNBwWUD2QJPyMqFaFpQ0CSY1EZvQ6tzxczgu2qbb+DDIS9gUxAmfMlOlLRQs5kBKIDDVmQ8h2cmVqzlwlG1jE/TJd6NbkR0RqhfevKu+uAegY/iGFmQQu6CW5cMzVzR3J6B8yUgCPTFsmVcfmglNe2HQrShWR9nxFccqd1xE32eoho5helQ3+74vMtUjgJVKjLpvsCGNVCkoQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XiiWzd1UBsklzW9MsaadkaRUaj1vpO+NhRgCdkFI25j+YAjW9Odascnpii9OH7PpVNeyYv9bYzRbLbzvRKxtH3Lp8yQrpkCzHG8XpFB97Qnm+YVwM+mcKKesp2MTkv2gIFqi18B/l5MA6y7ruzotz/LBvFhMkKtz4Qkx0NyTvOmkZcSpE2qJPhm4xKfZNOonaxsZHG7XlquZK32X1yGfQRKpOGQ3eaEKn907PHY69+6pk4BXCm2OUgLu4pTGCpATU4TES/TmX13KTFZOAGBKRfLXEqgOjC7NMYRkZfLAcDwiEmSg4J2oYU7Q117u5FmZgb6omM3zm9bOTDYeiSXtjhTQonb3pzTPHtTCiC1NJ1+mRAoqq33OGjGcPe2pRxYSRgngGGCFH0EmwqUchqdYwsufLfS13OFA5+f6BeqJvKVop6BxKXetsa/iPvDOdzXoqzIKw1Z1dREvy6PG2+5mDloAjXAhMmpcJ8ZvRkoLcf+D3/qQgowMYUvIEmBiGEMNCsPITYpEM+x/uPk0mf743PiECmNc5rErTovv+9hBc+G5si3VWJTvO1UuaWNvbV/y62eXkc0V9lfrsyisLvQJicx0InpElghwKSLbMukyvuK8DTwvFwecnywlK+DTNBlN0rBzTe9aYgWC0ACcMLs/mhL+SKwfzZATh8u+wh401SV6IIhmgoCAxasn0n8CVfwMXhOOj6LGjis+t9kYkNrtZQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wu5o0JZrTZmcbDSpwx5Ba17aql3dHXOj/KSi3WHCynqxa5IWSnuJKleiq7nI?=
 =?us-ascii?Q?brLJhANqEOd+PKbYRl7nxwaW62vVZPo/fTEQXmJw08jjdi+Z4V1SaU/uVeCt?=
 =?us-ascii?Q?WIeqILjyO3baac7cP9wbwSe35uKJoDEHokmY3WuTl36LTE9xmFQDZdUXiIlq?=
 =?us-ascii?Q?OQkLHAuQ+SH64G/ug0U4i0ZXfbFpAQIGdF3V06t1AvZvz5WlvxG0+JmFE6fj?=
 =?us-ascii?Q?hcSvuA2zpfTsIUqzizbxpqrfODA/NIsLNis2phdb9DDNNF2OcUtN5F3vvTQo?=
 =?us-ascii?Q?GmGXf26E8IfwP3QRYEijmuclxvsGgTyG8Abw5g4auIpkufhuPATo3GZRmHTP?=
 =?us-ascii?Q?cobFd+0umZ0LtV25CSvamQM3tKCTmqfLLhWQs0w40i/VhGBYeJKnWiInt03Z?=
 =?us-ascii?Q?a0OjSWJY8Zrk1wpX1gTqkzEueR9Cwwa+FgDx+A3ZxCIffdNlTolqWhtV8KQO?=
 =?us-ascii?Q?Wav4Ln/B4aO8suMc6VNt0ohacIVcZdikR/6gBGRFsD5FpevC/W3PH+pcmtRC?=
 =?us-ascii?Q?vbLh2FLQFaRoMFfZw/a04UQ7srLElXNcWEhAL31Az+Q+BLPNBjqUN2tM3Z17?=
 =?us-ascii?Q?XZI1khc+0XFQSAYeBXMFUyaxUsEM+9W5Fl0dZb1wXlsAceRtt7+fgvqC4xqj?=
 =?us-ascii?Q?xEnKLMjEELK+ni+AJueb66rd74LIu/z5VPw5ditj9+Oo8iaSx6HRSxX5lmgX?=
 =?us-ascii?Q?YPzi0UlepclzswahleHMrYxEMJ+gpV6N2+oCjAbTY+7O7XDoFHUmQPYTldML?=
 =?us-ascii?Q?uk//U3ZY18BFQbtxNDtiq5PO7JmSOub94HfwVpSPMUyRuiun//gDv50KkgPM?=
 =?us-ascii?Q?IOqq+ZfYdQqQyG+GuvcaQQw8BwwSc4RrWlMCGOjLZhUU2pVc725KB+K4P3hV?=
 =?us-ascii?Q?hMz3mXaDAHDtd9Egvi9qxeVCcu6kgIyTIE7nSzSWPVdVS/VYVmcLMf5BVsku?=
 =?us-ascii?Q?oPqM1UDFF0tktv6/6G+Sl1HgEQ9M61tVtMuZyLlD+L8aO5+ogqnYrJAfnQQP?=
 =?us-ascii?Q?2O3YcvRkMJkYRXLxf6Xy9RI7sz54qt3b+kgoq2FeFJJHoSFVWKTflOtZZI6l?=
 =?us-ascii?Q?n5EowHOQSu09YV/Grko0xnWKm3ByDu1N7nJ9hKcuFKwQW0yNTNPiBiaqtn3M?=
 =?us-ascii?Q?lL5TIUnliZDtD/5vbgBfOG2v3o1AqdoPFJCEXUGW4LfmpYqaKzNl/fPkMqUe?=
 =?us-ascii?Q?bpRG55NIs0Fr03bUAhKaZIPTeSBcHvtaQZD0nuXuSCkmiGs4MmDtVI8wkG6U?=
 =?us-ascii?Q?KNGrFpEgBe+FkxuN7c9y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a244c67-0d8e-4f4d-b80c-08dc4725a048
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 08:30:10.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4414

On Mon, Mar 18, 2024 at 09:09:45AM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2024 07:38, Inochi Amaoto wrote:
> > The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> > an additional channel remap register located in the top system control
> > area. The DMA channel is exclusive to each core.
> > 
> > Add the dmamux binding for CV18XX/SG200X series SoC
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 47 ++++++++++++++++
> >  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
> >  2 files changed, 102 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> >  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > new file mode 100644
> > index 000000000000..c813c66737ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800/SG200 Series DMA mux
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +allOf:
> > +  - $ref: dma-router.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800-dmamux
> > +
> > +  reg:
> > +    maxItems: 2
> 
> You need to describe the items.
> 

I wonder whether reg-name should be introduced, or item description is
just enough?

> > +
> > +  '#dma-cells':
> > +    const: 3
> > +    description:
> > +      The first cells is DMA channel. The second one is device id.
> > +      The third one is the cpu id.
> > +
> > +  dma-masters:
> > +    maxItems: 1
> > +
> > +  dma-requests:
> > +    const: 8
> > +
> > +required:
> > +  - '#dma-cells'
> 
> reg is not required? How do you perform any IO?

This device is part of the syscon. The IO is performed by the offset.
In the v2, Rob suggest me add the "reg" property to describe registers.
He also mentioned that driver may not use this info, so I do not make
this a must.

> 
> > +  - dma-masters
> > +
> 
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


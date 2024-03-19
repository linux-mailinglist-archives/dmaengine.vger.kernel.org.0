Return-Path: <dmaengine+bounces-1442-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA987F6BE
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 06:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B9C1F221AF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FFC4438A;
	Tue, 19 Mar 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bsLd++f1"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2069.outbound.protection.outlook.com [40.92.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3244365;
	Tue, 19 Mar 2024 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826392; cv=fail; b=OkmASgMcl0WWnkVfYKO+Pf2m4gnkUULIz/zuL8qSARKUZQUgF/DeZC51Pgm6dIAGJWRYsjN0vBG2OD8LmO9DsS9DKWNt8W0FTjml0zHZqXWgzRZMn3hnK+r9NtL973TgR31Mwp7BrgI5jkoP6TI9VmgLqyTHSTlvGxGILMzsxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826392; c=relaxed/simple;
	bh=MCn2YOyPXKn3JxJZTxVhIkh2xqRHCqoVYDYaTykyzCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFH1vSk1jxl3sLekNxtfjmiRhzpPFEO/6hY0zEM3kfMnhQUHbDoANhbvyEMZ26TNRu3s6MP00+bzjW6aIx0vcdCefcQXB5KxgOzG4rbaXxFRzEqtzByQai38BQhoKLzcVktDAfuSbwWn+kH3xmD9JhQdvuJyVfUrjLpYR9Igp80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bsLd++f1; arc=fail smtp.client-ip=40.92.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzaFh13L0B7dLrqv8n5qf25qTOSDju4LTCagaT8IRpgU3gzO24bEKY7YegMkOHyt5+dNOYLWArkgvYZTH+3ezLV3HUp7Bp3R65Yo+nRV9YKNN+G7csnMyURagmnNyp5N/sCzXjwJTYSuq4kqaRmJOnNFv+18KzD0zJV9bDLPhv4UJcbNNhvRTnzDRfvbqrCrB4IdH+UrswDCHLrLBgvbNlsvf1Vwsq2yEy4T9R9KYuJSpPYMCQDecq0X8Lv6k9e0/Gcqm64AkEvHq7ktw7AlHpiJVUVpQKr9GWW7pPMUFC7N5bg4M0zMPFBIzQQlqs+SEwpYMQ5Lvejcnj0xOqxm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pzSXMvMxmDREZqw9DAgybS1ThNkia+PvrD/hiD34xE=;
 b=mje42qsRBRNtnavC1Hn8xPVUiTSHU2WkeoQmyBMxWE3fGr+hC6IINDZRW60N2YQYBnjVGtBxN+Qtj4zg6E58hsSXZjyAk13CeyiQuk1Yn3RTq6BLy9s0ATssWedqIWL/YJ9nyuzbtTUKvL2X1yE/kujSSAWld8TPITkobTwOhqjK6EAluxjxG/pjr8N8SSmUGPbW82IEtm4REnCXTyLO8HPDkvmU3wj6EmeKyI9VpYPYo0BhgP06U3o5rN+ga7sGfd1d6HEOmakadOC7b/9wn3YxQ3AqanbAuYdxBdWVBYF6QF6SMcAf7LwJuhD7vlU2SUvSmyAwjHWn8vgeEQdiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pzSXMvMxmDREZqw9DAgybS1ThNkia+PvrD/hiD34xE=;
 b=bsLd++f1P572R1ww3aDlTxfxEgZYearFwB5IJ7pIi9cT7+vHe3ta6irpzdKe2NdtNgc+L2p2zFDNZyQL8ws/qgAt1L/p74uNv/bkyuBBV+APCGhm5Uyd9oSdaAWb2U7E5907wXWLTieEF3F2wtroy9SWgRiijY6npPeTXanHV3u4Y/CZel3d0QEbKPoE0yxej3bc3z/6yWSQ3G607L7QwfuPZKcxoCxnxyw0lvvzwkxI2vCy4bJhZiHIsGlkawuuC+wedjirqZYYjMxHMjuG8o6AkO5WNgN4JLEJUi+1lDflGkYbCAg2Ve3GdkTIZ+ggqjTGSsP8dMqxY2ISZ6aThA==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by SJ2PR20MB6973.namprd20.prod.outlook.com (2603:10b6:a03:569::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 05:33:07 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 05:33:07 +0000
Date: Tue, 19 Mar 2024 13:32:49 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB49539643F7428873280318D4BB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <29f468c5-1aaa-4326-8088-e03a1d6b7174@sifive.com>
 <IA1PR20MB495363835DD4C6B0EA2DA224BB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <b4863d37-2182-479d-8ca2-79951badfb8d@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4863d37-2182-479d-8ca2-79951badfb8d@sifive.com>
X-TMN: [jg+8a4V8CIGjyuLtW3x61MhHPxw9qfxvsa5QdxXrYDw=]
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <oe72iikfepnp7y3r2soomwchreoh2xp6z7l5m2bskrka4zso37@rcb4xv2hgygo>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|SJ2PR20MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a38285-efda-4b53-ac0e-08dc47d604ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8vqeE2HVIIDOgxEGy+II/NUuDJo6i4oA++1S+iUFdedv58XDd+h4hxhMUmJ+UOgg0VghE0ds5QnVr4ficdaJLMWHfYhH9viqq8JL0gbFBMKlcxJClkhoB9fl9KnSBCzgJjpYp6MSn1BkQHJpYO5MeASlmgsOtjKYXP2zk27JyfxPyjXkxViF+E+gmHLVd5wiLud3FzB2qyGffDLr326uT94zCYLJjBE6XrLuZTVDcW3rbuuGu4AmNmokNgJUECerPuAcix/l5OWkqavfDvXlKeO/SXLCsRelsirC4efKJnTBZZWTzg8ruvJac/wk+GYxqyiW03qSoqCZTUgjN0lH/Dh886ZwnIHxaIJc8A2IFFwhSXhazTHTRZ+bSVkhomfpsB4mTzM7auBied+yls+TYpkBg9CJHRQfA7kbjPSRJsiQegaZdSFHxPGhfGiaYChG3xTQYBCaaSigIrQ9zPhpyeid5DYwaHKZ2zWFF25blkIqOCBE6O9i9s4jmK/MXT8NN6BpDIv5kQmtHamw7UCHgXyzu+8+gWXGL5MbLd4gyGoqvcwccMIbcB0vXMjNNAKf1vgAevo3OEwOD8JfHsoiS7SVYWv2BsF+zazxNoY5je1z7Rtcz3P7xkbXy93Abqyq+M0vVK1+EY1pEPxNhdNY4l04Is+n0EZ0mMsdnvYepuAPFbZfwT0f22NJ33H3x3S9Nbb/+oSNNM4h5i5F4Zrlrw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOlyurMDFNXHnUGFrC70wo3DFPzoDfDP1+qZ2W73YFymSkLYQ6MiADjy+NFT?=
 =?us-ascii?Q?j4i4rfX4u86S9T3zSvQWtWzKN2HujvzuznO900ZY3m2MtvR5z1+39Zd5tMVe?=
 =?us-ascii?Q?qMjxfaDD2R7eyht6CSemDdPukHijBDY8EXEDTqrNqCXsvcDFlOOVdGsRKpoe?=
 =?us-ascii?Q?zt6vHtJZ0WwgfIXpKfxfeMQR2v8TRpPUDN1waywxFVszpQyf265FXi1sQUOM?=
 =?us-ascii?Q?ZJKSV8pP4tHb2l1GWg9oyTqI8PNwOgBhWt9yKaWNeqdrPXx789EI1gPg9ZmM?=
 =?us-ascii?Q?Wl3BdBkIeslDqwlnpYQCWw8nKy+a15e6+wXHHTxZRyFWNSTVd/9ufK1LDgJy?=
 =?us-ascii?Q?HaaVyq6dxIqi9/gCNMt7IjQuZeT7Zl/A11iSgXF+A0U4tox3+gI4MqSGa8YX?=
 =?us-ascii?Q?nIcEdUSDjU6Canvq8hiv1SAod9SyTbkUq4prBioAv14/YrqTbTItN8FrNR52?=
 =?us-ascii?Q?NGEfNESxtBkcVlzD4AX1KN+RGPCuHKFMPYQz6M9q8ucSA2QyNyu9HjMPIGJb?=
 =?us-ascii?Q?R+hKmfAgAC9l9GAtsRYFjJ8og2f63i6H89YjaQQ+ppokZLidPZtNqDUlAZaF?=
 =?us-ascii?Q?IftZMil2frqZbGankyPPpQMbCoPoxt4mO9l03q8jxarSk/1clqQHzubVUieS?=
 =?us-ascii?Q?ST5zjD1OHH0zb73rLr/MtUkXIgxyIMOMWQOHyIpOoaotjDqkOmYYOn5r2weP?=
 =?us-ascii?Q?aYEqzMrxaP5Hatg5Cpw19gON8+bJlAgl63H5K0c2aaChb/f/ZL4G7Y7oXwCV?=
 =?us-ascii?Q?o0HGqRNK8T4oYlgN8EuGdIhEqCrPFlyXyYIMSvSJmDdFavNFOteeX9R2sxLG?=
 =?us-ascii?Q?tVSHecbp0q86kMWPRcGfI3UYyesbsubYPzSQ9OpWTNT2anTJ5SRViz50DWMF?=
 =?us-ascii?Q?+b6tbPtoXxHewMXgSOMTLAh4yrCddcmmmau9Z9mtuXtM0ZohTU9+PYkV9zEg?=
 =?us-ascii?Q?95tg3jWBPRXUJMrRqGk5wosKrdgEHIU/SwQ5yseM7NcDOIWOhDpkNONh0JSF?=
 =?us-ascii?Q?g15J9zf4DfkGIpKg3sCRC9YnUuhlRAk+0azGT9X/zedCHl0+oxgfjk/yuB6P?=
 =?us-ascii?Q?RDUJLyZyyet7yBrF4JyLEThaORYes+HJ+EPTGt2ElUV97b23J5Xx57Ze0Czn?=
 =?us-ascii?Q?i8m/q3JfW6aILv8Sl8bFJsSB6rUtMm6norvzzmWnTr0Iw79RDMUgjo6eFVQj?=
 =?us-ascii?Q?4SELfvj2Q/A4gc+kTKvqwILWHMIBsxlhPiQzFrMZzWAyVGDF9PqsMnW9VfNt?=
 =?us-ascii?Q?igtkfQNGnrYb09D7K42l?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a38285-efda-4b53-ac0e-08dc47d604ba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 05:33:07.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6973

On Mon, Mar 18, 2024 at 11:27:37PM -0500, Samuel Holland wrote:
> Hi Inochi,
> 
> On 2024-03-18 11:03 PM, Inochi Amaoto wrote:
> > On Mon, Mar 18, 2024 at 10:22:47PM -0500, Samuel Holland wrote:
> >> On 2024-03-18 1:38 AM, Inochi Amaoto wrote:
> >>> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> >>> an additional channel remap register located in the top system control
> >>> area. The DMA channel is exclusive to each core.
> >>>
> >>> Add the dmamux binding for CV18XX/SG200X series SoC
> >>>
> >>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 47 ++++++++++++++++
> >>>  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
> >>>  2 files changed, 102 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> >>>  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> >>> new file mode 100644
> >>> index 000000000000..c813c66737ba
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> >>> @@ -0,0 +1,47 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Sophgo CV1800/SG200 Series DMA mux
> >>> +
> >>> +maintainers:
> >>> +  - Inochi Amaoto <inochiama@outlook.com>
> >>> +
> >>> +allOf:
> >>> +  - $ref: dma-router.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: sophgo,cv1800-dmamux
> >>> +
> >>> +  reg:
> >>> +    maxItems: 2
> >>> +
> >>> +  '#dma-cells':
> >>> +    const: 3
> >>> +    description:
> >>> +      The first cells is DMA channel. The second one is device id.
> >>> +      The third one is the cpu id.
> >>
> >> There are 43 devices, but only 8 channels. Since the channel is statically
> >> specified in the devicetree as the first cell here, that means the SoC DT author
> >> must pre-select which 8 of the 43 devices are usable, right? 
> > 
> > Yes, you are right.
> > 
> >> And then the rest
> >> would have to omit their dma properties. Wouldn't it be better to leave out the
> >> channel number here and dynamically allocate channels at runtime?
> >>
> > 
> > You mean defining all the dma channel in the device and allocation channel
> > selectively? This is workable, but it still needs a hint to allocate channel.
> 
> I mean allocating hardware channels only when a channel is requested by a client
> driver. The dmamux driver could maintain a counter and allocate the channels
> sequentially -- then the first 8 calls to cv1800_dmamux_route_allocate() would
> succeed and later calls from other devices would fail.
> 
> > Also, according to the information from sophgo, it does not support dynamic 
> > channel allocation, so all channel can only be initialize once.
> 
> That's important to know. In that case, the driver should probably leave the
> registers alone in cv1800_dmamux_free(), and then scan to see if a device is
> already mapped to a channel before allocating a new one. (Or it should have some
> other way of remembering the mapping.) That way a single client can repeatedly
> allocate/free its DMA channel without consuming all of the hardware channels.
> 

Yes, this is needed.

> > There is another problem, since we defined all the dmas property in the device,
> > How to mask the devices if we do not want to use dma on them? I have see SPI
> > device will disable DMA when allocation failed, I guess this is this mechanism
> > is the same for all devices?
> 
> I2C/SPI/UART controller drivers generally still work after failing to acquire a
> DMA channel. For audio-related drivers, DMA is generally a hard dependency.
> 
> If each board has 8 or fewer DMA-capable devices enabled in its DT, there is no
> problem. If some board enables more than 8 DMA-capable devices, then it should
> use "/delete-property/ dmas;" on the devices that would be least impacted by
> missing DMA. Otherwise, which devices get functional DMA depends on driver probe
> order.
> 
> Normally you wouldn't need to do "/delete-property/ dmas;", because many drivers
> only request the DMA channel when actively being used (e.g. userspace has the
> TTY/spidev/ALSA device file open), but this doesn't help if you can only assign
> each channel once.
> 

That is the problem. It is hard when the register can be only write once.
It may be better to let the end user to determine which device wants dma. 
I will do some more reverse engineering to check whether it is possible
to do a remap, And at least for now, I will implement the basic mechanisms.
Thanks for your explanation.

> Regards,
> Samuel
> 
> >>> +
> >>> +  dma-masters:
> >>> +    maxItems: 1
> >>> +
> >>> +  dma-requests:
> >>> +    const: 8
> >>> +
> >>> +required:
> >>> +  - '#dma-cells'
> >>> +  - dma-masters
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    dma-router {
> >>> +      compatible = "sophgo,cv1800-dmamux";
> >>> +      #dma-cells = <3>;
> >>> +      dma-masters = <&dmac>;
> >>> +      dma-requests = <8>;
> >>> +    };
> >>> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> >>> new file mode 100644
> >>> index 000000000000..3ce9dac25259
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/dma/cv1800-dma.h
> >>> @@ -0,0 +1,55 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >>> +
> >>> +#ifndef __DT_BINDINGS_DMA_CV1800_H__
> >>> +#define __DT_BINDINGS_DMA_CV1800_H__
> >>> +
> >>> +#define DMA_I2S0_RX		0
> >>> +#define DMA_I2S0_TX		1
> >>> +#define DMA_I2S1_RX		2
> >>> +#define DMA_I2S1_TX		3
> >>> +#define DMA_I2S2_RX		4
> >>> +#define DMA_I2S2_TX		5
> >>> +#define DMA_I2S3_RX		6
> >>> +#define DMA_I2S3_TX		7
> >>> +#define DMA_UART0_RX		8
> >>> +#define DMA_UART0_TX		9
> >>> +#define DMA_UART1_RX		10
> >>> +#define DMA_UART1_TX		11
> >>> +#define DMA_UART2_RX		12
> >>> +#define DMA_UART2_TX		13
> >>> +#define DMA_UART3_RX		14
> >>> +#define DMA_UART3_TX		15
> >>> +#define DMA_SPI0_RX		16
> >>> +#define DMA_SPI0_TX		17
> >>> +#define DMA_SPI1_RX		18
> >>> +#define DMA_SPI1_TX		19
> >>> +#define DMA_SPI2_RX		20
> >>> +#define DMA_SPI2_TX		21
> >>> +#define DMA_SPI3_RX		22
> >>> +#define DMA_SPI3_TX		23
> >>> +#define DMA_I2C0_RX		24
> >>> +#define DMA_I2C0_TX		25
> >>> +#define DMA_I2C1_RX		26
> >>> +#define DMA_I2C1_TX		27
> >>> +#define DMA_I2C2_RX		28
> >>> +#define DMA_I2C2_TX		29
> >>> +#define DMA_I2C3_RX		30
> >>> +#define DMA_I2C3_TX		31
> >>> +#define DMA_I2C4_RX		32
> >>> +#define DMA_I2C4_TX		33
> >>> +#define DMA_TDM0_RX		34
> >>> +#define DMA_TDM0_TX		35
> >>> +#define DMA_TDM1_RX		36
> >>> +#define DMA_AUDSRC		37
> >>> +#define DMA_SPI_NAND		38
> >>> +#define DMA_SPI_NOR		39
> >>> +#define DMA_UART4_RX		40
> >>> +#define DMA_UART4_TX		41
> >>> +#define DMA_SPI_NOR1		42
> >>> +
> >>> +#define DMA_CPU_A53		0
> >>> +#define DMA_CPU_C906_0		1
> >>> +#define DMA_CPU_C906_1		2
> >>> +
> >>> +
> >>> +#endif // __DT_BINDINGS_DMA_CV1800_H__
> >>> --
> >>> 2.44.0
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>
> 


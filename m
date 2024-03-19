Return-Path: <dmaengine+bounces-1439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467187F641
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 05:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5753F1C21813
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 04:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D57BB1B;
	Tue, 19 Mar 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ig8t/zc5"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2057.outbound.protection.outlook.com [40.92.42.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1667BAFE;
	Tue, 19 Mar 2024 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821038; cv=fail; b=G5xYZSlIZnCefKdPBgHeKFjn1YXuKlUBytqiLtrHWvrEciJ0ed648d09hf02oRqTtpv9jcJcuK3QL5wgAp7EosEHMYO118nL8aKk7cyU+UOL+c/yP5pHwFEJINrPtppf9RZKtakYoPS0sFzL3gZgcMmywXb1PrJ9i80mwYmruN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821038; c=relaxed/simple;
	bh=ugMRtB5Jq08LS2o9T4rvkqKSlhF4m7fcKNsDkApUBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFEWI7aP7a8LWuHp6zTu3GQfC4huqpJ4YD87Utar6nQpjYZ/M8tVso2xjiwbATLnAZaSwFoQVeF2hnJLatg5rIx2qiINh6us2v7y9J6tbsU8pSUGccBokAQDN9wEx2u90uJKL5+yWlLz4qexC5xN+24VsEDbOlVug6OFnIxTAAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ig8t/zc5; arc=fail smtp.client-ip=40.92.42.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgOUDKi54+IOC3WeOISk/KMCfUC42sFZdfiGjOvjv+FwzBKcFxn6jWBJYvQpZUx9zM4MmZcD5C3W6t2KP2b7NIyMeU3j9kFAFQyajKXsM+nXM7+QBOY7Yjhjwr7fTNihLoGO79QhOBYQae8EMv68Dw2lVC5LQkON7ikIlUKesEtIOzVQ00WA52/ZUEh/HJqtRUr5miPK3Tr8VHPYOI+xUBtnNBsyg+ECfKzRMPD3BA8DTl3E+wAJv9tekfShIrY4QzUmD+/t0xwyq1t1QqFfEVoIYUax+7gwdRqru71A4gJqFk1empurxdpBwxYY7W8UqZKttmuJ4A3libxU363A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/EfHzbGKgsvLE4233fAV91Gst5pXuKcs6hXY7YkTOI=;
 b=DpNTQi3jMGRRHotRFkX+Pv47Wq5kFoUi/SnONFITnsmRtmT0w1HeFG+o72U35JXIuTlyvbsoCP3Ls/l9OpmWwCvLeh9aaldTykUccQljjmWzBfjKJTo98gzzCx5mEvkDMn9dZmuSZI5du2ODf6PZonBuYg5VACALanZN/8WqsrmFegC9SI8iao4ZfEtNRMJmZFxUM1crykKlXrhVD8vD4JjYBcop15F7P7+3EohlWGpeFqdgLImucctErJFFLHqhxp5W8FTODLTYfD105SB06KxEhLgB7RVRXAgnrARdncvGtfe64BelbeLdjKvRV1+TxQssfPJVRS4DzUVIAnNjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/EfHzbGKgsvLE4233fAV91Gst5pXuKcs6hXY7YkTOI=;
 b=Ig8t/zc5tOzhrpx0VPhhFDz30fRt69KYvlS40YrsECSkm+3E1CIkdqGZ5XqBJOTjZv5YX9uQsB77f4fv5lKUvg5luaQpJJ4CWaqbxwXRjzNTgvWfkcvWQKNga0ZajpASgOrL/pXth2eEY9uALTwMiSV+A3Tlu/8UqaAbsaz06z3sEIHLE+SoL+e3IYpk2I44qG5BbpePg6Ft/bzu8S4PFTee7x4Qd31MNhLgmyniRP970feXdc6Fteah2QWV3lBbF6QUjmkphCv0ZTWH69jxuQUMgG5wEWNdtjEFOn9tdeyB/MZblAOcYc04E8QKGC/aEwZQpgNtYlGjIQeAz/G0EA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA3PR20MB5888.namprd20.prod.outlook.com (2603:10b6:806:318::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 04:03:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 04:03:53 +0000
Date: Tue, 19 Mar 2024 12:03:54 +0800
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
 <IA1PR20MB495363835DD4C6B0EA2DA224BB2C2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49532DE75E794419E58F9268BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <29f468c5-1aaa-4326-8088-e03a1d6b7174@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f468c5-1aaa-4326-8088-e03a1d6b7174@sifive.com>
X-TMN: [d1m1NKlTz46g39Fv0MnA7JRExOJtqI0KbMPdKy/ItAE=]
X-ClientProxiedBy: TYAPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:404::36)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <vo3hmz4xazbwp7oqxg7ehy3a7vmn2aru777zz47am5p7vxbcgt@uvifvririfal>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA3PR20MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: f00fc7a3-14b7-4554-5b5a-08dc47c99750
X-MS-Exchange-SLBlob-MailProps:
	98ioH9+sI7/gmAhNpKNDe9mf06H9eeFe1adcnj3WughFRFBtuV/cwE3ShP434/GnzitabmV2Vo8/H9We2MlGQs6M+OiS9sjOpsyQGFXdiIPVsMErMhF9WcQKOQeOXBcyuOpsqQfaClWqGQMQImdOuKrleyREQtx8DnSWRgzdEZUYVb1+aJYRzbC/dx7OSrOsY6HCW0MpvbUjyD8WWi9QsEb3sy4LSM5g1hMynFSd6XRT5yFA0HIqXP1XLZkU8rqKRTMYhUtVCO7aXkRKWLkGQQgxGJjmnfVapyQTRWwttFnSQF+2Fj2LAQ3iX59ZLbwWI2eAZ6ACbJ2AZ6cW5vrHTW0Ava+X28fplup+j8zrTwLYZkKhyyY7WoNbWB/Oz8OH1wcAyEOj8ajZ1QuUpL8GIHalZTRLCIUfv/kFks38GcZHKlMK3PXamdOI90DVZhtZJIGsGBG7VPMGNYkrHo/2iw6Ebd14Uh7SkBPLgo+ALtB+qPfWZT3qBJn9VmS046IiCCdRgqcOVJCIVdYXsoNpEq9tEeNGI98eb/oHDSIvs6i7ZfQsmIhKk3yYF2Y9fgBpWDq8okQiQwHTO8P5WTeoki13OpvjR/DRbqzxyInauTsmIYAs9nYjtaeXSZxaWSrAz6DV7b+9G1Q7LakvlHv0CeRF999ansG4cki/3bYXdd5TiwsHyieJlbNcMWjLubEJBrEKo93czMTB8WmLbNj2Pp7pTAUxehHtV6nkG42mAUlizS10VS7Errixfj/PJoBgMuDxSReZfLYNG77Rd7GsJEkg8PVOS0zPEbL6yinotRW+EwaWHQgBwKcFb61uZHZFYeGLBuLTTxr6lw3uLAHKxOIpghhprrrF22rDOSOYgFCWj7QmQtj7lQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Avh6wlDqJ/YWpCiIq76VLHs+YKFB84RubwfN0T9d7hLgh8XxXbUCv7Lkb/tjDm87ZcmsTNl0nW/7aax9KlqIFtMitLCGZxTjGZJxNmwtHh4zRwgtJHLLQtl65iHEoWDTBdP0p6XdEnyeQriMvliudvgN+25/gCedju/s4Cz7FPGXA/h4qAyf9IVhqgLSdAhSPWgsomYAdLZSS8dHAokGXlYAAp9KmHgNtPZ+yhjjJLj0L6BpHwb/RiBa/1fKin5zV+8f8wwFxujzoNmy0JVGAn2FlXbZb8cwNB5xmXzr3+9isBrDzUGwFYIquwt1fs3168Ykto8FR2wlMy6cCBuNatCPqOAZGm3jOR5krJrHiI035GMYA4Ko0bpLW9hQBQ8UnLeAzrzrp8/a5zOGCL0tlFcmVwCfpxARJyspCZMk3Xqi5rR2Mc78uAbvtj+XbhcyOLtrgDU8tLuCjzlWdve/MZoV2co35/vc7I/grg/pFQATtDwfAQc+c86URRNYRhsg7Ymg3DAMKGYNF0JTq+2/AlFFLWPk8hzho1d0Wlh9t1wAgYJ4iA/4hFPM43wFj7/yVpqRkJXbCo1ANWduumwIOUs6EzYeLp+0b6u1HceyDZ0jTCztr+VkCuWhIzyJdhHefjujJi5N659VnH1bBymSWEdAfwtm+XKtadw2mLfwLfCYyYnfKirBD1RZ/bo3dR3AdaUY6mxqe/6zCg27Kp22Vg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Knzgs1S02Fla9oKgcOMX7NgdafjusIRve3Nfs4fCoeOBDsX0VnQYB6HojOM?=
 =?us-ascii?Q?ylHjFPPZscjmE9J2ORkYjq43lAhgZucQ1WPqn3vPEBOikBdVVOQerVRWze/A?=
 =?us-ascii?Q?/lriRWTPYwHN/Ss+MoQDRDFrxIPEBmFm3i12vqEGHgSNfHOhwq89Ps7XIgfV?=
 =?us-ascii?Q?foCzkNA+X7NKvOjRimihK4CqrcOtiVKIF16gOoJ6veLhcUn0Zo82SeG1iECH?=
 =?us-ascii?Q?pH7P5AWNNaY5+MSQj35SLe+U3/wkWBJx68ePkGNNAYu8OcR8Gzm9BoVCgGEa?=
 =?us-ascii?Q?wEzDLrLi549Flsvc2HPUDHdDnkqIOIUIiI17ngbElbt+hADac4nCaLBW7432?=
 =?us-ascii?Q?TUx4Ay4sMu3KYgFOHuEPMvje+nuJNAcI3ubRQJqvt5euymcP3tTevK56Q9s4?=
 =?us-ascii?Q?X7GGxVYP++ihAd1p63LfO2N/DHDi7i6A0SCLhD0xeVft0e6j/MnBAvkxiFvH?=
 =?us-ascii?Q?YYvOtRYB6hoHXUZd7zMoDf14N+UFMYJ5XMihmUHRNBskWDenGvF/1jG7f1gq?=
 =?us-ascii?Q?7WOlzpajR3dgRqPp7FWuSRzyP4AkcJUNMy7uxWhO9P+DZntF/grQzy+owODb?=
 =?us-ascii?Q?EvNwHogpRTZLDjtocPaDC+6j4UWkcuNTgZAnYE+XPc1XRHa06ryLLEt7D2ag?=
 =?us-ascii?Q?Szatog6jhx1zRJE0xaNR0CMr7MNzSrkNBOKCrK7bKEO/USpdbmca5KglEkYM?=
 =?us-ascii?Q?l0loxdM+v1x5KW9fPDF0AATdJkolwC163/j3gbU5as0Fq3xMxH8SpBEDBAqF?=
 =?us-ascii?Q?Hhw2ZfKuf7yl3MGqnUDQTzAXdpQ16gJIWiI4C5chT0EOyjBzWps+uhGKdZUM?=
 =?us-ascii?Q?zyFrcZXbt3POkOzwoRvr/Nd/eZhJqU7lwnIschvQFVfYXPRsPofxx5t3VDF1?=
 =?us-ascii?Q?1yTBCgFquanwrSe8tm6T4NxGfymZtLIgbEJtTHXp6Nocl1JwkA0I92zqDeHj?=
 =?us-ascii?Q?hcThJ7mamVsKKquc4qKIxHJVCdL53eVlMlq48s0dbWp2mcT+7ekL0qNvaJGn?=
 =?us-ascii?Q?sTcRWCX3yyXaHN62KESnhw/Jnlzi4NTudiYTA3eU9iPPG1b7UYKU60UCs617?=
 =?us-ascii?Q?QR5kZ7jskOV+e2qNATb5fUlhE63ymARIMBoxvh4Waa1ITINyxw7hsF8rScv0?=
 =?us-ascii?Q?XjuQHtDzQgfOU84y7/Y8NAjIlZa5oqobj37CVKcjx81qWnflLc7J7z65uEGB?=
 =?us-ascii?Q?ufVsgWcClt/yAowAsxKYM3wBAIOFwITSynSEc8GzMfUlGtuQD/ppyhNh+vDY?=
 =?us-ascii?Q?e1rKocEiGwpSkTQ6pNAX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00fc7a3-14b7-4554-5b5a-08dc47c99750
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 04:03:53.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR20MB5888

On Mon, Mar 18, 2024 at 10:22:47PM -0500, Samuel Holland wrote:
> On 2024-03-18 1:38 AM, Inochi Amaoto wrote:
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
> > +
> > +  '#dma-cells':
> > +    const: 3
> > +    description:
> > +      The first cells is DMA channel. The second one is device id.
> > +      The third one is the cpu id.
> 
> There are 43 devices, but only 8 channels. Since the channel is statically
> specified in the devicetree as the first cell here, that means the SoC DT author
> must pre-select which 8 of the 43 devices are usable, right? 

Yes, you are right.

> And then the rest
> would have to omit their dma properties. Wouldn't it be better to leave out the
> channel number here and dynamically allocate channels at runtime?
> 

You mean defining all the dma channel in the device and allocation channel
selectively? This is workable, but it still needs a hint to allocate channel.
Also, according to the information from sophgo, it does not support dynamic 
channel allocation, so all channel can only be initialize once.

There is another problem, since we defined all the dmas property in the device,
How to mask the devices if we do not want to use dma on them? I have see SPI
device will disable DMA when allocation failed, I guess this is this mechanism
is the same for all devices?

Regards,
Inochi

> Regards,
> Samuel
> 
> > +
> > +  dma-masters:
> > +    maxItems: 1
> > +
> > +  dma-requests:
> > +    const: 8
> > +
> > +required:
> > +  - '#dma-cells'
> > +  - dma-masters
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dma-router {
> > +      compatible = "sophgo,cv1800-dmamux";
> > +      #dma-cells = <3>;
> > +      dma-masters = <&dmac>;
> > +      dma-requests = <8>;
> > +    };
> > diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> > new file mode 100644
> > index 000000000000..3ce9dac25259
> > --- /dev/null
> > +++ b/include/dt-bindings/dma/cv1800-dma.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > +
> > +#ifndef __DT_BINDINGS_DMA_CV1800_H__
> > +#define __DT_BINDINGS_DMA_CV1800_H__
> > +
> > +#define DMA_I2S0_RX		0
> > +#define DMA_I2S0_TX		1
> > +#define DMA_I2S1_RX		2
> > +#define DMA_I2S1_TX		3
> > +#define DMA_I2S2_RX		4
> > +#define DMA_I2S2_TX		5
> > +#define DMA_I2S3_RX		6
> > +#define DMA_I2S3_TX		7
> > +#define DMA_UART0_RX		8
> > +#define DMA_UART0_TX		9
> > +#define DMA_UART1_RX		10
> > +#define DMA_UART1_TX		11
> > +#define DMA_UART2_RX		12
> > +#define DMA_UART2_TX		13
> > +#define DMA_UART3_RX		14
> > +#define DMA_UART3_TX		15
> > +#define DMA_SPI0_RX		16
> > +#define DMA_SPI0_TX		17
> > +#define DMA_SPI1_RX		18
> > +#define DMA_SPI1_TX		19
> > +#define DMA_SPI2_RX		20
> > +#define DMA_SPI2_TX		21
> > +#define DMA_SPI3_RX		22
> > +#define DMA_SPI3_TX		23
> > +#define DMA_I2C0_RX		24
> > +#define DMA_I2C0_TX		25
> > +#define DMA_I2C1_RX		26
> > +#define DMA_I2C1_TX		27
> > +#define DMA_I2C2_RX		28
> > +#define DMA_I2C2_TX		29
> > +#define DMA_I2C3_RX		30
> > +#define DMA_I2C3_TX		31
> > +#define DMA_I2C4_RX		32
> > +#define DMA_I2C4_TX		33
> > +#define DMA_TDM0_RX		34
> > +#define DMA_TDM0_TX		35
> > +#define DMA_TDM1_RX		36
> > +#define DMA_AUDSRC		37
> > +#define DMA_SPI_NAND		38
> > +#define DMA_SPI_NOR		39
> > +#define DMA_UART4_RX		40
> > +#define DMA_UART4_TX		41
> > +#define DMA_SPI_NOR1		42
> > +
> > +#define DMA_CPU_A53		0
> > +#define DMA_CPU_C906_0		1
> > +#define DMA_CPU_C906_1		2
> > +
> > +
> > +#endif // __DT_BINDINGS_DMA_CV1800_H__
> > --
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


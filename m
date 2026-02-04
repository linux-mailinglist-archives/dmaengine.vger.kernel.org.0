Return-Path: <dmaengine+bounces-8703-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAGTJPGfgmlgWwMAu9opvQ
	(envelope-from <dmaengine+bounces-8703-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 02:25:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BEE06B9
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A97302CD17
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A926CE2B;
	Wed,  4 Feb 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+f4ic0g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0723EAA3
	for <dmaengine@vger.kernel.org>; Wed,  4 Feb 2026 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168302; cv=pass; b=PBOj99RybDAoXz0cU4RUH4DX9+cmyxihuTwmkm1amRxjmToC/mI/EFkHknPfEvovfkvuH8R1UhtAzMXa7qY70nAFTNFamit6HZQF1OSr0nloCrRs+ZisdDr/qdmWkpLL78FvUSHdYlBum2BQ/IXRW8mF+1ODl0iU89vzUMU5swY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168302; c=relaxed/simple;
	bh=/+f2suc9LFtxuDNlXH100F4yN30vJg9HdtU9fyXKPzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey7NBoUfXBHGT6pNw/I1qJ5FZE2RlLCA5buHMC3TfU4uxoc/89PqMzbe5iFQicWy9yVJPFCES0Uzmd0Pgt/hHVxBdgd8KomOeBktW9lcZVSH5Ui4ejq/HEjrfLro4kDQ49VDsqNzxjhHzIldhdiJzJXp7oP8dspLQ2sMxG7qtig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+f4ic0g; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so1592575a12.1
        for <dmaengine@vger.kernel.org>; Tue, 03 Feb 2026 17:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770168300; cv=none;
        d=google.com; s=arc-20240605;
        b=XntYQzqNqxDyWdpAkmEYDgKlUvtI0hk3P67oizWEBmSM1E+BYuMRcCiDKAM/gtxx9Q
         e+dD2f0CNIJyhVzazKGoLXfN+nG87DrIuWEYian+nVN0lopYdmPgJQlUnRVzEfaUDQOd
         xehRJEM98eINqgnLyALEow7scuUTvWqcmMHM6GJ+aEPmIqiLKq2bWx1LWA+KL2Qt7Ewe
         rDa9LnYyCriaK5+3uoMfFhf7kfnnZqTk6smkzWqB5bg6Vp7AxCR3ZvpapncBd9O6Inwg
         v6LVYfJ7TYA9NNDT/zv2niOlC94OTxX8HdUGHRDarG11Pk9FFOBg2njS2JCMYr38bKL7
         2C+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSQbsRTvBz9zOZSX4Hu3wQKCkFjocGyQDMtXx0/BobU=;
        fh=C4OZD5L8ov7Sd2tpFqL/cLpsEmPtWharLW0UuKyjjhQ=;
        b=EQrJFuTqFOTcp1AZbqjMawCeCC3mZ8N40DSNpeS+u/dBNPNRlzkCwugZAdJzY8tkGH
         Fr1F2DIldzkoPiOC0JHL/hMwB44L5vB8Vp8rWvS71/ZaEL1Wfo6hVYm6ckmJls7lknv6
         JoGt567po9T8qglieRjZYZtNrn/VvtBdHsoYwUHGsUiaVg7PuvG0LMqU0kcwRz+x4f89
         AedPDV5czf/V8/iVLUxU94XUNzdyJne2t3620BNO8NPwxuuA0Q1UWyz3SJKoWEk4H7IO
         lzZmR4w7PpRZyyK1ZAHTmy/YL7ar/Lu5NtCU464PRY29rcigllv1Ia59yO/7BhIhh1qf
         SM3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770168300; x=1770773100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSQbsRTvBz9zOZSX4Hu3wQKCkFjocGyQDMtXx0/BobU=;
        b=D+f4ic0g4rlv3Mn26uP/0Tc1Q1QolwIuqrPUB8iux3sCYNAQ/Y8UbQHYBl2p+j41gm
         2ttcmrBBD4YH2E2n2vRf0Wpz4eLHngBaWrfsSNsztGZsKe5JKYSiO1TsPkDk0hfWyahU
         FBNHj9dHHzkHoprFrNIVRxr+XQYeI0VRgjAfoeKLGiVhMTqMmdeUaFYYVvxJSOlnIxzU
         EgJc2pEarmqQvofq6a8r4yFimbULOyuddkjQNnXhivhhSPsgc//vUu/Z4K0LbWsaIUNX
         T2MGpTdRLgjYnyUFTjLWESa1fInYZH+7+NEhk/awARQNgwLzY6q4t2taTWn16ZcXI3gR
         9yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770168300; x=1770773100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSQbsRTvBz9zOZSX4Hu3wQKCkFjocGyQDMtXx0/BobU=;
        b=S+sTm0yzCPsEWqgTUtWFviP8Q783Ap4V3JB39jEW3L33i2XbkfnRReiJkfq/03XIFf
         tM8AdEV2JUGh9l647xQGL2gvRIZTpDnCz7IsC4527q2OPAAVFIaTKbarPDJOen0bzSHL
         eD3YuHQg/4sn2BsRTRJIM6rFvbfJ8y7BlGU9trwHY03CSZ/0x8K9nutEhB9N0Vxy+H5t
         +k7LlN31TuEvKtkEOb7rZ+O+ARuucmpUb2ifEWmvhXL6sfdfhv5gMQuzT+SJrHaDl/bd
         jFPgt8IMWYx6WxpjgoHEIWap3PUE3voDsnGmUtXOpWNCjZ5FWaUc5AgXsW1whYqrpLXj
         FrWw==
X-Forwarded-Encrypted: i=1; AJvYcCWsc7A4NCpovplO5A6DPlb3B4yw297pyiwtY6qAeJnSJVKVbXUIZAZJbADiTgXm3aGk2NXVamWhU9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQWvFeATWQQ4zJ7OUEgvX0saySYQVSdKQzRBO495v4CNmPCk2
	2TX6ZodjqEqZKhbd8WzuzvKG8EmK+jc9Qw9ypZyWaomae7czyBx+0AAYM3HoQU09ByW51v3sywJ
	ZIR1N3kdnXaqtiXRxUud/Ha9Ojjt1Fhg=
X-Gm-Gg: AZuq6aIeuj3qGKl3qmqKLWCXsUElgs2ZQZVnC2h/gJPO41A0D3ddKtYAyBpEHjtZaL2
	IgFP/ZroAUOFqqMeU24gKRf35jLgpBs8risxxzlISY4i3SUq1XoBLkOkoKDjrOc7ILEpC1iCO30
	h/mUspsdXNN+ujzQCfOu5CNdJNqS3THTWk8yKTeBa91UKN22rLcLktbXaxKckSArWl2gBO9+wj3
	ggTV7TgYWf5zCitwdB5L2yggv9JiB7RC0HvCwAapzWElKuV9z3K8fMq4IrD6jzb8Y4CMAA=
X-Received: by 2002:a05:6402:1d4b:b0:655:a20a:a258 with SMTP id
 4fb4d7f45d1cf-65949abd3femr975527a12.10.1770168299500; Tue, 03 Feb 2026
 17:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770119693.git.zhoubinbin@loongson.cn> <7d6bb6ddc9b2d7c760fa0dcef30123f700e47f77.1770119693.git.zhoubinbin@loongson.cn>
 <aYJT3B/vgjklDN46@lizhi-Precision-Tower-5810>
In-Reply-To: <aYJT3B/vgjklDN46@lizhi-Precision-Tower-5810>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 4 Feb 2026 09:24:46 +0800
X-Gm-Features: AZwV_Qg7lTZAlTII9Lc1LaPvKwjyIxSgjAYbgx3n8Pz_6fYcbnbBi3dEw_krDVw
Message-ID: <CAMpQs4+jT8kCXSKta2QfQyhek5sC45yqnW=0f_Ap-8HnynbSOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: dmaengine: Add Loongson Multi-Channel
 DMA controller
To: Frank Li <Frank.li@nxp.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	Xiaochuang Mao <maoxiaochuan@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	Keguang Zhang <keguang.zhang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8703-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,devicetree.org:url]
X-Rspamd-Queue-Id: 1E3BEE06B9
X-Rspamd-Action: no action

Hi Frank:

Thanks for your reply.

On Wed, Feb 4, 2026 at 4:00=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 03, 2026 at 08:30:11PM +0800, Binbin Zhou wrote:
> > The Loongson-2K0300/Loongson-2K3000 have built-in multi-channel DMA
> > controllers, which are similar except for some of the register offsets
> > and number of channels.
> >
> > Obviously, this is quite different from the APB DMA controller used in
> > the Loongson-2K0500/Loongson-2K1000, such as the latter being a
> > single-channel DMA controller.
> >
> > To avoid cluttering a single dt-binding file, add a new yaml file.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../bindings/dma/loongson,ls2k0300-dma.yaml   | 78 +++++++++++++++++++
> >  MAINTAINERS                                   |  3 +-
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2k=
0300-dma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dm=
a.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> > new file mode 100644
> > index 000000000000..d5316885ca85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> > @@ -0,0 +1,78 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/loongson,ls2k0300-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Looongson-2 Multi-Channel DMA controller
> > +
> > +description:
> > +  The Loongson-2 Multi-Channel DMA controller is used for transferring=
 data
> > +  between system memory and the peripherals on the APB bus.
> > +
> > +maintainers:
> > +  - Binbin Zhou <zhoubinbin@loongson.cn>
> > +
> > +allOf:
> > +  - $ref: dma-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - loongson,ls2k0300-dma
> > +      - loongson,ls2k3000-dma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 4
> > +    maxItems: 8
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#dma-cells':
> > +    const: 2
> > +    description: |
> > +      DMA request from clients consists of 2 cells:
> > +        1. Channel index
> > +        2. Transfer request factor number, If no transfer factor, use =
0.
> > +           The number is SoC-specific, and this should be specified wi=
th
> > +           relation to the device to use the DMA controller.
> > +
> > +  dma-channels:
> > +    enum: [4, 8]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - '#dma-cells'
> > +  - dma-channels
> > +
> > +additionalProperties: false
>
> use
>         unevaluatedProperties: false

Yes, that should be it.
>
> because there are $ref: dma-controller.yaml#
>
> Frank
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> > +
> > +    dma-controller@1612c000 {
> > +        compatible =3D "loongson,ls2k0300-dma";
> > +        reg =3D <0x1612c000 0xff>;
> > +        interrupt-parent =3D <&liointc0>;
> > +        interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <24 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <25 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <26 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <27 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <28 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <29 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <30 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clk LS2K0300_CLK_APB_GATE>;
> > +        #dma-cells =3D <2>;
> > +        dma-channels =3D <8>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 66807104af63..16fe66bebac1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14771,10 +14771,11 @@ S:  Maintained
> >  F:   Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> >  F:   drivers/gpio/gpio-loongson-64bit.c
> >
> > -LOONGSON-2 APB DMA DRIVER
> > +LOONGSON-2 DMA DRIVER
> >  M:   Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:   dmaengine@vger.kernel.org
> >  S:   Maintained
> > +F:   Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
> >  F:   Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> >  F:   drivers/dma/loongson/loongson2-apb-dma.c
> >
> > --
> > 2.47.3
> >

--=20
Thanks.
Binbin


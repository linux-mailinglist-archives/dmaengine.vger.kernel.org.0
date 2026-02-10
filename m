Return-Path: <dmaengine+bounces-8864-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOVOOvbJiml+NwAAu9opvQ
	(envelope-from <dmaengine+bounces-8864-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 07:02:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E151173E4
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 07:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A2A4301F794
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F7919EED3;
	Tue, 10 Feb 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWEiVB6s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E7220F2C
	for <dmaengine@vger.kernel.org>; Tue, 10 Feb 2026 06:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703349; cv=pass; b=P7xBEHyVOmsOX+wVlRTBjCBX9msOXNp7pR0+bBIX9cxydrN3Xd/mzRL0l2afRdkLncj+3kNTtOGCGWffHQtN9kkz+Zlok8MQQLrZvK3W9sQFGv7OrQOg/SfNuCJra+QJZZ6opgQR9x402oifDuAQlhyQFW85S09obUhKVMXNpFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703349; c=relaxed/simple;
	bh=SBGRUJE27Sh9oreSO41Rbst3WAb+KnZAYy13PKJYLsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGYSh1jxUbLmmuLUWreF8nT4n414R83J0kae0OhMmxeMz2TLMCogW9pxTWlvS3yq3zEArVNWc5VrefKZ/A/ezjD32tlYQ+Ik2gz3HNcg9foGz+G4V4i7MBdD1/oznWXIW55v/AqXvBU84UjyAuzktNfPBxCPndqjE3i2P7gvp5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWEiVB6s; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b885e8c679bso504936766b.1
        for <dmaengine@vger.kernel.org>; Mon, 09 Feb 2026 22:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770703345; cv=none;
        d=google.com; s=arc-20240605;
        b=BpBL1LQEKqlcOGPnERH2FXL5oKg+0NzrkJM9NLisMJU70gATokhc7TEIX6oULOK9oM
         E3JqiP1An0YuZNUAxEswSbU7fMLVVE0qJO/K7k37/I9spiqOGlALWNBBjRXdXfhljScg
         c25GQPFRoBcD6xeJ7nWTNAQQiZTtveLYM0zocqJNWqvFTUqiPNR3vpp50ydeJ++ssP7m
         weFXONb+iYIS8Iyv5jqCTxKXAGXCvdle79XRBjVgf5OQtogoBdBr+j7KKDZEKbaZpAWg
         +ap325zSJJMnNAETsrXDIYmMiAVvL/WRTN92/6qGcfCNOo9g1UZScUvhsGvWwGEAAsA3
         H4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wdfQoNjE0A1x2BNxyqiUYamnhnBwjzLKcZCZB7uzUFA=;
        fh=wA585UZsERmAwwzsh7BchGmAAE+yRzCN7EG4FKngP/g=;
        b=Oqgt9Z1eRAJ7wlFUcEocGTls5SXokGr0n+eWLfJLGaTa4J8WUuILkQ356IcGhqXKe7
         /5/tyQcAybTpcozeYEN6Wu8KbsVGxgDyQ0IWtIT/gShoZWa59xdem2f6RmnqvHMUALVx
         sr93PxLw3xJI6qjojV6rYk17JSeJBntRMdrsBvY299eyyRnRHfrvQRjJNO+xpvAzmCth
         5IyqmPBDv47PTCFHJT2eaLPb13C/Gc1jnLg2TOAeRxBcZKI7jTqJppTV6+Eki7Ye5ILU
         vxdaUvoSkArbD4+BSbggSLGZSYKintse86Xx11CAuyS09t97E4u3k981kMzlHH9AcUDq
         55AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770703345; x=1771308145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdfQoNjE0A1x2BNxyqiUYamnhnBwjzLKcZCZB7uzUFA=;
        b=DWEiVB6s+Dg1EJEGZCfSSuBzdxpUF51eP+FIQpBUDAb/4ABWUCGGS2joZBY3zuiSh2
         Q6DNoj6zy9VhpZ+s0LZz756c3V/ibI/TAG0qegxXYywKftP41Su4b9ZIiEM2PKeQCXsI
         WvJAAYOPGT3PpdbIR3YaOdlAyGF5U0S21o2YM/c4JSj9++T+n/2kVgplN1UnfCK7zeNo
         MKnMm+CEts811tSh4wXsZAGWvEjfgNYweP/U3guqF0se9aADgRGb3qNAeeJdllJo6MTu
         qG6dGKv1fDKQeyQnEnlXF5LpIHtTRqlE620wpzLGrkoLRXtPsHDDQxrfGzhii9HeR+HR
         kGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703345; x=1771308145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wdfQoNjE0A1x2BNxyqiUYamnhnBwjzLKcZCZB7uzUFA=;
        b=BQ/xRT4LZdTJtN8foSKPShGesyIeNo8V89Huh6XfnvWk3WoZTOZhxLeA6zM0DDSDpt
         YDFuCsYypP1j9P91AGc9vh+dhyxAD2SaVQXAbCvBw3sbM/Y/FkNITMGQohTCsO4nzZtv
         hQJk+jV3BORdip1aOOh6aTmvzXKcjGUwj6EjwSf7TpnOlPAmr9RtXYswWVaZFt5rQekB
         ztODxeNCwhhrb75joaQ92TLu02gRa0LpHHkD9YR/xWD8805FhIaF4fDkGz6i2lE0l1fX
         UNYNK4tvU7KoTTAx3S0fbnnkA1j+OVWkPTdm1uODn3LMHX3fIE17LZ8uTeChF5TwSjA6
         s1hA==
X-Forwarded-Encrypted: i=1; AJvYcCVyc9t4PZQ4BWpheFa+SNwIogLT7TfnIt2xJtklVhiS/PIBneGq2eLovANkXOpJlANCP/cRVB2EX6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0kdwjIoECkZwYeGeDHKcjDXIPvFFfuZAOOz3OxgfnvYFGVe4
	61LJLAevAk9uyEiPHuWLPWFS06FNQlX9zHzizySobDnj3geLLTufxupHMMBIqn35SHp5ItSw8+f
	sVvZE0uIegYTay3liPbOeWoSqJZuuwtU=
X-Gm-Gg: AZuq6aLXQaBFXel+Dn1ZgXRArDhFhqQX1EzoEZ8wIjgle+Wox2N9zGJtNH077zbJYr2
	OjbcneUEEzwLoutspywRn1APgmtavVRbrL3y3L+EwqKLqSo5G7Djm7qLyNpverGOoMz9jKNLsT/
	fg+Xo28tlA1ck28s/g6lvzskl28VY46sLwDnBcHCB3Ds4fGLn9/j01t6OPafwdRh05MXd5xFbgx
	ZYTCl5TfPAf/11pnFfcPj7QTJwYO0E4f+RElqEu7s47pN9+SXVAR8QTww/FeqmE6PljUK56jSrT
	JF10kuch
X-Received: by 2002:a17:907:3dac:b0:b87:965:9078 with SMTP id
 a640c23a62f3a-b8edf14c39emr680666066b.7.1770703344240; Mon, 09 Feb 2026
 22:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770605931.git.zhoubinbin@loongson.cn> <36cc977f0746095196354b631f0b158365208a0e.1770605931.git.zhoubinbin@loongson.cn>
 <20260210030346.GA2406064-robh@kernel.org>
In-Reply-To: <20260210030346.GA2406064-robh@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 10 Feb 2026 14:02:11 +0800
X-Gm-Features: AZwV_QiqIfn7ZPx0x3V31tbQ_jX8n-lqXvq0szv7fUMgSdTmEq3QSZCxI0OoBUg
Message-ID: <CAMpQs4JcnkmVM6B2rCQnFsdnMs9XnoV3EwO+0yA9XdXvVQg8cQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: dmaengine: Add Loongson Multi-Channel
 DMA controller
To: Rob Herring <robh@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, Xiaochuang Mao <maoxiaochuan@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>, 
	linux-mips@vger.kernel.org, jeffbai@aosc.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8864-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,gmail.com,aosc.io];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1612c000:email]
X-Rspamd-Queue-Id: 87E151173E4
X-Rspamd-Action: no action

Hi Rob:

Thanks for your reply.

On Tue, Feb 10, 2026 at 11:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Feb 09, 2026 at 11:04:20AM +0800, Binbin Zhou wrote:
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
> > index 000000000000..77e5df47ec01
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
>
> I'm assuming this is 1 interrupt per channel? If so, add a description
> saying that.

Yes. this part will be rewritten as:

  interrupts:
    description:
      Should contain all of the per-channel DMA interrupts in ascending ord=
er
      with respect to the DMA channel index.
    minItems: 4
    maxItems: 8

>
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
> > +unevaluatedProperties: false
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
> > index 27f77b68d596..d3cb541aee2a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14772,10 +14772,11 @@ S:  Maintained
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
> > 2.52.0
> >

--=20
Thanks.
Binbin


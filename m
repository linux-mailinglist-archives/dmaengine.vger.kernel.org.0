Return-Path: <dmaengine+bounces-2253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31158FB2ED
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E386B1C243FB
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9D1465B7;
	Tue,  4 Jun 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4bKT20b"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C18145FF1;
	Tue,  4 Jun 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505417; cv=none; b=H9D34N5nwFTq26LPhGr6v8C4Da+neNLcbs7AJUBB8w83j6QutrzZWkO51peR5mztpj3rVPoxn+oERRYRGoeOviqlRYwo2pGHdkW7DfRsHZG+FeAUrnYSkrYVyXQcb8QsvH5/H7ZClBDeMFqLBg/Xa/Anwky1qP1mvrVNytE69HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505417; c=relaxed/simple;
	bh=uL/t7pm9AK4sEcDXmw3Mra5gJjxVZIFJK9MXRYF5SCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzgkMzeTR8poymTuyMufW0IH/Da9rELUi1eaFZvSlg+YLiFKKHqtyKJWsoI6diWl30qEpqgCIc61kXrocVuDD39H5QMPrIGDuksKj6kaS0Ht5TqENmLZF9xRO0YmBiCPf+yCP3Y0WNGV2CWZwkoXLuSQwlVsmLZ9Voj6d2SoPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4bKT20b; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so3342259a12.1;
        Tue, 04 Jun 2024 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717505414; x=1718110214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5A5/CwMQp+giK6dA3QbmX6y5Z0nir0CTmgUL04kHgE=;
        b=Z4bKT20bGMXD/hk6vaMlGYEtJU15SQFFGJF0FO93kOVnrFOkPoYb1MJ/1VShuoAyem
         syYNMKa6g5kbjkqLb3yTYj3OTv1iWT1CnVpKKrLzHMa9Ttl6PNcKaEAC2mMiN4y/CHO2
         eJm67iJT/ndfWtIFsH9/5UZzdv+3dI8w7Ecdip+yk32SKy5c+pYIHoaLFbpCy1/B2Wuk
         vQK57JT9Pw9wcdvg5/iFe7qViq1/2s1kfyEShnoGDbDxC/jycH3Sx7tk01BUhJkA5xCh
         J0cX3ls4XbAW5W7dt0GB65hX3QZy+v3KJdx0kE+WFnMJj8k4/rG0jZwS6l74Ek6SJ1t4
         Ldaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505414; x=1718110214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5A5/CwMQp+giK6dA3QbmX6y5Z0nir0CTmgUL04kHgE=;
        b=T1D1u2hdB02XKS88FFFSpXWeyYy+2ImWI/9Bphe6gCPYRVUUViNVp6CxBp/caepC2v
         59+4hdiF7gyoCEwcAL5mxDh0a1NrboBpL4p9BCbSInchI0qFpO8a2edipFpsu63pI6EJ
         jaVA4pS7lIMg9V5LU1pU2xeb/fnJkYXBLQBfvRQVSeiLDSTBW/tPoQ9uFb44/R+zsI3l
         V/vrhfng80PdOqif/FPUHclLGpPGWiCoIrGWPwCjWICQPZvD1rVh8G3Ay0FbPEc/eGoI
         eeRXnzqozyuqjMFFqdT0OO3A1VNryqMxQbuG7rnYNLzW5rL3qX1yiQ1h0Rc9PicoVhUu
         Yw/g==
X-Forwarded-Encrypted: i=1; AJvYcCXfTbcwtnEdwhv8o+OJ2jKoQDKwc2QvWZap3ALg2bloQiR+faq0aLhFCziKd/ugfTnuvZ7DF0zs2zagbUGQN/od1wWIE0HgT1EkVpyECdVKPdnuG/8eOWQfvruhVNSUHiGcsMD93xu9EsxDIfypU+yi3JyPQAxRgIJd1i8qxQt7/XaXBA==
X-Gm-Message-State: AOJu0Yw2ayA/0ivlJyQbuOiZgPYkLOCq6USQKIscjaY2S7AVwt5Ia/Vb
	IkPqkD1e5iCwr82pIWs0ajKNCtEg5m3oEPRskVvfWvweBXj1Hq1W7r+5Nn1YsA9f9vpwvNufma8
	OvfiQH/bUhHYQJiJK2ux3bVEjGB0=
X-Google-Smtp-Source: AGHT+IF2c7GJir+XPdRoLTFlUuzDsKkGSNria5acCbGeioFwEyDr0OUN028acb+qeCgAnoaY523IZwylbZbhdOiDrCo=
X-Received: by 2002:a50:9ea5:0:b0:578:6484:24ff with SMTP id
 4fb4d7f45d1cf-57a7a6a29a2mr2227617a12.6.1717505413457; Tue, 04 Jun 2024
 05:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530072113.30410-1-animeshagarwal28@gmail.com> <Zlij+FgY4ul7ZwbA@lizhi-Precision-Tower-5810>
In-Reply-To: <Zlij+FgY4ul7ZwbA@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 4 Jun 2024 15:50:01 +0300
Message-ID: <CAEnQRZBsBOAHiwZDNKyPRinXdEOhdu2dBdGpMrq-e9kWasukSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
To: Frank Li <Frank.li@nxp.com>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:06=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, May 30, 2024 at 12:51:07PM +0530, Animesh Agarwal wrote:
> > Convert the fsl i.MX DMA controller bindings to DT schema
>
> nit: need "." after sentence.
>
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > ---
> >  .../devicetree/bindings/dma/fsl,imx-dma.yaml  | 58 +++++++++++++++++++
> >  .../devicetree/bindings/dma/fsl-imx-dma.txt   | 50 ----------------
> >  2 files changed, 58 insertions(+), 50 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.y=
aml
> >  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.t=
xt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/D=
ocumentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> > new file mode 100644
> > index 000000000000..f36ab5425bdb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/fsl,imx-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Direct Memory Access (DMA) Controller for i.MX
> > +
> > +maintainers:
> > +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> > +
> > +allOf:
> > +  - $ref: dma-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx1-dma
> > +      - fsl,imx21-dma
> > +      - fsl,imx27-dma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      First item should be DMA interrupt, second one is optional and
> > +      should contain DMA Error interrupt.
>
> items:
>   - description: DMA complete interrupt
>   - description: DMA Error interrupt
>
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +  dma-channels:
> > +    const: 16
>
> I think it should be maximum: 16

As Krzysztof pointed out and looking at datasheet and driver implementation=
, we
always use 16 channels. Nothing less or variable.

So const: 16 I think it is correct!

Another, thing. Should we keep both

dma-channels
and
#dma-channels?

I wonder what is the correct way to put #dma-channels

Like this:

#dma-channels:
     deprecated

or

'#dma-channels':
    deprecated


The rest looks good to me.

Thanks for doing this Animesh!


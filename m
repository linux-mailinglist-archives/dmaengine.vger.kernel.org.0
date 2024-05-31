Return-Path: <dmaengine+bounces-2219-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468858D5CCA
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41BAB266E1
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F014F9FA;
	Fri, 31 May 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IViwfX54"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93814F9EE;
	Fri, 31 May 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144553; cv=none; b=pl1kL0OJ9z2uK4Za1srzEdzu9DFb/8sfqAEyRJJdjqkj9n6ITEquNA3AvKTSWkp4SWB3NpsKAemIgavrbSa4cR7tmcxmQlAFyzxVNJ+3NOhD3RCnEhrnH7clEq645n7NaOR0xYFKdEQ+QF1n6t/ZHzR14h/+g27pHvPaWV+uXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144553; c=relaxed/simple;
	bh=xMKqd7o5RmFHMTyNinBae/NjtHab99yOKmQxPflfAoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/rkfSrRc8cXqlHDqWLkG+6e0uXf5d7CW/MorDRsqZjUH9l3kDXhCyuz2KBIQBjhRNysNzelLxoMim3w+r7hJGjAoKZjH7hoTxCP09bVS/6uj7FtTmnKOZJ297yW7jWH0J3tmmrluMgxiZ5V1UYW8cacCzQ4Z7v+O4dP7Gb7qFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IViwfX54; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9c36db8eeso925564b6e.0;
        Fri, 31 May 2024 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717144551; x=1717749351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2juPgxcdbd1hz+pbic7lEAk0l0NWh5iJd6OWt1Xe84=;
        b=IViwfX54Vfm3BupR3Lt63f7aQtVgBtkl9ycnFnzooSAlDVC62P+Dz/2EACXeUqMyO+
         066fpCEZvgEe/922D9XfKeVZPASpg3xx2xp5etoLLad7XMJHvlvxSm8gyRV6ghqEiPyp
         tRQO9HfVg+e59d023jhyXfvNAza9D06sVCR4sNXN8uu0LcOm7rzjNgm+Q5ext/ib/931
         nV57Aet3MF399vD0h0OKn/2V7SH9BfrKZn0vpKcEAPSmGs7DoYEABetD1Tb06/J72SaP
         vDol+k6dLdbuyPpGY4eb+EsIDFULzHvlg8FydYL4UghAUiZztPdQPdKrGpDZ/vywoJv7
         kbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144551; x=1717749351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2juPgxcdbd1hz+pbic7lEAk0l0NWh5iJd6OWt1Xe84=;
        b=xOirA3ESQluoJTyPDtJy14jy6ZN/F+vDOKJhyn2s8/X5j6FTQXLXxCQS3xInjG3ZfB
         6qNl6zbDAph4Cj2bCxrcGMc5ZoJa0WHrcg7YGzyEQbrg8R+oS6c+oaQoThEQFS2rUuAr
         NiXqblHxJ7lh7DxOZ4xZrPFZjb+dk4hN3ygn97m1ApK6UJ2eDg5SCjsripUne6xmpapc
         +8Mx3qVnY3YJalzD/+TKfVMY/rAn+asglohmJqRYqd6Eu86EsdjC+qz/u/I6JqGBlWKv
         gzSkN9zvjBGwmpFdLtqiq+sxtXckWUFAiMSZFJjr2c+d5yYhl7F+MlnBHQ38E106zuey
         uwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy6gQz6a1hmPcnZ1ZMbuofoC9rhMW2Z/6VZi8FJjlTJjXxWGuyZw1B4yXzXe/nP6QGsUTv+BIR0Ij67aXxzBAwgsA8uBzE9FkBAZ2S4aj03JAIx6Y0NgZI1Y78ccr3Y/VFR/78FlnBQV7KKpjfJm/KsAeGIkh+iLVcosJoYuHjQM6eqA==
X-Gm-Message-State: AOJu0YwVbWCPjB3RirNqjE11YHzbJI6RG+/cJKGFUqSOSiVLeU+GwpHo
	U08ojWHoqzT8zODfkcl0hogdQM+q5R2oOLaA48mAXI6oWWYNLCHe73EmqnJKYVYG4tiivdyFvVR
	lqhuSWIgdxH2bmC/Vw7JqKKl4mbI=
X-Google-Smtp-Source: AGHT+IGguiBY/fCegTOROpXSzFRFn41ShgTSJDBrr1ysGdomDhTlH0t/hjN+d285Y3ME7qfLnxr4IPqeGG9eolTrr4M=
X-Received: by 2002:a05:6870:9a14:b0:250:7a43:af02 with SMTP id
 586e51a60fabf-2508be17114mr1195911fac.11.1717144550575; Fri, 31 May 2024
 01:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530072113.30410-1-animeshagarwal28@gmail.com> <Zlij+FgY4ul7ZwbA@lizhi-Precision-Tower-5810>
In-Reply-To: <Zlij+FgY4ul7ZwbA@lizhi-Precision-Tower-5810>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Fri, 31 May 2024 14:05:39 +0530
Message-ID: <CAE3Oz80GUu_aojCqz3DAZEJx=Yo-4mYL-xtdtuN+F_BBeJ3smg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:36=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, May 30, 2024 at 12:51:07PM +0530, Animesh Agarwal wrote:
> > Convert the fsl i.MX DMA controller bindings to DT schema
>
> nit: need "." after sentence.

Sorry for the typo here.

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

I'll add this in v2.
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

Agreed! Changing it for v2.

>
> > +
> > +  dma-requests:
> > +    description: |
> > +      Number of DMA requests supported.
>
> No "|" need here.

Removing this.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dma: dma-controller@10001000 {
>
> needn't label "dma".

Removing this.

>
> > +      compatible =3D "fsl,imx27-dma";
> > +      reg =3D <0x10001000 0x1000>;
> > +      interrupts =3D <32 33>;
> > +      #dma-cells =3D <1>;
> > +      dma-channels =3D <16>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Do=
cumentation/devicetree/bindings/dma/fsl-imx-dma.txt
> > deleted file mode 100644
> > index 1c9929d53727..000000000000
> > --- a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> > +++ /dev/null
> > @@ -1,50 +0,0 @@
> > -* Freescale Direct Memory Access (DMA) Controller for i.MX
> > -
> > -This document will only describe differences to the generic DMA Contro=
ller and
> > -DMA request bindings as described in dma/dma.txt .
> > -
> > -* DMA controller
> > -
> > -Required properties:
> > -- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or =
imx27
> > -- reg : Should contain DMA registers location and length
> > -- interrupts : First item should be DMA interrupt, second one is optio=
nal and
> > -    should contain DMA Error interrupt
> > -- #dma-cells : Has to be 1. imx-dma does not support anything else.
> > -
> > -Optional properties:
> > -- dma-channels : Number of DMA channels supported. Should be 16.
> > -- #dma-channels : deprecated
> > -- dma-requests : Number of DMA requests supported.
> > -- #dma-requests : deprecated
> > -
> > -Example:
> > -
> > -     dma: dma@10001000 {
> > -             compatible =3D "fsl,imx27-dma";
> > -             reg =3D <0x10001000 0x1000>;
> > -             interrupts =3D <32 33>;
> > -             #dma-cells =3D <1>;
> > -             dma-channels =3D <16>;
> > -     };
> > -
> > -
> > -* DMA client
> > -
> > -Clients have to specify the DMA requests with phandles in a list.
> > -
> > -Required properties:
> > -- dmas: List of one or more DMA request specifiers. One DMA request sp=
ecifier
> > -    consists of a phandle to the DMA controller followed by the intege=
r
> > -    specifying the request line.
> > -- dma-names: List of string identifiers for the DMA requests. For the =
correct
> > -    names, have a look at the specific client driver.
> > -
> > -Example:
> > -
> > -     sdhci1: sdhci@10013000 {
> > -             ...
> > -             dmas =3D <&dma 7>;
> > -             dma-names =3D "rx-tx";
> > -             ...
> > -     };
> > --
> > 2.45.1
> >


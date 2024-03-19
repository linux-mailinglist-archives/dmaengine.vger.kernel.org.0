Return-Path: <dmaengine+bounces-1444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177987F9CF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57321C21B89
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7D7C6E9;
	Tue, 19 Mar 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE3LpN2/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9E7C08E;
	Tue, 19 Mar 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836955; cv=none; b=PuPNkdzn34LCcZeF0SXzQpJ75oMzmFCqj7PaAE0WEexxl3NVPqN2g8Y9koVd7zN472oSZwb1AH9P70pOmzqrz6MVZa0CNQMFK9AsfMf5ejiOl0d/BFZ3sNYZd+gHd/UKKNNF6laWZ7ilDJPzxOaiDXY85XjAC69lcSuNI+n/ioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836955; c=relaxed/simple;
	bh=rVF9H8p5A/tZCcUzg90IMGb1EulK+WvD39yZtuREOCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHovoFAQQAEJ3HL3L/H9mk9a+QPvq5T7pbyNZZBB/sG1RkCkOzXiqls2OGnNdCEOs7nPV1qC90uZMSSsA8xpwOKeqFNw2VVuhMBdL5kxQez+lr3hTo7RuDBgFLFfLIr6kk5Mk828MqJ3K6XevZ6Z9FDgA85a/pH66kkcCQxGd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE3LpN2/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so7717949a12.0;
        Tue, 19 Mar 2024 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710836952; x=1711441752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+caFpiF1NE9VjCHjmW6BZDvqMJLVV4nvdJHe6aB/9w=;
        b=cE3LpN2/GMOpGdvs+lXMV+/pVld0OiUT795aLQnqV29mzUD1emWLleOd4Sh9XbZpkG
         sfDma3OKiBD8qVukQaWKp/hEbgT/nWUiaAms7rospyf7rgghz8rx9oUYwolBvK0Re+59
         TlLhq35i6D8ygOt4wnYaPJkc5un4K9ozJ5ovAVu7EjW7o3Bji4fbzNFwmjadJt77qlCx
         ICt1UhGWSg8xm+ThO670FWVa5MVUd3a/A74DwVvO+BE8vqW/qrKEPYBkY+KHxB2d90i7
         PHlphRw93c5gSBCauOE+oylBG3Dta26vWmQOCZjAoOqDyT2FWCrFMVcF4BV9jO+fXlAd
         0zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836952; x=1711441752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+caFpiF1NE9VjCHjmW6BZDvqMJLVV4nvdJHe6aB/9w=;
        b=Kmweg7FJPiz6kbZmviLmaaZsJwiglloK9v4qRHlefvH+5SCROb/TuI3kS5JHZRSO3B
         OFaSk4ih4+bHx7aP8XQHndAlfT2BRBBBjj+GlNl1RN7zm31pzcPrjq9/fhx1NqW4kbJf
         4KY19CStfclaxjkmgaKncHOEDh0DIKTnjpx+YU/GjScTK0uzwPObIcizHUeiTNhjgPkM
         IHjp/BOJX04bB9XiW3wlKuw4MT7VJwzO1vqMaq1bMBmockkahM01MOnCuXQD4AN0blNh
         nPRiaqoJfedyAQi+4qLbAeGgXZAFmBCKCrzSK1P6xOkpr42v1ihFsCQ5vocTKDGEDnv8
         Rftg==
X-Forwarded-Encrypted: i=1; AJvYcCUYjE76bAnfKVx+YiAT/i2+++OQbdq3iWuyIPF77/yFYptKD3EXS9jEK45hiBvBfzIyvriMoWJHt0uPhE2knTmIWh/VzlgiyY4P0R3iPfgnTNOISbfzpgPvsurStk8H+xZ+SzeFDZK1ctmfDN4xk8LaW70NQla+Ma1Q+9c+sI1OxWA8KRWjgrOZVtflYo8P0BVu0CAX4qbBxre4RSdiB1k=
X-Gm-Message-State: AOJu0YycfI4gVkc8yZl5Xi5m//o2tYlZASSjgwcNfgDducsOfaFAhg7a
	h1b/Yv3KIgpDfpP5QTSXGv4CEm4abTctyEGCyx2ttU+AssNFaIJEyMDci83x7pGAzfUn9toW+4q
	hY8C1gxHG7ENPbXUsEDAbKibfHOk=
X-Google-Smtp-Source: AGHT+IENQGSo2CY36rseL4WEmz3mPXsVW0fWojGGC/2UdA9byb37TJLO4V6lJIqrbscjz/c+UmnsE5alQVGx2i6us3s=
X-Received: by 2002:a05:6402:320d:b0:56b:9ef8:f656 with SMTP id
 g13-20020a056402320d00b0056b9ef8f656mr149159eda.7.1710836951986; Tue, 19 Mar
 2024 01:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com> <20240317-exorcist-spectator-90f5acb3fe2a@spud>
 <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com>
In-Reply-To: <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 19 Mar 2024 16:28:35 +0800
Message-ID: <CAJhJPsXzGjD43nj7eLPSmtDLgp1FCvzJFRJDDTY=9Uq_Dc8Qdg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:18=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> On Sun, Mar 17, 2024 at 10:40=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Sat, Mar 16, 2024 at 07:33:53PM +0800, Keguang Zhang via B4 Relay wr=
ote:
> > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > > Add devicetree binding document for Loongson-1 DMA.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > V5 -> V6:
> > >    Change the compatible to the fallback
> > >    Some minor fixes
> > > V4 -> V5:
> > >    A newly added patch
> > > ---
> > >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++++=
++++++++++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.=
yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > new file mode 100644
> > > index 000000000000..06358df725c6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-1 DMA Controller
> > > +
> > > +maintainers:
> > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > +
> > > +description:
> > > +  Loongson-1 DMA controller provides 3 independent channels for
> > > +  peripherals such as NAND and AC97.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: loongson,ls1b-dma
> > > +      - items:
> > > +          - enum:
> > > +              - loongson,ls1c-dma
> > > +          - const: loongson,ls1b-dma
> >
> > Aren't there several more devices in this family? Do they not have DMA
> > controllers?
> >
> You are right. Loongson1 is a SoC family.
> However, only 1A/1B/1C have DMA controller.
>
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description: Each channel has a dedicated interrupt line.
> > > +    minItems: 1
> > > +    maxItems: 3
> >
> > Is this number not fixed for each SoC?
> >
> Yes. Actually, it's fixed for the whole family.
>
> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    items:
> > > +      - pattern: ch0
> > > +      - pattern: ch1
> > > +      - pattern: ch2
> >
> > Why have you made these a pattern? There's no regex being used here at
> > all.
> >
> Will change items to the following regex.
>   interrupt-names:
>     minItems: 1
>     items:
>       - pattern: "^ch[0-2]$"
>
Sorry. This pattern fails in dt_binding_check.
Will use const instead of pattern.
  interrupt-names:
   items:
     - const: ch0
     - const: ch1
     - const: ch2


> Thanks!
>
> > Cheers,
> > Cono4.
>
>
>
> --
> Best regards,
>
> Keguang Zhang



--
Best regards,

Keguang Zhang


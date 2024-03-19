Return-Path: <dmaengine+bounces-1434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2587F555
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 03:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B476A1F21DD9
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF864CE6;
	Tue, 19 Mar 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZFjJ969"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A075657A0;
	Tue, 19 Mar 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814659; cv=none; b=mrhsrQXh8uvL0iF59tbYVuKsAbsH/je8raN9/Yh4QsADuOXAVgtq19pGImuHrluvmUvfcCsv2zCfbdyh1to8ftBujtHzouQtxgZ/KIveea5g2vJJnV5UYWPa9B+WQsvN9Vfgnx6uDaMOqIh3T2DVCYuEBbt08w9qRtQM8T/lCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814659; c=relaxed/simple;
	bh=CsG3vmxbvFtQ7kIVlmN4FWQj2lM1tpF+IhDqH5t4bhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmYlz3NXRxgCXxbpPpPyXJNsbld10hPzTsFxg2pbMecVZLcthphggDvSGZc/gZH4hGECzOY9pCGheHu4HJFSNANqzNCNVNgaLwYUfcjprWf1OE9/BFXtQAoxfCUiJF1UMegbphxHv5h5Qgqbjq7+BX1CpxqjN8bkg7z+0bKZ36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZFjJ969; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b95efd37fso139999a12.0;
        Mon, 18 Mar 2024 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710814656; x=1711419456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06RPO2L6a0D0jVlzae2rRfq/gkYIWURzVjCd+HP4+0E=;
        b=KZFjJ969KLoF+Fo7KMcYjYfpBk/3EYivKCa82GXPi+UO4yhOnPOYHBGN7V26gTnbGa
         gkT5Y2zIpMwdE6Wu4GVg1rSkUJxDBV6fsfwaIbw4Z01H/U672NrCjXN91scd0g3MCTDw
         XQrGMIJvmtfZotVVOLN+/nyH1BatuEdd1/HS89cKPH7idIzz275GORL7YAHLu9Vba4RM
         wOsa+DTm/XTOH+33p4tM4/IMptrORoRKjT9JD8JePI0Lp2XLtbkBU4N4irV6pT3xT5rt
         RzUagQh+rzWlgMKXLJLzCvtmCZKpsyYJ9c+6ascDTfjJYNO+Wz+1NUBuqqbtjo24BDtC
         jp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814656; x=1711419456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06RPO2L6a0D0jVlzae2rRfq/gkYIWURzVjCd+HP4+0E=;
        b=BD5wcDvDGYRNA98Px4JxxfDqSahy5QuENOGd50jz+3y6zTkrygtRK5JAwj27nqb0AH
         0saANWjKedWA5xhjZ4jhif8dFUwaWdiCLOSBkLxworf9Gwl3T8hKrdeJB56vb1usxaRW
         5o9Lq90X8Q+upnZcxSsLyj9aua95jElCHR6yJ2F80pE/5Prj2L7yBmnG53xGR+fWgNFa
         CE/hnPLJsznHfHmgTfguh8Hawm3/GG2yysIa8fpTRzWL+cp4H4LYeF+NGtIb2E1NO989
         74yjWRC350qpwkSkzeWq5JeO873nSQIUmE9jAm3QKDpn7IRs7eI3vEILp9HliHaLkGQ8
         VUTg==
X-Forwarded-Encrypted: i=1; AJvYcCWYLyNqSSx6N4cYffoYTMUheOEgZkhulfqv47GXKVV5FAEH0rwt1ZW95iZIjzZuX58woln7SfuxmTUxL7EdLwX/uG+yA/+bLkTppqTp6RxLHwAiV/7x6omERfgNJHdPa5YKDbOFHU9JfsKJEY/OC4hQm8TCbK/NHOQIaADUlVRGe0pHMQyCC2UVe651beaWuTfcALjSbI7hFZvQTXCWTas=
X-Gm-Message-State: AOJu0YxdwxmW7hcINXt+KimKQRcSXY9jEIQ7sH/JHHSCm/72qA4AmcHN
	RjIGZKk+8nmLbGLqLrAWblln/oYzaecpW+GKR8n25cHjJjvjivVkXTZvlHZQLzGyZeVZoJaxgm+
	QfULUh+quc8xyq6ajBJCkPHjzXF8=
X-Google-Smtp-Source: AGHT+IET5BfyyNn1yIQVOKCdlTrCvipy5TXQyXfXWXQ9ccwDlBn7aPQxcrAA+CMVqApdHTsfUVr56tWGv+GC7gfYxSY=
X-Received: by 2002:a50:cd87:0:b0:564:f6d5:f291 with SMTP id
 p7-20020a50cd87000000b00564f6d5f291mr8897173edi.34.1710814655306; Mon, 18 Mar
 2024 19:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com> <20240317-exorcist-spectator-90f5acb3fe2a@spud>
 <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com> <20240318-value-snide-8733098b9e76@spud>
In-Reply-To: <20240318-value-snide-8733098b9e76@spud>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 19 Mar 2024 10:16:59 +0800
Message-ID: <CAJhJPsWRoNaSeYs1DjSreriV6V7TgdkktQNWgs=HsNKBAiCpxw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:29=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Mar 18, 2024 at 02:18:27PM +0800, Keguang Zhang wrote:
> > On Sun, Mar 17, 2024 at 10:40=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Sat, Mar 16, 2024 at 07:33:53PM +0800, Keguang Zhang via B4 Relay =
wrote:
> > > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > > >
> > > > Add devicetree binding document for Loongson-1 DMA.
> > > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > > V5 -> V6:
> > > >    Change the compatible to the fallback
> > > >    Some minor fixes
> > > > V4 -> V5:
> > > >    A newly added patch
> > > > ---
> > > >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++=
++++++++++++
> > > >  1 file changed, 66 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dm=
a.yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > > new file mode 100644
> > > > index 000000000000..06358df725c6
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > > @@ -0,0 +1,66 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Loongson-1 DMA Controller
> > > > +
> > > > +maintainers:
> > > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > > +
> > > > +description:
> > > > +  Loongson-1 DMA controller provides 3 independent channels for
> > > > +  peripherals such as NAND and AC97.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - const: loongson,ls1b-dma
> > > > +      - items:
> > > > +          - enum:
> > > > +              - loongson,ls1c-dma
> > > > +          - const: loongson,ls1b-dma
> > >
> > > Aren't there several more devices in this family? Do they not have DM=
A
> > > controllers?
> > >
> > You are right. Loongson1 is a SoC family.
> > However, only 1A/1B/1C have DMA controller.
>
> You're missing the 1A then.
>
Will add 1A.

> >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    description: Each channel has a dedicated interrupt line.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > >
> > > Is this number not fixed for each SoC?
> > >
> > Yes. Actually, it's fixed for the whole family.
>
> Then why do you have minItems: 1? Are there multiple DMA controllers
> on each SoC that only make use of a subset of the possible channels?
>
All channels are available on each SoC.
Sorry, I will remove the minItems.

Thanks for your review!

> > > > +  interrupt-names:
> > > > +    minItems: 1
> > > > +    items:
> > > > +      - pattern: ch0
> > > > +      - pattern: ch1
> > > > +      - pattern: ch2
> > >
> > > Why have you made these a pattern? There's no regex being used here a=
t
> > > all.
> > >
> > Will change items to the following regex.
> >   interrupt-names:
> >     minItems: 1
> >     items:
> >       - pattern: "^ch[0-2]$"
>


--=20
Best regards,

Keguang Zhang


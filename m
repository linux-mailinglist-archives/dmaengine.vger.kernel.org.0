Return-Path: <dmaengine+bounces-1401-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00E87E3A8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC2F1F21708
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91622094;
	Mon, 18 Mar 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWRVEGTe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38322F0E;
	Mon, 18 Mar 2024 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742748; cv=none; b=qRFDMblqd73d16YKQ2AmlWAjYY9YJtkLCigrIA5V3XfTqi8qB3UUi4lTYi4xvrGIQ8QdnsTS8Ana+u83sK+oh8N179EmqOnoQQeaQB2GOzjC+YE+XFgz13gqKzn3Iw6mbKKeJi5ZaSJ6xg2xipMj+j7k7fPcvpQtj5EXAmtxflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742748; c=relaxed/simple;
	bh=3UOolR8JHoqKDwxkh3gJR0lNhSxsx84z8zqGpiIaiuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxd9UzASns0T3RPFAodAGs2n+dngATTmUohmUONXzXxj/nvO3CCoEwiXJp0FPo1uTaHJObpoy3Ih+TxEGureEYZ7cVx4FVccrAB4i0/Lwy2B8jVngLsskmh3q7TpOWZxY5/HjZ/N7QV+henOQGiJnGfKq0XJ2OlBo+Gh3KiQgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWRVEGTe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56a9f5694dcso338162a12.1;
        Sun, 17 Mar 2024 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710742745; x=1711347545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ucpTK5ikX0YK4SSOnWQlhYk2l25hLLVmLN0L3ZgMDk=;
        b=YWRVEGTeBuRaRas8cWKaokjXBPLecmqD7D2ORlzfoLew9qo209NHq30BGII4JH4tGg
         dWAOG0r8an90AkIfLImccY94cBUnFduLh9AypbB85Hl7rSSWd8ZVV8+yUH5axJNDSSRO
         BniLy13CuXrDpynhv9EQ1Fa9CKNklyiAY8QMbzvXzNpeGnhCLuaQdm8bmsL4CQmIZEu8
         Vz8oLqReOAX7SmM0w+OCSJLHtn4ST8AXXMgmOQ7NPMhYDJakZOfTBuRSjVAj9XI/PyRg
         P/QOjN7yPWEA3PaD7/cpFAYAgCENXUP1aZwS9mBaN5/xdCbNv9OMkUwEroHVcH0+7D+F
         8jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710742745; x=1711347545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ucpTK5ikX0YK4SSOnWQlhYk2l25hLLVmLN0L3ZgMDk=;
        b=GIgJAAFnhNLGXe1JzZ0N+9dHVB9S3WKyPR1DS1EO4cEfy7HwpfyxBr47xjWqY3TjW0
         m0pDUrcam1Tyf1WUSpVq6JeMAfl7/qgUlS6KPx/AaEsSN27NNRcgjkOeF3YGjCAhyX4b
         DfJER2a64JI3p/gE3hmS+h6xGRRAXGgvQSeU1WICp+BTX4OuJx7S2+1Qr+Z6yPaxXjJg
         MIRcebpdmIF126drNstYdQNB/t/95WsXdwMfYuM5/FgC/CY/mfZFkcAo+nLkD63kUUr0
         YWG3eH2pBZnRfQ34kT1f7yb220K5B4pn5ZXMwPAHVG47RfKJqKvFQWpVfhf7w+RiBTgF
         TB0A==
X-Forwarded-Encrypted: i=1; AJvYcCVs2Yrr7KchQCKLoko/Eo8eRsUwACPQC+iPnPbpJAMvG9kDZLLMHBZBRq9Ioe5MZ1n+tlmqVZARiZ/+2qALSIj5S1eOkp3khWXYHpDUvw78ikgHeOKc/3MwLK1RM5k4tRvb6LkFABpveHp+02tZAtu2h4rUXc1W3Y3xJDIvKVLYBHIvQ7FhV1pK13qJZtTCqgJFb15qSlnSSz9Xp9XUMq4=
X-Gm-Message-State: AOJu0YwBASIg5p/N0KJ99hcPXJj4B1o1IDcIfGYSL3skjJAL3GF8Fmv9
	pq1J6Oec0VFsQGS5F25zYDJuuf47htGb1FO1KlZXmcM8TPm4rl6hTnNKUVXRRuyDheCAbiCkagA
	jlbYdJxJVqIEDo7RuKAi5GtgTqvc=
X-Google-Smtp-Source: AGHT+IGFZlEfND0/QEzYxEFBqsH8cbQPNzEwsHVBGJzBi3UPQPHMyjSKJX6kHW5eCvCzP4I8Ci/M3MkVq0y3iCfhWW4=
X-Received: by 2002:a05:6402:528a:b0:569:a0e9:3409 with SMTP id
 en10-20020a056402528a00b00569a0e93409mr981538edb.41.1710742744931; Sun, 17
 Mar 2024 23:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com> <20240317-exorcist-spectator-90f5acb3fe2a@spud>
In-Reply-To: <20240317-exorcist-spectator-90f5acb3fe2a@spud>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 18 Mar 2024 14:18:27 +0800
Message-ID: <CAJhJPsWOUZsWFvreRrPqQHAjYW7uRT31THHi7CRDN46+nHpL9g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:40=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Mar 16, 2024 at 07:33:53PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > Add devicetree binding document for Loongson-1 DMA.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V5 -> V6:
> >    Change the compatible to the fallback
> >    Some minor fixes
> > V4 -> V5:
> >    A newly added patch
> > ---
> >  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++++++=
++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.ya=
ml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > new file mode 100644
> > index 000000000000..06358df725c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 DMA Controller
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +description:
> > +  Loongson-1 DMA controller provides 3 independent channels for
> > +  peripherals such as NAND and AC97.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: loongson,ls1b-dma
> > +      - items:
> > +          - enum:
> > +              - loongson,ls1c-dma
> > +          - const: loongson,ls1b-dma
>
> Aren't there several more devices in this family? Do they not have DMA
> controllers?
>
You are right. Loongson1 is a SoC family.
However, only 1A/1B/1C have DMA controller.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: Each channel has a dedicated interrupt line.
> > +    minItems: 1
> > +    maxItems: 3
>
> Is this number not fixed for each SoC?
>
Yes. Actually, it's fixed for the whole family.

> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - pattern: ch0
> > +      - pattern: ch1
> > +      - pattern: ch2
>
> Why have you made these a pattern? There's no regex being used here at
> all.
>
Will change items to the following regex.
  interrupt-names:
    minItems: 1
    items:
      - pattern: "^ch[0-2]$"

Thanks!

> Cheers,
> Cono4.



--=20
Best regards,

Keguang Zhang


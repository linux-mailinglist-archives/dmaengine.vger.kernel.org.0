Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBECF7BC4DD
	for <lists+dmaengine@lfdr.de>; Sat,  7 Oct 2023 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjJGFqE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Oct 2023 01:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjJGFqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Oct 2023 01:46:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1FBCE;
        Fri,  6 Oct 2023 22:46:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so8544548a12.0;
        Fri, 06 Oct 2023 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696657560; x=1697262360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28EjpLmU0JWs2tbhhlyKo79n+tgLbbY2JqMG52GJQ54=;
        b=miRvuiJoENJ4V7Fe7L9sWH6yGQL4+pg3bkDHHFXYqzSvGjJ0i8i8hqhQ1M/tc6c0tV
         Um1NnEUBnZY6Uy0sYHIpdneK/3uq8D7qHgjQNBMukHg0ua/6rKlO5akPziPPKLetRnGI
         HlLDy4wa4Lj3ijLoH4qHatOptXmP68fu1RPbYgR1Y/YYOO9/sMFPMxaxv79g02WNW2tf
         SCqnwh+aCc3pL4NFmfoem222Lsu4MmBtovlRrs/FMVUxEwqgmjUMZNdJyW5CBECYeVoH
         ZeJLkKzUft+J8oj8STMYWmggRSRE+B2HN5xP7MaCvVXqVt50W3r53aIwdtFuF6l2TsBo
         niXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696657560; x=1697262360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28EjpLmU0JWs2tbhhlyKo79n+tgLbbY2JqMG52GJQ54=;
        b=ohQ5jy2xrrGUouhDcUF53l0ivdkfOc/DHrj+Po/O3or/gxZNCgxTayU7ju2XYNw0rW
         6ICBu4wpHlZE8F7WgRsIw6iJ0FaVA4jcAndV3dmcw8nFJJmG9ejOA2WPsZOWRMMWCBDA
         N8KTgak3pMPcAwLhKFFIaLsiga5NiSjgiK7LeBuqXCl99ucXW7zy2jFJZ56/Y6lZud/W
         C/s/aoEbZUcqKKJxv5/WdbPqwDAt4IhAiqFjchexNlsJ3fu344xgKYs4Y2isiwQDu75z
         tYqnypIFy2c22WwWaODvSPu/ybA+gAmiDqNBw88Y++QbJI8VnoOBTGUuzE1iPweEhWk4
         iVZg==
X-Gm-Message-State: AOJu0YxSQMkEOGNGq9/oYftt4pQy3e87mhr9KZCtv+1tltVi4Mce9aMz
        EeL/86smdA2yGhn2HWcZaDtp2soKejDC+17+5SQ=
X-Google-Smtp-Source: AGHT+IHA1HYlOdi0Ar0nVTg3qzB6qyPAJjYJ5cjJZ4myeP9TeqvaMuNZzH5/0lvmk/KejpjH6VQOfxGwT4eTR2oTKJE=
X-Received: by 2002:a05:6402:35ca:b0:52e:3ce8:e333 with SMTP id
 z10-20020a05640235ca00b0052e3ce8e333mr5474640edc.18.1696657559662; Fri, 06
 Oct 2023 22:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
 <20230928121953.524608-2-keguang.zhang@gmail.com> <20230928-capacity-husked-305f03680834@spud>
In-Reply-To: <20230928-capacity-husked-305f03680834@spud>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Sat, 7 Oct 2023 13:45:23 +0800
Message-ID: <CAJhJPsVT371gPN++UNK-cggb8uVxWqpJAoEbFGV8+syxfvnGAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add Loongson-1 DMA
To:     Conor Dooley <conor@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 29, 2023 at 12:42=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey,
>
> On Thu, Sep 28, 2023 at 08:19:52PM +0800, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 DMA.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V4 -> V5:
> >    A newly added patch
> >
> >  .../bindings/dma/loongson,ls1x-dma.yaml       | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x=
-dma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.ya=
ml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > new file mode 100644
> > index 000000000000..51b45d998a58
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > @@ -0,0 +1,64 @@
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
> > +description: |
>
> This | isn't required as you have no formatting to preserve here.
>
Will remove '|'.

> > +  Loongson-1 DMA controller provides 3 independent channels for
> > +  peripherals such as NAND and AC97.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - loongson,ls1b-dma
> > +      - loongson,ls1c-dma
>
> From a skim of the driver, these two devices seem to be compatible,
> and therefore one should fall back to the other.
>
Got it. How about changing to one const?
  compatible:
    const: loongson,ls1-dma

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: Each channel has a dedicated interrupt line.
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - pattern: ch0
> > +      - pattern: ch1
> > +      - pattern: ch2
> > +
> > +  '#dma-cells':
> > +    description: The single cell represents the channel index.
>
> This description is unnecessary.
>
Will delete the description.

> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - '#dma-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    dma: dma-controller@1fd01160 {
>
> This label is unused.
>
Will delete the lablel.

> > +        compatible =3D "loongson,ls1b-dma";
> > +        reg =3D <0x1fd01160 0x18>;
> > +
> > +        interrupt-parent =3D <&intc0>;
> > +        interrupts =3D <13 IRQ_TYPE_EDGE_RISING>,
> > +                  <14 IRQ_TYPE_EDGE_RISING>,
> > +                  <15 IRQ_TYPE_EDGE_RISING>;
>
> Odd mixed indentation here. Bindings use spaces only.
>
Will fix the indentation.

> Thanks,
> Conor.
>
> > +        interrupt-names =3D "ch0", "ch1", "ch2";
> > +
> > +        #dma-cells =3D <1>;
> > +    };
> > --
> > 2.39.2
> >



--
Best regards,

Keguang Zhang

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935ADA7B87
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfIDGTA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 02:19:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDGTA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Sep 2019 02:19:00 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so41578470iog.13;
        Tue, 03 Sep 2019 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsBF1dQsIvTEdVXFaueG4wdJlmUypORqD6GvIQNikE0=;
        b=g4HZH/NS+4MfDVTP4D/xX0doMFNKP1flWdbGufYwEDn3zHRdCxceO5cGBjPs9ifQI6
         qJG/K7b1CI3NwaWZkAkeBbKZkoxKGEVfCvFHC2IjtbBEvxESd+px28MwpK45dMxhoUDI
         2sToxJZhS6h682DFVE9YfR6xwpROPJly2bvFQ7CRQ1H8PYFnVAX83FHxY8sBUqCSSTOF
         o9/X5JE5YPboEKk2o8YFlhJySlCS0Gy/zH2gT6zT8f0epOdBcmH/HyA80N2IgS/W6sNu
         RHbz+k+HWTTQZQHkGJwOx8PJ+zstdtbl0MmNm7TfV5oi0kR3SubVDXwnDBtW4ws7yOP/
         RB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsBF1dQsIvTEdVXFaueG4wdJlmUypORqD6GvIQNikE0=;
        b=A3BBG5PUTSr4AOsrPDQqSwFmUx+SY6BSLJt8q04zYOdssL+tb/iQ/9KpCAipRwjOyh
         MDIu63yByZCKja5FX1/rr15H+/QtqNNOLN1fwurUKr1CHjUnrSDif0J4V+9ZKVLQ6trG
         wDagCoPK7UJ62u1E+pPvWdonTQJhWhCNG9xX6YUr7/DHBVzu5O3m0itLlpXScFaq/ooz
         2WnMnHP5Lpae5eCLqxcui8s4Yh9oqn3p272kO2l3W9YKXN4WE94Tl4D3Vr/SMFidZAV7
         NM8MPQ/6u/XsLZtBGz740BWHCxY6k5/hosldxkHdxrBMK5Gtemj50DadxahroY7I0v25
         AGXQ==
X-Gm-Message-State: APjAAAUxvPpJosA5QRcgY5epBz5hSRaMfYZUgoHC3YPbgmAwTO6mepo/
        SoQPHMYIviwWbHjLZ2ZXe/bWMU8ZZeIwKRJXkhQ=
X-Google-Smtp-Source: APXvYqxBHegpJH9h6BKXc+D5BhjsNhQ1QdtP62zH71vPMmQKuZz6qskjwLZSVJ790/0C762HDrly44uC5h+c2qit/5Y=
X-Received: by 2002:a5d:9591:: with SMTP id a17mr18209960ioo.303.1567577939643;
 Tue, 03 Sep 2019 23:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190818051647.17475-1-jassisinghbrar@gmail.com>
 <20190818051754.17548-1-jassisinghbrar@gmail.com> <20190904055037.GC2672@vkoul-mobl>
In-Reply-To: <20190904055037.GC2672@vkoul-mobl>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 4 Sep 2019 01:18:48 -0500
Message-ID: <CABb+yY1RT2TuUyuU2C+m6w=AOVzXkuG7cOwbWsccywxU7HwkQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 4, 2019 at 12:51 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 18-08-19, 00:17, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Document the devicetree bindings for Socionext Milbeaut HDMAC
> > controller. Controller has upto 8 floating channels, that need
> > a predefined slave-id to work from a set of slaves.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > new file mode 100644
> > index 000000000000..f0960724f1c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> > @@ -0,0 +1,32 @@
> > +* Milbeaut AHB DMA Controller
> > +
> > +Milbeaut AHB DMA controller has transfer capability bellow.
>
> s/bellow/below:
>
> > + - device to memory transfer
> > + - memory to device transfer
> > +
> > +Required property:
> > +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> > +- reg:              Should contain DMA registers location and length.
> > +- interrupts:       Should contain all of the per-channel DMA interrupts.
> > +                     Number of channels is configurable - 2, 4 or 8, so
> > +                     the number of interrupts specfied should be {2,4,8}.
>
> s/specfied/specified
>
Hi Vinod,
  Do you want me to spin yet another revision for the two types in text?

thnx

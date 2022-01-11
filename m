Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4245648A55E
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jan 2022 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbiAKB5D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 20:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbiAKB5C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 20:57:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4FC06173F
        for <dmaengine@vger.kernel.org>; Mon, 10 Jan 2022 17:56:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so51087063lfk.1
        for <dmaengine@vger.kernel.org>; Mon, 10 Jan 2022 17:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tezxY2J06qhj7ov7742qW1p6EILBDEbMRTBUVeQPkvo=;
        b=buCvymbn8/qQJdU8bjvND2DQ21cgq5eCD6EU/xlyXOirMVhyD8bmJNLG7SO20LjLa+
         kxl+6Oc/q6NqZbLRk95NMCHkXOaAgreCkl/EoML1qCcIlK8L9MZK/9quEN5n726JDmRA
         LANIBuHAbucgweYbvAr1kDzt09xwsubl7LrqhSxenMnXvfCOt9y1gbRnx05K1G+USBNJ
         DbFPFiAMblWbhWo3UE+QeHZzEwU519n1kF471TZ1Dwl/duIPnUa3whZzHExWTSUvTC7L
         aTpsA7ViXESqUf+5xCsQIhFm3JETYA8SvftBHWdTGGs0y2qL66/IlaqEy9zqAjS7J2m4
         Rjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tezxY2J06qhj7ov7742qW1p6EILBDEbMRTBUVeQPkvo=;
        b=O4T82jcqOZpWez3fMvthJg6Li4QTGFxVFsYOIErH8DwtQh2qb/Dfc1Edodg/7efkDF
         fmIP8+v4K5mZmrn3OHDDakAF9YmTiJc3AOYebvwKk1NiYkyMszDVY9WHJsjzcU51sZTQ
         9PX+QeVHFo6o58NO9jCCXf8ASgcuPXQGvTtt05YTfBjt12UYADRP6Em7ycHbuqHHwHXg
         49zbDP+3ETr7pAoUSa4+Gi+pQ1Tr0e0WktPm1JI6Zj3Nfo01wLE6iNAHmWWH0loLqaoz
         YqJiJCjmtb9cpyccWNyGh7T3A6M+wbV1o7SsHCVdMYBh7+oCaMh/M5H1nReisHWt5jO7
         R5tA==
X-Gm-Message-State: AOAM531RDc4heE5fJHVyzHmIedTs/fA6nqk0Cdkxgn+f/iIphzW0CZYj
        w5QLFFS91QhHr0gjq6yuuspKzuJ9LYndwJezzUhYSA==
X-Google-Smtp-Source: ABdhPJyYj1U9xCeV1tG6jxMxA24J+Bqp8dsehDAUbfCEY4gC63Hr3XQfMqUzDBAVXliFyH+P/Eil7hBWTmWek2HHg/4=
X-Received: by 2002:a05:6512:260a:: with SMTP id bt10mr1754644lfb.223.1641866216357;
 Mon, 10 Jan 2022 17:56:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641289490.git.zong.li@sifive.com> <0419b2865c87f72adeb4edee9113a959e468b4a5.1641289490.git.zong.li@sifive.com>
 <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
In-Reply-To: <CAMuHMdUyYVBXAeJ8XS9OsUePpFLgpCXYT5rH_bJCvCg3eaav_w@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 11 Jan 2022 09:56:45 +0800
Message-ID: <CANXhq0psEs0X=w6n4_HA5P3bWWac00byGQ4CaivJSBPZMjgwdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: Add dma-channels for pdma device node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 10, 2022 at 5:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Zong,
>
> On Wed, Jan 5, 2022 at 6:44 AM Zong Li <zong.li@sifive.com> wrote:
> > Add dma-channels property, then we can determine how many channels there
> > by device tree, rather than statically defines it in PDMA driver
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > @@ -34,12 +34,17 @@ properties:
> >      minItems: 1
> >      maxItems: 8
> >
> > +  dma-channels:
> > +    minimum: 1
> > +    maximum: 4
>
> As per my comment on [PATCH 3/3], perhaps you want to use a default
> value of 4, and document that here, too?
>

Thanks for your reminder, it should be modified as well. I would
change it and add a description in the next version.

> > +
> >    '#dma-cells':
> >      const: 1
> >
> >  required:
> >    - compatible
> >    - reg
> > +  - dma-channels
> >    - interrupts
> >    - '#dma-cells'
> >
>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

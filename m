Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEC4CBB4F
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiCCK0w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 05:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCCK0v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 05:26:51 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A6175869;
        Thu,  3 Mar 2022 02:26:06 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id v62so71521vsv.1;
        Thu, 03 Mar 2022 02:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqANOVEBE1ifRQMdow3CTMTDQ7ypFtiFbef3UWAqnWI=;
        b=xzabRn09srUS5kbVEw7zxeR0a3KoD8Eyv0hKoXeS0rrUS0rG7PbmReyJxCo5Na8TTh
         QXLI6PG319PlE6fMIHyq+ZLGX5Q7IJqiDyDoBEylfmc7534ZNfGPF9UccOewfrZVjawc
         8X+Yg63wrOP2/SWonJuaJj1xaHz7ySiO4dcUG1ilBTVNSZSThed7WTHAdsMn6f9RqEsS
         hi5+gv1g+9EOAL1K62VsCmsLmHoiDANI8w0VRE9gCQ/f7UunBVb3ECwzT3iAVGzANXAt
         SnghLPxI8dHohoy7rNFmU16Oo4uYjz3CD8YrqRbDNI7wT3XzcOQfd3HwJrd+x6MwTlhO
         XPrA==
X-Gm-Message-State: AOAM533yRGz7vySo/dUKnKbZ2BZQwryjFrWuKloJtZMFWNNoXfnA/7Ql
        fpzaEnj5K1kWh/axbgJz7Dc7rDfXqqLA9Q==
X-Google-Smtp-Source: ABdhPJyKTFQeQTKO8YkaQvAmt2Shihd8mdIaRedCbLAlKPzxVFP88y1Ijn+XhKlvanKki4tBY5WmBQ==
X-Received: by 2002:a05:6102:453:b0:320:5e2a:d9db with SMTP id e19-20020a056102045300b003205e2ad9dbmr2322448vsq.14.1646303165767;
        Thu, 03 Mar 2022 02:26:05 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 106-20020ab003f3000000b0034a4433fe7asm265610uau.28.2022.03.03.02.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 02:26:05 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id j3so4957353vsi.7;
        Thu, 03 Mar 2022 02:26:05 -0800 (PST)
X-Received: by 2002:a67:c499:0:b0:320:2cd8:9e1a with SMTP id
 d25-20020a67c499000000b003202cd89e1amr2443124vsk.38.1646303165309; Thu, 03
 Mar 2022 02:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20220303090158.30834-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdUXXkoeAU7as+-t5AkWv4Y6ZW15wwDSozOeH+gZetD1YA@mail.gmail.com> <OS0PR01MB59221E953FD970E3877643D386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221E953FD970E3877643D386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Mar 2022 11:25:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVNEhrcjkO+vZVn3jk0XEuVYooxTL0mZn+Aa1=STBf5rw@mail.gmail.com>
Message-ID: <CAMuHMdVNEhrcjkO+vZVn3jk0XEuVYooxTL0mZn+Aa1=STBf5rw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Update compatible string for
 RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Thu, Mar 3, 2022 at 10:59 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Update compatible string
> > for RZ/G2UL SoC
> > On Thu, Mar 3, 2022 at 10:02 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Both RZ/G2UL and RZ/Five SoC's have SoC ID starting with R9A07G043.
> > > To distinguish between them update the compatible string to
> > > "renesas,r9a07g043u-dmac" for RZ/G2UL SoC.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > @@ -16,9 +16,9 @@ properties:
> > >    compatible:
> > >      items:
> > >        - enum:
> > > -          - renesas,r9a07g043-dmac # RZ/G2UL
> > > -          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> > > -          - renesas,r9a07g054-dmac # RZ/V2L
> > > +          - renesas,r9a07g043u-dmac # RZ/G2UL
> >
> > Is this really needed? As far as we know, RZ/Five and RZ/G2UL do use the
> > same I/O blocks?
>
> OK, Just thought their DEVID is different and they use RISC-V instead of ARM64
> And also the CPU caches are different.
>
> I agree it uses identical IP blocks.
>
> May be I can drop this patch, if it is not really needed. Please let me know.


Please see my response in
https://lore.kernel.org/r/CAMuHMdUZw5bxUgEif=pT-2Gm1ha-Z01r+AJ6ieC62SwkfMYD5Q@mail.gmail.com/
Let's continue the discussion there...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

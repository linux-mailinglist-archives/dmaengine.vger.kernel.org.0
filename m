Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1224A1C3B85
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEDNoB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEDNoB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 09:44:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AACEC061A0E;
        Mon,  4 May 2020 06:44:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g14so8849152otg.10;
        Mon, 04 May 2020 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEWs1xs69QGFQT8FpFMUjbbXsqIGW+k2px0Ls7b6Oi8=;
        b=QdrM3gPHzWbm4Ut0s77CXXuPeXeO3+pWV0ebjCCBJG+EiLxeyghlid3QCd7Um13g3Q
         jMfneriy+x5BaIONl5wKwdXifl1ySev0gDGA0O2A6aLemvnsfCbjMxPirHTS/JOIOvtP
         vPfTmyLF+G4kTQBg6kgc33HQ2ZKi/0rJa/kZUXKNu41yGYhZGOjWCN5t8bpmdMLx2k0t
         rJe8rVsJGOXwZi4Gw0ty8U4DsWbSXKDKfT/rbVlDFgmPVsDhDYmevn1xfD9USEgw4xAu
         yTEgKiIyjSji1U2sF8bmzhDWsVx8yo+sLoRKqK/5gVRibpacAxOtgwApzMIJT/fekupS
         CnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEWs1xs69QGFQT8FpFMUjbbXsqIGW+k2px0Ls7b6Oi8=;
        b=YBIARUgrvamv4YPxL4WPJDCkb2/40tEkM1LDrBUwyVryz1K4mtuDAxfVO4yETIkU2B
         Cx4Qq6LArvIljF7P8nNEnW4ipvx5KEiA/wjU0u5JXHZd/nsf3FLXMm7NXFcSRLbjaGTh
         W5Ug45WjlI/stF1qo/vQpLQFGLwmR5YWx0EqJea7AmHTVDKfS0l9mnJVA/SpW5xbzF/s
         mZ4ETK7A5iZHk8vH8m7wxcMz0XOrLyBUhpCIDCddoitx4bbYXBnnOEbJeCi4DK1oZsyF
         wSkqWVrcMmtveBoVKyzplsr+j+9ONykGsP4HwEeT+rpamvIH8qht9MwTh97dqHvSfRQ0
         KZwA==
X-Gm-Message-State: AGi0PuaMNGX0/FnoZOd5seJ1vQLpLP+WM6ZA3MGh42gHefB6PzYklotQ
        0b4TJqUNpYPf7Aen9PeIU6wwza2iIllsAkpdFR4=
X-Google-Smtp-Source: APiQypLNn94uuIHxhLJOj/nbkJcX/HXrwlyBrRZSV8ynXzT8RUBOpYvtk0ulNzKDoqpofBW0lh97EwemfFvkm8NH9KE=
X-Received: by 2002:a9d:7390:: with SMTP id j16mr13274515otk.43.1588599840793;
 Mon, 04 May 2020 06:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWBp_+PAa9VNhHCxd8CwrZVeeH1swDrZhegS-7YuQaL2g@mail.gmail.com>
In-Reply-To: <CAMuHMdWBp_+PAa9VNhHCxd8CwrZVeeH1swDrZhegS-7YuQaL2g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 May 2020 14:43:34 +0100
Message-ID: <CA+V-a8sRtYy5VoMegnrwW535wjaSiv3YAJ=eBUAbiLiC5fu=Qg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: mmc: renesas,mmcif: Document
 r8a7742 DT bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, May 4, 2020 at 11:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add support for r8a7742 SoC. Renesas RZ/G1H (R8A7742) MMCIF is identical
> > to the R-Car Gen2 family.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> > @@ -11,6 +11,7 @@ Required properties:
> >         - "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
> >         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
> >         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> > +       - "renesas,mmcif-r8a7742" for the MMCIF found in r8a7742 SoCs
> >         - "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
> >         - "renesas,mmcif-r8a7744" for the MMCIF found in r8a7744 SoCs
> >         - "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
>
> Please also update the paragraph stating the number of interrupts
> (1 for r8a7742).
>
Oops missed that, will fixup and post a v3.

> With that fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
Thanks for the Ack.

Cheers,
--Prabhakar

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

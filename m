Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F61BF8A8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD3M7O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 08:59:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35830 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgD3M7N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 08:59:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id o7so5119493oif.2;
        Thu, 30 Apr 2020 05:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFd0mFF+Oi7oyBZIDq8g60aiuPWlTPswKEMj2mCEslc=;
        b=m+/B/1E8mX7goQslfqFT7NI0tPHqcaNNc2db0X2K3VuU+AxgVGKvqhdPlOKJM206Zp
         pHouhrXxUCEzQtI6ozywTptd74wJyrYFXkmDk++vr+udN2bjERPfRNJFKyVAp+PIzHtM
         cEDkttfxrOACy/x0EqnrIKn/wLCt6mSC6LM1JVlctL66GR8/IV7Ujq01qVhI8Js+6PUu
         iKZAOJW/zxRkbhDP9ysA8gvOc9hLttBFHvYeyGsJ44fS8yBEsovrkp5WsWvjLQWeFUNO
         aCquvADgejtICC+p+3oDTXKBGDhOtvSmweNLcCiz9bPnMH5uBfn/nO+N2yMBjeL+fdRY
         u+cA==
X-Gm-Message-State: AGi0PuYnmCLzg/KBLa2K0MQ91oNcY89JuhXbWP5meHHCkiYtYNnsgNc9
        5kOBPv1h6ipfR0L5wUKfMw+AyHndVOBtj5Z1Vfc=
X-Google-Smtp-Source: APiQypKbIFfpHEXzOX2dxSQf2ILcVnLcCfpVuwsgYdFPltw0zUwaBesFmNJeGmcaPY8Ao/9oH4A2Zgt2d21nG0O6IDg=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1538425oih.148.1588251552921;
 Thu, 30 Apr 2020 05:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 14:59:01 +0200
Message-ID: <CAMuHMdWm25oGgwkA-nP5oRic9Gi1fZaZEx35Egj6-5254K89Mw@mail.gmail.com>
Subject: Re: [PATCH 03/18] ARM: multi_v7_defconfig: Enable r8a7742 SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 29, 2020 at 11:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable recently added r8a7742 (RZ/G1H) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

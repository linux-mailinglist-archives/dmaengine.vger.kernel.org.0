Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533391BFCC4
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgD3Nw0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:52:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44755 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgD3NwZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:52:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id a2so5238016oia.11;
        Thu, 30 Apr 2020 06:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx1vrsVZq+IbNA++2G08z1rg1sNLX2BQVibyI5UB8Yg=;
        b=lH0pEzPedzQYe54e/QhwJ+TjQpDzCj1O4CrBLiPR7pvi31yXn/5yCrK0K4L7ZOKiYe
         SQC53y7lwWi14j9qc/4BJRjqsSnxPjcKfutF8HQypAQoI17Hm2q23olFmon9ctEzWfMX
         o2oZsVxgvPoAJsghyh+3HgLrnvRRrgkAqdEj1HWB/0obrjXqWtF16S7ki5Da3tzPMPrL
         HrihePowIK95gIE07+4Ca2Is3CX23N4nICM9jcRGwc+McScSewwEUV31FWj75C8lBNOy
         oM80wt8eVDufCffs+h4DsnjLGwbK7WohC+z/SFG/9DzzMzaIMuDvU5nGnXyJFGoXHISI
         awmg==
X-Gm-Message-State: AGi0Pua9r+tfpQPyDdhMnecU2jStf9HFz5xC6zrG9pvaz5U58+HQ07Um
        1KfeyONVCncdu859280qaEASi7UFC8jqqcPw5ms=
X-Google-Smtp-Source: APiQypJUGpqJbnxexd7dqOJmSTBNVdW9VYTDdyYVHeV3l6YnMiahGYWRXjyWK2Vresb0767EYyF1hnGyTnD1yoW3ZW8=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr1848055oig.54.1588254742783;
 Thu, 30 Apr 2020 06:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:52:10 +0200
Message-ID: <CAMuHMdVTwEFeRKLaK_0_xTkaTV=vVPtu7bhZPz5_UZ++L=n8rw@mail.gmail.com>
Subject: Re: [PATCH 08/18] dt-bindings: irqchip: renesas-irqc: Document
 r8a7742 bindings
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

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document SoC specific bindings for RZ/G1H (r8a7742) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014A91BFC5C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgD3OFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:05:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44020 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgD3OFK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:05:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id j16so5280268oih.10;
        Thu, 30 Apr 2020 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btoVzhyY0wnUJEwfEjCbMjjPFevTpPi/O3/wVPiGFzY=;
        b=uL4SrbiFCRixhE/NXVmUNF7DBC20uxcrgdy0omqXQbA+8hieiZDXQt4mX3/++42il2
         lpdZl8jaIaVMcIDN0dN9xuNReQZrrBF5lK2q5HE+tCmfcsjYktFZjiPcH/MRDoAFN8JO
         taV7iMIvp9fT5xYSI7TxtQjpwJaAImvNEDHI9LWdl8YU3KNgqwyVyLFF5tQYXEkuhFI8
         6Pjm5LAm98r9m8ouCFIBca9oSJ9AH8xxW7lI5DjlzJWaC2a8qqAYLidIP/ZRVM90rka6
         obH+zbU6aMhUzYQjvtDzxeVSU7tQuRalsIO8MssozMlGOKhynh7FqbFG8RQLl2tRDqrQ
         F4vQ==
X-Gm-Message-State: AGi0PuZL7cZBSIpxBf+J1TbMk0b6/fGkBQDUcXLCkoKBGVDjDT6vYGN+
        fphiChmuIWQ8o9+FKOsJDCuu1vhjvTDTJaoxmu8=
X-Google-Smtp-Source: APiQypJf2tz6nTts7ezicKf5ZObe2sWqHoXbLa3vjDS8ljB2NDD54mIOYa5s4UgwtTQTUZGm9HLHqKoVdv49zUTb29A=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1777710oih.148.1588255509404;
 Thu, 30 Apr 2020 07:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWUYU6-S+EhzTKE4JeS2ExLQcsg_Bpy7RKD+cwhg55M8g@mail.gmail.com> <0002cb9c8b1f0f7a308dea06af14bb37@kernel.org>
In-Reply-To: <0002cb9c8b1f0f7a308dea06af14bb37@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:04:58 +0200
Message-ID: <CAMuHMdV-65MAgzVm=1_TAHgtp+T-ZxdUjAv79uopKMp3EQar8Q@mail.gmail.com>
Subject: Re: [PATCH 09/18] ARM: dts: r8a7742: Add IRQC support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
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

Hi Marc,

On Thu, Apr 30, 2020 at 4:01 PM Marc Zyngier <maz@kernel.org> wrote:
> On 2020-04-30 14:54, Geert Uytterhoeven wrote:
> > On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >> Describe the IRQC interrupt controller in the r8a7742 device tree.
> >>
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> Reviewed-by: Marian-Cristian Rotariu
> >> <marian-cristian.rotariu.rb@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Can I safely assume that the irqchip DT updates will be routed via
> the arm-soc tree? If so, feel free to add my

Yes they will, eventually.

> Acked-by: Marc Zyngier <maz@kernel.org>
>
> to these patches.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

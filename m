Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1F1BFB9A
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgD3OA5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:00:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40004 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgD3OAy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:00:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id i27so4960605ota.7;
        Thu, 30 Apr 2020 07:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56+hnJF7fvucpKqv2sY0gAy5FVHsLurCXmxr1aGtcTI=;
        b=cturxDu5JIDIp5o6PGnU9/IzWxKh3SG1Vrn9xTJ36O1PR57ccgRdHGX9VSNxxXcf6N
         IfEANJ6QMdLgpHFpP5ii7dlDqRAYhCofAxd/r6W9in++0ba4dVLEwALaj2q7GMh9u6XA
         QGeegR+CPbfoGVQLJOlfK34nhbblkyRKS6vrivkYCpLe8tHe5kDihkW1h3h9++IuPDm5
         v1DDUM0nC0pbWPQai6Sh+Z/weDYPa7xKOwH5fBiND1uQ8AbZbMiRNRBpBNUxMi6zZ3s2
         c7xs0CQJvopjjJgPmqbe+TfRCREHpVWgT4mVIl2MmnP9ea4r6FWFJHLZaOM6s2bRR3MP
         RkSw==
X-Gm-Message-State: AGi0Pua1EDpOnM78uLp2Hp1YtmhIOahKlFlFU8iOM/SIbwRbH8kTHHE8
        YPAZ6QON8LO888TOBSWYdrQNWpKuxEGyg1X2Ni0=
X-Google-Smtp-Source: APiQypJ6KaeAGcTKjVOK3+7+brBeC98O0eTIIpFYmbi9JxFQKsEFhK22k9egoZvh71YGTW6h2ODRjWwTyt+WgWUnMsc=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr2561994otm.145.1588255253287;
 Thu, 30 Apr 2020 07:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:00:42 +0200
Message-ID: <CAMuHMdVn0j8fKD_LH7gKBadjA-g+eNE1=Ld5M+8=NM2VKt-HCA@mail.gmail.com>
Subject: Re: [PATCH 11/18] ARM: dts: r8a7742: Add SYS-DMAC support
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
> Describe SYS-DMAC0/1 in the R8A7742 device tree.
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

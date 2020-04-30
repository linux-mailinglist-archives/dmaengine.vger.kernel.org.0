Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AC1BFE78
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgD3Ohj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:37:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32910 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgD3Ohi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:37:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id 23so5919136qkf.0;
        Thu, 30 Apr 2020 07:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE3bI8i+KLba6V4Lh5f3hn0EFqTCTl7OhA34yJVC44g=;
        b=n5IcWXrCP9svMDlwLPpp4GL3Za9ya8V4t69Ymx+DKQpzb3++UMMKE/hz1BLXOC3wu4
         Pmug8P3ukZhmKEtya2W17eqSTNyR6OjQacTJ5wyEDCd6Q0bFEpe+WGCiSXkQrIzop6V8
         AT570BqODOmC4kdffW1Z5LUtgTnJIANEvzERPt81hwaZi5AoNhD6fkVsueuX6jhWubc9
         Hwwn2YOsenBosLtBKylpi7eeNF0oHgBJvl2KaCR1s6Xx69YM+VUA274GUrVcuwHizKDt
         KwjKhoIIRyvr0fT2O3OGJ8Wexzw3fa15aPq43i1C11EsUCYHLnT21lBBJiBqE7hhed5X
         8qlA==
X-Gm-Message-State: AGi0PuZ/DmpB8MzKyDlgS6UyB0fKZBU7DeKj4L6sr14QRUUQVWgT6L99
        0gM3ysQVUwCxieAw0unUO9eer601FwQStB2Q2/E=
X-Google-Smtp-Source: APiQypL37xZXvZAZkCoF9EXedcHtgwTVhctRwzKsL1ZVVKLbbBWQgvPnJlTJbYuMAWHGev5mzNUqXta8lHehVpoaPJs=
X-Received: by 2002:a37:44a:: with SMTP id 71mr3875551qke.114.1588257456479;
 Thu, 30 Apr 2020 07:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:37:24 +0200
Message-ID: <CAMuHMdWXaKaUkAhQFG2=AQuMZSh4jRe_Hp3L=Eyjn5af49CvOQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] ARM: dts: r8a7742: Add GPIO support
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

On Wed, Apr 29, 2020 at 11:59 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Describe GPIO blocks in the R8A7742 device tree.
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

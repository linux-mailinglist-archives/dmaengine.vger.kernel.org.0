Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5643D1BF8A1
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD3M6i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 08:58:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45956 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgD3M6i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 08:58:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so4752866otk.12;
        Thu, 30 Apr 2020 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFd0mFF+Oi7oyBZIDq8g60aiuPWlTPswKEMj2mCEslc=;
        b=DuVwhmd5Zp9s7G/sobWSBDcaTtggZ7jeH5XUVMHPQfLlqNBMvXG/BZaVcn0Ebl8as4
         VopYtKuzCdMRJ9qN87b+OMnFcvE0kjzyQj3WaKV7F2xw2J6cKfOmsKTOY9ZDW2w7h5Lt
         kqPQx7l5J58+HfpmMFDRKpf4M1JH+1oDi5ZbUHc9m7SzRADl7YGwnMhzOo20v5VvWFHv
         vPd34K3GJ8T0IYlzqGxQkKRy0XUMunV69Ah3re9ddd85ne0vVJJIwQJ34/eiM0u/Xmzx
         oirZAacsOiN2vh/1L8XGxUNPPTFHhnvFTTirXNrYgj55MMOu/Oo9ojHizUHk1f293nfP
         9XTw==
X-Gm-Message-State: AGi0PuaAedpxYpEOk8WqDCmDOUGnNwY+lite0FcJ1/mYAipftmimRzuy
        4cz2UmvkdZFfuvp8Xs9N0snN0kDQctRLnduGWTE=
X-Google-Smtp-Source: APiQypL1QUWjengM4Z3jBYWUfcWFClwy5vxn0vgax8kCZQ47In29GZsjXT7y/L+Zq7rD04amU+ljAIcAVBvTfNyOgXU=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr2222464otn.107.1588251517540;
 Thu, 30 Apr 2020 05:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 14:58:26 +0200
Message-ID: <CAMuHMdXNqqBjqBCYE=2agSaH8E4AyW4ML+0H5-+5QWhXKsO8+g@mail.gmail.com>
Subject: Re: [PATCH 02/18] ARM: shmobile: defconfig: Enable r8a7742 SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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

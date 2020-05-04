Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EBC1C37EB
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEDLVf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 07:21:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36836 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDLVf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 07:21:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id s202so6293525oih.3;
        Mon, 04 May 2020 04:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZDl2ISqwoHN4MDsNOQjpFEl7Qj/2jW8GPSfjfJo6nc=;
        b=WM8qLFAfOdxGJtCFPNk0ZBz2V7jHgPf0p30Bdwq8c0mZpCb4aJafif9BCN8J5xxAd4
         BFND0C7yKCQKyi6ERamJIZuQsvoUVLNakRYH+2M7Y1RCv3bcvsHfn1WhZuV3rkVeTvFO
         c/YFtzcoEpAXa6bOgAIyR1nfgRz9EnjjYf5BhVDzkfvcrxGxWlphRhyPNZwzClwMyLhd
         l/tsQJZyxKNu8as87+3VVDdjYsTETjs6dKpuTgCbKO605g3Pflc2CiXoNyDxTfCFV0Ob
         e3Bud0YeHBinx2bqKA8kzL8/e9Xx78AeZtYoBpSVlEx1FwPWYM1+hlvhNa4GnQODtZOi
         HpAg==
X-Gm-Message-State: AGi0PuaRGRWjp6RTEVZObM9CTTsWjtBDk0shhjPYmNAb16OWttEnrACZ
        kwsO+6MIt1gppvMbNn3rmvcB3kCFJXOiU35R6S0=
X-Google-Smtp-Source: APiQypLg42OO2VjW0SY9rnGti/L+fKWDI0eWfPP2uNbvCsMbAadHm9cbkZemqzEwjcmfQHTIp0JmQe3BpKW5x1EEses=
X-Received: by 2002:aca:f541:: with SMTP id t62mr8161718oih.148.1588591292740;
 Mon, 04 May 2020 04:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 13:21:21 +0200
Message-ID: <CAMuHMdXUkxe2GJigr92HYBtg3Ni_MSpuMnxo132U+9448YVDBA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: arm: Document iW-RainboW-G21M-Qseven-RZG1H
 system on module
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the iW-RainboW-G21M-Qseven-RZG1H device tree bindings,
> listing it as a supported system on module.
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

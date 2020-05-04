Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A508C1C3AF7
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEDNKJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 09:10:09 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36566 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDNKJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 09:10:09 -0400
Received: by mail-oo1-f66.google.com with SMTP id x17so2363554ooa.3;
        Mon, 04 May 2020 06:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m45ix2jo0oJBT4CyJlzZkH39XD04I9G5DajC3f1FfT8=;
        b=SI1kRq9X/TdIMm/Z+OhHQPnD/LRDj1xsaD/GCYLbeDLYJ3IehlkY6XnTZbixGPf4qI
         32uykv5mK6k+iKfozRPMDmaGjReEOtlsZZh5aw7/gPhBLPmc1PEo3SuxUAb1Vl4fVGVc
         bXZT/tDfup0DaLMoVOYiFy9+5ur2KRC5JYO5tpV1plm4JFli3sCZfG6yWivzhH+cbVUR
         usbqrH/wM3NBGJkkIqyM6aSj6SfJ5fdT5zc7e2LkYUnVVhephzHLCYfADuDHn6Up7b12
         ZgTMWfQMss8UFBFJ/B0y3VluxtZ7oBsbsm2tF+AA8pO6moEyMsKVULncIqgkhEX4ulo9
         o9cA==
X-Gm-Message-State: AGi0PubTfCqTbiMt7eoI83EpBU1+AWu1K03/5ozacr5sSasDaB0iymqf
        p4/S1jeVliZ56cstgMerU07Pirrj3vwvMxFtG8o=
X-Google-Smtp-Source: APiQypLpzZE2IvYXqH6gz6imKGnp8FyeyBLm3+HacZ75gaAc1r2MHwwKq/DQyIzoTSsqIBSxXXNNqHjyLyhzp3T+hPc=
X-Received: by 2002:a4a:e8db:: with SMTP id h27mr14970818ooe.40.1588597807924;
 Mon, 04 May 2020 06:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 15:09:56 +0200
Message-ID: <CAMuHMdVa63kgKtb616vsjis1qmwsPoye-wDUe6YcXf6Lc=CjBQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: r8a7742-iwg21d-q7: Add support for
 iWave G21D-Q7 board based on RZ/G1H
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for iWave RainboW-G21D-Qseven board based on RZ/G1H.
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

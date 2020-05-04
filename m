Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE61C37EE
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEDLWJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 07:22:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44335 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDLWJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 07:22:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id a2so6258644oia.11;
        Mon, 04 May 2020 04:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jRRl/QTF62BTO0pe47y/GWsOHz0nkfjCAIUVeTbtdY=;
        b=pGqTYZJVu37luwOmAJTxXHgZIdsFmIBbKyR7fINcZDv01N/p8pXEI5+y+HJc8qh1Oa
         NrIEq3h8edOuezJ7CpXvTYK4O5T6ludeXXJlnhe4GZ5vUj+r7cCh2IDmWdTFtJLXKVXg
         A65mzKssS1zTRLFwkYln+C+gK9qigaDw+F6+tU6vMohCgdnyMLEE3VPbnk7CfY5yFXpO
         ZvxhK3FVNG/AIb/clGuNtfGJlljyiIY0aVI7ucxxg8CIGPevlv+adedbbTG68sVnl7Zb
         O5J+7T2VMzKC3a1Ud3TpOXSWifNbLalrm4TDtsW77C7CIXKBmqR2i7ehoI0FI9MJQAwX
         CAYw==
X-Gm-Message-State: AGi0PuZ1yOQf0NZ3UmOvG3v0ItAclivIlF5+617XoRHZsSy2Sp9QIYGe
        aNuGBEjZE1A1TR9fTXskkdAiMtR7beoXf2yF2/QiA5So
X-Google-Smtp-Source: APiQypLhQa33fXpG4CJeXxg3td7a1+tJhkA8EyqpoDhMWC0c9V02ObVa3BG3J0cZD74cbBUTpHl6RscmLuTe+RiMbt4=
X-Received: by 2002:aca:f541:: with SMTP id t62mr8163136oih.148.1588591328305;
 Mon, 04 May 2020 04:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 13:21:56 +0200
Message-ID: <CAMuHMdWqD6k7-cfaZQbc2pjSuCOGL4TcKR-S6QRgVqoUHfBayQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] dt-bindings: arm: Document iW-RainboW-G21D-Qseven-RZG1H
 board
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
> Document the iW-RainboW-G21D-Qseven-RZG1H device tree bindings,
> listing it as a supported board.
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

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD50A23CD35
	for <lists+dmaengine@lfdr.de>; Wed,  5 Aug 2020 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgHERWj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Aug 2020 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgHERVU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Aug 2020 13:21:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA4C0086B0;
        Wed,  5 Aug 2020 07:50:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so23186635oiv.13;
        Wed, 05 Aug 2020 07:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lnCZoNdrZNQbQaV/iF1DKtpBff6Ck+1xozm4eqaEmw=;
        b=p+jlcQHBqr0FBki7hCBNWHPJ/hWFZrwga7NmQDaDGOIgnf2c+20Begp0wNRxZJkIWH
         Ex+VyXmuD34hri9YsT48xhntbdkHS+2WOyzX/X2cpbM79wbvuH6FHlx/S10vmtILLW9R
         xAmOWDgxN+J03mi2Qo9jM7ptSngvD5bqL+wyWVST0Zn2cgaRz7lH9rV2FaeI0Ml7HWuS
         cuXEy+u7LJ3/kdywifRuMnseOTbmHhe5IKiYJEtk1wCg1jaA0atFTT9OjzCdOWd6+PT+
         mQv8J1mAjz1Jbm3EkIdkYl9WEDW55j2SmdJMXB280MYlvfbNO4qfYXTbPyk7EO3q3Oec
         kS9A==
X-Gm-Message-State: AOAM531OT4CMd+P7TZx1NJNkek7bjLSqS6uLK5tKKcmsxwWf6f0u12eV
        aNh+hepY96KHqiQuS8BM/CvOscD68y6A7SiHpH+X1nah
X-Google-Smtp-Source: ABdhPJwhUm4QHaZz7xbR+lTUoUQuyCH4le0QF/k75iMvl2tButnuNI7+iEhEoJyqrnRXlecEQMMJHtDC6cCth7F51hU=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr2275594oia.54.1596626072299;
 Wed, 05 Aug 2020 04:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Aug 2020 13:14:20 +0200
Message-ID: <CAMuHMdW5_yBdEidPiVNeQO0QwuJfTe0kSiHLg4hkQLzVuRM7VA@mail.gmail.com>
Subject: Re: [PATCH 10/20] arm64: dts: renesas: r8a774e1: Add USB3.0 device nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 16, 2020 at 7:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add usb3.0 phy, host and function device nodes on RZ/G2H SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

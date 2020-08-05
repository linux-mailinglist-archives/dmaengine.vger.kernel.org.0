Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0582023CEB1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Aug 2020 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHES6r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Aug 2020 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgHES4m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Aug 2020 14:56:42 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57BC008693;
        Wed,  5 Aug 2020 07:33:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id p191so7703246ybg.0;
        Wed, 05 Aug 2020 07:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhwGBb3og4FBqTm6+fj02zyv7weIuiKRDAujBvepcdQ=;
        b=fch6LB7KMtoU3ydFD3x7lOUc816sn1DTq0b2HNj9twAMga3EBXvQdvMsHrkfPKS4jA
         uazXvHSW7mG00Dl3XKr58t6jr8EBxhTHSTnuRfGIiD5GyECH26bslPfhbFYhbtu82MAY
         2Q0GucivfIHZWvsJWi05WKA64nxxs+rTDAVDz9CuV00E4FewnxKDvVwibVnN/0Psu1cY
         VTfNWD3V2pvwMp2i9ssSkE8ew9aCLuweBQRmiEwkvoQ38JD6sWL2DO6s9aWIuwFGitMe
         +/Z8/nqZ0tA+8vF78a8eml0NsVGBf0c0Bdn7dh8feKNv3TqsLzJgSYmr4EGtEOpf8qgZ
         uMjA==
X-Gm-Message-State: AOAM532T925N06vt1YjS95QmTDSXnaxD/9Mjq6ncaejqcd7jdURcMvRQ
        pgAdlXUBfOPh2Zwx7GYd9J2ONA4jcxNJ0tLDoU5HyuwK
X-Google-Smtp-Source: ABdhPJy6Few2JSpX34d8UWs2mHs62Jj4zoFqif/HtRZNiG9fgu0Yy1ArYH3I3/SVye0G2Oxi4tcy3VslWxu2yq+qpJs=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr2025587ote.107.1596625767021;
 Wed, 05 Aug 2020 04:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Aug 2020 13:09:14 +0200
Message-ID: <CAMuHMdVTBWuDVueW4OJff5kC+=PF+Q5OnKAo5-M4+7g9WB-adA@mail.gmail.com>
Subject: Re: [PATCH 04/20] arm64: dts: renesas: r8a774e1: Add SATA controller node
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
> Add the SATA controller node to the RZ/G2H SoC specific dtsi.
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

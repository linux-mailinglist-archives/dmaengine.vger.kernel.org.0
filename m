Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B91BFB60
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgD3N7a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:59:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32982 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgD3Ny3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:54:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id o24so5296725oic.0;
        Thu, 30 Apr 2020 06:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lq5yotINN5KYJUar62+nHe1UVAWw3VsyL3e2P7YS8BU=;
        b=Fs+x95REPD9EfTrmtAphxUuSWdnK4AewafFukG28gjw6/cMXJ7SPw+K/JRXaEzDI+Q
         xCxdviGuWsdNW5oaM6ZLrEja3DMcTLx0A0xIZiXgLz/DLhqIcJGVkRUXWEvxRNIeSEg2
         TfitgjACuqffMU4eUtex6dZMOL2j4LyQs3zP4diaw7khFVR1wuugEk9/cPZpGKx/u3pa
         yglXxryic2X+Y7Q7xaYhznG9EcQMB2g+wDsUwyZLo4IVmHeonmeAVY1HXPq47qqOO285
         D61MdmfgHNdhBGk7ShmxPsM4xxThulaCyjlbwt3xbKr5muFXsUyPsRGHJBwJJJrUz9bb
         i5Sw==
X-Gm-Message-State: AGi0PubPicM6FM9kH8G6Eeu7uYJJpPynry7GYQ1lIHq/ZpyBkDd2fLwc
        Mmh3CH/FwvwazzCeLcQlhgSPFQstOmPt5/x6OKE=
X-Google-Smtp-Source: APiQypKSH2mk4TQbA0Ak5zrv/RbXfwp1aRhXDsLXfDfpPXjbsGxuhUfYCkid+vwSbm4NVFRKEn9DNNlyvrMRml/YzRI=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1735443oih.148.1588254868374;
 Thu, 30 Apr 2020 06:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:54:16 +0200
Message-ID: <CAMuHMdWUYU6-S+EhzTKE4JeS2ExLQcsg_Bpy7RKD+cwhg55M8g@mail.gmail.com>
Subject: Re: [PATCH 09/18] ARM: dts: r8a7742: Add IRQC support
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
> Describe the IRQC interrupt controller in the r8a7742 device tree.
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

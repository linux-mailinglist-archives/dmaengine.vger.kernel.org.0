Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F11BFC12
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgD3ODV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:03:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38235 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgD3ODU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:03:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id g19so4971559otk.5;
        Thu, 30 Apr 2020 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz7Wj6UlhUtYyAjOVoDBpABEhXzAY8F1XL3/Z2xqUzA=;
        b=k/hifpxip8WvfwSk64PvtfcABtuv8RJlaepsuoRFODq+LzNM7jsZy/m7vozJM7FlE1
         8es+NHpnYCIFeHsBaSR/cHZJVQRj9X5cuMiB+sZbV71Gik//CqwD29PngIR+qpIdKNJO
         NwbrFdEGQtQpHxPqlKOasB4pEuivsBARaRdIzqe5waOcjhq2dUhXUeE8bBXfN7dmucOC
         3IamyNuOSBctLWtJaGqZ/CQlYjpsOFn6jKGl4NdW1mPoLhk++sO7vWSF2lgw+YzqcLIA
         71wIxEPJYAdJY3pXSACUcudGfJALwL76xTM9XGdPtDCEAoOfeBlgUUrTRfD5M0bZ902G
         rMgQ==
X-Gm-Message-State: AGi0PuZtS7tXCKHB5KWLJYULNeCNYIJUS3ZymQQCDvhRIQ9pzPhSRfjK
        xcA7ErqFg+IpJmqyT68OKiy38aKyzmSCmMIsD8I=
X-Google-Smtp-Source: APiQypKwUUCVBWIBcqOPUBZmRRdT7JXpn2BYbxbHqquKVj0D5RpVp1Oagg3I9RqW87RaXrHEMn4Krxr5O0GVmmhdSMo=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr2469309otn.107.1588255399560;
 Thu, 30 Apr 2020 07:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:03:08 +0200
Message-ID: <CAMuHMdU=_yAxxc7vLzRC5576TTjwjZta=fBgWQ5gmDX5rfRkVA@mail.gmail.com>
Subject: Re: [PATCH 14/18] dt-bindings: serial: renesas,scifb: Document
 r8a7742 bindings
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
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIFB ports,
> so document the SoC specific bindings.
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

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10DF1BFC24
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgD3ODt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:03:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39302 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgD3ODr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:03:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id m10so5283514oie.6;
        Thu, 30 Apr 2020 07:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8sgU1Szr34IsxXbirpuvDaAZhkCI+krBrR2ZiJePQw=;
        b=nnnpUXMs8YnO/kEZg/lUUlcZU01rhsikOsSgRaCs4SXKJrYXWOA3/znD8TbhbqKgnV
         IlaCf7JGZ7L+iv4rNjjMFzTolXJTThrfpQZanxV1iVSauAxMt6fcfsRy/3GbLgyAKLMB
         mLk4342rFDqDldx46Qvm6DbIRBXB6imjC67IQl4I3nkov71CmtDqNq9bZVjAufrKAlYf
         gn8rduT49egOYAcqsRz+hwFUTeUiRLgRgt/hHEHwqrK7tP3eaD5wLL6ZIpPk0nu3ZAJp
         43Bb+1VvxCysEfyYACyPj8agOrwf4QVNT9aK7OND2qd+VqwVpApRJpqi5WAAlj5JakD8
         +12g==
X-Gm-Message-State: AGi0PuaphrQlUyutjFmA53JtE9iki8IFpfgT79jNiPx4WmYxZvv7xM0k
        1HKQzsWllWcmqSJGzz1bZ01oSFSVVAfOobFiN2U=
X-Google-Smtp-Source: APiQypL9xeeJpmuZvM5tql+5NXWQ4pW6DcMEWufc5ew+DxYHUpQs0+qo6mOBm2fIsWhIGQsFkQ29kQIrXYqgOowhF2I=
X-Received: by 2002:aca:895:: with SMTP id 143mr1766140oii.153.1588255426230;
 Thu, 30 Apr 2020 07:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-16-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-16-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:03:35 +0200
Message-ID: <CAMuHMdW5UPVStDUHK_9eYEwAnRiCxCBshLPCLeoAsxuhn2LXqQ@mail.gmail.com>
Subject: Re: [PATCH 15/18] dt-bindings: serial: renesas,hscif: Document
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
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible HSCIF ports,
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

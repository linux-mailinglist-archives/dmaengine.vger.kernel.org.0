Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30C1BEB61
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2WDw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WDv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 18:03:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3163C03C1AE;
        Wed, 29 Apr 2020 15:03:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k133so3304123oih.12;
        Wed, 29 Apr 2020 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuIJyUBI77A7IsS+UOzXlF4URqxn4aKY6yPSfUat6bs=;
        b=jYjww6TRFcRX3Y23g1fUDaSBixBCmtlAr7R6Tr647wYfD6+VQtLpQyI3KQy3e9YvVZ
         GpcxE8fFEo6OWVSKuQwuHBjMY4thiSIdKoHlvitdIYxmtyZpsMeQejW1hdtDaMB4wmk0
         F7jHmJII2Gtb6LCbj5zCojkV1FYAgJwh+xYKpP2RtNrp7FRaObjHYxH9sg/TrRzwJHs6
         li/TE2Nx2Vs6kvMJWzIHQzUj7Egf5+H/qSp0aglmR2A/9ci3Mcn2ZBQRk2z4sNW5E2k8
         wD3tk7bVwZl351JxP4iOxPoHCGy92KYF/3XHy2wtZdSpGhHG4SJRGO7npCeAVQIm061u
         6Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuIJyUBI77A7IsS+UOzXlF4URqxn4aKY6yPSfUat6bs=;
        b=opHnCCv31KSe3tij6f2edWlhbQTyl5/QXOpvA6VaQwxUmOynVhmDvCHVRdvrqbY0Va
         HRVnyRCNALvkrobdZGy00F9vCf8zX/INnGtaqejZxTVQqEvhXahhbP6E9GdtCxkyK8h6
         Z1wOXWw3Vg0q6xqmgKXHjwB86LmpdUVOgfW6NE+i0yWpC7z4bJzhNLp5zZQ8uVl8HHIy
         QYJoJ49KNQuJQj+7PJ0o/AHKxEGHhtoOcGrY1rghwNuDLH+p8c0BOlG1wehMqOv1S1XL
         Db1PsfvzsCPGJxDGuZrqy3tyMTvidYxsnsUK0N4UKcH0HimbP2eZ70eT3BYGj/OiuYwO
         9mZg==
X-Gm-Message-State: AGi0PubxZtVmnuJIuBysxBdsg+4Iad8lmdOg6KVQqidwayxuO1WfiNre
        Hxv12kJhmnY+9ccTxS6YU3m1UB1GU+b9S3YLGfbq/OEC
X-Google-Smtp-Source: APiQypJ3zwVfJk2nMrXMJzcY0A34yx8sFc7iQq4Qt4G4w6K/OJdPad49V5wxoF+Zc/LWhjYb6zlkiutTqfBQpvdh7bQ=
X-Received: by 2002:aca:b783:: with SMTP id h125mr349467oif.62.1588197830734;
 Wed, 29 Apr 2020 15:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200429215955.GN1551@shell.armlinux.org.uk>
In-Reply-To: <20200429215955.GN1551@shell.armlinux.org.uk>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 29 Apr 2020 23:03:24 +0100
Message-ID: <CA+V-a8syz--q7MCNL_5TZmnYqgc7W6nuXJOt6VJhJutuS3seKQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] ARM: debug-ll: Add support for r8a7742
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Thank you for the review.

On Wed, Apr 29, 2020 at 11:00 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 29, 2020 at 10:56:41PM +0100, Lad Prabhakar wrote:
> > @@ -1701,6 +1709,7 @@ config DEBUG_UART_PHYS
> >       default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
> >       default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
> >       default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
> > +     default 0xe6c60000 if DEBUG_RCAR_GEN2_SCIFA2
>
> Hi,
>
> This is ordered by address.  Please keep it so.
>
Sure will do that.

Cheers,
--Prabhakar

> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

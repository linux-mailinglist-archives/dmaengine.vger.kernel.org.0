Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB13A98FB
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFPLUg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 07:20:36 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:45728 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhFPLUg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 07:20:36 -0400
Received: by mail-ua1-f50.google.com with SMTP id v17so627201uar.12;
        Wed, 16 Jun 2021 04:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFppgdT7CLKOLDaLJGeivAUUwv8mpERUMDgjR5mFX2Q=;
        b=BBeVsvoZ4AVSy+Y8yHwdEmm5VnqLTJRxB/oarkG9s8C2HRFpJvpV+Y7+gkXdhdzCYt
         u4gaF3RUWOnSk7QWmQPj7ejeGSlZAeTfbC28/PXrdt8awQpGrlkRIoEhANUrvvRxSoyw
         3eVOo93+6DEDuBDZ/KwPQHg++XM7nzuLRTtUggwGA+FqHWeU1femrCrTUarsi5PLXOf6
         GcmwOWzKQsjK5jwTp2qkrJW7XbmWyRyHPOPTvkQ97OnIMc62PmAbzh7UsxsdoJ9f2ZEA
         TZvaW2iEjYkB3/73sZqNGjJZQ6RjwwzWNqg+mp2U7n6mF48qBWrN2dxUZmKY34MKnAag
         jY3Q==
X-Gm-Message-State: AOAM530+WmRtpWEfnV0XLLJs/TZZdUYqwriS8gjlBz5xfdYJ1RlZxr6d
        aDD8hRf3fwcCqIOFf6l9dyjmAdY/YbBvXisARXk=
X-Google-Smtp-Source: ABdhPJy9W5ndu5bvPys51QNrj75YVXl0pvjisg4IJQA0U4LMfMINRJyD7Z5sYALWQifxuYErXQHn1iBe9VLGxsU9S+A=
X-Received: by 2002:ab0:647:: with SMTP id f65mr3978118uaf.4.1623842308529;
 Wed, 16 Jun 2021 04:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623405675.git.geert+renesas@glider.be> <0c6bdd6a-826c-6831-1477-3a1e782cced3@physik.fu-berlin.de>
In-Reply-To: <0c6bdd6a-826c-6831-1477-3a1e782cced3@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 13:18:17 +0200
Message-ID: <CAMuHMdU_B4pRyaz4nhp3k0dtXy3A8tRYbdCpmYYaSpzeZCeWOw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove shdma DT support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Adrian,

On Wed, Jun 16, 2021 at 12:42 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/11/21 12:18 PM, Geert Uytterhoeven wrote:
> > Hence this series removes the Renesas SHDMA Device Tree bindings, the
> > SHDMA DMA multiplexer driver, and the corresponding description in the
> > R-Mobile APE6 DTS.
> Do these changes make life harder in case we want to convert SH to device
> tree as already prepared by Yoshinori Sato? [1]

Probably not. The only modern DT-aware DMAC drivers for Renesas
hardware are drivers/dma/sh/{rcar,usb}-dmac.c.  Soon there will be
drivers/dma/sh/rz-dmac.c, for RZ/G2L (and RZ/A1 and RZ/A2 later).
Given the R-Car DMAC is very similar to the SH/R-Mobile DMAC, the
latter may be made to work with rcar-dmac.c, if anyone is willing
to spend cycles on that.  Likewise, the RZ/A DMAC probably has its
roots in older SH SoCs, so that may be helpful for you, too.

Chris (CCed) may know better...

> > [1] https://lore.kernel.org/patchwork/cover/693910/

None of these handle DMA?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C7BF304
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfIZMaC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 08:30:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34195 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfIZMaB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Sep 2019 08:30:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so1842254otp.1;
        Thu, 26 Sep 2019 05:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJJH7c5Zoj531ptgrS+I6xbKj34WO31mf5Hp3BAxJlI=;
        b=KnjQP1UJ9Tj/tV3fB2G4OaXXgW1w77j2fa+fqAm90CgwDzi/Ufm3meX+R0hVifDn2z
         Sf6hueZvPkFVkwIZqDcHNu7Y0yv+5FC/0geE54InMoIrHxE8teVsq526T9o3DV6LUUhj
         MNERHPK2RgbK+EHyKoeD68bkALfWEsJq/7Km8BcU2HC0AkGWOgZPHBT2AqBGAmtONG5a
         BV3sQEO3KR+CxJfpRHoEzcm9v3gm1NgCLXD9NpPoOBzqnjCCjIcACRibFunFsf0BV1K2
         nnH1Fa1BfTj7RgmC6KiVqPwanAdHAFO1JUhFKhgRzwpn7EQ/OIqGDK6o5/l/Hz7RWL0i
         RNIA==
X-Gm-Message-State: APjAAAXQn59Ia82W3msmqM876OE0EYjKsbWo2X2dchujda0vU4kehBGU
        GYXMxl85WKY4gQQKw8bIDfAquH48KbeuHtLsBhw=
X-Google-Smtp-Source: APXvYqxQ5nDWf+QViSnoTMdDQxAvHVUfXRiLX2Bq6HYe4MkOQoHeudp3c7jCIoFhciCeMVI5V28Dlnm1CHRerw+nvok=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr2375699otk.145.1569501000905;
 Thu, 26 Sep 2019 05:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <1569245078-26031-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569245078-26031-1-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 14:29:49 +0200
Message-ID: <CAMuHMdW+AwUFTbN6+084jZdYdVHYdi1wzBGAxkreqcQCGXm8zw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 23, 2019 at 3:24 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Renesas RZ/G2N (R8A774B1) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2N specific bindings.

Please don't mention "driver", as DT bindings are intended to be
implementation-agnostic.

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

For the actual change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

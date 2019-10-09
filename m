Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9821AD1193
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfJIOmE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 10:42:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33413 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJIOmE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 10:42:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so1977717oic.0;
        Wed, 09 Oct 2019 07:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYxICKoSLEOlVM2G1DTLDI58Zl5VZZN+hm3z/KE4F50=;
        b=CqHywPZQ9NiS7VYZ2le0ENoM/T7ZGBTn5W3QJVXV17TEr9k3PFrlyuaq9LQHHKvKnR
         VEmWaiks34Qtp2aPX+gmWM6hvSVOIWIg/W2wB2ApOUBA50yu1tSFgmmd7C0JepeNdtLJ
         E6jvvW+zCTNGimbJygeFUu9qdYBxKG8c+u5Q/I1W3QANDmAuAsKdo4uU/o3dzia8HwCC
         mLFD4NMsMmmy7/1rFwfwj6HizSt9OEpOvcwD+iLAXMOW96tEGnBg2bWYQ8V0t8zLhcHS
         Qr8IzBxMzlQT5+4X6obbylwgVg2V2/X/P7DcgLojd30m3ob65vLXEFsRF5xIo+MTnC+x
         qVMA==
X-Gm-Message-State: APjAAAWYcnyZrBQ+FqOGfwEGR8c1Ma9ZX2HLErA5tMLG3wh+gpgwpv15
        nBvkTo/E9k9D2jHoaEoFZpKZp/xFG3rzMkQ+xB4=
X-Google-Smtp-Source: APXvYqynYzkCNt/wi6NEo/s2UWx/NZZFg6Was2FQZhzdPqRiGIrPZ3EPJCu6XJUT6hG+zgiGcSD3/NbDL/nuU3Culjc=
X-Received: by 2002:aca:882:: with SMTP id 124mr2706202oii.54.1570632123470;
 Wed, 09 Oct 2019 07:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-10-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-10-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 16:41:52 +0200
Message-ID: <CAMuHMdV4moTd0PSkRv=bZK9GZCQ5cWVrCV5iXoBX6e+zJ-012w@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm64: dts: renesas: r8a774b1: Add USB3.0 device nodes
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Oct 8, 2019 at 12:39 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add usb3.0 phy, host and function device nodes on RZ/G2N SoC dtsi.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

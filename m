Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C459D116D
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfJIOjH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 10:39:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34157 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJIOjG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 10:39:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so1939414otp.1;
        Wed, 09 Oct 2019 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQjFKWDZqjWTXiNcV4iPO7ss0OhEBXdi6eaFigDkSL8=;
        b=s8Q0tbBUjItgU47j4vdz/Bflu+R9EVRao5+iv9n9SNojg5rOgxsOxxxvG5UpjKUQfP
         UulexUwL7xh3bDav2cDoGxNb+aQXsUjhPs+GgL08Q4unvlbpIVpH/zPq1FhwOBlLbMEd
         lt3WV0lJAODWVP3jGqzM3cg1kbi1QR2fPAGx9fM6J4hrSXk1iG40t1hfgRDcA7TECgb5
         Uf35lV+ZFn3pH5t5W2RHABj/6bb+vWoLR6+UPgKaivFLCnIR59Opp+v3g6mKA1R+4QE5
         xBfNRDyFIRsH1ATJ/NmcpuvlzYPU+PNOAX0+jAG6J81xiI4j3ccaJ05POfB5DEHAQXcI
         Yh0g==
X-Gm-Message-State: APjAAAWqA8oa0lEXLl9jE23dRhrKHdvh5ftf+SlXAKHZuBuzBlsbRbgV
        bvBjW/8OcAzLLjFRLoQT6O0FQbaPYeNCeU+WNkY=
X-Google-Smtp-Source: APXvYqzcZGhyFNk19zn0xftebfgdykxxeNAxrvj/mhGsyAHMUJvYnkJTNBVY8+tX4zWV+yLYeDJlRBGjP36kaKogSpg=
X-Received: by 2002:a9d:7345:: with SMTP id l5mr3197408otk.39.1570631945630;
 Wed, 09 Oct 2019 07:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-9-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-9-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 16:38:54 +0200
Message-ID: <CAMuHMdV5x4h-DJ04Mipf_nyvv6zytX9tJgdZ9wNv4w71=nDfLQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: renesas: r8a774b1: Add USB-DMAC and
 HSUSB device nodes
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
> Add usb dmac and hsusb device nodes to the RZ/G2N SoC dtsi.
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

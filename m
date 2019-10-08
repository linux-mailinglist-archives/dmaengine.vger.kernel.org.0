Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85779CF83C
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 13:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHLbg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 07:31:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43002 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLbg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 07:31:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so13700125otd.9;
        Tue, 08 Oct 2019 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWU50A1ftSfnXS5t6he0dr7vBuFC5vEUJUAdKOgY8bw=;
        b=BLWDEKEE40Z43yFmL1QT7KNpYscsV8gKDrE6P0C+TiWgwjN+nC8Bp73g/dVgKRfwWt
         opTja6tEFInTPdhAjQJHQwT409vWWGmXFDs4lHPb3X9SlBBznfFtE8v00b5OLM+BmgJJ
         gZbbgmwEwawOzrpWAeH2n0sgxxwAi4qcWlH5EentE8C6S7R6jnuLa1uZJON5/+4taVE0
         wA25sxaHp7RidarA2YY75+wV/50cwu0JMnQ/JTvwobgl1+EpVW0UDLF16yPMMlcB7ngJ
         ejjKTNsGGWMstBL9WM4uWFQ2WU81f94s3qQ3lINDCgQ3D7AicSIlgYL8Wqh81J66LLGA
         MREQ==
X-Gm-Message-State: APjAAAX9YpacNthpWh2Iipu6AaKUY176TcbeE27VUGjbW4oIg8Fl14lW
        Gi/3gbASwoaRQMtDQ4hkpMMS4to2v239xlOU2UI=
X-Google-Smtp-Source: APXvYqwg3JosVAAgDSiL28e72fmiuqQR8WnI4fg5raXCpMujENXSYM2HP7kCRnJ80aJMkRAJk+mptxa3ILDqF8ntcjM=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr15552472oti.39.1570534295529;
 Tue, 08 Oct 2019 04:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-2-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:31:23 +0200
Message-ID: <CAMuHMdVtFHbKnTk3xerOK4ju5NAS9-VSXrM10bZyquSR17V6-A@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
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
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

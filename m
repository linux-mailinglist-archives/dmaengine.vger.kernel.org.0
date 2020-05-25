Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A71E0B8B
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbgEYKSg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:18:36 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:40624 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKSg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:18:36 -0400
Received: by mail-oo1-f66.google.com with SMTP id f39so170585ooi.7;
        Mon, 25 May 2020 03:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt8kUHkLgm4/PwCXdRTJgQz9PVt7y+gc7PSY3CqRuB8=;
        b=OIsigtPDMDXhkjZR/DX2SCMb86jskcKQpqAvMHP3IXf6lOYqXDvBXec45ERoDWsXZp
         rPfSGffaFreUQ8o+j5aLkVbMGHtBYmMIhioZiRIxADlM3NsRKeC38XdwuBex223peYFr
         66jUSxQyJlfyLRakHDmIAXfLElIPD8T4oprn0aX6nxqlBSmmn9tD03MIqsU6V/1QId5R
         W+bZU0iwfBMtEsjUaNKBtOtCzroESR1L2DE3HNYyO5htM+MGr0TklunP2bqTxs7JrM94
         DFRgu432q6tFWU5y5PT8JYCjDEYQ9Mrg0nxaY0hxnY5mabQrE/Q4ljYSbud4V8PliDk1
         XTLw==
X-Gm-Message-State: AOAM531CCohuB10O0M3DtuJiJ9uOvwjPNSGyLhNWCEu1p2V9ch8zhvGc
        YIwlL7qXYPYEORfN3CqYuR+RE/oxvPz7LrrKIJQ=
X-Google-Smtp-Source: ABdhPJyV6T1+hM56Oz27Q8wrRBfENyGDZ7TpbxFI/YUDXRlpcmMlJpGgfYhSII4TvcHVkQgF6ezzXbs7f7VYidwjDHs=
X-Received: by 2002:a4a:e0d1:: with SMTP id e17mr12526255oot.1.1590401915222;
 Mon, 25 May 2020 03:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:18:24 +0200
Message-ID: <CAMuHMdUxuCE2ODK1kdOvtvLuPrxO3-O=0FYv5ZABE01M9phdEQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] dt-bindings: usb: usb-xhci: Document r8a7742 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, May 24, 2020 at 11:40 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document r8a7742 xhci support. The driver will use the fallback
> compatible string "renesas,rcar-gen2-xhci", therefore no driver
> change is needed.
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

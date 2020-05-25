Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3F1E0BB4
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgEYKVA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:21:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38604 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKU7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:20:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id o13so13498676otl.5;
        Mon, 25 May 2020 03:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yopzbVm+eUMJe3Fni+UwvWNShxRus/IUujJkvzqWVE=;
        b=XcuN2Zj+rixJyJtzhj7ouWDUREChjmobJsebYJrbPnGrGott11pOXJZWABpX5qzVS0
         fIkcwIEDEE3y4xYuU5DVMohVALvDhGQOZdgpiGwoAvZI0+zF1RxIpIq4w6XWi7n1al2X
         94v1dUf/zHH5jJZVVsGDEkKdHlenO01++Ho1z/eTP0nIsCsRDf/JKtWWeetYBS9iz6+C
         Q7/t5mzAtMe6yuCiq0GF0Wh6k++I9+Y+CtBBsDgBwlbKN+qm8NajN8WhBH+1lkkxL/JA
         nFb61uq+vE3+TehE7rDbb/SXwdzIEhvB4pG6neNaFch/MjHwuRqpqsUQPM0be/EywarQ
         aqxA==
X-Gm-Message-State: AOAM531a375L9BT9vX44/vSChSDL0kOOJz95uVLHBzT2CInp6pvTJUAI
        8Za2ihZmZe4gabesE6Bumgs82vHrbENRSxgfsrw=
X-Google-Smtp-Source: ABdhPJxDhX5IQzbP9fBHec+PnHe81TZt3e8ze6HJnTqmAnTlEFGXbHJQH8LnQFFSrSlOqWAleERomojOiXJm1wn7GU0=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr19234658ote.107.1590402058777;
 Mon, 25 May 2020 03:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:20:46 +0200
Message-ID: <CAMuHMdWj3MEpS35EmZQqdyQJ2c8iMiv1TWU4U9z=wgKsBQ-g4A@mail.gmail.com>
Subject: Re: [PATCH 7/8] ARM: dts: r8a7742: Add USB-DMAC and HSUSB device nodes
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
> Add usb dmac and hsusb device nodes on RZ/G1H SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

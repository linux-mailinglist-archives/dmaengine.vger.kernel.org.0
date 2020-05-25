Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A961E0BBD
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbgEYKVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:21:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42805 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:21:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id l6so15624260oic.9;
        Mon, 25 May 2020 03:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onDQQKl8qSMU7ZJx8kFKPy/mrmdvKkFjplyaEWpAtZ8=;
        b=MqEeeg21JlQKAgq63BAvIds/BrK5QhOKD/TK9QmHeXkik9NJTKbYMKymNIeXuaVf2d
         o1WrRqo8p/JgFZIiCOJnf+U3VcNDkWAIH7xsiEX+eET0m8yV5v5aawzFkRqvgA4NqUCl
         JzOEon2sYqZNpNDdqYgAEf/IsiZLWlwNXGSFyHAIjoJSDZUdoyUUDHGQKsf6MJYO5LI9
         MsSSzf0VEtiOvYFKVQRzj2m8auqlIXkv+0X5Mt84OSqCDv7DTuINU9aZAMw1asmPQ+Au
         lIr+ru+TCNi8vihkgZrxBQx6K8Pkn2Zo5UqqjU0/cMBadsyl/SAs5gEpPmMuAnQqby5P
         yHVw==
X-Gm-Message-State: AOAM53302QG8otC8LhiJAb47OkUGU0PZGVedfUmlTCOW0KzkfM1dLkYj
        zbT0tTPG15/559tt04ecYACuHNafVFm+h0MssZY=
X-Google-Smtp-Source: ABdhPJwXWWurZVIHVglb8tUexFUYYibLrikIqtMT08yZLtu7OOE70SUNhPEYM+TSeqLw2Z0Y29czRB8Y9e3cMwJbAy4=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr10818927oic.54.1590402106462;
 Mon, 25 May 2020 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:21:35 +0200
Message-ID: <CAMuHMdUfiPHJZ1i1ZfHezwzgb6O8Yirn3PPW4oqC2Yz9mch7zQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] ARM: dts: r8a7742: Add xhci support
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
> Add xhci support to R8A7742 SoC DT.
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

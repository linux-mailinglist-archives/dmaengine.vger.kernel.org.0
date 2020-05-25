Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCD1E0B5B
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbgEYKFQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:05:16 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:40380 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgEYKFQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:05:16 -0400
Received: by mail-oo1-f66.google.com with SMTP id f39so164458ooi.7;
        Mon, 25 May 2020 03:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xw1pkyh0Ir8nfmsoLVnnjIS8IfgdWiFdji6t98JfZAE=;
        b=ft0/5SNQtI4e2cYekn8i3vaIFPn7VoyLA3CIMfo1gQNgrtxjeNl5+XD7NRfyPp6SVD
         k/wXD71XQujMcPlSitNymyb/zG62IWq4xoG3hqi7cR3RM+asZQguK3dgMVHzNGGGeilT
         Orl6gkiDSx0JKNT2EDolBE9T4geX8RPxzJJth49E4znH14RUsnLfhiXQQFL5zGIhaGv6
         DDaJd8SKXHq7GSfPKAsnFbSTOHDJi9AgRo/CDW1w+42e/QQimjw/dD74ZFn188lNq7TB
         kVWghouV9TxFVoNEYSDxPGSQaeJoMHd/ZotguvavFldFuewiJk0T6Ge0cCfv5B77lgDQ
         OYxg==
X-Gm-Message-State: AOAM532QCCLCF0kVbmX2jwFQ/V8fJv4c8V+kjWdaYkDXou7VWpnCuSFZ
        ikuugA+QS61nqO1NlElOeJZV+f+6FnpFelqGMCw=
X-Google-Smtp-Source: ABdhPJwpsoXxS4SZOMLNeUtOFIvKeQ/xfHoBmbLhEQs5FjxW+RcSdEOgaeAHqrTHm23gDT4hxLApJzNpKxs3TYatHYQ=
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr12638128ooi.40.1590401113953;
 Mon, 25 May 2020 03:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:05:02 +0200
Message-ID: <CAMuHMdW=7oEj03eFmVkziZUhrSWk01AHEPAw1R1D0fmdijTAtQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: dmaengine: renesas,usb-dmac: Add binding
 for r8a7742
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
> Document RZ/G1H (R8A7742) SoC bindings.
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

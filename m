Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC641E0B42
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbgEYKDQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:03:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44051 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbgEYKDQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:03:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id y85so15531140oie.11;
        Mon, 25 May 2020 03:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rzJZvRESUr8hiAmOR4T4JGtHLkJfQBVgwOEzfB30oU=;
        b=KHoDJ1g06/9ablSyj4avenCZf2up7IuyJYDx+cIlXBdZUWWge/THMRt6IF4318Nlgq
         ozT9niJe3XRDpRmF9NOnKarxPlDSylywOZZB17F5qh7Bs/VJ3TSG/HUvZksCU/QSdHy5
         TVgvfL8Ym1AqECVkPBKS3IQ7LF+YT5JOgSayta7R/fNii7A3NGHqrSym2o3HW1rKvJj+
         WNKn5xCumIUmI1l9P1Kz1q4H/+WmRXHem7/GxE79s2POCVdFmP+Et3gUzGJgKOAD0bVB
         DKjLcNIsfdh0fjjPvUyandc90wa5N+jlpt45UEvsXSsnnVqvIabMH3NfphqdM0O+uP5T
         j/IQ==
X-Gm-Message-State: AOAM5303uk8wSAs9kYOkb4ALaD7yU6Py8QDiIkIbD2r4yRgB5/yIBZNF
        7U8TN0kXU1i6Cnoxr7+KUKrr6h4IXR1DT7Veqgw=
X-Google-Smtp-Source: ABdhPJxmoibk6taNOVQvIwHEcuzy16d0/dYI+MONoveQW1Ozul7ByEVdsRtpuOLDqvoDPswLKdn/hZl/HLC/7sEoNxE=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr10141334oig.148.1590400995429;
 Mon, 25 May 2020 03:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:03:04 +0200
Message-ID: <CAMuHMdVb-c4QKx-wBK352LKEJAPhZK+=A9R=j=XAEVfsONEgfw@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: PCI: pci-rcar-gen2: Add device tree
 support for r8a7742
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

On Sun, May 24, 2020 at 11:39 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add internal PCI bridge support for r8a7742 SoC. The Renesas RZ/G1H
> (R8A7742) internal PCI bridge is identical to the R-Car Gen2 family.
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

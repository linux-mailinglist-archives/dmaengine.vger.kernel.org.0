Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399382F34DC
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbhALP4p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 10:56:45 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:38722 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392046AbhALP4o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 10:56:44 -0500
Received: by mail-oo1-f47.google.com with SMTP id i18so695326ooh.5;
        Tue, 12 Jan 2021 07:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3QyPHhBiWRJNjfM9s/jAyHUyeZqNTdJKNXPpErhKvM=;
        b=NijGxedDi4ACgPsr1Mrtm24Ajw2psFqUmDe+ssBMmIk+czQpH+lEDUJZlqfpUj4fnn
         DKAc93vE1oeRCfNpO1+h2yxAaFs8Li6GhbNAfDBH6m7WSmXst9EEwKFsY6cWpY6OerNb
         m/G4ixVPQhXP5gDm7tiWdQYxxkFRS8VO0GAKZy+TjBBMGIwFVUkwO+hc9CJF2C5YgKqd
         hCnbqTC2C/qreCdRIVYRMBQiZ3GsnuQpLejLHS+Nh5/IDTTP/miWugHVMb8FEG7d6c+g
         9k9stgb1vYsIR5x3zCj38EcR0d9J3RveloHGTKqAZiLUjQr0dNZO8LjqzDNBrDUOH5y+
         eakA==
X-Gm-Message-State: AOAM531fNuWrWFjqSTuROGI7REml/+oCWamNSN0pOfNb6Y8O5vpcq9Ey
        BK7CtLcWfOfV+zNUF0kKHKVt3OTy4XufgiCGDtSu4lqQ
X-Google-Smtp-Source: ABdhPJwWEMbTg8cxfcrGwJdhZIUPGXjnzNMp3WtST0PtCOCtlAHJyvLNgcwadD8bKb2gZHI0dgcoeeziNgkJC45CgZo=
X-Received: by 2002:a4a:c191:: with SMTP id w17mr3240978oop.1.1610466963170;
 Tue, 12 Jan 2021 07:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210107181524.1947173-1-geert+renesas@glider.be>
In-Reply-To: <20210107181524.1947173-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 16:55:52 +0100
Message-ID: <CAMuHMdW9ca4xehcpd0yOOZPUumoebt5Jq5k5Shtm72Or45SHzg@mail.gmail.com>
Subject: Re: [PATCH 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
To:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CC linux-renesas-soc

On Thu, Jan 7, 2021 at 7:15 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series adds support for the Direct Memory Access Controller
> variant in the Renesas R-Car V3U (R8A779A0) SoC, to both DT bindings and
> driver.
>
> This has been tested on the Renesas Falcon board, using external SPI
> loopback (spi-loopback-test) on MSIOF1 and MSIOF2.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>   dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
>   dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
>   dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
>   dmaengine: rcar-dmac: Add support for R-Car V3U
>
>  .../bindings/dma/renesas,rcar-dmac.yaml       |  76 ++++++++-----
>  drivers/dma/sh/rcar-dmac.c                    | 100 ++++++++++++------
>  2 files changed, 118 insertions(+), 58 deletions(-)
>
> --
> 2.25.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds

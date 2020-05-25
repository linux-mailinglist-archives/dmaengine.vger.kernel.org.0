Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BF1E0B3A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgEYKBf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:01:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40500 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbgEYKBe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:01:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id d26so13430475otc.7;
        Mon, 25 May 2020 03:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV/6l8WsyzC8FiWpUNY+r2Jtj3u8eeprICu82Hj0+XY=;
        b=Ux4MSvsoa89TNIazEGpdFWwqCr9DEj+ZXhe2tXDSZ3qL1bR097MPSp8rISat8cffQe
         +h1Tl7L05mez6fgQKShP4PMqmNQ6x2uR1Hh5Ttgi58PC1TS8zJj+z93yoIlPSVUz9l0f
         +uHOFIuqglVCXfeuzemys3kKvtgc7/U78Q9QY92AjcNNehpCn6iAnuEyn7EgTK/Jpq0e
         +cEIstKd8jCuWz0+PhKLMn/VeBM1Cwbhfny/hCimqufs4A2gxNAwB6W/dFWE5gJP+aQf
         VwAkn9OSAaJBn3khhNkGBDZpZD4pW9QpMPMtE4Xl6snjqVcknvScZ/qg/ArIwb53NSJL
         DNaQ==
X-Gm-Message-State: AOAM530JxaI6ucoFgzCxWWDxCSnvXb01lkIp5XwFNlqfblFh1PDajmAD
        EiKwaaBabCbVMyYZJWKqr4P7dGEuTPu/9CmC6VQ=
X-Google-Smtp-Source: ABdhPJzes4OiyEEjnQUeTxYRLsuBzQ4vKfThl/Frl99MU9u9wmZ+pYZTwDk9xLH0jtn6Of53oQ19DFOqxZtclXHDOj8=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr19187412ote.107.1590400893283;
 Mon, 25 May 2020 03:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:01:21 +0200
Message-ID: <CAMuHMdXhmxhYSsnzSMQYvUa8SYd-evFi=sfxqMgYuXtxvxdWVg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: phy: rcar-gen2: Add r8a7742 support
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

On Sun, May 24, 2020 at 11:38 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add USB PHY support for r8a7742 SoC. Renesas RZ/G1H (R8A7742)
> USB PHY is identical to the R-Car Gen2 family.
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

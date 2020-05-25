Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEDC1E0BA4
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbgEYKUX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 06:20:23 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:37190 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKUX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 06:20:23 -0400
Received: by mail-oo1-f68.google.com with SMTP id r12so3509719ool.4;
        Mon, 25 May 2020 03:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ3bKV0IGk0Q2r0OiUHGmRZfloaC+oey94yGv1o2D4E=;
        b=hg0wsIjrOioazcUfGW3Zqsju50kyN9dWumrd9A+TmLvZqrTHXVYL3E9GBf5DapMvzi
         2nTj6FcSV9Mmo+Jmn9X4dRu3XTAGy6+jHRUV+Uvx38CozcvO6X7//hXaKn7zzzPrluIo
         LNUfqIw5wppB3kalV8omuaI528vNKapgfHFV8NV3X2m0SIDy2ChrXRHXWnQBxSO0AnMN
         +PBO9OUb0MIxGAcp7JKHU9T5wwhZbzll4xj9THn4uyAV5HOhT9e93cMiybyGyHLDEvHz
         MBaVRmQGEhly73Q5g7t4AHowEnImBXT7uRwu8ODyTUbX8XzZjUtKJiRbVEUpIgFFgIcS
         Kpzw==
X-Gm-Message-State: AOAM532ihQbXpKvWG7hsjBgW049U6errbvFH+qJmPE7NxyMwCjpkGsQS
        eLcocV1/iRDf8b8LB3XY1/fcx8/0r+NBNV8KRQU=
X-Google-Smtp-Source: ABdhPJyG7gY1vgATEx/zQgoz5xy+TXg0emLN8vf6Fp0mTM5+PsKO4ijltUaRMalF3tBjfNo7QxUSc3jxkBUpxrJU2Qo=
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr12678039ooi.40.1590402021986;
 Mon, 25 May 2020 03:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590356277-19993-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 12:20:10 +0200
Message-ID: <CAMuHMdUSQK2OnFM3eZ80HL4xtuqZS+fKaec1Y8moUeJ4yF1J9A@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: dts: r8a7742: Add USB 2.0 host support
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
> Describe internal PCI bridge devices, USB phy device and
> link PCI USB devices to USB phy.
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

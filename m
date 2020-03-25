Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED9192948
	for <lists+dmaengine@lfdr.de>; Wed, 25 Mar 2020 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCYNLS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Mar 2020 09:11:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36895 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYNLS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Mar 2020 09:11:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id w13so2006730oih.4;
        Wed, 25 Mar 2020 06:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYLnwtew5VKunPDMNW3rhIF1red/JpzR2kKh0qo6PZU=;
        b=oWwu7KdL2AWiRT025GHS06dsFvz2wGOu1pPWhNMT47/LYv3dUJ8cWCdteEeSo/sNdH
         6PIrlaCPCX4JjARqXELmjBfG6WZnl5SNZp60Wspv+ObOs795sxaiYfWQAKtdXg1mqhO0
         xi0tCh++9TktVCX42iLFTbRaedRot8ta2GQpPWksfBlq49IrXOUMXyiHEGG+LLgrDe3T
         AaXNbb+del+8EbfMSG0uuW7tga3TBHiM0887+O6fohW0FvT6kgm4FCj/RWflEwJAH192
         1uYXUch1zq/L9+6HwHYHhupH4BQXwsGKvxg5neE7qfTAxUqqrQVfsRkVhSlyKlIkK0u0
         ukMg==
X-Gm-Message-State: ANhLgQ28nlLBN8PlpPCMeUH1nSWhh+4y97z3DWZeYKXPhOH8JlgXcqEu
        qN0bDdnqn/x8eE0RZoKCRAoEQ4f2GJqw50EFx1OtcQ==
X-Google-Smtp-Source: ADFU+vt79au5X9xs7q6HmFPKCDXhlMCKliZtiTG1v7U/uc3JZLGhL+vqsuZcpw16lBndhOaUh4BembceGp/RtaDPIjU=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr2260205oig.153.1585141877032;
 Wed, 25 Mar 2020 06:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1585117138-8408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1585117138-8408-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Mar 2020 14:11:06 +0100
Message-ID: <CAMuHMdVWDLNhm0g1wP-jyA-UdiOfFnCNenXxqMySUqHVVgyRJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: renesas,usb-dmac: add r8a77961 support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 25, 2020 at 7:19 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds support for r8a77961 (R-Car M3-W+).
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

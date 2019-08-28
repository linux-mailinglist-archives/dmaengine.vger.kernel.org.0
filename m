Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390439FBC5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 09:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfH1Ha3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 03:30:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36512 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfH1Ha3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 03:30:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id n1so1349478oic.3;
        Wed, 28 Aug 2019 00:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uFFUgG2fl+PE0Xn05agzG2nI14mh1nZWXeP/6T/JUc=;
        b=WzzjVIe0KihewabIDKEz0w3fdz5IPx7Fr/8sWMeUY4Jtb/pIGQ+7tmTQcfcTd881Xt
         krG0Vv4YMrhCucXg36fE0wRha8fgh1fHiW7hR4t1Le3zD05l4Ce5eVtCAB9qy9R9vvLj
         XCqazOzcjlmPgT0ddpej/Wc4joHDGQImCHDK8TLWybwxgWxc7KAZuNyUSO/kgfjUdehT
         fP6Utd101/8xtIrj3Zu2JJNuPSh1LneDZBc47yhGdz9F9Jidqe7DtnSmLwCQprriFZ08
         D8E+a7Ou/AbqnB5jNeRltjNHcyeUryrfkPlYe6ILy1wrByFhXHiI09MP+8gwQcdJUGDx
         LJrw==
X-Gm-Message-State: APjAAAVEpMlY0XbudlTMBRZ7rUVJ/3+z7KW8OO1I07pOO7o36H98X04B
        7Vq5KWY+GM5yszPdzvtN0G3mNWCdoMghEAk85RI=
X-Google-Smtp-Source: APXvYqy6Aj7QiR5ojjg02TTmi5aa8CtyV1Qo+g/8uJHeTnQwaRQD9PXlCcqe5RSk0bdMxOev0BpmrxEi5T3jZpJd/lo=
X-Received: by 2002:aca:3382:: with SMTP id z124mr1805472oiz.102.1566977428785;
 Wed, 28 Aug 2019 00:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Aug 2019 09:30:17 +0200
Message-ID: <CAMuHMdVHtJTmuW0z+LRRFGL4O2bjiNv6odyGTmLi-EqxN1PP8g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

I would s/Revise/Fix/ in the subject.

On Wed, Aug 28, 2019 at 8:41 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The commit b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas
> for the generic DMA bindings") changed the property from
> dma-channel-mask to dma-channel-masks. So, this patch revises it.
>
> Fixes: b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas for the generic DMA bindings")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

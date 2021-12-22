Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9229D47CEF5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 10:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbhLVJQp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 04:16:45 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37556 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhLVJQp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 04:16:45 -0500
Received: by mail-ua1-f42.google.com with SMTP id o1so3272096uap.4;
        Wed, 22 Dec 2021 01:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvOPL3zpwlhKXcNJC0t1uuXXsPgHFENXQjcpxUeaJp0=;
        b=Z8Bg9SkjTZ6Fq05T5cjUiCn11jGDPRnik9KQwp06CGZMEwgOM/LxH0UaYwOmFNORVw
         758qTAW42yWdRBfKgoEI5w+Kb/rrlxSUpHI6NUMXQOg+Nypho+3OEKggtWcknZGo4GP0
         RvHXIJhWiPyGp6463Ch/+gAshGrMFUHTgeH+IlZOZAFAcIAy6RSGYeFvCyEAPmSt2/bU
         DKIsx/Zlwi0ig2z/iASToJkcg+OBe2RL6MwQBizFSLa/7GFbNsfrNYFMEjOdRWV6KQqN
         9PKIqv7JNpGFjvorZ7OmYjmChV6saYZpnH2CcKYzkhTSvhpxbBZshFm1w9Rv5ABovd9I
         ro2Q==
X-Gm-Message-State: AOAM531qu0n/Z7yqcayCiwunvR+uFW9EiNhcQfgDbnngZOsJ3X8OCfHg
        mSBD+ozxQmM4+Sgs4aRp1XmTnQmhblrIIA==
X-Google-Smtp-Source: ABdhPJzdO5FvWr3kEoLj6ORwj0sMm0JXQDfcvCAIRyqecM5L9HF8KzWFggzHTsxplG/W2fBIQqhQ0g==
X-Received: by 2002:ab0:65d4:: with SMTP id n20mr658120uaq.56.1640164604380;
        Wed, 22 Dec 2021 01:16:44 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id f8sm316551vkk.36.2021.12.22.01.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:16:44 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id 30so2975130uag.13;
        Wed, 22 Dec 2021 01:16:44 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr725899vsg.57.1640164604040;
 Wed, 22 Dec 2021 01:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com> <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Dec 2021 10:16:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com>
Message-ID: <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Tue, Dec 21, 2021 at 10:50 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for R-Car S4-8. We can reuse R-Car V3U code so that
> renames variable names as "gen4".
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

Perhaps you want to rename RCAR_V3U_DMACHCLR, too?
As some registers do not exist (or are not documented) on R-Car S4-8,
perhaps you want to document that in the comments for the register
definitions, too? Fortunately none of them are used by the driver.

As this patch is correct:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

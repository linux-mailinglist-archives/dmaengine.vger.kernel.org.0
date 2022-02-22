Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E75A4BF345
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 09:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiBVIOJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 03:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBVIOJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 03:14:09 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220F151D21;
        Tue, 22 Feb 2022 00:13:44 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id j9so9957433vkj.1;
        Tue, 22 Feb 2022 00:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qr9ORlOvdRYTnbcCKLusChglX3kF7TzqaSHd9n/udYU=;
        b=4r+RozdkY8BEyI2BeCVyUmCkCPyRcsRKhjgXNZFm0HR/o5IUSl7XC5vRamYpt9Hgyq
         qF8x5TLF+YaxFFk+b1cnIPcpOJ9PvQTp2tXbqiQtFQEDA24SFrZsg8POirf9apvZrl8F
         gluzeHz+a+exf3Jf/eLM+gFbu4Ws92BysO5uRtAXkikfhySSZ7CqRqGx1NlPT81HuWgh
         S+TDpQFjwGehuUXMz5+3YczeU0Os7PjeISbnh4lBfPRdYjS917FI1OVtt/l4KMGsO71p
         7MiiwGVBPu6zlSSP980Kyz5CKrrPXcgaho+WCMoWo6AsaZQN0Qcac5FqiAy04JtigDJh
         Ssaw==
X-Gm-Message-State: AOAM532Ncp4Lmg23HXLL2ucw3xkG77oUZyX+UHCKLsBS8j88P83pm4oR
        xzh30wbbMHDCqbLJbOUicJWJ/iS5i137vQ==
X-Google-Smtp-Source: ABdhPJxc+hordFvrGyRlJkLiakanSMWttMi8yMiKXPnRQKfmtoQbHrmchGdvGn7ieyaSPWo7BjIsOQ==
X-Received: by 2002:a1f:fc49:0:b0:331:ae2b:a315 with SMTP id a70-20020a1ffc49000000b00331ae2ba315mr4842843vki.2.1645517623419;
        Tue, 22 Feb 2022 00:13:43 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id y22sm2980962vsk.6.2022.02.22.00.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:13:43 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id g15so3571599ual.11;
        Tue, 22 Feb 2022 00:13:42 -0800 (PST)
X-Received: by 2002:ab0:1009:0:b0:343:779c:f40a with SMTP id
 f9-20020ab01009000000b00343779cf40amr2011264uab.89.1645517622780; Tue, 22 Feb
 2022 00:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20220221224321.11939-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220221224321.11939-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 09:13:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXF3t-mKKUZzDNVz=1sxiNBMV1Hc6a4p4NvAos2rxmEjQ@mail.gmail.com>
Message-ID: <CAMuHMdXF3t-mKKUZzDNVz=1sxiNBMV1Hc6a4p4NvAos2rxmEjQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for
 RZ_DMAC config option
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 21, 2022 at 11:43 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> RZ/V2L DMA block is identical to one found on RZ/G2L SoC. This patch adds
> ARCH_R9A07G054 dependency for RZ_DMAC config option so that the driver
> can be enabled on RZ/V2L SoC. While at it, also update config help text.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

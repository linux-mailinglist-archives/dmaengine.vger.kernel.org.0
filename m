Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141B47CEFF
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 10:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhLVJRg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 04:17:36 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41488 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbhLVJRg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 04:17:36 -0500
Received: by mail-ua1-f43.google.com with SMTP id p37so3007225uae.8;
        Wed, 22 Dec 2021 01:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1R1HNtv/pPuoLo30VVIZYsuFQPJix4kgBIlMCtSKMY=;
        b=A6NpQtdQ/ZHa4RneoEGJ7TFNMSVMGWUSucynay+r3/kzjpBw9o6aDkWPwif1Vp2sGP
         W/tToik4o73RWc2N+wQTvDDFnlXQU1YGNuB6+iOiw4YLjEzqG/0oMaxDAGqYet8/HtYG
         YZT9srdN2BPmI+7rylrdzqLDJOB7eYmWg1pfWV6WdPg3A4aTKM0Dz7/2w1mr/mRIndRU
         oDtPditUGV0M66vO5O421rytBzEniVN6vEyesHvY47HasQx786BdOJx34ak85EpGrxXe
         LFmG9QqonSCCza3aLccSYgVrtrf7RfwpZrsrD9JPWG1nSt2m7GYjlnCxrqQMwbaa3/9A
         JPrg==
X-Gm-Message-State: AOAM533GeeNzZ49sIXt1uqJ3twa3XDvcdnMUbX2a22xytggK7R879fru
        z8KK3UtP+G7rODQGLg5OmaO6VHxOkQRvGw==
X-Google-Smtp-Source: ABdhPJzS/DwfR95Qjc8JVupAIFGYWsXJmQ/uA/JcTh67dhoetEC2OvULID2B506ZUfbPXZJy6++7sw==
X-Received: by 2002:a05:6102:3a66:: with SMTP id bf6mr699260vsb.43.1640164655448;
        Wed, 22 Dec 2021 01:17:35 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id t3sm293055vsl.25.2021.12.22.01.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:17:35 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id o2so956249vkn.0;
        Wed, 22 Dec 2021 01:17:35 -0800 (PST)
X-Received: by 2002:ac5:c853:: with SMTP id g19mr713461vkm.20.1640164655149;
 Wed, 22 Dec 2021 01:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com> <20211221052722.597407-4-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20211221052722.597407-4-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Dec 2021 10:17:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWDETrBV2sx=sM=cbCCQDcLpaZ5sgiH8yduP=8oF5jfA@mail.gmail.com>
Message-ID: <CAMuHMdUWDETrBV2sx=sM=cbCCQDcLpaZ5sgiH8yduP=8oF5jfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r8a779f0: Add sys-dmac nodes
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

On Tue, Dec 21, 2021 at 10:50 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add SYS-DMAC nodes for r8a779f0.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

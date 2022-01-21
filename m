Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366A496174
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiAUOqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 09:46:44 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:43666 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381253AbiAUOqj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 09:46:39 -0500
Received: by mail-ua1-f50.google.com with SMTP id 2so17274221uax.10;
        Fri, 21 Jan 2022 06:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxPRsEioEhWwZNVwROb6Na+9U4bze12UgQ1X0XxyEKg=;
        b=lgVVor5viYZDRh0iIdNADQeDNMOkmnSHoN4s4RYn6IREpdxtss5lPfAUdfWkY/2aNy
         Rjo384O7NBTUqVQMm8iQaA0BFY/j99CQpGQChvrlEWHBHYE2qn88J9N+gtp8PIYvTWR4
         4CWBUtfTOQqBjhsn3TsHO8AlwGghfs4LuwOc1Ta90TS3MsWyox87T0n6gso0Lf8YRCdY
         y5JK3BK4nU1qecLGtIAe/f4zw2hyXnQHQ+sN9/HCxPwEZRHtfiMjyDYX8bTsBxuTBBUD
         XUn4Pc+6RUGoCwQJm0I53z2wXogGn6woehPDOPrh2h0uAQ9TfXXpL7DtQhzIUS2bJubM
         Y9ZQ==
X-Gm-Message-State: AOAM530R1WANTQ1uMTuLNbFoYsk4NBnf1kE+fg4vRN3hEVbcVJl/Wzxs
        ECeOvIsXm1sSNUYe3gvD4glLeFbZ+4E4nw==
X-Google-Smtp-Source: ABdhPJxScp8AfGSfPSJt8k9vY+myxgJwqdjOWZDvf1Q2RaVXMr6TWW6OqS8NJuXvB4PEAVxaAsTPFQ==
X-Received: by 2002:ab0:59ea:: with SMTP id k39mr1788258uad.71.1642776397988;
        Fri, 21 Jan 2022 06:46:37 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id q69sm1390004vka.21.2022.01.21.06.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 06:46:37 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id u6so17379833uaq.0;
        Fri, 21 Jan 2022 06:46:37 -0800 (PST)
X-Received: by 2002:a67:e95a:: with SMTP id p26mr1713985vso.38.1642776397567;
 Fri, 21 Jan 2022 06:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jan 2022 15:46:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUL_k0b-MrhHF6A4vrW++0--bKfcL746moRNP=0_8XP8Q@mail.gmail.com>
Message-ID: <CAMuHMdUL_k0b-MrhHF6A4vrW++0--bKfcL746moRNP=0_8XP8Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 10, 2022 at 2:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document RZ/V2L DMAC bindings. RZ/V2L DMAC is identical to one found on
> the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-dmac" will be used as a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

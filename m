Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3649446611A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Dec 2021 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbhLBKIL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Dec 2021 05:08:11 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:38849 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbhLBKHv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Dec 2021 05:07:51 -0500
Received: by mail-ua1-f53.google.com with SMTP id w23so54729463uao.5;
        Thu, 02 Dec 2021 02:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54g/h1vHmCTiyAGVZtHNa46rksNUGNErFPNGl5DOYdM=;
        b=OlV4Gu7Gk0eAB+4rlFYkODFpimQZxmg3xX+WZ6g3ygQV6r+I58bemDVqLDsg242hLd
         WfuRFypXSNxWxPYQvva+n+tNZiY0Kg9KagetenEjonNgp2mTlUS2dfzDMCALlkPOI4hh
         znvT1GDia7KcUHajdsWDUOqz0ZcAccx/1zJ4L780jb06yooUE4tmi1vHWsCXjrGKXM8h
         oPT/qrcMG/A9i4GmdVDsfNCXVzEdXFLSuBvKGIiGs3jyCvucxdfaolR9K+KyAMC30g6a
         YBHLg3wfqxOEZc3dU2Y45Ligc31JFDt6WaQLzitlXFVflP5AzAARIpSwV3/Shk88vybh
         SJNQ==
X-Gm-Message-State: AOAM533apjnL0L6yicr2zU2zp4Xq2i/nVCJzYoFQ+uNuNqL0hKIGGQUT
        IlpBOAayBJB/JvD+5KbGUODSpNqYMr8kPA==
X-Google-Smtp-Source: ABdhPJzESsx8qhHLtPxAAyeS0Fab7UPXda4RIKWcgdpAsOVB8caFYXY02b6LtrYrmQsqDMJpFQq3wA==
X-Received: by 2002:a67:efd5:: with SMTP id s21mr13802474vsp.73.1638439468388;
        Thu, 02 Dec 2021 02:04:28 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id y22sm683086vkn.42.2021.12.02.02.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 02:04:27 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id j1so18075195vkr.1;
        Thu, 02 Dec 2021 02:04:27 -0800 (PST)
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr15229249vka.20.1638439467494;
 Thu, 02 Dec 2021 02:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20211125151918.162446-1-geert@linux-m68k.org> <Yaf6wa5tyO/oCCeK@robh.at.kernel.org>
In-Reply-To: <Yaf6wa5tyO/oCCeK@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Dec 2021 11:04:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWaW2Bv4Q7LPkVDeYngRWoTMztzUHZEvpLWbDkn9epH_A@mail.gmail.com>
Message-ID: <CAMuHMdWaW2Bv4Q7LPkVDeYngRWoTMztzUHZEvpLWbDkn9epH_A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Group tuples in snps properties
To:     Rob Herring <robh@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heng Sia <jee.heng.sia@intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On Wed, Dec 1, 2021 at 11:44 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 25, 2021 at 04:19:18PM +0100, Geert Uytterhoeven wrote:
> > To improve human readability and enable automatic validation, the tuples
> > in "snps,block-size" and "snps,priority" properties should be grouped
> > using angle brackets.
>
> For these, the tools should allow either way. Where are you seeing an
> error?

Good to know. I'm not seeing any errors.

> I tried to rationalize which way should be 'correct' and gave up. I
> think bracketing only makes sense for matrix and phandle+arg cases.

That makes sense.  And "interrupts" is special, because it's really a
short-hand for "interrupts-extended", with the phandle specified by
"interrupt-parent" at the same or a higher level.

Hence I'll drop this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

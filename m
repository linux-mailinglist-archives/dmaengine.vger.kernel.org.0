Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0939B47CEEA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbhLVJNJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 04:13:09 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:41833 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhLVJNI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 04:13:08 -0500
Received: by mail-ua1-f41.google.com with SMTP id p37so2988149uae.8;
        Wed, 22 Dec 2021 01:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW/Pwg5Ke22MAchuX1prlmMQk+F7qSVh6AcCbguvgR0=;
        b=6K3RJGybQlQfcYETAcJ+fZP7vph3Scl5F+ZGxIGwucDAzdjmI5yQzQa2E+YWmOjd6t
         TCUlXl+xdBWaEADREucAOndI5t0tNVP31GXu48S3AZhH41jqJpOoO3C0JRy6P1y+UvTC
         C2vuPI1kATiwDLjhUcUuxGjM940ajZwpncPLzksB0lL2L47p4fnH5Pk1ZUm2DC3SaFax
         BBBUR2aliPVsYYugl1omj3XGt+68HZvorYotoSNH1u5nnjmisl2k0BLTvhAEQA7MNN1/
         iZFESp0kGztbmX7B6kX1B45NqxmP7Fmq1TM7VBXspr2HVLF/bZDZzqiLD8WPoA4O5xtj
         JUFQ==
X-Gm-Message-State: AOAM531j90oDOCTsZT+5secCHO7IkET4jfmru1rb6XcxHLeT2W2DXhHt
        Ct6AI6TsEnsCNvntQdA4cN1rT9HLSzciqw==
X-Google-Smtp-Source: ABdhPJxePAvMnmofP8+cl0tRMycrkicpCdPZCT2Ha13eW8cHO4Qe+UVcJKjCweHt3QQNL5fJILlCFw==
X-Received: by 2002:ab0:3c4f:: with SMTP id u15mr709432uaw.108.1640164387237;
        Wed, 22 Dec 2021 01:13:07 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id r2sm283609vsk.28.2021.12.22.01.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:13:07 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id n7so2970857uaq.12;
        Wed, 22 Dec 2021 01:13:07 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr605418vsg.68.1640164386939;
 Wed, 22 Dec 2021 01:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com> <20211221052722.597407-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20211221052722.597407-2-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Dec 2021 10:12:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWS+6wdN+3eE-A3EF74-SsY4bZrFZ+8-Now78H0U+fG1g@mail.gmail.com>
Message-ID: <CAMuHMdWS+6wdN+3eE-A3EF74-SsY4bZrFZ+8-Now78H0U+fG1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
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

Thanks for your patch!

On Tue, Dec 21, 2021 at 10:50 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document the compatible value for the Direct Memory Access Controller
> blocks in the Renesas R-Car S4-8 (R8A779F0) SoC.
>
> The most visible difference with DMAC blocks on other R-Car SoCs
> (except R8A779F0) is the move of the per-channel registers to

R8A779A0.

> a separate register block.
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

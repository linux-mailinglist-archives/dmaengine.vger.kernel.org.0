Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40D435D77
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUI7i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Oct 2021 04:59:38 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:44657 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJUI7h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Oct 2021 04:59:37 -0400
Received: by mail-ua1-f53.google.com with SMTP id r22so11716429uat.11;
        Thu, 21 Oct 2021 01:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt56pOI2593Bz4YaZuLEHtZbkcFcr6OkdM6Oq/1gjxs=;
        b=HK1t06sngZD3xVfws8Btkq1s3InncsLnQ6kVA3fToSuRxSG3PklL5iKkO4RweSkaZE
         p2rTOx/3SpYh5pxxy7V16RYMnYtQSqcxm1d18g37TYw5KSn2zb1qOA04zb+CWGd/6ez+
         kgWpaHf4QSrz0npj/On+mSSckeyfF4BJ5eicDNpnSPWjvhmZ0vg0IdIIaKyKOlLSY8HY
         ZqbUFoNZm1VCMeHBWd0CtZ2anJ2m3Xx/HYwhzLLl3f0eNdhNnlbDeNupHdcp1SMsSRDR
         yMJcU760kMYTP5h8Qe+HB1KbZbPFqyhY8WADbWshsMeb1xziKSSfBIx4onZ3879j1Cqn
         qHeg==
X-Gm-Message-State: AOAM531MRNZ97BXfm60idFwzPMrMDQZ8fRANSTntmSAZRQZPJXz0NDfA
        aKgUUhfytnb59MiW6IVqrkIx9uJTo3kvtQ==
X-Google-Smtp-Source: ABdhPJwbf0N7Q3ubDcS+tYcDopM0eZvLPqmjh/LrsUMs1rW/X9wjPRBRmC53YOEpBGpFvPn2j9gEgQ==
X-Received: by 2002:a9f:29a5:: with SMTP id s34mr4628138uas.122.1634806641535;
        Thu, 21 Oct 2021 01:57:21 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id d4sm2917220vkq.54.2021.10.21.01.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:57:21 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id q13so11835045uaq.2;
        Thu, 21 Oct 2021 01:57:20 -0700 (PDT)
X-Received: by 2002:ab0:2bd2:: with SMTP id s18mr4562481uar.78.1634806640849;
 Thu, 21 Oct 2021 01:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
In-Reply-To: <20211020143546.3436205-1-mudongliangabcd@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Oct 2021 10:57:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWs73KeXSrVBXS-8b0S6AXyOki+Fc_ST1SuWUQ6DD_3FA@mail.gmail.com>
Message-ID: <CAMuHMdWs73KeXSrVBXS-8b0S6AXyOki+Fc_ST1SuWUQ6DD_3FA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: refactor the error handling code of rcar_dmac_probe
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dongliang,

Thanks for your patch!

On Wed, Oct 20, 2021 at 4:36 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> In rcar_dmac_probe, if pm_runtime_resume_and_get fails, it forgets to
> disable runtime PM. And of_dma_controller_free should only be invoked
> after the success of of_dma_controller_register.

The second issue is actually harmless, as of_dma_controller_free()
is a no-op if the DMA controller was never registered.
Of course it doesn't hurt to improve symmetry.

> Fix this by refactoring the error handling code.
>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

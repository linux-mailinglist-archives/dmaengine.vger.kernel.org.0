Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081732051D4
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2020 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbgFWMIP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jun 2020 08:08:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43219 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbgFWMIO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Jun 2020 08:08:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id u23so16293864otq.10;
        Tue, 23 Jun 2020 05:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Re+WjjB1dMGkNf1EzZMfoTm0AtEm8gvJc3KpB0+MMw=;
        b=iQjOmUUKOIWYO9ZuueIhSoE+mqvre9RCKCEvn8LuacTFmYlNZG0kpomMmMSOMickQK
         igIarSl7Lvh5brYeF0DLMP/YXb9a2DXtU0j/CNWI3NuAbJ9HF7qcS4Q6W3CLooBQKsxT
         E5DqO5VrP2/sAU1xx/0RX8QbOpVdzIGm4fKuFkmc8Xhm4sS+G1axRvw4EPXhyBikv7F9
         5HmFMwQyq27rbapPQhPyonlK4+Z4cPlXmBiOksWig1Ar0BhUfnnkeIBIVUqz3eEVbzP1
         ODjnYWFacs4llD+QEPeQ5Ami/7iNMusonspeLGc517HaQswDOZ5p3p67kXaqZojTtBRH
         pF1w==
X-Gm-Message-State: AOAM53127YeGEojQzy34YR7J2hIwxrZLQpJ9pQ9QQ2nl6VgPLXxEdvaw
        tQVkjCguToTBPOVV6op9RAF0/nvW2TxdAiyiVIlNDVtV
X-Google-Smtp-Source: ABdhPJwjtQvaDrr3eeGnXHD1JJmS3t1dYujqHaWWHyHw8nXgJiFN/bcBSRw0jwg3owzToimpYmcrIQbYXyhdJF9PQD0=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr18196097otp.250.1592914093700;
 Tue, 23 Jun 2020 05:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054710.9915-1-dinghao.liu@zju.edu.cn> <44d7771e-5600-19c2-888a-dd226cbc4b50@nvidia.com>
In-Reply-To: <44d7771e-5600-19c2-888a-dd226cbc4b50@nvidia.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Jun 2020 14:08:02 +0200
Message-ID: <CAMuHMdVu=Tm4UTN1GAc3_uy00UhYYJ7ZPyq1qPCXQ+iP3hksfg@mail.gmail.com>
Subject: Re: [PATCH] [v4] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jon,

More stirring in the cesspool ;-)

On Tue, Jun 23, 2020 at 12:13 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> On 21/06/2020 06:47, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > when it returns an error code. Thus a pairing decrement is needed on
> > the error handling path to keep the counter balanced.
>
> So you have not mentioned here why you are using _noidle and not _put.
> Furthermore, in this patch [0] you are not using _noidle to fix the same
> problem in another driver. We should fix this in a consistent manner
> across all drivers, otherwise it leads to more confusion.
>
> Finally, Rafael mentions we should just use _put [0] and so I think we
> should follow his recommendation.
>
> Jon
>
> [0] https://lkml.org/lkml/2020/5/21/601

"_noidle() is the simplest one and it is sufficient."
https://lore.kernel.org/linux-i2c/CAJZ5v0i87NGcy9+kxubScdPDyByr8ypQWcGgBFn+V-wDd69BHQ@mail.gmail.com/

You never know what additional things the other put* variants
will start doing in the future...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

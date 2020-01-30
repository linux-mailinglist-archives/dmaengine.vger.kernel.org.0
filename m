Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A550914D763
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 09:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA3ITH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 03:19:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35490 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgA3ITH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 03:19:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so2362980otd.2;
        Thu, 30 Jan 2020 00:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3I41ZfIrOT79LBysL0u65vz33Hk4LOsapeDNAzlOAI=;
        b=Q9ARLxDxhspwnHkBdQqVpmQx85unCWld7wiALi2zP6y3dXG3i3htU4YAtPQTkoao6N
         lun8KzIKIuAmCDO5n1B3JMEAg1nYy/EBNNHmqFB6ENL/ZFPG2XSLRYqKSqkwAWvH7oWO
         of7b8zcGM1W4uIzidabriQ1XJK1+Xpb4clnDV1WLQeOEoop4cFP1No+fQwrNHg8MiM2D
         lc0qXwg3fsF6ULkSG/umuFLXZlldmS1T/GDdTf9eKXNPF0HifOIBZRdQdUUEgvbensOC
         /NERPOKu7SIOSXNONnP130geuwLZUL+6g3opP6uJYek+xHNw1WtCkd7BWjBzudQZfVS/
         4L1A==
X-Gm-Message-State: APjAAAX66znWVg6pJmqT5Z8RnhjSX/AP6LkoecUQl8WXymfc0sDz406w
        hznERwkDqOctm+nxwnjCsUZ7aC2Q6WATwOroHWA=
X-Google-Smtp-Source: APXvYqwqmdaXGxYCmHJq4Z/tqKv+f7ulnVAfvZ/0q3dXE5eP+LWDnJSN+Cu5ZkUVt32Ur/IHm3qlurwn2y4v9rtXjm8=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr2494065otf.107.1580372345508;
 Thu, 30 Jan 2020 00:19:05 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae@eucas1p1.samsung.com>
 <20200130070834.17537-1-m.szyprowski@samsung.com>
In-Reply-To: <20200130070834.17537-1-m.szyprowski@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jan 2020 09:18:54 +0100
Message-ID: <CAMuHMdWcNK_9RTaWRsEeOZ3k9=LduZOrSLcYHE8Ud1aYfZPUnA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Fix return value for dma_requrest_chan() in
 case of failure
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Marek,

s/dma_requrest_chan/dma_request_chan/ in one-line summary.

On Thu, Jan 30, 2020 at 8:08 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
> slaves") changed the dma_request_chan() function flow in such a way that
> it always returns EPROBE_DEFER in case of channels that cannot be found.
> This break the operation of the devices which have optional DMA channels
> as it puts their drivers in endless deferred probe loop. Fix this by
> propagating the proper error value.
>
> Fixes: 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and slaves")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Sorry for breaking this, and thanks a lot for your fix!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

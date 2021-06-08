Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75E53A014F
	for <lists+dmaengine@lfdr.de>; Tue,  8 Jun 2021 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhFHSu4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Jun 2021 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhFHSsR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Jun 2021 14:48:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EC1C061144
        for <dmaengine@vger.kernel.org>; Tue,  8 Jun 2021 11:44:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m21so17986216lfg.13
        for <dmaengine@vger.kernel.org>; Tue, 08 Jun 2021 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/n2yUEViCmlCbkWm7ppXR+v3Z2ScShTqfIirUWpY1w=;
        b=mLCpYalDrr2ldQuGpiD7Sk5Ev+roCMUQzBDH9k1sCaBG4ns9Zt+U59vwoH2VEorGY0
         8wnyrLqyvBbCjYqmA9WFzkzpekG8X1V1UhrVgHKMS5mbcDNyQbsX+seDVRfrOeiDdzh+
         sZ8Mp68/HAcUyIo4UOdCmSxShl3eRDvmZcP5xCSiCoBOcy0+SJLNdkg/1WE941hoFjPF
         dZ8LLQNrZ4SnyV26dAK5FLgwRgBcUpLxcMGCmxYn+k6vwjdT5Hgl0de8QbQ6i3Mv7w+y
         E8OIXDkweJa1pW+15b/YvGnDpEKZMzsPhqRsRQuxUM1lzRuv78nrTj4VAeQ9s9kvdKv0
         qBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/n2yUEViCmlCbkWm7ppXR+v3Z2ScShTqfIirUWpY1w=;
        b=kyHP8R53NBh2FwwZoEezXhn5CakGds2P++rJbuFa5Ryo69LiBanv8lPPt5KdAxFqO4
         Mnyf205sOQ/fVsu39JFGvYoUXvubsphMKpVG5wPHS1S4JlwnXWY5J89yFXW8a8qQqoMg
         EM76F2ksnEOuiHWHXA6dpzIraP+hN/i3LwTIZ75lR++Kht+jRb4iM9q5dGkePnhQy/W4
         32kMBNb7Ieb27h+N9d5Vx2e29VorV+7WN5zQCLRL9hkxtMYdqo3dfrbTH2qfZf/Tm0nG
         n5Mg6r4/Pm6MF5mCw8WtfzfTA6LlBadQITbLezEYmhJMLRZEg16aW0gTBHD4ypBeBiiJ
         iGOw==
X-Gm-Message-State: AOAM532l/D5/eS5EKn0MJpEghoW3KEyNI1E7mJqiO9/WigVTe1GREPkN
        7q1iCliCjgIJTL9R68HveLS9yTt0c5v44arfagUXbw==
X-Google-Smtp-Source: ABdhPJzzUMTXD37rDyfCeVVjDfNo9L8b3GXFxmE5KXMmeYUOMVEgqghT+XbIvoP4GqZRDLP3p61C99Bob8MFnwmvJZg=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr9020454lfb.297.1623177867232;
 Tue, 08 Jun 2021 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <1623145017-104752-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623145017-104752-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:44:16 -0700
Message-ID: <CAKwvOdkhQrnunYDtGPvyfMcjW-yMihQQZY_8VYLbD3+Y5pHryA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hyun.kwon@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 8, 2021 at 2:38 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in xilinx/xilinx_dpdma.c kernel-doc comment
> to remove a warning found by clang(make W=1 LLVM=1).
>
> drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
> xilinx_dpdma_chan_no_ostand(). Prototype was for
> xilinx_dpdma_chan_notify_no_ostand() instead.

xilinx_dpdma_chan_notify_no_ostand has static linkage, clang shouldn't
be emitting such a warning for this function.  Which tree was Abaci
run on? Do you have the original report? This warning doesn't look
right to me.

Again, the diff seems fine, but the commit message does not.

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 70b29bd..0c8739a 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
>  }
>
>  /**
> - * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
> + * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
>   * @chan: DPDMA channel
>   *
>   * Notify waiters for no outstanding event, so waiters can stop the channel
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers

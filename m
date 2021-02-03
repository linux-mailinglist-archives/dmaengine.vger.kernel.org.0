Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCDC30E082
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBCRHE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 12:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhBCRHA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 12:07:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D417C061573;
        Wed,  3 Feb 2021 09:06:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so159819pgj.4;
        Wed, 03 Feb 2021 09:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zw2i9DcKydthS+RWG0igJPT6GlIYIp2vkqtEMC3MV4g=;
        b=cnU07DYgcc2STvojkqsr0jvFdkNeQFJlC8GouLlAhkMjE1M55TzyKGTTEsRlInwCql
         SqP5Or894V2nre4E/1Vq7oxY6yGp7UvrxnkW9YxxW2EUiGLsZcPiEBFy7W+SZLSrPeR5
         +ZLPqHenCTcMzVNW+afcAaqUEXW/CRDTRIzL4sl4EA8oJFx0++9Pr+OOyi3jkS6xRR9I
         sqYXhWKbbmBsug6Z+HtR5uC3/dWNBRLBTheIYdCrJDXg0jM3z4lr9mCXGPL5B9ln0vV9
         7H1zzZNPWpHQ92MlGnCGHztgxMyhadTAnHwtr7YSWbOZw0s5zaPMK+uTKo1Hsm+Z6fYl
         EIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zw2i9DcKydthS+RWG0igJPT6GlIYIp2vkqtEMC3MV4g=;
        b=krkqwcapxwWtrK4UcS/5oewFdB5OoyQHYSZO3hbjW3CYkG3TzKViagG8r9H3uj9KDL
         a42oE97Ki9MXV7cUzTgNecrYK6JTv9C+6hbZOlz2eMDNeJRig8fUR3M/8MctcRJ+Gqco
         iwl4d8/KZBSFBzA+97zGT4XCGY+eAAHynTmsop11KolmeKxUc27QsH+UdlkY7FkrDFZg
         P7Y+7hsn3VuD1gA3fQ3HXwq0EzFEXVm+QcFcYSCy5knehgrd98hWtw7oSe23LSUO0NZZ
         x82utHDWmD747enTtS0rmKVU0j5ehI8zDvhqsCUs7BCVmtLZk3Hm+rrHIV72q6dCZ3s3
         CPbg==
X-Gm-Message-State: AOAM533+l2ltrQB7p5PQotZbi0pMvUAEDnI/8Fbbj8q3tFYsDpdsNfTB
        4+9ylvXYzYErT0VV7HXFdMY7MfUvi5R+6rLrX3q+EXAhdyIsmSnX
X-Google-Smtp-Source: ABdhPJzAms+xiS71tZmxxZMPUjAfo2Nu1DEIlujDQRLX2BoLYPbc+xbESP5NC2MuoTMyxQyr2DskSCtdIJJ2hxbvlQ0=
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id
 q20-20020a056a000854b02901b762330c5fmr3926341pfk.73.1612371979934; Wed, 03
 Feb 2021 09:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20210203155100.15034-1-cezary.rojewski@intel.com>
In-Reply-To: <20210203155100.15034-1-cezary.rojewski@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Feb 2021 19:06:03 +0200
Message-ID: <CAHp75VeuL0d48JBBQrb=twQvtwh4E_oB8Aszy+GtszhNWKqAmg@mail.gmail.com>
Subject: Re: [PATCH] Revert "dmaengine: dw: Enable runtime PM"
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viresh kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 3, 2021 at 5:53 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> This reverts commit 842067940a3e3fc008a60fee388e000219b32632.
> For some solutions e.g. sound/soc/intel/catpt, DW DMA is part of a
> compound device (in that very example, domains: ADSP, SSP0, SSP1, DMA0
> and DMA1 are part of a single entity) rather than being a standalone
> one. Driver for said device may enlist DMA to transfer data during
> suspend or resume sequences.
>
> Manipulating RPM explicitly in dw's DMA request and release channel
> functions causes suspend() to also invoke resume() for the exact same
> device. Similar situation occurs for resume() sequence. Effectively
> renders device dysfunctional after first suspend() attempt. Revert the
> change to address the problem.

I kinda had the mixed feelings about this, thanks for the report.
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Fixes tag?

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  drivers/dma/dw/core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 19a23767533a..7ab83fe601ed 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -982,11 +982,8 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
>
>         dev_vdbg(chan2dev(chan), "%s\n", __func__);
>
> -       pm_runtime_get_sync(dw->dma.dev);
> -
>         /* ASSERT:  channel is idle */
>         if (dma_readl(dw, CH_EN) & dwc->mask) {
> -               pm_runtime_put_sync_suspend(dw->dma.dev);
>                 dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
>                 return -EIO;
>         }
> @@ -1003,7 +1000,6 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
>          * We need controller-specific data to set up slave transfers.
>          */
>         if (chan->private && !dw_dma_filter(chan, chan->private)) {
> -               pm_runtime_put_sync_suspend(dw->dma.dev);
>                 dev_warn(chan2dev(chan), "Wrong controller-specific data\n");
>                 return -EINVAL;
>         }
> @@ -1047,8 +1043,6 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>         if (!dw->in_use)
>                 do_dw_dma_off(dw);
>
> -       pm_runtime_put_sync_suspend(dw->dma.dev);
> -
>         dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko

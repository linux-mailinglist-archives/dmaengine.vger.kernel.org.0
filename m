Return-Path: <dmaengine+bounces-6348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA5B41EB0
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F84A7A3DCE
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC22EA75A;
	Wed,  3 Sep 2025 12:18:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205C2E7BBA;
	Wed,  3 Sep 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901889; cv=none; b=Z0DfmDVVLoCem2mx63+61C0jeh1h1bELycqd4M34wJcI6oPI/FGvbzXvDxddia2ZmM3CCvKnA9IWruJ9fmdBtkqZnuFbPCiqWx2/CRcGfFuwiG1xtSsw9xKFPkgVT5e5eSIQfeXd39WLjEOYNHGucCrPGF+RIxBhJsjchdcdnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901889; c=relaxed/simple;
	bh=dFl0pmdaQz07Fl16URPufL0x1/vv0IsnmajehigYdM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKhaas6ReRoU9d462FrII9xMdVfXFjMdIM3LdK6xa4PHtmCIur7FXv6uUyFfdz/3bSTILNZWhsRCG3k9m295atyh4XIxpotvvI1bpFSMc8Ij0KiSt483sb8t0+U79DZBWls9T42lKTGtFXgmezJ7SLt55DjjjE/QZ0c0TfsHX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54494c3f7e3so1738397e0c.3;
        Wed, 03 Sep 2025 05:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901886; x=1757506686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4lcj+k+cV6dgenICur0LGliIrjbiJKDxgECoBH/EB4=;
        b=syEGDI6TzSv+SFm4ePdbo5KQdNWVw/Yzipc8/pWznyvkYfl504ROcpPn7akhcDhSqs
         86OK1TOlSdXn1jYz7FO/muM1raFJqu3zhkmCLIc5quUK61GoUr4kvLXBsyKDZ/jN/ruq
         aHuXOoBCz6OkM9VI9KqPSuHNEg5O0gFFRmgJoUFHZCxXd93XfDeqq1MNnli84AtLeI/Z
         Xgu+NqBjS+7YE6NB7CtBrOLeRqNofV8W3K7BMN9RMn6reCLOlq/i1FrXdcVqxF3DXn7C
         Wn/QoPrzdBLJ4nwM1yHn2zeuBq6tH4at0LVfCEMc+KpV+qXvvgmlO7e/mYB91SwMRcFd
         RdDw==
X-Forwarded-Encrypted: i=1; AJvYcCUCyop3JwyEadkWAIn13XqJOw73KS4AH7rNnyv6C/2vhclUwaWjGjwlsMRR2u1T5xg5IBvntiU8c96pyH1s/oB96Ic=@vger.kernel.org, AJvYcCUlGf40b+rIb2aUwgUHuo7UmiY6xgrHF97BSHwuRKLRF7myZ1NO/IZtqrOtLdSB3/OvBmrgmdOkyKu1@vger.kernel.org, AJvYcCV+Up244rcPAFxxZMpstzExZByiqbAGrzxYtkHIQfpzA4yF6U+9MXz7CyqPuImIeOTdynrSo7yZHQs=@vger.kernel.org, AJvYcCWgiX9ckzS9s7oLDRbCL2E6bYL8yvHjtMJte07QNK4uIp35DVlFafUDnQRWKqZtwQ2c3Vx/mTeFS/ZTSi7v@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+WRO55UWNXLNTpGiu2JjJ3eTbrjniMXIWMwGtXx4vHXIlLOq
	yGtE9JhzIqqhR5CAdelEX/YReuswGaBfGG7noWPplTRMldg5YnldbbQ7V6fsgwQu
X-Gm-Gg: ASbGncuTaKVXZlLPE53RfF/78ByfZYZa8dUo4pa3eT7SAJdgEKni/d+PIe6zRv3Ss3H
	qf881Bb0URsDqOTUcQKL7jlEkBouE4FDDljkQNeeV3hGgt4RcBdx/9yoexQnasjjCdigyBdG1ky
	ZLnOodIrC1SJOdwBwhTdkym8olSFiYfqF9qS/XoPYLtQ0my/UDUYTqLe4F4KIlACSaGmBe0TpPg
	noNAAEKByZ8PMpaUlPSw7ySTl3Nhp4R0g+d+Av/yMZRt2Wm3HLMIIRL+r3Zr9ilWX7JONLBXLwK
	F3acL4Am0L2tIR4syu+1b6iUHETIvY+JIfQNNiYB6j/4xt/KJzFGivmiMtJublH5Nj9ekD+nuHJ
	CZyXueHCvTi6UD1SZlF9outhaxwOBBMMNBYnPc7WTA5etSLH5zE4fCeqXEbJN
X-Google-Smtp-Source: AGHT+IFDnqPMO0LOavXSwTyIZnLwdds7Hj2C6t/EVBj6LZ3pkm9n+llOmkaCZxWlbhhuqd9T2LBZCg==
X-Received: by 2002:a05:6122:1789:b0:542:2912:664f with SMTP id 71dfb90a1353d-544a028d9c2mr4909015e0c.10.1756901885922;
        Wed, 03 Sep 2025 05:18:05 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54521bac78bsm1424236e0c.30.2025.09.03.05.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:18:05 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-52dec008261so1121036137.0;
        Wed, 03 Sep 2025 05:18:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHeN9ldQ6gSe3iafaSKCydXnBjNvIp5+i0lPpzuJzNLLR+A+tw60OuywL2Bwz1lELpJHxCDuSvEZPOW13PwIF22Fg=@vger.kernel.org, AJvYcCWrL6thkYQSB0lMp3yCkiTqP3AZ/1TwFfqgXFg4VPHTdqYwP+8K8jhmUor1tjWeGuCeCaMFwrs1e7nD@vger.kernel.org, AJvYcCWwOKwvvALIjE/PCU4ZGT/LviT45/llu4VH6GlfDP8Mh5VW4988Eu0htL2FEmnDLSNOeM1OkL2Dy6M=@vger.kernel.org, AJvYcCXiZAEA9aLY7q+eUz0H/fsBcrlD+o6VY+TUsRwWb4lmz70WIgra20Jmeo616hOU8CaKl7MDDt1bXlHJ/FZs@vger.kernel.org
X-Received: by 2002:a67:e707:0:b0:4fd:3b67:4572 with SMTP id
 ada2fe7eead31-52b19e70aa8mr5233687137.15.1756901884962; Wed, 03 Sep 2025
 05:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com> <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Sep 2025 14:17:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com>
X-Gm-Features: Ac12FXzjtNyL-pnc5SB9EBlg0WwsRroNd05LIL0hUHM6h97SRbLd3l-Qn2rFHnI
Message-ID: <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dmaengine: sh: rz-dmac: Add runtime PM support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tommaso,

Thanks for your patch!

I don't understand why you included this patch in a series with clock
patches. AFAIUC, there is no dependency.  Am I missing something?

On Wed, 3 Sept 2025 at 10:28, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Enable runtime power management in the rz-dmac driver by adding suspend and
> resume callbacks. This ensures the driver can correctly assert and deassert

This is not really what this patch does: the Runtime PM-related changes
just hide^Wmove reset handling into the runtime callbacks.

> the reset control and manage power state transitions during suspend and
> resume. Adding runtime PM support allows the DMA controller to reduce power

(I assume) This patch does fix resuming from _system_ suspend.

> consumption when idle and maintain correct operation across system sleep
> states, addressing the previous lack of dynamic power management in the
> driver.

The driver still does not do dynamic power management: you still call
pm_runtime_resume_and_get() from the driver's probe() .callback, and
call pm_runtime_put() only from the .remove() callback, so the device
is powered all the time.
To implement dynamic power management, you have to change that,
and call pm_runtime_resume_and_get() and pm_runtime_put() from the
.device_alloc_chan_resources() resp. .device_free_chan_resources()
callbacks (see e.g. drivers/dma/sh/rcar-dmac.c).

> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
>   * DMA engine operations
>   */
>
> +static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
> +{
> +       unsigned int i;
> +
> +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> +
> +       for (i = 0; i < dmac->n_channels; i++)
> +               rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> +}
> +
>  static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
>  {
>         struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> @@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>                 goto err_pm_disable;
>         }
>
> -       ret = reset_control_deassert(dmac->rstc);
> -       if (ret)
> -               goto err_pm_runtime_put;
> -
>         for (i = 0; i < dmac->n_channels; i++) {
>                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
>                 if (ret < 0)
> @@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
>                                   channel->lmdesc.base_dma);
>         }
>
> -       reset_control_assert(dmac->rstc);
> -err_pm_runtime_put:
>         pm_runtime_put(&pdev->dev);
>  err_pm_disable:
>         pm_runtime_disable(&pdev->dev);
> @@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
>                                   channel->lmdesc.base,
>                                   channel->lmdesc.base_dma);
>         }
> -       reset_control_assert(dmac->rstc);
>         pm_runtime_put(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
>         platform_device_put(dmac->icu.pdev);
>  }
>
> +static int rz_dmac_runtime_suspend(struct device *dev)
> +{
> +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> +
> +       return reset_control_assert(dmac->rstc);

Do you really want to reset the device (and thus loose register state)
each and every time the device is runtime-suspended?  For now it doesn't
matter much, but once you implement real dynamic power management,
it does.
I think the reset handling should be moved to the system suspend/resume
callbacks.

> +}
> +
> +static int rz_dmac_runtime_resume(struct device *dev)
> +{
> +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> +
> +       return reset_control_deassert(dmac->rstc);

Shouldn't this reinitialize some registers?
For now that indeed doesn't matter, as reset is only deasserted
from .probe(), before any register initialization.

> +}
> +
> +static int rz_dmac_resume(struct device *dev)
> +{
> +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       rz_dmac_chan_init_all(dmac);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops rz_dmac_pm_ops = {
> +       /*
> +        * TODO for system sleep/resume:
> +        *   - Wait for the current transfer to complete and stop the device,
> +        *   - Resume transfers, if any.
> +        */
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, rz_dmac_resume)
> +       RUNTIME_PM_OPS(rz_dmac_runtime_suspend, rz_dmac_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id of_rz_dmac_match[] = {
>         { .compatible = "renesas,r9a09g057-dmac", },
>         { .compatible = "renesas,rz-dmac", },
> @@ -1068,6 +1110,7 @@ MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
>
>  static struct platform_driver rz_dmac_driver = {
>         .driver         = {
> +               .pm     = pm_ptr(&rz_dmac_pm_ops),
>                 .name   = "rz-dmac",
>                 .of_match_table = of_rz_dmac_match,
>         },

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


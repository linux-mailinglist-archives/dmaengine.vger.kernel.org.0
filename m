Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5613E039
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgAPQgq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 11:36:46 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43618 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 11:36:46 -0500
Received: by mail-il1-f196.google.com with SMTP id v69so18712129ili.10;
        Thu, 16 Jan 2020 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5CUZisbEmcuPSU1emkEgklMu7uKE46FRb40awhcNNw=;
        b=EJLTwp2ZhMt6m8MIODOMxX8F0WUxZXnFllgPy0vjYRaP2a/uqLd7VgfSGrWmo8hpAJ
         NPHIjFIJGRLr4oNAz9tf5hOsdcfuVYMnqjiTf2J4RCADCuxQW+oGSsB83s4QcMRYpoPy
         vf1DpVdQTI/VdvN2YcvhWNwF4XaXJSfsa0NNO5bimCUjbA5cJJ6NJWxgsXS2WESS+fUM
         XotHwzWPyWBYZMI9ssGzm7k30A7uRYYqAYpyL23ouh5EW6o0lP2Rp5LvXf14sfItRsni
         tEMr9QVNKomtq9S+mvxD/frcA8S1mOvx2byWGDSjpzIyfdwenphPtbBOjb3rbGha0prQ
         SK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5CUZisbEmcuPSU1emkEgklMu7uKE46FRb40awhcNNw=;
        b=TUp5TzhjNk+h2WOj3yUFK93LVHevOE7wKgNdfVVxRgMv0oEcQGbsYMQ9hZBUlpLZrG
         vxiFQ1Vj1UoSwwwe/tc7+Wiza9IUVoBStit6tFdJO5hjMKkRuXiFOuAqOxJKKXpwh7YL
         yBIK4rP1Ym+KNaGStYklazb3w6XAJQe42CT/CYofZafEPJ9MsQp/5w0TUrgJsnwcEnJP
         GOX5RlqnuhRdc2jCqAuuI+Mq6kzptwNPuiz1RgCXv24rFo9mJyyeLOn5ZnMsFQ/S2DY4
         y9nySAAYk+AdNn6Y4lGzvtF8mlHX+9c92fP+R4o8YyB9lH+9kJbqO7mJOR5USaQykrWx
         UUiA==
X-Gm-Message-State: APjAAAXImM+WtoprLs2RKOgNconYGOCvSc4MqhpuNYbmY3u88+1O0jBP
        WoWdV076dDmui+oknjn2UdEV8A2BPZx1PxgL18+bqMGj
X-Google-Smtp-Source: APXvYqxwMlno7wjUoiFGxFWb2n/ehu6lv/LisVmo7tUhvmCPmOwoAt13VzXh6hngJWSHaeNKOw/agO1BB94B4lZ59eo=
X-Received: by 2002:a92:3d17:: with SMTP id k23mr4375754ila.110.1579192605275;
 Thu, 16 Jan 2020 08:36:45 -0800 (PST)
MIME-Version: 1.0
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
 <1579038243-28550-4-git-send-email-han.xu@nxp.com> <20200115080257.dtd4vss4uhopbvn2@pengutronix.de>
In-Reply-To: <20200115080257.dtd4vss4uhopbvn2@pengutronix.de>
From:   Han Xu <xhnjupt@gmail.com>
Date:   Thu, 16 Jan 2020 10:36:33 -0600
Message-ID: <CA+EcR23TCUU83Y7BYX5LCvGAj20+s67n+rWaGR5R9BSMHUH82A@mail.gmail.com>
Subject: Re: [PATCH 3/6] dmaengine: mxs: add the power management functions
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Han Xu <han.xu@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Esben Haabendal <esben@geanix.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 15, 2020 at 2:03 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Wed, Jan 15, 2020 at 05:44:00AM +0800, Han Xu wrote:
> > add the power management functions and leverage the runtime pm for
> > system suspend/resume
> >
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > ---
> >  drivers/dma/mxs-dma.c | 97 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 90 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index b458f06f9067..251492c5ea58 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/of_dma.h>
> >  #include <linux/list.h>
> >  #include <linux/dma/mxs-dma.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <asm/irq.h>
> >
> > @@ -39,6 +40,8 @@
> >  #define dma_is_apbh(mxs_dma) ((mxs_dma)->type == MXS_DMA_APBH)
> >  #define apbh_is_old(mxs_dma) ((mxs_dma)->dev_id == IMX23_DMA)
> >
> > +#define MXS_DMA_RPM_TIMEOUT 50 /* ms */
> > +
> >  #define HW_APBHX_CTRL0                               0x000
> >  #define BM_APBH_CTRL0_APB_BURST8_EN          (1 << 29)
> >  #define BM_APBH_CTRL0_APB_BURST_EN           (1 << 28)
> > @@ -416,6 +419,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> >  {
> >       struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> >       struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> > +     struct device *dev = &mxs_dma->pdev->dev;
> >       int ret;
> >
> >       mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
> > @@ -431,9 +435,11 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
> >       if (ret)
> >               goto err_irq;
> >
> > -     ret = clk_prepare_enable(mxs_dma->clk);
> > -     if (ret)
> > +     ret = pm_runtime_get_sync(dev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to enable clock\n");
> >               goto err_clk;
>
> From looking at other DMA drivers I know we are in good company here,
> but I think this is wrong. Doing pm_runtime_get_sync() in
> alloc_chan_resources() and going to autosuspend in free_chan_resources()
> effectively disables runtime_pm as clients normally acquire their
> channels during driver probe and release them only in driver remove.

Thanks for the comments.
That's why I moved acquire_dma_resource from the probe to
runtime_resume in the gpmi driver, this change won't disable the
runtime_pm function and the incremental counter always balanced.

>
> In the next patch you release the DMA channels in the GPMI nand drivers
> runtime_suspend hook just to somehow trigger the runtime_suspend of the
> DMA driver.
>
> What you should do instead is to make sure the hook runtime_pm to the
> DMA drivers activity phases, like for example the pl330 driver does.
> Then you wouldn't have to care about manually putting the DMA driver into
> suspend from the GPMI NAND driver.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Sincerely,

Han XU

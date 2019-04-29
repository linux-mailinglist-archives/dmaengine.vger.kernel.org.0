Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8AE21D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfD2MUk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 08:20:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38038 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2MUk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Apr 2019 08:20:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id t70so2525396oif.5
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2019 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFO0p/7UJRpxLYopOdRBBRpDf4lmxD0/G7tl+RGmL9s=;
        b=uNM939BHOv4+pdSPK+Vzc1/5zuB63RUW5hgUqQ8Hvx4yfKIDCXAC1oMA0G6OuEyHnX
         /YNeO7H0d+7nGGHTKK8hd4GR5qk4CYC0ZtE9XZTRpdRvxYvEw7vpMMUCq0D0CbIAxomt
         vHxpGTDGwa9PG+wkPmhPxy0QsCYz0SwAXIRCEgkmaA2BgKyWJvL5yryq3oE7qaSUq0k4
         0lZaFwbW2VLyNRntMGB0m9bbY+EyEjwUbCEGA9U3hzDe94M2QfBqL+kDdO0TUrLxBkPE
         1LPMAD6T9vn74cRN6leBRQRzEBCXIy+qP6Q2IhvaX93CREg5Cc1XQQmc/J6lhy+VhxvG
         zoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFO0p/7UJRpxLYopOdRBBRpDf4lmxD0/G7tl+RGmL9s=;
        b=FXSEiKuDJBmiDzK0YWIQLfCcax4vDtpmqRvmIbMQmb8pPALjsQS/YI3fOrVXK8gnuU
         FpghUs/6wJ2XApkFB0i+w3NXB5cXNHch365x7M0hXXf4pl3/zBuL7b6I5q/txyr5qucn
         HApe1FS0kI6CiiYkAk8yMuTnF0IPmvEJ7RCJZCXB6Q8NhBxIBWOftqe2yPseDBb4J2G9
         JDrCMeAeIyG7f+Yk9gJeA9DDdQYk4BVXdlx28fCaxix/ij/b9/wDyczEyFLckLIlChoi
         ryGL8jGluS2tNi6+SOmiUYZIhe3Znda2K9azvup4XU35jnmf/3RwREecgX2otka+N0w/
         j80w==
X-Gm-Message-State: APjAAAVhw+AT5UW+nbtW63ivWTvFyG4A7f9ovxc5Tptir2eLf5lzRS9f
        dhmIk2NTE7sLbN4zowko1VjsCKNPOJTCdVN+VOFthQ==
X-Google-Smtp-Source: APXvYqzTmh9x7vaRytwBmnlAbmJCtwWQ8MTSGQxCK2lTPxYWKsNUzTE5riEh/it8vk8shHd+EM/kUWbicbcbSKV2Y88=
X-Received: by 2002:aca:61c3:: with SMTP id v186mr15973210oib.27.1556540438914;
 Mon, 29 Apr 2019 05:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink>
In-Reply-To: <20190429115723.GK3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 29 Apr 2019 20:20:26 +0800
Message-ID: <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-04-19, 20:14, Baolin Wang wrote:
> > From: Eric Long <eric.long@unisoc.com>
> >
> > Since we can support multiple DMA engine controllers, we should add
> > device validation in filter function to check if the correct controller
> > to be requested.
> >
> > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/dma/sprd-dma.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index 0f92e60..9f99d4b 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> >  {
> >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > +     struct of_phandle_args *dma_spec =
> > +             container_of(param, struct of_phandle_args, args[0]);
> >       u32 slave_id = *(u32 *)param;
> >
> > +     if (chan->device->dev->of_node != dma_spec->np)
>
> Are you not using of_dma_find_controller() that does this, so this would
> be useless!

Yes, we can use of_dma_find_controller(), but that will be a little
complicated than current solution. Since we need introduce one
structure to save the node to validate in the filter function like
below, which seems make things complicated. But if you still like to
use of_dma_find_controller(), I can change to use it in next version.
Thank.

struct sprd_dma_filter_param {
     struct device_node *np;
};

static struct dma_chan* sprd_dma_xlate(struct of_phandle_args
*dma_spec, struct of_dma *of_dma)
{
    param.np = dma_spec->node;

    return dma_request_channel(xxx);
}

of_dma_controller_register(np, sprd_dma_xlate, sdev);

-- 
Baolin Wang
Best Regards

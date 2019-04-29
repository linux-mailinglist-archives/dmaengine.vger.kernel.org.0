Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D0CE18E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfD2LtR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 07:49:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33101 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbfD2LtR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Apr 2019 07:49:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id s11so3985568otp.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2019 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYDvYsD7vm9de86thItX5OqkUb2XqGh4QsUmBR6DvzQ=;
        b=eE78XoupObinxdP2tF2TRd372B+Ugnx1YhJQQ7sa3QK5Bri8moF6Ouu45b7sCRFDW2
         X4ZSKXhGYeDuO8UsZUxi/5IDlSKD2H8AXspi6EHQAelo+d/+uHOn8OPwcJvQLcF0xm20
         +ldumwxYB6h/2+D7h1iMukTpyubDZuhWwrjg8T+HrlLwYtfCizpmHiuD1vobez/DKYkp
         Cn1A08OkAjt/Z8aVydIFWx13REL10X44PgohhXRcN5dhLptJcRelPTi9+szc+TG/Zle8
         W5pY/BamAXqf/Y6WpFFqHRa7DAQ4qjzM6mXaAgh7FzmRQwysNLQfR3l7MqMhZQl+RvD2
         5Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYDvYsD7vm9de86thItX5OqkUb2XqGh4QsUmBR6DvzQ=;
        b=W3Ksvz1+bvBhviuUToP+ChrMiJx5mb8VRcS0KoOvbqm3DyhZpio36sciVVn8wyr4uh
         PCrvoUQx/H8OlnJs7ejHRKsBnme2xJNpP6KYtSn9h6FYRyE/aF7jv+k6xVOfyC+dhwSd
         5tJs7bExkRx8OXHkzeXrKHIrjfvQf5c0l/56y42y1nWu+7QTFPYXqAG/hCgXvWtBc114
         44eynSItYvNMzeHgX+gXTzMDtMZcNJq2A2pBTogwOBjz5CqpIu4iRRXRd0bhi2NwVP1s
         VMnrUyy+oVsYaVF0HCs+IVeEYCXUo8QyeEtnIMeKzlIU07McwfyqnYUSwQ5DIUKg/WhK
         544g==
X-Gm-Message-State: APjAAAXAC3ylR54WPiPx1M7DGf9/6IlvYgDgsNVvA3aBCKeT0CbQ6Z6u
        oaCPxWZrCMZXxEBpi8QhjSfGb3hqF52euTzk4bw19Q==
X-Google-Smtp-Source: APXvYqztn5+6dKQKN9rJen87uREhHeHbRfuKnL7Aoc1dAALWLuQn5eqBCwEzUOfb8/eBbK9Pj5VM1EMVq/qgGU6y/OY=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr18399492otl.191.1556538555961;
 Mon, 29 Apr 2019 04:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <2eecd528e85377f03e6fbc5e7d6544b9c9f59cb1.1555330115.git.baolin.wang@linaro.org>
 <20190429113555.GI3845@vkoul-mobl.Dlink>
In-Reply-To: <20190429113555.GI3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 29 Apr 2019 19:49:04 +0800
Message-ID: <CAMz4kuK0jurdNX3Z+zH5_ErR-64k2-Nuw_1T+X4OjbjURDSnUA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dmaengine: sprd: Fix the possible crash when getting
 engine status
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

Hi Vinod,

On Mon, 29 Apr 2019 at 19:36, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-04-19, 20:14, Baolin Wang wrote:
> > We will get a NULL virtual descriptor by vchan_find_desc() when the descriptor
> > has been submitted, that will crash the kernel when getting the engine status.
>
> No that is wrong, status is for descriptor and not engine!

Sure, will fix the commit message.

>
> > In this case, since the descriptor has been submitted, which means the pointer
> > 'schan->cur_desc' will point to the current descriptor, then we can use
> > 'schan->cur_desc' to get the engine status to avoid this issue.
>
> Nope, since the descriptor is completed, you return with residue as 0
> and DMA_COMPLETE status!

No, the descriptor is not completed now. If it is completed, we will
return 0 with DMA_COMPLETE status. But now the descriptor is on
progress, we should get the descriptor to return current residue.
Sorry for confusing description.

>
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/dma/sprd-dma.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index 48431e2..e29342a 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -625,7 +625,7 @@ static enum dma_status sprd_dma_tx_status(struct dma_chan *chan,
> >               else
> >                       pos = 0;
> >       } else if (schan->cur_desc && schan->cur_desc->vd.tx.cookie == cookie) {
> > -             struct sprd_dma_desc *sdesc = to_sprd_dma_desc(vd);
> > +             struct sprd_dma_desc *sdesc = schan->cur_desc;
> >
> >               if (sdesc->dir == DMA_DEV_TO_MEM)
> >                       pos = sprd_dma_get_dst_addr(schan);
> > --
> > 1.7.9.5
>
> --
> ~Vinod



-- 
Baolin Wang
Best Regards

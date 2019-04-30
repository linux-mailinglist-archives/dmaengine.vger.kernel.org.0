Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D375F006
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 07:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfD3FhM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 01:37:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38926 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3FhL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Apr 2019 01:37:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id n187so10274547oih.6
        for <dmaengine@vger.kernel.org>; Mon, 29 Apr 2019 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJvFcVfqwgzIS1NBj3zREVCrtd868vw/Fv4Z5EAQunA=;
        b=srrwKdo+8+Nl0Xj4jaF3DS5rdaY0nf2MjiA+86H3DvfVKYkeQzY/nVWWf5iUK7h1c1
         inxR0Dmfk3NvKggZ6AWmXRkfDqtTe0D+SQo5Fs8rGj3CYHkyV3FU/3Wm2h1oY2K2Zv3B
         KM2ilmDA/7l47VZamM+Huh8qUVy9cwwV8GKlymi2JEu3/ScTdjEqccs9a83Lxf+yeGvN
         5GeQW656+mtkEMSrG84JmCfdX2t9i8hozKcbzmUp1TrGA7txCt6RudN7eXd4IXvEzUzQ
         zDXOajM02kKVNw/gBGUxRdMrsm6l1WK2RBd2Lg0CvHlCy9L0fc2X4SoN+tZ0dE/S5bRU
         gNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJvFcVfqwgzIS1NBj3zREVCrtd868vw/Fv4Z5EAQunA=;
        b=MRmEwD8uIfEYfztDMidxHFiUJG/lvsJoGBcVbz5DcWHie6JzeXrL1aZfcm9bDeOZNw
         bvQ4aCDCGVvB4X9TSTemmGvZeI96tr4mB9xXluqSz39GdHMCv1oduISn87O1VR3kWmKU
         UMmfMtUOJr9VSRT4OeEXGZQ9oWtmapx5iDAY4IX6vjcyw7s/EA1p+kaEAWMThAKHeJea
         rwxoYx0j7xPdxEC9gII8TC7lD5iYo8vdh4KXQJHZ6ggNq2XLp/XlKa+ctHw2pDXvS4SF
         wyUqFnde5T1zq74cGGep7SBv8Te/NQLwRQs2SA5QvAc5pi1Xkz7cXNx+04UuCZxNP//f
         j7rA==
X-Gm-Message-State: APjAAAXzcnKx3peEih0EVoon9PoTH0eC2IGsY4h6wLPPNKC5y67rdd3P
        76IHKJHj2WLhpna5t5OojM4nLX22WH6Dp6byn/sVgw==
X-Google-Smtp-Source: APXvYqxV85nlYUiFaiqVW4I+2fGjsKRIMiGplegwOmEzvP7k+idaz1rr7N/BVvcysL3xxh6fOdtJZ1eFuGeHcJ1kku8=
X-Received: by 2002:aca:ad82:: with SMTP id w124mr1927437oie.33.1556602631029;
 Mon, 29 Apr 2019 22:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
 <20190429120108.GL3845@vkoul-mobl.Dlink> <CAMz4kuJB2+6HziyDep4ctfmjFYpmZ-v_vrFQsJ9tHvwYzSJeKA@mail.gmail.com>
 <20190429141009.GO3845@vkoul-mobl.Dlink>
In-Reply-To: <20190429141009.GO3845@vkoul-mobl.Dlink>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 30 Apr 2019 13:37:00 +0800
Message-ID: <CAMz4kuJ6EUbaHKCnQeYrJB+TjgaZGt=590C89t6i26meMdGsKA@mail.gmail.com>
Subject: Re: [PATCH 7/7] dmaengine: sprd: Add interrupt support for 2-stage transfer
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

On Mon, 29 Apr 2019 at 22:10, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 29-04-19, 20:11, Baolin Wang wrote:
> > On Mon, 29 Apr 2019 at 20:01, Vinod Koul <vkoul@kernel.org> wrote:
> > > On 15-04-19, 20:15, Baolin Wang wrote:
>
> > > > @@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> > > >               val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> > > >               val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> > > >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > > > +             if (schan->int_type != SPRD_DMA_NO_INT)
> > >
> > > Who configure int_type?
> >
> > The int_type is configured through the flags of
> > sprd_dma_prep_slave_sg() by users, see:
> > https://elixir.bootlin.com/linux/v5.1-rc6/source/include/linux/dma/sprd-dma.h#L9
>
> Please use DMA_PREP_INTERRUPT flag instead!

We can not use DMA_PREP_INTERRUPT flag, since we have some Spreadtrum
specific DMA interrupt flags configured by users, which I think we
have made a consensus before. See:
https://elixir.bootlin.com/linux/v5.1-rc6/source/include/linux/dma/sprd-dma.h#L105

-- 
Baolin Wang
Best Regards

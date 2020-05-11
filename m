Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781F91CDC56
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgEKN7C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730153AbgEKN7C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 09:59:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063AC061A0C;
        Mon, 11 May 2020 06:59:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s20so3977592plp.6;
        Mon, 11 May 2020 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEIvh3jZJq+GIyJboY8LqqnCPNcN8dIguJBZTjRlCk4=;
        b=YB5hOE9l2jYX/jRF0LNvB/eltbhtnNpVB1Svk2f+VbWyezfJhmemBjI1KpIcc4PKKb
         wExB22WUJkkJyStwHTNvLrojk72AmUto+5/xJUAlNiGWUBkfyS14oAfJ5JXO+cyh8mmX
         Mp3bOsUX1sV3efRSUf72d54OhpnphPPhycEvdZfT+l4tn5fuYzQ2qx/fN/6FM3IrxtFb
         dovMbmTfkDBFA+xMg/u8HZTeJwM5XgP7SwDm2ZhxA2BJ84JBeYqqWRTzr8zMyoNGvRCl
         qi3Q3eq71YyO1eN1pzT88DxoLTzCWvTGthuSAGQT1ze6PMvKhjA4RgVrWWjCyFuXLr+q
         LYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEIvh3jZJq+GIyJboY8LqqnCPNcN8dIguJBZTjRlCk4=;
        b=fx7RTe/j7HxM8ShozVVjm2iNAF1NJtPCfKAvqzYVjUXzkFHOY3TAF99TRtu6z4CXl7
         wYDqnuX3jZgKRLiPNu10FRYvWbZE1qzf5hzp7r9Fkqk9AU9h96g4C7AxkiaxJ8jET387
         7vJYFkB+HaEETXeDpXZ2Cd+XZxivN2qvqqPbI8Geh7EkUrgi43XFMKSw9ncuVhq+q1NK
         pgH72mnhTAnFzoKZyPGYeLcudUGWmiBoEHak2QFyu2JR9ztMnKtv7yoo0lr0+b0dYwBP
         q6E+Axk1E1Bm0G2GX4XyKPfgZ0Ir3jcpwkNS+ebKNU8XPoWSmqI0rhRrHgztuvHqYxad
         Y0mg==
X-Gm-Message-State: AGi0PuZvTmuRg6snqh3LfEJLrI/dOtZYO6Ojd5Oy2i7+ClYG4SOLm+Ih
        r3GwLtqSe9AYRJe2QhMkc1++0hjEWPvjJdq4eNNX56PK
X-Google-Smtp-Source: APiQypIB31uuk+a3fTSz6ya4QV/kV9bztOcHX1UG5aCskc1fav+TQguLBT2Cbm/aZiOYqODRvcuIgtcdPL2/TjRWFs8=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr23250451pjb.228.1589205540218;
 Mon, 11 May 2020 06:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com> <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation> <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
In-Reply-To: <20200511134502.hjbu5evkiuh75chr@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 May 2020 16:58:53 +0300
Message-ID: <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is unsupported
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 4:48 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:
> > On Mon, May 11, 2020 at 05:10:16AM +0300, Serge Semin wrote:
> >
> > > Alas linearizing the SPI messages won't help in this case because the DW DMA
> > > driver will split it into the max transaction chunks anyway.
> >
> > That sounds like you need to also impose a limit on the maximum message
> > size as well then, with that you should be able to handle messages up
> > to whatever that limit is.  There's code for that bit already, so long
> > as the limit is not too low it should be fine for most devices and
> > client drivers can see the limit so they can be updated to work with it
> > if needed.
>
> Hmm, this might work. The problem will be with imposing such limitation through
> the DW APB SSI driver. In order to do this I need to know:
> 1) Whether multi-block LLP is supported by the DW DMA controller.
> 2) Maximum DW DMA transfer block size.
> Then I'll be able to use this information in the can_dma() callback to enable
> the DMA xfers only for the safe transfers. Did you mean something like this when
> you said "There's code for that bit already" ? If you meant the max_dma_len
> parameter, then setting it won't work, because it just limits the SG items size
> not the total length of a single transfer.
>
> So the question is of how to export the multi-block LLP flag from DW DMAc
> driver. Andy?

I'm not sure I understand why do you need this being exported. Just
always supply SG list out of single entry and define the length
according to the maximum segment size (it's done IIRC in SPI core).

-- 
With Best Regards,
Andy Shevchenko

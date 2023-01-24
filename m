Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E932679A7C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjAXNs1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjAXNsK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 08:48:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA749038;
        Tue, 24 Jan 2023 05:46:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ss4so39011016ejb.11;
        Tue, 24 Jan 2023 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJR+SqoG7Y6z7Fd4lCaXOHkp5vK+lAqzG3rI6CwOzWw=;
        b=HrQYKBHRtgBaJ1TxPuB/g0eDJtgfWevg6jNoS/HoQPPnMUqzmEIxFGHJ07YtFSQukD
         49l6QejvEHq5KHdUa5jGGFrcjIkn3Lha9qAoYN4XXxDIJLaZq3SPUjPww8i3b6jyb54d
         OK3XCzhYkv6k6BR+L0ki1izMEVtGUSPKlR0kZFfbIH/mXCKBOAH/KaZte3cg9Zt75Px4
         Y07uL369ALCegoPvHLd9iUxwigvDJCHixt254ZSVQ4UscTfoNbjwT/Mezn6+O++3zCy1
         4Vj8+Tgr8RlD6Y25RgBclFLqfGph0rFcWLsL4Ke6N0f7T3zPY5aKCvXsiKP+NPJDpBBm
         p1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJR+SqoG7Y6z7Fd4lCaXOHkp5vK+lAqzG3rI6CwOzWw=;
        b=aFrinzU0wiKUMH9lox5qAJGUxA3eg79dZVzmFmgL42eVLXXWaMPcUvNQ2Nv8W2NNza
         N9BerxYhWqSi7wZBa5VeZBgareDT8XZfVpyemZdG4T9lMzRzQPeseKMIpFASvfCBBBQ0
         0eI2aV0S+C+elIJAk9H7YCEn7+Aq1R9jsoJMUo6EV0toHjihZ8I4wEVsV5U0NP12ADPz
         TM3yKx7pntQHkpOwNzQ6xusfJZEnnk2gX5ItTPpGc9ryq738fZaNl0gZp32xBvnwkAm2
         Im+aFpJv1P1GtpRPeHDes/OpSwnZyLNJ5clLcdhVdz2QXu9RHF9KbhLKhK/jkJB6pwUs
         SfTA==
X-Gm-Message-State: AFqh2kq+Mb19SXSZPREl5PynCvdntxk75AmUjfTAijELxIrxYrLM/lQg
        5Dv99a7/1mEpVnfGIl51PFs=
X-Google-Smtp-Source: AMrXdXu9CJsHxcvSJ6zp0H/luWGL1RXkaMNlc6p64s5C/N/q96rgMr1j5BhpFr9jx8akzqr6Kl1/ZA==
X-Received: by 2002:a17:907:6f18:b0:7c1:98d:a8a3 with SMTP id sy24-20020a1709076f1800b007c1098da8a3mr29527990ejc.7.1674567883747;
        Tue, 24 Jan 2023 05:44:43 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a170906481200b008778f177fbesm951530ejq.11.2023.01.24.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:44:43 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:44:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20230124134440.mg6jxbk6bp5xetv7@mobilestation>
References: <20230121230359.kqfm4kvwys2jdan6@mobilestation>
 <20230123163709.GA891421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123163709.GA891421@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 23, 2023 at 10:37:09AM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 22, 2023 at 02:03:59AM +0300, Serge Semin wrote:
> > On Fri, Jan 20, 2023 at 06:54:01PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 13, 2023 at 08:14:01PM +0300, Serge Semin wrote:
> > > > Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> > > > possible to use the already available non-atomic readq/writeq methods
> > > > implemented exactly for such cases. They are defined in the dedicated
> > > > header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> > > > if the 64-bits readq/writeq methods are unavailable on some platforms at
> > > > consideration, the corresponding drivers can have any of these headers
> > > > included and stop locally re-implementing the 64-bits IO accessors taking
> > > > into account the non-atomic nature of the included methods. Let's do that
> > > > in the DW eDMA driver too. Note by doing so we can discard the
> > > > CONFIG_64BIT config ifdefs from the code.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 55 +++++++++------------------
> > > >  1 file changed, 18 insertions(+), 37 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > index 66f296daac5a..51a34b43434c 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > @@ -8,6 +8,8 @@
> > > >  
> > > >  #include <linux/bitfield.h>
> > > >  
> > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > > +
> > > >  #include "dw-edma-core.h"
> > > >  #include "dw-edma-v0-core.h"
> > > >  #include "dw-edma-v0-regs.h"
> > > > @@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > > >  		SET_32(dw, rd_##name, value);		\
> > > >  	} while (0)
> > > >  
> > > > -#ifdef CONFIG_64BIT
> > > > -
> > > >  #define SET_64(dw, name, value)				\
> > > >  	writeq(value, &(__dw_regs(dw)->name))
> > > >  
> > > > @@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > > >  		SET_64(dw, rd_##name, value);		\
> > > >  	} while (0)
> > > >  
> > > > -#endif /* CONFIG_64BIT */
> > > 
> > 
> > > Great to get rid of these #ifdefs!
> > > 
> > > Am I missing something?  It looks like SET_64 is used only by
> > > SET_RW_64 and SET_BOTH_64, and neither of *them is used at all.
> > > 
> > > Similarly for GET_64 and GET_RW_64.
> > > 
> > > So maybe we could get rid of everything inside the #ifdefs as well?
> > 
> > Even though these macros are indeed unused in the driver they are
> > still a part of the DW eDMA CSRs access interface. In particular they
> > are supposed to be used to access the 64-bit registers declared in the
> > dw_edma_v0_regs, dw_edma_v0_unroll and dw_edma_v0_ch_regs structures.
> > So until the interface is converted to a more preferable direct MMIO
> > usage without any packed-structures I'd rather leave these macros
> > be.
> > ...
> 
> > As I said above I'd rather leave the 64-bit accessors be until the
> > packed structure-based interface is removed from the driver.
> 
> I wouldn't bother polishing something that's unused since it can't be
> tested, it's easy to resurrect from the history if/when it becomes
> necessary, and it makes it much harder to connect the commit log with
> the code change.  But this isn't a drivers/pci change, so I'm fine
> with it since Vinod acked it.
> 

> I guess the point is that when !CONFIG_64BIT, there was no writeq() so
> we used SET_LL_32 twice.  linux/io-64-nonatomic-lo-hi.h provides that
> writeq() implementation, so we can define and use SET_LL_64 for that
> case.

Right. That's what is done in this patch.

-Serge(y)

> 
> Bjorn

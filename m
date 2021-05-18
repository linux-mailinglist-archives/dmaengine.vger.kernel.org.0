Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C874F387C9D
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbhERPko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350260AbhERPkn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 May 2021 11:40:43 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D0C061763
        for <dmaengine@vger.kernel.org>; Tue, 18 May 2021 08:39:24 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so1164919otg.9
        for <dmaengine@vger.kernel.org>; Tue, 18 May 2021 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hSwqPBR8xk5peOjp8r36zshPTihxbD5KyZ7/NEBH24=;
        b=mvj1ormvns6c8e+ic/PsSJNg9DLr9kf/17VvtRI2XtMI//1llYzD/QpQuvPakUJYQQ
         DS+Xo/uoPIJyjHoavYY7zuWK4qVVV83WVk5nAn7MDmEsl2vw0uz1xsLweQYC/9dTzzRV
         ghr128tExjqZBppdRqp8xWwxJxE68i7ZTjFXGbfJPFUT9aWJyvLRdh3QWPkRkYnXtm3T
         zrCwTYgf17p8ER1Pg5Xx1kYVK5BPy71uz1Lto2qzL+gIYXWfHrE0RCY/SPzUIGJYMqlV
         +BRUesvZx2dingYSETXNoJPVsjGINfdPZ7JjYsY39BlCrS8AMVaG+GwJF7MJ4hKWkcDX
         W6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hSwqPBR8xk5peOjp8r36zshPTihxbD5KyZ7/NEBH24=;
        b=d2v7+LDq2r3fjxm6Es4cfSq/tQ74y58mupUVCbTEt6hDqbQd6dHtkZzz191GQAkyfp
         DhcEObnI0djxE64CMEYke6RfdNRJxTQkVSGYfkjSjpu2v4pkArE4ow2ShoiWw9kxy91h
         /8DLMS4CZOTW2WoVRsZOS9+ftYyQOVyGSvb0oqFHl58k7Y9i4nRJxvtCtCRB4Fss5N8w
         YzMEgOo4yIV5VN4doyN+6sFCehK8T0fUsVcc0OvfZQwSGmYLZOx9BAWPqI37xCGv4I4K
         Mp1AWKWq8akOyalSI45qBVcXpjqYM+DwzoLtdEt90BftHnSVMPIxgN5cGrryH009D367
         9++w==
X-Gm-Message-State: AOAM531AsYiEm0GyWheZLQkh5KhOeG9+rEnLE4wWexG+yyyg/UTNrqoZ
        XYVX/B4Q0jz5N1RpBi5zLYCGt4gOQ/CYfI8XhLaEYg==
X-Google-Smtp-Source: ABdhPJxs5EkaQ8cVqMmDDyuAeI4LeAKT2u8OFSqwXjSjLKhqFVkkYjQ9FPfi1Tdv13wngOPWcvaW1DPF7TKLro0KyJ0=
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr4807826otl.155.1621352363686;
 Tue, 18 May 2021 08:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
 <20210505213731.538612-10-bhupesh.sharma@linaro.org> <20210518150702.GW2484@yoga>
In-Reply-To: <20210518150702.GW2484@yoga>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 18 May 2021 21:09:12 +0530
Message-ID: <CAH=2NtxMR5zCBJ7_u3kT9Koewv3Ay4baH8YQ9frX2uhO2gDM=Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] crypto: qce: core: Add support to initialize
 interconnect path
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bjorn,

Thanks for the review.

On Tue, 18 May 2021 at 20:37, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 05 May 16:37 CDT 2021, Bhupesh Sharma wrote:
>
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > Crypto engine on certain Snapdragon processors like sm8150, sm8250, sm8350
> > etc. requires interconnect path between the engine and memory to be
> > explicitly enabled and bandwidth set prior to any operations. Add support
> > in the qce core to enable the interconnect path appropriately.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-crypto@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bhupesh.linux@gmail.com
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > [Make header file inclusion alphabetical]
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>
> This says that you prepared the patch, then Thara picked up the patch
> and sorted the includes. But somehow you then sent the patch.
>
> I.e. you name should be the last - unless you jointly wrote the path, in
> which case you should also add a "Co-developed-by: Thara".

No, it's the other way around. Thara prepared the patch (as the
'From:' field suggests) and I just changed the inclusion order of the
header files and made it in alphabetical order.

I will move my S-o-b later in the order.

> > ---
> >  drivers/crypto/qce/core.c | 35 ++++++++++++++++++++++++++++-------
> >  drivers/crypto/qce/core.h |  1 +
> >  2 files changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index 80b75085c265..92a0ff1d357e 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -21,6 +22,8 @@
> >  #define QCE_MAJOR_VERSION5   0x05
> >  #define QCE_QUEUE_LENGTH     1
> >
> > +#define QCE_DEFAULT_MEM_BANDWIDTH    393600
>
> Do we know what this rate is?

I think this corresponds to the arbitrated bandwidth / instantaneous
bandwidth (in KBps)
for the qce crypto part [I think 'average/peak bandwidth' would be a
better terminology :) ].

Maybe Thara can add more comments here.

> > +
> >  static const struct qce_algo_ops *qce_ops[] = {
> >  #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
> >       &skcipher_ops,
> > @@ -202,21 +205,35 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     qce->mem_path = of_icc_get(qce->dev, "memory");
>
> Using devm_of_icc_get() would save you some changes to the error path.

Ok, I can address this in v3.

> > +     if (IS_ERR(qce->mem_path))
> > +             return PTR_ERR(qce->mem_path);
> > +
> >       qce->core = devm_clk_get(qce->dev, "core");
> > -     if (IS_ERR(qce->core))
> > -             return PTR_ERR(qce->core);
> > +     if (IS_ERR(qce->core)) {
> > +             ret = PTR_ERR(qce->core);
> > +             goto err_mem_path_put;
> > +     }
> >
> >       qce->iface = devm_clk_get(qce->dev, "iface");
> > -     if (IS_ERR(qce->iface))
> > -             return PTR_ERR(qce->iface);
> > +     if (IS_ERR(qce->iface)) {
> > +             ret = PTR_ERR(qce->iface);
> > +             goto err_mem_path_put;
> > +     }
> >
> >       qce->bus = devm_clk_get(qce->dev, "bus");
> > -     if (IS_ERR(qce->bus))
> > -             return PTR_ERR(qce->bus);
> > +     if (IS_ERR(qce->bus)) {
> > +             ret = PTR_ERR(qce->bus);
> > +             goto err_mem_path_put;
> > +     }
> > +
> > +     ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
> > +     if (ret)
> > +             goto err_mem_path_put;
> >
> >       ret = clk_prepare_enable(qce->core);
> >       if (ret)
> > -             return ret;
> > +             goto err_mem_path_disable;
> >
> >       ret = clk_prepare_enable(qce->iface);
> >       if (ret)
> > @@ -256,6 +273,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       clk_disable_unprepare(qce->iface);
> >  err_clks_core:
> >       clk_disable_unprepare(qce->core);
> > +err_mem_path_disable:
> > +     icc_set_bw(qce->mem_path, 0, 0);
>
> When you icc_put() (or devm_of_icc_get() does it for you) the path's
> votes are implicitly set to 0, so you don't need to do this.
>
> And as such, you don't need to change the error path at all.

Ok, got it. Will change v3 accordingly.

Thanks,
Bhupesh

> > +err_mem_path_put:
> > +     icc_put(qce->mem_path);
> >       return ret;
> >  }
> >
> > diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
> > index 085774cdf641..228fcd69ec51 100644
> > --- a/drivers/crypto/qce/core.h
> > +++ b/drivers/crypto/qce/core.h
> > @@ -35,6 +35,7 @@ struct qce_device {
> >       void __iomem *base;
> >       struct device *dev;
> >       struct clk *core, *iface, *bus;
> > +     struct icc_path *mem_path;
> >       struct qce_dma_data dma;
> >       int burst_size;
> >       unsigned int pipe_pair_id;
> > --
> > 2.30.2
> >

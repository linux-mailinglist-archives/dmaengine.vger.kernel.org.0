Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD99739C6CD
	for <lists+dmaengine@lfdr.de>; Sat,  5 Jun 2021 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFEIdS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Jun 2021 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEIdQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Jun 2021 04:33:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD0C061767
        for <dmaengine@vger.kernel.org>; Sat,  5 Jun 2021 01:31:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x196so11868404oif.10
        for <dmaengine@vger.kernel.org>; Sat, 05 Jun 2021 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xotmvldeiH2nvjCl/SbEJZu3HovTS9rXIMr+8EDJUGs=;
        b=GkZkiIXLSc9IYvsZt5bHxw1XquCV0h6dyXndU3IdFYXRet08kPIUHWIdJnp1w4+ujd
         WUQtLGkKtK8BZ34Gcm1qeW0aVCFlQuAjd0IUDauK9RCOKj9Jmpwf8H91IsPE8y185n2i
         HDdiLaG1ruahA79NvlpdcvspmOT2oaLjN3bTI0aeZoeftRHwzt+fGUayWizf6Lc1U585
         hYxx/014JgUSSIPKxpgzbpN/8Qf1Rn0tOiFtn2ig8EE8PEiD1e00/o0EWG5rM39M3585
         BfVbfgP8Jtr7Anh0iZnw6NFO5xvs4mYaNRg8whPrrIgmDYXNWiPWa1Dzc//dtnTv+Tg/
         pj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xotmvldeiH2nvjCl/SbEJZu3HovTS9rXIMr+8EDJUGs=;
        b=WAUw2++de1Tn/xfcmrJVyojquVXnvi8pmWFzxmwcD3NifgG+aI2JwhEBynkZTcQE3i
         ZpKfWhWDkZ5srwVErwbUb9rES1xG9iXXS1f0sZHK3OAcaDbm0hykmN+bYQvyBu9UllbK
         KhSlsAmtw72wDPcawY6Srz2r6gegh+WPI2qkwefzvrGaf4gjI8j3zKG7QHnkaF2y3dRo
         QV5IXjc3MFr+53gK/9Z3m9J1VHjP/V2EVzMpAzi4R+Vrd5NbM96QVmAk8lIh0QYPI2IO
         y0MWgxvz8CFM359BT5DBD8jgtcOwhdPni6GjsLdpxlFLFlI54/2l9cBfmdWypKEzy21c
         veTA==
X-Gm-Message-State: AOAM5327Tn43JJt2XmSZKnFU4NpOvHOR6rRGe3yKovdy+/lWmJSmmrwf
        nMGiwhOztpV/egyWu/L4320yOKwTQ4Kcn8MYIn/dkQ==
X-Google-Smtp-Source: ABdhPJxllf5Ssjpm3lFPxiJPWMd5Wxxeq3l3Izy+0Rt6E9PYAhe5xf8H1gYjuJ8AEr3M47JsUmdIV5rodrDFbk9jlQg=
X-Received: by 2002:a54:438e:: with SMTP id u14mr12136616oiv.126.1622881876215;
 Sat, 05 Jun 2021 01:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
 <20210519143700.27392-14-bhupesh.sharma@linaro.org> <125e1f83-e340-9cd3-91a8-cd1ee3ee8b7f@linaro.org>
In-Reply-To: <125e1f83-e340-9cd3-91a8-cd1ee3ee8b7f@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 5 Jun 2021 14:01:05 +0530
Message-ID: <CAH=2Ntw3FbZLO3pkB9w--6DNQH0owv0RSFPxKfpDaC-iUzTjQg@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] crypto: qce: core: Make clocks optional
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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

Hi Thara

On Fri, 21 May 2021 at 07:41, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 5/19/21 10:36 AM, Bhupesh Sharma wrote:
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > On certain Snapdragon processors, the crypto engine clocks are enabled by
> > default by security firmware and the driver need not handle the
> > clocks. Make acquiring of all the clocks optional in crypto enginer driver
> > so that the driver intializes properly even if no clocks are specified in
> > the dt.
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
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > [ bhupesh.sharma@linaro.org: Make clock enablement optional only for qcom parts where
> >    firmware has already initialized them, using a bool variable and fix
> >    error paths ]
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   drivers/crypto/qce/core.c | 89 +++++++++++++++++++++++++--------------
> >   drivers/crypto/qce/core.h |  2 +
> >   2 files changed, 59 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index 905378906ac7..8c3c68ba579e 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/module.h>
> >   #include <linux/mod_devicetable.h>
> > +#include <linux/of_device.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/types.h>
> > @@ -184,10 +185,20 @@ static int qce_check_version(struct qce_device *qce)
> >       return 0;
> >   }
> >
> > +static const struct of_device_id qce_crypto_of_match[] = {
> > +     { .compatible = "qcom,ipq6018-qce", },
> > +     { .compatible = "qcom,sdm845-qce", },
> > +     { .compatible = "qcom,sm8250-qce", },
>
> Adding qcom,sm8250-qce does not belong in this patch. It deserves a
> separate patch of it's own.

Ok, I will fix it in v4.

> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
> > +
> >   static int qce_crypto_probe(struct platform_device *pdev)
> >   {
> >       struct device *dev = &pdev->dev;
> >       struct qce_device *qce;
> > +     const struct of_device_id *of_id =
> > +                     of_match_device(qce_crypto_of_match, &pdev->dev);
> >       int ret;
> >
> >       qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
> > @@ -198,45 +209,65 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, qce);
> >
> >       qce->base = devm_platform_ioremap_resource(pdev, 0);
> > -     if (IS_ERR(qce->base))
> > -             return PTR_ERR(qce->base);
> > +     if (IS_ERR(qce->base)) {
> > +             ret = PTR_ERR(qce->base);
> > +             goto err_out;
> > +     }
>
> I don't see the reason for change in error handling here or below. But
> ,for whatever reason this is changed, it has to be a separate patch.

Ok, I will fix it in v4.

> >       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >       if (ret < 0)
> > -             return ret;
> > +             goto err_out;
> >
> >       qce->mem_path = devm_of_icc_get(qce->dev, "memory");
> >       if (IS_ERR(qce->mem_path))
> >               return dev_err_probe(dev, PTR_ERR(qce->mem_path),
> >                                    "Failed to get mem path\n");
> >
> > -     qce->core = devm_clk_get(qce->dev, "core");
> > -     if (IS_ERR(qce->core))
> > -             return PTR_ERR(qce->core);
> > -
> > -     qce->iface = devm_clk_get(qce->dev, "iface");
> > -     if (IS_ERR(qce->iface))
> > -             return PTR_ERR(qce->iface);
> > -
> > -     qce->bus = devm_clk_get(qce->dev, "bus");
> > -     if (IS_ERR(qce->bus))
> > -             return PTR_ERR(qce->bus);
> > -
> >       ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
> >       if (ret)
> > -             return ret;
> > +             goto err_out;
> >
> > -     ret = clk_prepare_enable(qce->core);
> > -     if (ret)
> > -             return ret;
> > +     /* On some qcom parts the crypto clocks are already configured by
> > +      * the firmware running before linux. In such cases we don't need to
> > +      * enable/configure them again. Check here for the same.
> > +      */
> > +     if (!strcmp(of_id->compatible, "qcom,ipq6018-qce") ||
> > +         !strcmp(of_id->compatible, "qcom,sdm845-qce"))
>
> You can avoid this and most of this patch by using
> devm_clk_get_optional. This patch can be like just three lines of code
> change. clk_prepare_enable returns 0 if the clock is null. There is no
> need to check for the compatibles above. Use devm_clk_get_optional
> instead of devm_clk_get and everything else can be left as is.

Ok, I will fix it in v4.

Thanks,
Bhupesh

> Warm Regards
> Thara
>
> > +             qce->clks_configured_by_fw = false;
> > +     else
> > +             qce->clks_configured_by_fw = true;
> > +
> > +     if (!qce->clks_configured_by_fw) {
> > +             qce->core = devm_clk_get(qce->dev, "core");
> > +             if (IS_ERR(qce->core)) {
> > +                     ret = PTR_ERR(qce->core);
> > +                     goto err_out;
> > +             }
> > +
> > +             qce->iface = devm_clk_get(qce->dev, "iface");
> > +             if (IS_ERR(qce->iface)) {
> > +                     ret = PTR_ERR(qce->iface);
> > +                     goto err_out;
> > +             }
> > +
> > +             qce->bus = devm_clk_get(qce->dev, "bus");
> > +             if (IS_ERR(qce->bus)) {
> > +                     ret = PTR_ERR(qce->bus);
> > +                     goto err_out;
> > +             }
> > +
> > +             ret = clk_prepare_enable(qce->core);
> > +             if (ret)
> > +                     goto err_out;
> >
> > -     ret = clk_prepare_enable(qce->iface);
> > -     if (ret)
> > -             goto err_clks_core;
> > +             ret = clk_prepare_enable(qce->iface);
> > +             if (ret)
> > +                     goto err_clks_core;
> >
> > -     ret = clk_prepare_enable(qce->bus);
> > -     if (ret)
> > -             goto err_clks_iface;
> > +             ret = clk_prepare_enable(qce->bus);
> > +             if (ret)
> > +                     goto err_clks_iface;
> > +     }
> >
> >       ret = qce_dma_request(qce->dev, &qce->dma);
> >       if (ret)
> > @@ -268,6 +299,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
> >       clk_disable_unprepare(qce->iface);
> >   err_clks_core:
> >       clk_disable_unprepare(qce->core);
> > +err_out:
> >       return ret;
> >   }
> >
> > @@ -284,13 +316,6 @@ static int qce_crypto_remove(struct platform_device *pdev)
> >       return 0;
> >   }
> >
> > -static const struct of_device_id qce_crypto_of_match[] = {
> > -     { .compatible = "qcom,ipq6018-qce", },
> > -     { .compatible = "qcom,sdm845-qce", },
> > -     {}
> > -};
> > -MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
> > -
> >   static struct platform_driver qce_crypto_driver = {
> >       .probe = qce_crypto_probe,
> >       .remove = qce_crypto_remove,
> > diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
> > index 228fcd69ec51..d9bf05babecc 100644
> > --- a/drivers/crypto/qce/core.h
> > +++ b/drivers/crypto/qce/core.h
> > @@ -23,6 +23,7 @@
> >    * @dma: pointer to dma data
> >    * @burst_size: the crypto burst size
> >    * @pipe_pair_id: which pipe pair id the device using
> > + * @clks_configured_by_fw: clocks are already configured by fw
> >    * @async_req_enqueue: invoked by every algorithm to enqueue a request
> >    * @async_req_done: invoked by every algorithm to finish its request
> >    */
> > @@ -39,6 +40,7 @@ struct qce_device {
> >       struct qce_dma_data dma;
> >       int burst_size;
> >       unsigned int pipe_pair_id;
> > +     bool clks_configured_by_fw;
> >       int (*async_req_enqueue)(struct qce_device *qce,
> >                                struct crypto_async_request *req);
> >       void (*async_req_done)(struct qce_device *qce, int ret);
> >
>
>

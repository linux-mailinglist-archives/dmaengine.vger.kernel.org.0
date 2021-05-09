Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E554237780F
	for <lists+dmaengine@lfdr.de>; Sun,  9 May 2021 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhEITWA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 May 2021 15:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEITV7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 May 2021 15:21:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56904C061574
        for <dmaengine@vger.kernel.org>; Sun,  9 May 2021 12:20:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u16so13889176oiu.7
        for <dmaengine@vger.kernel.org>; Sun, 09 May 2021 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GPX6YCdFT0eI9OqiRM8BpJFmnkJ48nTNs5bVOXcOto=;
        b=W3oEm+Oqv8jLV7JX4eRdNWLtaUGnm18j3ZTtBh3ytvRUvWqMMuZkuTsalW6FwJM1O7
         zUy9IpQYFCCLsR5UA1avToB85nZYis468um1kgBb/SwY5TG/CIlZ1bzK034KroZdFLqS
         0s2UClL6u5efDdXqywqT3Zh4/b2E4cYf2DJXU/jtyB8Rf0ngt9FJ7sdYfzTz2aBVTgvb
         vXOD4O0mCV5xLFLNWHc82ZV2MArtTu7PbWHYjBdlnr4rnjLUEkWRtkTVS87WNLE1vnJu
         9GRBQp9f7nbi32VxANmKrUXkFGiEIxHnDooT79iM5V1J4eh6t4UYcI9Epnt7xanmWzMh
         wX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GPX6YCdFT0eI9OqiRM8BpJFmnkJ48nTNs5bVOXcOto=;
        b=T7+SzXZ6WiRIkd+YS7RtvAu0IKs18gfoylj0M2RsodA45/5T4VieCjJT9gBHLMsvt3
         iXO4zHVXkarpqPIRccAzQDr9GtMAPYYSoL9Myar26jl3XOysbH5TzcW+ArgWlNhKcC19
         jQWc8V0Mv3SdlEp612XoPlsFrla07i+Bs7IwrmDMNndLY2dGLfIE0Y+B7OQZeVPM2vrk
         HcbATCjHHlNXuv6eS6fzlA9izXCgmYLog/6wd08QY3ukBNIJMllacSgBac6J42fYFvZK
         lJ3d++olbXT0lKeYD6jRa0UOM3cXAYOC2CEWhOyKbLHt4hobN5gn2rdm0RIPFKESdjDq
         CzuQ==
X-Gm-Message-State: AOAM531u6yxMeqortSQMciD0jMazIouYuFPtUbkZpKndQGVj3Db2OLuq
        +PibgkAU8qD9Ue5ljXPY7/3otATe7K6PLqNIUGOTri95v7I=
X-Google-Smtp-Source: ABdhPJw6+UCBlq3IWslbkvJg6hDx8LHViB9kozY6+DNTnjWO3Xjnwmrth+lDZWe6PVj3aw2O9mJQcyzhFO5f962x7fo=
X-Received: by 2002:aca:3dc3:: with SMTP id k186mr23871986oia.126.1620588054621;
 Sun, 09 May 2021 12:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
 <20210505213731.538612-15-bhupesh.sharma@linaro.org> <YJfqk/0Whr2Qfxjb@vkoul-mobl.Dlink>
In-Reply-To: <YJfqk/0Whr2Qfxjb@vkoul-mobl.Dlink>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 10 May 2021 00:50:43 +0530
Message-ID: <CAH=2Ntw6MfqLvxzx44TqgF21frwkeJnUmkeH2+zx0L+MfLdG=A@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] dma: qcom: bam_dma: Create a new header file for
 BAM DMA driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        dmaengine@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the review.

On Sun, 9 May 2021 at 19:28, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 06-05-21, 03:07, Bhupesh Sharma wrote:
> > Create a new header file for BAM DMA driver to make sure
> > that it can be included in the follow-up patch to defer probing
> > drivers which require BAM DMA driver to be first probed successfully.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
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
> > ---
> >  drivers/dma/qcom/bam_dma.c | 283 +-----------------------------------
> >  include/soc/qcom/bam_dma.h | 290 +++++++++++++++++++++++++++++++++++++
>
> 1. Please use -M with move patches...

Oops, will do.

> 2. susbsytem is dmaengine
>
> 3. Why move..? These things are internal to the driver and I dont think
> it is wise for clients to use everything here... If the client needs to
> know defer probe, it should request a channel and check the status
> returned for EPROBE_DEFER

Yes, the main intent is to defer the probe of the calling client driver in
case the BAM DMA is not probed() yet.

Sure, I will make the suggested change in v3,

Regards,
Bhupesh

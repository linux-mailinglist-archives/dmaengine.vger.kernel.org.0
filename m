Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A01ADC84
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 13:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgDQLvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730410AbgDQLvp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 07:51:45 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A406BC061A0C
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 04:51:43 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g10so540826uae.5
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOHFM9elPBqZ53StmEbbuJGOBdc8SihR2GSmdzRs9uY=;
        b=fMBCf9rOwilC1Z6Zixv2jAkeDoBbxoQeuGNlsPNTLbDswvHwzz7iLxOphekUuKVqeF
         Qn0ggF1zoOm+Or2djEeeJGzuDDFRF7v1IClvr+VYsYw0IMCAkP04EfKMZRjblTi3rOJ7
         wYWU51MpN6ZElokLiqRmQN7mHlbC890Dl+mpo8TLTrcZzqyDcx4wjqHcSd2SApybyb8Q
         7Bewaw/qrHUFuEXg5kdULw5Dfr6ub2RuVOD6TU8NZyzuo02/mjevhpdMd53w6KaIvMFE
         MOXrJDBF6/Es0NfS4DM1SdeFWa+bj4mz/t//QzlwvAiUPZiGZkQlwsDIpD4Yc5vwJllI
         CzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOHFM9elPBqZ53StmEbbuJGOBdc8SihR2GSmdzRs9uY=;
        b=ffa/L9hKz+SSe32JiipUqFpUQLEkfS2brLc3zzDpgSmvK4YOUuo8ot+79vPtSqol+u
         NGZqlnw/u0x+YPtTl42TMrkFmy21kSgKjah5I+jDUUJD9I2wQ42hzKMlo12hxxo/jjrI
         qAu4uADZVUyDCvaQZ7xcnQUlfSWFMEC6FyewBe1C/GDXs7WRt68oW0C15Pv3k30xdXLu
         HdzzrTfkr5lG84PlkqPQ3INRrV7SVSywIYva735JD6iBfjf+cfwCcg8kwp4WnSI0wlpT
         eA26wiU6tJV/tal6qMX3nIG//k53gMIT2nkC/cquE0u910voVb+k8uZZ0rST8uWanOja
         wKsg==
X-Gm-Message-State: AGi0Puabu/QE/K81Nbl3wnuq0Ebds/RmXQNQwWggAULURs+q+RUL/mkf
        AHt2dLEfruv+yiTky8ujqxcMimn6RqHeSB1GvfXHJA==
X-Google-Smtp-Source: APiQypJptyO3Q188LiC+lVglCDgxEqyyiuLnTQxJkuIYhQNrcbVh5T9dEoPww3VYf1pU7et5uyG7m7wgsnLScU++FZU=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr2012699uap.19.1587124302013;
 Fri, 17 Apr 2020 04:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200331183844.30488-1-ulf.hansson@linaro.org>
In-Reply-To: <20200331183844.30488-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:51:06 +0200
Message-ID: <CAPDyKFoVMBFTRJbEi-bjzeeMgi+z5xsBpBYteF=duCMb0Zxdhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] amba/platform: Initialize dma_parms at the bus level
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

 - Greg, Arnd, Linus, etc,

On Tue, 31 Mar 2020 at 20:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's currently the amba/platform driver's responsibility to initialize the
> pointer, dma_parms, for its corresponding struct device. The benefit with this
> approach allows us to avoid the initialization and to not waste memory for the
> struct device_dma_parameters, as this can be decided on a case by case basis.
>
> However, it has turned out that this approach is not very practical. Not only
> does it lead to open coding, but also to real errors. In principle callers of
> dma_set_max_seg_size() doesn't check the error code, but just assumes it
> succeeds.
>
> For these reasons, this series initializes the dma_parms from the amba/platform
> bus at the device registration point. This also follows the way the PCI devices
> are being managed, see pci_device_add().
>
> If it turns out that this is an acceptable solution, we probably also want the
> changes for stable, but I am not sure if it applies without conflicts.
>
> The series is based on v5.6.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (2):
>   driver core: platform: Initialize dma_parms for platform devices
>   amba: Initialize dma_parms for amba devices
>
>  drivers/amba/bus.c              | 1 +
>  drivers/base/platform.c         | 2 ++
>  include/linux/amba/bus.h        | 1 +
>  include/linux/platform_device.h | 1 +
>  4 files changed, 5 insertions(+)
>
> --
> 2.20.1
>

Does this look okay or is there anything you would like me to change?

Kind regards
Uffe

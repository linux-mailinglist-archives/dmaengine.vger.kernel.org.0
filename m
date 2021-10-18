Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECBD43176E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJRLgy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJRLgx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Oct 2021 07:36:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D5C061745
        for <dmaengine@vger.kernel.org>; Mon, 18 Oct 2021 04:34:43 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so764063ote.6
        for <dmaengine@vger.kernel.org>; Mon, 18 Oct 2021 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6G8Hfd9HWWdOmQn8dJ/4ZTN0E6g9DldkLudnuHQWD1k=;
        b=mfWHkg6A++/9gjuM+FUS0mGsRBbFBJOlC/EjyddiPAJctM5q/3aGEkGv0P9ExrHLYf
         vlnNzUKEfOTtJzDy0NRR4NFTvE8RnCv5Smk1MSYJQUYBgQc5ztrxlGLQ6BvCE6HgqeHR
         AuoMfraz4oXYEmgUAVhlRhm6sQ6nWYWvEQiL/5R7bLCmzwDP9RIyY3PFQFpKf0P/mdMb
         //v1bgSYW9PRlFyzfVwe5fv6KzVlQVdy0Ry0vHqL9/4UtfDzq4BV85xu2Uh50jPPrQl5
         zIZuwOmHSc6Thw3vfNcXkvSf9F+XlsvT5aeSj7mjWcE3tgqqeaVhgoC46G9Tj2XzjpoB
         yUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G8Hfd9HWWdOmQn8dJ/4ZTN0E6g9DldkLudnuHQWD1k=;
        b=T74gXe0CqI6e1zWg8fNZOAq1F0xfnBMnlV15vWdDtiilGrekKA40U4lEnazoaLAc+S
         iNDLtcw4u2qTgpNr6UnRJONr8Rz4DlAwghoHkaYoU+eIJdMzLDFHSpzdDoubE1wm04nO
         qL9aVqS5/Lknhy7QaJYwKGVA/78bEUjA5LqRxgdrdXZj+ziJPC8LXhYry4d6YCy1Cm/n
         6T/O2uZcOuHV6ifMoXT4X/yHPlEk5DNruwvzSV8tDEWDuBeQlsM+VMSrWQ13BePuIbHm
         0JKWZU+9HDKBsGGqs0etWOkhkcee6fj+HXQLk8RrezTy6pxJo9p/m+PqAjapjSsR9xVH
         kXQw==
X-Gm-Message-State: AOAM531PhnYhQMoU+kBURaGor9SdzZLzPOcncj0D6oBoeBETyrF2SGGj
        6hvGwQr5UQ/VxlOxM1OC8+4krvNFdnF9+Xs0cyFKUg==
X-Google-Smtp-Source: ABdhPJzToQU6dBlbmasyOXnGLHSpLJDGclh9CmgZFd06P3bvgiJJeE2czOxOsSKQnEzr3MFg2ogcNZYW8cFjW+0K93M=
X-Received: by 2002:a05:6830:1c26:: with SMTP id f6mr20715033ote.28.1634556882315;
 Mon, 18 Oct 2021 04:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211011141733.3999-1-stephan@gerhold.net> <20211011141733.3999-2-stephan@gerhold.net>
In-Reply-To: <20211011141733.3999-2-stephan@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 18 Oct 2021 17:04:31 +0530
Message-ID: <CAH=2NtwH9kmZBMsOkZkwiuN2mpmOTiAVtw3zC2O4xNdCgG8P4w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: dmaengine: bam_dma: Add
 "powered remotely" mode
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Aleksander Morgado <aleksander@aleksander.es>,
        netdev@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Stephan,

On Mon, 11 Oct 2021 at 20:12, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> In some configurations, the BAM DMA controller is set up by a remote
> processor and the local processor can simply start making use of it
> without setting up the BAM. This is already supported using the
> "qcom,controlled-remotely" property.
>
> However, for some reason another possible configuration is that the
> remote processor is responsible for powering up the BAM, but we are
> still responsible for initializing it (e.g. resetting it etc). Add
> a "qcom,powered-remotely" property to describe that configuration.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes since RFC:
>   - Rename qcom,remote-power-collapse -> qcom,powered-remotely
>     for consistency with "qcom,controlled-remotely"
>
> NOTE: This is *not* a compile-time requirement for the BAM-DMUX driver
>       so this could also go through the dmaengine tree.
>
> Also note that there is an ongoing effort to convert these bindings
> to DT schema but sadly there were not any updates for a while. :/
> https://lore.kernel.org/linux-arm-msm/20210519143700.27392-2-bhupesh.sharma@linaro.org/

Seems you missed the latest series posted last week - [1]. Sorry I got
a bit delayed posting it due to being caught up in other patches.

Maybe you can rebase your patch on the same and use the YAML bindings
for the qcom,bam_dma controller.

[1]. https://lore.kernel.org/linux-arm-msm/20211013105541.68045-1-bhupesh.sharma@linaro.org/T/#t

Regards,
Bhupesh

> ---
>  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> index cf5b9e44432c..6e9a5497b3f2 100644
> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> @@ -15,6 +15,8 @@ Required properties:
>    the secure world.
>  - qcom,controlled-remotely : optional, indicates that the bam is controlled by
>    remote proccessor i.e. execution environment.
> +- qcom,powered-remotely : optional, indicates that the bam is powered up by
> +  a remote processor but must be initialized by the local processor.
>  - num-channels : optional, indicates supported number of DMA channels in a
>    remotely controlled bam.
>  - qcom,num-ees : optional, indicates supported number of Execution Environments
> --
> 2.33.0
>

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52F410C44
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhISPyH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhISPyH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 11:54:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14AC061574;
        Sun, 19 Sep 2021 08:52:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso10297234wmd.5;
        Sun, 19 Sep 2021 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ct6BHiuUGfmZnCOMnrBPm1D3sUejQVBqmg146vwiSS8=;
        b=ZC6Qufv+8GnvnNGlV3HqjefUztw6KTFZLsAPGMM/ESw1teZRZalSyGJ+DQcGyaupiE
         MCii3OkJMNuLb8TwP1h2xszyK6CtLRocWcmtGg1k9V97CxlmVuuubW/z3JJVv6k7T5i8
         3KhSzwfu0zrXIFmkXE92oUHdG8atoRL+Cj0jROzH558WmnNwxOSsE41Ac+2b92ZU6raI
         Yj3FMpVmWcQofH7QlKefXgomrbGb3orWq9YZyvkAX8Jd5dCn4mcZP7nrquFJoT0jLysF
         rdyP5BaB1SpBqFQCitRUEYZkN18SIaFMKpneC0VEse03VwQA7XdBsdUbYnLTDgRKAK6q
         IZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ct6BHiuUGfmZnCOMnrBPm1D3sUejQVBqmg146vwiSS8=;
        b=BUz00ekVashnGBbnNhIo4wxLzCxcJss+RbYhdaX4wMXC3qgU2Bp+BgYaRk4eJuvPfV
         7g0lBHc+/r6yrmK+0gTDybaUPX3m4JzVeZATrL/QEU0DsHOf1izjF8eZdLkxmFwadvnF
         r0MOWJzkUmq/L1qCKBNEohYRw/mqUiwjCUiEPpx707fwzyDvRJdSylcWCIFZAxoTtf4O
         QbTGQek7xOdkFM7UBWt3oTrpJmc2YwDx/Oky+7rKD24qJgW8zZbLAdaomyc+c5aO+0dL
         5QnVgcVqpH1t788LIbTnUcg1EJRf1/26kW2G7VtO8ZfrOdrasJ25CXENrwp6d7grAc6z
         DqlQ==
X-Gm-Message-State: AOAM530ZASLYDLB516dFM/+4/co/qGZ7d5cc8eRHubYiSr+MC6vQBvlQ
        l9IYZ8xsqP24a93MjAmLigypnq5Lt5kb5teB2pggcZywJM4NpOZa
X-Google-Smtp-Source: ABdhPJwdQ9X4JU7dqWUBFFTvSNN16QehVpQcHBnL24Z12m1sZigp/dU7wUT45yTv4MGF3bSD+OoBzyxnbh+wipYc/1I=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr12736526wme.76.1632066760499;
 Sun, 19 Sep 2021 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210919143311.31015-1-sireeshkodali1@gmail.com>
In-Reply-To: <20210919143311.31015-1-sireeshkodali1@gmail.com>
From:   Sirsireesh <sireeshkodali1@gmail.com>
Date:   Sun, 19 Sep 2021 21:22:29 +0530
Message-ID: <CAFvbNjZr-WdDAKQ8f-P1beiOkZzfinpr5ua+wVoKaagtE_EcNQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add support for metadata in bam_dma
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Sorry, I accidentally sent this patch twice. Please ignore the second one
(i.e. the one I'm replying to now)

lkml link to original: https://lkml.org/lkml/2021/9/19/126

Sorry for the inconvenience
Sireesh



On Sun, Sep 19, 2021 at 8:03 PM Sireesh Kodali <sireeshkodali1@gmail.com> wrote:
>
> IPA v2.x uses BAM to send and receive IP packets, to and from the AP.
> However, unlike its predecessor BAM-DMUX, it doesn't send information
> about the packet length. To find the length of the packet, one must
> instead read the bam_desc metadata. This patch adds support for sending
> the size metadata over the dmaengine metadata api. Currently only the
> dma size is stored in the metadata. Only client-side metadata is
> supported for now, because host-side metadata doesn't make sense for
> IPA, where more than one DMA descriptors could be waiting to be acked
> and processed.
>
> Sireesh Kodali (1):
>   dmaengine: qcom: bam_dma: Add support for metadata
>
>  drivers/dma/qcom/bam_dma.c | 74 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> --
> 2.33.0
>

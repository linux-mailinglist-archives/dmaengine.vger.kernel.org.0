Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752215EB08F
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiIZSxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiIZSx2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:53:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ADE8053D;
        Mon, 26 Sep 2022 11:53:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 10so12348184lfy.5;
        Mon, 26 Sep 2022 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=LTprvCg8UrTMN0V7Jb/ZUGpUP2Drp+PBcPjICaNlCm8=;
        b=SLZK7mbvT23yOz/NZMoFljpw9++bR4DS1v01TMykZFQ2Ib/mZlkFXd45iq1y70hLTB
         HuTkM91Kcl+Djq7zmKDb/cbjZB7AmeMGt6lERR4g/vJVHFzw58zrEVkZUl7OijsqVBkP
         Hy78HbIVWQrrPe2gyBbJMUS49kBCeZxTV3u/9OA+djn8QtbiZyo8H5K6ie6jAAgcopgG
         ZStwJC6gblFf4iCS3nU9nh5Wbd+r1CQWHz9V9Yxj+0qLLr+BlJsrnBbIJUxXUhyOG5Ng
         HixDb1tIyWokhQXKEb1npUO+RXDhisoYArBPmrzw5acsY8dJLzH5Ks3kYNQDfLFCgCvc
         NEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LTprvCg8UrTMN0V7Jb/ZUGpUP2Drp+PBcPjICaNlCm8=;
        b=haHcQ88Pv3mtBkLr519rjESr0Dubj1n5wF2CJiekpKbMQMgoSKBdvTe4xYaOfsn10m
         GWqIO6Qu7tQ8YUnPvvK3dQlFKaLZIg0nyA+Sm4uLghbuNJM693sjhLj0r96NStikfxDO
         zu6J4JyCCy9KqQkVCFJk9tEs7EvxPsdZ/0korMNuBB2Ivphj9ND0zz3iEk255MUDaawk
         ZGtYq1W1Cy6aDCgMsxU02oUb2LYnzTeUJBTwc2x97gpZHbNOkpS1vKKb8NwMAi5IJumN
         qTShI2NLDZ+HEgpNYSIoDazyjKQY/Oe4azVSFQAGEg/vEw3REdQQSm9gl6Fxhgk4JUI/
         i9Zg==
X-Gm-Message-State: ACrzQf1WA85q/JM8fi4jxiApxbmMpf9oAHKzRSjy1yb4bFoPa7NpvI40
        F/D1N7yPCXYjFbJRWkW4cdg=
X-Google-Smtp-Source: AMsMyM6aSz15nrB8kdgmCWJPgka4iQpIl4hUGvHQa74xXfxatFsll0h09KX6X3+FVXP9ybOP2Wdx3w==
X-Received: by 2002:a05:6512:308e:b0:49b:9015:e76e with SMTP id z14-20020a056512308e00b0049b9015e76emr10036043lfd.393.1664218406121;
        Mon, 26 Sep 2022 11:53:26 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25e79000000b0049ade93ad24sm2604902lfr.156.2022.09.26.11.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 11:53:25 -0700 (PDT)
Message-ID: <cf3194ec-0952-fa7a-cc05-6a60e7e66cf0@gmail.com>
Date:   Mon, 26 Sep 2022 22:02:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 0/3] dma/ti: enable udma and psil to be built as modules
In-Reply-To: <20220926181848.2917639-1-khilman@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On 9/26/22 21:18, Kevin Hilman wrote:
> Enable the UDMA driver & glue and PSIL maps to be built & loaded as modules.
> 
> The defauilt Kconfig settings are not changed, so default upstream is
> still to be built in.  This series just enables the option to build as
> modules.

I can finally drop the half backed stuff I roll on top of -next ;)

Do you plan to convert the ringacc also? It is straight forward, like:
https://github.com/omap-audio/linux-audio/commit/01f9290c1c61e8bbc0fbdd877382672883ba7e73

> Kevin Hilman (3):
>   of/irq: export of_msi_get_domain
>   dma/ti: convert k3-udma to module
>   dma/ti: convert PSIL to be buildable as module
> 
>  drivers/dma/ti/Kconfig          |  7 +++---
>  drivers/dma/ti/k3-psil-am62.c   |  4 ++++
>  drivers/dma/ti/k3-psil-am64.c   |  4 ++++
>  drivers/dma/ti/k3-psil-am654.c  |  4 ++++
>  drivers/dma/ti/k3-psil-j7200.c  |  4 ++++
>  drivers/dma/ti/k3-psil-j721e.c  |  4 ++++
>  drivers/dma/ti/k3-psil-j721s2.c |  4 ++++
>  drivers/dma/ti/k3-psil.c        |  2 ++
>  drivers/dma/ti/k3-udma-glue.c   |  5 ++++-
>  drivers/dma/ti/k3-udma.c        | 40 +++++----------------------------
>  drivers/of/irq.c                |  1 +
>  11 files changed, 40 insertions(+), 39 deletions(-)
> 

-- 
Péter

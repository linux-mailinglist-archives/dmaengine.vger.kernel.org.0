Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7D7A88B5
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjITPoq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjITPop (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 11:44:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198CA3
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 08:44:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c022ce8114so38314301fa.1
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695224678; x=1695829478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwiViBM+Ng2Zbve/53EB1qRCOS4sOxEjrY7Ch3Gjuko=;
        b=CRkX8zcM82KHlrizb10Yz9xe/1/6uo+QQYDQDMA5yyWiGPv/IEijh0qZYLl30QnU1l
         OLduempe77iTYsoyUWy0z2lRBoscVhwqXx5j5yPT9GERdsEyjQYmz8CkklSzNfGW+fo5
         7b2PQK1y1JWVF5OXvP2ruchyAxyBThUiuyNe5kmHoYQtgYr7MtskHhmHbbiv5bZoVzyw
         3o5KEhVi+zWG+MofxwRVgTh8CCePeWxQYr3tiLQ32M6ID7iGXycp2bemIzk2j42JrKwN
         wBeZWO+Mj/66sV15igMNAgIaIIR5oRWLLakCCzXUJKxLyCVDCQVFoCLbRBq6eO0mI09I
         sQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224678; x=1695829478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwiViBM+Ng2Zbve/53EB1qRCOS4sOxEjrY7Ch3Gjuko=;
        b=NBWswNccXY3hkUxbxDByhkk3l8WrwkHawHnS3N6X2QXkvliRluqBoO2uWb4WrvdHX8
         Q6JDa0yZrd3soYfpl5wt0Z4SgMe/7hGZEISBTtxh9W86lJO24HQkKF1iDBqiGX3MRG4i
         Gef4geyIjpxeP//KPhCEkBlW7ptx50UiMGaMrKHzPzlq1rqDKI3ViLVO+S/ad6VcYWaX
         nzbwGceK4wr2q28Eqb8TRK4n9oqXxXI9Wiezd9ugYUQ4T3LwuHDUAdzHY0MhfTvlTt+r
         TbiUmVzl5GdvpQtg+QuC9SSAmoVTV46yR/vk3i8qdKmWZS24+3ybgaBFRSbNpqtP89E7
         VI1A==
X-Gm-Message-State: AOJu0Yz1kNRgnKYXPyOQJfQKS4HMVu43xQ8i8MrBLmNxxu9YynNkN/J5
        9vOYuzm1Sr5iFY2sxfFThrYma1WnJ+tL+38Y+oc=
X-Google-Smtp-Source: AGHT+IHL1BxFCB0RMETNh8MVHkFqrO5tu9cYC6MGMWkxjrGnG4pdcx7diZ7tSnuuONrha5On1aR5JA==
X-Received: by 2002:a2e:6a09:0:b0:2bc:b557:cee9 with SMTP id f9-20020a2e6a09000000b002bcb557cee9mr2559470ljc.43.1695224677761;
        Wed, 20 Sep 2023 08:44:37 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906710600b00992e14af9c3sm9624125ejj.143.2023.09.20.08.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:44:37 -0700 (PDT)
Message-ID: <6fb10313-ac31-f5ed-763f-4424ec502d78@linaro.org>
Date:   Wed, 20 Sep 2023 17:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 09/59] dma: dma-jz4780: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-10-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230919133207.1400430-10-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19/9/23 15:31, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/dma/dma-jz4780.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


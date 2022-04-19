Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B350663E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbiDSHuc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349565AbiDSHua (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 03:50:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055A2E697
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 00:47:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b15so20156614edn.4
        for <dmaengine@vger.kernel.org>; Tue, 19 Apr 2022 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C0PGH+OMpKE6L74TE6jhieB2Brn97/rzhTTKeA9q/uU=;
        b=pJGFE1TLlYKUSZZ8nx1OFLi/GSXW17TSV2iiypDaXosKmnlXPFEgQD4TDcGTWrcIWZ
         KAzUpClu2+SNU4v/Gzk2wBA0MQTXrZtepF+IornOijYRy/BPfEsKAOKJBjlNTzwTyal4
         OYga3cY3CArO8RopZLRsLAFtDwJaIHSKjMBbQ/hfxbu5nSf23FpHcRa81SzNchyaTuJS
         G9KbjlopXIZJ+wOpJy+eB5nb6HAlD6kaYwZlc/IhgWKxDDpEffOKzq0YsZj2Ffm1kQlU
         Qyf5zUdMnoks3bgaCj3PwRTBrJPajws+OK80WEW6lxTOZo7miEwNG5OPUgC/5MwEqTCD
         lJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C0PGH+OMpKE6L74TE6jhieB2Brn97/rzhTTKeA9q/uU=;
        b=WjtC92jSIqkjyxJGiR0IdO8Wi/JkcD4COsP4Ckd5956Gu2HvUKuO2lzbLl4kck3ClL
         ej1GDBZQVb8HwOEYF4LSoXfHeesqwpHG1X/jZ5jdFu+tsW+S58Fe16NHnL2kxi1myLk0
         RMunIfM9kSAu/K9cBf90nN8L+Agb9SifQskWc1NSbgUYUedqj5dw0q5mqciewBxuiep0
         0IymFe9VVPYMbk+v/PvK/gzKe2r4curcoNxE9Xfar/Pm4A+KUREn+2YxKd5y7299+pJm
         4am29k0cfUBjRWBV5fhVSQp9LUuAmwla2TOPQs7/7+GtzAO0dWz4CZ1KTREdKgqR8PVo
         FDOA==
X-Gm-Message-State: AOAM530kSWGY7gMb9IrtHWaRbY7fitGX1tahVUX7Q51IHQ83p0bOgVtp
        bNtyK+pJKRjRX5tcfLwmFieU9w==
X-Google-Smtp-Source: ABdhPJztlccA1gfyQHHXSuSecllY6AcbHNzImIi5kfGI/UhPAB1xEEPE1IIUbnLO+ypjox1WyCKDNQ==
X-Received: by 2002:a50:fb03:0:b0:41d:8d3f:9427 with SMTP id d3-20020a50fb03000000b0041d8d3f9427mr16055306edq.263.1650354466943;
        Tue, 19 Apr 2022 00:47:46 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906071700b006e8a19cefa6sm5335821ejb.106.2022.04.19.00.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:47:46 -0700 (PDT)
Message-ID: <1965ed9f-0258-cd28-f1c3-ef87272f6c03@linaro.org>
Date:   Tue, 19 Apr 2022 09:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding
 to json format
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
 <20220418192012.GA6868@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418192012.GA6868@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/04/2022 21:20, Kuldeep Singh wrote:
> On Mon, Apr 18, 2022 at 10:57:55AM +0530, Bhupesh Sharma wrote:
>> Please see <https://lore.kernel.org/lkml/20220211214941.f55q5yksittut3ep@amazon.com/T/#m6700c2695ee78e79060ac338d208ffd08ac39592>,
>> I already have an effort ongoing for converting qcom bam DMA bindings
>> to YAML format.
> 
> Ohh ok, I wasn't aware you had similar series.
> I just noticed your latest v5 version was rolled out ~5 months back,
> usually this is a very long time considering the duration. Wondering
> reason behind this..
> 
> My updated series(v3 version[1]) is kind of complete and mostly reviewed
> by Krzysztof and takes care of armv7/8 based platforms. 

My review was only about patch correctness, not overall patch preference.

> With no offence,
> I believe we should go with the current one as your series includes
> changes more than BAM and will take long time to merge. Anyway, I'll be
> fine with choice of the maintainers.

I appreciate your work Kuldeep, it is important and valuable
contribution. It is sad to see duplicated effort, I don't like it for my
own patches either. In general, I believe the FIFO approach should be
applied, so in this case Bhupesh patches.

Before starting the conversion the best is to look for prior work on lore:
https://lore.kernel.org/lkml/?q=dfn%3Aqcom_bam_dma.txt
This way you could easily avoid doing the same.

Bhupesh,
Please check what was stopping your work, you might need to rebase it
and resend it.

Best regards,
Krzysztof

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C084FE78E
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiDLSE0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiDLSEY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 14:04:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080395A15D;
        Tue, 12 Apr 2022 11:02:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so3790076pjb.0;
        Tue, 12 Apr 2022 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KD3zlhA4cnu+F8Ye3bhSZQoi9dOhZ7oX6Of6NoxUUuk=;
        b=iCV26r+EyhOpvQyEn8WdLCWBOQ4OpaL8UodOn8ua4BC/Q/QHEOiVx5lPx/ZLNmhkr3
         z+juAfN3JLD9T5FhqgJRBwEqc0LKZnjU2fSzjGEFGDJMEbOJd4jtE9YPC0w5FnNiGMvk
         4RkbVGo09yl2USiIoe/oMQfhxY1Pef+eCmp8tDE5vDiLu2q0U2/QZazh/ayjMJj47/UL
         UtCBr0ROq5yagnvTt4xiLC4Ut52nYyab2dCgb8921SBD/ydYeP/+8ltyei70aJ6ZNSe0
         eBbYeU89jNImPvSLIDF4JIUuluccMh43n13h0XJaomdvq0nDzlONJZ6S/87nRRCr/eud
         Iz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KD3zlhA4cnu+F8Ye3bhSZQoi9dOhZ7oX6Of6NoxUUuk=;
        b=tjdXmagNocT1UQHBKiyC1rO3DvCyQkGrf1PPCHw/csTZg3hynpTCg1Zii3HYYFIlKb
         xb42WrDNYvrOByCPY20eP88k2eJoZJLol8y32WWWYu6jLYfHIVfd7bK68CGSubat2sqB
         WWYf7smkl8Y0713SkHNGntnKMHuD2ICPIReH6N268xifTFXQkcNy4ZtQ1qn8t94G1bID
         0KP+ZO4lZpgpuFpvO+tXoGs3nwxdi91kVcepuBg+p+j7CUqWqntzQGTDLwyqyU+fAeTh
         jC3UNktXwlHzawTTAE+OkBNYV0Qkv/f69jADyLegP1cxQDbeFF7CaAwgRVoNM8qkzQz4
         9sgg==
X-Gm-Message-State: AOAM530yqT/8PR8t8ke+LKSxY4dfmFYo7umLg9JTpsOqyCmmsGU5jk3G
        NLvVwAHXSaBhhziXyWizvp97y2/fDBI=
X-Google-Smtp-Source: ABdhPJza/agHmGrmFLgonFL7VOBBA4SS8lMXCPSs9MfxWwOxa5kiBqig+Iy0FNNkQutRNULcGytwDw==
X-Received: by 2002:a17:90a:d584:b0:1bc:e520:91f2 with SMTP id v4-20020a17090ad58400b001bce52091f2mr6402022pju.192.1649786525466;
        Tue, 12 Apr 2022 11:02:05 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id m13-20020a62a20d000000b004fe0ce6d7a1sm30027607pff.193.2022.04.12.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:02:05 -0700 (PDT)
Date:   Tue, 12 Apr 2022 23:31:59 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220412180159.GA29479@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
 <20220411105810.GB33220@9a2d8922b8f1>
 <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
 <20220412061953.GA95928@9a2d8922b8f1>
 <8ff07720-3c52-99e6-8046-501f4ae28518@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff07720-3c52-99e6-8046-501f4ae28518@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> > Which example schema are you talking about?
> 
> There is only one example-schema.
> $ find ./linux -name 'example-schema*'

Example seems good to me. I will change to boolean.

> > Anyway Krzysztof, can you confirm the same as you have been actively
> > contributing to Qcom peripherals. I will add credit in follow-up
> > submission.
> 
> Honestly not now, because I don't have access to related datasheets (I
> am working on this).

Yes definitely and you also must be having bunch of items in your todo list.
Actually, I also don't have access to datasheets that's why was looking
for inputs.

> You can though try to look at original (vendor) sources:
> https://git.codelinaro.org/clo/la/kernel/msm-4.19 (sdm845)
> https://git.codelinaro.org/clo/la/kernel/msm-3.18 (msm8996)

Great. I'll see if I can make most out of it.

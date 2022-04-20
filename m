Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB205086BA
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbiDTLOo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352597AbiDTLOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:14:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AD41611
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:11:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u18so1820466eda.3
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dd68attu6wu8SnkuJQL45TqfDMtpPSRWGhXsotp4fTY=;
        b=lEJ8p5ElATv5tyFZAbGsc745hOouC6LTxXrw9Bkb6v+j3URODF22aXFXhG0dmZOnoc
         xcMHtdlUaMadbQ/J25dUNYqM2fNIkTQrGq8CcT/N0qdiv4dSUSdSuVtC09352RKkQndt
         RdDPDX+kGDgldVfnXnoKtpkoZ40JA9Thp+nhrPHdiyildt36YwnDEmGxDTBGrdKH3l7G
         bnfrN0Auidp/galrNajKjI+u5XlZXs+jbq35cvIXSJB1146d0+yXgGCSV98n67lreBnY
         vQoHy0fQa47z+y8SEVVb+Q0v8W0OYKa7HzLbLYm4/rEFPuS6hB0JfBORr7y7NNYmy9/k
         DD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dd68attu6wu8SnkuJQL45TqfDMtpPSRWGhXsotp4fTY=;
        b=O76e0dL6QbwuWJWm+ppZODFE26ZKKUzhkqViVw0sGOGLtgtU/YbIz+1HH+WiDErzci
         vG35eiYHUk2mw0MYFNVOsqDUB95NSKOIC800Mv0B92X24H04oASB7L57fOqaQ2rKGkGP
         +PvlCaC2KIL41h8C0YCglAB08YbnRyvu3ynKPoIucZ4c3aThPlDkTkxjSnt9IhDEj4/E
         cA4F7SRtOWGsS9Lj16mtazxc4JLnDrY/6U6oYwnekBia2jhA1kjamKsEbGn+o0BA+diT
         gMJ+7SJUunkrePQJr/B0Y+Wkw6x6YkPojQB3lTKAxlUgIqo7IvqKfuO4iyA/QaEqDkUt
         KtHw==
X-Gm-Message-State: AOAM5302EEST+/PKbgpSD8njoL/JcBnCEs0OfyUGFtUxjNz7lpPM94SA
        FxAEAS/OmXmjs+sdEABpXzz8oA==
X-Google-Smtp-Source: ABdhPJxY1Yx1+CTh4SZOnb1fxoaQucy1q7RvAqB3GBbl9vKfDQMW6ddMc084uEsY/jIiGh/MJqYQew==
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr22513317edb.288.1650453116311;
        Wed, 20 Apr 2022 04:11:56 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lo15-20020a170906fa0f00b006e8a81cb623sm6637533ejb.224.2022.04.20.04.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 04:11:55 -0700 (PDT)
Message-ID: <e08a8f96-54a7-60be-0bd4-7a74fdcd627e@linaro.org>
Date:   Wed, 20 Apr 2022 13:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for
 interrupts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414064235.1182195-1-vkoul@kernel.org>
 <0598d1bb-cd7c-1414-910c-ae6bedc8295d@linaro.org> <Ylf2gsJ+Ks0wz6i3@matsya>
 <9d35e76e-5d98-b2d8-a22c-293adcbaadf0@linaro.org> <Yl/iElIfHhmoOYOU@matsya>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yl/iElIfHhmoOYOU@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20/04/2022 12:36, Vinod Koul wrote:
>> If the choice is per SoC-controller, then the best would be to limit in
>> allOf:if:then. However maybe the number of channels depends also on
>> other factor (e.g. secure world configuration)?
> 
> That is quite right. So we wont know how many channels are made
> available..
> 
> So is min 1 acceptable or do you have an alternate ?

minItems:1 is ok.


Best regards,
Krzysztof

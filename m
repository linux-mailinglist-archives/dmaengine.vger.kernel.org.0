Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED0500C54
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbiDNLrY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242434AbiDNLrX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 07:47:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0463C731
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 04:44:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v15so5957570edb.12
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zx0fCIbKblbyaHSD8kB0xZUv7itAhP6P0FADRJhSr/k=;
        b=SJxJ6GD0fYnPbXn2N7hL3uJALox98ts/6qgKxJmGny5r7fLefAfzlrvSFV081uRwkh
         igkYes+yS4TN/C/KyYcXWz+qm5g2tJfqgCCLh3VHgSobaNs0/kfZGA6Rhwfsj3g68Deb
         1Vt9zhQDQYwj5YuWqJ3ucVCYj6T73P2SA32pCk2WCTwTfx7K+UvhDdpb/qlG/MnY3QNx
         BuEAbyq67D2e0kqsIiPA3c10YI/zauzJhYoleZNgJ2PhbZ7aiNVGxDUzYaLx+roguxKw
         kT6iSbJceueLTywTbw3xD8//cC8ulehh5mSshPRLg1E8iS2ZVchp90UifjeRoZh8flQx
         w3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zx0fCIbKblbyaHSD8kB0xZUv7itAhP6P0FADRJhSr/k=;
        b=zL56+sCL1+Ks3p7YkIDr0gCcX7o8R5/7TZaH9Ixo4CttVuLu1/7dTmFlJ2tivxMhIr
         QbN7bRywn724y5fhvR4/7aJ1mmXMESfm3l35CWZ8qoCQH5DWIQzGyb+NItX5p2SnwZ5T
         PVCGqs2/U/56LpKpL3p5MCydauaDHk3pcFsSUxpBzZAQqo6Pa9WSsdWfBiahXEFPnuXq
         dPp5G644RT1J7fPthQkVxS4q9aXNvjEO0eectTVBqqGXbl2m6zqvguK1oXFjKm+8d5rz
         EfsEvs/3K6SZ/LjFEzHL+aQoULuzJWAsUkR4JwChSva5v3CuAydOcd/rJW/uCQRn153Z
         oYKQ==
X-Gm-Message-State: AOAM531AK6m7q/hpn6wkTE2eDHZejKvRZs775UFenUQrlADAgg2AB3eU
        cF5iNTPTV8T5Fh0KkpX8DmGHOg==
X-Google-Smtp-Source: ABdhPJyJE+BERDLwaYd0zLhEJkQhTKTg9UHFI3rbNm0KybcLkz4RcpahDLrS/C2g4PN1uwKcG5Ydsw==
X-Received: by 2002:a05:6402:d0a:b0:421:10e6:2ecc with SMTP id eb10-20020a0564020d0a00b0042110e62eccmr2087217edb.329.1649936697069;
        Thu, 14 Apr 2022 04:44:57 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h22-20020a056402281600b004206bd9d0c6sm917388ede.8.2022.04.14.04.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 04:44:56 -0700 (PDT)
Message-ID: <9d35e76e-5d98-b2d8-a22c-293adcbaadf0@linaro.org>
Date:   Thu, 14 Apr 2022 13:44:55 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ylf2gsJ+Ks0wz6i3@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/04/2022 12:25, Vinod Koul wrote:
>>>        Interrupt lines for each GPI instance
>>> +    minItems: 1
>>
>> This should be some real case minimum, not just 1. Unless really only
>> one interrupt is also possible in existing variations?
> 
> So that depends on the channels available to use which can be worst case
> of 1. Maximum is 13.. Most of the controllers are between 12-13, but we
> dont want to change binding in future if controller has lesser channels
> right?

If the choice is per SoC-controller, then the best would be to limit in
allOf:if:then. However maybe the number of channels depends also on
other factor (e.g. secure world configuration)?


Best regards,
Krzysztof

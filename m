Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD360F946
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiJ0Nic (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiJ0Nib (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 09:38:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9E181943
        for <dmaengine@vger.kernel.org>; Thu, 27 Oct 2022 06:38:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id mi9so1267359qvb.8
        for <dmaengine@vger.kernel.org>; Thu, 27 Oct 2022 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0R27uVh9S1IODnsPNgVc4Gf/GzSriaNtmqZC9M5Tyc=;
        b=gZhPe4VeYbOtt8sG3IB1d1L2z5Q5c9vFXzrWKMnRxbYkuqoSeILYTgVjGUSd/j4aeP
         YtwcqLSLVtH2JghCkBchwyU9TzY67jCbueW9MoSv9Tl5YEhv38RCn1lUswCA0tA4+PFc
         bsop7SntiUqhmzTOSg0YzRRt2NjzRzRl5x9AVv8PJCHwtkWvgqMShR0vUqCbi4eeWSAX
         b0I+qzDDUe/BC1SIVmDclsjqbWJf1yCfzpIiQyYnPjnreh0wZFtOmeqOeOQ7WDOUa3FF
         TeTcnhivb0TGJbrPL+nK+FJyBh286y5AdavZZkkJP1wYqxNjPcUmoNSFDBZ0ZK6QnulJ
         a7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0R27uVh9S1IODnsPNgVc4Gf/GzSriaNtmqZC9M5Tyc=;
        b=Z7l+SIydcNAiyRvle3QO/Hc/own9mHAPFXV2m4g1mPm0Awxn4piM8A8asDEO1+TsXM
         iBYLe0MFiwEGOoZ5o0EKMzg3D6Tb6tCcmvohNxnlqFF8VTGCNLzNkyTBvbzNozHwk+nP
         FJkwRvtpAjWlXWOyMMc3iKGcCYdnbQU2m7xUUJE5zgfHtH1kHGm9xCXqw2KVTaFcUS5V
         MvefHZcYH/YgeH+LdPdhliTGMRZX3MsYjSmt6ChEl1dHtbSASZulJfyixLwjzJLrHb8B
         9hvJyOq6uicwtr6Anw64zGdBjpwI6/nU5afpj5VnL+k27zuAA8495v92rkJgTGEQkujq
         RAUw==
X-Gm-Message-State: ACrzQf2b4VPlGKHclzDonp0Ws9sMfbxrOrTL/7xKkYZGdmqinCXwq74A
        8CIX3SyUg47NL8e3QMGt2UeU0g==
X-Google-Smtp-Source: AMsMyM5cH3mUoy0Vy6ThcdzX44QwG6ALzGgdClmEC9/O+6ZNxX4RBhOn2RkVEFpmCkZZFMT3ujJNcg==
X-Received: by 2002:ad4:5ecd:0:b0:4b7:c95c:2c0c with SMTP id jm13-20020ad45ecd000000b004b7c95c2c0cmr32828493qvb.60.1666877909168;
        Thu, 27 Oct 2022 06:38:29 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006eea4b5abcesm973846qkp.89.2022.10.27.06.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:38:28 -0700 (PDT)
Message-ID: <c5e3497e-c131-1909-f0b7-62b5d5b0d7eb@linaro.org>
Date:   Thu, 27 Oct 2022 09:38:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND v2 1/3] dt-bindings: dmaengine: Add
 dma-channel-mask to Tegra GPCDMA
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, vkoul@kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sfr@canb.auug.org.au
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-2-akhilrajeev@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020083322.36431-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20/10/2022 04:33, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA document.
> 
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


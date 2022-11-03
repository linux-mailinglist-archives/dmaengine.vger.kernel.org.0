Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B14617DB4
	for <lists+dmaengine@lfdr.de>; Thu,  3 Nov 2022 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKCNUY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Nov 2022 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKCNUX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Nov 2022 09:20:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E15FB8
        for <dmaengine@vger.kernel.org>; Thu,  3 Nov 2022 06:20:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x18so1058737qki.4
        for <dmaengine@vger.kernel.org>; Thu, 03 Nov 2022 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uspOLGGocbq7u+IpHZsmh0HxQTXZmKwmF6cTvBu1Rvg=;
        b=TlrLCLvHLsZBk79eT7LdRVQjhTURKZedGehFo010NXK259LQDCx5OZ7j/OrUXYsb/l
         lDOjbgVQ1g9neJajqbaVK2f1VhCdPbI8bcyVseuG481Oug1Lz9N/sWef/y0udPkoJ94H
         Ge5hFVZjB9D90guZvJgJd67oBRby6aHCjRVlTkCi8VqgMQvdEhUyWjZA+cJKBPmB0Lst
         LesqEoA4spvnyC5LTKvfJwQgocuZX9qRPyfoRXtj8JDNQXzIwPQCmi8/3v+A0xVWHkHp
         HolSiy0FbA1s6DxNw06lQD/MUYfs1FeFL/GAsIneNCI7kGLk1NkHmgQcLUjw34pwu3AM
         57pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uspOLGGocbq7u+IpHZsmh0HxQTXZmKwmF6cTvBu1Rvg=;
        b=Y+5sRmTvncKVrWOKsVkOCH22yC2L0WqltI/A7J+oJ5AKrgLSCv9HEAQeptPCZ/kx7W
         jC+7VVNpDvgskalR7dXQRqk8hO94+0MMHdU8NLAIM+vczRbLo1/ntAbW/j0rSDPwmqUH
         0BRncXNwVsg4WFO8HOSZaxon7YvYh7/OJKmuBuubV4r5JJa17YbPL9IK7LbG8LbjlBE5
         psSndJenBllVk3zU4Fcd4VCPO+OEem2kQG9vXsq/e0p+c/03dNC32A5+qNBfFvGRfx4x
         jAEZupAg7NfoX0BN7aV0iZNku8iKHKr3DzdYRlLyJu5qRXcCC2KH5ezc0GydFwolkW/R
         kTSw==
X-Gm-Message-State: ACrzQf0QFzIG2z0qoTSOMv7axKI0j6U34clhwZ84P6oK38D0WaBrA+eu
        Cc4Frx0wBuPHKMRS7PKw17M+Pg==
X-Google-Smtp-Source: AMsMyM6zD3Dvbb/9SA6r/DVJhEPxH88V7aUL08JxAgMrAMGk1ICrkVjBArxs4eMzbL3GDzjbdEdnaw==
X-Received: by 2002:a37:9404:0:b0:6fa:729c:2ce0 with SMTP id w4-20020a379404000000b006fa729c2ce0mr3256676qkd.28.1667481620228;
        Thu, 03 Nov 2022 06:20:20 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id i1-20020ac87641000000b0039c72bb51f3sm497464qtr.86.2022.11.03.06.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:20:19 -0700 (PDT)
Message-ID: <da8761f9-419f-105b-9180-8ddf7f51f20f@linaro.org>
Date:   Thu, 3 Nov 2022 09:20:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width
 required property
Content-Language: en-US
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     michal.simek@xilinx.com, m.tretter@pengutronix.de,
        harini.katakam@amd.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667448757-7001-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/11/2022 00:12, Radhey Shyam Pandey wrote:
> xlnx,bus-width is a required property. In yaml conversion somehow
> it got missed out. Bring it back and mention it in required list.
> Also add Harini and myself to the maintainer list.
> 
> Fixes: 5a04982df8da ("dt-bindings: dmaengine: zynqmp_dma: convert to yaml")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


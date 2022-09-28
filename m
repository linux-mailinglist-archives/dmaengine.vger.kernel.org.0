Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9F5ED6F2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiI1H5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 03:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiI1H5r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 03:57:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EAB4454E
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:57:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s6so19145290lfo.7
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lilscpJXloOe6u1OCL01pzjWBX0iSF1UcV5WaZbsYBY=;
        b=kRWHpiYIbeZtze4zW4Bv4ttblUgLFFhJ1QSnXc3Ogn7cOZPtouoHFkjtojdqrFWjxa
         XGiILdseWv5HKtvNcmTp+gFlK2l9pCEUl/mYHFERqqx3BV890fRqQWNGmoxQ6TFaA88B
         fJzBJyAsRcKJYtblRZii2xzX0O30HgLMEoSED5/kqu/dpIBxRH5AUd+Obro8p144jzl8
         TNJ5nY3qzKJJdF0rCjzrBCQBQwD2IQ+GQi52rzUkAyn4eEuKATpNCuumTAD9EV1E9Eg7
         y6IIj4Ajckxh+tKaza0fvxqSKoC+WspQ+ww6/chBgXrONJnjmgnpRNg6H72bap1JbfK1
         /0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lilscpJXloOe6u1OCL01pzjWBX0iSF1UcV5WaZbsYBY=;
        b=Bwt5WnA6e+/rpwLBW3llygzuFUfhCiBS9rTmkjDFYmR8tngoK4MXhB7v+r6ZkYyFl5
         N9z0ofdRrQLawDTx1GXqa0szJe73G2fFUlEHmRBhqGMHcdF5SvJ+5yK0GN5/cMWXAGEa
         RLGLdwTDzNUrJTZ7cfimyM+pA5IBXOSBJ0e0pk7R+J3SNCSTKbhAhtiRcIprGO0gUCfB
         lflOjeJG7YkgE5Cb9gxNyJgdxfMpxtaJQolyHhW8M+oro5Y7kX8z3pDOBIleGEtFI4NJ
         +6+LVUCzlO9dkiOIrykR82VRk12pmJwkMYVlAf2a9IDb5VjofyxDypHHl58vK3lhS4Zg
         zO4Q==
X-Gm-Message-State: ACrzQf1q65enKE+t/VbeO7TXoGyj5iLq2SVylGwf2Zv0vVQQZnPIyRrl
        nF7OTEuXzvQdNPEoA7p5yq/3tg==
X-Google-Smtp-Source: AMsMyM6xTrGU3lbgaT76uOyGvYMUJBjZ1/b62L/96dIyBb/RE7mX81VbOIKDJ8QoQwEOR04cVy5rdg==
X-Received: by 2002:ac2:4c48:0:b0:4a0:606f:3e85 with SMTP id o8-20020ac24c48000000b004a0606f3e85mr9832691lfk.675.1664351863916;
        Wed, 28 Sep 2022 00:57:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u12-20020a2e9f0c000000b0026c446918acsm365978ljk.134.2022.09.28.00.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:57:43 -0700 (PDT)
Message-ID: <6ab9472d-8229-65e7-dc0d-6b9e8ba9bb78@linaro.org>
Date:   Wed, 28 Sep 2022 09:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779g0 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/09/2022 17:03, Geert Uytterhoeven wrote:
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4H (R8A779G0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


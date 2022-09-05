Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D565ACE48
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiIEIr2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiIEIr0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 04:47:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14344A109
        for <dmaengine@vger.kernel.org>; Mon,  5 Sep 2022 01:47:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g7so12089108lfe.11
        for <dmaengine@vger.kernel.org>; Mon, 05 Sep 2022 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lNSicUzgpjL8VZxpqNJWeYU8tvWfCp+Ey73RuOEEBVc=;
        b=NiI8AKFD3Ft3j6bAMkEMVG83lhnHgpicBUYrof/HAuUAFUNKbLHYAShA9tq/7zUuR9
         efzjcFFJIKdyBip5Ayf0IQuKWddSO78Uc4H5uYGJf8BtuJbkVimDMwHwWvNuoRocWKGH
         YLHSaPaBay9HdTn6HblvIdxB6Ma09ZHBO4NidsgFhJlJWU0XihLH5EQnf2khuJRs3tIO
         tVnq15HwURtwzzn6y5f31a52B6mviUZoMY3DveFvHvVHw/pGvCm6YCCVWVHlcgzXIxuA
         mJOTTi6jBZSCWx2ajzIxTH+abN+vZY7XHzHGC2Oq9gOq8SZha0tctFOYV3wRuY9KGwmB
         9ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lNSicUzgpjL8VZxpqNJWeYU8tvWfCp+Ey73RuOEEBVc=;
        b=cPZcQNOtowKtE0ynH2IGIr3SpI/HMhIcuF3kXq+sCsrjeSuE90Rqq883HMG1+PRCNf
         4E7KaSk/4+N9DkgGyCv+jL/55bjwG76kbX/ubLKZbSrryxzOhwVvKqINGgOtCg5MnVoT
         wRPM3V/MwfOJQ5GVl77vOYn9bzuSktj+zCgVmmqSWP51yaB6BRBFZwVUvk7uj46BlWN5
         Qx+swC/vJ7YSSwgzMOm9Nk0js2O9xZP43/AZLnYS+Zwf7EOFZ98TCtwJKmHsHaOpepzF
         EPrXVNFmv//TzeGcQw9i3qf34sFVYPiXhfbt84zhvFXGyV5zLPU0YE6sz0qetQ6goyoi
         TV0A==
X-Gm-Message-State: ACgBeo18D+E38D8BqXj7t7dneritx9uYVreV3CR2SKgtIioxt9KbZUQ3
        jtVd3KOXIqR4oQ1iF2RgeeDlEA==
X-Google-Smtp-Source: AA6agR4LvFK7QJL7yqaolXMFZ/oGh2HNYG/PWjMMZgRyqbe5Nuh+a9cWB7u1xYuOhKQFjHcMTmGOsw==
X-Received: by 2002:a19:f00c:0:b0:494:8576:1ae3 with SMTP id p12-20020a19f00c000000b0049485761ae3mr7711734lfc.203.1662367643362;
        Mon, 05 Sep 2022 01:47:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af3c090f8sm1133343lfg.13.2022.09.05.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:47:22 -0700 (PDT)
Message-ID: <2df5b170-1fbc-bf63-5d8c-ece7bbfc1568@linaro.org>
Date:   Mon, 5 Sep 2022 10:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V5 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220905083102.89531-1-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905083102.89531-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/09/2022 10:31, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The original
> binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Vinod Koul <vkoul@kernel.org>

What? How did you get them?

Please point to exact emails which gave you these tags.

From my side this is unreviewed and it looks like some tags were added
to skip/pass our review.

Best regards,
Krzysztof

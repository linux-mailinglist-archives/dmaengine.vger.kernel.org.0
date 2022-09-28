Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0D5ED6C9
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiI1HvD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiI1Hu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 03:50:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C17422F0
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:48:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k10so19149010lfm.4
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fI1tRchrI85rvicggm77bMmF6azeSSqCLtvKXNTHIBg=;
        b=QHR4KmAMXvl5eCNlHNg/o5hGkat1QD0dm7c9UmjBxbs+6rj/Zn/1OTz3sMH+Z9ij2L
         w6p5LYjY/KZJMARL7F4KXjbErjpOUwMkyBV/VmBNv6J9iNWt84o2dJ/q8UiRanQG9l/J
         iu6j9OEYp8O9CPz8jcaalVykQ8+6yKmcOTuYr3MyphV1ioRkOQu2gpBpsJ+ZW2872h4q
         E5bjmzU4WFFV9B9rfSS3tieZcttyo1n5WERTHqXWWVcC3LjOozPlzJ4safqTsy1F6872
         1Y5HnQR/0T4eBN3y+Mv4IaeigTlddz9+N6+sQ1Gtmo81AvhMyJEWymsGBZ9y7qb7e3ZL
         +r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fI1tRchrI85rvicggm77bMmF6azeSSqCLtvKXNTHIBg=;
        b=rcjahzIXK4k8jlWuLf+8jovsSip0sLjOIt9HSLu1ZwF9JyyaSZ+x+VPpCyo0iBdAcB
         mWs7MFmTecr/x6jHCrSWsWXFh7HjeQdlPvTboN6j5Ez1M8pJKbXi1LRdBcyx3FSpJwrC
         WRqyyXyk+CvwsbdHkpJT9Diq+enYl4jex33dAzfSIbs5kBfy1g3vxz+E4BwL7iCqqQj2
         J2SDYEOe3mEaajnzphLkdGEhfIsH83ECQV4auRm3PNQJlR9GhlvvpGURInk9kedZ8+JK
         oHFkJtdGTwkHNdtJ/rhTg4XqX7oTgACcJCTCZqZq0ONL4HeZkEy/QgILSBh0/Tajrh3M
         WrUA==
X-Gm-Message-State: ACrzQf3CEhOqWw9SO6d5SXEVBoAMBxPEmojx6FoBycmCbylXS9pHnQ18
        6Is/F5Zxh8vf4nhGgRVcZ4r45Q==
X-Google-Smtp-Source: AMsMyM7HBOquUj8cy+dhskZs6MUPoNEP5zIq4X7VT4ynG8TRKK7P91Kiwel4w2SAL2sAA21CZJBNuQ==
X-Received: by 2002:a05:6512:3056:b0:49b:704a:15c9 with SMTP id b22-20020a056512305600b0049b704a15c9mr13115539lfb.9.1664351326140;
        Wed, 28 Sep 2022 00:48:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d16-20020a056512369000b0049f53b65790sm396644lfs.228.2022.09.28.00.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:48:45 -0700 (PDT)
Message-ID: <7c5e04de-d7f7-eeac-0003-25d882714505@linaro.org>
Date:   Wed, 28 Sep 2022 09:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/4] dt-bindings: dma: qcom: gpi: add compatible for
 sdm670
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20220927014846.32892-1-mailingradian@gmail.com>
 <20220927014846.32892-3-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927014846.32892-3-mailingradian@gmail.com>
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

On 27/09/2022 03:48, Richard Acayan wrote:
> The Snapdragon 670 uses GPI DMA for its GENI interface. Add a compatible
> string for it in the documentation.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


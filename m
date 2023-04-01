Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312E6D2F7E
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDAJw7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Apr 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDAJw6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Apr 2023 05:52:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673102118
        for <dmaengine@vger.kernel.org>; Sat,  1 Apr 2023 02:52:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m8so3390876wmq.5
        for <dmaengine@vger.kernel.org>; Sat, 01 Apr 2023 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680342776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubewBkPby97o40oELqocw2J96D+WGJJIF9H13Ba/6cw=;
        b=Fbtbg7IFl93B8s+l5jjIi1+vv6IyRXiYEWxJZev0SKPEucXNpRygOlsgYhaNIi2XkA
         SAE+HmLtuZRkbK3xBgf8oMKIztfLDtTnUA6qvohVLUES6E+pdNevcfmLVlUWysyAc6B4
         hXDGwzx4TfS1sgJfPpq4hDzkKz4Sb1uqTmDAd+kRIEWeR7VI7bShTcXPAv3GVMPG3UUv
         Y3te1boGoJVdNeImb32MI+sfAn0l5AqaEygPPBXxWJpby6gFFajRq7Fi4W4x1GLVgKal
         vKamKVFVN1H+/1kTcacb2ha/zrFY8MnfoAe8E5whvj70TAtgouA2BglfnHAQabM+WARl
         7MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubewBkPby97o40oELqocw2J96D+WGJJIF9H13Ba/6cw=;
        b=bsAEZDjsfqhhC5cWKTBw1Ueyo1X/3n8hWh8b04WuyGg5v4lSOL2uRPBuVJEDkVdUpl
         meFkKFnY006SK+UI7CnQ6d1PfKEgN2xjQep+gRvfj/jET4+1u4lqeWVo1mydJ71RhKkq
         sr5GJ8XN8LviaSa4J4m3/5S1XgYma61aoDGd6+YrLhq4jVB0lK6BBTWeMEi3/ksSt12m
         psnhuYOSKitco4Sd4/tJSq26ZI4mkSkHIl6UFm/s7R4PQvbsPMnoFP5r0dnnIV4DZD1M
         BLLBGMTIoLGqy5JJ9sq4RSqqhQ6JmLm+pnycXtVYtmCOxx69zcOLsYTl62buDqZFDUmP
         LWWw==
X-Gm-Message-State: AAQBX9d8d80r4tCTb8c/TrfSw4jxyldOXBZl9W2KIL5/FJOSHs9jb5yT
        nL+HD7+FvWyogvxFPp57Lcgpjw==
X-Google-Smtp-Source: AKy350bDZRr78VsY4xPGgA9fKeLTsoROMnZx4JUnIGKxF+xa12guHsktQkku7LNwe1GcqNSz172BQw==
X-Received: by 2002:a05:600c:3b11:b0:3ee:91a8:5ce7 with SMTP id m17-20020a05600c3b1100b003ee91a85ce7mr9609554wms.15.1680342775850;
        Sat, 01 Apr 2023 02:52:55 -0700 (PDT)
Received: from [172.50.14.32] (5-226-109-132.static.ip.netia.com.pl. [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm13084631wmb.40.2023.04.01.02.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 02:52:55 -0700 (PDT)
Message-ID: <bbbad646-16d2-fd35-9aa5-83373b962973@linaro.org>
Date:   Sat, 1 Apr 2023 11:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: dma: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230331182141.1900348-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331182141.1900348-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/03/2023 20:21, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


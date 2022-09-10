Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745E5B45CB
	for <lists+dmaengine@lfdr.de>; Sat, 10 Sep 2022 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIJJyo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Sep 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIJJyn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Sep 2022 05:54:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC318B22
        for <dmaengine@vger.kernel.org>; Sat, 10 Sep 2022 02:54:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i26so6777990lfp.11
        for <dmaengine@vger.kernel.org>; Sat, 10 Sep 2022 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wZ6pO0qP2lP0EdvfsRwhcpTENHXsz3JcKbr3shUc4TU=;
        b=r0Zo8wGfSMBass6kqxL5Z6VCacDKNMGTgphBS/mfV9+5KJ+d8oQrYJhewxDxn5PlYU
         LyfQOOtMDsTTDXEinR3reqsvsNnlAAZrPt49fPx6cDo+6zmKbSDi8VZTRNAPHs867ULx
         VwG+M3+TwAoCEamKXwzzzoCIc2a86UUG4/F3WuBbZzz3roRjPtEerAz2OJeum0+gfu5t
         AJevs8ewiJ9hQIJn2O6InbGR7Y2GPNkSTrjg4qtmP3KpluVPPLnd8DvL07aPLk9bs4ep
         TccaQudoCNHdc4VgqE35KjFTFz8BoLjBNGNLo7MCebKLiw993gLwCA4y/XPScLxRpMg9
         Uj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wZ6pO0qP2lP0EdvfsRwhcpTENHXsz3JcKbr3shUc4TU=;
        b=KLjCF1HzdTn8igdGmSOjT4w9TCb14jIArbwwPklKcleUvbPbgtFitWZInfoI2+yssh
         CArGKrOw0EIvz6OA96ZXFC0tT0V7w6PDDsFnrNNfuWGcYabeaxL3mVI0nz8Dl124IbGc
         sFg+mvDppTAzgQccrQjgjGxRtZalxqpoLkYHniHYMxEhg9g5RXzOV0Vq+KxLp70BnRE8
         jSbBU4/W5DXR5whKqLIhNp2nz+yT3SKOhHZnpRxKSTcpoYsf6tQAW0UosjaFUXgFD90P
         QGr26xDQgrmIhg1l83bvyErB2IUIZBE72QB7yL4q+rTetWcqMm7OF+CT2h83xkA6E0Tu
         Nblg==
X-Gm-Message-State: ACgBeo39Wbr1sBCYliWlrTkOMZtD8OXCDC3myy0hPESdWDbdAVzbnJJK
        SEN7NAc5lad7zxglgat27RmnzQ==
X-Google-Smtp-Source: AA6agR4421xFsdbE0xflRQvnyCMglAk40p1nG6802nRC1Pk/i13y8S35zuJxNCMMgWbJdkcDHs5b9A==
X-Received: by 2002:a05:6512:38b2:b0:493:9a:ac2e with SMTP id o18-20020a05651238b200b00493009aac2emr5486129lft.126.1662803680563;
        Sat, 10 Sep 2022 02:54:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k28-20020a05651c10bc00b0025e00e0116esm283118ljn.128.2022.09.10.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 02:54:40 -0700 (PDT)
Message-ID: <104fb8b5-03fe-203a-57ed-e4c6616989cc@linaro.org>
Date:   Sat, 10 Sep 2022 11:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 02/10] dt-bindings: dma: apple,admac: Add iommus and
 power-domains properties
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        er <povik+lin@cutebit.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-3-j@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909135103.98179-3-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09/09/2022 15:50, Janne Grunau wrote:
> Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
> and has its own power-domain.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

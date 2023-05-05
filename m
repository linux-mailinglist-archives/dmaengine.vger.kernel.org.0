Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E562C6F8832
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEERyO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjEERx5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 13:53:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29AC22698
        for <dmaengine@vger.kernel.org>; Fri,  5 May 2023 10:53:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so3127474a12.3
        for <dmaengine@vger.kernel.org>; Fri, 05 May 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683309198; x=1685901198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDCSv0avH4pfNfNeC0DOfI7drElfKwvWaAkxpPyXO/U=;
        b=arfKTyei82D2UyXmshvlZvVJH0oJdCCSpkmvX0YjpNi5mjm6y6oYSvdQ43htajtoQ4
         BcnJW+vPVPQ7zYB/vjrc5T5ofIzObYgo47OJzOeIbfx/O8ANwJHWWsUP851DaU2aMP2p
         ayvnBpC7iDrYdN62V4K2HSJDJkXNE351nESXoixBMYcxTFjN60q+e4uJxUfqXi/2dq3b
         6Omoq5bHXFUcYvYIUuDS9DUwdYN/U5+Ft26419VRWhnff3e/JhJ1obVVWjrs2V2l34Wn
         Blxjw+k011P5t1fzmrAB7amuknFjzbfpSvKf/cQvrbvi0AtKfrlFr/yNwJy9mVGLvEOb
         NZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309198; x=1685901198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDCSv0avH4pfNfNeC0DOfI7drElfKwvWaAkxpPyXO/U=;
        b=kkpzyaD4SE1y+0z6tRQd3n/Itr3AET04TiUlCruMsCsGIuA6MvMhCV6v7ESZ9K/nDX
         g3dH9J5gYi10M1gXCG4e+ba6Pe7NWooGuQg16zPLdrTSFUq//+gRieoTjrTKf/+4gWj+
         lLKKklH7UklkO1Tw9y6WovysfUzeDpW96IhIY6R9cRYki4rFACy33mm+B5BfFvEsPLlE
         YP2ChCaLkLpZVG1RibuqujfgWCxvXvBYL2I+LHmxj9jFKgXkitJCn8uhYMonqrLgvn0D
         mWRqJS96DtQhmt/8DhBQkBgfwe+yl55//MDwIAV5JGHZxxlpJBmP0cUKgAvc8rFytV0p
         M1kA==
X-Gm-Message-State: AC+VfDzaQCTVjCrvjhHVQzy4L7QgdIZRYi133TMPUW55ES6SBLlIWKbo
        bu772q7JV0zcExn42JUuoaW2HQ==
X-Google-Smtp-Source: ACHHUZ5b628M3V2IEGKahrsnnn1Vpsn6iI70y9x2AVaMedJcj0svHaUAy2+obEw0sOt1nmgZsXRzPA==
X-Received: by 2002:a05:6402:884:b0:4fb:aa0a:5b72 with SMTP id e4-20020a056402088400b004fbaa0a5b72mr2015524edy.5.1683309198718;
        Fri, 05 May 2023 10:53:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c2d2000000b0050bfeb15049sm2251324edp.60.2023.05.05.10.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:53:17 -0700 (PDT)
Message-ID: <883eca69-4ed9-d5cd-8408-13e90c287c08@linaro.org>
Date:   Fri, 5 May 2023 19:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, peter.ujfalusi@gmail.com,
        vigneshr@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-kumar1@ti.com, j-choudhary@ti.com
References: <20230505143929.28131-1-vaishnav.a@ti.com>
 <20230505143929.28131-2-vaishnav.a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505143929.28131-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/05/2023 16:39, Vaishnav Achath wrote:
> Add bindings for J721S2 BCDMA instance dedicated for Camera
> Serial Interface. Unlike AM62A CSI BCDMA, this instance has RX
> and TX channels but lacks block copy channels.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


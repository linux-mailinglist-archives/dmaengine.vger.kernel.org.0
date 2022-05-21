Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9262252FD1A
	for <lists+dmaengine@lfdr.de>; Sat, 21 May 2022 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353497AbiEUOGz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 May 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiEUOGy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 May 2022 10:06:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926959318
        for <dmaengine@vger.kernel.org>; Sat, 21 May 2022 07:06:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v8so16679315lfd.8
        for <dmaengine@vger.kernel.org>; Sat, 21 May 2022 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G/JiRdkydlLW6miQGBKIde5cpkPs5X1Fjry1L1VttZ8=;
        b=kyB5ACp5DuAfVmlH0VGXRH77XLo8B/mgLfzsfy8jooXJhmFYVW81Oja6/l3xtcOTa8
         MM0A/6I5qcbB+I3JU/nsraWIB5cYHPZa3iw13NBrxS67gV3dFCghgpj9i2xuahlWbrIC
         gBKWxBLL6aoVwoIFDpahsY+rTT5ek7sLMfMZ3wZ7zuz+EXgcXVV56rzw3sGAHiUjJCk6
         gEy+UDsYF77Gig16w/+57VmWd+zpmiPQCXU9OlH7mqPLRGBoswRYE92/sB3+4oExf2kF
         TfvkcF37exSKXoC0e6xeaBrloQmxW8z2u42+XhGtadIPZH1hnteqxxZWAOPgWiwrc5al
         VzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G/JiRdkydlLW6miQGBKIde5cpkPs5X1Fjry1L1VttZ8=;
        b=V+nz7alvIVAWJdEaxOqhHEQ05SD8dn2fd0ugChC/gbPQY0xiemh5lt1f7y9qaAx52r
         77gLGhyyW2m6mlJOhJUr+LKG2LkNy89GIDzEvoGAwUvgrxk05OMCXJ25h4hzx0Lq4jUy
         Q3//W25Hr38rYGynoutVeR5furbtDl5iIRo2FMShchQhPawKPb4k4ggjeMM+PLze5IKB
         uW2wk+dF8roSUoiFBSt4ilRbJvZRzhXqpFsWVOMEqcxYrC6hPZFlefIqDoF+ljfklTjy
         azZy8jU10ASliNjL+ZVxHVXZ9U5MgOW0n+tW/SSWrtloBdSEIhiyvQmo5QqwSnJN1L8R
         wwJg==
X-Gm-Message-State: AOAM532ygaFVF838St13M0aQrIFbRataIhHs7ApFn91DcHtNmQIuynEk
        1bU1/7Sd4BwWKyPaEQRwUSk+Ug==
X-Google-Smtp-Source: ABdhPJwXkIO/E6VJ/I8iMFuOXFk5pyRswYiniF2BoI2fFc5koe9Rg/H/T076e7mIyPPEs68Svxv3eg==
X-Received: by 2002:a05:6512:b83:b0:44a:9fb7:784b with SMTP id b3-20020a0565120b8300b0044a9fb7784bmr10379431lfv.547.1653142011456;
        Sat, 21 May 2022 07:06:51 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o28-20020ac2495c000000b0047255d211c4sm1065940lfi.243.2022.05.21.07.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:06:50 -0700 (PDT)
Message-ID: <4db8d4df-9cab-a53e-ddd4-84479af46ba8@linaro.org>
Date:   Sat, 21 May 2022 16:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dmaengine: s3c24xx: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-46-Julia.Lawall@inria.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220521111145.81697-46-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21/05/2022 13:10, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

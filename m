Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632275116E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGLTmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGLTmc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 15:42:32 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B851FE4
        for <dmaengine@vger.kernel.org>; Wed, 12 Jul 2023 12:42:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso115164021fa.1
        for <dmaengine@vger.kernel.org>; Wed, 12 Jul 2023 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689190948; x=1691782948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIaD+R3zG+IeSkSUIKYN7/FjM9J0ujCHdLNlAioODXE=;
        b=I9NrMFNv71nbDBkkb2bhN6OqbX+eRoQiRO3AuxWxTxaXro+Jjwhoen1VDMEl9OtqVz
         gqRfYqZyjjVKViV9+U/Spfor6DD97i5HN1OYw7M0gDy411eTUrL/R9VsEzY/e++cfTOo
         l4DbIe8NE4WG/FoJTr3c4UJWQZiEU6biYmCRIDpddzSNRdbztPI9za51JuCLhsMk1uVa
         ovyxS6Baj9rezP03HVZ+lGtk3v/sVLKmwFz8Gi0lgGX+8m1UhuwwYE2+XhmVD9xhKjUX
         H6qepFNGgT1PeZYvbnJrcRA11X6F9oU9OTlNWa6NpEAvDYCg4cjuuWzlMw0NJYaeD0Yb
         Na8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190948; x=1691782948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIaD+R3zG+IeSkSUIKYN7/FjM9J0ujCHdLNlAioODXE=;
        b=haDoJSeGJcolk3eDwnjLQl3sJlFrOmlBqiqlHMOacXjUQN9kWRRwOE2IZKo7yKaKgZ
         3kXAsH6JUcajite+Bwhzkft22EmXhYxu2S5vfITtd3oVkaDzRgoEtQoK2WerWNxKYbwk
         yfK5RU+NWJyywV+V5BlMlaotgM3+ozUbZdD6z3YWqPRmfugjL2DUHBUf6RJzLgUXSy3P
         Uh1GECn+seeYWrAJttyGEtqEsoNOjXB9Lt/K5gS4cXpFTzsEn1xslMEeTiaM3EARPMDG
         uMifP3XA0KADT3XNFmUFRq1Iqb14KyqqFsJ34JglglERvISXRU52oQQh22Y6yG8ORqc/
         PrlQ==
X-Gm-Message-State: ABy/qLYPyiLzB2JwCI6JAF/ZZQ/bulEe9x3gi5LbOHNszfseDpGcRQL6
        YzRo8ipbJ21wXlYga0qqeegbmvL+nfJFlPe+7hFukA==
X-Google-Smtp-Source: APBJJlGoL/j2CRXfaB7Onsdnsesrdy0+qIqa9SdRzh/jrIZDLn63/iDHTEz5Bw876Y6VbC/ijnBzrg==
X-Received: by 2002:a2e:9909:0:b0:2b6:eefc:3e4f with SMTP id v9-20020a2e9909000000b002b6eefc3e4fmr17335677lji.21.1689190948673;
        Wed, 12 Jul 2023 12:42:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm2954697ejb.36.2023.07.12.12.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:42:28 -0700 (PDT)
Message-ID: <f4c19365-4006-50f7-6c4a-754c2a87c8ca@linaro.org>
Date:   Wed, 12 Jul 2023 21:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Apple SIO driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712133806.4450-1-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712133806.4450-1-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/07/2023 15:38, Martin Povišer wrote:
> Hi all,
> 
> see attached a driver for the SIO coprocessor found on recent Apple
> SoCs. This coprocessor provides general DMA services, it can feed
> many peripherals but so far it seems it will only be useful for
> audio output over HDMI/DisplayPort. So the driver here only supports
> the DMA_CYCLIC mode of transactions with the focus being on audio.
> There's a downstream prototype ALSA driver the DMA driver is being
> tested against.
> 
> Some of the boilerplate code in implementing the dmaengine interface
> was lifted from apple-admac.c. Among other things these two drivers
> have in common that they implement the DMA_CYCLIC regime on top of
> hardware/coprocessor layer supporting linear transactions only.
> 
> The binding schema saw two RFC rounds before and has a reviewed-by
> from Rob.
> https://lore.kernel.org/asahi/167693643966.613996.10372170526471864080.robh@kernel.org

Thank you for explanation. Then this is v3, not v1.

No need for resending, but if it happens, consider naming it v4. :)

Best regards,
Krzysztof


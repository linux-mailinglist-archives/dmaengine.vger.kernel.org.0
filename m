Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A11595779
	for <lists+dmaengine@lfdr.de>; Tue, 16 Aug 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiHPKEr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Aug 2022 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiHPKED (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Aug 2022 06:04:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B31C9EBB
        for <dmaengine@vger.kernel.org>; Tue, 16 Aug 2022 02:27:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so14109280lfb.1
        for <dmaengine@vger.kernel.org>; Tue, 16 Aug 2022 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YuhzrIsKzKoxljsJquJ+N3MzsaKkJkpZ8K+pC1+WTlM=;
        b=wvHYOe7vCMOWiQ0nymIOzn6F2Mne3tojRiURaRTfDlx8FNTjviNmtXGdZM75UXUnsI
         4IJv3jaEffif/5cR/jc3VDh/QkFxJ/mVnVnpvjn/oYVEMe2zWGUM0jzGCHv8NkZDcROz
         6Vk+KUYDHLL6g3rS7ddA57gEnvLXZoxKtLKPZ5RrmtNpILJQMwIzy7LZDxvUdy086HUL
         CV7KHiz9zQsx4F/1AbNzNU4AzslfxAnj7G76D02AoxRcoE1yWk+vm+b+RpiyetKqSKg6
         f0A/pYcy5s2efGQypmfyLv8jQT2zNLjBHrHR492VnDTElyGmysFM4varqCcY2u4yJ+wD
         qWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YuhzrIsKzKoxljsJquJ+N3MzsaKkJkpZ8K+pC1+WTlM=;
        b=4fQ3Hu8u5/sA5D5PSFx1pnpS12+HargjERDWSLWyfVWGhDnIqPXeO9pib/7ZJCEdl5
         UBJhUNxzuwJOOP0yH/UYBZkvoA0pdAq4VIBOy8DM8mOylhY0UxP4PV3fDwtbiMr5iVwp
         +krr9rPO6e0ViedO/BrqYjURqF7ho/mH8HjGYu8gx5BdNva4U7MPtTj9PU1eAG44U+qv
         O2X84nVTv5ixds+XDfsWI5sl850SSDX/AMINUFDflCzP+4zpdAlMS03knR/Ry23HpPKt
         JuY4Tola0hqPBisuRcP/oZ1RF+2VAidN3eR7+TMO4wgcObDhzZaeKyU2vUCURcglOcly
         2LWg==
X-Gm-Message-State: ACgBeo2xKogt4PNg5p32DzTV0Ks1yoIaLl54SyNKOIvdhMCwcXG10Iha
        HKfAzv7R+OAny3F5GiMm0vi70A==
X-Google-Smtp-Source: AA6agR6s2p78Qi53zblpaHXfrGi//J3wJqGVT9FrxyRs6MqrWgTRPUjHp/ZhteJLKa8SqLm3gh6NhA==
X-Received: by 2002:a2e:7007:0:b0:261:6dd1:e0f5 with SMTP id l7-20020a2e7007000000b002616dd1e0f5mr6503137ljc.394.1660642025713;
        Tue, 16 Aug 2022 02:27:05 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id e19-20020ac24e13000000b0047f8e9826a1sm1331015lfr.31.2022.08.16.02.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 02:27:05 -0700 (PDT)
Message-ID: <d6acd450-a3bc-d5bd-eda9-9664e6beadf9@linaro.org>
Date:   Tue, 16 Aug 2022 12:27:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 04/13] dt-bindings: memory-controllers: add canaan k210
 sram controller
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-5-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705215213.1802496-5-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/07/2022 00:52, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 U-Boot port has been using the clocks defined in the
> devicetree to bring up the board's SRAM, but this violates the
> dt-schema. As such, move the clocks to a dedicated node with
> the same compatible string & document it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Does not apply to my tree. Please rebase and resend.

Best regards,
Krzysztof

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84F5122BB
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiD0TbZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 15:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiD0TbB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 15:31:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FB49CBF
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 12:26:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id iq10so2323807pjb.0
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh6OruqftWVABxdIhH7SnyaHoA0qU1W0oHzil2WC0bg=;
        b=H0ewu+vW4sL/wxXv5X+gxum+hcUKmJMcww5kKUqczHc+mt9UWe4iAcmFIOaIegviYl
         1KtltKngsgPch0KyCv8oHKs0gCtlctGXfAeFsjCNYBte1GWRnnULtzmsiTAVLFGRV7TN
         TCG9LVKiDkogUp2z6Xx88Zrypj0MifR0YbOKF/Xvuml+2xWKYAGs/WFzo34zSRW9fj2h
         7yxP6QN5uFqUYISM++GywuuzpNybpaomxtqAic/1nJ2Aj/oYHMMNvMJq7pKrZkXYpkHj
         Xey2h2t9/BHaCB2X02MMnLHqwaU4z4QeI9neMwW4alJVjhzlfgL9+bi8IVPwa0iE50EM
         sRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh6OruqftWVABxdIhH7SnyaHoA0qU1W0oHzil2WC0bg=;
        b=cNuAC0RiBBQMqTJP47MP3wjSxmDE17OObJsaLaxYeBJi+/PgO9xzh/mFdMGODJkuF4
         p7FX2CYgWmoqX1Z5Ya6Ve5LCQlfgImN/3KZOkuYTz3F7503C22/NpY3Vt0tTqvY3YYUe
         JU0btSUaFwtUvDEKXjEAwUCItihhDQRZvmhaqyjQ8gUIdr6TT1b6FtIHuQrh6GOXVGII
         fVVeLJMAeRmdQwZLzQ4B0UBG2ZE5Jm8uMNboMGYXLHq2ZOlJzGsANH8/KzIorwC+O56U
         kNHLsdVtRukOe6Crig20F8Qzax3Fb9VDlfrJh8GWcQzaJ90SJ70uCuLCT4XeOI5ouP7w
         BSQA==
X-Gm-Message-State: AOAM531r388W+MB0+W0rPwLCZLr/RcQf2g8uSEeD2oZ+/0iKePBLT5T/
        8sBQ0DRUsjZyQA1189soLQdHg/MFXFECN4kGXTaykw==
X-Google-Smtp-Source: ABdhPJy/L2J+5OoIpxaGiRpuV3AwRbWlKTOcnXs7FNJGXIHoh6wHrVu8SWrx9z06Lb4N/QlJ6EwayAMjLnq71CnqN+8=
X-Received: by 2002:a17:90a:af98:b0:1d4:67d4:d122 with SMTP id
 w24-20020a17090aaf9800b001d467d4d122mr34597645pjq.166.1651087614892; Wed, 27
 Apr 2022 12:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
 <20220427161126.647073-5-krzysztof.kozlowski@linaro.org> <YmmJfInA0hNQOhDN@robh.at.kernel.org>
In-Reply-To: <YmmJfInA0hNQOhDN@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Wed, 27 Apr 2022 21:26:41 +0200
Message-ID: <CAGE=qrp1GAVxDF4b1iBigdvbONwsF0jhfcLG-Xt3pjm8VAEdiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: am33xx: use new 'dma-channels/requests' properties
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 at 20:20, Rob Herring <robh@kernel.org> wrote:
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index f6ec85d58dd1..55ffb0813ded 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -461,8 +461,8 @@ cppi41dma: dma-controller@2000 {
> >                               interrupts = <17>;
> >                               interrupt-names = "glue";
> >                               #dma-cells = <2>;
> > -                             #dma-channels = <30>;
> > -                             #dma-requests = <256>;
> > +                             dma-channels = <30>;
> > +                             dma-requests = <256>;
>
> You could keep the old properties for compatibility and to apply
> immediately.

Indeed, that's a nice solution. Any preference from TI SoC maintainers?

Best regards,
Krzysztof

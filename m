Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05C0562580
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiF3Vno (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiF3Vnm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 17:43:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570453ED0;
        Thu, 30 Jun 2022 14:43:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s10so286213ljh.12;
        Thu, 30 Jun 2022 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m2lAzkI1kyUA6X4SSjR8xwr1vZy0wQogLl8c1xpaHQU=;
        b=lrWda6wWNqrPSJmZGSOm1ISr7wKduLFWi1rtfL/yScVS9rHmDVD4N/9zCj+VSJ1+Oa
         FO9NZKuJMIQLUjdIYTiAb8HTBGYm+o9Ez2NIlum6kfuR5+fovJBM/7p+CV2LxVlJ3E6G
         KbNf1TNhzph7T0TL/sDQ4Hw8iQagGqS9jY2lgDmk2pKIsLr0eEUC7CM3K/ir9SVbBuVr
         mnIbczJybBGXfmK7KjkwqGLjfxGX15NKjz6h67HEK5siEgqdufHy9gcSjXVGAN/0WIOu
         yx7sM7I+pjTlcSePBegIfy7IPhw66UH8cQ9c4cOTJEpeHnzk0zgK/utetinXxDnU/V10
         Rp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2lAzkI1kyUA6X4SSjR8xwr1vZy0wQogLl8c1xpaHQU=;
        b=k5fDSAuqcT2GPCs27EbAeTIShh9Vywl85GN/Os18d1EYLykxykL9fcxpVYX4b2QJeO
         62H2cL2dSnWMHJDFruCcBC/91Sr6clQNh8qPCZ7M4GkbtgD4tEeT34VsJbOSjYvtRYHh
         MekweoXEhVnWOaiKdW8AfGNJZQCRttB5gdoyUBER1XWw1ZREU8FnrrwbEbavxdYjiNvz
         An3IpI6cxdMtrq+DGa6Vk3exw/IzTnQOvP0FbT7a4YiTns6Z1P6IXh9Zh6syHle7ED3j
         QpllWLxpYnGTEOp34y/x1p2IHEw86ZrCg7+wJZalfivTYilGyBQDI+Iu8L0N37jFNCKS
         FgJQ==
X-Gm-Message-State: AJIora9TQv9SBp/5v/12RMeXsp7TNNMXROfIlIB+au45rGeWTC1iEXjb
        nefFflRReizELTHq8l74LT4=
X-Google-Smtp-Source: AGRyM1tiXOSoDewIDtJQjZ6heJh2v6Etx9okcGhLJIyxUHhTxknHodjEWzqlCQs2mLldDoYhOHP8Ow==
X-Received: by 2002:a2e:a793:0:b0:25a:74f4:b377 with SMTP id c19-20020a2ea793000000b0025a74f4b377mr6429372ljf.177.1656625419868;
        Thu, 30 Jun 2022 14:43:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v22-20020ac258f6000000b00478f739f1fdsm3296894lfo.103.2022.06.30.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:43:39 -0700 (PDT)
Date:   Fri, 1 Jul 2022 00:43:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 04/15] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width
Message-ID: <20220630214336.tyhll4ldrgdibnjv@mobilestation>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-5-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-5-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 29, 2022 at 07:43:33PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Most users of dw-apb-ssi use spi-{r,t}x-bus-width of 1, however the
> Canaan k210 is wired up for a width of 4.
> Quoting Serge:
> The modern DW APB SSI controllers of v.4.* and newer also support the
> enhanced SPI Modes too (Dual, Quad and Octal). Since the IP-core
> version is auto-detected at run-time there is no way to create a
> DT-schema correctly constraining the Rx/Tx SPI bus widths.
> /endquote
> 
> As such, drop the restriction on only supporting a bus width of 1.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Link: https://lore.kernel.org/all/20220620205654.g7fyipwytbww5757@mobilestation/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index e25d44c218f2..0a43d6e0ef91 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -143,12 +143,6 @@ patternProperties:
>          minimum: 0
>          maximum: 3
>  
> -      spi-rx-bus-width:
> -        const: 1
> -
> -      spi-tx-bus-width:
> -        const: 1
> -
>  unevaluatedProperties: false
>  
>  required:
> -- 
> 2.36.1
> 

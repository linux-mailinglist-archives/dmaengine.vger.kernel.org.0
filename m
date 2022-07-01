Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F49E563A1B
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGATiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGATiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:38:19 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D221CD;
        Fri,  1 Jul 2022 12:38:16 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id p128so3236814iof.1;
        Fri, 01 Jul 2022 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYGwea+9Dc5qlyJ44ffM89yyXqLnWemdQ1bnBNc3VDk=;
        b=6QOA9ax1kJ8lkvv7TbUOkArIBVr509K1DVj7ov9NudWzDoZ/76i0t0514oVY23C9HL
         cUFsbPL2bDjYLGVGIe1m3p75/Z46VR2itFkRrcisIh3BuSzEIAtnnDOcJvBLRIpzdlCS
         ig/xwG+m2OYOIgBuMR2rNnwn8To6fvbFdN7X7lVtei4PoIRTgDrG9hxrKYvOadS77K4v
         s6P8tZpXpQL/nBxF6o8yZ3qFEPyWeYwGmJBcgPoPnZd5xzewxcNCn5KO7Mgj3fCWSjCG
         7goLcJo64Plmu6B+aOZJIEjlujTKx3kLIiqUO+jtufzY+Z0Vo8uXkwbf2FOJmzU4cBz7
         P/Lw==
X-Gm-Message-State: AJIora/XWL19NAAWnEz02E5YZrtidnUeLstev22l9xQZQwtaTmcpHkdI
        Ha62FMqts5lrGjosGGKN/g==
X-Google-Smtp-Source: AGRyM1uejcIwzsBE+pycB2Qnm2yYV9wtrnyFGLocbsLu1VxbRBag5KlqP0ugvtvcy/HrL02BZGM2Jw==
X-Received: by 2002:a05:6602:2e8d:b0:64f:b683:c70d with SMTP id m13-20020a0566022e8d00b0064fb683c70dmr8094734iow.62.1656704295753;
        Fri, 01 Jul 2022 12:38:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v1-20020a92c801000000b002d8f1269e97sm9277818iln.42.2022.07.01.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:38:15 -0700 (PDT)
Received: (nullmailer pid 1385506 invoked by uid 1000);
        Fri, 01 Jul 2022 19:38:12 -0000
Date:   Fri, 1 Jul 2022 13:38:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        David Airlie <airlied@linux.ie>, alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: display: ili9341: document canaan
 kd233's lcd
Message-ID: <20220701193812.GA1385448-robh@kernel.org>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-3-mail@conchuod.ie>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 29 Jun 2022 19:43:31 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan KD233 development board has a built in LCD.
> Add a specific compatible for it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9341.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

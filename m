Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E12567745
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGETFF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGETFD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 15:05:03 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED11F2F4;
        Tue,  5 Jul 2022 12:05:01 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r133so12034122iod.3;
        Tue, 05 Jul 2022 12:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYhNf6ucb9Y2EJr3g3GFcYGSI7hDN6hlWNBPyCne12o=;
        b=Pe4g34VHQVxOjub77kD54vPBLa9W6BwrfRPXzWJT8DKVW40qLZtc7b9xi6pmb5OiKp
         aAek+Nat5xaMFmXPogqshZ67PQHDEqBcUcz83gu6epw2qK3ZpKYSMVVc6Wddov4xbf0w
         Uf96DPgwjgqxOintXvq2PHon3q0rx87pp5e9VJqTPIXRUYKHILqeGXGBT/G4Grkt8I0O
         VwG/76oKc01OF28zlpvkP//IyPKRynlvez3zkWVKZSghD+cHRvx3I2BjwskSHVqtEjfO
         ese3NuLHvd808R7QPh85/65OsfBGGdvvWm2am1LRqs2U2z4x+L82ow+DKJ5D0GQv//Dt
         hD3A==
X-Gm-Message-State: AJIora+IhlN2yVVTzqrsTzAVh4uWl+fSc+YDHQQITGFY/LKbYC7EeXPi
        Rm1uI8fylUpmVN93IyNQHQ==
X-Google-Smtp-Source: AGRyM1vbgvYpzb6OcGyK9lCHO48fmdYxy4SEAi8PzKsPwRclsAgNdeYXBff/q4XTwjXyQVl9lebl7A==
X-Received: by 2002:a05:6638:2494:b0:33c:cfb8:1e3c with SMTP id x20-20020a056638249400b0033ccfb81e3cmr21373745jat.139.1657047900325;
        Tue, 05 Jul 2022 12:05:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x8-20020a056638026800b00339c46a5e95sm14948822jaq.89.2022.07.05.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:59 -0700 (PDT)
Received: (nullmailer pid 2450909 invoked by uid 1000);
        Tue, 05 Jul 2022 19:04:57 -0000
Date:   Tue, 5 Jul 2022 13:04:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dillon Min <dillon.minfei@gmail.com>,
        alsa-devel@alsa-project.org, Albert Ou <aou@eecs.berkeley.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        David Airlie <airlied@linux.ie>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/14] dt-bindings: display: ili9341: document canaan
 kd233's lcd
Message-ID: <20220705190457.GA2450821-robh@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
 <20220701192300.2293643-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701192300.2293643-3-conor@kernel.org>
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

On Fri, 01 Jul 2022 20:22:48 +0100, Conor Dooley wrote:
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

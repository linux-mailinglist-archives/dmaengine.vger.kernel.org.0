Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE755CA82
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiF0XVD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiF0XU6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 19:20:58 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3802409C;
        Mon, 27 Jun 2022 16:20:57 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id 9so7068761ill.5;
        Mon, 27 Jun 2022 16:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceugb8p4sPvAqdgfnrtKA+vm4NF5OVcyALYNjlDqlwc=;
        b=sxj7HwZX/9oe0maUX8lgNW1svrV1RXJUlII9vme75BkpkfheoxhToZYRxI80TGpXH8
         oCBft+NZVynC1t4FozPjyqVlYnqLnvQgU7NZ55YOmhWo6iVM64BQR1SQx3RMFyj3C6kJ
         XSNfGvic1hZ9ZTDGE2DfG4F+hpMWC5wdAJEnWcSdu0j9e+R/nT08UeivWDNs6MvdWL2S
         BdwXT4MN9QzoYR+Bu/jZXosj5pl2iuQYbmrQqzfg4a7zRuAXMzRJS7uRNzk7Jvn9C4ir
         UrLqKT0lSaxZRz7s/f88DnVZJTz+OdxVQ2AzB7qfU8gTb+rJ7niSQT6VxdgQhU39jKo/
         DfRA==
X-Gm-Message-State: AJIora+lPxxCLJohhuAmgLza3D53v87JxPUAjSmzsL5vD9nQ3CDSd2+b
        Z8r59ebBqZ2JodvezgozMw==
X-Google-Smtp-Source: AGRyM1s2ztwoSBusasaBa/b2ACZCEycSaaxHL4lJfIIeTxh/zrx32YNfVPG2AlRLoX75ei2t68AjEQ==
X-Received: by 2002:a05:6e02:214e:b0:2d3:df8c:611 with SMTP id d14-20020a056e02214e00b002d3df8c0611mr8403927ilv.295.1656372057040;
        Mon, 27 Jun 2022 16:20:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y4-20020a056e02128400b002da7e147de7sm3137057ilq.17.2022.06.27.16.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:56 -0700 (PDT)
Received: (nullmailer pid 3155702 invoked by uid 1000);
        Mon, 27 Jun 2022 23:20:54 -0000
Date:   Mon, 27 Jun 2022 17:20:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heng Sia <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
        linux-spi@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH 01/14] dt-bindings: display: convert ilitek,ili9341.txt
 to dt-schema
Message-ID: <20220627232054.GA3155668-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-2-mail@conchuod.ie>
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

On Sat, 18 Jun 2022 13:30:23 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A dt-schema binding for the Ilitek ili9341 was created as
> panel/ilitek,ili9341.yaml but the txt binding was ignored in the
> process. Move the remaining items in the txt binding to the yaml one &
> delete it.
> 
> The example in the txt binding has a spi-max-frequency which disagrees
> with the yaml replacement (and its own documentation) so change that to
> conform with the binding. There are no users in tree of the Adafruit
> yx240qv29 to check against.
> 
> Link: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/display/ilitek,ili9341.txt       | 27 -----------
>  .../display/panel/ilitek,ili9341.yaml         | 48 +++++++++++++------
>  2 files changed, 34 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

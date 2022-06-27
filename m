Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5666C55D5FA
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiF0XS6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbiF0XRE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 19:17:04 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93548237DD;
        Mon, 27 Jun 2022 16:17:03 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id m13so11289896ioj.0;
        Mon, 27 Jun 2022 16:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ch0+XgUThIc/l8CQOuy5NljTuESRwdl/Mc/QQ/GRHwY=;
        b=pjU7DN1sQJFsGG2xkaentequitCQpPr4TdiKIC8KP91Yzh2S0zfkfheJ15HWFTK7Ti
         ie7pbz+r3DcvPY8gt7FIwXQTICVzR9te7HIVusBI5cpUp+iz8smL2Vi8JPxWvd0o9ss+
         BpEtFIZ0Uk73fEtprN1QrEkfLeQ7clhfK1+a0xnInd4KRKuyXIpUL2ZUVdVL5QO4F54o
         4Rj0C9RThf8P7gMkVaYxGXMe7Hw+CzYFj/b+vxixO6A1V5ivfLRL9AFtWGboGSfLdt1w
         8N84UlxJIxsaUD3RKFtivBKSg+VnhJnq7sG0Nda0fnvj0Y8NNNsvSQcs4rp0EfkNk+qG
         0CiA==
X-Gm-Message-State: AJIora/+dEhUkOmNP3bpVzUeQ1tiLMYvMB8T2IuIl/mznBf6FhmeUjNo
        FlnMQ2YPTFbGrqRtakH6qw==
X-Google-Smtp-Source: AGRyM1sQjARQFnKoj25XCNLdCib4jTOupm0g5QOmkXXsBc0eHF5rPc9gxrBwiTwvftgDQ3k5Qq4cZA==
X-Received: by 2002:a05:6638:190f:b0:339:bc9b:4d90 with SMTP id p15-20020a056638190f00b00339bc9b4d90mr9292586jal.153.1656371822830;
        Mon, 27 Jun 2022 16:17:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p16-20020a92d690000000b002daa70b6a83sm630571iln.20.2022.06.27.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:17:02 -0700 (PDT)
Received: (nullmailer pid 3150543 invoked by uid 1000);
        Mon, 27 Jun 2022 23:17:00 -0000
Date:   Mon, 27 Jun 2022 17:17:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
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
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 02/14] dt-bindings: display: panel: allow ilitek,ili9341
 in isolation
Message-ID: <20220627231700.GA3144115-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-3-mail@conchuod.ie>
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

On Sat, Jun 18, 2022 at 01:30:24PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The dt-binding for the ilitek,ili9341 does not allow it to be used as a
> compatible in isolation. This generates a warning for the Canaan kd233
> devicetree:
> arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible:0: 'ilitek,ili9341' is not one of ['st,sf-tc240t-9370-t']
>         From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible: ['ilitek,ili9341'] is too short
>         From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> Allow ilitek,ili9341 to be selected in isolation.

Just because you get a warning doesn't mean it is right. ili9341 is a 
panel driver IC, not a complete panel. It needs a more specific 
compatible.

Rob


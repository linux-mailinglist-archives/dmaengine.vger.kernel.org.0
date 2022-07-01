Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DBF563A45
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGATjp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGATjp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:39:45 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1021838;
        Fri,  1 Jul 2022 12:39:44 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id l24so3180436ion.13;
        Fri, 01 Jul 2022 12:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIjC0VMQYlxHq3YH9uFPu/iSI53LcMMtf9U7T5PvCVs=;
        b=cfAubZsU4vH3ke+fVNXNIi0c5jUxpIvnmJmZu4FNH9hWpuL+zwdwOvQjOyg50cIuCe
         NX6erTPOPPlF22Id5Ir9xVMj//bnVQHBkaXYoi59K5qhn0Z7ynxAABH3xOIquWkv5qv1
         QtqrgvQDWO7M6Yp3LH+8djwH8GM1e/k07rmqm4uyAzD6lZ42IsRlS9inBeS7/rGkcPcL
         R39d9Ul2Ing1qH0qY8bMap2fpF5NVDU+u454ymmlwPO4R+H1e+eCicrGP2yIPTPJkwYi
         NAby+zuSxUrc3iM9rrW/13Q8C8dJQNeWJ/bCT+vv9Wqy91+sZuFqoyUg9M4tXozWjpCr
         BQwg==
X-Gm-Message-State: AJIora895tO1OnbqSNK+s2p/ebW8exS+/S+84a8RW18j9NSPZwOuQKgD
        aSXnsUmxnrurlUMPsY/tVA==
X-Google-Smtp-Source: AGRyM1uDFG3jh7RbZC85xymUau5rtrth9s79OSclwWORLisSXLGll3gQmu6p4g13FmIUZ+MxpdIJrQ==
X-Received: by 2002:a05:6638:250b:b0:331:b103:8b2b with SMTP id v11-20020a056638250b00b00331b1038b2bmr10057080jat.246.1656704383511;
        Fri, 01 Jul 2022 12:39:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n3-20020a02a183000000b003316f4b9b26sm10145706jah.131.2022.07.01.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:39:43 -0700 (PDT)
Received: (nullmailer pid 1387930 invoked by uid 1000);
        Fri, 01 Jul 2022 19:39:39 -0000
Date:   Fri, 1 Jul 2022 13:39:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-spi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, dmaengine@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] ASoC: dt-bindings: convert designware-i2s to
 dt-schema
Message-ID: <20220701193939.GA1387897-robh@kernel.org>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-4-mail@conchuod.ie>
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

On Wed, 29 Jun 2022 19:43:32 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Convert the Synopsys DesignWare I2S controller binding to dt-schema.
> There was no listed maintainer but Jose Abreu was the last editor of the
> txt binding so add him as maintainer.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/sound/designware-i2s.txt         | 35 -------
>  .../bindings/sound/snps,designware-i2s.yaml   | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

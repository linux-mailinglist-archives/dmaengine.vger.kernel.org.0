Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6D563A3C
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGATlP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiGATlP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:41:15 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D92F3A9;
        Fri,  1 Jul 2022 12:41:14 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id p69so3194842iod.10;
        Fri, 01 Jul 2022 12:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHrkVsGF6yh4atuN/qmRjWl7VEZw4egW+a3OkfBFnbM=;
        b=dGi5+IWxZifomVeULEctZ3YQFR290GiVtHsyAMm5umYyUBQ+jB9Hv5NeznFD7fA0cB
         P/u4xHKGwRmltwtCNarrU7iOHS3IllRlg6VcOt08mO/pVtKz7O0CKbSh+IVfmtmn5FGw
         JU8LmPK3V6zRxDiwVhXzOzJNQ2Nzva8vtu3d0HO37w1bXMVO93D4hVPZ7fdeIkrb+gto
         m8cX7nIwRrWnAUNPeAcphlRh5LqJYGbmECuVXEL81UUJIOrzcmINPNJ7vlvs8fkL4IJo
         bzGEdHeNFiHfNHt3o1x3JWwGmRyT/rAUhgFX9dcMyg2zoylIq1bmrFK2zjAUGn+RC6z/
         ZSWQ==
X-Gm-Message-State: AJIora9brTUYWoEdOOyS3/AoH3VYrGcgnAijMduDkXBwm28mymhv3if7
        1E6Ejds0Y9eqNarxYh5zqg==
X-Google-Smtp-Source: AGRyM1tlsN2RCONvqgzA0GpBUrUts90pmA7r74l1wJj1YnzPtK+Cu6hEsfzhUTYnzJsijdJvLVfcBg==
X-Received: by 2002:a05:6638:33a4:b0:33e:9335:9f0e with SMTP id h36-20020a05663833a400b0033e93359f0emr5171953jav.260.1656704473689;
        Fri, 01 Jul 2022 12:41:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y1-20020a02a381000000b00339c855eb15sm10186415jak.27.2022.07.01.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:41:13 -0700 (PDT)
Received: (nullmailer pid 1390347 invoked by uid 1000);
        Fri, 01 Jul 2022 19:41:10 -0000
Date:   Fri, 1 Jul 2022 13:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     fancer.lancer@gmail.com, mail@conchuod.ie, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, sam@ravnborg.org,
        Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, joabreu@synopsys.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 05/15] dt-bindings: dma: dw-axi-dmac: extend the
 number of interrupts
Message-ID: <20220701194110.GA1388036-robh@kernel.org>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-6-mail@conchuod.ie>
 <20220630215540.cifnzovya57bgbsw@mobilestation>
 <f7d64f1d-9fb8-6259-cd60-8bfc65636300@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d64f1d-9fb8-6259-cd60-8bfc65636300@microchip.com>
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

On Thu, Jun 30, 2022 at 11:12:53PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/06/2022 22:55, Serge Semin wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 29, 2022 at 07:43:34PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> >> controller, but according to the documentation & devicetree it has 6
> >> interrupts rather than the standard one. Support the 6 interrupt
> >> configuration by unconditionally extending the binding to a maximum of
> >> 8 per-channel interrupts thereby matching the number of possible
> >> channels.
> >>
> >> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 51
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >> index 4324a94b26b2..e33ef22aec9c 100644
> >> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >> @@ -34,7 +34,9 @@ properties:
> >>        - const: axidma_apb_regs
> >>
> >>    interrupts:
> > 
> >> -    maxItems: 1
> >> +    description: per channel interrupts
> > 
> > Description is inaccurate. It's either combined or per-channel IRQs.
> 
> I will change it to:
>   interrupts:
>     description: |

Don't need '|'.

>       If the IP-core synthesis parameter DMAX_INTR_IO_TYPE is set to 1, this
>       will be per-channel interrupts. Otherwise, this is a single combined IRQ
>       for all channels.
>     minItems: 1
>     maxItems: 8
> 
> How's that sound?

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

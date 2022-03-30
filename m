Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482044ECC84
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbiC3SiW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiC3SeN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 14:34:13 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65145FF6;
        Wed, 30 Mar 2022 11:32:11 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e189so22917940oia.8;
        Wed, 30 Mar 2022 11:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=p7RLOmPhVN+XXHIq5ojAzjaursZDjvFUP+3MuJu/be8=;
        b=YTtGdEZF4q9U3TVqwiv86p+A1fI20ofWTZ6qHYziaOPGMHEJkk1QZGVgZZyT+iZJa9
         mWqwXouMdXXL2sgFfCDXmrmkRTualmvxW3OhfZ3FhdO+pnzqfcd79q1eRE7wAhOd4XMl
         8tx12q4LaZ4UWs39sKIIymSw+qvxLNsNAhCIX7E90A1q95YahTMJTE6YfRbhagjTB3O7
         WROjSIFjm3nPvtPtLrHhvq6+bNL9pCXp7/IHnGyzPV+VM7UxyIkIcrlHDNCQFr7ahlr4
         G4sNn81h3N9jP7zHj65YHHwHIbQrJcTCafoX5NFYRJcxGSvvW9/Af5ypZ2GhooAH5HGw
         tjrg==
X-Gm-Message-State: AOAM530IYdHvwZkjbKkamQfPf/ndDjHSAaG4YmQiXxrGhisa7BrPmLIa
        qn0rMNUrLPmJECQ11sIEtQ==
X-Google-Smtp-Source: ABdhPJw2WztYoeKhnwsTLdMcSeH7vaNnIsOZGBGNP/EK2mQe1so3+Js3sL3Ti4ohFwUEKlz8rYPu1w==
X-Received: by 2002:a05:6808:16a7:b0:2f9:39c4:c597 with SMTP id bb39-20020a05680816a700b002f939c4c597mr608435oib.101.1648665131112;
        Wed, 30 Mar 2022 11:32:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d4b10000000b005b22b93d468sm10322717otf.74.2022.03.30.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:32:10 -0700 (PDT)
Received: (nullmailer pid 3399406 invoked by uid 1000);
        Wed, 30 Mar 2022 18:32:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <kettenis@openbsd.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20220330164458.93055-2-povik+lin@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org> <20220330164458.93055-2-povik+lin@cutebit.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
Date:   Wed, 30 Mar 2022 13:32:10 -0500
Message-Id: <1648665130.079263.3399405.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 30 Mar 2022 18:44:57 +0200, Martin Povišer wrote:
> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> samples on Apple SoCs from the "Apple Silicon" family.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  .../devicetree/bindings/dma/apple,admac.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/apple,admac.example.dt.yaml: example-0: iommu@235004000:reg:0: [2, 889208832, 0, 16384] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/apple,admac.example.dt.yaml: example-0: dma-controller@238200000:reg:0: [2, 941621248, 0, 212992] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/apple,admac.example.dt.yaml: iommu@235004000: compatible: ['apple,t8103-dart', 'apple,dart'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/apple,dart.yaml
Documentation/devicetree/bindings/dma/apple,admac.example.dt.yaml:0:0: /example-0/iommu@235004000: failed to match any schema with compatible: ['apple,t8103-dart', 'apple,dart']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/apple,admac.example.dt.yaml: dma-controller@238200000: 'dma-channels', 'iommus' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/apple,admac.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


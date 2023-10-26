Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBC57D834F
	for <lists+dmaengine@lfdr.de>; Thu, 26 Oct 2023 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjJZNJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Oct 2023 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbjJZNJu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Oct 2023 09:09:50 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79212A;
        Thu, 26 Oct 2023 06:09:47 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b4145e887bso457606b6e.3;
        Thu, 26 Oct 2023 06:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698325787; x=1698930587;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NO5m7fhdZ86xZ6oZ/eNUrPW8qSlU9o/6HhuyLwLwsFw=;
        b=Rnt+X6ZQ9t5E1J2gkzJ22mTpJ/jh41L9S/zygpf33P2j3IBc7hcsQnbbaEeJ8UUuhP
         hTOue1YY26+tGq26MQqDbM4QNrh2oy/cNyuxU4ArJJhqVzutb3ww2XtCq94B+o7nkiir
         L2lOjCC0z0ist9qfg7smd2rAiq7WTLTH9phEZAdz7pyPq5k33mliuqHImRX6YSZVLpQj
         E+aMQavMTfAjgfvyNucD7TJfWIzynXjPz1Tt0YVs8HbeXgKuoyiwU9lvpR9irq6lvxTk
         +9BG6OawpdFzt3R8peM3nyEHH7sbZc73gVudMrIGF/kvl9oW2X//5vwJnqHpKaK9hFO4
         HTXA==
X-Gm-Message-State: AOJu0Yy2sWUHulIQrfJz9MlcHFwGZFnaUZLUMrxQ9In1p79P2M4QHBDq
        Dz5MhSV4KrUsw/XrUfFQdw==
X-Google-Smtp-Source: AGHT+IFbYix8XnLYfgLgwHIbCKasrWZ3A/+3Wi6GBgZ2V81n3ck6jlEHxn3qMHqcfAbPpBPMDmMobA==
X-Received: by 2002:a05:6808:2029:b0:3b2:f192:5a6b with SMTP id q41-20020a056808202900b003b2f1925a6bmr21367755oiw.16.1698325787239;
        Thu, 26 Oct 2023 06:09:47 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r33-20020a056808212100b003a747ea96a8sm2756099oiw.43.2023.10.26.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:09:46 -0700 (PDT)
Received: (nullmailer pid 3504841 invoked by uid 1000);
        Thu, 26 Oct 2023 13:09:45 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org,
        chenweilong@huawei.com, robh+dt@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        xuqiang36@huawei.com
In-Reply-To: <20231026072549.103102-3-guomengqi3@huawei.com>
References: <20231026072549.103102-1-guomengqi3@huawei.com>
 <20231026072549.103102-3-guomengqi3@huawei.com>
Message-Id: <169832512997.3486292.15938415768767321000.robh@kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: dma: HiSilicon: Add bindings for
 HiSilicon Ascend sdma
Date:   Thu, 26 Oct 2023 08:09:45 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 26 Oct 2023 15:25:49 +0800, Guo Mengqi wrote:
> Add device-tree binding documentation for sdma hardware on
> HiSilicon Ascend SoC families.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  .../bindings/dma/hisilicon,ascend-sdma.yaml   | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml: dma-can-stall: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231026072549.103102-3-guomengqi3@huawei.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


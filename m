Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C17D1C6D
	for <lists+dmaengine@lfdr.de>; Sat, 21 Oct 2023 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJUKSQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Oct 2023 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJUKSP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Oct 2023 06:18:15 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12BD41;
        Sat, 21 Oct 2023 03:18:10 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-581fb6f53fcso1003893eaf.2;
        Sat, 21 Oct 2023 03:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883490; x=1698488290;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V5uRcWDpqOXlkA0SQTwaP57mswGoxWrMMHmifDFiYJQ=;
        b=NXvIUKnYvUJpYVqFpXluqEiy6ohTAUB0/Sp4WQewuDL1h2gMrhniiy8fLLyGP4IV+6
         cFttq3wbPChHFvPS58Xa/sGnVEExvbjdcmV7/Kvj2PsRYTc8DwuynQQORFcpZ1J/jorN
         j7x2uZuV9fv4QVksUWj8q8IegZcBI991+9O9afCrcGCaamjWrSEKpBjosKqywREl/gQx
         s4sDvBKfWaaEUE0EUPqBlZr6AwbJ5PSkOBO7Gbte+TbyjzQ2M4u55dN7MdGb/5djvb1d
         cSYIjfe6HV6gpsZzhebYrFKJvwii1dl42wV+ry0yWM86M3j31WY3hSkvc4mzRZS8vtcF
         9E+g==
X-Gm-Message-State: AOJu0YysxW6CWo8rDGAgRIS8VswlhurZTfLxj9jpsLrF/k9JCIFw5JZE
        sNH+/IszaqT5nQ1L1Qp+WEKbxnCcjg==
X-Google-Smtp-Source: AGHT+IGDtLLxR/perzKXsJ9v5yb1s8dzQBjD6ACEuMoaQHz4QngTZigFfIlcNZ036tNmd6iDOvED2A==
X-Received: by 2002:a05:6870:530e:b0:1e9:e0f3:d716 with SMTP id j14-20020a056870530e00b001e9e0f3d716mr5966616oan.37.1697883490180;
        Sat, 21 Oct 2023 03:18:10 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nd25-20020a056871441900b001dcfaba6d22sm781448oab.46.2023.10.21.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:18:09 -0700 (PDT)
Received: (nullmailer pid 1320489 invoked by uid 1000);
        Sat, 21 Oct 2023 10:18:08 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     vkoul@kernel.org, devicetree@vger.kernel.org, xuqiang36@huawei.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, chenweilong@huawei.com,
        conor+dt@kernel.org
In-Reply-To: <20231021093454.39822-3-guomengqi3@huawei.com>
References: <20231021093454.39822-1-guomengqi3@huawei.com>
 <20231021093454.39822-3-guomengqi3@huawei.com>
Message-Id: <169788348856.1320467.2316881090457833857.robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: dma: HiSilicon: Add bindings for
 HiSilicon Ascend sdma
Date:   Sat, 21 Oct 2023 05:18:08 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 21 Oct 2023 17:34:53 +0800, Guo Mengqi wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231021093454.39822-3-guomengqi3@huawei.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


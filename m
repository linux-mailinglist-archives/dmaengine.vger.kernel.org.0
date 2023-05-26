Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7F712919
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbjEZPHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbjEZPHc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 11:07:32 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F781A2;
        Fri, 26 May 2023 08:07:26 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3319a6f989aso6357755ab.2;
        Fri, 26 May 2023 08:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113645; x=1687705645;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3SwxZHQH75a2BAIZDAbWAuC2lYpmSVUQ9esXHuE/GI=;
        b=T9szlRgrrQzZEnmWRlrkNiJoYFJaT+gsJtquHnva2xNPD/S5SZ930L0XG3KbZxqip3
         hF3xb5PKoU4UX02Ube82zqyNlVYabBEj0abTexQpwNJY8YA+H5L4n7Md2Lk+Cdq/eLcS
         CSqsm/sQWRmQ9PFeh6G19rEtrK5ArEb+i5gzt9Oa1p/J+SwhPuSaeKhTrKVi8uOwz3y2
         YwFkcfWCFTvrAnAEakAWUMDprb82IlArEmDhugXlqITI0qJhAIHvENmLxlKzZuMx/UP0
         nd4FSNA6Ym35aDPBQ9que/jikXlUPn4FEn/Piu9fQ3aIbC14DTsSk4sYrkZTcHnNFL/7
         0eaQ==
X-Gm-Message-State: AC+VfDw7LEl8EU4TyFc8FS0EWTWCxhLS8PsCjbmBteEbCEirkvhdft7L
        L7+XOM2j8K6m+LYZPiuir2ibdnl6vA==
X-Google-Smtp-Source: ACHHUZ4sQCTa/dr9gjLgz+7HyZIHSPCkkfyyY6iaMt2G+s3hyhzHYOSrLEyG/CyX2oDIONOuCjyNrA==
X-Received: by 2002:a92:cc4f:0:b0:32c:88d9:af1d with SMTP id t15-20020a92cc4f000000b0032c88d9af1dmr1414048ilq.13.1685113645566;
        Fri, 26 May 2023 08:07:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z1-20020a92bf01000000b003248469e5easm14423ilh.43.2023.05.26.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:07:24 -0700 (PDT)
Received: (nullmailer pid 752525 invoked by uid 1000);
        Fri, 26 May 2023 15:07:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     shenwei.wang@nxp.com, robh+dt@kernel.org, joy.zou@nxp.com,
        peng.fan@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
In-Reply-To: <20230526143639.1037099-13-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
 <20230526143639.1037099-13-Frank.Li@nxp.com>
Message-Id: <168511364321.752508.2528911041260451856.robh@kernel.org>
Subject: Re: [PATCH v1 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Date:   Fri, 26 May 2023 09:07:23 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 26 May 2023 10:36:39 -0400, Frank Li wrote:
> Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
> i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/fsl,edma.yaml:113:13: [error] duplication of key "const" in mapping (key-duplicates)
./Documentation/devicetree/bindings/dma/fsl,edma.yaml:114:13: [error] duplication of key "const" in mapping (key-duplicates)
./Documentation/devicetree/bindings/dma/fsl,edma.yaml:115:13: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/dma/fsl,edma.example.dts'
Documentation/devicetree/bindings/dma/fsl,edma.yaml:113:13: found duplicate key "const" with value "fsl,imx8qm-adma" (original value: "fsl,imx8qm-edma")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/dma/fsl,edma.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/dma/fsl,edma.yaml:113:13: found duplicate key "const" with value "fsl,imx8qm-adma" (original value: "fsl,imx8qm-edma")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,edma.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230526143639.1037099-13-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


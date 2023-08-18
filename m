Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC02780B4E
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376432AbjHRLk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376486AbjHRLku (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 07:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318AD10DF;
        Fri, 18 Aug 2023 04:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD5D630D1;
        Fri, 18 Aug 2023 11:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C81C433C7;
        Fri, 18 Aug 2023 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358848;
        bh=oATdbFqb5iDKqQj9oTeb+6LZE5xR2YlK3loyGn8h3ss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H33YdPhED91MI/TOD50hKOiZ//1dLD+PJsbF/CUnT6GEFCpjalWspv+U66mHAtWgT
         usySZobm093pGkYsNnXEHqUacNad5QlJKrzf2KWDEb77ujPBwocdWOviQKXm42hqNy
         X8O84vablC3zdJGPx8JkNDLO2JO8PfSUhD6g2gk+/b7l3FrcrygZgSYq9CJP+ugDZ2
         RHRIMgJlKMlTrFvaU0mLyQxULU7PiYjOORdjWgXfXjzYCMIgq+OWeFWXA/uoKfYepJ
         U8DWLwsfVVRErzprSUp2+V0TRqA0s1dzKY8XLiUPxpB5fFq6yJv0tv1A2dF1OSPqGp
         ahW7w5wCSDhyQ==
Received: (nullmailer pid 3808736 invoked by uid 1000);
        Fri, 18 Aug 2023 11:40:46 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        xuqiang36@huawei.com, chenweilong@huawei.com, conor+dt@kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20230818100128.112491-3-guomengqi3@huawei.com>
References: <20230818100128.112491-1-guomengqi3@huawei.com>
 <20230818100128.112491-3-guomengqi3@huawei.com>
Message-Id: <169235884616.3808705.14218783452622789257.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: hisi: Add bindings for Hisi
 Ascend sdma
Date:   Fri, 18 Aug 2023 06:40:46 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 18 Aug 2023 18:01:28 +0800, Guo Mengqi wrote:
> Add device-tree binding documentation for the Hisi Ascend sdma
> controller.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/hisi,ascend-sdma.example.dtb: /example-0/dma-controller@880e0000: failed to match any schema with compatible: ['hisilicon,ascend310-sdma']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230818100128.112491-3-guomengqi3@huawei.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C87878E0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjHXTn3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbjHXTn3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C81BE6;
        Thu, 24 Aug 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E6366D2B;
        Thu, 24 Aug 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB530C433C9;
        Thu, 24 Aug 2023 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692906206;
        bh=0V2DSkVF87pI/l8v/Q3/4st7Qd2divrO5JtOEUuR1Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kln5o0EWNpFYkWPILpgi8TiN+RwGpO9oc4tKWGXWziTKlUBBVBRqeCDZ5Lp/a4AQf
         e0jDF8sqCe7ykXO+S1IZDZgSNIMtK6wr0/45qV8JwVlP8F0utJYHJj9V2SCW7QU8Yq
         mT6zPx16BFvf+OqXW0G/fI/WRsOURjMM7tlzsKkjgODrFL5I1oEbMJXD0idAJ5TtuQ
         wDceFtvy9mrWcNlCfawX89WfqzV5wXgmo9YHlmzORx9Bir2FdYDMcOWmXl7tNqzXhR
         UEuY/cS2ZAU1iUZvw+9OvfYjMQE3TZVBJN/arCnbNxhvCBUOOoNmySursb3jXA0qLL
         6Ot+PCY8KPJgw==
Received: (nullmailer pid 1347243 invoked by uid 1000);
        Thu, 24 Aug 2023 19:43:24 -0000
Date:   Thu, 24 Aug 2023 14:43:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Mengqi <guomengqi3@huawei.com>
Cc:     vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, xuqiang36@huawei.com,
        chenweilong@huawei.com
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: hisi: Add bindings for Hisi
 Ascend sdma
Message-ID: <20230824194324.GA1342234-robh@kernel.org>
References: <20230824040007.1476-1-guomengqi3@huawei.com>
 <20230824040007.1476-3-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824040007.1476-3-guomengqi3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 24, 2023 at 12:00:07PM +0800, Guo Mengqi wrote:
> Add device-tree binding documentation for the Hisi Ascend sdma
> controller.
> 
> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
> ---
>  .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> new file mode 100644
> index 000000000000..87b6132c1b4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/hisi,ascend-sdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HISI Ascend System DMA (SDMA) controller
> +
> +description: |
> +  The Ascend SDMA controller is used for transferring data
> +  in system memory. It utilizes IOMMU SVA feature and accepts
> +  virtual address from user process.
> +
> +maintainers:
> +  - Guo Mengqi <guomengqi3@huawei.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,ascend310-sdma
> +      - hisilicon,ascend910-sdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      Clients specify a single cell with channel number.
> +
> +  hisilicon,ascend-sdma-channel-map:
> +    description: |
> +      bitmap, each bit stands for a channel that is allowed to
> +      use by this system. Maximum 64 bits.
> +    $ref: /schemas/types.yaml#/definitions/uint64

Sounds like the common property dma-channel-mask. Use that.

> +
> +  iommus:
> +    maxItems: 1
> +
> +  pasid-num-bits:

Needs a vendor prefix.

> +    description: |
> +      sdma utilizes iommu sva feature to transfer user space data.

Isn't shared VA mostly a s/w concept?

> +      It acts as a basic dma controller if not bound to user space.

I don't understand what this means.

> +    const: 0x10

If only 1 value is allowed, what is the point of this property.

Rob

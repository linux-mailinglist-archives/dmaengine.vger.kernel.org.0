Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49E2A6D63
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgKDTCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 14:02:34 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41325 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgKDTBC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Nov 2020 14:01:02 -0500
Received: by mail-oo1-f66.google.com with SMTP id n2so5336764ooo.8;
        Wed, 04 Nov 2020 11:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28TSBEACDPg4TOixmPv6qTaMuTlZjdSzlb52Hl2/KaM=;
        b=P6G3lXBXhx8x3TCJh5uvkqZefXs9JBabj6BcAArpScYQ+JwqRDDnJlw9NGAWBm3flY
         6bTttaHmOaekTK7CXdD06V9/v3/bjMdJxg7RMiBhs/vqNc9QJmRPKAGYFY+asIyXSfog
         PtT+W+rWwuSLfQnsO5xKcZcS0stflqu6TEWVYZWAhje+a3rinslj0efDWJ9BlTr81obQ
         U20gIjfwiAfKxeFvXM0I2dxCfdcOwLHSpPUyaNw2xoPhxou22Ynm+R4a/1UyhdewlvnN
         wxjTG9/NyFUnPymtMk1yq9f4DpOa0Bi/p0w8UQlxJmd7LVfLw2EYe31yodfANjXRO3UZ
         cIAA==
X-Gm-Message-State: AOAM530nUdyZD8ssMi/R2jGZgPJyCUJIKgbd0C0gxV2bUE2Wz8SNmjqA
        CC5rshp/KePfxIisbaCmd/KQrqgwuQ==
X-Google-Smtp-Source: ABdhPJzsluuC2hERxHZwZe3UQMIR6GG4OMT2RUm6D2mmZ79HE7zUD6ZJS1WAdGIgSYPCRrhTzr6AIg==
X-Received: by 2002:a4a:d554:: with SMTP id q20mr19826886oos.23.1604516461232;
        Wed, 04 Nov 2020 11:01:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b92sm654957otc.70.2020.11.04.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:01:00 -0800 (PST)
Received: (nullmailer pid 3952952 invoked by uid 1000);
        Wed, 04 Nov 2020 19:00:59 -0000
Date:   Wed, 4 Nov 2020 13:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Document qcom,gpi dma
 binding
Message-ID: <20201104190059.GA3950437@bogus>
References: <20201103112544.674566-1-vkoul@kernel.org>
 <20201103112544.674566-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103112544.674566-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 03 Nov 2020 16:55:42 +0530, Vinod Koul wrote:
> Add devicetree binding documentation for GPI DMA controller
> implemented on Qualcomm SoCs
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/dma/qcom,gpi.yaml     | 90 +++++++++++++++++++
>  include/dt-bindings/dma/qcom-gpi.h            | 11 +++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
>  create mode 100644 include/dt-bindings/dma/qcom-gpi.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom,gpi.yaml: properties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'additionalProperties'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom,gpi.yaml: ignoring, error in schema: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/dma/qcom,gpi.yaml


See https://patchwork.ozlabs.org/patch/1392940

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


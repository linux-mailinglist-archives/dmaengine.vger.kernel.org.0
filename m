Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F298439E4E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJYSTZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 14:19:25 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47098 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhJYSTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 14:19:23 -0400
Received: by mail-ot1-f51.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so16122320ote.13;
        Mon, 25 Oct 2021 11:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bLfZN28QMCI4m4KB4fkACx23o4Rjd6HbYTlUX1t6irc=;
        b=QKo8Kx0H5wE+jpCZhs3VbJWbQwMJ8GyFDv9gqlNra59O0/M+harCqjmH6KWbo5ERcr
         d7QocxWEP79bw7A06SFLhZ4xUJjw8u9ia50tR27kHfrJmTWuVs16QSHBTFDZzYqpqgdi
         zPiNSo/12E23YpS3orRrYPRZfcZGLKrPC8IkmCFG6wfC15ig+KJGBgS3+YiILZM31CSH
         RRPWNWPqRFpJoYnS9urMIdmpryl1vgx4UgNXh76GbQJFNVtACaElWZG5AQr7yI7DYZzT
         fRXGd7s6ILHndwT9nzIHpDHojHmr0csXUS541TNz0++A88gH9B0mqMQdrT/3V2iE8zuF
         b/tA==
X-Gm-Message-State: AOAM533K0dDOSDxP4CtWhjiH2kuruDPFu8U6HNDg9eWZIMAKubnqWJzB
        EddoBSkjXEuUZsfaVM2HzQ==
X-Google-Smtp-Source: ABdhPJz8+BG6kwGVgKT4pjax5eofi2fAJBOSEhlpU4V7piV9LLWwdwpEoAuNV9IKiFB8x1N0+b9i6g==
X-Received: by 2002:a9d:72de:: with SMTP id d30mr15244534otk.18.1635185820747;
        Mon, 25 Oct 2021 11:17:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v22sm3096784oot.43.2021.10.25.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:17:00 -0700 (PDT)
Received: (nullmailer pid 824874 invoked by uid 1000);
        Mon, 25 Oct 2021 18:16:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     rgumasta@nvidia.com, dan.j.williams@intel.com,
        linux-tegra@vger.kernel.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        kyarlagadda@nvidia.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <1635180046-15276-2-git-send-email-akhilrajeev@nvidia.com>
References: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com> <1635180046-15276-2-git-send-email-akhilrajeev@nvidia.com>
Subject: Re: [PATCH v10 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 25 Oct 2021 13:16:53 -0500
Message-Id: <1635185813.793339.824873.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 25 Oct 2021 22:10:43 +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.example.dt.yaml: dma-controller@2600000: 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1545840

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2584746075E
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 17:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhK1QLk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Nov 2021 11:11:40 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40798 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbhK1QJk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Nov 2021 11:09:40 -0500
Received: by mail-oi1-f173.google.com with SMTP id bk14so29645066oib.7;
        Sun, 28 Nov 2021 08:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XcdVLR5T8aEqWDjXmGT4FtJ9lSL6Rm6Y96yhhLDME0=;
        b=4taXed+QR7SrHztucROx6uelGYy2q0iUcqYS3LBQkVwPhpmVaYT9tAZEWL3R9cQeHt
         aQdSP0/huV8hw0ihrik92vGsIMf2I14vEHl0KKW2QDwzZpHH2zFb4sD3bulkuspQ8e/K
         k6pjsZp2eUsD8uZmI0GnG8Y5wpkZwd2THd9fMC5GturI+smrVD+NQrGut5cc5b+Bpi5V
         k2V2qAqaOWhN9V3tKV3t0Q3hU8OWeOZDF7RXHNG/SL0bX2UUCHTzwdVvaBNaW4q7j70y
         H//9rO4fb5qAOwuY0fpj6bLW+L3qJXMOydUUxjARYYzwctQzl+gILw754rVguoIMj/IS
         wslQ==
X-Gm-Message-State: AOAM530vxLSlS8AnM8U/HdrlODPsg0KLAMfGDTy1KAV/qDHzyFx8fiR9
        KGCh4+KjnHgfy/NYkYQqTA==
X-Google-Smtp-Source: ABdhPJwKIwsK+qKc3/WIO+9F/yWvFZR4TMP+v+GAwfhU3SlRfqN972FhHTZlzd0Etz2MduGDNYwiZg==
X-Received: by 2002:aca:1708:: with SMTP id j8mr34441661oii.62.1638115583942;
        Sun, 28 Nov 2021 08:06:23 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:afc8:f6e9:d57a:3e26:ee41])
        by smtp.gmail.com with ESMTPSA id y12sm2487710oiv.49.2021.11.28.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:06:23 -0800 (PST)
Received: (nullmailer pid 2561004 invoked by uid 1000);
        Sun, 28 Nov 2021 16:06:20 -0000
Date:   Sun, 28 Nov 2021 10:06:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dan.j.williams@intel.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com,
        thierry.reding@gmail.com, vkoul@kernel.org
Subject: Re: [PATCH v13 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YaOo/FHKQBAa93hd@robh.at.kernel.org>
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
 <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 22, 2021 at 02:58:09PM +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
> 
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 111 +++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> new file mode 100644
> index 0000000..3a5a70d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
> +
> +description: |
> +  The Tegra General Purpose Central (GPC) DMA controller is used for faster
> +  data transfers between memory to memory, memory to device and device to
> +  memory.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Rajesh Gumasta <rgumasta@nvidia.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra186-gpcdma
> +      - items:
> +         - const: nvidia,tegra186-gpcdma
> +         - const: nvidia,tegra194-gpcdma

Still not how 'compatible' works nor what I wrote out for you.

Rob

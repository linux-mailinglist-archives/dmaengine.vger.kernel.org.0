Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F040578A7C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jul 2022 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiGRTQb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jul 2022 15:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGRTQb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Jul 2022 15:16:31 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98792ED5D;
        Mon, 18 Jul 2022 12:16:29 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id r4so2362765ilb.10;
        Mon, 18 Jul 2022 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RF8yPg0V6Ei1ECcsENYa6ZgHRNw38bA40D3WRP4FyM=;
        b=HtIUSlWeR67/+pac3QdOLs/nTkmfUEP3IOQGcSHNfw8CupHXTLHuMaPwMBcdCxOIt/
         BhPgPwaC3u9lnnCi11gSBCzJVQj7yN5XOZDSekAdTLbbEv/wKCz3v5EekWn271vmFyX2
         K+qsBpI1Al0EsGIxmNpu7joFOZ8hJIlSU/BUQitlZLuUXbWltgssjgOqed91QRTdfCUY
         tUdMsIR6yWfknVDQpvBpE2IK1S8pitqKZjpX1KdEwTZlOGDCGnVcJ3xWlN3BpHPAM6ht
         S8W+IvKX9hX33KOTj/EpK+Tnbli8NvbRr707kY6xmnEibAZQovY+PhBgf/cYJQD981hb
         8u/Q==
X-Gm-Message-State: AJIora/7P6kX1T4V4WCDr8g5mO2a4sCQ2f8w3oaC5Impc/Mx1DsqNDwQ
        Lx3lJ/oTAvf3+xm+3dANP2dUqYEfZQ==
X-Google-Smtp-Source: AGRyM1skZXRGXATxAj9yKT/sA/YyYFM/FtsMqbrtgIQYQ35QL7+WaUwDmKepF9LYedHCorY7wdg3Cg==
X-Received: by 2002:a05:6e02:188c:b0:2dc:a00:3222 with SMTP id o12-20020a056e02188c00b002dc0a003222mr13783935ilu.43.1658171789064;
        Mon, 18 Jul 2022 12:16:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w64-20020a025d43000000b0033ef9dc43d4sm5785863jaa.159.2022.07.18.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:16:28 -0700 (PDT)
Received: (nullmailer pid 3377517 invoked by uid 1000);
        Mon, 18 Jul 2022 19:16:27 -0000
Date:   Mon, 18 Jul 2022 13:16:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Message-ID: <20220718191627.GA3375779-robh@kernel.org>
References: <20220711154536.41736-1-akhilrajeev@nvidia.com>
 <20220711154536.41736-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711154536.41736-2-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 11, 2022 at 09:15:34PM +0530, Akhil R wrote:
> Document the compatible string used by GPCDMA controller for Tegra234.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 9dd1476d1849..399edcd5cecf 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -26,6 +26,10 @@ properties:
>            - const: nvidia,tegra194-gpcdma
>            - const: nvidia,tegra186-gpcdma
>  
> +      - items:
> +          - const: nvidia,tegra234-gpcdma

This can be added to the above entry changing it from a const to enum.

> +          - const: nvidia,tegra186-gpcdma
> +
>    "#dma-cells":
>      const: 1
>  
> -- 
> 2.17.1
> 
> 

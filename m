Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C493644426
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiLFNIu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Dec 2022 08:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLFNIZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Dec 2022 08:08:25 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB92B606;
        Tue,  6 Dec 2022 05:06:35 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id v82so16820176oib.4;
        Tue, 06 Dec 2022 05:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VLnmw9cgzz1trBmeVfOPIC0eg3Xb4TPnCQ0Or5PgMY=;
        b=AmbsZ3Sug9Ohwfw9f0CV5ukTD2EuGwp6r+WPt4u+c+pmtQvbB1Eb8OsYfTyKIuxU5B
         EGCOjyS3N4IRnJdAm/tM2ftNmg5xDRgEU+1D3ujkjbO/KR6ymnZdOn/y8u6AbaLV+27i
         anZeba1y+5CGTp/8y0AJEChysQUwwzrhatUQh+MFUGjVEWjXbPfsxAirDA/PbJOLV6ZU
         yoDnWTuzFBCj6Nx5ghozSojOK6bbp4afq03AcfZBByau4mcaj/UD/IvYllYmFoHxgR6S
         g3f2tihtf3O05WpvW14egXOsPS7D9XZ3UEOtq/Khy3uiMN7NTQoYJR3KJz4bVFCRUMXC
         kE1w==
X-Gm-Message-State: ANoB5plnFcoejb1zLvcFC0/uIlkjhqNqCPSny/ii7+fqkRZvkU3sffUr
        mqjKKOZE/M+XSAz8TEv9mQ==
X-Google-Smtp-Source: AA0mqf6rA5VNHLxzZM/XwyRklpPC+5cPWHfnnE5YfB9BJ350CCsG5DmrMQoA1lDqr6+SKNMVJEuKmg==
X-Received: by 2002:a05:6808:a10:b0:35a:433f:b03a with SMTP id n16-20020a0568080a1000b0035a433fb03amr33763043oij.1.1670331994188;
        Tue, 06 Dec 2022 05:06:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a4ab208000000b004805b00b2cdsm7837159ooo.28.2022.12.06.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:06:33 -0800 (PST)
Received: (nullmailer pid 231668 invoked by uid 1000);
        Tue, 06 Dec 2022 13:06:32 -0000
Date:   Tue, 6 Dec 2022 07:06:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: Drop Jee Heng Sia
Message-ID: <167033198953.231535.1943885623418266769.robh@kernel.org>
References: <20221205164254.36418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205164254.36418-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 05 Dec 2022 17:42:54 +0100, Krzysztof Kozlowski wrote:
> Emails to Jee Heng Sia bounce ("550 #5.1.0 Address rejected.").  Add
> Keembay platform maintainers as Keembay I2S maintainers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct email format in keembay-i2s.
> 2. Add Ack tag.
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml    | 1 -
>  Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

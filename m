Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040E7CCAB7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Oct 2023 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjJQSfP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Oct 2023 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJQSfO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Oct 2023 14:35:14 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6EE9E;
        Tue, 17 Oct 2023 11:35:13 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3af6cd01323so3729508b6e.3;
        Tue, 17 Oct 2023 11:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567713; x=1698172513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvrIiJWq+n8YDLTkOFBATbZgJOnUihq2U+eENPEqdgI=;
        b=r07r7jF4FZo4PQAUWLZHeouVmB89GI3FxMVqspmPByc3Zd6ds4Nr/iITI2g+cYl4Sn
         h8Odrr9dm2YykJfgMm/9zf7+fSdBk6uMFn87HbpsGOcrdefO0QzIPeY0yC/jW5FgHz9N
         7H5M6oFiYtjE2SLFgtTmF3cFjHzo8Poyu2EB0tXKxBDlgQkdCGM0TE+k5gkm/E4WZ/Qp
         uN0uN7ev6CdH4h6vCMsEwdfkNXbinWgORTHbfBsNGwAor8gyLMRDHqTnPITcPEF03lti
         f4LCQX8QfC45I3Is8QUI4lmQTBOdpdiDN9Ta8GpJxX9122mwYfC5JVcUr2RHvxa9GDAV
         RU/w==
X-Gm-Message-State: AOJu0Yz75WIFSf4f1daR43y+psrBYRll0Oc9jSglR5eKaIj/rhurRmva
        a/y1PCsoELYmZLyCMN0pqA==
X-Google-Smtp-Source: AGHT+IFwrG2G9V+WzMR8t6/VcVQnYVQqqTMf+zxSRlMmdCuFJWQL/bWxYXJZN3yLyevIWE8VSZNj1w==
X-Received: by 2002:a05:6808:94:b0:3b0:da4a:4823 with SMTP id s20-20020a056808009400b003b0da4a4823mr3195106oic.56.1697567712826;
        Tue, 17 Oct 2023 11:35:12 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp18-20020a056808239200b003af644e6e81sm346268oib.45.2023.10.17.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:35:12 -0700 (PDT)
Received: (nullmailer pid 2484073 invoked by uid 1000);
        Tue, 17 Oct 2023 18:35:11 -0000
Date:   Tue, 17 Oct 2023 13:35:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        vkoul@kernel.org, ldewangan@nvidia.com, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com
Subject: Re: [PATCH V2 1/2] dt-bindings: dma: Add dma-channel-mask to
 nvidia,tegra210-adma
Message-ID: <169756769843.2483754.101770522333028835.robh@kernel.org>
References: <20231017091816.2490-1-mkumard@nvidia.com>
 <20231017091816.2490-2-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017091816.2490-2-mkumard@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 17 Oct 2023 14:48:15 +0530, Mohan Kumar wrote:
> Add dma-channel-mask binding doc support to nvidia,tegra210-adma
> to reserve the adma channel usage
> 
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>




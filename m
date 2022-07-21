Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381357D463
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiGUTwX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGUTwT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 15:52:19 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB02183F;
        Thu, 21 Jul 2022 12:52:18 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id e69so2184014iof.5;
        Thu, 21 Jul 2022 12:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qU3lShC423RO9jUaFHy+GEk0cB+opAvk6TkHNpI+xU=;
        b=KZKB2m3WSJUG9LKZ3sR/Ie2L87r6w4ZcHTj8yX5RmEiL/4vaK/GAgwut5NWyA7+u3h
         r1RTluXKFrge5WeeCZ1TWN4RTzcgZXCDum4A3Td8g6W4YQL/DvxFFGxX0NTJgAAopJ09
         2yqBmXipH4d+ZExhZOiN9DI4dL46XG1w5yS+2WZsfQuAQYfRr3tlf1tS8KkggaLZ/xu8
         hkIpLUEjutp5j8tIrbm9JY/MHAZmQTCM5YbdSZHlI0hxU6CK97NluYiWW0dBkY7KV1Dy
         /7I3vYJMbyNpvwQf6L9WaloxgBAUDHg684rafOoMCVkiB5Itp+/sBbo+dRt6+Jd2GQRZ
         Wmbg==
X-Gm-Message-State: AJIora96+mn46UR7GdPCgzXzO0sE5rkYQAYd774kcUe+01Mlp4uqpwP0
        aPzpWfQJ1/qBlGDqhCB/+g==
X-Google-Smtp-Source: AGRyM1vtb/Pgq6vsjHn+wt+hYE2q0Nb6Yn4IDlr2B93dVsctunQcYCRjbeahSAuZpzfSUQBA5UXtzQ==
X-Received: by 2002:a05:6638:3881:b0:33c:c785:37d1 with SMTP id b1-20020a056638388100b0033cc78537d1mr98828jav.40.1658433137724;
        Thu, 21 Jul 2022 12:52:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y6-20020a92d206000000b002dc10fd4b88sm1026857ily.29.2022.07.21.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:52:17 -0700 (PDT)
Received: (nullmailer pid 1821727 invoked by uid 1000);
        Thu, 21 Jul 2022 19:52:15 -0000
Date:   Thu, 21 Jul 2022 13:52:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220721195215.GA1817266-robh@kernel.org>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
 <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 18 Apr 2022 02:34:36 +0530, Kuldeep Singh wrote:
> Convert Qualcomm BAM DMA controller binding to DT schema format using
> json schema.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v3:
> - Address Krzysztof Comments
> - qcom,ee as required property
> - Use boolean type instead of flag
> - Add min/max to qcom,ee
> - skip clocks, as it's users are not fixed
> ---
> v2:
> - Use dma-cells
> - Set additionalProperties to false
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 97 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
>  2 files changed, 97 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> 

This is the 11th most warned on (168 warnings) for missing a schema, so 
I've implemented my only comment and applied. It seems neither this one 
or the other attempt at converting are getting respun.

Rob

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78366C0C9A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfI0UZl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 16:25:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43265 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfI0UZl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Sep 2019 16:25:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id o44so3355732ota.10;
        Fri, 27 Sep 2019 13:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBr+kyAQD3h7/fDbIxlNBsTTTrh86TRcvJ4J3ndHmVw=;
        b=ebT2Vw/hbb+UISgzFnqIbSnJad6R0yBe6mMfCEwi5UnOEQil9QaqTTqSWeaKedx1Ss
         yCLdAHSMeYpHRt/Nm+SR0AA3EyVvBJR/WZSsitPSoOi3WVb1GuwCrScLK5nfIy1ZX2UG
         nEYs9KWu1SYbf/39j2x+ft5/NX+DYf0HxZrbfyYn0Uyp/gdvxVWkcs4RyK625D/4OqRf
         U20SVo90fh926YMUXnUnsl7gFYOiJxlpy9VHm4lD7fKFDMrUzM+iCr4v4HM3KK5IhGXM
         2m4q9DZlyNZpPTowLpzutrmUaF2C6mTcu3NHbTjUT9hDSp//KN59ZSOezsSrmfKoIaYU
         rSXQ==
X-Gm-Message-State: APjAAAV9PLOmdQ/mN3e0lHGplEPnucKtT9280jv34uiIZsfcT1s1Ql8Y
        rvpxow2x+P66qHkuSllhatG9jRA=
X-Google-Smtp-Source: APXvYqznd9NzbTUbTaK9aZBHJBB3SLh8bEoM8JN+tq6aSN8pFSjK7Qd+cpbLPIWfWclC1JcDFrlD0Q==
X-Received: by 2002:a9d:2de4:: with SMTP id g91mr4467829otb.57.1569615940792;
        Fri, 27 Sep 2019 13:25:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d95sm1379473otb.25.2019.09.27.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 13:25:40 -0700 (PDT)
Date:   Fri, 27 Sep 2019 15:25:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
Message-ID: <20190927202539.GA20669@bogus>
References: <20190926111954.9184-1-peter.ujfalusi@ti.com>
 <20190926111954.9184-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926111954.9184-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 26, 2019 at 02:19:52PM +0300, Peter Ujfalusi wrote:
> Make the dma-channel-mask to be usable for controllers with more than 32
> channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma-common.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
> index ed0a49a6f020..4527f20301ff 100644
> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> @@ -25,11 +25,18 @@ properties:
>        Used to provide DMA controller specific information.
>  
>    dma-channel-mask:
> -    $ref: /schemas/types.yaml#definitions/uint32
>      description:
>        Bitmask of available DMA channels in ascending order that are
>        not reserved by firmware and are available to the
>        kernel. i.e. first channel corresponds to LSB.
> +      The first item in the array is for channels 0-31, the second is for
> +      channels 32-63, etc.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          minItems: 1
> +          # Should be enough
> +          maxItems: 255

'items' has to be a separate sub-schema from $ref to have any effect:

    allOf:
      - $ref: /schemas/types.yaml#/definitions/uint32-array                                                        
    items:
      minItems: 1
      # Should be enough
      maxItems: 255

Or (note the added '-'):

    allOf:                                                                                                            
      - $ref: /schemas/types.yaml#/definitions/uint32-array                                                           
      - items:                                                                                                            
          minItems: 1                                                                                                     
          # Should be enough                                                                                              
          maxItems: 255                                                                                                   

The first way is my preference.

Rob

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82F838991B
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 00:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhESWMf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 18:12:35 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40854 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWMf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 18:12:35 -0400
Received: by mail-ot1-f53.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so2593087oty.7;
        Wed, 19 May 2021 15:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHQQpS2EvBsKOZih9h34Kkl6JWS3zX+JZhU1E+mE6WA=;
        b=aLlZTC6NXLGTlTClq9h3qDfpwwM9McTLR8IdvklE43p5G4cenyvCF0/0QpkJyeND9h
         5bvmMCnwtWXSnjgqLCA9BfNDIQ5ifvNAfDNyxmLPdungMNK1xBiSm+TCuPUcEDM37GsQ
         Yrkr4OdSHr8qwXoP8DCoK7GPF4DR+BD9Zt9s7vqGTowUeSfIl0Mo4BUTpQvLFCZ0Qdpt
         jmqxMZb+0+XZk4G8w1ECFQRNyxZ0pYXX5ssvgBdrxA0wbjWY/3x2L3Mo6e9rwnBpXYK6
         ndAi+3uM6/oLbglohWe+zwpN6ogq4Tqez+9H57vNvSaclpecwSA1LVXkMN576mT115Y4
         1N5w==
X-Gm-Message-State: AOAM533pm4KFvOzp/pg+E2Gz5WxZHCzI8xpq8/rilluA7gnaO1a1+jqa
        1kZ3fIE9I4l2L22gICBrNkSk3MfqVA==
X-Google-Smtp-Source: ABdhPJz7e+i1WTOlR4EGjINAE5Fn0AvSykqtdCL1EYOngHXvnGv4VUW/+ZC3Z+ER7MlQrH05OjCFXQ==
X-Received: by 2002:a9d:ef6:: with SMTP id 109mr1420027otj.74.1621462273409;
        Wed, 19 May 2021 15:11:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y34sm232289ota.16.2021.05.19.15.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:11:11 -0700 (PDT)
Received: (nullmailer pid 3751945 invoked by uid 1000);
        Wed, 19 May 2021 22:11:10 -0000
Date:   Wed, 19 May 2021 17:11:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: add schema for altera-msgdma
Message-ID: <20210519221110.GA3751894@robh.at.kernel.org>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 18 May 2021 15:23:34 +0200, Olivier Dautricourt wrote:
> add yaml schema for Altera mSGDMA bindings in devicetree.
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
> 
> Notes:
>     Changes in v2:
>      - fix reg size in dt example
>      - fix dt_binding check warning
>      - add list in MAINTAINERS entry
> 
>     Changes from v2 to v3:
>      none
> 
>     Changes from v3 to v4:
>      none
> 
>     Changes from v4 to v5:
>         as per Rob's comments:
>             - change compatible field from 'altr,msgdma' to
>               'altr,socfpga-msgdma' to indicate that it's compatible
>                with altera socfpga family.
>             - describe each region separately
>             - remove maxItems/minItems for reg section.
>         as per Vinod's comments:
>             - separate MAINTAINERS editing in another commit
>             - remove description for #dma-cells
> 
>  .../devicetree/bindings/dma/altr,msgdma.yaml  | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

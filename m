Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683E4183B61
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2020 22:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCLVdc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Mar 2020 17:33:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37946 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCLVdc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Mar 2020 17:33:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so5297973ott.5;
        Thu, 12 Mar 2020 14:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNfJtMUZ9AtdFlrm/x22oDH4yXo8oQDRHF0dEFmtX8A=;
        b=L+E5IF0NuarUxOuSowCnRK7BnwtzBe78MVnvHj2hAqijZ0RFRHb7MhNW1DaEBHpX4g
         UwxR5vrwHgPiRPMY3mVN77z+UY6rD+LvcCvUIEFvn9Tlgzz/9Ku61hcM4d15yks73Ico
         UJHkQkOmBFLUc30tYsZOHJ3NKyxYs3qqjB/3xJIYZ7q6KGr+lGAzPO+Gg136FY2V3jgp
         kBH/5l9F1eCuEra4YCk6Up9v28l+li8Qz9iDCXQ6PnO3HxWUgIL4ScE5BTAYjNNDzUhG
         ggJVb+KDuN8HZ6m13HLBTxxT9PjRZT9sWYZcQC8h8j+gHFdOIJ0p+oYCD8i8ThiDlLVx
         1oHA==
X-Gm-Message-State: ANhLgQ0pIWe1c0t9jUnIsTMo7RgkIOadkVYWATLjtkVD9OGzYUV+9ssX
        IGsM0MZNGig9QI5EnAtgEypuC/E=
X-Google-Smtp-Source: ADFU+vsW7Zr/jjjZYXDJ9E7f4Lz3HnH6GhbmY8U8zErlnGILP92rFq5L2irBkuf1ecow5ypK68rg7w==
X-Received: by 2002:a05:6830:12d0:: with SMTP id a16mr7357673otq.218.1584048811700;
        Thu, 12 Mar 2020 14:33:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm7014819oij.19.2020.03.12.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:33:31 -0700 (PDT)
Received: (nullmailer pid 16495 invoked by uid 1000);
        Thu, 12 Mar 2020 21:33:30 -0000
Date:   Thu, 12 Mar 2020 16:33:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: dma: dw: Add max burst transaction
 length property bindings
Message-ID: <20200312213330.GA30463@bogus>
References: <20200306131035.10937-1-Sergey.Semin@baikalelectronics.ru>
 <20200306131049.37EDD8030708@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306131049.37EDD8030708@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 06, 2020 at 04:10:31PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> This array property is used to indicate the maximum burst transaction
> length supported by each DMA channel.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../devicetree/bindings/dma/snps,dma-spear1340.yaml  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> index d7f9383ceb8f..308ec6482064 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> @@ -126,6 +126,18 @@ properties:
>            enum: [0, 1]
>            default: 0
>  
> +  snps,max-burst-len:
> +    description: |
> +      Maximum length of burst transactions supported by hardware.
> +      It's an array property with one cell per channel in units of
> +      CTLx register SRC_TR_WIDTH/DST_TR_WIDTH field.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - maxItems: 8
> +        items:
> +          enum: [4, 8, 16, 32, 64, 128, 256]
> +          default: 0

The default needs to be an allowed value in the enum.

Rob

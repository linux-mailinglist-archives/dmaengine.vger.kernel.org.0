Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF458A7AF9
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfIDFvq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 01:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFvq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 01:51:46 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0DD23400;
        Wed,  4 Sep 2019 05:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567576305;
        bh=l7eIx4DSpd0U+fEd+RL7AhDqTLb6d7EsJav6w5VgEaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl7uTKaE4zW6dgY+wo0kzdahgAe/kvfTIdua16LeD8WFuL+EebLLxrP0WFepsQ6lw
         nc0pvE0VrG3grn6KMEPvk38PuBhANiMBBNQaaOMNDz5vchBtGl8ambJK86yJgtb3aJ
         1m7rtUcO+51HsFQa/acNSwkivQismAJQMNRWUF10=
Date:   Wed, 4 Sep 2019 11:20:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: milbeaut-m10v-hdmac: Add Socionext
 Milbeaut HDMAC bindings
Message-ID: <20190904055037.GC2672@vkoul-mobl>
References: <20190818051647.17475-1-jassisinghbrar@gmail.com>
 <20190818051754.17548-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818051754.17548-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-08-19, 00:17, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Document the devicetree bindings for Socionext Milbeaut HDMAC
> controller. Controller has upto 8 floating channels, that need
> a predefined slave-id to work from a set of slaves.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/dma/milbeaut-m10v-hdmac.txt      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> new file mode 100644
> index 000000000000..f0960724f1c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
> @@ -0,0 +1,32 @@
> +* Milbeaut AHB DMA Controller
> +
> +Milbeaut AHB DMA controller has transfer capability bellow.

s/bellow/below:

> + - device to memory transfer
> + - memory to device transfer
> +
> +Required property:
> +- compatible:       Should be  "socionext,milbeaut-m10v-hdmac"
> +- reg:              Should contain DMA registers location and length.
> +- interrupts:       Should contain all of the per-channel DMA interrupts.
> +                     Number of channels is configurable - 2, 4 or 8, so
> +                     the number of interrupts specfied should be {2,4,8}.

s/specfied/specified

-- 
~Vinod

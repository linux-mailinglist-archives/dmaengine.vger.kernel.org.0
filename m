Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6709A7B14
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfIDGB0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 02:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfIDGB0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 02:01:26 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9677723400;
        Wed,  4 Sep 2019 06:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567576885;
        bh=BQ9hn8j6Jc8e7lOty+wvuxRc1qVRJM7fTFpeT6TgqBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBcgpBrxx2UL0I3WDN2iJdBDh2+jr5oMwtnKGylIYkCcuEObubn0Iz4d737LMf50B
         2gD3L+Di69Vo68zOqEu3jftSkberNGmMnxBa1w4k4KWZm8O0zE+gZXkhW0Wn22EoXp
         VOPr8s3//DgfVEG20j3uX5v0jS7L3Rfmv9KOwitU=
Date:   Wed, 4 Sep 2019 11:30:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: milbeaut-m10v-xdmac: Add Socionext
 Milbeaut XDMAC bindings
Message-ID: <20190904060017.GE2672@vkoul-mobl>
References: <20190818052154.17789-1-jassisinghbrar@gmail.com>
 <20190818052224.17857-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818052224.17857-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-08-19, 00:22, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Document the devicetree bindings for Socionext Milbeaut XDMAC
> controller. Controller only supports Mem->Mem transfers. Number
> of physical channels are determined by the number of irqs registered.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/dma/milbeaut-m10v-xdmac.txt      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt b/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
> new file mode 100644
> index 000000000000..1f15512e3f19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
> @@ -0,0 +1,24 @@
> +* Milbeaut AXI DMA Controller
> +
> +Milbeaut AXI DMA controller has only memory to memory transfer capability.
> +
> +* DMA controller
> +
> +Required property:
> +- compatible: 	Should be  "socionext,milbeaut-m10v-xdmac"
> +- reg:		Should contain DMA registers location and length.
> +- interrupts: 	Should contain all of the per-channel DMA interrupts.
> +                Number of channels is configurable - 2, 4 or 8, so
> +                the number of interrupts specfied should be {2,4,8}.

s/specfied/specified

-- 
~Vinod

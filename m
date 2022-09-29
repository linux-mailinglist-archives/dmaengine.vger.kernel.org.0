Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED45EF96F
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiI2Psq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiI2PsK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 11:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A111C99DF;
        Thu, 29 Sep 2022 08:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B26618D7;
        Thu, 29 Sep 2022 15:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A955C433D6;
        Thu, 29 Sep 2022 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466475;
        bh=D5MESLT/IXAZ2dSqhIZqRBjBjZTd0jInAaXi83xB9qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnQalHSqR3S+Mt2H42T4rS0/ftAxe67Og2O71ShEmJQZ7sfR70iGyipZx1so8Qucv
         uDrZOmCqsKGUAK4kUQ9ZghqqZcncp/0LwKPd7xZf3JoNkm+qHE97hX5e3slC2WW0FU
         CtVioZC7dOthu/LbPY+GP73XCK6zG9gImPeX020kQ42OJx6bHaF3pOVAcN2beA31Wz
         KYZgsw//hBpfmS/SzLku/ikpiCPxCtVLci4tG6rvK5QqYDRMBlnXcNzeSO9Z0N5dca
         NrTqsPp2wsnCtlSjoNqYBJNbalL8fhKceTZuJtK7Ppm17pXZ7NogrFZ3aMWGvHiki3
         aONCYW4lSyEKw==
Date:   Thu, 29 Sep 2022 21:17:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     peter.ujfalusi@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: devicetree: dma: update the comments
Message-ID: <YzW+Js6VW0duRV5z@matsya>
References: <20220920020721.2190-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920020721.2190-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-22, 22:07, Deming Wang wrote:
> remove the double word to.

Applied, thanks

> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> index b849a1ed389d..47e477cce6d2 100644
> --- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> @@ -4,7 +4,7 @@ Required properties:
>  - compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
>  		"ti,am335x-edma-crossbar" for AM335x and AM437x
>  - reg:		Memory map for accessing module
> -- #dma-cells:	Should be set to to match with the DMA controller's dma-cells
> +- #dma-cells:	Should be set to match with the DMA controller's dma-cells
>  		for ti,dra7-dma-crossbar and <3> for ti,am335x-edma-crossbar.
>  - dma-requests:	Number of DMA requests the crossbar can receive
>  - dma-masters:	phandle pointing to the DMA controller
> -- 
> 2.27.0

-- 
~Vinod

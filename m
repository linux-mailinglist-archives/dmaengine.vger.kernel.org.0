Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2415C086
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBMOl6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 09:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMOl6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 09:41:58 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960EB218AC;
        Thu, 13 Feb 2020 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581604917;
        bh=an31nb43uP0tShcFCdO46SOIJojAno/QfSPG1aCR4uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5/EKUUw599m19/1U1gTZ3hr5XG7Ne9QSmLFAUqGMSo5kRVsZpdZ++AIAJnrHSRtJ
         oFp86NjaC7hj5I6DxNhEgonk2i1DpKDugD8dLHoijtZ1N7fMioDtYpLGuMJBORwzzR
         rcGK1lZEP7KJ4VcXbuxxhsXYVMRxWuOuH053bLAA=
Date:   Thu, 13 Feb 2020 20:11:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: ti-edma: fix example compatible
 property
Message-ID: <20200213144153.GK2618@vkoul-mobl>
References: <20200212104840.20393-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212104840.20393-1-johan@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-02-20, 11:48, Johan Hovold wrote:
> Make sure that the compatible string in the edma1_tptc1 example node
> matches the binding by removing the space between the manufacturer and
> model.

Applied, thanks

> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 0e1398f93aa2..29fcd37082e8 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -180,7 +180,7 @@ edma1_tptc0: tptc@27b0000 {
>  };
>  
>  edma1_tptc1: tptc@27b8000 {
> -	compatible = "ti, k2g-edma3-tptc", "ti,edma3-tptc";
> +	compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
>  	reg =	<0x027b8000 0x400>;
>  	power-domains = <&k2g_pds 0x4f>;
>  };
> -- 
> 2.24.1

-- 
~Vinod

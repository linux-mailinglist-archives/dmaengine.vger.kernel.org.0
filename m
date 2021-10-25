Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99BE438E7E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJYErU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhJYErT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:47:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017A260F4F;
        Mon, 25 Oct 2021 04:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635137098;
        bh=T3WkwZ1s63m8kCYozHTFga54qgTsMD1mM7FO6S2jDQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQJZFTPbnPCzHjosqmIxbV+2FvaSqBlwEj1eSwkjZkFwJNaNFz7ixf0Lk4qto7wfC
         AfdUoCYcslFTZg/7Hrv0ySUk8SK31oLR2P02VnHTaU5ZztaJQ4OgzGK4eHzBgXJpg4
         FK1C8vdirXY0S2qQ5QpDKsJFgOfEuRf78wVLOethVLTww22thu1Q8VL8EvwEQHzoeC
         4MQUfaCCJuPxBHx4wlTtoTHbQNpi67lKWkO9+Ol21WszoxWDl3zhA7u+cUKG338kw3
         XIdIeXz4lq1bjI7/SZWataQBddSnylQQzPgsJh+TNmKI6/UtVCQ0wTscm2eksemOCf
         x45c4bRcy2P5g==
Date:   Mon, 25 Oct 2021 10:14:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     yibin.gong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Message-ID: <YXY2Ra+/j1apuRpZ@matsya>
References: <20211021052030.3155471-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021052030.3155471-1-joy.zou@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-21, 13:20, Joy Zou wrote:
> Add HDMI Audio transfer type.

Convert to yaml?

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 12c316ff4834..ffa61264a214 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -55,6 +55,7 @@ The full ID of peripheral types can be found below.
>  	22	SSI Dual FIFO	(needs firmware ver >= 2)
>  	23	Shared ASRC
>  	24	SAI
> +	25	HDMI Audio
>  
>  The third cell specifies the transfer priority as below.
>  
> -- 
> 2.25.1

-- 
~Vinod

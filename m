Return-Path: <dmaengine+bounces-5505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D538FADC27B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 08:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E3D7A2CFE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DFA28B7CC;
	Tue, 17 Jun 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEh/V+VF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F0202C48;
	Tue, 17 Jun 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142337; cv=none; b=usTc/gzmHg+FyIG8ZMnIpT5iOOKUPJugWF5aj8wxMobw5iU0Xr1ic5xUKqdOkr+KmldTPrwVfqaRj3bjYOcPKsqJ+ugQ/wxudmRY5+DQ0Z6kF2pXQx7UkzBeoSWiHiWrbLLMh9y1cpLAg6hxl2wMgOBY8+PXMsZP8+Yasnl94xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142337; c=relaxed/simple;
	bh=z+vpObESyxPEfQz9MODClMQrhR21GENy2LtWC3VhyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy3gLeOMboLkc7R1S5ZIgGvYPN0wzutV2+X8JeVZa8JmCnIQxsnaiC9VZQfy4HyfDhY4gfK24SfaGJ5CfIT/QOw0NTjMSXHfpGkizquHffdEdr3dKQN8zdRa6zku0ycC4mCtU6JD1ts6vzqBN3cbi+X22GKe/DsieDvipA56ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEh/V+VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A1FC4CEE3;
	Tue, 17 Jun 2025 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750142336;
	bh=z+vpObESyxPEfQz9MODClMQrhR21GENy2LtWC3VhyO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEh/V+VFAkpmYeRXwXnW4Gtssa2FNm9M3j6QIyoBW8wLdMDarSedKQkM5wzrG+5zp
	 cDL8UlZw948WVJawBmkQ5bOJq1V1WafNt3pk8AqVwrJSIOrd0edtxuIW34dKju+Yen
	 YLTQKnn6NA8HIXNSv7V8VMYCiPosyKRg1IFgrTxiX5Z3ZoM55FTuqFCB8dbcd6INTC
	 CA+kgxgZlqZ1cO+g5hYngjyGmQuiTOxpajoMqizwH98nb2/sawVxBjwQgVn+i98AEz
	 AKa2ptfcM0APRnv3r/Lm/NPQwnbxEIleXIpe0PszbavEUG6TiihejDHPP2yV/BUBE5
	 Ftd3IsvnZbuxg==
Date: Tue, 17 Jun 2025 12:08:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Abin Joseph <abin.joseph@amd.com>
Cc: michal.simek@amd.com, yanzhen@vivo.com, radhey.shyam.pandey@amd.com,
	palmer@rivosinc.com, u.kleine-koenig@baylibre.com, git@amd.com,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Add shutdown operation support
Message-ID: <aFENfW0v0gmtY2Gu@vaman>
References: <20250612162144.3294953-1-abin.joseph@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612162144.3294953-1-abin.joseph@amd.com>

On 12-06-25, 21:51, Abin Joseph wrote:
> Implement shutdown hook to ensure dmaengine could be stopped inorder for
> kexec to restart the new kernel.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index d05fc5fcc77d..8f9f1ef4f0bf 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1178,6 +1178,18 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
>  		zynqmp_dma_runtime_suspend(zdev->dev);
>  }
>  
> +/**
> + * zynqmp_dma_shutdown - Driver shutdown function
> + * @pdev: Pointer to the platform_device structure
> + */
> +static void zynqmp_dma_shutdown(struct platform_device *pdev)
> +{
> +	struct zynqmp_dma_device *zdev = platform_get_drvdata(pdev);
> +
> +	zynqmp_dma_chan_remove(zdev->chan);
> +	pm_runtime_disable(zdev->dev);
> +}
> +
>  static const struct of_device_id zynqmp_dma_of_match[] = {
>  	{ .compatible = "amd,versal2-dma-1.0", .data = &versal2_dma_config },
>  	{ .compatible = "xlnx,zynqmp-dma-1.0", },
> @@ -1193,6 +1205,7 @@ static struct platform_driver zynqmp_dma_driver = {
>  	},
>  	.probe = zynqmp_dma_probe,
>  	.remove = zynqmp_dma_remove,
> +	.shutdown = zynqmp_dma_shutdown,

Why not do all operations performed in remove..?

>  };
>  
>  module_platform_driver(zynqmp_dma_driver);
> -- 
> 2.34.1

-- 
~Vinod


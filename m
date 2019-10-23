Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58616E10FA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 06:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJWE21 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 00:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfJWE21 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 00:28:27 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2BA214B2;
        Wed, 23 Oct 2019 04:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571804906;
        bh=pud1AqfrL2+yGH3/Mj/96RE5LhtzfD6/WYjBiXtPT38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqwY2860h37CrasP50CZJnw67mckyQb0+sRAUhAsM0LM9RQyIAMU0IbWjZJbzb3D0
         9yHNOVAqpoNp60Vc8vVAxZnBGrn6Q0IZ7+b9Ht2e5+W2/iHgQ+Ocso03WHoEwj/Zaq
         LG2USbNiXQ0tVBlfewWmUCCYm0ZJWeSr6aHHlUBs=
Date:   Wed, 23 Oct 2019 09:58:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        anders.roxell@linaro.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Fixed build error when enable
 dpaa2 qdma module driver
Message-ID: <20191023042818.GN2654@vkoul-mobl>
References: <20191023021959.35596-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023021959.35596-1-peng.ma@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peng,

On 23-10-19, 10:19, Peng Ma wrote:

A patch title should detail the change it is doing so a better patch
title would be: "dmaengine: fsl-dpaa2-qdma: export the symbols"

> Fixed the following error:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-dpaa2-qdma/dpdmai.o
> see include/linux/module.h for more information
> GZIP    arch/arm64/boot/Image.gz
> ERROR: "dpdmai_enable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_set_rx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_get_tx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_get_rx_queue" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_get_attributes" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_open" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_close" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_disable" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> ERROR: "dpdmai_reset" [drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.ko] undefined!
> WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2

And here in the log, you should say the symbols were not exported
leading to error <give error log>

So export it

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> index fbc2b2f..f8a1f66 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright 2019 NXP
>  
> +#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
>  #include <linux/fsl/mc.h>
> @@ -90,6 +91,7 @@ int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_open);
>  
>  /**
>   * dpdmai_close() - Close the control session of the object
> @@ -113,6 +115,7 @@ int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_close);
>  
>  /**
>   * dpdmai_create() - Create the DPDMAI object
> @@ -177,6 +180,7 @@ int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_enable);
>  
>  /**
>   * dpdmai_disable() - Disable the DPDMAI, stop sending and receiving frames.
> @@ -197,6 +201,7 @@ int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_disable);
>  
>  /**
>   * dpdmai_reset() - Reset the DPDMAI, returns the object to initial state.
> @@ -217,6 +222,7 @@ int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_reset);
>  
>  /**
>   * dpdmai_get_attributes() - Retrieve DPDMAI attributes.
> @@ -252,6 +258,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
>  
>  /**
>   * dpdmai_set_rx_queue() - Set Rx queue configuration
> @@ -285,6 +292,7 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
>  
>  /**
>   * dpdmai_get_rx_queue() - Retrieve Rx queue attributes.
> @@ -325,6 +333,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
>  
>  /**
>   * dpdmai_get_tx_queue() - Retrieve Tx queue attributes.
> @@ -364,3 +373,6 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_get_tx_queue);
> +
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.9.5

-- 
~Vinod

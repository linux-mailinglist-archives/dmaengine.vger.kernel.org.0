Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3942EE117E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfJWFJe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 01:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfJWFJe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 01:09:34 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFD4214B2;
        Wed, 23 Oct 2019 05:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571807374;
        bh=yHRR1qaWgApvonMqA4KR2biBOE3OmpEgupa0lezkM0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R21h/IlOeR/5NGFmEipA8/XzUX9RObcjqUIfu1kzWiTtCkMr6Tf4gqCl5fnqDdTC/
         QUqx9pXRV2ITidQMqdCDmlPIGKf4+NmPqvv0EyKemFVDmei/ced4i+3MGTpQrESppR
         AhXXil0XZGhNcpJkFKvx1OM04DOLOfOh/SWMWrcw=
Date:   Wed, 23 Oct 2019 10:39:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        anders.roxell@linaro.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [next, v2] dmaengine: fsl-dpaa2-qdma: export the symbols
Message-ID: <20191023050927.GP2654@vkoul-mobl>
References: <20191023045617.22764-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023045617.22764-1-peng.ma@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-10-19, 12:56, Peng Ma wrote:
> The symbols were not exported leading to error:
> 
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
> 
> So export it.

Applied, thanks

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163821AAC5D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414942AbgDOPyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 11:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414941AbgDOPyN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 11:54:13 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC99E2078B;
        Wed, 15 Apr 2020 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966052;
        bh=vnmTaBMnbWeZwBEDn7jEJ2FxWVO9YscBRgyo6TVC4A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nT/1/zngd0WdQg2V/NRBkL8bMFXf+XI/Vnkjec7wJ3QbxNPL/tpLPpOp3qpNtpypf
         4HMA3PKkSUaBIwFssoHqn2gJn3hwtAvlZG3ZikkrwSx7x6+rIJbcyr7FqaopArJPOK
         MNy0CD4ADSnA4o5FU6R1bkvHhki0V0UPPs1IK6Cc=
Date:   Wed, 15 Apr 2020 21:23:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     leonid.ravich@dell.com
Cc:     dmaengine@vger.kernel.org, lravich@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: ioat: Decreasing  allocation chunk
 size 2M -> 512K
Message-ID: <20200415155359.GT72691@vkoul-mobl>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
 <20200402163356.9029-1-leonid.ravich@dell.com>
 <20200402163356.9029-2-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402163356.9029-2-leonid.ravich@dell.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-04-20, 19:33, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> current IOAT driver using big (2MB) allocations chunk for its descriptors
> therefore each ioat dma engine need 2 such chunks
> (64k entres in ring  each entry 64B = 4MB)
> requiring 2 * 2M * dmaengine contiguies memory chunk
> might fail due to memory fragmention.

This is quite decent explanation :) pls use upto 72 chars to make it a
better read.

> 
> so we decreasing chunk size and using more chunks.
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
>  drivers/dma/ioat/dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 5216c6b..e6b622e 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -83,7 +83,7 @@ struct ioatdma_device {
>  
>  #define IOAT_MAX_ORDER 16
>  #define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
> -#define IOAT_CHUNK_SIZE (SZ_2M)
> +#define IOAT_CHUNK_SIZE (SZ_512K)
>  #define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE / IOAT_DESC_SZ)
>  
>  struct ioat_descs {
> -- 
> 1.9.3

-- 
~Vinod

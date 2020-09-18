Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7426F6D9
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIRHZa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgIRHZa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:25:30 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B7220C56;
        Fri, 18 Sep 2020 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600413929;
        bh=reDaz415y6/CFFbnz3pX0ER4+qhEF0Z44ZHEFXr2a2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKDNkKHBw4ATydrOZUlOC6WwhFF6dbez6+LgCZqKJ12hOQ0D4s1QrjLg5Ls8BwKmp
         /I6nveUMgObJPvyIlATson4aZ0wpfc+QTKruNfUwDy9TjpDVHJU3SubcyRKabG1INX
         yAWcmH7HWE4550Ym2wR23BSTFCPhHwfZHUUTO7H8=
Date:   Fri, 18 Sep 2020 12:55:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: iop-adma: Fix pointer cast warnings
Message-ID: <20200918072525.GL2968@vkoul-mobl>
References: <20200818115101.55700-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818115101.55700-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-08-20, 19:51, YueHaibing wrote:
> drivers/dma/iop-adma.c: In function ‘iop_adma_alloc_chan_resources’:
> drivers/dma/iop-adma.c:447:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    hw_desc = (char *) iop_chan->device->dma_desc_pool;
>              ^
> drivers/dma/iop-adma.c:449:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     (dma_addr_t) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
>     ^
> drivers/dma/iop-adma.c: In function ‘iop_adma_probe’:
> drivers/dma/iop-adma.c:1301:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    (void *) adev->dma_desc_pool);
> 
> Use dma_addr_t for dma_desc_pool, and %pad to print dma_addr_t.

Applied, thanks

-- 
~Vinod

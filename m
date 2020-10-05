Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE03282FBB
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJEEq4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJEEq4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:46:56 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6582080C;
        Mon,  5 Oct 2020 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601873215;
        bh=0SimSveQGeUxXB9OTEuy2aHgGOxBfTXFFfaOsN9roXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQEZCokKzw0j4sTpUVkmfD2atNDjTgLkjZZQMfu1cSzDOWRTDnRA1Pe8CgEOjBLWS
         OTM6xTd1hiYCMPeNowSerJZ32N2tOloRqVmPqLiXr7iDpWRUmWJb0tihdk9rlfdZBr
         t8a2AqrlxLkmtK5zz/Brdmyrvn0AYBvi75qtaWQ4=
Date:   Mon, 5 Oct 2020 10:16:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dmaengine: ioat: Allocate correct size for descriptor
 chunk
Message-ID: <20201005044651.GI2968@vkoul-mobl>
References: <20200922200844.2982-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922200844.2982-1-logang@deltatee.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-20, 14:08, Logan Gunthorpe wrote:
> dma_alloc_coherent() is called with a fixed SZ_2M size, but frees happen
> with IOAT_CHUNK_SIZE. Recently, IOAT_CHUNK_SIZE was reduced to 512M but
> the allocation did not change. To fix, change to using the
> IOAT_CHUNK_SIZE define.
> 
> This was caught with the upcoming patchset for converting Intel platforms to the
> dma-iommu implementation. It has a warning when the unmapped size differs from
> the mapped size.

Applied, thanks

-- 
~Vinod

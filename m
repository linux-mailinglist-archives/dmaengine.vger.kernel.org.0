Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30689B615B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfIRKXo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 06:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIRKXo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Sep 2019 06:23:44 -0400
Received: from localhost (unknown [122.178.229.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2A721897;
        Wed, 18 Sep 2019 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568802222;
        bh=Ufw7FUGrLQkUrWpErXpIVqjX4+AcYjir12O/liwljKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uv9gLn/ezsR5m8Ye2Jf15UwxZR8x4nqLe8HzMspBkdbet4cDVpMZVpZlYcCGgZ/HH
         2sg15lx2bQjYDIvstqli769vWu5xtGryD5Ol6OKgS9tq4vrpPAj5TFCKjjmOiFzkh1
         Waek5fMuRXpfeVHH8r8p2MMvi3K1JSW63iFfMahI=
Date:   Wed, 18 Sep 2019 15:52:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dylan Yip <dylan.yip@xilinx.com>
Cc:     dmaengine@vger.kernel.org, satishna@xilinx.com
Subject: Re: [LINUX PATCH] dma-mapping: Control memset operation using gfp
 flags
Message-ID: <20190918102231.GN4392@vkoul-mobl>
References: <1568752715-11704-1-git-send-email-dylan.yip@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568752715-11704-1-git-send-email-dylan.yip@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-09-19, 13:38, Dylan Yip wrote:
> In case of 4k video buffer, the allocation from a reserved memory is
> taking a long time, ~500ms. This is root caused to the memset()
> operations on the allocated memory which is consuming more cpu cycles.
> Due to this delay, we see that initial frames are being dropped.
> 
> To fix this, we have wrapped the default memset, done when allocating
> coherent memory, under the __GFP_ZERO flag. So, we only clear
> allocated memory if __GFP_ZERO flag is enabled. We believe this
> should be safe as the video decoder always writes before reading.
> This optimizes decoder initialization as we do not set the __GFP_ZERO
> flag when allocating memory for decoder. With this optimization, we
> don't see initial frame drops and decoder initialization time is
> ~100ms.
> 
> This patch adds plumbing through dma_alloc functions to pass gfp flag
> set by user to __dma_alloc_from_coherent(). Here gfp flag is checked
> for __GFP_ZERO. If present, we memset the buffer to 0 otherwise we
> skip memset.

Please use ./scripts/get_maintainer.pl to find out who should this patch
be sent to.

This is not the correct list for dma mapping code

> 
> Signed-off-by: Dylan Yip <dylan.yip@xilinx.com>
> ---
>  arch/arm/mm/dma-mapping-nommu.c |  2 +-
>  include/linux/dma-mapping.h     | 11 +++++++----
>  kernel/dma/coherent.c           | 15 +++++++++------
>  kernel/dma/mapping.c            |  2 +-
>  4 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index 52b8255..242b2c3 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -35,7 +35,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  				 unsigned long attrs)
>  
>  {
> -	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
> +	void *ret = dma_alloc_from_global_coherent(size, dma_handle, gfp);
>  
>  	/*
>  	 * dma_alloc_from_global_coherent() may fail because:
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f7d1eea..b715c9f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -160,24 +160,27 @@ static inline int is_device_dma_capable(struct device *dev)
>   * Don't use them in device drivers.
>   */
>  int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
> -				       dma_addr_t *dma_handle, void **ret);
> +				       dma_addr_t *dma_handle, void **ret,
> +				       gfp_t flag);
>  int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>  
>  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>  			    void *cpu_addr, size_t size, int *ret);
>  
> -void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
> +void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle,
> +				     gfp_t flag);
>  int dma_release_from_global_coherent(int order, void *vaddr);
>  int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
>  				  size_t size, int *ret);
>  
>  #else
> -#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
> +#define dma_alloc_from_dev_coherent(dev, size, handle, ret, flag) (0)
>  #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>  #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
>  
>  static inline void *dma_alloc_from_global_coherent(ssize_t size,
> -						   dma_addr_t *dma_handle)
> +						   dma_addr_t *dma_handle,
> +						   gfp_t flag)
>  {
>  	return NULL;
>  }
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 29fd659..d85fab5 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -136,7 +136,7 @@ void dma_release_declared_memory(struct device *dev)
>  EXPORT_SYMBOL(dma_release_declared_memory);
>  
>  static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
> -		ssize_t size, dma_addr_t *dma_handle)
> +		ssize_t size, dma_addr_t *dma_handle, gfp_t gfp_flag)
>  {
>  	int order = get_order(size);
>  	unsigned long flags;
> @@ -158,7 +158,8 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>  	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
>  	ret = mem->virt_base + (pageno << PAGE_SHIFT);
>  	spin_unlock_irqrestore(&mem->spinlock, flags);
> -	memset(ret, 0, size);
> +	if (gfp_flag & __GFP_ZERO)
> +		memset(ret, 0, size);
>  	return ret;
>  err:
>  	spin_unlock_irqrestore(&mem->spinlock, flags);
> @@ -172,6 +173,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   * @dma_handle:	This will be filled with the correct dma handle
>   * @ret:	This pointer will be filled with the virtual address
>   *		to allocated area.
> + * @flag:      gfp flag set by user
>   *
>   * This function should be only called from per-arch dma_alloc_coherent()
>   * to support allocation from per-device coherent memory pools.
> @@ -180,24 +182,25 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   * generic memory areas, or !0 if dma_alloc_coherent should return @ret.
>   */
>  int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
> -		dma_addr_t *dma_handle, void **ret)
> +		dma_addr_t *dma_handle, void **ret, gfp_t flag)
>  {
>  	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
>  
>  	if (!mem)
>  		return 0;
>  
> -	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
> +	*ret = __dma_alloc_from_coherent(mem, size, dma_handle, flag);
>  	return 1;
>  }
>  
> -void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
> +void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle,
> +				     gfp_t flag)
>  {
>  	if (!dma_coherent_default_memory)
>  		return NULL;
>  
>  	return __dma_alloc_from_coherent(dma_coherent_default_memory, size,
> -			dma_handle);
> +			dma_handle, flag);
>  }
>  
>  static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b0038ca..bfea1d2 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -272,7 +272,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  
>  	WARN_ON_ONCE(!dev->coherent_dma_mask);
>  
> -	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
> +	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr, flag))
>  		return cpu_addr;
>  
>  	/* let the implementation decide on the zone to allocate from: */
> -- 
> 2.7.4

-- 
~Vinod

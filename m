Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2138D524
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 12:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEVKaa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Sat, 22 May 2021 06:30:30 -0400
Received: from aposti.net ([89.234.176.197]:51886 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEVKa3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 22 May 2021 06:30:29 -0400
Date:   Sat, 22 May 2021 11:28:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Possible bug when using dmam_alloc_coherent in conjonction with
 of_reserved_mem_device_release
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Message-Id: <4S7ITQ.ORCLYUEJD8BH3@crapouillou.net>
In-Reply-To: <YKf4zlklLdfJBN6p@orolia.com>
References: <YKf4zlklLdfJBN6p@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Olivier,


Le ven., mai 21 2021 at 20:15:42 +0200, Olivier Dautricourt 
<olivier.dautricourt@orolia.com> a écrit :
> Hello all,
> 
> I am facing a problem when using dmam_alloc_coherent (the managed
> version of dma_alloc_coherent) along with a device-specific reserved 
> memory
> region using the CMA.
> 
> My observation is on a kernel 5.10.19 (arm), as i'm unable to test 
> the exact
> same configuration on a newer kernel. However it seems that the 
> relevent code
> did not change too much since, so i think it's still applicable.
> 
> 
> ....
> The issue:
> 
> I declare a reserved region on my board such as:
> 
> mydevice_reserved: linux,cma {
>         compatible = "shared-dma-pool";
>         reusable;
>         size = <0x2400000>;
> };
> 
> and start the kernel with cma=0, i want my region to be reserved to 
> my device.
> 
> My driver basically does:
> 
> probe(dev):
> 	of_reserved_mem_device_init(dev)
> 	dmam_alloc_coherent(...)
> 
> release(dev):
> 	of_reserved_mem_device_release(dev)

You must make sure that whatever is allocated or initialized is freed 
or deinitialized in the reverse order, which is not what will happen 
here: release(dev) will be called before the dev-managed cleanups.

To fix your issue, either use dma_alloc_coherent() and call 
dma_free_coherent() in release(), or register 
of_reserved_mem_device_release() as a dev-managed cleanup function 
(which is what my driver does).

Cheers,
-Paul

> On driver detach, of_reserved_mem_device_release will call
> rmem_cma_device_release which sets dev->cma_area = NULL;
> Then the manager will try to free the dma memory allocated in the 
> probe:
> 
> __free_from_contiguous -> dma_release_from_contiguous ->
> cma_release(dev_get_cma_area(dev), ...);
> 
> Except that now dev_get_cma_area will return 
> dma_contiguous_default_area
> which is null in my setup:
> 
> static inline struct cma *dev_get_cma_area(struct device *dev)
> {
> 	if (dev && dev->cma_area) // dev->cma_area is null
> 		return dev->cma_area;
> 
> 	return dma_contiguous_default_area; // null in my setup
> }
> 
> and so cma_release will do nothing.
> 
> bool cma_release(struct cma *cma, const struct page *pages, unsigned 
> int count)
> {
> 	unsigned long pfn;
> 
> 	if (!cma || !pages) // cma is NULL
> 		return false;
> 
> __free_from_contiguous will fail silently because it ignores
> dma_release_from_contiguous boolean result.
> 
> The driver will be unable to load and allocate memory again because 
> the
> area allocated with dmam_alloc_coherent is not freed.
> ...
> 
> So i started to look at drivers using both dmam_alloc_coherent and
> of_reserved_mem_device_release and found this driver:
> (gpu/drm/ingenic/ingenic-drm-drv.c).
> This is why i included the original author, Paul Cercueil, in the 
> loop.
> 
> Q:
> 
> I noticed that Paul used devm_add_action_or_reset to trigger
> of_reserved_mem_device_release on driver detach, is this because of 
> this
> problem that we use a devm trigger here ?
> 
> I tried to do the same in my driver, but rmem_cma_device_release is 
> still
> called before dmam_release, is there a way to force the order ?
> 
> Is what i described a bug that needs fixing ?
> 
> 
> Thank you,
> 
> 
> Olivier
> 
> 



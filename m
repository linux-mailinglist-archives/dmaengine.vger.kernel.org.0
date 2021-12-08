Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE646CCBD
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 05:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhLHFAA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 00:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbhLHFAA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Dec 2021 00:00:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA4C061574;
        Tue,  7 Dec 2021 20:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F555B81113;
        Wed,  8 Dec 2021 04:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E346C341C3;
        Wed,  8 Dec 2021 04:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638939386;
        bh=C9Fxg4lH/TpRohy6FBCFxRHJq6QxdHRXmdORxmA2LQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqcCBB0TqyOBe1PKMXTJnGrJfgXFaWGreXTj4jacVfPnKGUQdsx2+nFCt6aL8AWCe
         gtaOqSRy8mIQSsB9Z1Uv6Jn0CtQ0xxwjqe9Ti1AqmdRSAJ2wmhcEdA5Oqc8wbp80tz
         zwRSIObMdfzqEZARgmGqbIaLCXu+YC30LG2braUKc+iaNTCQAdAGQ0n0COlSAwPH7W
         LNtk2YVvMJTRCDCVfBPMAHA1KG5uRv0WP3xJ06LgzZSpPQdm8cdmIxvLsj1ooSWMqU
         JY2qXKWq26CuKIsAcA3w9CH9PFTdFkD+uScKtG7iAGiebvHqBxMUoVX7QHjcBVE/Pe
         gXTHxbjRH/83g==
Date:   Wed, 8 Dec 2021 10:26:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <YbA69kdTgqB9tJc8@matsya>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <dbb90f20-d9fb-1f24-b59d-15a2a42437e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb90f20-d9fb-1f24-b59d-15a2a42437e2@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-12-21, 16:27, Dave Jiang wrote:
> 
> On 12/7/2021 6:47 AM, Jacob Pan wrote:
> > In-kernel DMA should be managed by DMA mapping API. The existing kernel
> > PASID support is based on the SVA machinery in SVA lib that is intended
> > for user process SVA. The binding between a kernel PASID and kernel
> > mapping has many flaws. See discussions in the link below.
> > 
> > This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
> > requests with PASID under the same mapping managed by DMA mapping API.
> > In addition, SVA-related bits for kernel DMA are removed. As a result,
> > DSA users shall use DMA mapping API to obtain DMA handles instead of
> > using kernel virtual addresses.
> > 
> > Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> Also cc Vinod and dmaengine@vger

Pls resend collecting acks. I dont have this in my queue

-- 
~Vinod

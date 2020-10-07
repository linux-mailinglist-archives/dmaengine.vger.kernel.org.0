Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD982858F1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgJGHBh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 03:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgJGHBh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 03:01:37 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A626D20797;
        Wed,  7 Oct 2020 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602054096;
        bh=EQol35pNFBdmd6Ux0Kwp4YrW6KklnpWUtJVLyyYp1uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCTsWggT9tZDRZm5bDKs9eMsLiAHwH0zUzAa+JCs7RQo5yrumU+Bb1syGw0Zppa8y
         XfaTVBI9ohbggmhwh/1oAuMHfG6K4VReZFt7IgVJ9hj1yGwznnNKacrHCXS+IcVRE8
         5iE/xeTE15rDA4JdW0wlaPLa0E+V+mve4fJ9d64o=
Date:   Wed, 7 Oct 2020 12:31:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
        ashok.raj@intel.com, kevin.tian@intel.com, fenghua.yu@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007070132.GT2968@vkoul-mobl>
References: <20201005151126.657029-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005151126.657029-1-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-10-20, 08:11, Dave Jiang wrote:

> == Background ==
> A typical DMA device requires the driver to translate application buffers to hardware addresses,
> and a kernel-user transition to notify the hardware of new work. Shared Virtual Addressing (SVA)
> allows the processor and device to use the same virtual addresses without requiring software to
> translate between the address spaces. ENQCMD is a new instruction on Intel Platforms that allows
> user applications to directly notify hardware of new work, much like how doorbells are used in
> some hardware, but it carries a payload along with it. ENQCMDS is the supervisor version (ring0)
> of ENQCMD.
> 
> == ENQCMDS ==
> Introduce enqcmds(), a helper funciton that copies an input payload to a 64B aligned
> destination and confirms whether the payload was accepted by the device or not.
> enqcmds() wraps the new ENQCMDS CPU instruction. The ENQCMDS is a ring 0 CPU instruction that
> performs similar to the ENQCMD instruction. Descriptor submission must use ENQCMD(S) for shared
> workqueues (swq) on an Intel DSA device. 
> 
> == Shared WQ support ==
> Introduce shared workqueue (swq) support for the idxd driver. The current idxd driver contains
> dedicated workqueue (dwq) support only. A dwq accepts descriptors from a MOVDIR64B instruction.
> MOVDIR64B is a posted instruction on the PCIe bus, it does not wait for any response from the
> device. If the wq is full, submitted descriptors are dropped. A swq utilizes the ENQCMDS in
> ring 0, which is a non-posted instruction. The zero flag would be set to 1 if the device rejects
> the descriptor or if the wq is full. A swq can be shared between multiple users
> (kernel or userspace) due to not having to keep track of the wq full condition for submission.
> A swq requires PASID and can only run with SVA support. 
> 
> == IDXD SVA support ==
> Add utilization of PASID to support Shared Virtual Addressing (SVA). With PASID support,
> the descriptors can be programmed with host virtual address (HVA) rather than IOVA.
> The hardware will work with the IOMMU in fulfilling page requests. With SVA support,
> a user app using the char device interface can now submit descriptors without having to pin the
> virtual memory range it wants to DMA in its own address space. 
> 
> The series does not add SVA support for the dmaengine subsystem. That support is coming at a
> later time.

Applied, thanks

-- 
~Vinod

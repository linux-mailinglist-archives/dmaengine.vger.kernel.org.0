Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25F29DEC4
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403766AbgJ2A4X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 20:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbgJ1WRg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C9C20838;
        Wed, 28 Oct 2020 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603860124;
        bh=EkFiNjN4SUv3EqO7hmjM0xSLrXXIbQuWSr/bMpRYcJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nr2z3cqQXSG6KAp7J8g0im/X3XiRPzWtQlyKY+5hUBBrsopy5IZosCGiMlV4BojKg
         nzAEdJFfizwgmkYLriwS9IvE7V/T9wN7OyGaEGmfeBFzRAYAXDLxTjn9e2kSwBhQfc
         Q0CqmfDqiDxaKjbteSeKZSjq4njrhXpm6w4SW4EE=
Date:   Wed, 28 Oct 2020 10:11:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 0/3] Add shared workqueue support for idxd driver
Message-ID: <20201028044159.GE3550@vkoul-mobl>
References: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 10:34, Dave Jiang wrote:
> Driver stage 1 postings for context: [1]
> 
> The patch series has compilation and functional dependency on Fenghua's "Tag application
> address space for devices" patch series for the ENQCMD CPU command enumeration and the PASID MSR
> support. [2] 
> 
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

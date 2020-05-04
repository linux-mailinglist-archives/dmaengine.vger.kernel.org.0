Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE81C323B
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgEDFaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgEDFaD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:30:03 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE6A20643;
        Mon,  4 May 2020 05:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588570202;
        bh=qb8TFTxPvAhYVp5MgrmNT6TV3hFAhoKv0fd+mmu/eVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APZ0NKptkV7nQmbOJVXrZ9iWMmMUmj7uJeCMSrHt7W1oMBQo2hOiesdv2pwFAdOAX
         n+RM1steegXVBEEFP8BhW3PsJ+at9begFNrDZryT9bPwWuktnqkKUAj8LVmqsASYwL
         JxanWkMRzCWA5b0BpFF1z3OMwKSLO7Spju32iFGc=
Date:   Mon, 4 May 2020 10:59:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, kishon@ti.com, paul.walmsley@sifive.com
Subject: Re: [PATCH][next] dmaengine: dw-edma: support local dma device
 transfer semantics
Message-ID: <20200504052958.GH1375924@vkoul-mobl>
References: <1588122633-1552-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588122633-1552-1-git-send-email-alan.mikhak@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-20, 18:10, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify dw_edma_device_transfer() to also support the semantics of dma
> device transfer for additional use cases involving pcitest utility as a
> local initiator.
> 
> For its original use case, dw-edma supported the semantics of dma device
> transfer from the perspective of a remote initiator who is located across
> the PCIe bus from dma channel hardware.
> 
> To a remote initiator, DMA_DEV_TO_MEM means using a remote dma WRITE
> channel to transfer from remote memory to local memory. A WRITE channel
> would be employed on the remote device in order to move the contents of
> remote memory to the bus destined for local memory.
> 
> To a remote initiator, DMA_MEM_TO_DEV means using a remote dma READ
> channel to transfer from local memory to remote memory. A READ channel
> would be employed on the remote device in order to move the contents of
> local memory to the bus destined for remote memory.
> 
> >From the perspective of a local dma initiator who is co-located on the
> same side of the PCIe bus as the dma channel hardware, the semantics of
> dma device transfer are flipped.
> 
> To a local initiator, DMA_DEV_TO_MEM means using a local dma READ channel
> to transfer from remote memory to local memory. A READ channel would be
> employed on the local device in order to move the contents of remote
> memory to the bus destined for local memory.
> 
> To a local initiator, DMA_MEM_TO_DEV means using a local dma WRITE channel
> to transfer from local memory to remote memory. A WRITE channel would be
> employed on the local device in order to move the contents of local memory
> to the bus destined for remote memory.
> 
> To support local dma initiators, dw_edma_device_transfer() is modified to
> now examine the direction field of struct dma_slave_config for the channel
> which initiators can configure by calling dmaengine_slave_config().
> 
> If direction is configured as either DMA_DEV_TO_MEM or DMA_MEM_TO_DEV,
> local initiator semantics are used. If direction is a value other than
> DMA_DEV_TO_MEM nor DMA_MEM_TO_DEV, then remote initiator semantics are
> used. This should maintain backward compatibility with the original use
> case of dw-edma.
> 
> The dw-edma-test utility is an example of a remote initiator. From reading
> its patch, dw-edma-test does not specifically set the direction field of
> struct dma_slave_config. Since dw_edma_device_transfer() also does not
> check the direction field of struct dma_slave_config, it seems safe to use
> this convention in dw-edma to support both local and remote initiator
> semantics.

Applied, thanks

-- 
~Vinod

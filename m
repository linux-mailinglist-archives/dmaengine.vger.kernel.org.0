Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02530A4A6
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhBAJwl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 04:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232941AbhBAJwj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 04:52:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12F5B64EA6;
        Mon,  1 Feb 2021 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612173104;
        bh=dgOYit+WCLzNdVs6ULIzfObZ6XzUuWxWVV2xTXISoXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJLzOByIvhVO9dIHOX4ktAgKTAAXq/8km6MbWFypkgb/k5Iv/sZ1RfPcdNDcS3EGT
         YOPDKTH41Gro6MS61TXRilBSzdICh4nDEa1q8H9T9WNoV4Vm2CFH4O/G47GOCA+hWk
         A0N2W+/CmBburf26BvQHngyblguei21XB5oWDRWcSa1AOHwf4HQ3vUCJHJMZI9hDRe
         aSMJl79ecrzHTwkzTnEO2tAfOWE1velliyRtY6JxdAx7GL5Y27EmUvwrX+R5ZAsxx8
         EsxLVSqDmYqtsphrwFntaIwdlmOwSSTRX8481lDWL99wDAa8wtwQLKACDP+KrMMHQF
         vugBtonQHT3PA==
Date:   Mon, 1 Feb 2021 15:21:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 00/17] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Message-ID: <20210201095139.GO2771@vkoul-mobl>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-01-21, 09:32, Sia Jee Heng wrote:
> The below patch series are to support AxiDMA running on Intel KeemBay SoC.
> The base driver is dw-axi-dmac. This driver only support DMA memory copy transfers.
> Code refactoring is needed so that additional features can be supported.
> The features added in this patch series are:
> - Replacing Linked List with virtual descriptor management.
> - Remove unrelated hw desc stuff from dma memory pool.
> - Manage dma memory pool alloc/destroy based on channel activity.
> - Support dmaengine device_sync() callback.
> - Support dmaengine device_config().
> - Support dmaengine device_prep_slave_sg().
> - Support dmaengine device_prep_dma_cyclic().
> - Support of_dma_controller_register().
> - Support burst residue granularity.
> - Support Intel KeemBay AxiDMA registers.
> - Support Intel KeemBay AxiDMA device handshake.
> - Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
> - Add constraint to Max segment size.
> - Virtually split the linked-list.

Applied, thanks

-- 
~Vinod

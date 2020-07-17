Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5F22336E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 08:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGQGLZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 02:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGLY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Jul 2020 02:11:24 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568042071A;
        Fri, 17 Jul 2020 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594966284;
        bh=ByxbXOjxP3K7mnchGy8x9Qk3bXjHxrtZYNnrd7xmXYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcJoXjn831pGjMOaL1ud6YImKLHAuDk3HEeSkR3Z+zC+AsYqR//EE0x7u4177+tf8
         hdCQfwqQuQS6UNvdeetJBSG24t/MoU3WNvDvszw2Ma2IEKJ7clSoR6IAxhladaa44a
         1sDs42MYDuLQ1JmNgaK2c0H6DgQQWdiXY5AmBT7c=
Date:   Fri, 17 Jul 2020 11:41:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v7 0/5] dma: Add Xilinx ZynqMP DPDMA driver
Message-ID: <20200717061120.GE82923@vkoul-mobl>
References: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-20, 04:33, Laurent Pinchart wrote:
> Hello,
> 
> This patch series adds a new driver for the DPDMA engine found in the
> Xilinx ZynqMP.
> 
> The previous version can be found at [1]. All review comments have been
> taken into account. The main changes are in the DPDMA driver, with
> cleanups in the debugfs support, and handling of the !LOAD_EOT case when
> preparing transactions.
> 
> The driver has been successfully tested with the ZynqMP DisplayPort
> subsystem DRM driver.
> 
> As I would like to merge both this series and the DRM driver that
> depends on it for v5.9 (if still possible), I have based those patches
> on top of v5.8-rc1. There's unfortunately a conflict with the DMA engine
> next branch, which is easy to resolve.
> 
> Vinod, if you're fine with the series, I can propose two ways forward:
> 
> - You can apply the patches on top of v5.8-rc1, push that to a base
>   branch, merge it into the dmaengine -next branch, and push the base
>   branch to a public git tree to let me base the DRM driver on it.

Applied 1-3 to dmaengine.git topic/xilinx, it should show up in -next
later in the day

Thanks
-- 
~Vinod

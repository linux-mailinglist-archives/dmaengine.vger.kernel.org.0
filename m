Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3319316AC3D
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgBXQyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 11:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXQyD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 11:54:03 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBFD920836;
        Mon, 24 Feb 2020 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582563242;
        bh=byy7hCZafPpLH8/tx/qwBqiyJfY1p33yc7vFxlR1K+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZ0CQkrZc5F5qwpa5cShXPZQyAdst36hSPNZkja14vyc13yuTVXghEL0MrZz2CkGQ
         xX4adrmu9TQ8oKza7lV7Mtb+/rZGbalBo4NkkzZGnzCWXycdrEiGOBi/W0l4eaFvhi
         tC5xGVH3H7JpVARs4TucCgc0fHC/MSwNGe2adyPc=
Date:   Mon, 24 Feb 2020 22:23:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH v2 -next] dmaengine: xilinx_dma: Reset DMA channel in
 dma_terminate_all
Message-ID: <20200224165357.GD2618@vkoul-mobl>
References: <1580283909-32678-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580283909-32678-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-01-20, 13:15, Radhey Shyam Pandey wrote:
> Reset DMA channel after stop to ensure that pending transfers and FIFOs
> in the datapath are flushed or completed. It also cleanup the terminate
> path and removes stop for the cyclic mode as after the reset stop is not
> required. This fixes intermittent data verification failure when xilinx
> dma test the client is stressed and loaded/unloaded multiple times.

Applied, thanks

-- 
~Vinod

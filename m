Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EACFBEB3
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 05:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKNEuK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Nov 2019 23:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfKNEuK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Nov 2019 23:50:10 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76220206E6;
        Thu, 14 Nov 2019 04:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573707009;
        bh=xbAq9j7hJzH7wDaa4XbHSay9kwZs9UcP2SsD8mxpQKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1kDTSHp4uIO9ksVm/bF9uMnqg7QH2t8l2HNkBev6PvDZ7NMahDuly3D8CZ+JXjqO
         ihfqCG0GsIQGRT2ozs9MGlCVWu5lZjjR1qmvUETwT1txIf/RgRfrriZOGpT+7/7r4u
         /uAjjkqeYaQYq1Xxs0IeCSA7jYdQ1++exGTizMN8=
Date:   Thu, 14 Nov 2019 10:20:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        baolin.wang7@gmail.com
Subject: Re: [PATCH] dmaengine: sprd: Add wrap address support for link-list
 mode
Message-ID: <20191114045005.GI952516@vkoul-mobl>
References: <85a5484bc1f3dd53ce6f92700ad8b35f30a0b096.1571812029.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a5484bc1f3dd53ce6f92700ad8b35f30a0b096.1571812029.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-10-19, 14:31, Baolin Wang wrote:
> From: Eric Long <eric.long@unisoc.com>
> 
> The Spreadtrum Audio compress offload mode will use 2-stage DMA transfer
> to save power. That means we can request 2 dma channels, one for source
> channel, and another one for destination channel. Once the source channel's
> transaction is done, it will trigger the destination channel's transaction
> automatically by hardware signal.
> 
> In this case, the source channel will transfer data from IRAM buffer to
> the DSP fifo to decoding/encoding, once IRAM buffer is empty by transferring
> done, the destination channel will start to transfer data from DDR buffer
> to IRAM buffer. Since the destination channel will use link-list mode to
> fill the IRAM data, and IRAM buffer is allocated by 32K, and DDR buffer
> is larger to 2M, that means we need lots of link-list nodes to do a cyclic
> transfer, instead wasting lots of link-list memory, we can use wrap address
> support to reduce link-list node number, which means when the transfer
> address reaches the wrap address, the transfer address will jump to the
> wrap_to address specified by wrap_to register, and only 2 link-list nodes
> can do a cyclic transfer to transfer data from DDR to IRAM.
> 
> Thus this patch adds wrap address to support this case.

This fails to apply, can you please rebase and resend!

Thanks
-- 
~Vinod

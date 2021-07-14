Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90BF3C7DD5
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 07:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhGNFM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 01:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNFM4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 01:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F986128B;
        Wed, 14 Jul 2021 05:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626239406;
        bh=t8bL81gRFQESqYmW8xNb7ypHYtyV4k0LDE0X2Ub+GQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phEm6F7yJsYoP1BQU0fdY4vF5xPLpPC+WfCOVclleTzkrn/zh7EUGivumhikG8FsD
         Pqf1c5Eb4U1Q8Aqqi64cKK1ZQdeJaCVDdJ18CYo9FUGfctTQBSAehXR9MPy4wm7sVu
         iG3I3qtxbdMoYsbCK4N4BJO80NcjzOSQ78CpJeWNechmjP3Kf0FBFcvuerpGCmLJSO
         Y1d+Fb8QpcL4PUTC4AW+eEQgw/O0NK6GqpBaMcGkq7XZX7J4pNTnvknWWKYB/jJmN4
         fC51x02lMRJyl/B3NdLZltHY2O8IwX40gp5z8csh3S1JmUXZaKkKIW98IbpGnFtcg6
         zapniH5eps49g==
Date:   Wed, 14 Jul 2021 10:40:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
Cc:     dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] xilinx_dma: Fix read-after-free bug when terminating
 transfers
Message-ID: <YO5xqrys1az1UDeP@matsya>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20210706234338.7696-3-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706234338.7696-3-adrian.martinezlarumbe@imgtec.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-07-21, 00:43, Adrian Larumbe wrote:
> When user calls dmaengine_terminate_sync, the driver will clean up any
> remaining descriptors for all the pending or active transfers that had
> previously been submitted. However, this might happen whilst the tasklet is
> invoking the DMA callback for the last finished transfer, so by the time it
> returns and takes over the channel's spinlock, the list of completed
> descriptors it was traversing is no longer valid. This leads to a
> read-after-free situation.
> 
> Fix it by signalling whether a user-triggered termination has happened by
> means of a boolean variable.

Applied after adding subsystem name, thanks

-- 
~Vinod

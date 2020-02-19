Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF3163DD9
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2020 08:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgBSHjg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Feb 2020 02:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSHjg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:36 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E46208E4;
        Wed, 19 Feb 2020 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582097975;
        bh=KIEXxX4jEJNPFYhU5xWr7O+78iRlS7JsDPszV/HDTEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsZ+BCR82tcyYc4ynfONnsUmrFGHOqTp+kYKtG2Tc4RMtjWj4+egICQcQKhPZUXBl
         yWGt+REwNyTuwH57j7D97TIZ61cQknHNl+cscexYGXg+Dj2ePE/M5m+n5EWR4qDu39
         JrRdJY1qO3wozgWOM6lF8XfvFflvqE/BIxT3L2l4=
Date:   Wed, 19 Feb 2020 13:09:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v2 0/6] dmaengine: ti: k3-udma: Fixes for 5.6
Message-ID: <20200219073930.GD2618@vkoul-mobl>
References: <20200214091441.27535-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214091441.27535-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-02-20, 11:14, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> Recently we have uncovered silicon and driver issues which was not addressed in
> the initial driver:
> 
> 1. RX channel teardown will lock up the channel if we have stale data
> in the DMA FIFOs and we don't have active transfer (no descriptor for UDMA).
> The workaround is to use a dummy drain packet in these cases.
> 
> 2. Early TX completion handling
> The delayed work approach was not working efficiently causing the UART, SPI
> performance to degrade, with the patch from Vignesh we see 10x performance
> increase
> 
> 3. TR setup for slave_sg
> It was possible that the sg_len() was not multiple of 'burst * dev_width' and
> because of this we ended up with incorrect TR setups.
> Using a single function for TR setup makes things simpler and error prone among
> slave_sg, cyclic and memcpy
> 
> 4. Pause/Resume causes kernel crash
> if it was called when we did not had active transfer the uc->desc was NULL.
> 
> 5. The terminated cookie was never marked as completed
> client will think that it is still in progress, which is not the case.
> Also adding back the check for running channel in tx_status since if the channel
> is not running then it implies that it has been terminated, so no transfer is
> running.

Applied to fixes

Thanks

-- 
~Vinod

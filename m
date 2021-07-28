Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18EB3D889D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhG1HMX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhG1HMX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C66060F0F;
        Wed, 28 Jul 2021 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627456342;
        bh=iMvhET50/bGdhMyxG8vbSsorMy/0jrvOPd5iwP0GAoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccXN74JDL/v6FIZxfjFuTE6yafTxFqw2/qEdFjDFCsLED7psxQXeWJUgIBvE5QUC9
         5JuN2TuiexCN/YM6pPO6++fEFJeETHr5XUR9Yzvfxit0chQGYDVrgMbu6ffYZuH62a
         7pYjp/2OD2MBs1aIMDpzAw5JDgLu8ZnCwo1cx+2Sk4AWPh0LZrMi7O6LcOstsfncW9
         aXibNcYryXTcEVNFwrGSRoSJO660vGOUUvaaSpSghr9i3tMxqIXq1649Sbo3Y/0Pbm
         PDQAhjYSnt+PaOUcdkW/lbQ6KBSBjuCHg0U3ZZMAxXETgtbqlmbNQXNOx4DQxxB3Or
         EpsN7sl+r+GgQ==
Date:   Wed, 28 Jul 2021 12:42:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com
Subject: Re: [PATCH] dmaengine: of-dma: router_xlate to return -EPROBE_DEFER
 if controller is not yet available
Message-ID: <YQEDUkY3BHV2OqRR@matsya>
References: <20210717190021.21897-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717190021.21897-1-peter.ujfalusi@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-21, 22:00, Peter Ujfalusi wrote:
> If the router_xlate can not find the controller in the available DMA
> devices then it should return with -EPORBE_DEFER in a same way as the
> of_dma_request_slave_channel() does.
> 
> The issue can be reproduced if the event router is registered before the
> DMA controller itself and a driver would request for a channel before the
> controller is registered.
> In of_dma_request_slave_channel():
> 1. of_dma_find_controller() would find the dma_router
> 2. ofdma->of_dma_xlate() would fail and returned NULL
> 3. -ENODEV is returned as error code
> 
> with this patch we would return in this case the correct -EPROBE_DEFER and
> the client can try to request the channel later.

Applied, thanks

-- 
~Vinod

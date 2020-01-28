Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4B14B3BF
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 12:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1LuL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 06:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgA1LuL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Jan 2020 06:50:11 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C9F214AF;
        Tue, 28 Jan 2020 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580212210;
        bh=jW6H9OlD/jgob7HlVx2GQo9Y2WJ5ofqdPX2DH4cN0ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2cb1YugqwH2Kyc7TSXkHPyGqa4SajqkS1G/5EzKpQt0ER0jWrgg8B8kx41irg/+P
         BmEt88S8IfoSTGx/NcGkJg+nkUDwnlrAk26uaXIsT0nysYKSUK6RZBdYlykEVlKYRt
         KA1+RCXSefrCA4DP2Z8kNYqDDPctG8DwSf0SHbPk=
Date:   Tue, 28 Jan 2020 17:20:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com, vigneshr@ti.com
Subject: Re: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
Message-ID: <20200128115006.GT2841@vkoul-mobl>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-20, 12:15, Peter Ujfalusi wrote:
> Vinod,
> 
> On 27/01/2020 15.21, Peter Ujfalusi wrote:
> > Hi Vinod,
> > 
> > Based on customer reports we have identified two issues with the UDMA driver:
> > 
> > TX completion (1st patch):
> > The scheduled work based workaround for checking for completion worked well for
> > UART, but it had significant impact on SPI performance.
> > The underlying issue is coming from the fact that we have split data movement
> > architecture.
> > In order to know that the transfer is really done we need to check the remote
> > end's (PDMA) byte counter.
> > 
> > RX channel teardown with stale data in PDMA (2nd patch):
> > If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
> > data is might received from a peripheral, but if UDMA does not have a packet to
> > use for this draining than it is going to push back on the PDMA and the flush
> > will never completes.
> > The workaround is to use a dummy descriptor for flush purposes when the channel
> > is terminated and we did not have active transfer (no descriptor for UDMA).
> > This allows UDMA to drain the data and the teardown can complete.
> > 
> > The last two patch is to use common code to set up the TR parameters for
> > slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
> > with the change we can handle 4.2GB sg elements and periods in case of cyclic.
> > It is also nice that we have single function to do the configuration.
> 
> I have marked these patches as for-next as 5.5 was not released yet.
> Would it be possible to have these as fixes for 5.6?

Sure but are they really fixes, why cant they go for next release :)

They seem to improve things for sure, but do we want to call them as
fixes..?

-- 
~Vinod

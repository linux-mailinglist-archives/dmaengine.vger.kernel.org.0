Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F922AED1
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0Gjh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE0Gjg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:39:36 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD6A2054F;
        Mon, 27 May 2019 06:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558939176;
        bh=JT4KTsrIWgsbKhkPbSLThrwY2+w4AOrCa0jWApt18+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xP5ZOf0b4QiCw7NzBzQbzedrrWapYQKtZu//RoV7n6FD1I16KTQuswyZBWZHiHBHT
         I/lzbXFeC9Gg60JZUSxntpdJbi/m5DTKF71SwHwsE6GxgHiwQ0EADV5P8TMPINwCub
         zrbrDDzMTqbdN5dpVnFhfGWQ6DH6rrEbfQi4B2p0=
Date:   Mon, 27 May 2019 12:09:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dmaengine: ti: edma: Polled completion support
Message-ID: <20190527063932.GE15118@vkoul-mobl>
References: <20190521093646.21836-1-peter.ujfalusi@ti.com>
 <19b0d346-5249-e832-8eea-685c8e7706e2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b0d346-5249-e832-8eea-685c8e7706e2@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-19, 13:57, Peter Ujfalusi wrote:
> Vinod,
> 
> On 21/05/2019 12.36, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Changes since v2:
> > - Fix typo in the comment for patch 0
> > 
> > Changes since v1:
> > - Cleanup patch for the array register handling
> > - typo fixed in patch2 commit message
> > 
> > The code around the array register access was pretty confusing for the first
> > look, so clean them up first then use the cleaner way in the polled handling.
> > 
> > When a DMA client driver decides that it is not providing callback for
> > completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
> > it will poll the status of the transfer (in case of short memcpy for
> > example) we will not get interrupt for the completion of the transfer and
> > will not mark the transaction as done.
> > 
> > Check the event registers (ER and EER) and if the channel is inactive then
> > return wioth DMA_COMPLETE to let the client know that the transfer is
> > completed.
> 
> Please do not pick this up yet, I got report that it might cause side
> effect which I need to debug to understand.

OK dropped for queue

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A851D3916
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENS2E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 May 2020 14:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgENS2E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 May 2020 14:28:04 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462C62054F;
        Thu, 14 May 2020 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589480884;
        bh=IJ4hFZiqwGvf87PMadQdgP9uSiu4rcBcBLlDJAVJ62Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXXEvD46YIcvnij6/xTmbOaf1GMFpP9Yo2KduvLoeCC0HdIehZMr5HHoHIlieiysQ
         nPhZodFP8pECwFe2sbgbIwbmBI2gWs5AnVL12CeJuWrblGhGMBgxUMKLg0GMVaGidk
         9dMdO0bgV94tKjYsHEYzdZR0Z7142B5ziy13j4OM=
Date:   Thu, 14 May 2020 23:57:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v1 1/9] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200514182750.GJ14092@vkoul-mobl>
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589472657-3930-2-git-send-email-amittomer25@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-05-20, 21:40, Amit Singh Tomar wrote:
> At the moment, Driver uses bit fields to describe registers of the DMA
> descriptor structure that makes it less portable and maintainable, and
> Andre suugested(and even sketched important bits for it) to make use of
> array to describe this DMA descriptors instead. It gives the flexibility
> while extending support for other platform such as Actions S700.
> 
> This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> uses array to describe DMA descriptor.

So i see patch 1/9 and 2/9 in my inbox... where are the rest ? No cover
to detail out what the rest contains, who should merge them etc etc!

If you are sending a series to different subsystem please make a habit
to CC everyone on cover letter so that we understand details about the
series. If not dependent, just send as individual units to subsystems!

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646E778662
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2Hed (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 03:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2Hec (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 03:34:32 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F62216C8;
        Mon, 29 Jul 2019 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564385671;
        bh=t9LsxbTH4MpBJFWH0d4fER/3hJuiJvavkL6v8Hy/LVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDCAi84qIn4/Ux74deqn5LHJcGwjCrnLKaVJpn7EYNWaU92guoMzx37Vcdua72l7v
         9KHbGzFgTN5M7Yj41gOsKfTma6DngePMAHQAliKx4QBoRnelDRdfvV/B5jPyEUjFLy
         KNTqe09gJWMBo/SIcTdKS3+dLAx55mY37Jj/IEkg=
Date:   Mon, 29 Jul 2019 13:03:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 0/3] dmaengine: ti: edma: Polled completion support
Message-ID: <20190729073319.GK12733@vkoul-mobl.Dlink>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
 <20190729064209.GF12733@vkoul-mobl.Dlink>
 <fe201b5b-916d-1889-31b0-dcac20733b65@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe201b5b-916d-1889-31b0-dcac20733b65@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-19, 10:24, Peter Ujfalusi wrote:
> Vinod,
> 
> On 29/07/2019 9.42, Vinod Koul wrote:
> > On 16-07-19, 11:26, Peter Ujfalusi wrote:
> >> Hi,
> >>
> >> Changes since v4:
> >> - Split the DMA_COMPLETE and !txstate check as Vinod suggested
> >>
> >> Change since v3:
> >> - fix DMA pointer tracking for memcpy
> >> - completion polling is only done when it is asked by not providing
> >>   DMA_PREP_INTERRUPT for memcpy
> >>
> >> Changes since v2:
> >> - Fix typo in the comment for patch 0
> >>
> >> Changes since v1:
> >> - Cleanup patch for the array register handling
> >> - typo fixed in patch2 commit message
> >>
> >> The code around the array register access was pretty confusing for the first
> >> look, so clean them up first then use the cleaner way in the polled handling.
> >>
> >> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
> >> does not want to use interrupts for DMA completion or because it can not
> >> rely on DMA interrupts due to executing the memcpy when interrupts are
> >> disabled it will poll the status of the transfer.
> >>
> >> Since we can not tell from any EDMA register that the transfer is
> >> completed, we can only know that the paRAM set has been sent to TPTC for
> >> processing we need to check the residue of the transfer, if it is 0 then
> >> the transfer is completed.
> >>
> >> The polled completion can bve tested by applying:
> >> https://patchwork.kernel.org/patch/10966499/
> 
> Should I resend this patch so the polled mode can be tested in upstream?

Yes sure

-- 
~Vinod

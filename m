Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253EA1C31FE
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgEDFAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgEDFAH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:00:07 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A092B206EB;
        Mon,  4 May 2020 05:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588568407;
        bh=Sqc/o6T+nFXemlcgmHtEKzYmFketuc1fqMA+mAYUeDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh/tZLGNy9PXS1axw9ThF1Bu2U1hXjRht+1LYX3q+T2LIeI+WgJbw8jtUhyWEgaKS
         AbWfBefqHzR8MFRhh3GQeG+cDfP3op4FsS39CkC2WLQ3NEcNPeBnMNRKpAnZnRUxZK
         4HkDPuptej2x4y2OCE1Bm2sPGzOlVgyrDMCwiD1s=
Date:   Mon, 4 May 2020 10:30:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dma: actions: Fix lockdep splat for owl-dma
Message-ID: <20200504050001.GC1375924@vkoul-mobl>
References: <2f3e665270b8d170ea19cc66c6f0c68bf8fe97ff.1588173497.git.cristian.ciocaltea@gmail.com>
 <20200502122333.GA1375924@vkoul-mobl>
 <20200502173500.GA7621@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502173500.GA7621@BV030612LT>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cristian,

On 02-05-20, 20:35, Cristian Ciocaltea wrote:
> On Sat, May 02, 2020 at 05:53:33PM +0530, Vinod Koul wrote:
> > Hi Cristian,
> > 
> > On 29-04-20, 18:28, Cristian Ciocaltea wrote:
> > > When the kernel is built with lockdep support and the owl-dma driver is
> > > used, the following message is shown:
> > 
> > First the patch title needs upate, we describe the patch in the title
> > and not the cause. So use correct lock, or use od lock might be better
> > titles, pls revise.
> > 
> > Second, the susbsystem is named dmaengine:... not dma:.. You can always
> > check that by using git log on the respective file
> > 
> > Pls do add fixes and further acks received on next iteration.
> >
> 
> Hi Vinod,
> 
> Thank you for reviewing and sorry for the mistakes! I'll be more careful
> next time with all those details.

No issues, we do learn a bit everytime :)
> 
> I've submitted the updated patch: [PATCH v4 1/1] dmaengine: owl: Use
> correct lock in owl_dma_get_pchan()

Thanks

-- 
~Vinod

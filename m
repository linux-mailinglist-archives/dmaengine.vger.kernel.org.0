Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF546E06F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jul 2019 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfGSFGN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jul 2019 01:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfGSFGM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Jul 2019 01:06:12 -0400
Received: from localhost (unknown [49.207.58.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74F12082F;
        Fri, 19 Jul 2019 05:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563512771;
        bh=psl4jjNZDQaZ36V6nEf1qHJEUDJyLtVzshme/46dQbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+e5fIAG1af0gZlQk28PSXyzpSXtFZ9lrE9Q5asIftPmY155IQtBE69R+HAf+XaF1
         2/jrPwV5xA/Vr5R9UUqKlypbs7RoDmMNp/M5K+LisC/e3UkcSlgv+krgMm7Hg64iMR
         yzZaWhh4GTnFTS7xBtal8p17P0Vv02imtunpNU5c=
Date:   Fri, 19 Jul 2019 10:34:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, tiwai@suse.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190719050459.GM12733@vkoul-mobl.Dlink>
References: <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-19, 11:45, Sameer Pujar wrote:
> Hi Vinod,
> 
> What are your final thoughts regarding this?

Hi sameer,

Sorry for the delay in replying

On this, I am inclined to think that dma driver should not be involved.
The ADMAIF needs this configuration and we should take the path of
dma_router for this piece and add features like this to it

> 
> Thanks,
> Sameer.
> 
> > > Where does ADMAIF driver reside in kernel, who configures it for normal
> > > dma txns..?
> > Not yet, we are in the process of upstreaming ADMAIF driver.
> > To describe briefly, audio subsystem is using ALSA SoC(ASoC) layer.
> > ADMAIF is
> > registered as platform driver and exports DMA functionality. It
> > registers PCM
> > devices for each Rx/Tx ADMAIF channel. During PCM playback/capture
> > operations,
> > ALSA callbacks configure DMA channel using API dmaengine_slave_config().
> > RFC patch proposed, is to help populate FIFO_SIZE value as well during
> > above
> > call, since ADMA requires it.
> > > 
> > > Also it wold have helped the long discussion if that part was made clear
> > > rather than talking about peripheral all this time :(
> > Thought it was clear, though should have avoided using 'peripheral' in
> > the
> > discussions. Sorry for the confusion.

-- 
~Vinod

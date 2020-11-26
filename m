Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14662C4E19
	for <lists+dmaengine@lfdr.de>; Thu, 26 Nov 2020 05:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgKZEuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Nov 2020 23:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387684AbgKZEuk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Nov 2020 23:50:40 -0500
Received: from localhost (unknown [122.179.79.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010B82145D;
        Thu, 26 Nov 2020 04:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606366240;
        bh=t8TaVfhJXLJs3qX8q4hwu4FUKcPn1ZUAgVG39jnLMz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rg0nz22TB9YyMCDBgxlFqiZLPKGX10kdP0XYWmwet/TPpJtqXhzMhdTgcp27DaVEC
         0Ji/jqmGLa2v5ojhaN6fRc/NktWSsxjGlzBD2JamDl7MnhUjEgXrq7PDKDD2cPaRLA
         o1sa+aiWI273/Q5t2Fho8Wb7Vjb1OlAOVXk43Xo4=
Date:   Thu, 26 Nov 2020 10:20:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: Re: [PATCH v9 2/2] Add Intel LGM SoC DMA support.
Message-ID: <20201126045035.GI8403@vkoul-mobl>
References: <cover.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <67be905aa3bcb9faac424f2a134e88d076700419.1605158930.git.mallikarjunax.reddy@linux.intel.com>
 <20201118173840.GW50232@vkoul-mobl>
 <a4ea240f-b121-5bc9-a046-95bbcff87553@linux.intel.com>
 <20201121121701.GB8403@vkoul-mobl>
 <dc8c5f27-bce6-d276-af0b-93c6e63e85a1@linux.intel.com>
 <20201124172149.GT8403@vkoul-mobl>
 <ee275d37-5dda-205a-a897-7a61ad13b536@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee275d37-5dda-205a-a897-7a61ad13b536@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-11-20, 18:39, Reddy, MallikarjunaX wrote:

> > > > > desc needs to be configure for each dma channel and the remapped address of
> > > > > the IGP & EGP is desc base adress.
> > > > Why should this address not passed as src_addr/dst_addr?
> > > src_addr/dst_addr is the data pointer. Data pointer indicates address
> > > pointer of data buffer.
> > > 
> > > ldma_chan_desc_cfg() carries the descriptor address.
> > > 
> > > The descriptor list entry contains the data pointer, which points to the
> > > data section in the memory.
> > > 
> > > So we should not use src_addr/dst_addr as desc base address.
> > Okay sounds reasonable. why is this using in API here?
> descriptor base address needs to be write into the dma register (DMA_CDBA).

Why cant descriptor be allocated by damenegine driver, passed to client
as we normally do in prep_* callbacks ? Why do you need a custom API

-- 
~Vinod

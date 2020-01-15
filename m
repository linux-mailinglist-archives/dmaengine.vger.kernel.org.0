Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668A213C508
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgAOOLq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 09:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAOOLp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jan 2020 09:11:45 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339B32084D;
        Wed, 15 Jan 2020 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579097505;
        bh=Lcn/3JXRT9leGkM+woSFiZsmGmI7WadMtQurMVoVrxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2CAg5h8CH5nMgIJfn59IYcPUAYKiioGtfJj/nb4onCgctlqK11w8V2RpfrEp2pMgr
         dau1xZFWZoMnh8MWpB/FnDj6dyRdOU24sLnw4skLnZpyVDO6OS2lLD+4FwMP1dxzOI
         PT9L1eKhsnTQgcCBxMyZ1z4RkD1EE7GC7OjghFpo=
Date:   Wed, 15 Jan 2020 19:41:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jiasen Lin <linjiasen@hygon.cn>, Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH v3 0/3]  PLX Switch DMA Engine Driver
Message-ID: <20200115141124.GL2818@vkoul-mobl>
References: <20200103212021.2881-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103212021.2881-1-logang@deltatee.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-01-20, 14:20, Logan Gunthorpe wrote:
> This is v3 of the patchset. The in-use unbind bits have been sent and
> accepted as a separate patch set. This patchset just includes the new
> driver which has been updated to use the common reference counting.
> 
> This patchset is based off of vkoul/slave-dma.git/next and a git branch is
> available here:
> 
> https://github.com/sbates130272/linux-p2pmem/ plx-dma-v3

Applied all, thanks, apologies for delay!

-- 
~Vinod

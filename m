Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92C9369300
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 15:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhDWNZk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 09:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238784AbhDWNZj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 09:25:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 575FB613C8;
        Fri, 23 Apr 2021 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619184303;
        bh=h1qY378UMQdddxG9UZ6KBaWxcknWZJ3Q+JYiQACCZFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kywQkQZPg2x4C0fM82+FM8X+MMdsm332yVNP3DX5CFaxfXXLNPFp+8pYDoSUuEeOA
         JZ7mLesloIiNcotMujf8LqvTDyKsOWuDTGT5/1Ev4xjGNCszISFAb9j99eO9WbkrUL
         RE2QpIRmI5qt+DKtW+W4hJtWuGRDK/kcvAVPCaUP5DU70IPg1EfMhmhEOXsbIYtQnI
         mItjZAK5/OEIDgPe5ARwsqCcEjRp4q+niQ+l+BHZBiYFHzTtQ38A87kDlFq0Nbn7V3
         apm6M2gfjoDw28ax64pRSrYZSjsbzxnUx4FaOCjbqX5Y3mBOvAtaUK/o3MWl70cNwA
         Nf9hdS025bt0w==
Date:   Fri, 23 Apr 2021 18:54:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Expand Xilinx CDMA functions
Message-ID: <YILKq+jNZZSs37xa@vkoul-mobl.Dlink>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
 <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2876f2c-beb2-f159-9b61-d69ae6b8275a@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-21, 11:17, Lars-Peter Clausen wrote:
> 
> It seems to me what we are missing from the DMAengine API is the equivalent
> of device_prep_dma_memcpy() that is able to take SG lists. There is already
> a memset_sg, it should be possible to add something similar for memcpy.

You mean something like dmaengine_prep_dma_sg() which was removed?

static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
               struct dma_chan *chan,
               struct scatterlist *dst_sg, unsigned int dst_nents,
               struct scatterlist *src_sg, unsigned int src_nents,
               unsigned long flags)

The problem with this API is that it would work only when src_sg and
dst_sg is of similar nature, if not then how should one go about
copying...should we fill without a care for dst_sg being different than
src_sg as long as total data to be copied has enough space in dst...

We can always add this back if we have in-kernel user but the semantics
of the API needs to be thought thru

Thanks
-- 
~Vinod

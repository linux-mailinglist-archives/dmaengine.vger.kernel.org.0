Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CDF24752
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfEUFJa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfEUFJa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:09:30 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93AA21743;
        Tue, 21 May 2019 05:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558415369;
        bh=xP1xvBpudzfyHGSbZ8VGYTeUcTRCa9wyjvuakbLPV8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKFLAsq71fNaW+HnVwHRCzAs9YNI0XjjhmYRiopdaZp9J+Z3aRwTjMIQ4ghjlI+Ow
         MetyBCPLP6QP0iukhLAAlv5flx2i1egoK/S1hf6MenTXy5YJEVm9rQeqIX2g4hekxc
         yiUGKwjoWw6YOuz1YD8G0k26KU3Mrm/uCWd8jDbE=
Date:   Tue, 21 May 2019 10:39:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        fan.du@intel.com
Subject: Re: [PATCH] dmaengine: ioatdma: fix unprotected timer deletion
Message-ID: <20190521050925.GW15118@vkoul-mobl>
References: <155744504539.8006.16459393524018173816.stgit@djiang5-desk3.ch.intel.com>
 <f80ae09d-82f3-e395-f797-afd79381ce36@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80ae09d-82f3-e395-f797-afd79381ce36@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-05-19, 09:11, Dave Jiang wrote:
> 
> 
> On 5/9/19 4:37 PM, Dave Jiang wrote:
> > When ioat_free_chan_resources() gets called, ioat_stop() is called without
> > chan->cleanup_lock. ioat_stop modifies IOAT_RUN bit.  It needs to be
> > protected by cleanup_lock. Also, in the __cleanup() path, if IOAT_RUN is
> > cleared, we should not touch the timer again. We observed that the timer
> > routine was run after timer was deleted.
> > 
> > Fixes: 3372de5813e ("dmaengine: ioatdma: removal of dma_v3.c and relevant ioat3
> > references")
> > 
> > Reported-by: Fan Du <fan.du@intel.com>
> > Tested-by: Fan Du <fan.du@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Vinod, can you hold off on this please? There may be more changes. Thanks.

Okay dropped

-- 
~Vinod

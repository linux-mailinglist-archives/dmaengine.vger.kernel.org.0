Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D333E2BDA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhHFNqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244024AbhHFNqc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C189606A5;
        Fri,  6 Aug 2021 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257576;
        bh=v4oRscgS3N4hs+5TMCziPGustcUd7osAZoeBDMsr1JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViDxJXX/Av8gC/lobj/M5oD8Ts2OWHV6tBzKRjIEyRIIWqXBw60wcjkyRDX8ITiQs
         xzPE921By4H0fbl7SZ/d8IpFlgX4+dXNs+TQu9jx5tRiQ5MVoLLWLKPVvOCceqZaTQ
         h/narBRmrIjQmKRc+1OL12vwjtJeiZiY0fWs9dBLa9ujdHBrM0eYNGFJMA8S8YTz7K
         WqYOsirp/o98U5FVPvJrUfoI/yabn2uv/ZkJEhFD3/dGsJ3H3bc0T/M8kzXv1JOsgY
         GKTVbC1j7n0Vg5HcldQpDSfErSYvzt0IypD6x0cSDZFUgZYgctPzmFDYtIYiSb8FI5
         KagvxrYySBGFw==
Date:   Fri, 6 Aug 2021 19:16:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Remove unused status variable in
 irq_process_work_list()
Message-ID: <YQ09JPrmNHDJTUMN@matsya>
References: <20210802175820.3153920-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802175820.3153920-1-nathan@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-21, 10:58, Nathan Chancellor wrote:
> status is no longer used within this block:
> 
> drivers/dma/idxd/irq.c:255:6: warning: unused variable 'status'
> [-Wunused-variable]
>                 u8 status = desc->completion->status & DSA_COMP_STATUS_MASK;
>                    ^
> 1 warning generated.

Applied, thanks

-- 
~Vinod

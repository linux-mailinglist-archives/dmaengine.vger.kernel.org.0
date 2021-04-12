Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE735C27F
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhDLJpU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241169AbhDLJhO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:37:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E057F61245;
        Mon, 12 Apr 2021 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220210;
        bh=4ZsdKcat8lLSa2EXVUcjSKTmEmymgiIb2x6FsMboVJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgBlzxneLvgrX8ejKkh4Z1Zjs4l8HIRC3HWKcf/FUOMv9n52poTOXoUswgJcXmf/0
         w7IqUcYL5FZVdCoL9AqwzrYOIBNTGYHcMOt0/Kmng9fzIVXMuH5d1IuVZ6Dve2KiwM
         Jg9pGzH64gjewBaCAzbZdNYpYN9OIgCMI1cvWO7I9Nvwpn7VMSOMP5hyJN79ZnUT0R
         BVEdp56F6HnOGkXzVIAcKIgWG2lOd7GhMbTJLUNGkygGYrtxRSrQnUNM9xbxcl8gEz
         XK5uG7T3BT0BZaMDH8qPcYZj5I3sbwQGuJEEI9NGoDW4KTJZ2hhGwIlhFdxr7Zil87
         toHUeCxZ/I0sA==
Date:   Mon, 12 Apr 2021 15:06:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: Fix a double free in dma_async_device_register
Message-ID: <YHQUrpbSIXJ47nXL@vkoul-mobl.Dlink>
References: <20210331014458.3944-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331014458.3944-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-03-21, 18:44, Lv Yunlong wrote:
> In the first list_for_each_entry() macro of dma_async_device_register,
> it gets the chan from list and calls __dma_async_device_channel_register
> (..,chan). We can see that chan->local is allocated by alloc_percpu() and
> it is freed chan->local by free_percpu(chan->local) when
> __dma_async_device_channel_register() failed.
> 
> But after __dma_async_device_channel_register() failed, the caller will
> goto err_out and freed the chan->local in the second time by free_percpu().
> 
> The cause of this problem is forget to set chan->local to NULL when
> chan->local was freed in __dma_async_device_channel_register(). My
> patch sets chan->local to NULL when the callee failed to avoid double free.

Applied after fixing subsystem name, thanks

-- 
~Vinod

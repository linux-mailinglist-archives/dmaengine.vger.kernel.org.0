Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FFB438ECD
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhJYFbq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhJYFbq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0636360E96;
        Mon, 25 Oct 2021 05:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635139764;
        bh=RNpEAPKjIGsSgJtgenLTckvP7qpAQs/vjh5tiQApdNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YS8D4JMz/TXvlbImYJJwHfkyUNjq4WX1Xso4DfAaL3MZN2XMvSLg295E/i3lq+sgT
         vZ0an+S46mcMSnzufqY0SFyHniND/si9wMTCZ9zEvKX8iamhEc+ypgCbWdsQASjNO9
         ALzpOj82Zuu4GV4ww348GvuVizM3j7Fpz4S1dALSLByIjUm9REH24RuMW4WFadBsjw
         lcf3pFR6vbxGH2WQSxAtfsnI48m9rqhN9JK2JcJT9WuA+f8BILu+0OeXiprYmx5gog
         u04WZzzzWRXcnYBuGO6h6RPVrwgC0j1JYDuvv5G20WPxgJekIKWVyuJYGhz4QGyB3C
         z8mj/opcm+neA==
Date:   Mon, 25 Oct 2021 10:59:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: cleanup completion record allocation
Message-ID: <YXZAsD5zl0WozjR+@matsya>
References: <163467609628.2417190.1040580236639010770.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163467609628.2417190.1040580236639010770.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-21, 13:41, Dave Jiang wrote:
> According to core-api/dma-api-howto.rst, the address from
> dma_alloc_coherent is gauranteed to align to the smallest PAGE_SIZE order.
> That supercedes the 64B/32B alignment requirement of the completion record.
> Remove alignment adjustment code.

Doesnt apply, i guess needs rebase

-- 
~Vinod

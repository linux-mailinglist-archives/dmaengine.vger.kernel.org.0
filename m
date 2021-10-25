Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41860438E8F
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJYE64 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhJYE64 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB3E360EBC;
        Mon, 25 Oct 2021 04:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635137794;
        bh=X1B+ICbiRhqzBP2zWZyQbDl6LkSgMMFcCEqEj+geXpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gj8/CY658GMo+jxb2wDTctsSYR2DHJsmfPCmcag3XQ8eLFEXiUUC01f9tEWapljJR
         m38e6nKd+xN7D1A41fqZhOXY0Il3SpUcJc4s+rSQMJdXaqfS+B5SARIozwrGhKOLkp
         ptmDD7GU32hTspnnE3Zo6q7147ic9Drr0lJ7YrVos5oGbBqssqJDAxfyegf92zibOj
         pLpi/9DUDe1U+pZVkSh7hH8pMKHiRRmdMsuyuVTzH8UdFSWY7sYVePgAX37Qk7vwp6
         KwK2HL8ywtztQJD2urjETAPVB+yh2Gr90hGt2HJgGMQaRLPNapDviuAERGLpRQSCmc
         Y9w2Q63Le772w==
Date:   Mon, 25 Oct 2021 10:26:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/7] dmaengine: idxd: rework descriptor free path on
 failure
Message-ID: <YXY4/f0gQBtnoBNI@matsya>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
 <163474882126.2608004.7014964789204798071.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163474882126.2608004.7014964789204798071.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-21, 09:53, Dave Jiang wrote:
> Refactor the completion function to allow skipping of descriptor freeing on
> the submission failiure path. This completely removes descriptor freeing

s/failiure/failure

> from the submit failure path and leave the responsibility to the caller.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/dma.c    |   10 ++++++++--
>  drivers/dma/idxd/idxd.h   |    8 +-------
>  drivers/dma/idxd/init.c   |    9 +++------
>  drivers/dma/idxd/irq.c    |    8 ++++----
>  drivers/dma/idxd/submit.c |   12 +++---------
>  5 files changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index c39e9483206a..1ea663215909 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -21,7 +21,8 @@ static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
>  }
>  
>  void idxd_dma_complete_txd(struct idxd_desc *desc,
> -			   enum idxd_complete_type comp_type)
> +			   enum idxd_complete_type comp_type,
> +			   bool free_desc)
>  {
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_result res;
> @@ -44,6 +45,9 @@ void idxd_dma_complete_txd(struct idxd_desc *desc,
>  		tx->callback = NULL;
>  		tx->callback_result = NULL;
>  	}
> +
> +	if (free_desc)
> +		idxd_free_desc(desc->wq, desc);
>  }
>  
>  static void op_flag_setup(unsigned long flags, u32 *desc_flags)
> @@ -153,8 +157,10 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	cookie = dma_cookie_assign(tx);
>  
>  	rc = idxd_submit_desc(wq, desc);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		idxd_free_desc(wq, desc);

if there is an error in submit, should the caller not invoke terminate()
and get the cleanup done?

-- 
~Vinod

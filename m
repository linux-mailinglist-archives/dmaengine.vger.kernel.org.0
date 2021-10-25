Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75B438E02
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhJYEPp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhJYEPp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB46860698;
        Mon, 25 Oct 2021 04:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635135203;
        bh=spEdqPk7FEgiW8zV4Y1ATXHRnvRkc879ieQpA7pKvPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvgTX70kb1hFEjMwOneeyM61XqhN/mL8iIXhADP1GIW+XtrXBqVkhL5SWzM51XMS1
         DZgc5OYld8Ogw9mMW077NuUFX59xvTED4ekWE7lfKWlNUg9hRrfGMHUiuqnUgwkmZa
         XD7fS2BQQfKPc7sIN9zsqkskB/5tcfsOap4IRAwJUCb8yB/v9Yx4y4HgRpLC8U30WM
         hiDDh4KpNqwji4SZ79qcXNjVIVM1RQo5na1xez5glwlFnGkcA/Pu/6yI52HdPtUlCm
         mETDdU709IFcc0QAVQn2lnjLm0i44y9+qK94xYvI1oklPtflUWiEx2ODPc1FvvagJ9
         ZRT944ZLkY4FQ==
Date:   Mon, 25 Oct 2021 09:43:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmaengine_desc_callback_valid(): Check for
 `callback_result`
Message-ID: <YXYu33uHnr5F1NOj@matsya>
References: <20211023134101.28042-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023134101.28042-1-lars@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-10-21, 15:41, Lars-Peter Clausen wrote:
> Before the `callback_result` callback was introduced drivers coded their
> invocation to the callback in a similar way to:
> 
> 	if (cb->callback) {
> 		spin_unlock(&dma->lock);
> 		cb->callback(cb->callback_param);
> 		spin_lock(&dma->lock);
> 	}
> 
> With the introduction of `callback_result` two helpers where introduced to
> transparently handle both types of callbacks. And drivers where updated to
> look like this:
> 
> 	if (dmaengine_desc_callback_valid(cb)) {
> 		spin_unlock(&dma->lock);
> 		dmaengine_desc_callback_invoke(cb, ...);
> 		spin_lock(&dma->lock);
> 	}
> 
> dmaengine_desc_callback_invoke() correctly handles both `callback_result`
> and `callback`. But we forgot to update the dmaengine_desc_callback_valid()
> function to check for `callback_result`. As a result DMA descriptors that
> use the `callback_result` rather than `callback` don't have their callback
> invoked by drivers that follow the pattern above.
> 
> Fix this by checking for both `callback` and `callback_result` in
> dmaengine_desc_callback_valid().

Thanks for the fix, applied now

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C7379366
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhEJQLD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhEJQLC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82C4361026;
        Mon, 10 May 2021 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620662997;
        bh=8CnNw6OpmXW1QdEELhTvJCB2mMH3Jo/KbU3j4WSdLRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mV7yxo5O3CGcKEXfkrx1uidCW9Q+lC/HmIdzsl51Mp0T6pTJVmATVcHJDIIhJrYcc
         vXgGfqBbbciKdiKJ9GmA5ihQC4QdNb2r4Yw73D81nYUfa+3ksuY3qb/iswDDrFYMxH
         h+nerD3VbHocbjlt1JaOnE1kqDbiblkZVVVeTBYOaqowVJ9dEWvzO2gZ7hBzR15xQU
         X+jio5zqQRsvi5ShNPs00dvs1xTg7vbZvlskGYB7IkwqGnYd6U5le/y6tnW3fTeN3K
         znVf5uFjpucVHbNmcqJnYEphOeO9FHKyLRcSZ2lhqGHXVh41cLfH9D/uN+bLlsqGX8
         WbjTno34fbhqw==
Date:   Mon, 10 May 2021 21:39:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bumyong Lee <bumyong.lee@samsung.com>,
        Jongho Park <jongho7.park@samsung.com>
Subject: Re: [PATCH] dmaengine: pl330: fix wrong usage of spinlock flags in
 dma_cyclc
Message-ID: <YJla0egoGXXEVHVa@vkoul-mobl.Dlink>
References: <CGME20210507063730epcas2p3c08de48b052cc7d8dc2805a16cd79361@epcas2p3.samsung.com>
 <20210507063647.111209-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507063647.111209-1-chanho61.park@samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-05-21, 15:36, Chanho Park wrote:
> From: Bumyong Lee <bumyong.lee@samsung.com>
> 
> flags varible which is the input parameter of pl330_prep_dma_cyclic()
> should not be used by spinlock_irq[save/restore] function.

It should mention Fixes. I have added that and cced stable

Thanks

-- 
~Vinod

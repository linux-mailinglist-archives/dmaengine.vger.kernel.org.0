Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB40645897D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 07:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhKVHAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 02:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhKVHAI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 02:00:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3715E60F24;
        Mon, 22 Nov 2021 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637564222;
        bh=j+WE6L/AzcbHD6oVlrySwtSIhpIS05+F8QB1g87jyq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaoGxVUgKrF3svo6hsd5SEqVwgO6DgUQc91iSzYzOiujI08f20X0hRdB0wKSfukgD
         7mQfQCoozchZUh8+v/JD/xIwQDmfUdnXc8fyrbj5lKU1iTt4fRoq5ywssRqfhuXRMT
         XgAyQezNVGko1o5hsKmW5Ok9FfihCuYPQJAY+zriQ9L1E4QTj/Ehe/z9AeknsTt6AU
         hWkqaWglWBrsqcTB6YPy7QDapPjuo6dNH4YWtcTGdh/j4voKF8qnQCYtD7M2DcZmKl
         VNW21HbjMrrJ+zVjhenW6kBypFnpDpVWWN//V8894wMQFaoSxpCNC6O+Owip8Dli3L
         FF167jiu56hQA==
Date:   Mon, 22 Nov 2021 12:26:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gustavo.pimentel@synopsys.com, wangqing@vivo.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Fix (and simplify) the probe broken
 since ecb8c88bd31c
Message-ID: <YZs/OeBJDMc4A4EC@matsya>
References: <935fbb40ae930c5fe87482a41dcb73abf2257973.1636492127.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935fbb40ae930c5fe87482a41dcb73abf2257973.1636492127.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-11-21, 22:09, Christophe JAILLET wrote:
> The commit in the Fixes: tag has changed the logic of the code and now it
> is likely that the probe will return an early success (0), even if not
> completely executed.
> 
> This should lead to a crash or similar issue later on when the code
> accesses to some never allocated resources.
> 
> Change the '!err' into a 'err' when checking if
> 'dma_set_mask_and_coherent()' has failed or not.
> 
> While at it, simplify the code and remove the "can't success code" related
> to 32 DMA mask.
> As stated in [1], 'dma_set_mask_and_coherent(DMA_BIT_MASK(64))' can't fail
> if 'dev->dma_mask' is non-NULL. And if it is NULL, it would fail for the
> same reason when tried with DMA_BIT_MASK(32).

The patch title should describe the changes in the patch and not the
outcome! So I have taken the liberty to update this to:
dmaengine: dw-edma: Fix return value check for dma_set_mask_and_coherent()

-- 
~Vinod

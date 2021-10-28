Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0A43E6F2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJ1RQd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhJ1RQc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9EE610D2;
        Thu, 28 Oct 2021 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441245;
        bh=qV+MbbCtuGobAxJcFO3uBdv6Izo2EmOyEFObwrDhGx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGYNktBa5aEk+2tZnRj2WU9Ciugrj/jWeps3rJInfNqEJaqs6glnbztNvJakltb08
         MAw3If1ffiO0C2hAZzvHUOQpR0uS8dHKedCuDeoBJfw849Hige3znwwL0q9lWYbZ8X
         rVa5cbPVqsImq4VwQidEomGVNhnwFlAjXwXHTzK+gth5aIL2G0B8PqDTdALqgMMISZ
         TAguPC3JiJlMHxMWPo9lyVAiZVTKFqhqGqOfJAYQS3qDlaHf0Q5dHwa/kgf7B1O51D
         XN0I9r2yz6EXLbuXXSKyz0kX/2ZZN+1mXw9mSBSvELLNeyzlK/84CXob/CE34fX2g0
         ECrewkt0pL0Hw==
Date:   Thu, 28 Oct 2021 22:43:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Simplify assignment in
 dma_chan_pause()
Message-ID: <YXraVXpj+kh5XIjy@matsya>
References: <2abd0da35608c14689a919d47dd45898a8ab4297.1635263478.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abd0da35608c14689a919d47dd45898a8ab4297.1635263478.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-21, 17:56, Geert Uytterhoeven wrote:
> Simplify assigning zero and performing a logical OR to a single
> assignment.

Applied, thanks

-- 
~Vinod

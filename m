Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5056DA7A74
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 06:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfIDE42 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 00:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfIDE42 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 00:56:28 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AB12077B;
        Wed,  4 Sep 2019 04:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567572987;
        bh=xkQZikYEyY3c7L/C+i3x3dyZJTWQdFUTYOzei9xlyQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qru4PME1plSqZSD3Y0yICIVW9mG8C6MIOggnFtQeOImhWC+FBN6IDZmu3YNXSXfsp
         /CtM4d+VWQw/4xbdRL1f5E/kqn+X8vqamBF55CBzDkJAaWkH6pNZU4tRZd+X+E6DqX
         V7Xgvu0JOuirnwEN3Hsu9poD7z85dNhWmTT4l4mg=
Date:   Wed, 4 Sep 2019 10:25:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] dmaengine: stm32-dma: Use struct_size() helper
Message-ID: <20190904045519.GZ2672@vkoul-mobl>
References: <20190830161423.GA3483@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830161423.GA3483@embeddedor>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-08-19, 11:14, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct stm32_dma_desc {
> 	...
>         struct stm32_dma_sg_req sg_req[];
> };
> 
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following function:
> 
> static struct stm32_dma_desc *stm32_dma_alloc_desc(u32 num_sgs)
> {
>        return kzalloc(sizeof(struct stm32_dma_desc) +
>                       sizeof(struct stm32_dma_sg_req) * num_sgs, GFP_NOWAIT);
> }
> 
> with:
> 
> kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT)
> 
> This code was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod

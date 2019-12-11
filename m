Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D491911A8F5
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfLKKdl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 05:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfLKKdk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 05:33:40 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AC5206A5;
        Wed, 11 Dec 2019 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576060420;
        bh=+ZuEN6sbvx+HFSyKNfR9u2DU6UxvtkoeGe1OMt2sqOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyTut+e0k0KShiB3ONmjUMsB2d2qtxQJAPj4b2599Rk8xQTs4kDp5HD3wcdY0a+mz
         74ALyUrgeY0fjsR8lCzh2KgZDyqTZGdZcMW4VJbPlzqGZ8/tLxZ9/hcPLRv9ZVMH8Z
         Ru5mZsvkXRfJYWgXT7UstgmHWW2qoQqNliK+tY9E=
Date:   Wed, 11 Dec 2019 16:03:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     dmaengine@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] dmaengine: Fix access to uninitialized dma_slave_caps
Message-ID: <20191211103333.GE2536@vkoul-mobl>
References: <201912051630.Cb4fFTp2%lkp@intel.com>
 <ca92998ccc054b4f2bfd60ef3adbab2913171eac.1575546234.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca92998ccc054b4f2bfd60ef3adbab2913171eac.1575546234.git.lukas@wunner.de>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-12-19, 12:54, Lukas Wunner wrote:
> dmaengine_desc_set_reuse() allocates a struct dma_slave_caps on the
> stack, populates it using dma_get_slave_caps() and then accesses one
> of its members.
> 
> However dma_get_slave_caps() may fail and this isn't accounted for,
> leading to a legitimate warning of gcc-4.9 (but not newer versions):
> 
>    In file included from drivers/spi/spi-bcm2835.c:19:0:
>    drivers/spi/spi-bcm2835.c: In function 'dmaengine_desc_set_reuse':
> >> include/linux/dmaengine.h:1370:10: warning: 'caps.descriptor_reuse' is used uninitialized in this function [-Wuninitialized]
>      if (caps.descriptor_reuse) {
> 
> Fix it, thereby also silencing the gcc-4.9 warning.
> 
> The issue has been present for 4 years but surfaces only now that
> the first caller of dmaengine_desc_set_reuse() has been added in
> spi-bcm2835.c. Another user of reusable DMA descriptors has existed
> for a while in pxa_camera.c, but it sets the DMA_CTRL_REUSE flag
> directly instead of calling dmaengine_desc_set_reuse(). Nevertheless,
> tag this commit for stable in case there are out-of-tree users.

Applied, thanks

-- 
~Vinod

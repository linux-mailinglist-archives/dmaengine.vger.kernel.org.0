Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E1221101
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGOP32 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 11:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgGOP32 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 11:29:28 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A1F20663;
        Wed, 15 Jul 2020 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594826967;
        bh=w224y4zQtuziefarpEq2K02a19xs7z0MtgELxkxpHSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnMResrGwntYqTu85JCMCftD3amBBe1dQl9U8xdxSz16hSyFCguKjdaL6ZYwc5ppR
         8T7s7C55+5GUQEkqIXoVq5B47PAmH4Q1ZcenBoF+Twqq/+gaViC0iT6LgdjPtYbdLF
         OwLqB0WLndwAn2qja9L+GP9zukwEUUbcxAGLTG9k=
Date:   Wed, 15 Jul 2020 20:59:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/17] Rid W=1 warnings in DMA
Message-ID: <20200715152923.GB52592@vkoul-mobl>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lee,

On 14-07-20, 12:15, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/dma.
> 
> Hurrah!

Yes indeed, thanks for fixing these up. I have changed the subsystem
name to dmaengine: and applied all

-- 
~Vinod

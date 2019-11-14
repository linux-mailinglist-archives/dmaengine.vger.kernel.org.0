Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3DFC059
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfKNGsF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 01:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNGsF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Nov 2019 01:48:05 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C114C20715;
        Thu, 14 Nov 2019 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573714084;
        bh=kwJjaG+SEqpT4/sq5ZdwWvkA07Xb/lWO0se3jKCGklU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Te48b4YPfaWP8IvK5q0sJ5iOQakxbMaqikYck9YuSFBl0OdWCMaf9cfjmgKlRtGMm
         IaKGxhh4bei9KOuaVcG+5mVLi5o8EdQZhRrQS1p3gop2tHEabuIlr3/8C5e443VjOA
         Ys7XLVG8cL3JzzFerBZzyW0MEW7aXw+Ee3wKas7A=
Date:   Thu, 14 Nov 2019 12:17:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: mediatek: hsdma_probe: fixed a memory leak
 when devm_request_irq fails
Message-ID: <20191114064757.GP952516@vkoul-mobl>
References: <20191105165914.GD952516@vkoul-mobl>
 <20191109113523.6067-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109113523.6067-1-sst2005@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Satendra,

On 09-11-19, 17:05, Satendra Singh Thakur wrote:
> When devm_request_irq fails, currently, the function
> dma_async_device_unregister gets called. This doesn't free
> the resources allocated by of_dma_controller_register.
> Therefore, we have called of_dma_controller_free for this purpose.

This should have been a v2! Anyway I have applied this and other patch

Thanks
-- 
~Vinod

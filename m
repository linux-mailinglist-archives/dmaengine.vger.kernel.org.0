Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA45843E73D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1R0v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhJ1R0i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF4B160F38;
        Thu, 28 Oct 2021 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441850;
        bh=IjLX1D/rynQnmlEAwbWwkwq3rKn6dORQsASB50h8Lpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dg+PREvv7wCBlWxTLSI/UJkx6Ri4CnX80ecClwO/7wOMzCL20wmJEnl6vQMLaAQpl
         /R2RQKL4X4GP+ETI1ksF53m2Z+U4+b95XAOUEUnxHI5Wn7RzlV6RO4TySYRvPx6ezj
         ulLmbm2TVMcitldibsnw2sgz4rMVLwegrknQS+NDg0wLjmIxuydfRywjGUAH5DVcTJ
         5C4KoJtrenelYxhro4/re/k3Vb5badggJ24KyKV5r/W9ZY85lnOX8tp/MY3yRSpW6Z
         7yOD95Ytt0lQjDeV1iAowq/Twn4ETTglTvDj046jcKms5Tc5+K0Me99H16h/RxFO46
         Tf1GMzrHULQLA==
Date:   Thu, 28 Oct 2021 22:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: altera-msgdma: Correctly handle
 descriptor callbacks
Message-ID: <YXrctnB/4F2hzBHG@matsya>
References: <20211025075428.2094-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025075428.2094-1-lars@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-21, 09:54, Lars-Peter Clausen wrote:
> DMA clients can provide one of two types of callbacks. For this reason
> dmaengine drivers should not directly invoke `callback`, but always use
> dmaengine_desc_callback_invoke(). This makes sure that both types of
> callbacks are handled correctly.
> 
> The altera-msgdma driver currently doesn't do this and only handles the
> `callback` type callback. If the client used the `callback_result` type
> callback it will not be called.
> 
> Fix this by switching to `dmaengine_desc_callback_valid()` and
> `dmaengine_desc_callback_invoke()`.

Applied all, thanks

-- 
~Vinod

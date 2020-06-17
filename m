Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC911FCF3B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQOPa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 10:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQOPa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 10:15:30 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F7520734;
        Wed, 17 Jun 2020 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592403330;
        bh=nkqsIr/uXS139JDmrT9MgEJh96o7yq9tXUhI4ewyHR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4FDANTlZWJbduP+ZYhkOU09HANttZf6z9fOGS1R2O36p8lh4x84DpMGwyc/xp70v
         Kp3G+2qTfh4nCAbgG7LsuR8hwuvvv7WCexPnHD3WrD+Pugx15PwcQi8LQAlDkjqCz/
         AcS07RfIxIo57/r1xb8J/IHLLnCbQzBv6JO7Agfw=
Date:   Wed, 17 Jun 2020 19:45:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com,
        peter.ujfalusi@ti.com
Subject: Re: [PATCH v5] dmaengine: cookie bypass for out of order completion
Message-ID: <20200617141526.GV2324254@vkoul-mobl>
References: <158939557151.20335.12404113976045569870.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158939557151.20335.12404113976045569870.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-05-20, 11:47, Dave Jiang wrote:
> The cookie tracking in dmaengine expects all submissions completed in
> order. Some DMA devices like Intel DSA can complete submissions out of
> order, especially if configured with a work queue sharing multiple DMA
> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
> those DMA devices. The user should use callbacks to track the completion
> rather than the DMA cookie. This would address the issue of dmatest
> complaining that descriptors are "busy" when the cookie count goes
> backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
> DMA capability to allow the driver to flag the device's ability to complete
> operations out of order.

Applied, thanks

-- 
~Vinod

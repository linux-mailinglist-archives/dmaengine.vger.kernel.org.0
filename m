Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCA30A1EB
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 07:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhBAG1f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 01:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhBAGMc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 01:12:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BEB864E22;
        Mon,  1 Feb 2021 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612159905;
        bh=EBDbzPWKgF2z/7cjZyIByz8dGjfOnNy6fxEzMuGtobo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhFi/Eo5MBVb1MeaniqJLUyKLcyn8qL+zOuerc7co086UP9fqwBeq5+zg8gLj+Rg/
         LOGVV2vtol7PWl2SxFUZCmCNeax8Fa7qCK6XR+PaJwz1vmyt1z/8wj5khhZeJwzJ6U
         0NQeeYWnENz+TsfopRzXgZjrKisrCp8V6TFvXZKc6NSnLk9GF/zYsIAimTHNvIa3Js
         wW8O0Y8ZoK/mjZVTZFPWRbqAIesXiJ2EMxt7yF35Klb0DZ3Fe0sSUTOcd/M+FnEJA8
         s0kcpvwYzutREeyJ03Ey/brAcUKd3PL+2MnLEOp5dH3yJQKQPzO/F+xye7r8wm5YSH
         dPfoc9E26LRNQ==
Date:   Mon, 1 Feb 2021 11:41:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: check device state before issue command
Message-ID: <20210201061140.GL2771@vkoul-mobl>
References: <161161231309.406594.6061304765472136401.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161161231309.406594.6061304765472136401.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-01-21, 15:05, Dave Jiang wrote:
> Add device state check before executing command. Without the check the
> command can be issued while device is in halt state and causes the driver to
> block while waiting for the completion of the command.
> 
> Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Fixes: 0d5c10b4c84d ("dmaengine: idxd: add work queue drain support")
> ---
>  drivers/dma/idxd/device.c |   25 ++++++++++++++++++++++++-
>  drivers/dma/idxd/idxd.h   |    2 +-
>  drivers/dma/idxd/init.c   |    5 ++++-
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 95f94a3ed6be..45077727ce5b 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -398,17 +398,33 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
>  	return false;
>  }
>  
> +static inline bool idxd_device_is_halted(struct idxd_device *idxd)
> +{
> +	union gensts_reg gensts;
> +
> +	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
> +
> +	if (gensts.state == IDXD_DEVICE_STATE_HALT)
> +		return true;
> +	return false;

return (gensts.state == IDXD_DEVICE_STATE_HALT) ??

-- 
~Vinod

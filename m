Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1097399B30
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFCHDq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 03:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCHDq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 03:03:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3945860E09;
        Thu,  3 Jun 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622703722;
        bh=k9/3kydmCD/YVqKYWG9ynJ32X/eSBMR1Sx8GD8erjTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7+xsj/CtKHiwRCeE8Nts3det+GF1v+T+b9napCB8TheTV2oroNEhFpuECs8ZoXAN
         2XItpaWpyu8LEAzolPthF1kF8OGbj+RTEd+FBcxnHLD48fEd7wBxoR/utP5Fg8Djj7
         LYiQdamsZDSJRs79/zoteXRgV4Fa4T2b+IktGwKIOUYc2ERH2Y8TQdU98mzhiynvXr
         G7Vv/r/eeuFacQQ3b0nchTcv5VPS5sYAIfH7uCH1h8APfmO1D7G/l819qvMQttmHoQ
         boA0Igck7HmiCu2h/08xPVjXkazGyextREhVf+bDD/UXLl7hYW4aI6jbYrfoI7+1Wj
         0+EB3ZakPYOYQ==
Date:   Thu, 3 Jun 2021 12:31:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next] dma: ipu: fix doc warning in ipu_irq.c
Message-ID: <YLh+ZrjXhPN6kxdT@vkoul-mobl>
References: <20210601115938.3193296-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601115938.3193296-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-06-21, 19:59, Yang Yingliang wrote:
> Fix the following make W=1 warning:
> 
>   drivers/dma/ipu/ipu_irq.c:238: warning: expecting prototype for ipu_irq_map(). Prototype was for ipu_irq_unmap() instead
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/dma/ipu/ipu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
> index 0d5c42f7bfa4..dc44294b79b5 100644
> --- a/drivers/dma/ipu/ipu_irq.c
> +++ b/drivers/dma/ipu/ipu_irq.c
> @@ -230,7 +230,7 @@ int ipu_irq_map(unsigned int source)
>  }
>  
>  /**
> - * ipu_irq_map() - map an IPU interrupt source to an IRQ number
> + * ipu_irq_unmap() - map an IPU interrupt source to an IRQ number

the description does not match and should be fixed as well

>   * @source:	interrupt source bit position (see ipu_irq_map())
>   * @return:	0 or negative error code
>   */
> -- 
> 2.25.1

-- 
~Vinod

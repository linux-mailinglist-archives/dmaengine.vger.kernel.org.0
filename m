Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115AE2493D6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 06:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHSEY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 00:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSEYz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Aug 2020 00:24:55 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7969A20772;
        Wed, 19 Aug 2020 04:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597811095;
        bh=5R5yCOQUdGX/QNMFAj2RPOrCB6IJDx+12DXwDUsMK7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOCs0hHUrjHUeHk3WxVOV/i4e21PSR0eTZRn88+QHF/bmCy7P8XKR3yq8JB8AJmve
         6tFtceEdMUCjs0Zbp8XbvPRHWGtaToxCI2M+gddr5FXm9o+afE3sgx4j9RGFcDDwfC
         glhVGS/R5In1ck647WxLwd2cK223VgyfQHfi6oX0=
Date:   Wed, 19 Aug 2020 09:54:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] dmaengine: xilinx: dpdma: Make symbol
 'dpdma_debugfs_reqs' static
Message-ID: <20200819042451.GA2639@vkoul-mobl>
References: <20200818112217.43816-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818112217.43816-1-weiyongjun1@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-08-20, 19:22, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/dma/xilinx/xilinx_dpdma.c:349:37: warning:
>  symbol 'dpdma_debugfs_reqs' was not declared. Should it be static?
> 
> This variable is not used outside of xilinx_dpdma.c, so this commit
> marks it static.

Applied, thanks

-- 
~Vinod

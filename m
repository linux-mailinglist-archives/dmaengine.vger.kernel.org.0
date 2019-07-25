Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41874EC0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfGYNEJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 09:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfGYNEJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 09:04:09 -0400
Received: from localhost (unknown [49.207.58.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF1621951;
        Thu, 25 Jul 2019 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564059848;
        bh=kSsOkcHxhfceNWz39WywJ4n4fvDw4GrpNDBcNBi5atk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYWb44sRe5vsbI54z5fqDTLZGkSwc7EA1hHQjfmUOoLz/jaDt+q/f43pu6Huy+8D+
         IwbXfYpn/yQhksV4T8sCULCu0DqhzyI51sgKoP7uPa7LPrTOivQrPMN29eDniN36b9
         uHtTNowvayu/cHaT4vNp+44ueswPc8y8/gQG4moQ=
Date:   Thu, 25 Jul 2019 18:32:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix unused function warnings
Message-ID: <20190725130255.GV12733@vkoul-mobl.Dlink>
References: <20190709083258.57112-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709083258.57112-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-07-19, 16:32, YueHaibing wrote:
> If CONFIG_PM is not set, build warnings:
> 
> drivers/dma/tegra210-adma.c:747:12: warning: tegra_adma_runtime_resume defined but not used [-Wunused-function]
>  static int tegra_adma_runtime_resume(struct device *dev)
> drivers/dma/tegra210-adma.c:715:12: warning: tegra_adma_runtime_suspend defined but not used [-Wunused-function]
>  static int tegra_adma_runtime_suspend(struct device *dev)
> 
> Mark the two function as __maybe_unused.

Applied, thanks

-- 
~Vinod

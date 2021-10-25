Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813C438E6B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJYEip (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhJYEio (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:38:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF5461076;
        Mon, 25 Oct 2021 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635136583;
        bh=m95zL5qJFpIp8UBmqs1eDOK/t7E7DPgy8JbrnVNVwME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WusWNnXLBjbArxacHYWOsoDSbEzfkUzDRnwpL1Vq5pDgiO3R7OkDfIquygH/9xvf3
         AI6N0gjKljUG1KvnunrHWOpzV1VPd2NNyvDxBu+2sOULjy5eo7JJiHsl1d8f77G0CX
         E2T0n+JJV7AiXm6ebAKyePkFtsV+LNfbcz+TpZ2ZhMqSP0JmHrl5enOcMxz0RqDxDm
         orlD9KC3gWkIF+SP5h2dtOBvj0izxnWCfs8b8PcqmRS9eVbIPM5zLe7mZwuCA9ZVaw
         QTVXPtgXDoqMkroH1obqPsSmZrexTAE5NScvUqJuZ7bck+2DPswEIIiIS7Zfm/7jZ5
         PlM/odOQrKD4w==
Date:   Mon, 25 Oct 2021 10:06:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance
Message-ID: <YXY0Qyi2XzEFI8Ic@matsya>
References: <20211021030538.3465287-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021030538.3465287-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-21, 11:05, Dongliang Mu wrote:
> The previous commit 059e969c2a7d ("dmaengine: tegra210-adma: Using
> pm_runtime_resume_and_get to replace open coding") forgets to replace
> the pm_runtime_get_sync in the tegra_adma_probe, but removes the
> pm_runtime_put_noidle.
> 
> Fix this by continuing to replace pm_runtime_get_sync with
> pm_runtime_resume_and_get in tegra_adma_probe.

Applied, thanks

-- 
~Vinod

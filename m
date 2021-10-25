Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B03438E6E
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 06:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJYEjC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 00:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhJYEjB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 00:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66EFA61076;
        Mon, 25 Oct 2021 04:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635136600;
        bh=i42mi0+V1rzwA2P+sPblq3qoI29XMabxnRbayMFYlBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADyR7j3W9PwwHKzkUbkuBHNdhbZYdjCGbOoqRtsGKKpVLE3mi3f1ByMT4LFTxRAMi
         YvGNvQ8oy98XwpizFi72kh8yt/3g5bXr4iBrmfIJOnGmNH0TqsI4l+fTqhjyAvTJ7v
         VeZUqj92JfG095nA7IqhnH6z6JS3Dbm5EV80U99qZD8HZIukltJtRVLLoN0sqG3RIi
         s32ljPlDv2kfysVshJql2TJNCInT3HRVzxNL+BJN1cfqQQMYIB73d1HnLf4BNLz9Be
         a8raM3BgnaEXn9nQWbxLVLrZhlBDJ/4ScJjRytc6ucKMaaAjiWAJkjcKiRR8M9wk3Z
         TVY+FPF4TxhTA==
Date:   Mon, 25 Oct 2021 10:06:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance in
 tegra_adma_remove
Message-ID: <YXY0VJ63vm+4paHy@matsya>
References: <20211021031432.3466261-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021031432.3466261-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-10-21, 11:14, Dongliang Mu wrote:
> Since pm_runtime_put is done when tegra_adma_probe is successful, we
> cannot do pm_runtime_put_sync again in tegra_adma_remove.
> 
> Fix this by removing the pm_runtime_put_sync in tegra_adma_remove.

Applied, thanks

-- 
~Vinod

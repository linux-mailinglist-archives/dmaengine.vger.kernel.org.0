Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABA207044
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbgFXJmi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 05:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388005AbgFXJmi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 05:42:38 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4849B20885;
        Wed, 24 Jun 2020 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592991758;
        bh=POC8Wy5W8HTGPEipKgRNZ1OHxxsOy/XY4a0SBFZb7sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybftKYnLOHEYJTD5rDbKXmc8Lz2zb2r+pORrKDYLA/6TKMDELxG8MDiMrvnWT+AkZ
         nCzzLRrchZQUbJfL/YExokHyzRoY7dA42D1qVl4UGc0rI2iy0YZIWWMVVx4j0NJYB2
         IybzbssoS1gJ3VOOd5YLZFEenZD5S455zG/QoW+0=
Date:   Wed, 24 Jun 2020 15:12:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v5] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
Message-ID: <20200624094234.GW2324254@vkoul-mobl>
References: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-20, 14:46, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied, thanks

-- 
~Vinod

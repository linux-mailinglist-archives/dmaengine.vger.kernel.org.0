Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F36379308
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhEJPvj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 11:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhEJPve (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 11:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19AEF61400;
        Mon, 10 May 2021 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620661829;
        bh=JPkJHUiU/lse7/DOiU4LyD7lKWfjNaXscTsjXBfAs/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQNT6h+XzsZfuIZs9E4AQZ9NduVzZmOghnqx3M7TC+tCTj93l2zLXAQkx38SSn2I1
         TfZ4/GAzLinTMzUvtQHa38TizPRqZN+9lX/avt/K9fN7mF9wi7LkM19Hl6GvX0ntCr
         dEvmBcIp/xkoOy/5Evzi1zs0fd3PGyBV9BQJb3aSzmpzTQoqUbidCiTmqmNYv2Bxxf
         ZH0MmInPDbBepRjGIU2wuM8TTCdpIyD8TSXf88ETzHYcVyFxNBguiUyLaOd/4ZmnZ3
         Hzoa39++Gt2ZZRS7KkyXGIKjF8WedGLA98Z1XGQNH1C2Bbd09Pl8Jzc5UCEK+Ni8xG
         gRpkbFigDI15w==
Date:   Mon, 10 May 2021 21:20:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove devm allocation for
 idxd->int_handles
Message-ID: <YJlWQJZys1b6p3za@vkoul-mobl.Dlink>
References: <YJZJ2Z5CEqQC5s+1@mwanda>
 <162060710518.130816.11349798049329202863.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162060710518.130816.11349798049329202863.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-05-21, 17:38, Dave Jiang wrote:
> Allocation of idxd->int_handles was merged incorrectly for the 5.13 merge
> window. The devm_kcalloc should've been regular kcalloc due to devm_*
> removal series for the driver.

Applied, thanks

-- 
~Vinod

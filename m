Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE97C379076
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhEJOUA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237905AbhEJORr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 10:17:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07EF860FF2;
        Mon, 10 May 2021 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620656188;
        bh=NJT8p7LsY3zwEnfa4XYTDwnk5yR8HI19R7pkIeMUUK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGUVQLdKXr/Qhark9KLhGLfOkmS1yfYqAWzf+H6GQuUEckkTrtmvWxVT8AV+Y44TL
         MvS3OYJVoAtwVNixtTUaJpeaID29MckY93Y11ef79no3JG5MdbsRiM+yE4YGI/wUPI
         Vfta8K6rVjAqVGp3Z2EgGaHNx5eOJ2FVA0wvQRQVNYqTvfbpkV6mOoKFydsNLxgFGm
         SDZCJnh0sjFVuKImZ4rPQJOkzuFd9TwfV72x1LO9wjrxB2x/cT8JFPZLQnuwqZygl+
         QhPOVinpnrkeWt0H3U2ZEGcnMsHKRzvKoFVXEdcvmJYiaq2i51ooeN07iyokWCwJ2t
         GOZX9DyAIkoMA==
Date:   Mon, 10 May 2021 19:46:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: sprd: Add missing MODULE_DEVICE_TABLE
Message-ID: <YJlAOPlgJpanBHZj@vkoul-mobl.Dlink>
References: <1620094977-70146-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620094977-70146-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-21, 10:22, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied, thanks

-- 
~Vinod

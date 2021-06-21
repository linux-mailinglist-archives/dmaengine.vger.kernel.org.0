Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39E03AE4C6
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUIbs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 04:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIbs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Jun 2021 04:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91E060FF4;
        Mon, 21 Jun 2021 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624264174;
        bh=KPznl7d9Wv3j9LDZ3CCsrENhbmOEiGLgBvC80ba2OpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKcKMH9coXa7nADZfEz4x5P/kGS731f1HhZIVx60t48cKEoNQpwC2N117B/ihq7YH
         Uy1qdn1uXFk84gWE6naSTZwYWwEs/9S0Ns+5CM2UFMt7/Ju2cz2giWHuRVYm8LynOC
         iK69jfglBsA9O91maMPa+HjuVBpXHcSBCWhTczvq34FSkTO5NiwGCKc3M/HOgeuewx
         i3QB353yODBZVuLSC+Pu2PIuB/Jko4JIlpp3FKMH39bPvMEBZBVZ61oOEoA5fVpX2w
         IaF29J3BRvTnsoeKIewsKg3FujT1pw0K585rLJ0tGUhLOi4kHbpLDAn5MP//T1zPzP
         Rt9IkBIIWV19g==
Date:   Mon, 21 Jun 2021 13:59:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     angkery <angkery@163.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v1] dmaengine: mediatek: Return the correct errno code
Message-ID: <YNBN684ZiVdVb4eU@vkoul-mobl>
References: <20210621062048.1935-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621062048.1935-1-angkery@163.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-21, 14:20, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> When devm_kzalloc failed, should return ENOMEM rather than ENODEV.
> 
> Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Patch was sent by angkery <angkery@163.com> and signed off by Junlin
Yang <yangjunlin@yulong.com>. I would need s-o-b by sender as well...

Thanks

-- 
~Vinod

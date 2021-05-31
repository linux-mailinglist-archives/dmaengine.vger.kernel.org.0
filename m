Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB713954A3
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEaEdr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhEaEdp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 120EA611EE;
        Mon, 31 May 2021 04:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622435524;
        bh=MAoCGKAgC+NPu5hnXGbjb6AtY8/KZajb+EUQr95s8eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA2NozksxovAcRR65U8OoAfJuGN8dfqzxa2Tbf+3TlG6F8w44/J/MfvUNAnUh40Q5
         rUzI/XX27YOlAG4NRNURjsw9bhhG2XaNpVgAISZxRquzZOZV5Y6/J29HPwgGUtmhpg
         XGjKffS2v1L99XoZl1uopaZf67WgPlELULHw4CLMwab4UFODC0oYZ2ADZambqiOXRa
         GmH0gYi8S5BpQG0fgf00rkWe8ve3VUja9mP0mmrDE5Mht/99+78q2TSw81zny/Kq6d
         nvYnXyRvpZPA7uYVVgUPyH7gm/Ktu+pdM7tMqe163Fp9W+F+uKXRnCkNnOOfppNkIH
         4d8TpyQgwyWAA==
Date:   Mon, 31 May 2021 10:02:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Skip pointless cpu_pm context
 restore on errors
Message-ID: <YLRmwV4Nc4rFU0Bm@vkoul-mobl.Dlink>
References: <20210518074347.16908-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518074347.16908-1-tony@atomide.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-05-21, 10:43, Tony Lindgren wrote:
> There's no need to restore DMA context on CPU_CLUSTER_PM_ENTER_FAILED as
> the DMA context won't be lost on errors.
> 
> Note that this does not cause invalid context restore as we already check
> for busy DMA with omap_dma_busy() in CPU_CLUSTER_PM_ENTER, and block any
> deeper idle states for the SoC by returning NOTIFY_BAD if busy.
> 
> If other drivers block deeper idle states with cpu_pm, we now just do a
> pointless restore, but only if dma was not busy on CPU_CLUSTER_PM_ENTER.
> 
> Let's update the CPU_CLUSTER_PM_ENTER_FAILED handling for correctness,
> and add a comment.

Applied, thanks

-- 
~Vinod

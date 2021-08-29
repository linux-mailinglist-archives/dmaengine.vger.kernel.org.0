Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D323FAC05
	for <lists+dmaengine@lfdr.de>; Sun, 29 Aug 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhH2Nop (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Aug 2021 09:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhH2Nop (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 29 Aug 2021 09:44:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 870CD60C41;
        Sun, 29 Aug 2021 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630244633;
        bh=Q9UkFi+WxU/Tqc5gkuVySAB9CULHF80plLagvevOVNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpXS6ygScFUiz8bKxBaAOS0cusO8g0dswAxKjQz/fsgtZG5lYafOUpZxgd2rxuy7G
         lxLSu6iAMAoY8gMFrby39AeWGr6Qs3jV1FXpizkM9oefWmRIU6MDprgFOV9WHp5T+v
         vLgn0pzgc9k+6QuHj+ewGb752gxMiKTdIYoWENwQfmAaDn9YOaMBz2qIV/U9St3XNe
         LVWDmYyyLZQ43cxhxcft7FzI2XzqXnHofvGtdSwgN4XyOzhyq25+n2B689RybhQ6q5
         FXT4+QO0fInAg0CQgx84VkhVPWIJbM5X25ftBub50MK+NMO3D2RM3IJ6eUGgHUJGED
         NqBu5wA8tpD3A==
Date:   Sun, 29 Aug 2021 19:13:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YSuPFT1SLnM0J0NP@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YSZTGhBcSTFEPB4d@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZTGhBcSTFEPB4d@matsya>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-21, 19:56, Vinod Koul wrote:
> On 04-07-21, 23:33, Keguang Zhang wrote:
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > 
> > This patch adds DMA Engine driver for Loongson1B.
> 
> Applied, thanks

Dropped now, there have been build failures and no follow up fixes
posted.

Pls fix and repost the driver after next merge window

-- 
~Vinod

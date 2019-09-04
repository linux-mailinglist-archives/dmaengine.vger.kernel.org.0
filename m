Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068B1A7FC6
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfIDJvF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 05:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDJvF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 05:51:05 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3ACF22CF7;
        Wed,  4 Sep 2019 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567590664;
        bh=cWumTrUCWby2RFMQQ87i5+/dEWefDyNawluwiyL0n3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq05tX4MsH75NEnfoomECduDUpW2wgJt/to/w0nCfJX3GyJx2fdZxyrIs6XDUmTRO
         bVrzmOsP03hofoZ+aKx8Ta7FWzNVpvjjjj//h1N2YrnyBho2cog9/jYfuefO4489kL
         TESY896jfACtG/BoceM+AOuwziakfG1yMbHS1yGI=
Date:   Wed, 4 Sep 2019 15:19:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/5] dmaengine: ti: edma: Multicore usage related fixes
Message-ID: <20190904094956.GT2672@vkoul-mobl>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-08-19, 15:56, Peter Ujfalusi wrote:
> Hi,
> 
> When other cores want to use EDMA for their use cases Linux was not playing
> nicely.
> By design EDMA is supporting shared use with shadow regions. Linux is using
> region0, others can be used by other cores.
> 
> In order to not break multicore shared usage of EDMA:
> - do not reset paRAM slots which is not allocated for Linux (reserved paRAM
>   slots)
> - Only reset region0 access registers, do not touch other regions
> - Add option for reserved channels which should not be used by Linux in a similar
>   fashion as we already have for reserved paRAM slots.

Applied 1 to 3, thanks

-- 
~Vinod

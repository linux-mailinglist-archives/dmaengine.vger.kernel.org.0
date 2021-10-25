Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6841E438F9C
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJYGms (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGms (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B5460EFE;
        Mon, 25 Oct 2021 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144026;
        bh=VBih8NwPBkFNBYRuxLxjfdgRABbJNiBl1aeStq4mVC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjQg2NoUHLakNz9aOaGeNWfrAahKiOTBnsBXUCoGtNaTm49swJu96b4tzrhIxQnuT
         /4rszqEj71wprVPeQgwBgBR4vCNlBDd2ZYU7NFaZNpVWdPzTNnLpYL6WuIPXCFX8Ee
         3wKbVjfnYXHuaDKG7zGCDwBhLNhnms73+Hta+IYDHagvR8HU9Wt4yFlTxdESDdDlqL
         lXljqt6xUcWEXqyTwmGSt9k6xjPmRqf3E8QDERJriAZf0YQ+DoUMK+RMv1O8NiqcM2
         Sha2PikvbaJv/PaWx8L5lKnKjmHvYgh1CjUZXEk/DQCfBMZd8JDZvh04d51W3YxH4O
         746coGCGOPMOw==
Date:   Mon, 25 Oct 2021 12:10:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Shravya Kumbham <shravya.kumbham@xilinx.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix kernel-doc warnings
Message-ID: <YXZRVtOhHwJQpPO9@matsya>
References: <1631525316-2323-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631525316-2323-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-09-21, 14:58, Radhey Shyam Pandey wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Modify the prototype from xilinx_dma_tx_descriptor to
> xilinx_dma_alloc_tx_descriptor and xilinx_dma_channel_set_config
> to xilinx_vdma_channel_set_config in API description to
> fix below linux kernel-doc warnings.
> 
> drivers/dma/xilinx/xilinx_dma.c:800: warning: expecting
> prototype for xilinx_dma_tx_descriptor(). Prototype was
> for xilinx_dma_alloc_tx_descriptor() instead.
> 
> drivers/dma/xilinx/xilinx_dma.c:2471: warning: expecting
> prototype for xilinx_dma_channel_set_config(). Prototype
> was for xilinx_vdma_channel_set_config() instead.

Applied, thanks

-- 
~Vinod

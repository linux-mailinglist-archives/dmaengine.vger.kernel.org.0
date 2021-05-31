Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68239545D
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEaEQm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEaEQm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:16:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D7161019;
        Mon, 31 May 2021 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434503;
        bh=7VcOp3wmc1KVXf02qIcPbVYMovwxdpK4xnYvnYaf8Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5oMQdFAxE2XzNHM5JwqLqzx6uNlkm7X+uiSOW1SvkIOUOE+gswW978O3aVAj04Wo
         E5zAp/cbT0nrDLUpWn+7ORCExq0DPoFBNz6wZ2kL+ZUQucA4dZZCDmrxFesmcsGPac
         KY0b5RtfUl6Cd1WkCZPOEhr82Ziq3KWjccC+AP9mRB22YeRfMybNrqSUnc17u7FPhz
         CokEaUu3YZzLiBmIXEwZl7Z2QokdnxL+9MpdNf2rAxKwzRVQeCQakXxpOWOmRCQHSr
         6ryX0028t9PBUSdCLDZcKB5FRxxqIlS29zb/DNzxDKjJ8yci75T9VUyOuDlCo/1vvq
         CqcHJowfBkJig==
Date:   Mon, 31 May 2021 09:44:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] DMA: several drivers depend on HAS_IOMEM
Message-ID: <YLRiwyKfsRLV+wYu@vkoul-mobl.Dlink>
References: <20210522021313.16405-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522021313.16405-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-21, 19:13, Randy Dunlap wrote:
> A few drivers in drivers/dma/ use iomap(), ioremap(), devm_ioremap(),
> etc. Building these drivers when CONFIG_HAS_IOMEM is not set results
> in build errors, so make these drivers depend on HAS_IOMEM.

Applied 1-3, thanks

Also susbsystem tag is "dmanengine:" I have fixed that up while applying

-- 
~Vinod

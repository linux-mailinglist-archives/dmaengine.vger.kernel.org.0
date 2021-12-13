Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F444720C9
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhLMFxV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:53:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43662 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLMFxV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:53:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13A5EB8076B
        for <dmaengine@vger.kernel.org>; Mon, 13 Dec 2021 05:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF36C00446;
        Mon, 13 Dec 2021 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639374798;
        bh=UhnBjCwnUtEvWIwHM6Z5nJzExVfkg/12RQBTcRBBgDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jciqeDUKD/qRTg0I+fSF6CFvVqMqhHD+VZqiFQPA3QjnRHso1uyVFvpyFPcFK7v4U
         OvNM9IhKnekvtGDf0MJc3stMaj5YnH5nyfQzCFjuMO8lVDaiKme6NFoMcCQf+fn7M1
         +OEufwoaYfuBtZuvtqn6FVSiTss5E2MV5+w67TJeBfhYO9pD1cnWu/sQIVvsoduJqa
         rKVtMSs4P566P4MN0mxzC2b5DTWwpLp9BZOmyQKS1dC5iYQxoljUe3wrwzfxfZODIC
         nkWR5PfO60MpMK5/9UF4ROW5j5K6WbirjlIWr0gzkBYoxGx5eXKTmPv9YRwSRYkxU5
         x9sX9TPvUE0bg==
Date:   Mon, 13 Dec 2021 11:23:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: Handle IRQ mapping errors
Message-ID: <YbbfypH4k2k7GOVs@matsya>
References: <20211208114212.234130-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208114212.234130-1-lars@metafoo.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-12-21, 12:42, Lars-Peter Clausen wrote:
> Handle errors when trying to map the IRQ for the DMA channels.
> 
> The main motivation here is to be able to handle probe deferral. E.g. when
> using DT overlays it is possible that the DMA controller is probed before
> interrupt controller, depending on the order in the DT.
> 
> In order to support this switch from irq_of_parse_and_map() to
> of_irq_get(), which internally does the same, but it will return
> EPROBE_DEFER when the interrupt controller is not yet available.
> 
> As a result other errors, such as an invalid IRQ specification, or missing
> IRQ are also properly handled.

Applied, thanks

-- 
~Vinod

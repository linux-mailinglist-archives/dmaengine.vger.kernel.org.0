Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7978537936A
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhEJQLx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhEJQLs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589CA61026;
        Mon, 10 May 2021 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620663042;
        bh=5R9b+ZFSVfDZ3kcuqx1c9xrKvhCgr6D4wAVhmoT5Fws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjloC4vnaOgkyMgPxjGM4vtShPZ9cMhfj6E8Vkl1yzsrDRdhLgqFyCyuU5L+msqaO
         n3TWD5pfOn/HYq7n4MA3oJ8TNnAhZ8UrLTIIf7Pv4hALKRoPQzS5mtCnHWOz0YKk72
         SaHfd6OsNNcGM/ReVIl/plGZ+0wIlCrakIEsNpLPEJOefDfJXZu/s0e7XkYF9SAKij
         TBmo5iP+A2Sq7QdnuhwjEV4sX8kXOZSxyNf/hDcI8WFLmcr+lSwquz7KrDc6bBQ6P/
         uqOnvB2Rr9A9fm16oBAa/Klgn+YE6OCPg2vqMy/6tdnRjMSqQF0U+bhGKOTlx6UFWz
         OMfQ2nYEQhvfg==
Date:   Mon, 10 May 2021 21:40:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] dmaengine: xilinx: dpdma: initialize registers
 before request_irq
Message-ID: <YJla/qT1UO1gb/OD@vkoul-mobl.Dlink>
References: <20210430064041.4058180-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430064041.4058180-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-21, 14:40, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> In some scenarios (kdump), dpdma hardware irqs has been enabled when
> calling request_irq in probe function, and then the dpdma irq handler
> xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
> this moment xdev->chan[i] hasn't been initialized.
> 
> We should ensure the dpdma controller to be in a consistent and
> clean state before further initialization. So add dpdma_hw_init()
> to do this.
> 
> Furthermore, in xilinx_dpdma_disable_irq, disable all interrupts
> instead of error interrupts.

Applied, thanks

-- 
~Vinod

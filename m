Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E630343928
	for <lists+dmaengine@lfdr.de>; Mon, 22 Mar 2021 07:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCVGFL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 02:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhCVGEy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 02:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2000D6192E;
        Mon, 22 Mar 2021 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616393094;
        bh=XHSJVFYLkfSrTabMwU77kIGMegQzpz9eSl2b5yGtDdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/u+Yi1TNEVNGGo/bUsxAwLNr2Yb0hy6GggXTIkEG+1Q65pUBVldkBr/Fq/UTodTL
         /at0FtykXpSzDXC9gQ38IGNab8/Q9PP92D7nFioCF/pMZjs6P89c0AAypREj75VsqG
         +i3GWNlSjK8+bCn4o11IOoDG8LlcBVvvllHyYvAgCvJbiIWnzj+YZKUK9md5I/BNd3
         qYc/K6aGS/BfP5JPoIKF95gdKxyWpBM0ryJxYWrobpfm1LxdGQ5H13Zpm/q0XuwQeh
         BBZBQIMzSYMbRspt72tW+Yf95bSVJnZn6uETAcYZTf2GJm1j//l6gOwq6BtVYX7WmZ
         IuEwX2jSJgnog==
Date:   Mon, 22 Mar 2021 11:34:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YFgzgRK3ZuL/GRkr@vkoul-mobl.Dlink>
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-2-git-send-email-Sanju.Mehta@amd.com>
 <20201118115545.GQ50232@vkoul-mobl>
 <5605dae6-3dde-17f9-35c8-7973106b9bea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5605dae6-3dde-17f9-35c8-7973106b9bea@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-03-21, 16:16, Sanjay R Mehta wrote:
> >> +#include <linux/delay.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/kthread.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pci_ids.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/spinlock.h>
> >> +#include <linux/sched.h>
> > 
> > why do you need sched.h here?
> > 
> >> +
> >> +#include "ptdma.h"
> >> +
> >> +/* Ever-increasing value to produce unique unit numbers */
> >> +static atomic_t pt_ordinal;
> > 
> > What is the need of that?
> > 
> 

[please wrap your emails within 80 chars]

> The "pt_ordinal" is incremented for each DMA instances and its number
> is used only to assign device name for each instances.  This same
> device name is passed as a string parameter in many places in code
> like while using request_irq(), dma_pool_create() and in debugfs.

Why do you need that, why not use device name which is unique..?

> Also, I have implemented all of the comments for this patch except
> this. if this is fine, will send the next version for review.

Am not sure I remember all the comments I gave, it has been _quite_ a
while since the feedback was provided. In order to have effective review
it would be great to revert back on a reasonable timeline and discuss...

Thanks
-- 
~Vinod

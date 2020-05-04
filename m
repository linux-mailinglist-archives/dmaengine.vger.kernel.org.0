Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C551C3221
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEDFQ2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgEDFQ2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:16:28 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14099206C0;
        Mon,  4 May 2020 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588569387;
        bh=NDLbS7H6KX8JKKif2MK4betfRmG+k4ZuMRllise3FH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK29ZRn37F496akRaG3GcO+JOrxhO4ifvkyc5p8z9aryf4UhKyF+AThH5xKRPGT49
         JYYrGGeesrtjQwRtI9m/4zOrMGJ11uFjbZdrd0pUmVDP5037K61cLpFCuYyME+Ne21
         3EKAg5il2Xg3hUuTZb/FKfFmfRCy0okr1oTZG+yU=
Date:   Mon, 4 May 2020 10:46:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWC?= Hibner <rafal.hibner@secom.com.pl>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: zynqmp_dma: Initialize descriptor list after
 freeing during reset
Message-ID: <20200504051623.GE1375924@vkoul-mobl>
References: <20200428143225.3357-1-rafal.hibner@secom.com.pl>
 <20200502123242.GB1375924@vkoul-mobl>
 <1330934e-342e-1e16-6451-d8952463119c@secom.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1330934e-342e-1e16-6451-d8952463119c@secom.com.pl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-05-20, 15:00, Rafał Hibner wrote:
> Hello Vinod,
> 
> On 02.05.2020 14:32, Vinod Koul wrote:
> > Would it not be better to use list_del_init() where we delete it rather
> > than do the init here?
> >
> 
> It is not a problem of list element itself not being initialized.
> The problem is that during fault conditions (zynqmp_dma_reset) all
> elements are moved to free list. List head however is not reinitialized.
> 
> In normal flow elements are removed by list_del and resubmitted to
> free list with zynqmp_dma_free_descriptor.
> 
> static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
> {
>     ...
>     list_for_each_entry_safe(desc, next, &chan->done_list, node) {
>         ...
>         list_del(&desc->node);
>         ...
>         zynqmp_dma_free_descriptor(chan, desc);
>     }
> }
> 
> The zynqmp_dma_free_descriptor does not delete elements from the
> list by itself.
> I am not he author of this driver so I fixed it by
> doing non intrusive changes.
> 
> Anyways, I do not see how using list_del_init would fix the bug.

Looking at this, i think it would make sense to do list_splice_init()
before we send the list to be freed.

Radhey/Appana are cced, they should test this.

-- 
~Vinod

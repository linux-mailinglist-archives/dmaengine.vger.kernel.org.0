Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E0438F8B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJYGdu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhJYGdt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:33:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E180E60E09;
        Mon, 25 Oct 2021 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635143487;
        bh=w0wt2RzbUmzFsn9gjSb7RtbSu2VKVQcA+1obxbpkBtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAHIL+vC76firAy7T3DBeUnbIXP6C25M/4Qp/Ww5/kmcMBkZwIaAcnXabdBplwpRH
         yJKRih7lqyB9PBIuVoBT5I2msrSby7ZHPv7t7MuqL5uMqfZ0htjq408f8Y7z5Aa+t/
         V4sTAWX6ssNkWjDi3EnQ76Ns7WBS/wC51Sl5bGAuZdvtO2VWzu3clNJEvYw9Ctq2P1
         0Gf55/NtGlaD9x8jFqZU7XdyUvL30Kn8hlp6YrUwIPL8wyzkCQMIGbo7vDx9nsWx24
         QqJgZp92R5NYdayJ7QIw1mHk0OMl5hBQ0+WbnBee4U/suRE1nlC8z+BYQpdW6ahzud
         w72Vz/20YBfkg==
Date:   Mon, 25 Oct 2021 12:01:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianqiang Chen <jianqiang.chen@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: remove debugfs #ifdef
Message-ID: <YXZPO6z2emwXe5DA@matsya>
References: <20210920122017.205975-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920122017.205975-1-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-09-21, 14:20, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ptdma driver has added debugfs support, but this fails to build
> when debugfs is disabled:
> 
> drivers/dma/ptdma/ptdma-debugfs.c: In function 'ptdma_debugfs_setup':
> drivers/dma/ptdma/ptdma-debugfs.c:93:54: error: 'struct dma_device' has no member named 'dbg_dev_root'
>    93 |         debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
>       |                                                      ^
> drivers/dma/ptdma/ptdma-debugfs.c:96:55: error: 'struct dma_device' has no member named 'dbg_dev_root'
>    96 |         debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
>       |                                                       ^
> drivers/dma/ptdma/ptdma-debugfs.c:102:52: error: 'struct dma_device' has no member named 'dbg_dev_root'
>   102 |                 debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
>       |                                                    ^
> 
> Remove the #ifdef in the header, as this only saves a few bytes,
> but would require ugly #ifdefs in each driver using it.
> Simplify the other user while we're at it.

Applied, thanks

-- 
~Vinod

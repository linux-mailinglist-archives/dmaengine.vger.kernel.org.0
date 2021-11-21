Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8720045852E
	for <lists+dmaengine@lfdr.de>; Sun, 21 Nov 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhKURCA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Nov 2021 12:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhKURCA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Nov 2021 12:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEC4D60E73;
        Sun, 21 Nov 2021 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637513934;
        bh=DcQmWAAu2hzVevIzFTvFCZ/6VlHnfAI9Bg1LDlVdlu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PX1wta7JlJjqJjqtmuw/4LEkg/pkhxNB8N6TPjNMBTB+ILGyV+dnFsipnD70+xdwr
         zcr4xL6W3/zyvc2W4R9dIErYHTwdHA3suymnve8iMS6VGM0uHgisd6WJzWrR+irebC
         BuM8/By0EFI9HiCTMBj8It5MYdwR7V1ANGKnlYYb/cnYH12i5mQlMX9N90qx85W2nH
         WjeTqmMkQQf7yc/xsUuUMRUJZ5tBhj0hYY+Vx1HNW1MYa3AXb/sGrE337eqwsBgLIg
         UfYYTrWju6j7xmHKY+cD+7f+52ChsVFB0hdyodE5XNRtzYNTwwhjtaOC1X2vFrXbh8
         aTGh3HNMuFXpQ==
Date:   Sun, 21 Nov 2021 22:28:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: compile error for 5.15.4
Message-ID: <YZp6yfVUx4eEwaxm@matsya>
References: <747802b9-6c5d-cdb5-66e2-05b820f5213c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <747802b9-6c5d-cdb5-66e2-05b820f5213c@gmx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,


On 21-11-21, 16:02, Toralf Förster wrote:
> Hi,
> 
> got this at a hardened stable Gentoo Server:
> 
> # uname -a
> Linux mr-fox 5.14.17 #1 SMP Thu Nov 18 14:02:58 CET 2021 x86_64 AMD
> Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
> 
> 
>   CC      net/ipv4/tcp_timer.o
>   CC      lib/raid6/sse1.o
> drivers/dma/ptdma/ptdma-debugfs.c: In function ‘ptdma_debugfs_setup’:
> drivers/dma/ptdma/ptdma-debugfs.c:93:54: error: ‘struct dma_device’ has
> no member named ‘dbg_dev_root’
>    93 |         debugfs_create_file("info", 0400,
> pt->dma_dev.dbg_dev_root, pt,

Can you please send your config file when you saw this, which toolchain
was used to compile...

Thanks

>       |                                                      ^
> drivers/dma/ptdma/ptdma-debugfs.c:96:55: error: ‘struct dma_device’ has
> no member named ‘dbg_dev_root’
>    96 |         debugfs_create_file("stats", 0400,
> pt->dma_dev.dbg_dev_root, pt,
>       |                                                       ^
> drivers/dma/ptdma/ptdma-debugfs.c:102:52: error: ‘struct dma_device’ has
> no member named ‘dbg_dev_root’
>   102 |                 debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
>       |                                                    ^
> make[3]: *** [scripts/Makefile.build:277:
> drivers/dma/ptdma/ptdma-debugfs.o] Error 1
> make[2]: *** [scripts/Makefile.build:540: drivers/dma/ptdma] Error 2
> make[1]: *** [scripts/Makefile.build:540: drivers/dma] Error 2
> make[1]: *** Waiting for unfinished jobs....
>   CC      mm/usercopy.o
>   CC      lib/argv_split.o
> 
> --
> Toralf

-- 
~Vinod

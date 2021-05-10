Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E518F3790E6
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhEJOh4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233361AbhEJOfz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 10:35:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB8346145F;
        Mon, 10 May 2021 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620657290;
        bh=AsAyoVw3jfOoeNKWiGPEY4r1KTurdncvzIM0msm/r78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNZ8mxbAn5KZvmuJUJXVqrbMriD+D/2EW/lXPgFWQQ0oWhkw4NIW/1Kb7cMe/wxV/
         wLqWLAgD48+3Pht/hFBH/3uDSNdTTRyxTwGu3NvL2MQmhL1cQQOllQHkhSnQbwAMjl
         j0aIfRNXOfnBnzfkZ6YAuEEbLFqhRJQrv1PbMwMHA+5E7gOnaYuZvb4YaReJGaIcVI
         5U7EF9NSzcydgcLMqDuSpLqj/HaG8LmzZSRbdyZBKUbdg930VBIG02IIrYwUfoKm0+
         pdvKhoHZDyJ05j3u5vLIJGXYc37vUYS9rm/yyOOoHwK9YXEBfdBJ2aeAqBJzRPU5yO
         UEEa48Vw1RQ+g==
Date:   Mon, 10 May 2021 20:04:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Remove redundant variable cdev_ctx
Message-ID: <YJlEhyv0c17EEaz7@vkoul-mobl.Dlink>
References: <1620298847-33127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620298847-33127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-21, 19:00, Jiapeng Chong wrote:
> Variable cdev_ctx is set to '&ictx[wq->idxd->data->type]' but this
> value is not used, hence it is a redundant assignment and can be
> removed.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/dma/idxd/cdev.c:300:2: warning: Value stored to 'cdev_ctx' is
> never read [clang-analyzer-deadcode.DeadStores].

Applied, thanks

-- 
~Vinod

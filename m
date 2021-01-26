Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D65304BCB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhAZVwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391784AbhAZRcu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:32:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9FD420449;
        Tue, 26 Jan 2021 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611682329;
        bh=aevOU/oAUIC45KM/PiKluJZqSZNzHEmWriiswuFkqh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqsBZ2WCzFqanJpjrpk5S3Hyq0sQRKB5+GVebNWa4w2G5eGpfYu6ICpYht+WZEDxC
         k4pBRKie0uopmyYHEyhLXuksXxvF09sy8/T0x4mhUdhfJ/sn4qO76QwJYJZHikWUfY
         I8WQ9EQN04UuYrQb4zYeuxT5Qu9SdicKD4zVtlJE3RkHwSgDFdLV9FVqd+T0mmfX0D
         AcrmY0R3+k5e0RwfjDCtG7+ODYIHjPcM0FEFnbmVNgJIn+NioYO5EwXR08sBYy9jqt
         NtQ2SL5LSiWJjVZTVkVqUbWjRFp4wsLtB36AUk17lpd49yNHepMDRTWIOKj4Xj1xTw
         ihrCh27jT1NRQ==
Date:   Tue, 26 Jan 2021 23:02:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peter.ujfalusi@gmail.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix a resource leak in an error
 handling path
Message-ID: <20210126173205.GZ2771@vkoul-mobl>
References: <20210124070923.724479-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124070923.724479-1-christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-01-21, 08:09, Christophe JAILLET wrote:
> In 'dma_pool_create()', we return -ENOMEM, but don't release the resources
> already allocated, as in all the other error handling paths.
> 
> Go to 'err_res_free' instead of returning directly.

Applied, thanks

-- 
~Vinod

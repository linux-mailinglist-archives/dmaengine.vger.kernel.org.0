Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8213687A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAJHqO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 02:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgAJHqO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 02:46:14 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90E42080D;
        Fri, 10 Jan 2020 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578642373;
        bh=8ADsNC4aByvOIz1Pl29Go90LRKxU6fl1luPK7QjlgWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szWnKRft82X+GbunxqZ3pu0hXwcVAwCZLFfKRZY8Mke2USKX8z12JHL8OM04UP8l5
         YA0KCp8m78f1vFwR3rqz7fdSW3q3FPj0/Q1Ho/RskDr2UQF7lw/bUHH01L380L582g
         m1uhyeN0AwP2HJWXyDuigxX3uTQobOINIUkw70Hs=
Date:   Fri, 10 Jan 2020 13:16:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
Message-ID: <20200110074605.GD2818@vkoul-mobl>
References: <20200109131953.157154-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109131953.157154-1-colin.king@canonical.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-01-20, 13:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to dev_get_platdata returns null the driver issues
> a warning and then later dereferences the null pointer.  Avoid this issue
> by returning -ENODEV errror rather when the platform data is null and

s/errror/error :) never thought would correct Colin on spelling :)

With the typo fixes:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD62F729E
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 06:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbhAOF5o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 00:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAOF5o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 00:57:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71192239EF;
        Fri, 15 Jan 2021 05:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610690223;
        bh=1nmZ8i/8wKH8oPQ6+f5znp4ICppZYRDs4o+6s2h3Rkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkedOrMRk3+x5MdhLl0BdjJjI00H3c81J1AdjoLI9T0/htTxpXmPsnN2dUHJ0MIEj
         4wHCxCxwz+F8M7GzrY2XYeURGOSQAGs1/0Y81b/sQY2jyy+NjyVD3yIjL+CJPVwgZL
         rsBcT3LA0kDKFd7n3xrtoNSwOFvCKUqtztFnIDxq3mLw+p0jyXA9qtNQEdun98+Xwq
         A6caIjQmAOPVIEmsHszxl08o3cbJt/8FzRWzGbMvsFOKL48S2pp2EOckZR9qLjb1mg
         Krs3XUrVvKSUlz72FhyPgobsRjfgrKz+NloQ9V4jelbdejG3nGYcmyxxMfPKAMWREl
         kwx9c3/ezRunA==
Date:   Fri, 15 Jan 2021 11:26:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rajesh Gumasta <rgumasta@nvidia.com>, ldewangan@nvidia.com,
        dan.j.williams@intel.com, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyarlagadda@nvidia.com
Subject: Re: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
Message-ID: <20210115055658.GD2771@vkoul-mobl>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <2a99ca73-a6e8-bf7d-a5c1-fa64eee62e23@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a99ca73-a6e8-bf7d-a5c1-fa64eee62e23@nvidia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-01-21, 10:11, Jon Hunter wrote:
> 
> On 06/08/2020 08:30, Rajesh Gumasta wrote:
> > Changes in patch v2:
> > Addressed review comments in patch v1
> 
> 
> Is there any update on this series? Would be good to get this upstream.

Not sure why, this is is not in my queue, can someone please resend this
to me

Thanks
-- 
~Vinod

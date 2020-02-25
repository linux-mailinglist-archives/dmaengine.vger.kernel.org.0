Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E482716B9C8
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 07:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBYGcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 01:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgBYGcF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 01:32:05 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CE32082F;
        Tue, 25 Feb 2020 06:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582612324;
        bh=CSADtHLh4uy2pwTG/rYHxSNpQhgO2kNjyWKWP0iqptM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/Bvtczk39lN5rbBvtV+gfxV123RLd+I7XzRpS7I8Jv3gGnoKaqXls8j4sGJh6kXh
         0TvJOrrKMgKUx460vWEr15bMoFcttkz9v77juDIvu6UUln1Y93A376YdM+Z70YwTMH
         7K+nbqto33kDlJfSQCzWNmacDKKDLgQSNtxFAK8k=
Date:   Tue, 25 Feb 2020 12:02:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/19] NVIDIA Tegra APB DMA driver fixes and
 improvements
Message-ID: <20200225063200.GL2618@vkoul-mobl>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-02-20, 19:33, Dmitry Osipenko wrote:
> Hello,
> 
> This series fixes some problems that I spotted recently, secondly the
> driver's code gets a cleanup. Please review and apply, thanks in advance!

Applied, thanks

One note I would like to add thanking you and Jon for the series :)

This version was pleasure to read. A patch should do *one* thing and
this series really illustrates this principal and as a result I enjoyed
reading the series and was able to do a quick review of the series,
notwithstanding the fact that it had 19 patches. So thanks to you and
Jon (i know he pushed for split etc) for the wonderful read.

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EA1BA9E4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD0QQH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgD0QQH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:16:07 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF8420661;
        Mon, 27 Apr 2020 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588004166;
        bh=vF6pAYTYMAPx012IelvrM3E528t214+5Ot5mFL9LoSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1yhNETHs56OlqB06quniflMw81J32MTvMa+PhpM4hffusd0Y76vH0XCnmY26DeG2
         5aLUvXUyI15zZwfqtJF/Zmt8sLrUhRzyLsLqin1jzy1J6uU7FiDf3QZGAU3ddzTdzI
         laxk+CXBMsnosMI1JG68EPID/A9Jkjiq7eh5bvT8=
Date:   Mon, 27 Apr 2020 21:46:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 1/6] dmaengine: dmatest: Fix iteration non-stop logic
Message-ID: <20200427161602.GK56386@vkoul-mobl.Dlink>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-20, 19:11, Andy Shevchenko wrote:
> Under some circumstances, i.e. when test is still running and about to
> time out and user runs, for example,
> 
> 	grep -H . /sys/module/dmatest/parameters/*
> 
> the iterations parameter is not respected and test is going on and on until
> user gives
> 
> 	echo 0 > /sys/module/dmatest/parameters/run
> 
> This is not what expected.
> 
> The history of this bug is interesting. I though that the commit
>   2d88ce76eb98 ("dmatest: add a 'wait' parameter")
> is a culprit, but looking closer to the code I think it simple revealed the
> broken logic from the day one, i.e. in the commit
>   0a2ff57d6fba ("dmaengine: dmatest: add a maximum number of test iterations")
> which adds iterations parameter.
> 
> So, to the point, the conditional of checking the thread to be stopped being
> first part of conjunction logic prevents to check iterations. Thus, we have to
> always check both conditions to be able to stop after given iterations.
> 
> Since it wasn't visible before second commit appeared, I add a respective
> Fixes tag.

Applied, thanks

-- 
~Vinod

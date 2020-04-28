Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6542C1BC4E7
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgD1QRS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 12:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgD1QRS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Apr 2020 12:17:18 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E472054F;
        Tue, 28 Apr 2020 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588090638;
        bh=LBJhSUdHln8NWnKFrlq/FYyYfigWpHCiW6wOyRgE9V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UewfCuYvW9R/rkNT8dLf7AzsOkEl0qtjh8vvuLXkSjiH5rBCWB/hk+dCqliDQesk5
         lwL4EV9U6ZJwET/gTpcQ3qD74+eTHenmqRcw5Pqqs2a/dJqvPAwxfoNh3x+Y6sREL+
         OqmTXjgQXknZ4591C2QApAvElbMnY3RZIvJGi104=
Date:   Tue, 28 Apr 2020 21:47:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Seraj Alijan <seraj.alijan@sondrel.com>
Subject: Re: [PATCH v2] dmaengine: dmatest: Fix process hang when reading
 'wait' parameter
Message-ID: <20200428161712.GH56386@vkoul-mobl.Dlink>
References: <20200428113518.70620-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428113518.70620-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-20, 14:35, Andy Shevchenko wrote:
> If we do
> 
>   % echo 1 > /sys/module/dmatest/parameters/run
>   [  115.851124] dmatest: Could not start test, no channels configured
> 
>   % echo dma8chan7 > /sys/module/dmatest/parameters/channel
>   [  127.563872] dmatest: Added 1 threads using dma8chan7
> 
>   % cat /sys/module/dmatest/parameters/wait
>   ... !!! HANG !!! ...
> 
> The culprit is the commit 6138f967bccc
> 
>   ("dmaengine: dmatest: Use fixed point div to calculate iops")
> 
> which makes threads not to run, but pending and being kicked off by writing
> to the 'run' node. However, it forgot to consider 'wait' routine to avoid
> above mentioned case.
> 
> In order to fix this, check for really running threads, i.e. with pending
> and done flags unset.
> 
> It's pity the culprit commit hadn't updated documentation and tested all
> possible scenarios.

Applied, thanks

-- 
~Vinod

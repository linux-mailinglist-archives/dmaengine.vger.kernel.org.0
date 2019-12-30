Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3340C12D494
	for <lists+dmaengine@lfdr.de>; Mon, 30 Dec 2019 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfL3Uu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Dec 2019 15:50:58 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:42812 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfL3Uu6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Dec 2019 15:50:58 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47mqMg3hdwz7N;
        Mon, 30 Dec 2019 21:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577739055; bh=D6pE2vl/kkbLtR1H8IVxWVLpVDxXAIHYPkU2/WyGfv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tye5sYpzS6VjUo4VZCCQu93l/t9f4co826/yhyaWwL3qRCesRzU8QeKYnY2+pSFK1
         iY0KezSDl4lDNJARhnmSthSxmctKRbBqZPfhjCfQAtPiO+U+7292yVBXL41L05DfRq
         IMWufUDAQTn0B5thDu3YIOwcHgxIo73stxW+RLMKTwthSSdyWNg4Y9rfxHkMh2R6KS
         Nh+UWNfSCA4np9BZOa+HyR35ndp84LuABM2fse36RjLtYfrpKMmMdGP3XWI63Et3cq
         hIZ+uRekJXg8rHFCW9UTK9MkRCLVV8C83h/aMXUkWdKg2HPUuvuCSZ3faxYnA9AB4Z
         xQvAfhxR4fyww==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Dec 2019 21:50:54 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
Message-ID: <20191230205054.GC24135@qmqm.qmqm.pl>
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
 <20191230204555.GB24135@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230204555.GB24135@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 30, 2019 at 09:45:55PM +0100, Micha³ Miros³aw wrote:
> On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
> > It's unsafe to check the channel's "busy" state without taking a lock,
> > it is also unsafe to assume that tasklet isn't in-fly.
> 
> 'in-flight'. Also, the patch seems to have two independent bug-fixes
> in it. Second one doesn't look right, at least not without an explanation.
> 
> First:
> 
> > -	if (tdc->busy)
> > -		tegra_dma_terminate_all(dc);
> > +	tegra_dma_terminate_all(dc);
> 
> Second:
> 
> > +	tasklet_kill(&tdc->tasklet);

BTW, maybe you can convert the code to threaded interrupt handler and
just get rid of the tasklet instead of fixing it?

Best Regards,
Micha³ Miros³aw

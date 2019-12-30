Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1312D48F
	for <lists+dmaengine@lfdr.de>; Mon, 30 Dec 2019 21:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfL3Up7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Dec 2019 15:45:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:19990 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfL3Up7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Dec 2019 15:45:59 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47mqFw56cFz7N;
        Mon, 30 Dec 2019 21:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577738757; bh=s8g4G6MZBSj/JWYHiBIoQB/A8P4MtqlOvvb/SvdlSCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDha4HNHARaXWKwkXfwXhdcJhvvlxLkCKi4YkvuMri5gDvcBQOfLwG6NM9mp2XQhE
         g0I4h4JM3kJlDcoOI0jX3vOedeQzgzGN9x4zbd/ERKZ4ViZYvGXCqUR5kmCdD9J01l
         4OqseEfhCnRpJkWYaJ0IP6MGB9phe9Jo2hDy7ezUZjEVEx1DLby3lk71A/6KOzRbw2
         ZNtsNx8cZg/8tcy3fExnRHePQMY/vPU8xwOQm4bWllLFFP1nhAh8nEm6rnPczwMGbG
         9L2ij2VfuX5hCwived2I6oiMASBbE1ZFaFaYcnsTnzVqVUa5EQQfwEloAp+RABrTon
         hW+YBvA70zupw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Dec 2019 21:45:55 +0100
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
Message-ID: <20191230204555.GB24135@qmqm.qmqm.pl>
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228204640.25163-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
> It's unsafe to check the channel's "busy" state without taking a lock,
> it is also unsafe to assume that tasklet isn't in-fly.

'in-flight'. Also, the patch seems to have two independent bug-fixes
in it. Second one doesn't look right, at least not without an explanation.

First:

> -	if (tdc->busy)
> -		tegra_dma_terminate_all(dc);
> +	tegra_dma_terminate_all(dc);

Second:

> +	tasklet_kill(&tdc->tasklet);
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
> @@ -1543,7 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		struct tegra_dma_channel *tdc = &tdma->channels[i];
>  
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);
> @@ -1563,7 +1562,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
>  	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
>  		tdc = &tdma->channels[i];
>  		free_irq(tdc->irq, tdc);
> -		tasklet_kill(&tdc->tasklet);
>  	}
>  
>  	pm_runtime_disable(&pdev->dev);

Best Regards,
Micha³ Miros³aw

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47734BC3C0
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503940AbfIXIFO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 04:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503939AbfIXIFO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 04:05:14 -0400
Received: from localhost (unknown [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA50207FD;
        Tue, 24 Sep 2019 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569312313;
        bh=rzf24i5MOO6JLM6uk7Ln1hDt9nruRckWWZNiYKKdNuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vgc7lkZzopNzeioAQ+OdFSLVSTZTT0hxd6e1y57S+wM86h+D2jRlJbyTeeelCEGKA
         4A9/zftChp1wFfF2Zfqtr605BpAwI28u0cD96tVI02I03nJt3dhga7f+uVGp+ZwP0O
         R1PeyO7fnwTiaPVtS6+1qNz7bPH8RrRjs54TGcmo=
Date:   Tue, 24 Sep 2019 10:05:03 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: Add debugfs entries for PTDMA information
Message-ID: <20190924080503.GA564935@kroah.com>
References: <1569310357-29271-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569310357-29271-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 24, 2019 at 07:33:02AM +0000, Mehta, Sanju wrote:
> +static const struct file_operations pt_debugfs_info_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_info_read,
> +	.write = NULL,
> +};
> +
> +static const struct file_operations pt_debugfs_queue_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_queue_read,
> +	.write = ptdma_debugfs_queue_write,
> +};
> +
> +static const struct file_operations pt_debugfs_stats_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = ptdma_debugfs_stats_read,
> +	.write = ptdma_debugfs_stats_write,
> +};

Can you use DEFINE_SIMPLE_ATTRIBUTE() here intead of these?

thanks,

greg k-h

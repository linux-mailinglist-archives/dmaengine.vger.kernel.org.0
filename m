Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6932BCC90
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfIXQir (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 12:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbfIXQiq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 12:38:46 -0400
Received: from localhost (unknown [12.157.10.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F357A20872;
        Tue, 24 Sep 2019 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343126;
        bh=SljDFFMo90crqwi671Z3O1CEkHPiBtOHyj4ru/WL+RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJtsyQR/QJh5MBrSmme4Yi4JJeupeEh5dasYT1OYhrA8RDK70k+BAF6YqccEpZarI
         1d7xI1+VwKxRJJmjWBE/cQAHwNdbBWOsu96uCluF8eottaxzEO5/27sv+A/CATMJix
         UeVIBUoCb5IXuoMGXuaPVSzfN9VMnlR2UiVR4IFo=
Date:   Tue, 24 Sep 2019 09:37:44 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Kumar, Rajesh" <Rajesh1.Kumar@amd.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 0/4] *** AMD PTDMA driver ***
Message-ID: <20190924163744.GC3824@vkoul-mobl>
References: <1569310236-29113-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569310236-29113-1-git-send-email-Sanju.Mehta@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-19, 07:31, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> *** This patch series adds support for AMD PTDMA engine ***

What lots of stars!

Can you describe the controller a bit more to help people set the
context for the review!

And also helps to make the email subject as "Add AMD PTDMA driver ...."
or similar!

> 
> Sanjay R Mehta (4):
>   dma: Add PTDMA Engine driver support
>   dma: Support for multiple PTDMA
>   dmaengine: Register as a DMA resource
>   dmaengine: Add debugfs entries for PTDMA information

Can you be consistent with naming, and yes do use dmaengine!

> 
>  MAINTAINERS                         |   6 +
>  drivers/dma/Kconfig                 |   2 +
>  drivers/dma/Makefile                |   1 +
>  drivers/dma/ptdma/Kconfig           |   8 +
>  drivers/dma/ptdma/Makefile          |  12 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 249 +++++++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 445 +++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 700 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-ops.c       | 464 ++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 244 +++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 563 +++++++++++++++++++++++++++++
>  11 files changed, 2694 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-ops.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
> 
> -- 
> 2.7.4

-- 
~Vinod

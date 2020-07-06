Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7602151E0
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 06:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgGFEsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 00:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgGFEsa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 00:48:30 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0A420720;
        Mon,  6 Jul 2020 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594010910;
        bh=saajXkjFZV5Ysay/V5yS2+LctG2zyPPXgCNYyixmBgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8QMvTN/gVISdfC7gmwMxMOxgudEVlVFrB9e4xhjcdL6RTBc/mgQM7pZj72Gtycmv
         ohIo6GAY8xfkvM0ae8iHztQNqQL9SJopoEchCTMXAx+6NrAxmWhxIHuEb3w7k8MNZl
         ObXOA/9Fe0bv3YA6Qd3KXpJCm1Yzo6/moH2aUJ+k=
Date:   Mon, 6 Jul 2020 10:18:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH 01/17] Documentation/driver-api: dmaengine/provider: drop
 doubled word
Message-ID: <20200706044824.GB633187@vkoul-mobl>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-2-rdunlap@infradead.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-07-20, 20:44, Randy Dunlap wrote:
> Drop the doubled word "has".

Applied, thanks

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>  Documentation/driver-api/dmaengine/provider.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/dmaengine/provider.rst
> +++ linux-next-20200701/Documentation/driver-api/dmaengine/provider.rst
> @@ -507,7 +507,7 @@ dma_cookie_t
>  DMA_CTRL_ACK
>  
>  - If clear, the descriptor cannot be reused by provider until the
> -  client acknowledges receipt, i.e. has has a chance to establish any
> +  client acknowledges receipt, i.e. has a chance to establish any
>    dependency chains
>  
>  - This can be acked by invoking async_tx_ack()

-- 
~Vinod

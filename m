Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6C8ADE6
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 06:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfHMEjc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 00:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfHMEjb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Aug 2019 00:39:31 -0400
Received: from localhost (unknown [106.201.103.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366ED2054F;
        Tue, 13 Aug 2019 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565671171;
        bh=Yq3xjgq9j2Zb+0ptLtoV2Vl9gStxTv3sh2uj5jTv/4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPwpGrIvgTxtkfOL3WGglWuwIKmyDZsJHU/qtEEfGMyLgQ3WgMSwHwiVV9zpZPW2C
         C5h0JSbW+KMT4MGShNUQEaKgx+JzQpLtl2dirI6PVbmkc0MOOfb3pxTYvIbWTcfsSY
         5MjQtn1/bN2ZjUB/g7VENKRWhRvD1d3z+8gku1kc=
Date:   Tue, 13 Aug 2019 10:08:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsldma: Mark expected switch fall-through
Message-ID: <20190813043818.GQ12733@vkoul-mobl.Dlink>
References: <20190812002159.GA26899@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812002159.GA26899@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-08-19, 19:22, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warning (Building: powerpc-ppa8548_defconfig powerpc):
> 
> drivers/dma/fsldma.c: In function ‘fsl_dma_chan_probe’:
> drivers/dma/fsldma.c:1165:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
>    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/dma/fsldma.c:1166:2: note: here
>   case FSL_DMA_IP_83XX:
>   ^~~~

Applied, thanks

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865287C61A
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfGaPUp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 11:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfGaPUk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Jul 2019 11:20:40 -0400
Received: from localhost (unknown [171.76.116.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D1E206A2;
        Wed, 31 Jul 2019 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586440;
        bh=QQQ+QpM+RhFqQ/ypjrNEtcmyaMXt5cOebJM7X911U3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZCgA5KOSkUePqoFiBh0M+XwmYjYgiRh+LRMt1765PUQknMeWMvNsOxFTSLJK3gHo
         y4+GodC/ycKnCTdhjcpBlyW1h9rTqiSLP+rAkqY/D9LNoeSD+03Od3J/XoD1buGMgT
         MNKRX12rtv77Quy7hh4WPRwk88B39600tDSGJMCg=
Date:   Wed, 31 Jul 2019 20:49:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] dmaengine: imx-dma: Mark expected switch fall-through
Message-ID: <20190731151926.GV12733@vkoul-mobl.Dlink>
References: <20190729225221.GA24269@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729225221.GA24269@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-19, 17:52, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: arm):
> 
> drivers/dma/imx-dma.c: In function ‘imxdma_xfer_desc’:
> drivers/dma/imx-dma.c:542:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (slot == IMX_DMA_2D_SLOT_A) {
>       ^
> drivers/dma/imx-dma.c:559:2: note: here
>   case IMXDMA_DESC_MEMCPY:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.

Applied, thanks

-- 
~Vinod

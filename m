Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995AE206BE9
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 07:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgFXFqI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 01:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFXFqH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 01:46:07 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9890520768;
        Wed, 24 Jun 2020 05:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592977567;
        bh=A9yszn8fIAIjZK8KBhcQX82+P0BFKY8MrSA2lz2ouXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HItW1RBc2IXZV2kdlBL5KcEt32Z5z1YZr1wRYEqSMZsNA9fRZfKyTqVUokR1+9GRT
         aFcpfAZJOUIhwgral9ad6SPAU+XFgvP20o2Zpj1y4cCQr+7haXYkqGuJ3vgr3vC2P3
         tM4jcEriQm4iOWXmqMfv+/tZEm6eCPJ1oksGYXkU=
Date:   Wed, 24 Jun 2020 11:16:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     frieder.schrempf@kontron.de, dmaengine@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix: Remove 'always true' comparison
Message-ID: <20200624054601.GV2324254@vkoul-mobl>
References: <20200621155730.28766-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621155730.28766-1-festevam@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-06-20, 12:57, Fabio Estevam wrote:
> event_id0 is defined as 'unsigned int', so it is always greater or
> equal to zero.
> 
> Remove the unneeded comparisons to fix the following W=1 build
> warning:
> 
> drivers/dma/imx-sdma.c: In function 'sdma_free_chan_resources':
> drivers/dma/imx-sdma.c:1334:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 1334 |  if (sdmac->event_id0 >= 0)
> |                       ^~
> drivers/dma/imx-sdma.c: In function 'sdma_config':
> drivers/dma/imx-sdma.c:1635:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 1635 |  if (sdmac->event_id0 >= 0) {
> |               

Applied, thanks

-- 
~Vinod

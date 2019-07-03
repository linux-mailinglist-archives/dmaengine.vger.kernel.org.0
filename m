Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FD5DF32
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCH6z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 03:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCH6z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Jul 2019 03:58:55 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F082187F;
        Wed,  3 Jul 2019 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562140734;
        bh=o8CDE8Xa/PjXz5Kxt0YS/QOSACl5/xwyB+R139QKXB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUN8Xm7d2yELQE98IA7eaL5iFwyqIJY9l1ZsHsJ7jiTnWA3msEEvE2GL6eKmuySD9
         28FOtxEZG+3qrr6rwcYiZV1vAJL/ozALYwfWWmDnO1KhgXf+2l0RQvL0Tszi4nfaIa
         W8HeusVNrrIruqHDs3qoDwia8MT7UFdPqgvEiI34=
Date:   Wed, 3 Jul 2019 13:25:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     krzk@kernel.org, cphealy@gmail.com, peng.ma@nxp.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] Revert "dmaengine: fsl-edma: support little endian
 for edma driver"
Message-ID: <20190703075543.GQ2911@vkoul-mobl>
References: <20190702164852.3195-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702164852.3195-1-festevam@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-07-19, 13:48, Fabio Estevam wrote:
> This reverts commit 002905eca5bedab08bafd9e325bbbb41670c7712.
> 
> Commit 002905eca5be ("dmaengine: fsl-edma: support little endian for edma
> driver") incorrectly assumed that there was not little endian support
> in the driver.
> 
> This causes hangs on Vybrid, so revert it so that Vybrid systems
> could boot again.

The patch title should be:
dmaengine: Revert "dmaengine: fsl-edma: support little endian for edma
driver"

I fixed that up and applied now

-- 
~Vinod

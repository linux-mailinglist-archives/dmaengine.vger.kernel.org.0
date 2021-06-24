Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A753B2D73
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFXLRJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 07:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhFXLRI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 07:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F194E600CC;
        Thu, 24 Jun 2021 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624533289;
        bh=Yor6GmrIgTWlrEW6KcBitxP2lxqc2gFCBSASC2F5PGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU/O75oE6mjt7A9w/dOmDFWxoIOomnR92dNZXCSzs23Bh92svPj29uOA0GbgptBQr
         /QnlXAhIqwIvg5r6evnK4OGjB5F83Po7/htLtzM1/Axe0cZKz87Ha7ogBbt4Dqpzvt
         YTmHumPlVvO8roN6oQLNNZPjIkpoEdxjIYD3OsDE29vOpcr/Xt2SkASadaoQcLQDm/
         qXcgsLi+jKNcW9zqtCoVgIC2X8HZdot80PTNHV09gxl5iONJm9hrQfMLSjP14dnLu1
         FKCz9Bqobl0KEYfiBFVM9u387t/ZxJOn1jhWC9X0l3eou291+YwpXytPOpy1Z2KJr+
         ohCwxqDst9VFQ==
Date:   Thu, 24 Jun 2021 16:44:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Remove platform data header
Message-ID: <YNRpJtz7ifOYBQ2t@matsya>
References: <20210620191103.156626-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620191103.156626-1-vz@mleia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-21, 22:11, Vladimir Zapolskiy wrote:
> Since commit 6c5f05a6cd88 ("ARM: imx3: Remove imx3 soc_init()")
> there are no more users of struct sdma_script_start_addrs outside
> of the driver itself, thus let's move the struct declaration just
> to the driver source code and remove the header file as unused one.

Applied, thanks

-- 
~Vinod

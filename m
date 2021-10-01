Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3441E946
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbhJAI55 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhJAI55 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Oct 2021 04:57:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746C9C061775
        for <dmaengine@vger.kernel.org>; Fri,  1 Oct 2021 01:56:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mWEKw-0004mI-Og; Fri, 01 Oct 2021 10:56:10 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mWEKw-00041u-55; Fri, 01 Oct 2021 10:56:10 +0200
Date:   Fri, 1 Oct 2021 10:56:10 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, kernel@pengutronix.de
Subject: Re: [PATCH 0/7] dmaengine: zynqmp_dma: fix lockdep warning and
 cleanup
Message-ID: <20211001085610.GD28226@pengutronix.de>
References: <20210826094742.1302009-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210826094742.1302009-1-m.tretter@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:54:53 up 225 days, 12:18, 134 users,  load average: 0.18, 0.29,
 0.26
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 26 Aug 2021 11:47:35 +0200, Michael Tretter wrote:
> I reported a lockdep warning in the ZynqMP DMA driver a few weeks ago [0].
> This series fixes the reported warning and performs some cleanup that I found
> while looking at the driver more closely.
> 
> Patches 1-4 are the cleanups. They affect the log output of the driver, allow
> to compile the driver on other platforms when COMPILE_TEST is enabled, and
> remove unused included header files from the driver.
> 
> Patches 5-7 aim to fix the lockdep warning. Patch 5 and 6 restructure the
> locking in the driver to make it more fine-grained instead of holding the lock
> for the entire tasklet. Patch 7 finally fixes the warning.

Gentle ping.

Michael

> 
> Michael
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20210601130108.GA12967@pengutronix.de/
> 
> Michael Tretter (7):
>   dmaengine: zynqmp_dma: simplify with dev_err_probe
>   dmaengine: zynqmp_dma: drop message on probe success
>   dmaengine: zynqmp_dma: enable COMPILE_TEST
>   dmaengine: zynqmp_dma: cleanup includes
>   dmaengine: zynqmp_dma: cleanup after completing all descriptors
>   dmaengine: zynqmp_dma: refine dma descriptor locking
>   dmaengine: zynqmp_dma: fix lockdep warning in tasklet
> 
>  drivers/dma/Kconfig             |  2 +-
>  drivers/dma/xilinx/zynqmp_dma.c | 67 +++++++++++++++++----------------
>  2 files changed, 35 insertions(+), 34 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

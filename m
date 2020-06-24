Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D926206C26
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgFXGFT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgFXGFS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:05:18 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965B9207DD;
        Wed, 24 Jun 2020 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978718;
        bh=qghxJVkkiMtbRfQ/7Mj6wJLlOvY1Uw7KdE34MrVEL8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAfLleMJAysulcapubK8TBWNSkbmmaZZwroyqS+YlQaAb+NTEx+zhW6JqVVoI79rh
         KRL4tufD9YkGtQodvTLF/PTCgY0mFzvyRwNQ3swQB6tGC3MS0hM61HuY/DY7SSLWmY
         /KKwvpmWdFsgRHH3DviBEs7eQ+UyjKoKxdymSlcw=
Date:   Wed, 24 Jun 2020 11:35:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sh: usb-dmac: set tx_result parameters
Message-ID: <20200624060514.GC2324254@vkoul-mobl>
References: <1592482053-19433-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592482053-19433-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-20, 21:07, Yoshihiro Shimoda wrote:
> A client driver (renesas_usbhs) assumed that
> dmaengine_tx_status() could return the residue even if
> the transfer was completed. However, this was not correct
> usage [1] and this caused to break getting the residue after
> the commit 24461d9792c2 ("dmaengine: virt-dma: Fix access after
> free in vchan_complete()") actually. So, this is possible to get
> wrong received size if the usb controller gets a short packet.
> For example, g_zero driver causes "bad OUT byte" errors.
> 
> To use the tx_result from the renesas_usbhs driver when
> the transfer is completed, set the tx_result parameters.
> 
> Notes that the renesas_usbhs driver needs to update for it.
> 
> [1]
> https://lore.kernel.org/dmaengine/20200616165550.GP2324254@vkoul-mobl/

Applied, thanks

-- 
~Vinod

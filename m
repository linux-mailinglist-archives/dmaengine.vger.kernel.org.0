Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4D52239
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFYEnZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFYEnY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:43:24 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6F320665;
        Tue, 25 Jun 2019 04:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561437803;
        bh=+svs1xm0F2/CdYWQbH30vJyA8MQxdVc1RKbfdXbmfn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02tb7MAIsylFHaBkdmn1s9wKrHFWBomvZc0RQKO3xWkT1lvq0XxxYTDUGatspxZ+K
         r8H2n4NOLYN0339SPYo7VgJ8m7s/QKU2x5lKHQjsdh/n+ZbGKgLvBd4jYqxk9nG84V
         61udSRhPhjErNptANGH+WsdajYE0mTfMMRqpMy8w=
Date:   Tue, 25 Jun 2019 10:10:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA
 requests
Message-ID: <20190625044013.GL2962@vkoul-mobl>
References: <20190624123818.20919-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624123818.20919-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-19, 14:38, Geert Uytterhoeven wrote:
> While the .device_prep_slave_sg() callback rejects empty scatterlists,
> it still accepts single-entry scatterlists with a zero-length segment.
> These may happen if a driver calls dmaengine_prep_slave_single() with a
> zero len parameter.  The corresponding DMA request will never complete,
> leading to messages like:
> 
>     rcar-dmac e7300000.dma-controller: Channel Address Error happen
> 
> and DMA timeouts.
> 
> Although requesting a zero-length DMA request is a driver bug, rejecting
> it early eases debugging.  Note that the .device_prep_dma_memcpy()
> callback already rejects requests to copy zero bytes.

Applied, thanks

-- 
~Vinod

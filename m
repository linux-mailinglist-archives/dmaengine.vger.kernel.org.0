Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69B52234
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFYElp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFYElp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:41:45 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3047B20665;
        Tue, 25 Jun 2019 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561437703;
        bh=+svs1xm0F2/CdYWQbH30vJyA8MQxdVc1RKbfdXbmfn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjDHLFkECUqfmBrB6XzMV6RGFbWvfcCeasIkpZtutySDEKLgJ07zd2tmEN4LyN8om
         q566uosEJ6XjdH3ProvBEG7beGqqUrHiuPP3DA39BzUVk1krp1S923MpTqtQcqV9Sn
         voabsvHph35dQK78AjCT0f7Dl19ooAYla/Yx4eoM=
Date:   Tue, 25 Jun 2019 10:08:33 +0530
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
Message-ID: <20190625043833.GK2962@vkoul-mobl>
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

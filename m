Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36F1D5BC1
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfJNG6H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 02:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730080AbfJNG6H (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 02:58:07 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C2220673;
        Mon, 14 Oct 2019 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571036287;
        bh=j+ZrsNnjof4PoEK/2IEQvlBYczLMVw1tpD+JZhWdrVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wb2Z2KvHPcPM22VfNaSIPzAcvAqngWNI2/BVZI5JOc2bSKao6YsK+xPhydVnTRiWl
         fP+cRr4vCnwyAczxLIchLLL6HxM/IOdw3oBpGrl0/S1XI7WEjAlsb+MAl+nPgr07cs
         VxqoAMY+oMhL1e4cQRd2vCxFYF+K6d5wZOflOx5Y=
Date:   Mon, 14 Oct 2019 12:28:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     vinod.koul@intel.com, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 0/4] dmaengine: rcar-dmac: use of_data and add
 dma-channel-mask support
Message-ID: <20191014065802.GA2654@vkoul-mobl>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-09-19, 15:34, Yoshihiro Shimoda wrote:
> This patch series is based on the latest slave-dma.git / next branch.
> 
> Changes from v2:
>  - Rebase the latest slave-dma.git / next branch (In other words,
>    this patch series doesn't depend any other branches.
>  - Cherry-picked a patch which is contained in v5.3-rc8 to solve any
>    dependency. (I'm not sure whether this is a right way or not...)
>   https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=169317

Sorry for delay, I was on vacation + conference. Yeah ideally I would
merge fixes and this wouldn't be the case.

patch1 is no longer needed now, I have applied the rest

Thanks
-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD8A436F
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2019 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHaIuA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 31 Aug 2019 04:50:00 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50368 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaIuA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 31 Aug 2019 04:50:00 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2077E25AD78;
        Sat, 31 Aug 2019 18:49:58 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id F1C50E218F0; Sat, 31 Aug 2019 10:49:55 +0200 (CEST)
Date:   Sat, 31 Aug 2019 10:49:55 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
Message-ID: <20190831084955.uzywev5gu5iudztj@verge.net.au>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 28, 2019 at 08:13:54PM +0900, Yoshihiro Shimoda wrote:
> The commit 20c169aceb45 ("dmaengine: rcar-dmac: clear pertinence
> number of channels") always set the DMACHCLR bit 0 to 1, but if
> iommu is mapped to the device, this driver doesn't need to clear it.
> So, this patch takes care of it by using "channels_mask" bitfield.
> 
> Note that, this patch doesn't have a "Fixes:" tag because the driver
> doesn't manage the channel 0 anyway so that the behavior of
> the channel is not changed.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


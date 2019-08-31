Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DBA4372
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2019 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHaIuI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 31 Aug 2019 04:50:08 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50394 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaIuI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 31 Aug 2019 04:50:08 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 62C0C25AD78;
        Sat, 31 Aug 2019 18:50:06 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 570ECE218F0; Sat, 31 Aug 2019 10:50:04 +0200 (CEST)
Date:   Sat, 31 Aug 2019 10:50:04 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: rcar-dmac: Add dma-channel-mask property
 support
Message-ID: <20190831085003.x7pnitsppctlig7i@verge.net.au>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566990835-27028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 28, 2019 at 08:13:55PM +0900, Yoshihiro Shimoda wrote:
> This patch adds dma-channel-mask property support not to reserve
> some DMA channels for some reasons. (for example: a heterogeneous
> CPU uses it.)
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


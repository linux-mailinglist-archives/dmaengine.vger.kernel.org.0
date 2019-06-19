Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B034BACE
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFSOJY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 10:09:24 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:36736 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSOJY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 10:09:24 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1357025B75F;
        Thu, 20 Jun 2019 00:09:22 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 181D39409FF; Wed, 19 Jun 2019 16:09:20 +0200 (CEST)
Date:   Wed, 19 Jun 2019 16:09:20 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: usb-dmac: Use [] to denote a flexible
 array member
Message-ID: <20190619140919.gato77ta3srjgina@verge.net.au>
References: <20190619124555.12701-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619124555.12701-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 19, 2019 at 02:45:55PM +0200, Geert Uytterhoeven wrote:
> Flexible array members should be denoted using [] instead of [0], else
> gcc will not warn when they are no longer at the end of the structure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEDB1A1B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfIMIsu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 04:48:50 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43750 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfIMIst (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Sep 2019 04:48:49 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id BDB7125AEB1;
        Fri, 13 Sep 2019 18:48:47 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AD510940513; Fri, 13 Sep 2019 10:48:45 +0200 (CEST)
Date:   Fri, 13 Sep 2019 10:48:45 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     vinod.koul@intel.com, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dmaengine: rcar-dmac: Use of_data values instead
 of a macro
Message-ID: <20190913084844.2udw3vfgbsnz27qm@verge.net.au>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1568010892-17606-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568010892-17606-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 09, 2019 at 03:34:50PM +0900, Yoshihiro Shimoda wrote:
> Since we will have changed memory mapping of the DMAC in the future,
> this patch uses of_data values instead of a macro to calculate
> each channel's base offset.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB16265F49
	for <lists+dmaengine@lfdr.de>; Fri, 11 Sep 2020 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKMLl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Sep 2020 08:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgIKMLB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Sep 2020 08:11:01 -0400
Received: from localhost (unknown [122.171.196.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D7C21D40;
        Fri, 11 Sep 2020 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826216;
        bh=kj5Lm6VUA6EK7T0wL0x7qpdt/QS6kUn32+D05hc5vsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuN0FUN/occB8J3AiXYFus5rnqO6JpJ3m8qntyG9lW+fshNfegMIdHnoJ+Nibyq4R
         MC3VFRAT8UJeUb1hXBgyb2NRtUfhe4FIvZDtFqmjGnGbUNOVl4l72h2JJusVVEwNkW
         aJG2DDwvg5tMUC4Gmsh7YTGtU+HAIB1PhONIeDoM=
Date:   Fri, 11 Sep 2020 17:40:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Brad Kim <brad.kim@sifive.com>
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        Brad Kim <brad.kim@semifive.com>
Subject: Re: [PATCH] dmaengine: sf-pdma: Fix an error that calls callback
 twice
Message-ID: <20200911121008.GY77521@vkoul-mobl>
References: <20200903111726.3413-1-brad.kim@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903111726.3413-1-brad.kim@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-09-20, 20:17, Brad Kim wrote:
> Because a callback is called twice when DMA transfer complete
> the second callback may be possible to access a freed memory
> if the first callback routines perform the dma_release_channel function.
> So this patch serialized the callback functions

Applied, thanks

-- 
~Vinod

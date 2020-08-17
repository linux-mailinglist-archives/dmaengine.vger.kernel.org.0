Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972F4245C04
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHQFon (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgHQFol (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:44:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40AA3206FA;
        Mon, 17 Aug 2020 05:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597643081;
        bh=aqIsg2MDXKpvMXXPQ5wP3TKUruW1MuQtK/g5YmaXzcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWK7fnFdl1g9pGQK6EXMuPWBCnLkYmVnwL0Ico816DgwJZ7qnPvYW8LeUVio3mKoq
         GDZpoYgtXvhGAWMOb3wz5ccfFqGFCIUZB8wF7V3Zl1dcWkZyWyAcvFwlEoRjXys3s8
         CkXd/Dq0Mu8pyinGUqt1GW7hstXXdiHteknPLIvk=
Date:   Mon, 17 Aug 2020 11:14:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: of-dma: Fix of_dma_router_xlate's
 of_dma_xlate handling
Message-ID: <20200817054435.GK2639@vkoul-mobl>
References: <20200806104928.25975-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806104928.25975-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-20, 13:49, Peter Ujfalusi wrote:
> of_dma_xlate callback can return ERR_PTR as well NULL in case of failure.
> 
> If error code is returned (not NULL) then the route should be released and
> the router should not be registered for the channel.

Applied, thanks

-- 
~Vinod

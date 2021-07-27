Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FD3D7544
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhG0Mpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 08:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0Mpx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 08:45:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9641661A54;
        Tue, 27 Jul 2021 12:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627389953;
        bh=44Ab1AahffvqgzX7A7vVHonmxfzoPwtiEK6WPpUodYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5wCltUf2En9P2cL9BaNr7hr3zdk4LiLZngkRjExegVKxTpa8tMNqwUa1/dMMT8i3
         wbFEyy7vjtLtyxxaCYPZf8bh9Q6x8zPdgCRKDLL2M+6GbyczO/DVqMAsE8wQLbS5Vc
         LHqoq3FomSR/wCV79jmocF48nhZSOogIrxXr4YA3x6LzuQlaZnoUb4NWK04aQuTK2W
         TetUilgIj59fr87vCMCWgnGr9f03G444Xv1J21M46ghJB0mBRTp05rQooVDfFN8waI
         yt5H3jDBGIhh+sWiA12XxyO/K5K0bec/2kwUaVOU2Btxzh1imknpIVEzWbTygwxXWS
         SgYkqj2RrK92A==
Date:   Tue, 27 Jul 2021 18:15:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: uniphier-xdmac: Use
 readl_poll_timeout_atomic() in atomic state
Message-ID: <YP///aRr+/eR5viL@matsya>
References: <1627364852-28432-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627364852-28432-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-07-21, 14:47, Kunihiko Hayashi wrote:
> The function uniphier_xdmac_chan_stop() is only called in atomic state.
> Should use readl_poll_timeout_atomic() there instead of
> readl_poll_timeout().

Applied, thanks

-- 
~Vinod

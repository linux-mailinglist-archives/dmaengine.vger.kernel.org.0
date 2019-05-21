Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BD246E0
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfEUEaO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfEUEaN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:30:13 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9BE21743;
        Tue, 21 May 2019 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558413013;
        bh=NvgrzL9IzQcSGcTQMFaifUuVeEcbwClCUo/89xh6gjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VN82rvt4UcoNg4FeKa4lwNJbvxwZptyIv5eLhtWOHf0bNW8djto1wYrfTA7UYEY3W
         hzhevuGUthWwppLEJ7YPeWqNR1ozHSQ9OnBSShsetrnl3Gz+z/xKeGV2Ky8M9g7nPm
         NYcvAosWCVyrwLpVEnSi/c1w8EMNyDPFPL1VRqCQ=
Date:   Tue, 21 May 2019 10:00:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Dan Williams <dan.j.williams@intel.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: jz4780: Fix transfers being ACKed too soon
Message-ID: <20190521043009.GK15118@vkoul-mobl>
References: <20190504213757.6693-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504213757.6693-1-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-19, 23:37, Paul Cercueil wrote:
> When a multi-descriptor DMA transfer is in progress, the "IRQ pending"
> flag will apparently be set for that channel as soon as the last
> descriptor loads, way before the IRQ actually happens. This behaviour
> has been observed on the JZ4725B, but maybe other SoCs are affected.
> 
> In the case where another DMA transfer is running into completion on a
> separate channel, the IRQ handler would then run the completion handler
> for our previous channel even if the transfer didn't actually finish.
> 
> Fix this by checking in the completion handler that we're indeed done;
> if not the interrupted DMA transfer will simply be resumed.

Applied, thanks

-- 
~Vinod

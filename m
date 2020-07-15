Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6D2204A6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 07:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgGOFzf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 01:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGOFzf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 01:55:35 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D95620663;
        Wed, 15 Jul 2020 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792535;
        bh=nvGTsPzBDL/2LFcF2SnsYKiCK59Dx5m/R/SiFd5N+BU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYVl3MLud38NQquULtVJs8uVqlfrRupz53UmhCq1v+dirY80IKIohW6MVZeYxhA55
         PoTJjMVOylD2KBTlRjSElf15jEaDDpwj54eJ/XQ0YEYs28htHOCac8LPeaDZ2bkrHq
         RnlqNagLQjxDDcVJbCtaIGWweC3CLzKlhyXDvdss=
Date:   Wed, 15 Jul 2020 11:25:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] dmaengine: pl330: Improve transfer efficiency
 for the dregs
Message-ID: <20200715055531.GT34333@vkoul-mobl>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
 <1593439555-68130-3-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439555-68130-3-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-20, 22:05, Sugar Zhang wrote:
> Only the unaligned burst transfers have the dregs.
> so, still use BURST transfer with a reduced size
> for better performance.

Applied, thanks

-- 
~Vinod

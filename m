Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635E2204AB
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGOF4F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 01:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgGOF4F (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 01:56:05 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F184220663;
        Wed, 15 Jul 2020 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594792565;
        bh=WngwdGyYHv54+sJ4atFfeahvAQwaQ/tvDayGd66RYAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWjnonOMHsVKh8pGao0XttIFQLkJfxxmoZlR5YNZnk3vP98LwQSOw2RibmmR6C/x5
         l9IGnYTZMUZ3g/uXhp8NxS8zI+LzY3gionXVHP7Slu8p4ZI5WT98LGlK+7dp37x3m8
         mscG1Z3Tu2NptPRVGEPlHkFpg2GkbQaa0bhP3njI=
Date:   Wed, 15 Jul 2020 11:26:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/14] dmaengine: pl330: Add quirk
 'arm,pl330-periph-burst'
Message-ID: <20200715055600.GV34333@vkoul-mobl>
References: <1593439555-68130-1-git-send-email-sugar.zhang@rock-chips.com>
 <1593439555-68130-5-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593439555-68130-5-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-20, 22:05, Sugar Zhang wrote:
> This patch adds the qurik to use burst transfers only
> for pl330 controller, even for request with a length of 1.
> 
> Although, the correct way should be: if the peripheral request
> length is 1, the peripheral should use SINGLE request, and then
> notify the dmac using SINGLE mode by src/dst_maxburst with 1.
> 
> For example, on the Rockchip SoCs, all the peripherals can use
> SINGLE or BURST request by setting GRF registers. it is possible
> that if these peripheral drivers are used only for Rockchip SoCs.
> Unfortunately, it's not, such as dw uart, which is used so widely,
> and we can't set src/dst_maxburst according to the SoCs' specific
> to compatible with all the other SoCs.
> 
> So, for convenience, all the peripherals are set as BURST request
> by default on the Rockchip SoCs. even for request with a length of 1.
> the current pl330 driver will perform SINGLE transfer if the client's
> maxburst is 1, which still should be working according to chapter 2.6.6
> of datasheet which describe how DMAC performs SINGLE transfers for
> a BURST request. Unfortunately, it's broken on the Rockchip SoCs,
> which support only matching transfers, such as BURST transfer for
> BURST request, SINGLE transfer for SINGLE request.
> 
> Finally, we add the quirk to specify pl330 to use burst transfers only.

Applied, thanks

-- 
~Vinod

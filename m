Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94714483085
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jan 2022 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiACLaZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jan 2022 06:30:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44012 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiACLaZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jan 2022 06:30:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263CB61010;
        Mon,  3 Jan 2022 11:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F8AC36AE9;
        Mon,  3 Jan 2022 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209424;
        bh=PJcapKAIeWCUQ8GEVmO6uaKfnmXoKarLeDRQFQ8RRmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAY4Akej43xDQ97sjIXy535eaDqM81L/c/e6eFlI227rlPAmVbmajUjKE6ibSGk/I
         wnLfwC8nzjz36FgejGavM3szdsoGS9wA9vpcEPFdIbyqTHfMbE3CN52hCcWxvkGDHU
         9xpzMr3S6lxtoIaMCkcHqHPYzygNpUj8BSi1ie03uL+9NZhKWljyeUMXxjR0ek/PlF
         uGRI/qoVIhihMp30DHtksnsklHM/0kUl64dENP421pnE3BqifnBp1XgK2kpZOHiaUi
         T6atGKekATheFBtX1ModuAqzrK5IgtrWI46g+aVuDDpkSv/IkcdWJA6TLyjG6F3FBQ
         1knCr03OsXQJg==
Date:   Mon, 3 Jan 2022 17:00:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dmaengine: stm32-mdma: fix STM32_MDMA_CTBR_TSEL_MASK
Message-ID: <YdLeTC+H92xZHi77@matsya>
References: <20211220165827.1238097-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220165827.1238097-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-12-21, 17:58, Amelie Delaunay wrote:
> This patch fixes STM32_MDMA_CTBR_TSEL_MASK, which is [5:0], not [7:0].

Applied, thanks

-- 
~Vinod

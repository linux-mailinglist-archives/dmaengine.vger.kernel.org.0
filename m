Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE341B54A5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWGTk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 02:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDWGTk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 02:19:40 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEE920724;
        Thu, 23 Apr 2020 06:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587622780;
        bh=iFjJ7P8tBt9jHw5u95JP/ux+NUoop1lg0l7BJRMhoB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cICEJ7bT3GN1L4+ipzn26G1bBSKBzZkqsDQKXBSIaQEJnTkROEOozheAlJxp+NaCE
         BjyzuOFtZXd3jSUsW+ZAC5lAv0QZjIMf0LaCP1+f0/F1cQJqdWe2UH/7Ok5Ynshqjc
         9XMxUTVgT9BGMCusZTVu5t0kD50JmTSx4+UM/4zk=
Date:   Thu, 23 Apr 2020 11:49:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers: dma: pch_dma.c: Avoid data race between probe
 and irq handler
Message-ID: <20200423061935.GV72691@vkoul-mobl>
References: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416062335.29223-1-madhuparnabhowmik10@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-04-20, 11:53, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> pd->dma.dev is read in irq handler pd_irq().
> However, it is set to pdev->dev after request_irq().
> Therefore, set pd->dma.dev to pdev->dev before request_irq() to
> avoid data race between pch_dma_probe() and pd_irq().

Please use the right subsystem tag for patch. You can find that using
git log on the respective subsystem, in this case it would have told you
that it is dmaengine.

I have fixed that up and applied it, thanks for the patch

-- 
~Vinod

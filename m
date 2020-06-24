Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614A206C19
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgFXGDh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgFXGDh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:03:37 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63632085B;
        Wed, 24 Jun 2020 06:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978616;
        bh=1NNEAu5SaBy1TE3co7sVLQF9xPwX5FCT8mjmZHfq3lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=us+MWmV9Pnwi1IBiwovXU6CliVGEe5BvT5F1y4Zte+BoRyyDC7cFrdMGSmmG1xLRW
         pakSh7DuAyYEthPL79cLSS4WbAOgjAWFysrn95ZTrdekhCVsnl5QFXNI3TiL2bQyY0
         LuWKNDGMApfuukSeDeOBJ+zCPivtRaskjKal5taw=
Date:   Wed, 24 Jun 2020 11:33:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Fix delayed_work usage for tx
 drain workaround
Message-ID: <20200624060332.GB2324254@vkoul-mobl>
References: <20200618114004.6268-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618114004.6268-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-20, 14:40, Peter Ujfalusi wrote:
> INIT_DELAYED_WORK_ONSTACK() must be used with on-stack delayed work, which
> is not the case here.
> Use normal delayed_work for the channels instead.

Applied, thanks

-- 
~Vinod

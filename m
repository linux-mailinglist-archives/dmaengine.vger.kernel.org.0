Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D7206C28
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgFXGGX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgFXGGW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:06:22 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627492078A;
        Wed, 24 Jun 2020 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978782;
        bh=FIQucxuWybDuESe4M7PH//n/zM48AOwS9VQ7PD6O578=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0V9TZqngeh92/vHXrCS/rjsayyMKrm+J/E4GmclDnbH0Ia7BFqAwtxrK+sQTTdsQ
         r8nKZwoHQow8pji1L86GaKi+PU/vYb8WKsUbloTxSgSXITg0/DKxronzGllpPYzSMv
         S/nTGYtTfsoYoNa2Xt6lGcXVdAm+nxa466aWo3fM=
Date:   Wed, 24 Jun 2020 11:36:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     dan.j.williams@intel.com, peter.ujfalusi@ti.com,
        grygorii.strashko@ti.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: add missing put_device() call in
 of_xudma_dev_get()
Message-ID: <20200624060618.GD2324254@vkoul-mobl>
References: <20200618130110.582543-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618130110.582543-1-yukuai3@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-06-20, 21:01, Yu Kuai wrote:
> if of_find_device_by_node() succeed and platform_get_drvdata() failed,
> of_xudma_dev_get() will return without put_device(), which will leak
> the memory.

Applied, thanks

-- 
~Vinod

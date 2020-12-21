Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF632DFC94
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLUOLa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 09:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgLUOLa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 09:11:30 -0500
Date:   Mon, 21 Dec 2020 19:40:45 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608559850;
        bh=brYUIuxVH73MITU87zKgoCQnt6Z9UxnkR01Ev5sawdw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPARUF5OrYZojT26t2nFFvX7FwB02+0Kdjh5401mULRCBNO6VlV8vBtN3PuBOHjo2
         sqD55L3WZ2qMqXtevMvddHgKr6pmsSx94RBBxHzS86iqgMSIwiG/iBIE3Cn5KA+v5h
         XeXdRqog1H9snO/twxfgBbZu1pFA3MooY8KcMerqcS+GeekZV5OLy4HUMBbdV5qBiK
         8+3qEEy5Aqh4AvgKSkqHKP6PMq1w3RJ5F0aCrrWRjseagQY0ed8Sd+aZ/7aHeosTBD
         us28ZvpcBSuKA6WwRbffQl61IAam7MZlJId1l/202mNdH7tEeIdhfGiEG2p72DyiAp
         wQkAGXOGOYJVA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wangle6@huawei.com
Subject: Re: [PATCH] dma/qcom/gpi: Fixes a format mismatch
Message-ID: <20201221141045.GC3323@vkoul-mobl>
References: <20201218104137.59200-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218104137.59200-1-nixiaoming@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-12-20, 18:41, Xiaoming Ni wrote:
> drivers/dma/qcom/gpi.c:1419:3: warning: format '%lu' expects argument of
>  type 'long unsigned int', but argument 8 has type 'size_t {aka unsigned
>  int}' [-Wformat=]
> drivers/dma/qcom/gpi.c:1427:31: warning: format '%lu' expects argument of
>  type 'long unsigned int', but argument 3 has type 'size_t {aka unsigned
>  int}' [-Wformat=]
> drivers/dma/qcom/gpi.c:1447:3: warning: format '%llx' expects argument of
>  type 'long long unsigned int', but argument 4 has type 'dma_addr_t {aka
>  unsigned int}' [-Wformat=]
> drivers/dma/qcom/gpi.c:1447:3: warning: format '%llx' expects argument of
>  type 'long long unsigned int', but argument 5 has type 'phys_addr_t {aka
>  unsigned int}' [-Wformat=]

The subsystem is dmaengine: please use right tags (hint git log will
tell you so)

I have fixed it up while applying, thanks

-- 
~Vinod

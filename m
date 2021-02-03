Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3A30D8B3
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhBCLbp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 06:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBCLbo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Feb 2021 06:31:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3BBB64F6C;
        Wed,  3 Feb 2021 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351863;
        bh=J/T7Mn6eIJxHgm9/Hb5uRwEETuWSWuHtJJ/xi1JQ7ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5sf5BG0KGmNKntzb2sH1mel+WnthuHUsqws5xkuHgo7KaBE4TEVNQxwQ2xPiJknF
         YRUkm4hmTvAlr2GXiLiOF84a/rYBS5ho4og6L9qTHjg4UdoiGvq4q8gBJsa0qSkLpA
         AvtUS1RUwsw9yczxC+7GjhFWKqkusuyl6mDZGpBLdSaCH4X0ca+hykhmLv173jNBvl
         EANS+jDUKBo6hZn5m8Q7ujyMbmr1PVOYHgZVYObTGiHU0ZFddsBeCwSuM4nuIHXuZV
         buUH9PAyFz4zOB9/CVvZMrHTY/QMt7WzSunGqpZBlTYOoP5nAfpown43cSZ46Jx1MV
         jBdtR7npIt5FA==
Date:   Wed, 3 Feb 2021 17:00:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: remove unneeded semicolon
Message-ID: <20210203113059.GQ2771@vkoul-mobl>
References: <1612248373-43529-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612248373-43529-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-02-21, 14:46, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/dma/qcom/gpi.c:1703:2-3: Unneeded semicolon

This was already fixed with commit 9ee8f3d968ae3dd838c379da7c9bfd335dbdcd95

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84D83A97CB
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhFPKmX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhFPKmV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:42:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 090E761001;
        Wed, 16 Jun 2021 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623840015;
        bh=mYtSLTd76sDF11uwzoJJMeTTBprwirhYe2TG+3b/lFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7MI3HxAPI0WPwvZHkRjqVm1EIjv4rUDlQ31VIaWRnzq7h60O6s506abnuAWiReC+
         sGn6q+GUMHuueQB9GhYDfHOihtlnl6cJVqazO8vTEHAyW+0+PFJE2XxLFsmEI/rYeA
         NvRTCExGlY1Wup5aC1ZvQ/dn7mfuap/q8L8ClAp5rJu0E9TlFv5w5YjaXergApnn+J
         zWEWhKzxm/e7RkBs/Wc8SZT0o/iPq2c4GOgJYSj957ZU0Nr/dkrDpnX+68fD1KyAyR
         JPF61PIaZg8zLFbluQN52YsNsvfpDHeeWhiIB4CV/hOopbG4SKaKWyAJUmJXhiYxuV
         Ux+Xvu1bsdKVA==
Date:   Wed, 16 Jun 2021 16:10:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com
Subject: Re: [PATCH] dmaengine: sf-pdma: apply proper spinlock flags in
 sf_pdma_prep_dma_memcpy()
Message-ID: <YMnVDJM8foWIZTGk@vkoul-mobl>
References: <20210611065336.GA1121@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611065336.GA1121@raspberrypi>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-06-21, 07:53, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> The second parameter of spinlock_irq[save/restore] function is flags,
> which is the last input parameter of sf_pdma_prep_dma_memcpy().
> 
> So declare local variable 'iflags' to be used as the second parameter of
> spinlock_irq[save/restore] function.

Applied, thanks

-- 
~Vinod

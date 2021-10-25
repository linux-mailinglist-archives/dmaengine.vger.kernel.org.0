Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C33438FA8
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJYGqE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhJYGqD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0245560D07;
        Mon, 25 Oct 2021 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144222;
        bh=RbwsxV+7EA5MhdQjqbFs6xSGFLNYiYd3zcPW90AMfMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKXU+FAxQLfXB7BKAcCLnmpKCftbziXJuDutSW4WVXuBhcmiL3DLSJGTDryFTWL5z
         yuDyZQe4ey6XZbGqz8XLhcZwnoNQq+I0srP83Umuya0jk29q0FY469mIR+uqOAB7HC
         HA0KP2ZEcgOf0C7Sk9EG5q7Tfzi1MwWbbGsZWt4infbhh3jBiKSWBHBY+rnRC/qLN8
         20Aqx91BZGQOuPAQps/1OaEflnZD4KG3y4KlSA5mDj2M00nSPY+op9qnXY0tcoWMJr
         VqT6452+hoBeCKk+HV6sNxuv+stMh10W2cyS+pFMUxcT4ghdLoLDDUrFrK2zhNooNL
         bgWG34F6He0vQ==
Date:   Mon, 25 Oct 2021 12:13:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] drivers/dma: fix reference count leaks in mmp_pdma_probe
Message-ID: <YXZSGe+BBbXEiXg3@matsya>
References: <20210911070533.3114-1-xiongx18@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911070533.3114-1-xiongx18@fudan.edu.cn>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-09-21, 15:05, Xin Xiong wrote:
> The issue happens in an error handling path. If
> of_dma_controller_register() fails, the function simply prints error
> messages and returns error code, without decrementing the reference
> count of pdev->device incremented earlier by
> dma_async_device_register(), which may result in refcount leaks.
> 
> Fix it by invoking dma_async_device_unregister() before returning the
> error code.

Pls use right subsystem tag, git log will tell u the same. I have fixe
dit up while applying

-- 
~Vinod

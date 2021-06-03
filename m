Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3A399FB1
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCLXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 07:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFCLXW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 07:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C57A66135D;
        Thu,  3 Jun 2021 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622719297;
        bh=xM47Fi4TErvireQmcwqz7uMJqu5GNCjR2xMolRginjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7HzBt62hbp/p1rrl0Bue2WaqSoicvEL40uqCRod/6sYUXqJvYzpKnIUzKAAZqHwF
         Ltuk05afsQXGiaPM6mbSHVB/STCfvlNUf+vCe3S0i+91DrQvEahU8sZ7J0ZGaFr8PC
         rnTue4ybZ/Z5Q6LMl+QjszO50RGkWq4qo77djwR7/Ewir3rJz/4DewlwcZAVJ2Q1r4
         PJ+mOMiIEoOKyCr9XZRHheZi7tLvPCF8C5SjWckC9+lvP55gX0BqLP2i2E/AI4aUk0
         1bpzpU9au/sMXbTaHWCZ9uiDsxRK0Cfgyleh9eZTZhMbm03TXg0wsAx+Busu2QPTtF
         xMiM9dkbZ7jHg==
Date:   Thu, 3 Jun 2021 16:51:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next v2] dma: ipu: fix doc warning in ipu_irq.c
Message-ID: <YLi7Pi/t8DMNZKaE@vkoul-mobl>
References: <20210603072425.2973570-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603072425.2973570-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-21, 15:24, Yang Yingliang wrote:
> Fix the following make W=1 warning and correct description:
> 
>   drivers/dma/ipu/ipu_irq.c:238: warning: expecting prototype for ipu_irq_map(). Prototype was for ipu_irq_unmap() instead

Applied, thanks

-- 
~Vinod

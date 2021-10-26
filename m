Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8C43AB18
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhJZEZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 00:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhJZEZX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 00:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F9336103C;
        Tue, 26 Oct 2021 04:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635222180;
        bh=5a9A9jUrWj/VSmZBsEtQ6pQ+MWERbmpRwQykDkKGiyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgDq31sEtRXi6Qaz+EUZoII+/wwIqdGLEA8EvDtI1SL3Y8jtHOu0PvCE8GbJKXS+o
         exKFuZUz8gptatWx01gnMsf1ID6+3uGppafEAq4ur1JgNn8JhKvqxVWDOSGzKPXgpC
         6DUE9jj1HzP6tP/Lq/S3B85Y6u38vY5+idVcrerU6wIy5sn8pZHy23oikdSI9O0JD1
         monBBDtCWBcLVR6iDL5H+vs+zWN0qoYNRvhyee3ytedFk7SuSgcPeKrgD4Za70+r0A
         Mx5d7hFza8Mv2JUoLWusILFBNkQGDU12VaH9ldANUqSdlPAZJjvBe2DTscAPlC2e3W
         fBnai+/MUUmUg==
Date:   Tue, 26 Oct 2021 09:52:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sa11x0: Mark PM functions as __maybe_unused
Message-ID: <YXeCnzPW9yv5iLse@matsya>
References: <20211026020508.550-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026020508.550-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-21, 10:05, Cai Huoqing wrote:
> Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
> are unused, producing a warning:
> 
> ../drivers/dma/sa11x0-dma.c:1042:12: error: 'sa11x0_dma_resume' defined but not used
> ../drivers/dma/sa11x0-dma.c:1004:12: error: 'sa11x0_dma_suspend' defined but not used

Applied, thanks

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4875B86189
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHHMXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfHHMXl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:23:41 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD18E2171F;
        Thu,  8 Aug 2019 12:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267020;
        bh=pYsFBGP3kI4gJG4u1PJaSdrgvkRbRuJZQ/c/jwcwI2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZazE1taqA2r421KmDZVzNqPA+bSG3IjqBr4e1e/giVkNuwVgb3NEchPhztqU6QYfi
         GPj2QapJuzXJNzKKXvtyEycNJFqG3H7dunkUvVt9cZ3HNVHFePggOQ1fy+IpY3o9Xq
         C7ImPSlFTWh+CA67rXnQjQ9wy3ouO6RYu2i/nPpo=
Date:   Thu, 8 Aug 2019 17:52:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/24] dmaengine: imx-sdma: Remove call to memset
 after dma_alloc_coherent
Message-ID: <20190808122228.GP12733@vkoul-mobl.Dlink>
References: <20190715031716.6328-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715031716.6328-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-07-19, 11:17, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

Applied, thanks

-- 
~Vinod

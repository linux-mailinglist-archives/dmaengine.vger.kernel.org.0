Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0584F3E9F
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2019 04:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKHD4u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Nov 2019 22:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfKHD4t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 7 Nov 2019 22:56:49 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B9020679;
        Fri,  8 Nov 2019 03:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185409;
        bh=NRAWJvV5bwnb1AnqiW+YpK4zr3Un/bwt9+gbyfD7ggM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPnOWcOVjCELUgkIMqQ0D89400gIVqKye/cCoxR3uAUxwshGu+Kfc6ZBT5VqC6XTO
         hPNKKQfpuxMeTIq0JKs4xsMNvC3ENapie2AGwCVuKmshwkdHbQPJS56M/vfnv2RBzJ
         bVg2mmrvaHRbu2ma5Iu0QwkoToLVGpqhRabulopk=
Date:   Fri, 8 Nov 2019 09:26:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     jaswinder.singh@linaro.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: milbeaut-hdmac: remove redundant error log
Message-ID: <20191108035643.GS952516@vkoul-mobl>
References: <20191106163128.1980714-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106163128.1980714-1-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-11-19, 22:01, Vinod Koul wrote:
> platform_get_irq() prints the error message, so caller need not do so,
> remove the error line in this driver for platform_get_irq()


Applied these now

-- 
~Vinod

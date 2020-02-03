Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031C61500EB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 05:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBCESJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 23:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgBCESJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 2 Feb 2020 23:18:09 -0500
Received: from localhost (unknown [223.226.103.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CDC2073C;
        Mon,  3 Feb 2020 04:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580703488;
        bh=OYEuuUPdkHbimhsmrxdHDng3WqUbq4LnmhOrIQmh7ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kINX8QM+s6N57iwksEqOhruLQ3xcurtb8AEEmUhb+B1cVT2h4YYg9Om8Wjch067PP
         kwH0SoIo/ICl+cMxi6PaptmClLYcphM2gWSpUBICO2UFUH7+Uvpym/9lTjuEj9P7ny
         IGcDAMWFUXk/fTZlpWwHixzf39A9q+MZ/KgBn0y4=
Date:   Mon, 3 Feb 2020 09:48:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] dmaengine: fix null ptr check for
 __dma_async_device_channel_register()
Message-ID: <20200203041804.GL2841@vkoul-mobl>
References: <158049351973.45445.3291586905226032744.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158049351973.45445.3291586905226032744.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-01-20, 10:58, Dave Jiang wrote:
> Add check to pointer after assignment before accessing members.
> 
> Fixes: d2fb0a043838: ("dmaengine: break out channel registration")

Applied, thanks

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4650A4A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFXMDN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfFXMDM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 08:03:12 -0400
Received: from localhost (unknown [106.201.35.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFC0212F5;
        Mon, 24 Jun 2019 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561377792;
        bh=JM6uoHZixEf1pikoP30ugI/YpnyMtKuDIeiOANlIQNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSfhIn/DcFfLMzXNDru/QiDq/UFiUrGB8j0qmmTwmU/E47UZXLGHHdkDmW2rz4Z0l
         pWadQs5OyXKG8JYhPmkdzyqgq+aYFT8iH0zV8TxdtpbBmXgE+nfA+paaVeOEVEZlST
         d6/6L0uZC9Gn5TUHsJRcN1aWmYB6Ev6scUZbF5p0=
Date:   Mon, 24 Jun 2019 17:30:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: hsu: Revert "set HSU_CH_MTSR to memory
 width"
Message-ID: <20190624120002.GA2962@vkoul-mobl>
References: <20190613133232.49971-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613133232.49971-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-06-19, 16:32, Andy Shevchenko wrote:
> The commit
> 
>   080edf75d337 ("dmaengine: hsu: set HSU_CH_MTSR to memory width")
> 
> has been mistakenly submitted. The further investigations show that
> the original code does better job since the memory side transfer size
> has never been configured by DMA users.
> 
> As per latest revision of documentation: "Channel minimum transfer size
> (CHnMTSR)... For IOSF UART, maximum value that can be programmed is 64 and
> minimum value that can be programmed is 1."

Applied, thanks

-- 
~Vinod

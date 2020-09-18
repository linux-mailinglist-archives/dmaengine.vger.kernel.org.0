Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5C26F66B
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIRHBQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIRHA4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:00:56 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737A421582;
        Fri, 18 Sep 2020 07:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600412429;
        bh=0FIqjHpGsTX7bHiIomHFn7svxS6dlkfnQo+3Txtalgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqglsyDcUYcGrZHtQTSgWDzIrtt3vzOiq1l3gw5rCuN1BO4B2AsNVPEA+1iVY1EOv
         YXyWx2lrcEYIBX5LLunCDqd4vKikSs/+3CpGV7q3darWFIFzXL7PwvTcMjnRHFvzlt
         fFRBSsAmQsuwkfyhrKFbFKZ88XMiD/9ZiHEFO6Kg=
Date:   Fri, 18 Sep 2020 12:30:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     dmaengine@vger.kernel.org, linuxarm@huawei.com,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dmaengine: zx: remove redundant irqsave in hardIRQ
Message-ID: <20200918070025.GF2968@vkoul-mobl>
References: <20200912094036.32112-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912094036.32112-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-09-20, 21:40, Barry Song wrote:
> Running in hardIRQ context, disabling IRQ is redundant.
> 

Applied, thanks

-- 
~Vinod

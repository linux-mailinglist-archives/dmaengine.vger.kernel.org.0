Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253AB129D8D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2019 05:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLXEuJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 23:50:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfLXEuJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 23:50:09 -0500
Received: from localhost (unknown [122.167.68.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE39206CB;
        Tue, 24 Dec 2019 04:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577163008;
        bh=UL9b/SbX1WZ6RedDEtgQXJCpnmdECOSxErzvE+HN1eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DahhM3gJcOt286sQXsr1sihpHCDy9BrmnkilCr459a+rW6phc8h+yMCqkrQ6VARu
         r/4GgRBjblHRn4zZyQ63v2oQwg4DkurXppGe6yGm3XKrPWi/QRXaH83M/HzKrmEcpu
         brCn4XTUGYl9aVy+ud5wFFaZXAkrX2c4/CokRk/8=
Date:   Tue, 24 Dec 2019 10:20:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH 0/5] Support hot-unbind in IOAT
Message-ID: <20191224045004.GI2536@vkoul-mobl>
References: <20191216190120.21374-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216190120.21374-1-logang@deltatee.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-19, 12:01, Logan Gunthorpe wrote:
> Hey,
> 
> This patchset creates some common infrastructure which I will use in the
> next version of the PLX driver. It adds a reference count to the
> dma_device struct which is taken and released every time a channel
> is allocated or freed. A call back is used to allow the driver to
> free the underlying memory and do any final cleanup.
> 
> For a use-case, I've adjusted the ioat driver to properly support
> hot-unbind. The driver was already pretty close as it already had
> a shutdown state; so it mostly only required freeing the memory
> correctly and calling ioat_shutdown at the correct time.

I didnt find anything else (apart from one change i pointed), so I have
applied this and will fix the comment. No point in delaying this

-- 
~Vinod

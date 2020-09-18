Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D695026F6D0
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIRHYj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgIRHYb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:24:31 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BCC20C56;
        Fri, 18 Sep 2020 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600413871;
        bh=8meyM5JPwDLD84IHJZCFpl/oVfrFbNqq0LWxt6fn+Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ugi2a+somLS2TIwv7Z9+c/H/xJ5cwy9UI0BEMi6UAt1vRdCIaVlZ3LaPvUfAWBk37
         huJZ45n+HO8RMpxyb+JMQGdrJIuJqzdbI4ZQ6j3gSPXF0MAYDxTtsy1zGNKT4wHKhW
         0niqOsHVjZR7QSREvhV3CQuchFYUop39a6hK/Xhc=
Date:   Fri, 18 Sep 2020 12:54:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] dmaengine: virt-dma: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20200918072426.GK2968@vkoul-mobl>
References: <20200819095950.59157-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819095950.59157-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-20, 12:59, Andy Shevchenko wrote:
> In preparation for unconditionally passing the struct tasklet_struct
> pointer to all tasklet callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Andy,

Allen had already sent this in the pile of patches, I have applied that
one

-- 
~Vinod

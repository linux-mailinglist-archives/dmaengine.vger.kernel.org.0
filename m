Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3AC2744AE
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVOuP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 10:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVOuP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 10:50:15 -0400
Received: from localhost (unknown [122.179.101.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDC22395C;
        Tue, 22 Sep 2020 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600786214;
        bh=jSz/FsxQ7bGEu820XheKc20Xwb3lAptLQzf8gc7CVxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgzZIZ9Z5RokkcpCgC/AfeLBJrltdcYWrY7yIW2xj5N1/RqT4u1YR6AUUGGWF1nGW
         4SCtCcwVGveSyd34PtYZKB/Yg8kPoa+niGdWRVcA+OFbBjNe8AEpXwEe0Dbjaml95P
         AgpkkBdnJs0fVo2+2WvmqnPoEN5lVYAMPujfEeD8=
Date:   Tue, 22 Sep 2020 20:20:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/3] dmaengine: dmatest: Prevent to run on
 misconfigured channel
Message-ID: <20200922145006.GB2968@vkoul-mobl>
References: <20200922115847.30100-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922115847.30100-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-09-20, 14:58, Andy Shevchenko wrote:
> From: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
> Restore default for channel") broke his scripts for the case
> where "busy" channel is used for configuration with expectation
> that run command would do nothing. Instead, behavior was
> (unintentionally) changed to treat such case as under-configuration
> and progress with defaults, i.e. run command would start a test
> with default setting for channel (which would use all channels).
> 
> Restore original behavior with tracking status of channel setter
> so we can distinguish between misconfigured and under-configured
> cases in run command and act accordingly.

Applied all, thanks

-- 
~Vinod

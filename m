Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1539521D8
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 06:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFYERF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 00:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYERE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 00:17:04 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8CE20659;
        Tue, 25 Jun 2019 04:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561436224;
        bh=dvbZ+9ULprv7GELIXrP69p+iGTK2YtbNv4WTCWQnL88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4jl4RJT3GGyM/s8v6MohimMbhXTHiugawjreBSR/WyXfsGCWWES4860uhhy1VqVD
         87FaX7ARYaAs1b+uWPuCtCtpcJoi+Wxf2KpQnpHl6jwWVLVAHy9pdf4kluyrlA906u
         y9j1z6dN3xUjuu+EWVKNSWHmtRwjXOGVkgG6Ivfc=
Date:   Tue, 25 Jun 2019 09:43:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1] dmaengine: dw: Distinguish ->remove() between DW and
 iDMA 32-bit
Message-ID: <20190625041353.GF2962@vkoul-mobl>
References: <20190614110604.25375-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614110604.25375-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-19, 14:06, Andy Shevchenko wrote:
> In the same way as done for ->probe(), call ->remove() based on
> the type of the hardware.
> 
> While it works now due to equivalency of the two removal functions,
> it might be changed in the future.

Applied, thanks

-- 
~Vinod

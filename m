Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8E206C12
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgFXF6y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 01:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388307AbgFXF6x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 01:58:53 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80852085B;
        Wed, 24 Jun 2020 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978333;
        bh=PABbC3O7XUVzGvcFflGzTZABRmWlQuF9vZO/Moc36pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHS3hGLXuYS9U9fGigK2wUtPCN+Ex+Kv2PHrMkgALFCBaamaJ3QNZop0OJJ2cVTE5
         FhRrk8J2WU+vfqGsvjSR4zX99Pd49mFSVlbsUs01LJeld2TvqshVu7cgQYKjVIBQ7Y
         9jeEz6G8+YdHY+m1R/9fE6h6AH8qxq8wQZ1J9TmU=
Date:   Wed, 24 Jun 2020 11:28:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: acpi: Drop double check for ACPI companion
 device
Message-ID: <20200624055849.GZ2324254@vkoul-mobl>
References: <20200622181311.67649-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622181311.67649-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-06-20, 21:13, Andy Shevchenko wrote:
> acpi_dev_get_resources() does perform the NULL pointer check against
> ACPI companion device which is given as function parameter. Thus,
> there is no need to duplicate this check in the caller.

Applied, thanks

-- 
~Vinod

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B39815C107
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBMPHo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 10:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBMPHo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 10:07:44 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF2D20873;
        Thu, 13 Feb 2020 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581606464;
        bh=SBGUeUq4qkOcW9N0mPoJt27c1rZWtOAZo2FfvzapxHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSLd2c7sW+29Uv1PeXiNCAsKWrr6aWEKuWoZlHtq4UWXIOCrrKEvLxrgcfigoQouh
         rlC2Ps71D85vKj6kmaTjS9wSNFGuWC72l/NHWrviP+POYqk+zzR99dV2ajr+L6xxzT
         q2n8FFdcSAZfmKDSOtCzWCYN0hSt2YD76bBaXGWo=
Date:   Thu, 13 Feb 2020 20:37:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix error handling in
 idxd_wq_cdev_dev_setup()
Message-ID: <20200213150739.GP2618@vkoul-mobl>
References: <20200205123248.hmtog7qa2eiqaagh@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205123248.hmtog7qa2eiqaagh@kili.mountain>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-02-20, 15:32, Dan Carpenter wrote:
> We can't call kfree(dev) after calling device_register(dev).  The "dev"
> pointer has to be freed using put_device().

Applied, thanks

-- 
~Vinod

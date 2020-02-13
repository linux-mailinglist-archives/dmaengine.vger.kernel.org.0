Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9F15C069
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBMOek (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 09:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMOek (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 09:34:40 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD48024673;
        Thu, 13 Feb 2020 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581604479;
        bh=mt/wBV75C0JFyp9Jp5NJAMBeePDKaAfR/fqnojQNLA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyvSVb57nyYaFp0FTteX2g7KVlTIRAi1q6Yp8rBqBFyBLrZugZvocsrEQpnRO0Wrm
         BHwmZvHealztvCTSEIXt4liEt7OEQT8/4hvtTWf3liE+ujdrkScy3vD03bV2xPIfw5
         6n4gohOeD4/OZYU6vs7OzYX3Axb9gfNpVPcCQU6Q=
Date:   Thu, 13 Feb 2020 20:04:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dave.jiang@intel.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: idxd: remove set but not used variable
 'idxd_cdev'
Message-ID: <20200213143435.GI2618@vkoul-mobl>
References: <20200210151855.55044-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210151855.55044-1-yuehaibing@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-02-20, 23:18, YueHaibing wrote:
> drivers/dma/idxd/cdev.c: In function idxd_cdev_open:
> drivers/dma/idxd/cdev.c:77:20: warning:
>  variable idxd_cdev set but not used [-Wunused-but-set-variable]

Applied, thanks

-- 
~Vinod

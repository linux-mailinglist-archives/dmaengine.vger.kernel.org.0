Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD932D931
	for <lists+dmaengine@lfdr.de>; Thu,  4 Mar 2021 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhCDSE2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Mar 2021 13:04:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12870 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhCDSD7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Mar 2021 13:03:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604120e70002>; Thu, 04 Mar 2021 10:03:19 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 18:03:18 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 18:03:13 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.54) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 18:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWTavllj+fgL/iZrZIV6VnPzG3C5ov8TbgdU62q6SMlmDSyGDFMO8ZG5Bzs3QbW91f60wVkzTD/g90388RrLqROmJgM6gKYVLLYsO9mVbyhRkrPfHuYYd2QmnEOdCmuelEYEBLgWj66LcX4/Bomy/mmjo9e9aWp4HlLUI3HZ5rssQQEqCh/yz/2Zi3ncVIpON8AlQ/1cWrqeN/M+WQma/Imv6TI+G2O+/ymVeC+4ghhcU8OcH1V049hZb/0uxmt668nJZDWSafPaAPH/IIqJgm8GyA3LEP4kX8Qc5oNtJcbQgtqCnk+8yqq1+B+CiZiSLkC5SeH2grG8Wjw8RzyERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cMRHCN6zUj6aFhiZdOgJBZdNN571sQ98S6EJBdAasw=;
 b=Wn1Jun/UZEEHQRinpIIImLQ/ULt7CsDg04kVgrgAnc5bhck0qh24F0JReUsGdn/JZ1ReM7kfX0qm1yu3Ar/T3/e/IYemAeQbdfFmzmqNgkyJpmzLtnhcCCA/pKqawCOx1zXGR94+M6bNr4gOGgPr/BEs3dVZHI260WQo8q7dsH0Ntyh03GZYnh2SlsM9fXUmCM4YH8Dqso0ojz/HBJLwr8ugrXgXXNOPyydIQ0rkvJOosUZiW24TDi/q9xgjCesIFPpvQ6SmHs83d3YmrqS4AM2z3HfrO4M6/ch08yKJ8v0C2bBm7GZ/V/DaYFmjd7eW8HzOY7K5vDb1b11Z32rLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 18:03:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 18:03:10 +0000
Date:   Thu, 4 Mar 2021 14:03:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210304180308.GH4247@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 18:03:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lHsJY-006gfp-RI; Thu, 04 Mar 2021 14:03:08 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614880999; bh=5cMRHCN6zUj6aFhiZdOgJBZdNN571sQ98S6EJBdAasw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=Rmw6pefmzLNekJ3YIos6yiE/BvtqRsiXtzHq6nXV1C439/vl538Eue+HtVdqfFAD5
         zv1Cr9qzjTZq2/MU5hkf3W0Zs7CRWPKvtKsy6+8w7hdGHdbG7EkyaNZ7VyFv9mqsft
         e64FSeng9bFJa+RChr1Cr/4ezLs+5SAKxUEcHUJEmL9xuY66ICKdFUXT8t7e5Uczk8
         JgjPHcdmy32DliG0ZaGZ05nZ7c/1Ns2TJ5nUTV7O8LGWrSDjEASBQA2uz0gmJU+03s
         CHdkjFmhYbRXM/j4uOltC9NLpbDtf5uWUa2Vo1y81l81qdSmR/G6BBBbR91oNB2Rp2
         2oYDfBs6aDP7g==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 03, 2021 at 07:56:30AM -0700, Dave Jiang wrote:
> Remove devm_* allocation of memory of 'struct device' objects.
> The devm_* lifetime is incompatible with device->release() lifetime.
> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> functions for each component in order to free the allocated memory at
> the appropriate time. Each component such as wq, engine, and group now
> needs to be allocated individually in order to setup the lifetime properly.
> In the process also fix up issues from the fallout of the changes.
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> v5:
> - Rebased against 5.12-rc dmaengine/fixes
> v4:
> - fix up the life time of cdev creation/destruction (Jason)
> - Tested with KASAN and other memory allocation leak detections. (Jason)
> 
> v3:
> - Remove devm_* for irq request and cleanup related bits (Jason)
> v2:
> - Remove all devm_* alloc for idxd_device (Jason)
> - Add kref dep for dma_dev (Jason)
> 
>  drivers/dma/idxd/cdev.c   |   32 +++---
>  drivers/dma/idxd/device.c |   20 ++-
>  drivers/dma/idxd/dma.c    |   13 ++
>  drivers/dma/idxd/idxd.h   |    8 +
>  drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
>  drivers/dma/idxd/irq.c    |    6 +
>  drivers/dma/idxd/sysfs.c  |   77 +++++++++----
>  7 files changed, 290 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 0db9b82ed8cf..1b98e06fa228 100644
> +++ b/drivers/dma/idxd/cdev.c
> @@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>  		return -ENOMEM;
>  
>  	dev = idxd_cdev->dev;
> +	device_initialize(dev);
>  	dev->parent = &idxd->pdev->dev;
>  	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
>  		     idxd->id, wq->id);

dev_set_name() can fail

> @@ -268,25 +269,17 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>  	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
>  	if (minor < 0) {
>  		rc = minor;
> -		kfree(dev);
>  		goto ida_err;

This doesn't work

>  	}
>  
>  	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
>  	dev->type = &idxd_cdev_device_type;

Because this hasn't been done yet and release is thus NULL, will leak memory.

Also the order here is wrong:

	rc = cdev_device_add(cdev, dev);
	 [..]
	init_waitqueue_head(&idxd_cdev->err_queue);

Userspace can race a call to poll() before err_queue is setup.

And probably more. Please check your code carefully!

Jason

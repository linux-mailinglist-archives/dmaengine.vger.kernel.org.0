Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B04322B14
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 14:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBWNDW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 08:03:22 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18208 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhBWNAn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 08:00:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6034fc530003>; Tue, 23 Feb 2021 05:00:03 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 13:00:00 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 23 Feb 2021 12:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2qQdnF0BKnWSQ+CKck9/yw5ka8IBa3eP9CayFoMmcyss2JcZ48Vdu5xzbidkUr9c2a1maFM5HBqXFCFGMFA21H3LJJICSRW7x9te7FfzKROyOSAIQHn8bLC6CkERFmghawKktbKDOYH2Jp8KitV3uY9XdRtARJyfcvpyKQp7hp/canYQm5Cx7Ziu5Dcxdcw92DPGccB1jr3G6zRG8Vt5eeXZou2rxbZCDM2siOIunDfK6Mgxte3NFUAp8QL1SQPoCeJdLh3rLA4YNrqhxLlpAQmorntjMse47x5pwhGs21IR/uftKmY5mIxZmTxOpDwTxBskQR2LPFW+2+0SrgmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5oDKpdlCrLlWyy78c2LFix/DbsqEfKAQaw/W/YEk9g=;
 b=cQvE5BI/n0pBVfdIEspjFLPDEwm2D1nRh9+sadhYONsAXnSmCcNjui+jXEKSkPUqIE5qAiSF6M0eDi8PwEUYCt+JVOEiochdnl1pDm2lBH5Y+wup1ews4/jDg1Lx5570Rx+sLZIUzjJoaWq5Ag0lESunZxMtIBQ5opcy9Ylba44fyhsFKQpsuLSPnK6hWBezevDaSaLN7st7suMs6Ef4MpPa011mfdaSyve3TNYT6fOEzQYUSjHXXjPryjo0dBeAGhgV+0MxgV8H/Hriyab4mKk5NbxGE9lXHLUtniXrhi8eKNzmAmA66VEnfo4nIFf1iZylN9/9tD71hhhifODCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 12:59:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 12:59:58 +0000
Date:   Tue, 23 Feb 2021 08:59:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210223125956.GY4247@nvidia.com>
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: MN2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:208:134::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:208:134::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 23 Feb 2021 12:59:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEXIC-00FNET-Js; Tue, 23 Feb 2021 08:59:56 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614085203; bh=D5oDKpdlCrLlWyy78c2LFix/DbsqEfKAQaw/W/YEk9g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=Ss09SUrjJ84r/LKS2t6rQSEi2bUSRmrPZAI1Fa5cxut/PX7CusE41Q83IBXS2pkrk
         T66ncYDPEf04SNXZXjndmGOh0hI8LuoFZ0OTLiD1uJkPW91osGBefQ8t6jmN+vbLh7
         qnSJOy4IOK1/9Wm6bgXe+qdiikHeFnPcR5dNJ2Q59p8PuLfcUHfwWeHb6AKWe63p4n
         S8gPwCZYSssQKKl1b/5KyKzWhoyTJFLUWEbPNCQ0woek6Y/XQAPgRxBgTD4YI9VpBo
         NJL81nAKaPnpyGlGku4I9p5/8dWiWxMoAdRWMc1baCrLTSB7Bzx4H5DT8zZhX9e7aZ
         edYqtSnwNXigw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> Remove devm_* allocation of memory of 'struct device' objects.
> The devm_* lifetime is incompatible with device->release() lifetime.
> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> functions for each component in order to free the allocated memory at
> the appropriate time. Each component such as wq, engine, and group now
> needs to be allocated individually in order to setup the lifetime properly.

I really don't understand why idxd has so many struct device objects.

Typically I expect a simple driver to have exactly one, usually
provided by its subsystem.

What is the purpose?

And it is still messed up because it has:

struct idxd_device {
        enum idxd_type type;
        struct device conf_dev; <-- This is a kref

        struct dma_device dma_dev; <-- And this is also a kref
}

The first kref does kfree() and the second does
idxd_conf_device_release() which does nothing - this is obviously
wrong too.

> +static int idxd_allocate_wqs(struct idxd_device *idxd)
> +{
> +	struct device *dev = &idxd->pdev->dev;
> +	struct idxd_wq *wq;
> +	int i, rc;
> +
> +	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq *),
> +				 GFP_KERNEL);

Memory stored in the idxd_device should be freed by the release
function, not by devm.

And since the sub objects already have a pointer to the idxd_device,
I'd keep all the types the same but have the sub structs carry a kref
on the idxd_device, so their release function is just kref_put

Would be much less code

But even better would be to get rid of the struct device embedded in
the sub objects

Jason

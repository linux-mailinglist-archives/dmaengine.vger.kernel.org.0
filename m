Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1F326B10
	for <lists+dmaengine@lfdr.de>; Sat, 27 Feb 2021 02:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhB0Bhb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Feb 2021 20:37:31 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14991 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0Bha (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Feb 2021 20:37:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6039a2310004>; Fri, 26 Feb 2021 17:36:49 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 27 Feb
 2021 01:36:45 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sat, 27 Feb 2021 01:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT2ACPeT0HOKo9VGQmzXjFrH+/Yk0lDq4isb/4QCEoSK4PT5vkcKyrLTdyERr0rJoDKbJ5B//tuqGsUWJUmZtvf3KAXPRuICrivmP8kTqYfnUavlC+9EPQvgui38QwNrDKEBIcGIQV8L7TbC7qZbmoNMFIdMRSAvsSLOlBJ5/a0ZSWWt6Y5S74T4CKZ+a1j4f1sNqiWtK92902Ur8wfn+Lcralt4QenkhzQwm8CZwiELW5kB9h/gI7lW/WDeTXDo8x9Fsw8yTwwutBquc9i9ds2I7INLenMGJWzoYuUTXxrD/xEgdgXod4f/X2XpRh7ZFkURckcvpmiChwEk6HKMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dNdKuBc+X7/nwqAPUaloOZJqC5iUGe98JLZ3qCavI8=;
 b=ggDygn2EOMMNdaxT8lQfAhQG8bsH6rJdu0YXh8qvZmQW5Er8UVWxGZx3TBq2oNjmQhUZMJwkC0nuixYpdPOPqVErSG6dp21zwvr+87sdbKoustTIzfVYTrZWp7yZhxzAVfKfpmaFHQMD0eFRYySiK7l11uDV22T7lAaom0ZOjszKrfO7IdBi2w3AIF1oq9QEvZja2mbojH+aV16ttB+YZq3m3s4OfHic0cfis4vkH++Pu0oIv7uahtqHF+t40MHwbmPu0dStjBQXtUxG2zCs/rsk6ygK/AbAfPKp075Zm3rd37tzFPlXm/E9xPhUq8G/mYyT4j8adVczLVh8ZYtn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Sat, 27 Feb
 2021 01:36:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Sat, 27 Feb 2021
 01:36:44 +0000
Date:   Fri, 26 Feb 2021 21:36:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v3] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210227013641.GC4247@nvidia.com>
References: <161420602220.1987219.16867019403434743794.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161420602220.1987219.16867019403434743794.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0006.namprd15.prod.outlook.com (2603:10b6:207:17::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Sat, 27 Feb 2021 01:36:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lFoXB-001itz-Uy; Fri, 26 Feb 2021 21:36:41 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614389809; bh=1dNdKuBc+X7/nwqAPUaloOZJqC5iUGe98JLZ3qCavI8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=drlAAFQeVH/EkEG+AWnQgZlDxH8TkSkhJOMerEQRrB72hJjjHFVNjWcGaSVrG35cj
         SOjWFybjuOdN8sUu4J3xTSo1rSYEAKM9Ufz2Ptu2aXeBuSUHcbE3vSjPGNOV5Y9ieO
         lfDLhGbuniAugDWoCRBFikuhVmuh88wibd2zRJ0+XC5s/vD6m63hjDD7YjHDkcoAVw
         fjiZPdKMLxwGhlfCGC3nCnLQ2fXXiLUYBOytt7vIZQSAkxqUqiR3XvtbGMqtJQsL1g
         PLvDaNUFBXfo6D+iAtxCe0PDKyNnozbx9qy9P8fsmu+DqtS8yw04A4E65fBtnp6hbP
         ywSjSoHUzB4Nw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 24, 2021 at 03:35:19PM -0700, Dave Jiang wrote:
> Remove devm_* allocation of memory of 'struct device' objects.
> The devm_* lifetime is incompatible with device->release() lifetime.
> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> functions for each component in order to free the allocated memory at
> the appropriate time. Each component such as wq, engine, and group now
> needs to be allocated individually in order to setup the lifetime properly.

You've tested this now with kasn and all the other debugging turned
on?

I poked around a bit and there are other bugs in here too:

static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
{
        idxd_cdev->dev = kzalloc(sizeof(*idxd_cdev->dev), GFP_KERNEL);
        dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd), idxd->id, wq->id);
        ^^^ Missing error check

        if (minor < 0) {
                rc = minor;
                kfree(dev);
                ^^^^ leaks the memory dev_set_name allocated

You must call device_initialize before calling dev_set_name and once
device_initialize is called it must do put_device to clean
up. put_device will free memory allocated by dev_set_name

Isn't this a use after free kasn should flag?

        device_unregister(idxd_cdev->dev);
        ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
                                                ^^^^^^
                                             idxd_cdev may
					have been freed by device_unregister

Probably a good idea to check all the places working with struct
device carefully to see that they are right

Jason

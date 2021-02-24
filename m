Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EC32437B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Feb 2021 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBXSFB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Feb 2021 13:05:01 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9423 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBXSFA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Feb 2021 13:05:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603695240000>; Wed, 24 Feb 2021 10:04:20 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 18:04:18 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 18:00:12 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 24 Feb 2021 18:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ/uG+XIQBez0J72Wg3GRrpzJPlv7tPrvignU5gCmrtKxHaMbxfYwUQIsLlzFvrlF6ZDP841sfjQJN6IxWOl4vzBhOz1ThK/uXQfjgtnUWoUw45/T/Nf+iwTUFB4xLe0jedkhtXDpi1dLMkJCSC5j6oBdh5E4gdt3oazo/7aK0eRMWDRYYfWvVJlXmCV2f31Cs3KpxSJaklVX0VzCfTg7WnuER23AK7iOKvGELmVVczy3v2uauCXqrzHOgatYDlViJ0fUC1zeGvJ4VCQgtnO+9DGK2jG/Rlkip4mCYAPOaCj8dxcu4IVEzi5YP+wkiZ82NzEyAP/jwsOxq91QmSqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAqIuTxcCcy6DQRg1Fyre98IBrM09DbRi1CRafzyy4E=;
 b=LvpPRTm8gV9dTEUjS1t5HyhD2On6Xs7ndyw+SOtWpDzG9FQlSS+0+B1tuYcfeppIwUaoCR9chRl92E5xavXTH47H7jxrGzaOVvTwM0QT3OsqGY5f6ZHG6jaLz2vUlSVwPfgOsx16r3w/uFL/jcdTE7GvsTAXrZftHjz/i9xjAy1y7TQl63ffQmJhAPUgBnFyOSfI0+ayw3AwKnV5D4cddC55fsuuWJN/3INVdTnHPnkesaP07GdHg3QcG9ElsB+wHG1kp2BnpFtohl9Pqhe5O+ieLYvUM03xaxarrYIktffDmqvgw+Ol7H8lmKyRJgV1b7hS5BIhGKWBNCKwep7Suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Wed, 24 Feb 2021 18:00:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 18:00:10 +0000
Date:   Wed, 24 Feb 2021 14:00:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210224180008.GL4247@nvidia.com>
References: <161418136625.1883632.9123020856542653686.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4igM0O2U2+vqJRPL+Rh_pLydwdYpTorxhPa2MaDz-naJQ@mail.gmail.com>
 <ed5dd7c1-76be-468c-6453-3a3dc645d2a4@intel.com>
 <CAPcyv4huU8qTjdB6X+cNcgr-zX6XHoVT7nE6q2Sr6Y0UoiUkCw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPcyv4huU8qTjdB6X+cNcgr-zX6XHoVT7nE6q2Sr6Y0UoiUkCw@mail.gmail.com>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 18:00:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEySG-00GlQM-KG; Wed, 24 Feb 2021 14:00:08 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614189860; bh=TAqIuTxcCcy6DQRg1Fyre98IBrM09DbRi1CRafzyy4E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=SAkzgBjLEYE4ardqWAdjRrPoIlZQAjiHhFSZRLlo2317sDycPGyOKH38XaIk1EBZN
         FZPrZfSArmZLiJkxdFfyIxV66Eu5Aj/pydUeJhh8HKBRhryaIigmy45yWNFKflEP7J
         UNt++kaQajO1IBQ6ofeKVVFTQmJc6eyT78PNXoaYQUhCpp7PkDvk8Xcl6/dU/fnuz7
         3GeyTWlUNjeKZVRwBoDJnUai4HmQ+XsDPS8YF5L/4nOo7KR1ue/vmeEQFMxFnUwtqn
         JkW8rCndJTAdKOXjZaxDOEHgNBprofKE0GNUCGkJfaDJnUxkPaJEzErW1dU/uyM/6P
         g+yuBwsf3lbmg==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 24, 2021 at 09:49:39AM -0800, Dan Williams wrote:

> > > I'd say this is follow-on work post bug-fix for the current lifetime violation.
> > >
> > >> +       kfree(idxd->msix_entries);
> > >> +       kfree(idxd->irq_entries);
> > >> +       kfree(idxd->int_handles);
> > > These seem tied to the lifetime of the driver bind to the pci_device
> > > not the conf_dev, or are those lines blurred here?
> >
> > Jason asked those to be not allocated by devm_* so there wouldn't be any
> > inter-mixing of allocation methods and causing a mess.
> 
> Ok, it wasn't clear to me where the lines were drawn, so moving all to
> the lowest common denominator lifetime makes sense.

Usualy when I see things like this I ask why those are dedicated
allocations too?

It looks like msix_entries is usless, this could be a temp allocation
during probe and the vector # stored in the irq_entries.

int_handles might like to be a flex array, not sure

The other devm stuff looks questionable:

        rc = devm_request_threaded_irq(dev, msix->vector, idxd_irq_handler,
                                       idxd_misc_thread, 0, "idxd-misc",
                                       irq_entry);

So we pass irq_entry which is not devm managed memory to the irq, but
we don't remove the irq during the driver remove() function, so this
could use-after free.

However this is counter-acted by masking and synchronize_irq extra
code.

Looks to be a lot simpler/clearer to just skip devm and call release
irq instead of the other stuff.

Jason

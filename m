Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746AB3230F0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBWSsm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:48:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17508 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBWSsl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:48:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60354de10001>; Tue, 23 Feb 2021 10:48:01 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Feb
 2021 18:47:58 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 23 Feb 2021 18:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7z8Jt1FNP1wN7FtEY3EVsaJv9Ed3Lai7a9D5rdGpJf7VZd1F9Ib3fRRLiwCIs/mYfeAsjf7jzWHUvdGNekC0aG4x6pIBmOlbICIDVHRwp9kzow78z3NtT2Vht8mTIx7yXQrgePqUSmlz/FSXsMd5NgNIQm2GYXI8yl5Jgno3INuB7NK8cvPeDDrexE2cqsNRXNshM9hnjk5fd5EOF0j3KExAvJj3Hg72IYhghwcXUp48BpI08Jn4rUGsvIkGF0sP1QKW2QwgFb8lEAgGHehgDkELD0Ej2QRzVobqEG11kaHjV8YUmuY+7xRnduyi9rCxPM4NlWZmgBd/fgF/6PW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TJkyFTpBDwqsp+XOzpw/B9QhWpkF54OjsW5ZV8QvrE=;
 b=DLSUj9c5L7SCkKdW4Wlwe4VpKCBHfmLHg1Y3kLkHizv4SvbxSYq5UWM94ee03E5UMnVETBPrGkxXV8PcJLDZVG1fnD2o3xriK9iQcoUHu4TO6bPnDjG2Z+dHC5R5nzltN/Z847TaMTyQoC0L+9zyZ8NH81PqZpdtQtFmd+nWv7OVHWYYKII3gwWlvGx+piTQ19JEBvJzBWNLl3dG9yvpMiCmtPAKIGQRTaahcvF7yaBXFmiGO1W7SjoVVpNRAWHveQ6MxqPTfg/Nl838GsVhCC+oQh6JaMw3u5AH3lb1H/EQMbPvpihFgMIpqjQUIKnsHppvtrfFuv5+5D5mlr0s3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Tue, 23 Feb 2021 18:47:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:47:57 +0000
Date:   Tue, 23 Feb 2021 14:47:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210223184756.GH4247@nvidia.com>
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
 <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
 <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com>
 <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
 <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com>
X-ClientProxiedBy: BLAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:32b::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:47:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEciy-00FTLp-3V; Tue, 23 Feb 2021 14:47:56 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614106081; bh=7TJkyFTpBDwqsp+XOzpw/B9QhWpkF54OjsW5ZV8QvrE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=r+B+U+6poRm3+JK4sVvPNBoZuiezlD2mNks8fpvIxPh0srvaniDy5bkkzf0dWPvDE
         f0kNJI8weBKuCmWyDxQTZWFILYQjb4H+c1LDZPwVDx0H/kbUpDg8atpfQquF2/OVh2
         nYX05V9I1ehK2AaVV9Zz/pV+1z0P7bdokelHiHlK/GHPRl6YdWxTKdGr7N+ul4oSDZ
         o+v8MwhKIS+G7Bu0g5MWDqC72BPxWNLBpBDtuD2afkKcU9prYDSPnm4QAynMTLTGF0
         jIbSEt6rsgtR2ktof61dpmA+tnaQJC33y3aTvkMNQpie5RSZAAAmsShlIBXUzfR2Y7
         t13sdbHZWEjJg==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 11:42:16AM -0700, Dave Jiang wrote:

> Would that work for a queue that's shared between multiple mdevs? And wasn't
> the main reason of pushing an aux dev under VFIO is so putting the code
> under the right maintainer for code review?

Huh? No matter what device_driver type you use, the VFIO part would
still live under drivers/vfio

Jason

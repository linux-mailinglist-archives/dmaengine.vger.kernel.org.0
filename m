Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF24234855D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 00:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCXXfs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 19:35:48 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:5184
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231889AbhCXXfc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 19:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoebY3ZKNq2Z0Z0HdKsPAYms5DthMhJb7VD0Eo26bq39yD3w+GYSWQC1qpBLGK8cLHV9YuaNvoqoriWlYAsnQurrAFKxq1X7K6JpivkBwyVdgLXJ9Cc3eoT9en7LVuw2Q+xvM7OdEOEXKNQVZTeB8RQ7F3OoU6PcJ4X/h35zpnSwe0nGQsCeVImzIE7o1SEPZgS5yOn1xGclXJj/G5Ct4gjlUQHN+S3vBBPP/p3TLaxY31FVLwYwzScHBi0ojQgyVJG/wxUmL6gxvE127L9Ck/RQVUfWsr4sNGJs/Fsd3SY3r7imNV1qG6EoScCRShgQULd+9RuUVDbqvWeJxiOGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zOvIoAMmjPjuxEFqpWpqVIGr0dYcJorhHu/btuEFU8=;
 b=KHFdEt4J0jJYj6KV7rzVNVQUsU35iIKZWi/9vn/xjGzX7fd1NQbL2rAEoI3G92g/jawlNmGe8YJqh+4xFxRUGgdOT2IvP033DgmxmbiL0+trca7j55vmoKSuy1HkJ3jhErHIXXKMvbQzBri5zc6cUjUvFo7cYkga/CazshoYMxuia3H1tbolXvd5NEha3bqvnlFnCsMLKKKtqMdQt4fRpqFMKm6gn4HzdU8L0KZiQf05DfCAvqyCYoGgkewZgAjAjjbP6L9Ce+NL/6zQzg4/Ma18NW2g+T4FRliPT1PfC4xqkY3dRR+gO9HH0mS34ULfHzcBHJ1a6ZwMGSujHGyq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zOvIoAMmjPjuxEFqpWpqVIGr0dYcJorhHu/btuEFU8=;
 b=B/CvL+qu0c+VhbitVW0giih/35LCQdDQ9wKjIVIqzBZG2Jp30WsTBhusJB1fP7lOOy4UryAom4KZ/UZ6UhiPo79ZLqwlXk90Yj6fSxYelretAbQ8y5PY9E7TeQNaHVgQzUpxAR8uXlWUk+f48//aRHMkwnQZeWp5WK0q1Yj1ege90pQQxW5Wf8PNsPJTRpTZhevUjRFHFgFWp33OVA+SgWYavSl06uJSIVUZE3cz/KA1epGaZAZ5iGElkd7AP9bWTP0o7pedE4imoi4X/rRbUaPyN4AeVgtKDWA8qUs/wOsYpiso6x7ZKUhlre3fmMleObrV+jmUQzntXtLcdtkehA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 23:35:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 23:35:31 +0000
Date:   Wed, 24 Mar 2021 20:35:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324233525.GS2356281@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <20210324195252.GQ1667@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324195252.GQ1667@kadam>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Wed, 24 Mar 2021 23:35:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPD25-002Dsf-Pn; Wed, 24 Mar 2021 20:35:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f87b71-4be6-4576-0e40-08d8ef1d8214
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34044D6A3F404BB0303F7AD5C2639@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRNWeEEhCoKlcO/cDyMqE2x+cxB7JTGd3FFutVQooz8nz5kDey7hWlt1tPD6B7dBplPJ4ahlpNw7BwPh44o6/ZM+6ODBhGZAgMq3/cimmI5ehKxdBJOvYTwPmHsgsHCQyFIND6pqmRrvdvwPV+EE4F9b4/jHsWjeFV97gNNm3hjVnWvCzc7Fr2hMuI51YcRbLV4+c7qSlD6doJgtcQrFUnlQXaRx3eG6aWaKZNEnbgXo+hCbMu/MrLlHZgz4hXoKP/8lufK7qEp4vYkLj+H3r/lMayq1Iv/S3b0K1vHkO8Z8haUQ4VjpXcMfEAqILkbRKIDC6xMWKBM3Pg1+PbGqUnFL5enK1j44y+10uSEyvJfegsOgXLpNFtGCOoeAoDG4KTA0eQ+fMJyzHYrfA5imL/kX1ddkBZ8akKfDghHfjtKGnEsOcDp9Pon/WsveTvikTgMx3l8EB0qe+1Lm9tKjxoQHTRKhuBIIvLZAnqmG079GhGWb32FVcsN9guLhv8wmXxnDLkSiGv7fxd0EVUPrUuOlspxUmL/VMMlbSIl7zHKqJ8sStO+wDhBj72CDt89kxmYSe43EwioJdfpkCH69cAm7YXHh1VIKVjCDhAY42xzDScBMxE3TcOa2vUrTIYshSjt2QHXF29Dh1G9i82ycDPaKbu+pdJbvEoJaMNDpyCN0BlszkLVCjzI/+1qICHjuxAbyyT9z8rF1mrk2NEEo7piNfYoTcqlzT2OYtkLhDTYrLeNiZdzBpWF0bZn+zfAg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(8676002)(9786002)(9746002)(426003)(5660300002)(54906003)(26005)(478600001)(6916009)(186003)(36756003)(316002)(33656002)(2616005)(38100700001)(1076003)(2906002)(8936002)(86362001)(66476007)(966005)(66946007)(4326008)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wE/9Ux/i3WOOW0a/U/6C1epthEjXcLz4dEllm3FiotLpBafpwVCeLPywKDBw?=
 =?us-ascii?Q?tIoKoA/z2iasMo6PA/+XPg3X9ruD00hOQD0Wp7/MKlRqc2sSrVZd6ZFCZ80b?=
 =?us-ascii?Q?mkMOy3C8HPyCj6PHzsi/vqiAF9F0/+tqh0vknfGhx6BK/35wlRsiB2bZJTnP?=
 =?us-ascii?Q?MkcftspPQ9vxk6PH43b3gWiuet+shaJNF2O/se4/h+8QNURAedUp2tB78Nq0?=
 =?us-ascii?Q?a9xe3n0t6z5g+qBwiJ4BqNA04PQaUzj8pKYd1ddRuAvA5lngM7A1V+pn85Zs?=
 =?us-ascii?Q?M0KpjDJfzLmezX6b27zUsXcMmFxG9RFe4xGxUEI/ORKdCqMNA6PSXvfaQDut?=
 =?us-ascii?Q?vMIyheOVolYHrAVcqvyxZgPzbyl5IAcJa2o2i7Cv84QF+9pdJ6Y034OAceuL?=
 =?us-ascii?Q?HcSVXs2Py+MopD449FHsWTfUU8fQkfdulbtjVNPrESEFejbt+RcHP/kPSehL?=
 =?us-ascii?Q?CDlc2TkCKxGYJG0tdFeYvksZkHeK9Ikuads7OHMQMX+SoAYJ5Ff01Ob7kZ5q?=
 =?us-ascii?Q?dp5kvNbFyvpZzfEkGg0ClWpTgqXJcNlyC8JEqxip9YLIp6/8wP4KyBtT1zZd?=
 =?us-ascii?Q?3bMl8BfU1hjHLRdrwHY/iZmiVLgE0guTIsoeYTi1q5uyG7hMQrxrd21fciDI?=
 =?us-ascii?Q?F2NcsqhkGEIYhhNptg9Lu4J5qsGWVG49L8cfRohVFqcpw7JSWVkSCFcjWRwX?=
 =?us-ascii?Q?5J0O4za1vuUTmXjJDHpbCXYMrtqvHnsqUHXqA0S1d42DloVVq/sHLdzKkl3t?=
 =?us-ascii?Q?qw7sXGE6TkEk3/RkWhyk8M0dlyYHhM8NspkoCWufzRtDMvCHIxXgJ40kNz0q?=
 =?us-ascii?Q?J1wO9i0OWCinvEUy7LTBTmG2SwnH5LpGWYU6qEbAJeVjRfKUmNiwKgc3p134?=
 =?us-ascii?Q?Dqg0NeN56nJnjsGk82uOd8Cv65dFIYOKHYtTdFeMtflKMiHDrmRbdKqhf4W+?=
 =?us-ascii?Q?fyE9gVDnUYC7YCshxAQBNOKg72OBPpatfSEg+IpNeMenFmMoQ85PLBTAQDfl?=
 =?us-ascii?Q?kjFfg62WcOvzzd2oY2+9udytQUuk+9b1iotZIq2hPMjOO5jKCwff1Fo/1EO/?=
 =?us-ascii?Q?640jnCeJEUkLRt8uuOWnMQpzl9B1C3SeZRQqLH5H2aSnavJXRB3XOSg9plcf?=
 =?us-ascii?Q?YpMwqQceG/hjIc1R9HPjnh+q7Di+0Cu1WAbjylOTnIByy7Xa2ABaSa+nEYWE?=
 =?us-ascii?Q?nV945SZCkuXfA5x9I9+Nf5m2NsLeztSLXx+krHjoWT0O+yXossxOYbWHxBCN?=
 =?us-ascii?Q?XRol5PT5zkxdUxNLBbxMfjzgWxKQAiESSP9hZhxN9GGctgu20/+zjTfHKEz+?=
 =?us-ascii?Q?ID4idTdmcI/tBFRhhULaNx5p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f87b71-4be6-4576-0e40-08d8ef1d8214
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 23:35:30.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru2Tiu0D67qbZzpMqHomp4X3SZNgSVmDfH72/YXzJbwpNQsKggqxRlq0JRkgzGJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 10:52:52PM +0300, Dan Carpenter wrote:
> On Wed, Mar 24, 2021 at 01:52:46PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > 
> > > Which is just:
> > > 
> > > device_initialize()
> > > dev_set_name()
> > > 
> > > ...then the name is set as early as the device is ready to filled in
> > > with other details. Just checking for dev_set_name() failures does not
> > > move the api forward in my opinion.
> > 
> > This doesn't work either as the release function must be set after
> > initialize but before dev_set_name(), otherwise we both can't and must
> > call put_device() after something like this fails.
> > 
> > I can't see an option other than bite the bullet and fix things.
> > 
> > A static tool to look for these special lifetime rules around the
> > driver core would be nice.
> 
> If y'all are specific enough about what you want, then I can write the
> check for you.  What I really want is some buggy sample code and the
> warning you want me to print.  I kind of vaguely know that devm_ life
> time rules are tricky but I don't know the details.

This is driver core rules.

The setup is:

struct foo_device
{
    struct device dev;
}

struct foo_device *fdev = kzalloc(sizeo(*fdev), GFP_KERNEL);

Then in each of these situations:

  device_initialize(&fdev->dev);
  // WARNING initialized struct device's must be destroyed with put_device()
  kfree(fdev); 

And:
  dev_set_name(&fdev->dev,..)
  // WARNING not using put_device after dev_set_name() leaks memory
  kfree(fdev); 

And:
  device_register(&fdev->dev)
  // WARNING not using put_device after device_register() leaks memory
  kfree(fdev); 

ie kfree is not allowed on any control path after the indicated
function calls.

It is systemically wrong everywhere, here is my first hit in grep:

https://elixir.bootlin.com/linux/latest/source/arch/arm/common/locomo.c#L258

Jason

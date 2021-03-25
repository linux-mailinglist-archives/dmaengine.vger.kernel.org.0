Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A0349120
	for <lists+dmaengine@lfdr.de>; Thu, 25 Mar 2021 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCYLpj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Mar 2021 07:45:39 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:54240
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231246AbhCYLpZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Mar 2021 07:45:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5FQK9AfSBC4CDlKVVfgYjmBqwuEPAAnWAVkk2Iq30JPzypoOpVnNJy1n3zlBlflMzr9aEmlPxhm7m8aCwN3sDeO2+thXDhWNgxZ/q596goPbuT7QZbnFVlVchBvevxeQU8sOsQ8PqdZCXIRYzaV3OeIJjVtNAfEMlphMSFl/68X0FJy18kUr8reTwWRA/spVHd+MMdBIxVUlkGNBIRAImrqU84zqzGyNH41WMSy8Myx2z1grUeLVuCqSks0oa6YuA8EaWYa8zSqWH3ZfQCCH/eYiPeeCm6YCaGuqAcAjOEM09Yj/yND2RrTIk2mn8KTF/tA5SBJz+S6Rh2oHfVUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUwVxISDWlvZFKTNY7MiSdUqGao9o6J1tK2BHRq35WI=;
 b=RlWHlRCiXqY1Rx1W6QRlqO56Kxn8NCGDrk+ujkyvUABoIgeAJUtAy3fcVTrxusC6/jmVKobR+bBVSXw2U3QnQzbvfI2KUmAdQ4hYNZpNxuFsqGmvcfmV9hpZSWjz3RZyeHSrlSg8Nhnr697Li13G8w45+65mNsdaJilVOzEJzwgeDGVxVKJz3nrJBB37GOjI/uuTEceKKIvVS3YU/+4WPLAn+jnV/QdTSkBkLkNyjRWgw53QNn/HrhBzbJIpPJ2gImp43r+Ybq2F1hCoEPUrMQglPtH6xkhN5cKFPFnM1I+CVxG0IaemDQZdjjk+wQ0tbRmRCwaVFhUqAvNBJNilaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUwVxISDWlvZFKTNY7MiSdUqGao9o6J1tK2BHRq35WI=;
 b=H3QaZjtVyGfEfzBmUWlQVwA0sSH3GyueE/ap/Ta1pXtW1k5CstALbgaP7yCeEIiahbeCuvCWL0aSvBDbC1bFFS8WeJ0et3r9jt/xd3vgw3QIGiKRo94iM8CnCkwfy9JF+IbX1UnluqPR1a20srQwXL3Ss6B9WShL85X11p448SvvvIiZ4+stdSfvh9em0srUGR5Ll9dzoHJ1ZGXi4UhYet1pcFWUbMPREK4bjnYTLdVOPCfGNm3a/tRiJ1cOE7D+Yq07d90CIfoxULb3MmuO6OG6KKrpZh7xU6Pj5s5L3HUzeq9iZd2HLHfbvvsdfRLI9OpctKGcHFUu7AwY97gK2Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 11:45:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 11:45:22 +0000
Date:   Thu, 25 Mar 2021 08:45:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210325114520.GU2356281@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com>
 <20210324195252.GQ1667@kadam>
 <20210324233525.GS2356281@nvidia.com>
 <20210325065205.GT1667@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325065205.GT1667@kadam>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 11:45:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPOQS-002Uqw-UI; Thu, 25 Mar 2021 08:45:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892de81e-fbd5-419e-bbf8-08d8ef83790a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243FF4EA8561F3847D2EA89C2629@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsxuHY3svNtxGbtqh27ncz8ENY2U466Sn///eldroPuZHx8gGfPRxvdkAohF5lLflhu+poVmi78NNk2q68VGKlGpHkCAwZSxxkszSZlK5CyP7LyCNO7gkzPg3ub9nTSLt+TmZ2g0BEKTvi0YLhib7CpJLEJCg95szUYuGVvwcAQ8LqDpXRK+1g766dx8Eb5ga5mtT5pHf0hAbRqpYAzf3TuR5MP3G4thRYt+/gLZs7dYcgFgi4kAcNT/L1Kgj30/GYudhKl6cBWZbSugSKtBZ/pkIM4KeDliIpU6y881OOIZPHHyOhW+aU13BfWwz/U8YnxMN7bX6OOrc9I6VCmfTezZfZ3f9iVrBjwic+V0wth5VGCnIphEVXjTzDrow1bvpsBt+DESp1WrfoPuu/TVl7QQn+n+lNNjw1rYk38sNlYYYvkS3UhBtj2q2RquPttvGBUj1k7VoLs7Ivmo4My2QwGYLyABGKr+hn1rlXgHTZJpdhnA+J5UqkFcc5/59EmzzjG3o58LHvZ6er/Nvp3uLwRY9HF3WxhYL+Qte2GWusX2pakLY91vtcMGLo9p/obIPa1PI5jVgnvaPEisKnbBIsC9FFbjaV4hHA39JYRcVt2aXox6JsGR5uepAatRrkCFaZCLQ0JvJ6lO0GmPKqKrh996oiH/CN+MlzQqst0eKVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(2616005)(478600001)(83380400001)(316002)(66946007)(4326008)(2906002)(33656002)(86362001)(1076003)(66556008)(54906003)(66476007)(38100700001)(426003)(5660300002)(8936002)(9786002)(9746002)(36756003)(8676002)(26005)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i0DjeEzedU/1i6h4RKChkZD9AHEC43b3Dk550DmHVQ2c0r+JPhzl85/v01Zh?=
 =?us-ascii?Q?gsIw2uOBfIuL6kGgesBoe5oydBBLwwkga9HcfrP5ZAUlkUlxLEFIgeBqHoRd?=
 =?us-ascii?Q?21P8s2YkJQlq6nuOF8hk7BejOQZsCJd2kZVBZei0o8hs+7YDi1l3RbaplSSu?=
 =?us-ascii?Q?PBNT8Kq/MIz6kAVI1GwaHqJvrBzNCqDElLHkAW/p6sWvLvLGCEYOata96WVL?=
 =?us-ascii?Q?TnJyDpJViPEZhzkSlVP90k2Yz7C77SYNBQl6haE5dIgmAsHMZAbeRSilCEKA?=
 =?us-ascii?Q?OP/BGAKuwjMfYvpWtLrqA+GS0IO0kRRTRwqW5r0HOyWdDLxQARvL5S7d0wqy?=
 =?us-ascii?Q?sZoprWjHXJiilhXuKvSnC3mTYKvnXVk9UFwlWTSo/ivBB7QxOipObkFMC14V?=
 =?us-ascii?Q?viafOFTRT7hlgGW4OIaRsEPGYVv3DgS3Ke+NjiLdKDMsO2roj2y0oRohkigs?=
 =?us-ascii?Q?WRKn3vkfeJUXrTnudnqKUUsEW+eILK4sUJZ0xYMFcO3ZwTUe69dhJcQzR5uS?=
 =?us-ascii?Q?A/f23zlUQikmgRzxkAucvM4A6/ulpD2nH11dFlTNoRtZ3Nh+I5+xB8E1bn5x?=
 =?us-ascii?Q?av/TdsHs6wrjyBtXy8MsNlnU9hwDxtDNrw+K4hJeJdc0cZfCYpG6ylZSjnvC?=
 =?us-ascii?Q?c1yjKQr8WsO/l6WFpC3eBMaW8IpH+/z5LZvq90MjVo1EBio33I3Rhtk5/hLh?=
 =?us-ascii?Q?FvXk9UrOcYVMrfZxXY4nLiK+U0juDMJe61VjboActdaiYHsXd4LgKfroiKzR?=
 =?us-ascii?Q?BsEX2qOI1cftYUI5Wxp+wgDQ3++X3ChbVv0zjJhKgdhP/CBZhSPaNOu4lzq9?=
 =?us-ascii?Q?u1CEV4LDZCe55fKA7+MMev1VZcgS/DZQFiArzXaW5gJgMJE7jtMySGh+g0Tk?=
 =?us-ascii?Q?x0jX7PEpPwtjpC0Vok6UftKzYvofecx//qr1N6HjZu3XgdjJp4HOhfXeUDpK?=
 =?us-ascii?Q?4ADjR1hEYesiBmGitQTDAeOsLA2rilm6LzOwViq5p/SR7iduqoyUh/OBsHPl?=
 =?us-ascii?Q?9jZ763NAfpvZq6EsGURiWTaUs2f0gUEHDDEcca1iw5e4kbDODNiiV5Fg5qSK?=
 =?us-ascii?Q?OApBaju7KWHmnSs/UMD1MY7V/I9JMjwhv8Iw3I+SpCk4Xmuv+gKBoyadOjXZ?=
 =?us-ascii?Q?yfkVv9pIWc+mfFKxhk0RIK5YiLKeIZUA1pZQXhM6Hnx50B+IKI+lJKeKh1t8?=
 =?us-ascii?Q?fJpcMN64X4ut7LaWVG7kVKO6Hg+qg0lHvuAZw+v/j5D4M2+az/qdwsaLLQS9?=
 =?us-ascii?Q?WXswp5hf5kg+ZRyCXEYP2gz3ZZcBMfV+GNu4y9kmNaG+NIVQb3+kdcgtJy1f?=
 =?us-ascii?Q?ylwJ2Tn4gbHRFFA8A3patVYO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892de81e-fbd5-419e-bbf8-08d8ef83790a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 11:45:22.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFunB66f8Gp904Lk54P7uwtjsYOmcfN35Fs2Gcujza+dliCABlibgOZpW9qd0twt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 25, 2021 at 09:52:05AM +0300, Dan Carpenter wrote:
> On Wed, Mar 24, 2021 at 08:35:25PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 10:52:52PM +0300, Dan Carpenter wrote:
> > > On Wed, Mar 24, 2021 at 01:52:46PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
> > > > 
> > > > > Which is just:
> > > > > 
> > > > > device_initialize()
> > > > > dev_set_name()
> > > > > 
> > > > > ...then the name is set as early as the device is ready to filled in
> > > > > with other details. Just checking for dev_set_name() failures does not
> > > > > move the api forward in my opinion.
> > > > 
> > > > This doesn't work either as the release function must be set after
> > > > initialize but before dev_set_name(), otherwise we both can't and must
> > > > call put_device() after something like this fails.
> > > > 
> > > > I can't see an option other than bite the bullet and fix things.
> > > > 
> > > > A static tool to look for these special lifetime rules around the
> > > > driver core would be nice.
> > > 
> > > If y'all are specific enough about what you want, then I can write the
> > > check for you.  What I really want is some buggy sample code and the
> > > warning you want me to print.  I kind of vaguely know that devm_ life
> > > time rules are tricky but I don't know the details.
> > 
> > This is driver core rules.
> > 
> > The setup is:
> > 
> > struct foo_device
> > {
> >     struct device dev;
> > }
> > 
> > struct foo_device *fdev = kzalloc(sizeo(*fdev), GFP_KERNEL);
> > 
> > Then in each of these situations:
> > 
> >   device_initialize(&fdev->dev);
> >   // WARNING initialized struct device's must be destroyed with put_device()
> >   kfree(fdev); 
> > 
> 
> This email is perfect!  Exactly what I want.  My one question would be
> what happens if we don't call put_device() in this first example?

*Usually* nothing bad, but it is wrong coding and against the API
contract. In more complicated situations it becomes impossible to
really tell if it is OK.

The rule is once reference counting starts you have to use reference
counting for free.

> The laziest thing would be to just add them to check_unwind.c:
> 
> 	{ "device_initialize", ALLOC,   0, "$" },
> 	{ "dev_set_name",      ALLOC,   0, "$" },
> 	{ "device_register",   ALLOC,   0, "$" },
> 	{ "put_device", RELEASE, 0, "$" },
> 
> The check_unwind.c file assumes that every function cleans up after
> itself on error.  It doesn't look for the kfree(fdev).  I could make
> kfree() the rule if you want.  I tested it on one file to see if it
> generated a warning and it does.
> 
> net/atm/atm_sysfs.c:167 atm_register_sysfs() warn: '&adev->class_dev' not released on lines: 153,167.

I don't know much about check_unwind.c, but it is similiar to
kalloc/kfree rules? ie the kfree could be in some other function

If you want to be highly precise the control flow we are searching for
really is kfree following any of the above functions (cross function too)

> The line 153 is a real bug

Yes

> but line 167 calls device_del().  The
> comments device_del() say "NOTE: this should be called manually _iff_
> device_add() was also called manually." which suggests that this is a
> different sort of bug...  Should I add device_del() optional release
> function?  I have device_unregister() there already.

Yes, it is wrong too, it should be device_unregister, except that
would kfree the device and the caller isn't prepared for that.

The flow here is:

struct atm_dev *atm_dev_register(const char *type, struct device *parent,
    	dev = __alloc_atm_dev(type);
	if (atm_register_sysfs(dev, parent) < 0) {
     		goto out_fail;
out_fail:
	kfree(dev);

atm_register_sysfs():
           err = device_register(&dev->cdev);
           if (err < 0)
                   return err;

So we kfree after doing dev_set_name which leaks memory.

The whole thing is the kind of nonsense I hate - it is trying really
hard to use device_regsiter and it *really*  need to be coded with the
device_initiailze/add split, device_initalize should be called in
atm_dev_register() directly after registration.

Jason

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A029D347E3D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 17:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhCXQw5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 12:52:57 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:22113
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237012AbhCXQwu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 12:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoPVwKaScP7jfXelfncLViCPQuUxU06zHWN1QI1st4xz/eLAMlEy12Ww6UEr304C33YGw+KzCwzp0gqn5K6bS5phdZ1XYKdf/K0BfTi3G+s23S1oNbFwd38upk013CaOdL7/VCOwY5ItIPjQ+xOgKMAleCLL5uS2Og1Aoqlilnw2tZll0EfOqOJTkrS5CGfyLqztGzwhmiLsHzHPo59TfpHeQypoQymmphcNDWvB4I/cCyh2st5H+857ObbFovciUznXhEiJ4MD/deB5wOdtDlEcoWRaWxcN+596EXYAf+AFwFKoxRSbdeJlFSweysTjwe70sn0BnaIGwPhgm4C3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GzIlbn0Rnbmq/omTSKyfwXckUY2X2SS2qIpYpe9nSo=;
 b=fGtd/T1hwlmvqKIqYGpZR2arqxnNzqU51bzZ2O+9Q1C1+MPe5PvCuoqw80ivdWkGR6aIsnnSv2KS3erW74/xpvAaMfKZ6clShDvGro01CmFDju4IfyfVG9alw9IYOLv6xv++jxsozvfPj5zkz9/zcVTeLbNseNJ/1HgvzS4V7tiMtEZPgNVMsHYTZnwfeHMiYxNZLGjeYrC4UliGly6oyXpQuVGl8sod+63k3Z37eaET69ZsXNjVkkTj/VcuvONX4y6jZIEbXG8eEEMFKZ/RmCL6MmDKP9quko8VRnNh7fhfyvBcRY549jJ3xVEG6RCY3+jtejkYvZTdTKaORQitiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GzIlbn0Rnbmq/omTSKyfwXckUY2X2SS2qIpYpe9nSo=;
 b=JzjH1tKtWy9d50p8RVKr3C2qaLiNK1Zqc6E5foV1DxjPkfrrpqG9IihkP0XUfuOm1x5fk4dVgRyoyXMeyi5DfEh03LkLgPonIkSdDmiiwgYgyLn0io+uQlCxwvKAm9qb8dmoYwKjAxO6aTCbxf1NnLXUuCyLm1FF+gb06qwLBJTZLIuO0xZTaer42awsbhAN9koZwOGaLpiia61hAGhn7MKVrNnRZZJ/N1gpfDhlqZyDfqzpj9ZRXv5LsK+3tJY96fYGL5PI6lIZLDOYvnCdfOCoUT8VqoG8SyAJ0WlWCmnj6tsBQa6jEWmsvKPUFPaOHvnpUb1XX7oXHZBmTENO9w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 16:52:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:52:48 +0000
Date:   Wed, 24 Mar 2021 13:52:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
Message-ID: <20210324165246.GK2356281@nvidia.com>
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 16:52:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP6kQ-0024tT-Ht; Wed, 24 Mar 2021 13:52:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15ea9c4-3d69-4d73-6f95-08d8eee540fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40124B148E33F092E23DFC8BC2639@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yhBLw0BhuL3Yidicv258pmyxjsvv7fpzb1O4vQAOdJPMz2sD8y3hb22cbyPATebxOOfJbgF2boLp1ZtVIAFTuhOZyYP8lddBhPmApeUajwZc/24CRnxUuA1Rrb9nAKSxTnuLPEKK+2z/F8z+yLkoCyYO6MTPpeSAFlbKwrMsMEWG7cSh/VAAZ/ZHapSGrOdkH19zP/VUwgKpfDzGkM7Mx0M9kHhcn/zzSsC3KciUobUmGEuyMNpxILiRNOQxiCk30mZeZW7XDLynsSWoAqcNh0CRh/qtL160WfwO76DM6jySTEMHDOFS7Mu2E8n1310HQzGR11CP6eLj0EO1HfHyb+DMvUVHu6hDLEMQHbHy1RmRnfhFIIPGO0rtU3D2FzvAjzgNO1Blpx2DQaotRlf92zwaZD5C9mZcAT/W7+/Q34a3+oJlezmdPAd638tEkm5aeRO8psnPePSz7WCz3r06NVP93roU0+L7JSGwqrph92CQDR51TBcq8bD/oN9fcVxGv2yAoHUkb2xEiEZEewqz2L7UsYqryhrJinFpjI1aFDJZfkvrSjyxFaq/t0kc3fwqD7czfmjJuRo3kNX+jOuMG8Xsv05P6osISLeRvAtsUcUOStyPZd7YXzambRQUemEwLxm642gqM5QSd8irpHQeKczx19W3HJuKS5dJXtrNuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(426003)(66556008)(66946007)(38100700001)(1076003)(6916009)(8936002)(186003)(8676002)(66476007)(316002)(4326008)(5660300002)(54906003)(26005)(9786002)(36756003)(86362001)(478600001)(9746002)(2616005)(83380400001)(4744005)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vagno71qNp4Mk/pUxVcHGB08DOw1nSxtSYAWdrMc2huHkDRl/sdXocKPbAtS?=
 =?us-ascii?Q?2xGmrL2bGCADBByfntrKArP3E3vGDfrgG3LHqhgw5NxxwW8VTKTIte+i66vW?=
 =?us-ascii?Q?Cpk2oGII4+SE4Xo5Lo6X0zwjGtG8n0he2TRZvoUG+dFG1RgMNIvAjfIOgfwT?=
 =?us-ascii?Q?WDxfRAXtR1m3r2b7n2/zyxz+k13rZjtJYsjnMxOQopNL2p5uoAlO80bVgmcA?=
 =?us-ascii?Q?uurUMv6Y8H2cOmin3X2XILkuhpmnknE2GMPLNpuS6rsPOkV+crXgTyDeNQeU?=
 =?us-ascii?Q?juYG/Kf3R3Bcltkon0uu8qAmxBVTB2LoWJ4xV0Jea8SRRs5NsFgl6eIpZHQq?=
 =?us-ascii?Q?4L9LZTjgTLmgK+JPLtekADx69JHOmQx9f4AcltLx+hw8ZbJ1TivZXfN1GGRY?=
 =?us-ascii?Q?qE4WSCGZc9CWoFzlr7dUFBiFR9GE10qK6MCIXbBhchGmwD23Iu2W6z9FTqyD?=
 =?us-ascii?Q?zkGS4y/QDNT2l8uWkQ17ds6Indf5InhIAS45IzleT9kDqUGz63jvCVwCeeqn?=
 =?us-ascii?Q?jBPYGTaPF9Yqi3vSJKfxWU6qSbn3Pxkxp/ID+UPoQHMzSlNSc6ds5O2EEQbg?=
 =?us-ascii?Q?IJMTl4WTLeTOTtgQxsCgbhAPStJJMxTmA5XxpyHCHJTsNWZX9qdJPCCl62qM?=
 =?us-ascii?Q?CMLhjig+gOuaEwEPeUWbJgHxF6GxbIni8vqd6MLm5exTrjWQW+AfXvHcPSpc?=
 =?us-ascii?Q?EDDInjGOivEKJTVErEcSxhEaVW/mizxJ1aEd/O8TQvyY0pc+j9ibJWOza3fH?=
 =?us-ascii?Q?RRjqqEipizxeE1rEAS0E7/wXLjJ9wYxNIlXy6ltsRtg06gINVQP9gELO8hmW?=
 =?us-ascii?Q?hkXu2rohP5ZriR/meulvYhfNXjUo7Vs5kjjQjojSgv+FfYGTO3+9ZQGardlC?=
 =?us-ascii?Q?b2bfJ+CXoU3XQ+Vej4tC4MRp/Lw5vT0A+SfBD4itO34Rzl1nDgZzi/5kc5Pn?=
 =?us-ascii?Q?KB3qjDxqoczdso0nBj2I63mTnkhwIU0KakKiK+MmWxAxaBTyrlNop8xWOC8z?=
 =?us-ascii?Q?N+ndGtt1RFamQoVl2ztBy5bEzczbVnL9S1YhOKjOK/N3N6CQH95npfP8rY9b?=
 =?us-ascii?Q?EBDAHhHKQz8y64LSZouGasmbQNLfEZMbUHz0NnrtzXcqYftclq6RnfXDXMv2?=
 =?us-ascii?Q?jtnQfEsqBzSjPdpLQihjeTt46YIhugjw7TdDzqey6bKybf581EHahebmOsKU?=
 =?us-ascii?Q?zOWlWzIYrpkXXouxOtlw2bjAHQbF/blSKBrr89012Q5vmk6oEmgLlDb6YHHl?=
 =?us-ascii?Q?YgHC3MgcALCAbIBAedlvtRReQHTmasf8cLB6nuXe+3d0MpqBFbwkoE72AgdK?=
 =?us-ascii?Q?WELDrO1JRdvrmpNAE0wo7LHB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ea9c4-3d69-4d73-6f95-08d8eee540fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:52:47.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiwiW5QKcjVS2aHlfxPsHLMcZP+wqXlsumk2vCDxLi9x7yZShf9krqR4upNWhsHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:

> Which is just:
> 
> device_initialize()
> dev_set_name()
> 
> ...then the name is set as early as the device is ready to filled in
> with other details. Just checking for dev_set_name() failures does not
> move the api forward in my opinion.

This doesn't work either as the release function must be set after
initialize but before dev_set_name(), otherwise we both can't and must
call put_device() after something like this fails.

I can't see an option other than bite the bullet and fix things.

A static tool to look for these special lifetime rules around the
driver core would be nice.

Jason

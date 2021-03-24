Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85514347B94
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhCXPDi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 11:03:38 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:32640
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236429AbhCXPDT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 11:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+6sC87X+iQkzcf/ORK9O8QRZYrSifWIgLgMz/KEswcrXEEv0bd65tOJUG6G0iMwUmCwr5t6ttqOXzZ827qmPtc5uOLxnolCP8pxs3bTtmZ38JBZaHQVPp1z34Z3EqlvMUdB+sp1eK3fyHHvsMzLPz6Mn0cr+2l+BEjy5vk/Z4fxKNiMqVRuCVrPOxr8yON5avIUg5dgqHWR7keag2qEYKmzsObLqQTNQr/h9E7DpM+gIVaz3jWpu4sXk9csAw/GtqwPaHkH0Q4y4BjGsXfj/MHoXP2pxrB9uli8SoCWva+c7pAA1J2hoVFpqrTpUhfhPQlsz1l8R68v6GaEQFyeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMxeX5NzAdBAX7YUGqdvh4J195lI7He/4E8olkTS5Kk=;
 b=Bx0V42uacFuGSOASB9IEV82+1rxev7IpJxI1mrR7wLqOR+S/3S2V6Ti0fz1o87qaA1pG63ovAYhraq7i4Km03rekuUU27JBxhB3TDcoWhO5X8LHQYdlrTMOc8msZ5RBZxyBqLuv06n2J32FmKGJBj09I1jDJt6vXPDrx+PztNJLW1sRwO+8UNZQOpsgIN22+0t+FjfZ1OnNdvC3g9OWla2hkWhocv9Wz/dceykLdTnt6P+IOz9UIgWcvnL9NlaLuSn6Q6z+RR38ivhGtz+gRgZ0z1rB7v3+rD8wEL/akSsWESONZqT3mGlhQbSuE2SKnUAnbGL2t5uZ1AAlRkBkOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMxeX5NzAdBAX7YUGqdvh4J195lI7He/4E8olkTS5Kk=;
 b=OoZxrXDcdVln+WR7jkfl+uI0WFfeblp7o0VoImmyuAK0HgerO77or+5LvikkHvJegAf0d8A2a7rrvDFx3wAqGAz+B///tnzc13kJjz2wrA6y7aSdYt8kpjNYCgjXgkUFBc4n+4U8jNeKZjNErqUgno//KPjLGClA275kDekeG5YwHXpQgIpoo3HeNPxDibMkrY5T+tcwOhWck6+tvVocFD9qrDQNiLNJAlfKzB2NGyCASP8dEWY2Eg3rhp8m2byr4Min8yj2khjelfkpJLWG01TTXRFzl6A++Cg4/fXwFXnjlmmT/j7TflnjGivjpF9kxs3kbXDRRleTbPqWnyFRYQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 15:03:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 15:03:16 +0000
Date:   Wed, 24 Mar 2021 12:03:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <20210324150315.GG2356281@nvidia.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
 <20210323115600.GA2356281@nvidia.com>
 <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
 <20210324135640.GF2356281@nvidia.com>
 <d160ba36-84f8-1fac-2802-8b1393e17bd4@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d160ba36-84f8-1fac-2802-8b1393e17bd4@intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 15:03:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP52R-0022dp-2M; Wed, 24 Mar 2021 12:03:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8ac997-6c2a-4bd8-37eb-08d8eed5f442
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404968D010B15FB6CA13E1DC2639@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYrTUdj1B5PiUFAynxMyLK1z48sBFEnwK4jjMywyUpNykD7eAtMYYLYknB7xC/M4NjO0Yi9KeN7Fr9ubd8UhKOyP8T+GuM/nMijmpWN/fDnDKIwr2RcKdknoCz7OSn7hdVS0XuG+6NL8PGfd/bnvn0MrKgciXJaet6mhD0Milq9IIafWiami2htIE2d8mHWA2Zn0g0zx2f7k4t36rlCex7aEeJTWqzQv7BtjGrnB1Y+dZbCMTGpBdRYFQ7niEdo0gFZDgtNzPDCGz8rCQ9j/RKiEgO0Alm8qTUZStcjTg4N9Mj8wvZ5DBCft4+77zyb0hGsHUjMr7H+OZe8SSzMr6uZTKGnaBG1HFj5HRw6OYsnCPT2Ppcuq4R/7TJUMMy60S1f2DpkTKi1rjWuJjh5XTRrsHyMlkNqQJebkNZ2CCctAyhXwni/ItbWqYaoq7uIgrDfMbwk5j2PAYUaTtAwpzr50HZgnv1mxhcAWXlJtjKpwZvLQw/rFNOXdBbZh+cuNutosR3QqylSYSP/HBJ2dBVPWhmfQlPlNQYVEYVJWVIb7J9Kbh04b7jdecFnPg28IDVfoSbDRwEsnfeoFo1kOIojeQVxoJycDgruijPb8NhJco9wbBaSPRcHRl1w4micQLde4CPu42LN6QbZrvglZfE/RWRo7PEjGWA93YID9OTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(478600001)(9746002)(426003)(5660300002)(26005)(8676002)(9786002)(6916009)(186003)(36756003)(53546011)(316002)(54906003)(2616005)(38100700001)(1076003)(86362001)(2906002)(8936002)(66476007)(66556008)(83380400001)(66946007)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WHQ9hcKQqd9s78S7yG7WgZ2x+/26E6LYjp4BANiEkysjeJ9umBT8Y6qsTxr7?=
 =?us-ascii?Q?Y361VaN48Q+tDC0sd8PVPVpRFnno1gSDbFwnJYfOT+ug8b1kGPOLwy1Zql2F?=
 =?us-ascii?Q?NfppbaK42tv91re+HTgBlp2WG6Bau3SVDozxD04JplooJRlU7J/2D1+m5i3h?=
 =?us-ascii?Q?fAUTP1p91RzAKBFWszD8GxidFwjlBtCh22JGTYzwfBNiM4neYNs9tTJua5E4?=
 =?us-ascii?Q?U2FJRLl1tkrywnuy1KLYRiqmq5ajBP+AooiGoDXs70NolPc72xUYFu4XqYAF?=
 =?us-ascii?Q?PCFpdvjvPVU/BUzopOv8qNDPL0LAkoA/n08KOHt4Zl3Ej1yGMUKW+/bDsf/L?=
 =?us-ascii?Q?wgH0t6efijQz6i8+5VXVhKwWDyY82ydKDl++IH4yVjeqAkoGwbgm3Ho1QUrB?=
 =?us-ascii?Q?L4sHY9x9AkOfx988T1Pt+OBeeMwN30r/PNl4NtI3+Ce103NkWt6yr3mmMIl2?=
 =?us-ascii?Q?aywdw3JPK4xyQJfKBGExEDstLAtfrDHguqv1XLZS3vQjXcklRmXai307Xga6?=
 =?us-ascii?Q?rgo9UbQCOsHRVTp3YrjLmavZVkvVt1kyjYRGSD+78nNbxIEi4QakEXGh1Zei?=
 =?us-ascii?Q?jexsfHjHOOUSm+SdzyVSnZE6vweBYLwWRZ3gLOTrYe5SZuOQjQS81yjzzsuT?=
 =?us-ascii?Q?5PjC20DUAQlcNwLCzxfqFC/EpIguqwtKcmQe+ReCN8hop/yKJsql/2ZQIQuz?=
 =?us-ascii?Q?UxHQEdUrSkBmIZOD1vdP8Vxnms4OIFjUoZCcxjXF2Kj+yIWK4Dikzghceuiy?=
 =?us-ascii?Q?EGKmX7EoHSFfALG1hX/imgCWV6vNy9OxM2qnCMJA6QRkqI/qsejINZ8ZEBao?=
 =?us-ascii?Q?W7hYhuQK2WhVIY6lNdfGYelKyI/qTeEQsY2n9eETKDJLTyOaGX9D7RJrkJj0?=
 =?us-ascii?Q?Fc0B7NIKL8i8L0hjRR9UbeJgAGH4jMKLcfKNlAeabmrVQqPByx7y+UUwpvp7?=
 =?us-ascii?Q?977X+eGyOnekMx2DDRDotqC3xsxK9c8g7YAtQ8OdwwzIsQTSFwkX3JppNg9H?=
 =?us-ascii?Q?ALRvupnB1QHLR34qyD3hiLk0BQSfPs65xu3zIGAjklGkv3DF5Krq+LCgSVsB?=
 =?us-ascii?Q?ufuAFn7LeVVbwNjlpLa4X0WrEj0X13dEzKFXhMf4XMtJL75/TIY6VfCLFmQ/?=
 =?us-ascii?Q?zfmjCamM4IpiSMWdNgzk2JsKBg48sVJ1XKiMfKUMqNnhTBrlnAu6UT8zt/x+?=
 =?us-ascii?Q?mf9AWsrdTDesQzRImVWD/Y2FcZLqsPvlZeEVf1M7z/CxHdXwnXmzL4ork7ka?=
 =?us-ascii?Q?35sK9QL08c95Vacl7Qh8R+y7rpZnwSKo2FPvnliZSV4r6Q5qzKcbB39lCDe7?=
 =?us-ascii?Q?xbUXrergnL/+cgF/gmIJCM4t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8ac997-6c2a-4bd8-37eb-08d8eed5f442
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:03:16.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XnuZxjQFkHw+yV/i5ThfjR9oKndGzjPSYAdc0eU48aBSzGbbfR39O1CgoIbMSlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 07:57:57AM -0700, Dave Jiang wrote:
> 
> On 3/24/2021 6:56 AM, Jason Gunthorpe wrote:
> > On Tue, Mar 23, 2021 at 08:44:29AM -0700, Dave Jiang wrote:
> > 
> > > 1. Introduce UACCE framework support for idxd and have a wq driver resides
> > > under drivers/misc/uacce/idxd to support the char device operations and
> > > deprecate the current custom char dev in idxd. This should remove the burden
> > > on you to deal with the char device.
> > Gah, I feel I already complained at Intel for cramming their own
> > private char devices into subsystems! *subsystems* define the user
> > API, not random drivers in them.
> > 
> > uacce is a reasonable place to put something like this if there isn't
> > a multi-driver standard
> > 
> > If this is the plan we should block of the char dev under
> > CONFIG_EXPERIMENTAL or something to discourage people using the uAPI
> > we are planning to delete
> The whole reason to move to UACCE is to relieve Vinod the burden of having
> to review that code under dmaengine. It was unfortunate that UACCE showed up
> a kernel version later after the idxd driver was accepted. Do you have a
> better suggestion?

No, I said it is a reasonable thing to do

Jason

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407D134538F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 01:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCWADd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Mar 2021 20:03:33 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:36541
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhCWADB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Mar 2021 20:03:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caCcU1zkmTbVSmyJ66RSDvCeeNQyCT48KRVvzuxoT1E4J2vxNCgDp6Bj40/KhoJIqid1xo6Lzf7V5im5p6YANSEK7vlUttjWBDqbhoaT9kB8M+tDmMlstRfSrIjsF5hA40reoG144OfJzNCiVz7JFX+UC2RW06XyOL3GWDw1vxfFZdbUgMxfqE1/8+CvafzBO2LVJ4EoKO5vrsEAsf7V2TZiETrypYw0DbMz2VUy/dza/taCBW2HbG5Ue6cZhZcsWhsO/8VuVccimkru3EDjeX/ks4h5xsCeuMd/+ld005PaGBAx8oRg/RMGeQW0B7rp/rxHTSOs8o+MEJkMrxpxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guq7X1Rh9m7WhjHfvgMlfourr3iDWxWVlJNQGx8gH6I=;
 b=AEhFNpjmGdprPLW7xDn5J98T1ubs/7CN+Q0C4gt/CkU2M6O97tWFAZFLNgLWzITWZ7VgS5UsFqy9vGeEusR29gGlzSaJoGjVSHIlIsbs8HnR5hq+syR8YZ5y7vZh4Ar3k5NE6HQSY75RqQAoKR0gJCZc/CkH/fNb3AZx8Bs1i0WLjdFMSFkiJN98IZd9VEfrW7YFqm/kdjxcba0T1XI3Rit3bUMARIk5Ktiz9f7aUuBL8dQUyQnnMzTXtC4oeyinGgHz2Ir9VQqJDtspkz1xjxuoTDO4/d706ioVitQLff509fzsqO12+s7qt14YQ9ladKtOuqOcBZTGxhABagUWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guq7X1Rh9m7WhjHfvgMlfourr3iDWxWVlJNQGx8gH6I=;
 b=AwDdZxmWcaI2HIfkRNTOmG10c2LF08si7gFS4pEVcVpZkRMExUpDoJyck+ahZBqzE2JDt9NkBDqVWcQnwiuJ3B0Mwk5q4WMsyklrJFpCHgB734+01iJBGi0+OSrJ27JV6zUnqyjdl+ekasBU1EW3Nj0OQXtdinxdGIUPPH8edgJ4043nXxCGM3khU972072/INr0lpDShQ0IK+/RWcQCVlcs2Bq9JKg8LzJBKShEi9qUNTu+sQ1GgD8Rgq0WrYTP4OBU4qOUVt9WhaXrV1cHUk65VoDhtjAgQK1+YLn1W/HQ9TTzOi46F/wSCsgWnbnvaoEmdNHKMar8BcvUZYo90Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13)
 by CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:02:59 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::d960:79e6:8d2c:8ca8]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::d960:79e6:8d2c:8ca8%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 00:02:59 +0000
Date:   Mon, 22 Mar 2021 21:02:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 8/8] dmaengine: idxd: fix cdev setup and free device
 lifetime issues
Message-ID: <20210323000257.GY2356281@nvidia.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <161645592123.2002542.5490784749723732920.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4j8h3Ec-NX+tfaK+evzG8NQq-meVX8VwELQpDyTsTgZHg@mail.gmail.com>
 <60f12cfc-6f5a-7f0f-e88a-ab0e15b6d759@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f12cfc-6f5a-7f0f-e88a-ab0e15b6d759@intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To CH2PR12MB3831.namprd12.prod.outlook.com
 (2603:10b6:610:29::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 00:02:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOUVd-001GgN-Nq; Mon, 22 Mar 2021 21:02:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a079f8fa-3ef4-48d5-d2c9-08d8ed8f0506
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3750DA580868B01D8BB6E60BC2649@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XGPe4ccj7DX6aa6x0zuU5E3AIVNrwcrUIeNfqjL7imYWc6opdCFwSqvPvni0uF4oqFnpKXpqGnIqGAN34IGwi67DV7qnOliySmiTq2cft2EFGudEDchHSkfJ8CPURY7snU7Yjn5f84KpATaKtCiYgA7PfJaqtlEJeJ62XxhBex2klZqqSbEmGG50B8VX2fJmUj/15tSaOulh9V4UVTWAyvCfhMVOLIxGP9hxxT66O+mO2FUs63HLoV3mCoQ+kRxpETiDlMaqYtjg4WQM7ZaUCpwrp5nj+6YohdX5y+KGG9D90tJ6QAYk2G3/Cb//2gaB8oFJ8nW8kafUewnxvi6G5Ri8FlNGZME+JRy+OZOUTZ1CYmvjPX8CdJFkbQwIHxGLgEuNpFmCrCneokHzGbdpl3Jpfn3PD8Ur4HVFqGSu2JJZ95r9QrGPVBLgdyBXrVpQX8BqCYYz6UzJYAI8AjuTHKTt3huTrD7wREdpFarGvWQ/tMi5ZJ8JiVapGbn3EbUfJ8wX2iqwLxYkvT96C/wdAz9AevC9RM6MhcMRJtA2nkCVKiokw4OQjZc+Gvf1EFYMTEJWen72nz2VPBGjLambM9prwhKMn7r8UnIKKklg2yHiG0laKuMB5lz6B8QHmTKsvMj3+9ceh6zUwBZmH6Mvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3831.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(4326008)(53546011)(8676002)(33656002)(186003)(36756003)(26005)(8936002)(426003)(66946007)(6916009)(66476007)(86362001)(38100700001)(2616005)(2906002)(66556008)(54906003)(1076003)(83380400001)(478600001)(5660300002)(9746002)(9786002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f7yxo16yoMaxB8OnvWFZmhpkofEgPRU/st4+NFPAsSQRIa6Jd21gkPF2M5NA?=
 =?us-ascii?Q?ggbR0/tpMFoF3isR8KZ6zYu8424F/o0qH2SkQ+jQg0+8xlyDJy+79mKR6bTe?=
 =?us-ascii?Q?T/JXoQwJOqNZGLAg697TGjqooZgh1JK+aojxKZkScM9wQRu1Y1Fc71NMsVN6?=
 =?us-ascii?Q?G4VnRAyaulNvi8gg8+WfOABc978WE1yT1CUTy+oMMExzLeAISt9Jr8WmcAk+?=
 =?us-ascii?Q?BhIv3p3300+8f4sYuISFKmKHLl6ToJHfFjYs8hTeVPAu1yKR0T6EY3UnkjKY?=
 =?us-ascii?Q?+Qicoz7QtvDbOvSCnG/QaEQ5ty05zDZLGXn/6Dm5T+225dGJxVwnUOP4zh+Z?=
 =?us-ascii?Q?D3e1xg+70l1lpounR8B3K1Gzt8w/3TyO8a5fFkcyqw9LlMtLTzIuIRFWtUE2?=
 =?us-ascii?Q?juB2mR8dGTT4lk9KiTwsgrFnDBzxmxoFWSU3qicR8ReIB7r5oHvpB0/sjZ5F?=
 =?us-ascii?Q?IuxXsG1+mMUztlYExOW/fvPMO1bcpchrdgeLWgqf0UBFgS4/H2c4l51WQN/B?=
 =?us-ascii?Q?gMbHCFc+r95qYqujny2yg61o9mmNG4b4h1VszhlOXOXmQtJQtYOzJkXobK1Y?=
 =?us-ascii?Q?7QeKm4fywNhqiLFPcdxDViJTEL4392qkq6NA/+xcidmoRY+b3O4jeADXTD3H?=
 =?us-ascii?Q?O1+UzG8mxt1ehZA9/fy/yJfb+I9pQtTP8F4naWElDPGIJzYPGD7q0U90+YZC?=
 =?us-ascii?Q?dcmgYhUsa43samyqNevaKj4eu+lLsTfYtzD20bVDBg/d2c5uQHtyXc246zFy?=
 =?us-ascii?Q?9r6/qAUdJKf8GYMm85pjNxtyd/0Esab7yT7JKsN/NNRd9qpsYboPwOY1FBsQ?=
 =?us-ascii?Q?rLjakc9mmr6A6zVSl0u6sLkVjiQDj36Ew11RNQuobbtVAt9eAirK1II63H7I?=
 =?us-ascii?Q?L2zD8SsqfTlLPKaEC15mrp3b0/e5Sso1Du+5YlBv9RhOn9g1pFln4n8NSckr?=
 =?us-ascii?Q?oKHONa1anzd2pB1WTjY9RRCMwR5yHHibG6SPsS2CyPWlRTg+0b0D5uSY1vN8?=
 =?us-ascii?Q?Edg4RqeYOIWtlYF3HJ+JFAqpRX0LxJmLFfFzNDZG/Hi5D+WT7GFN3YxPo3L6?=
 =?us-ascii?Q?tnuaF3Xlwwdeof0oRmWnzt9cs3Wa7aKV/rnX7TW48aBpduzpaD6RI6LiwcdH?=
 =?us-ascii?Q?SWlsulJJCRG5G7mDi1RF342vcvXNL7AnWaNlQW9o0KarysASu/S5bPe2KOLd?=
 =?us-ascii?Q?TpaTv/ntD8yMxQNpM3lT4WTkhGdzH6IVYYXjmbQ4enMZ8rGXIS7LwGDqv40b?=
 =?us-ascii?Q?XWx0iywNK2xh/xqEwevLgkZqfk7vvKA2t6TnMZPk5jXf0jdH+Upk5NqB+FBx?=
 =?us-ascii?Q?e1BzYURU50QqYWqaBlG4zDdW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a079f8fa-3ef4-48d5-d2c9-08d8ed8f0506
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:02:59.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFIOuIv+Jh3EuvasEgnzr8wNemj8hFcHAxcFh7Uclibzw0C1nwPR5gVo5MuYnGx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 22, 2021 at 04:44:24PM -0700, Dave Jiang wrote:
> 
> On 3/22/2021 4:38 PM, Dan Williams wrote:
> > On Mon, Mar 22, 2021 at 4:32 PM Dave Jiang <dave.jiang@intel.com> wrote:
> > > The char device setup and cleanup has device lifetime issues regarding when
> > > parts are initialized and cleaned up. The initialization of struct device is
> > > done incorrectly. device_initialize() needs to be called on the 'struct
> > > device' and then additional changes can be added. The ->release() function
> > > needs to be setup via device_type before dev_set_name() to allow proper
> > > cleanup. The change re-parents the cdev under the wq->conf_dev to get
> > > natural reference inheritance. No known dependency on the old device path exists.
> > > 
> > > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > [..]
> > > diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> > > index 03079ff54889..8a08988ea9d1 100644
> > > +++ b/drivers/dma/idxd/sysfs.c
> > > @@ -1174,8 +1174,14 @@ static ssize_t wq_cdev_minor_show(struct device *dev,
> > >                                    struct device_attribute *attr, char *buf)
> > >   {
> > >          struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
> > > +       int minor = -1;
> > > 
> > > -       return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
> > > +       mutex_lock(&wq->wq_lock);
> > > +       if (wq->idxd_cdev)
> > > +               minor = wq->idxd_cdev->minor;
> > > +       mutex_unlock(&wq->wq_lock);
> > > +
> > > +       return sprintf(buf, "%d\n", minor);
> > As I mentioned, let's not emit a negative value here. ...not that
> > userspace should be using this awkward recreation of the existing core
> > 'dev' attribute anyway.
> > 
> > if (minor == -1)
> >      return -ENXIO;
> > return sprintf(buf, "%d\n", minor);
> Ok I'll update. This will go away when we convert to UACCE based driver.

Also ensure all new syfs callbacks are using sysfs_emit()

Jason

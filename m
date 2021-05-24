Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8086D38DE54
	for <lists+dmaengine@lfdr.de>; Mon, 24 May 2021 02:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhEXAH2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 May 2021 20:07:28 -0400
Received: from mail-mw2nam08on2061.outbound.protection.outlook.com ([40.107.101.61]:23424
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhEXAH1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 23 May 2021 20:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBZab9lC73y2GF4kYs8PNkX1Wi5WTsHg1pcJ6y8wRz7dq5Yawe8sH/8DM8drldf94+TQzR2j8r8NzqmeuklcDMZF/LrMrDA155iD+3UgNzGQEBRDJU9GtiTvIECx9DSYmGiTDoMFLaez/C47DgaEhGlnHeWlGLqnRwPzQt9+zMZ9eKaxQ8jJ6dW3geQg9dA9TudMCBo9Ypc0unFib8DZ4xO0KDmpCHAEOMI1cUOMZqP5Z7ep7AxCMV/sDFiFbwmYQqNYxeaEQthUcqF76wilJUv2XO8ginyOmymxNm73klw++qhNAy5/ZiptDgEXgLNBrJ8WIh1d4IYPAUglo9j4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1wGaeTEs+auh6J73VmltPlDDTB0Mu1IH/jhhWdekwI=;
 b=oRSVSE/4LrKlxdwCCIhI9vY4afTLUrYOLZg4yjjqlkijh0PIUJ8QxjOEXWgAzcYr0aO4RyuI8qvmDe4qjM4Wi8rxfC8woo/Kia8gK4Qln1QXzI65HdBFfS2T3s9ORDEf96DEkE8qMYRQTrPs93aVrSpol3jQYHnLR3Vc0DeJE9kV+OAnwV9l/n+s1F6nw3Ej1BGN+zMt5PERFi2WMhsU11uTIXAHvwL5fMMk9O60RPp0ivmE2R1nbV4JiMJPeRoY6LkM9g3qdCR8vJY1msiFKh0fPJtVZml9nJOLw94/if6r8lFAXyHIycYfqPhQt5Guknf1c50SE8UlGA4eKjXh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1wGaeTEs+auh6J73VmltPlDDTB0Mu1IH/jhhWdekwI=;
 b=U1u2XOJ0F8VCbcBR9BJn4Zma5X7lPdSOKfjhyqSQIIlf0zlimS4iMJKmxYuAeMbZ+Uh5q7Xkp9UXxgQToC7jzXjJuXb6KP0llGNU/zKZOZnXIla9h/jG8GELzh0bU4lvc4Tpql8cUAPahoK0JqaobwvzDZ6SYJ0w9lTCSa/loPayR6WUFbb4gK82oz1+OqaLf24hdKgDiEk86+vo8fehJH668W8ZItKPgGd98dYbfyPy7PyxwcP5NmTapc2cFgVtWGPF5WWyXTvFc4NiJP/Ekng7AqD2YXI+32+gFg8PRAukQGentPF46URGfhPSHfV1y3fBXpD+fEUjLHzlb4kU/Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 00:05:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 00:05:59 +0000
Date:   Sun, 23 May 2021 21:05:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, ramesh.thomas@intel.com
Subject: Re: [PATCH 02/18] dmaengine: idxd: add driver name
Message-ID: <20210524000556.GO1002214@nvidia.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
 <162163569407.260470.8069733178174299145.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162163569407.260470.8069733178174299145.stgit@djiang5-desk3.ch.intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 00:05:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lky6W-00DVGU-8W; Sun, 23 May 2021 21:05:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d5c4a6-cecf-48de-8320-08d91e47b5bf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192F6966AB71CCA2AD4F0B9C2269@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5zX8UkvCsMa7l0JA2qhAKbOOitPskmJEFgqTY/wPKMN3l4rXgnbFBIeIIUstEPA+7a4EOXoe4M4bqIBHr1zBMCcmvZYTMMxoZGR+aaeLnOR5cTXCwUS1VUyhUTmPuh1Ei1mjgChekaCEbhbUxLxVPwpthxrdT9jkG3xgVMNOXJx/mj2waGvY0ASDunmhl13ky7AQCeJeUf/WfxpevcPGTedg9icNfFQEyNOkRvlkFO2KlLDVmNXxjpRecndHvKzU+hSlVF5FpfuVG3KAhz472WpUYXVmoUw+FWWC+BA2C5JrxalLFFy2bZM1Y526A4B9qKUj7dreqAsi0gOUMVkOCnTjCgAW79erKWwe+a597/WXrCZAzbQtW77eKMMqhlIa9tAN7jeycKTMGUIdEGXGicpJF67cD2chIGffxq7NOCgPrxahT0MPEIicxJDLo0eThDI+T/rWoP4T8xBqKSanycAEg11+GSQBaigToa2+Ub6QJ+sY7LxC/xh8+YJY/nyLDsTxw8X4ds45Lo5sbhpGRm3pmXtP0CT+08qUTQSS00sXxodYL2xWYGSOqIuyzE8t8z4nPKa8ADJMA33DfQLxWQscWLh+92vYPfYPOPvLic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(9746002)(66556008)(33656002)(26005)(9786002)(38100700002)(66946007)(316002)(66476007)(2906002)(6916009)(2616005)(4744005)(478600001)(86362001)(426003)(186003)(8936002)(4326008)(36756003)(8676002)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5t88FgAHDdDAsiG/kVRmYzg4zR7yPdpNpbhIRcBQqE1PXgOekRrn5qXv1HeU?=
 =?us-ascii?Q?U6n9wvdzUhtSVYb1yHfPL9Zz+H4XwRMgO0YheLJEvEemRrS9doAo7jNzXImC?=
 =?us-ascii?Q?O8J/PwrD6euKc7bhoAthrMurpykmfrfqZu4TnlP5sQZd0izmEmbg9AMQbf7a?=
 =?us-ascii?Q?QsjXv8FYHS/CB0HLOMJ1JmXHmsDmDgJUNZM8eXictX041iVmyyEIL/7OY7Rq?=
 =?us-ascii?Q?zYN5rs7E8zpvPwOFzQAvrK5/JO8xSjlpd6kUU1kHYyrZEdA5s5S2DAH9p1Rm?=
 =?us-ascii?Q?BosvVppW99ThS61By4jCz8EmJhi5BHD4LtHH6OLM5PAoEewMs0MedrIPx+dT?=
 =?us-ascii?Q?VUUZQXTEq15GG5qH1IdQ+LcZ+Slp98Hg6/QrAikc5CECBki6I3V3a5xiHrwH?=
 =?us-ascii?Q?UBxbMzSfRI3rh4rCdujGAE5nCegHwK1dff7i7vhMXnsgpAXlogsPYTjkrE50?=
 =?us-ascii?Q?7G07zZVlI6rFOPz+FLhMuGm1ihXVsoPfTm5TIvXhuZfzzZDmswoCIBa1gDpV?=
 =?us-ascii?Q?VHGrSXDBvBgQ5ASWFoqfgkXP9Hl8OU0iAIq7sLIVl+AP3MIn4zHzdAYx9s1k?=
 =?us-ascii?Q?EQoWn2sxuTu8tPi5/Fpzd318WbJCUiignI1HOp65v0tV/LIhgeUKQdGMA4Ls?=
 =?us-ascii?Q?G5Hu3PWGGU2s1fIQje+yL4svNdZR9jDCCEr1/5+gZIURHVP6s5uBFpSgTkVr?=
 =?us-ascii?Q?yd13n04CRq1XobOXQAJ3H9Xa7eHl/hhvJLtnFIUHbFJCNqwYYEblM+DL2rLG?=
 =?us-ascii?Q?6hJkIVerngajmMuUtMyxcV49tM0xl2vbcU/EL8QgEe1pR2SbVteSO4IAF1qc?=
 =?us-ascii?Q?VPPdqcboefu6AYZny+cRmjX8aRGkY2wm9DZN/l2r7NSg85uPF1vwWezJd09i?=
 =?us-ascii?Q?QouOV21BH1KUYKNiY25M/sfpHCRnOsladXA3qdbpxiYGCZOfZDNoyd/RDqSY?=
 =?us-ascii?Q?9Mc66jG0x9fx6kNgvB5pnWTZSa8f/jgAGfi0OnZR5WZOKomytXhHeQ9cyhT5?=
 =?us-ascii?Q?MN5b431XjY4q/qY4qeNfHNNeacJmQcFtC252PVqdJaZeve77izj346rdDdmQ?=
 =?us-ascii?Q?+VFAH6anK3HX7gQLZtHglhKNVkg+IQv2Vm4IKZ/oE4cnwlLgFGEMk5MSkCLU?=
 =?us-ascii?Q?/BIBZf7qHAYORguvgFNeIB4IkY0eNy/TKS7bD0mzyUkNKlUigU4wEw7XhQd+?=
 =?us-ascii?Q?MI00wW4Vp8jS6AjCwWH1tI2uiaLLWDyUtLVVtQMM26Ma6CFyBKLTdSsvd/Q1?=
 =?us-ascii?Q?xPUdesShjlG4uTWDYc3zcg/zHaX+iUt9zVZK2ehn1+UQ8+zX/5eojCgTfqaA?=
 =?us-ascii?Q?DXT2u+SV8ciYSEEs10yZdXO1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d5c4a6-cecf-48de-8320-08d91e47b5bf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 00:05:59.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTv5gMc/iuIXEipbd3WtUYUovnr3c+RDARYopqCaTP5DoXftt+57t/nHWUZUljNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 21, 2021 at 03:21:34PM -0700, Dave Jiang wrote:
> Add name field in idxd_device_driver so we don't have to touch the
> 'struct device_driver' during declaration.

I'm not actually sure these two patches are an improvement. I view
this idiom as being valuable if there is a huge number of kernel users
as it does simplify them, but for something small like this I'd keep
rather it clear and explicitly set the .drv instead of burning CPU
code to do it.

But it isn't a big deal either way

Jason

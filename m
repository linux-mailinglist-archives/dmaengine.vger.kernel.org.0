Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895B2AB014
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgKIDqo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Nov 2020 22:46:44 -0500
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:10560
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729192AbgKIDqo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 8 Nov 2020 22:46:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXMLIH1FzvCuunGyZA0sdTb4lVXvtMjjfu1WCC+BId6jFJM+RBIkBvVSsMQDFI0DkR4CXeFI332vJ2wtcfTPhiZJa5LK8uKVk18yh3JcGPtxV8HVw9R7e42vFpF39grF3y/gHhX9wGvIcHcp9dpUdHra+WlV3Vf/148JQsXee2cHsLPXEh99A3dC13PqotOwP6/evayrdhIdGuiQTVjhZRVGyugOI+Rw+2NdxIhCiWlcDzVNvX/4wPrRoCBSAGZuiP9r15KAALHvxqh1Ij3a3hSav7oUFjUOwqZdvqUbln6+F9C1j8LmeS15Cjv78GQnQPI+UV2WM/M7InM/z6JZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL3qepJ8gppVuekPWT2bjMBJ1RQpcLsztHb29RkbALI=;
 b=MJLv+AeVPgXLpm0QXq9uCOVVazr/oxdwJqCTLRzeua8aSH7tfU9TEbqBqCmvdC610GNFwy7Q9HM3PbB61ZtvUoliqgMr98Mt/fIJmgjJL401bcEyqJIFRIutEuuHuDnIkaR3uf2K+bgCXWGrfOVQ5pAu6mgjH0BbrZF/toyuWBQCX6gPQMClM5FZo+oSgTTPOFWse6RBe4viDUs634jfZEQmojzbSnob3XUAAL4WbN+ROm9qdGd/PI7v0v0pKYN6huJB+oOhvemsfbT3O7KCk0hmYtqS1R6jBTWzck8AYJJgm2xMDsTxPvwRIUuV8zA3N5HKLmWcQZ+fj3WrFDe/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL3qepJ8gppVuekPWT2bjMBJ1RQpcLsztHb29RkbALI=;
 b=jTntU+PfACA5IBaS4QNZ+Ct8G3tpu7MY+jhcOOE5dX3/UB1J+5hBNENLOqMzFHt5YP5s7gkWY2enl92SYmeEWuXvNDlGHedy4BWTnyjP10GtexBuX2W6Gg0uphmZsfG5MpNScUC7PcsqRpQJnDOb6RAWNtX1E9RG5RbKFG95b08=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 by BYAPR12MB2757.namprd12.prod.outlook.com (2603:10b6:a03:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 9 Nov
 2020 03:46:39 +0000
Received: from BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31]) by BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31%5]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 03:46:39 +0000
Subject: Re: [PATCH v7 0/3] Add support for AMD PTDMA controller driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <7fd6eecd-1881-8578-4b4a-738de926321d@amd.com>
Date:   Mon, 9 Nov 2020 09:16:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To BY5PR12MB3956.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BMXPR01CA0064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 03:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 324151f0-e486-4714-62c2-08d884621072
X-MS-TrafficTypeDiagnostic: BYAPR12MB2757:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2757C9050EC8144988B49274E5EA0@BYAPR12MB2757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeWQKbadXWyIbohdgQiznFigAcg6wHR6BqZuuDIyFKldvv0wFQfP4Qb5Lg/w38p72Wh+0aBAqvcUQlwzK98oIi5htrRR1UsK2S5SSDkVVD0qsXC4sHYJ+jkGQaRiI3nmyX4HMbRLNlsyLfEvtnf4Y4zojOdzNCy73RVRTDQudnrglcRgQgQtvWclQt/EwbV2zYWbg00y9PTIe1hu8ETH0u2DLP9ZGFgbckzuSMEGnCxMVcncMqkh+Z1DddlP4bk6bHThOZ561FFNoMvVlku1yFfPnVm7Lw2EXvLAFE1n1AsQQn4tVfvL5C+2v7KqmrA3EgoSBKZZOPEYCSin0kxrOiXfThJfZRMFPqxHq2JXw4GyZrCknJq+IBjmDeS+hPYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(8936002)(16526019)(6666004)(31686004)(186003)(8676002)(36756003)(26005)(52116002)(2906002)(6486002)(5660300002)(478600001)(4326008)(66556008)(66476007)(956004)(16576012)(66946007)(316002)(2616005)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: E0rHxhsd6fpGr6RMGtcRGqu48aFsf9n5EpZbA7JrPh/ax9JfuxcFYmwQg+frNQ84274V4Pg5y9HpeckbToc61XQYUZZ9pmBw8UV5ne22Ypqa5NktdWykucdnLp06ICIADxtcGHZ3w6YNpi5YAxAeHj/7CcWmprCpOx/dyaRPO37i1PL6iYxaK6co8Qyg0QOuVd/zIB81wkxYZW72lYTi4YZ9uJ5d6CKwScZnY4bkMabCJCeZVVBaB5fvQ6v7erSEBe+9dufqJYqaauuhQ7HhftrNOoKI6B1FJLnrwtTE68e5hwaZmTF+NToU/ZFhrErzn0K6Eaeg7PXWaD5zDp4AljLb6g7Zj8gvr8kAHIrCbJ0oBo2oTMXhUsl8arSlv+sZhnXgXg3cAN41wKVnlO7mYetlWsotADXzlHFFmg+vwj6w1imU/mov4CSVQdhOxRgi8UBhOd8J6kDjBolVZkMvZxI/hl8fJpTglZegoRKD8euIezDqxBaJKlALarDP+lVhk+5cJR8VSzFloUsjiEsURr+3e55E5Slm+tFpm/vrRqoOX7gesACLdoWBTQNDNthKYeIj1TfEjQY4BCVvb7vrF4U+3c7sc2up5DqTUNiTzjM17lD/FIsBTd9Ii2BCwITbMKfz2DOcQZR4kDTv0xX/qOPDnZL+PfxuDbPpDpn3jUw4uGm8K2QjiaVabaTuojufhSGxii3++6Dvggdkb8IYxRse+aVsD1bNF96EA2lH3yqPC0gUq6qFAiFonGm9gm/DA4ZhEbj3tmxldWSjPi+2kR6FxeNNHTF9tB4sm0BGpybuWgGJEzUZdmdlaA3ibY8j56VmdxOn1VY7KwxgGHY8Dzw/7IosmlUt4ola4UrF/5IyPVIuuBkHQrZeA0smolmbGr7GEf+1hYUXfBBbk0ZgXQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324151f0-e486-4714-62c2-08d884621072
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 03:46:39.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUoB2uBB6Jr3H2EXhixG5ngMeaDNQU+q3xfIf6UyWCGOvIO0nU0bX4I4muF9lgsdL+GgnSVyGSX3uZbTuxUYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2757
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> Sanjay R Mehta (3):
>   dmaengine: ptdma: Initial driver for the AMD PTDMA
>   dmaengine: ptdma: register PTDMA controller as a DMA resource
>   dmaengine: ptdma: Add debugfs entries for PTDMA information
> 
>  MAINTAINERS                         |   6 +
>  drivers/dma/Kconfig                 |   2 +
>  drivers/dma/Makefile                |   1 +
>  drivers/dma/ptdma/Kconfig           |  13 +
>  drivers/dma/ptdma/Makefile          |  10 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 115 ++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 333 ++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 554 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 252 ++++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 352 +++++++++++++++++++++++
>  10 files changed, 1638 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
Hi Vinod,

Have incorporated all the changes suggested by you in this patch series.
Any further comments?

Thanks,
Sanjay
> 

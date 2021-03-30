Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A034EFDF
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhC3Rgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:36:48 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:4416
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232661AbhC3Rg3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Mar 2021 13:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0gM94iQv5rl/Jgxe9QvQ/CoowXUhZgC7R9IRTNd8WT2aUWOIz6oZ/LgUPGAYg5vkPfOL0KcaM/xEAnLLaTx+zBcvDxwYl8B7nfhKXf6641SOvRfddirOEe6I7+pmwwFaus3vnwiee7CvCw+PbP8tK0SPbMIsOIA7T2xIVtlEd1z/5y4UGbe1VgcBmsIyDsUUy1Vu2SdwrvE+vO7anS8rgjJuWt/KdKSg+crEbOGiOmST7dml82LL8MP1fK6PXa63AIjpBBVzoiq0hJ0ls+CQsoJc7cV+VbpgltwBOFv8r0+kehS0/4M1bcGofw/eHjdDWtD1jGFXyRTO8+mA1QsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsQMQ8GXPr3QbaZ8RWG6+IRg605oDjH7jj/hviTChHE=;
 b=OXNP10ypwkqAOBWSED2s4TeZQbAzE6sqGYLW69jyf1lCreO9iNiAjTTJY7G0GvOxTAQXBIq0j9YIDr8nCjhMyqpalcuSwB1AwWheFok7LO4uMG3eNa/opN5Rcyg4e+l3xUDP0nLcAHFQYDDusgba41Ah6fom/9rdAQjDCmA0lyEd6LlV6nE8lmMkRF5LkNnQVCWT15ZNGMty4hdJSyejj7bXa9vCA+HtSHFNSEt5kWmrckL3Y5u3VJIZ8Y9f4XPzSOyrJJAjjU2557Aovt/jyYgPT/JDsFo7SV/vhF400G0P06PRhlF3VhbLRHKDkDGx9WYCeG1dZTPb0UQ7PdWCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsQMQ8GXPr3QbaZ8RWG6+IRg605oDjH7jj/hviTChHE=;
 b=H3qFK3tBhv/3sEtYJa4rsyAO+JzuiQg5zzLEA3Ema3yspRmhlbXWRyPmpF+09ykD5MZ2b2JH6vEnVgtWuEfD0+k3ih5Q01kJm1o8CX7tYW2VopPKkK9n+PTBrGNPcbkZUkA68AjlhBIyhtQhxaJtfUSyITroFpvmBC4rTPwQ99zLLcVBB7ginTJPCir+xGwySi8naJNwQOdCu4Ox/uQgV5aCpNu0c7ch68przPBs1lO1r8hP+vn31WPTmO8Iv8hG19rnSBfFbQpiTFCo+CHkjtpdOCHYjdLVNdzNBvtncHhTvqZA31olbQzjhgdleqYjYJ2S2pbhscTxhz8xVq1vRw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 17:36:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:36:27 +0000
Date:   Tue, 30 Mar 2021 14:36:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH v8 5/8] dmaengine: idxd: fix wq conf_dev 'struct device'
 lifetime
Message-ID: <20210330173625.GV2356281@nvidia.com>
References: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
 <161668770006.2670112.1315353645420208591.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161668770006.2670112.1315353645420208591.stgit@djiang5-desk3.ch.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 17:36:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRIHx-005y9O-9s; Tue, 30 Mar 2021 14:36:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8986d29-eadc-4a6c-6a1c-08d8f3a2589b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311595D0EF979E92C5B0F7EDC27D9@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iP8Ij0kOPm+v8NqyKDbAQZf/rM3zwBj6UUibEsUgXzc9bCoofGyp1/A/0cnY/64A/5+TqH3RGDXWLSKiRNtxIrTvADs+6DwjHDWbal5XbT86oQK2t6k1G8DkuYh0hZYq+xCYJfJOWdN5ZfoSDPW/LE76JwuZYj+kCE39ZWFGZu6OxRZDmjvo+EzJPquV2aOt82NK/PvyX25foqawsbe3f4IFOcqtXBv3/Wx/H4zDrvbRKl6JjWOktfFQ7s+OiBKLC4fP+feRqCN0jCUOgoRN0Gk9X5082H0F5asIlC2Y71otcGdeSKdruSOoC0kczL8/P/s4+mybOUkbZ0KC1gUKgmJPggVZk1pTI6LgULC37e07NgwgmK2E7/+I32xBj6OKcpoAhlDQkfoRIrsCGcVA5VsfSlP9mp5S7QN3y3a+4FVjwscx2HfSu470uQKzmGD91MVImLPM9SZud6VIIZ4BXAn7QgZ+kSmVMmgxyJ2BoeeXTOre8NiaoC/EUBl1VBaqX/DxR87RxmvbNyiGEb2jLIEJTo+qh6oIwF6bk90pd1OecrcEi5Gb3k3KjkBHRsl2r4pE5cJIcApgKJO0e/DJ/xO1z/zvaCIMOyRRPNsGtC85huyzi4/6qNjyn35z436WaMIvuuwmSUBTVeOAwsrOy4e9oOtIv8qFyGsRnwq43ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(316002)(426003)(66556008)(2616005)(2906002)(4326008)(186003)(83380400001)(6916009)(4744005)(66476007)(1076003)(38100700001)(86362001)(8676002)(33656002)(478600001)(26005)(5660300002)(36756003)(9746002)(8936002)(66946007)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u67/16ulq5thr82rjTY++R80/H1pctTgMe2Lfu1YNDrahWUvTb7DsYnbrRB1?=
 =?us-ascii?Q?49hbZtNb9/7HNC84zLQe5NzDEE9f9tFw4QQUtIeNpiUbVv6ht9RwmYgSjakp?=
 =?us-ascii?Q?uw7ap2m+0q9zV3Oxt7oz0q0ppHXLgz+1errkbBVlxex1OzAVEK4crdXTTeVj?=
 =?us-ascii?Q?uulWeZp1c0qYDWR81htH25ROxNJ7Pi7q8W1NgciOnLK5dBe9OUzLBr43MXCx?=
 =?us-ascii?Q?5CcgWod0ysBTC+bb5kpoKGF8qCKN0YBI60RcUImuaILWn/d2LConPVboYh/N?=
 =?us-ascii?Q?oeeTvq1hI67Sw3Byy9FCqI5Cjcn8Xt8a85U/sSoKvUWMDHsmG1WZWZLccG/t?=
 =?us-ascii?Q?1kSyptxCnBocKd9lF7jPH0qT9jjNiV4+AwBdGac8TrXudE9a8HdLG7ZpPWk5?=
 =?us-ascii?Q?+bLJMoYUlcB3giWdzOla65zpoTZSCOqoG/N1Bs4K5MpmEaRqdt96v6OQxHM5?=
 =?us-ascii?Q?FUC40ubuVhdoURtBsOfg0XeKoNHGhbMPqtbmQpK7KXPMdnIanuKUe43I9IBZ?=
 =?us-ascii?Q?isDX/v6YlVFantJJEhnZ/lrhTy7pYH1GGhBJo2fVw8YqWsl30pV4LWPwmmM7?=
 =?us-ascii?Q?3jZN7jXpz0aNf6vgbK7j0uk6dkNfbnWGlP1IfeIuogtcvr+wYeFzN11pbG0y?=
 =?us-ascii?Q?09xjhqXEqUV551PAC4HG1coC4TWKNFXMENas1IEo4elEvnH6cOTQuicM16NK?=
 =?us-ascii?Q?EFQGgWRWvRIivBALDBS9EZ/ANsi6FPxlWLyhRWr6lnpvEJY1mmP48Fr11uq4?=
 =?us-ascii?Q?GZQdSvbwJj2qL+a1ahwKaIDSX/egKwPPRXOUl3QFMgetgLKFUN4PMsH9GdJ/?=
 =?us-ascii?Q?kGIJVtEwXsfdNtw2M8FUq/gwVf5Tag1lDJn7TFfzHvifVgWi8MzO1uluNtYV?=
 =?us-ascii?Q?4GpxS+6MjcqibdB3SrOcIuJS2Dk+h2h0TclsYXU9FZ2DKfcOTkjtt+NyXbNa?=
 =?us-ascii?Q?s6kuiPbjvm4/4m9mN2WtsNgCek1oY3lBIrokT/C4cGgz5+8uTqqsCdDKkEz2?=
 =?us-ascii?Q?EaHLSgvcECsrPsydG+8wRvVIrLf1NyiZhIZTrZPUYpYw8apQ+7dwwTXDVBO3?=
 =?us-ascii?Q?2pztYuWrzOIeCLd/VkFMotNwyK+9tczlRzFpoaVYRArxKeenonH/2P0+jP7I?=
 =?us-ascii?Q?ADsMOBRyAzz2AiwcscNqixqbZlQIrMQXdQZ0qcYsfLegyrp0exE3Q4YuwlAQ?=
 =?us-ascii?Q?tepVTau+FnP/96KPoSQGidgO4oyX02QPniO45Ud7DVHZilKIl5vpE9Y+kDjQ?=
 =?us-ascii?Q?QXh9BkgXUrP+VQAynRQyU1wEwkDZs9Y4IJorcVKnZKn6IKI1zEiDtO0Cq9PH?=
 =?us-ascii?Q?aaYZm6iCEKIrFccZO47/1vED0MoUTg2AeWzORmtxqd4pPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8986d29-eadc-4a6c-6a1c-08d8f3a2589b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 17:36:27.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SSGeMZItJCdXGaNGA3p4QU5j8OhIyTww8S+TFVWhgCqnAmKm0A14InH1PlbdLjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 25, 2021 at 08:55:00AM -0700, Dave Jiang wrote:
> The devm managed lifetime is incompatible with 'struct device' objects that
> resides in idxd context. This is one of the series that clean up the idxd
> driver 'struct device' lifetime.

don't repeat in every commit message. Each message should explain why
each patch exists.

>  
>  static inline bool is_dsa_dev(struct device *dev)
>  {
> @@ -273,6 +274,23 @@ static inline bool is_idxd_dev(struct device *dev)
>  	return is_dsa_dev(dev) || is_iax_dev(dev);
>  }
>  
> +static inline bool is_idxd_wq_dev(struct device *dev)
> +{
> +	        return dev->type == &idxd_wq_device_type;
> +}

Wrong indenting here

> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 158f9e0158a3..1890a1c15977 100644
> +++ b/drivers/dma/idxd/init.c
> @@ -136,7 +136,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>  	return 0;
>  
>   err_wq_irqs:
> -	while (--i) {
> +	while (--i >= 0) {

This looks like another patch ?

Jason

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAB12F997
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jan 2020 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgACPMY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jan 2020 10:12:24 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:43329
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgACPMX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jan 2020 10:12:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QATz2CdOoYHmRL3k/7HvtYzYgWmOwioVEzN/XkfdJaA5+KiA2S/et31HP/R/NOx9bTlOz57BBtP3AUX804Qgo2xod8Uc214KUPnnYbd3rGkNQBmA/O0vBY04BHFDHwhf1QVClcHTm4aZIYSb//6xkRu+2GYmVLbcbMwRE7T7BTVveSVxHlY7qm+isEih/6HMN0WRq3ZZo4BztEt7bY4kn4ArURc0rOsrwNVjpiUUABoFCUFeTsV34Lry7yk3uGOp0yHH5VUg7R5lvxwvXADs5FHEwEVcYYpRI+4Rugv2RvSQUJ4t1ssHa6ALpCIWjYjzBETdJfx0DtG+tJf49CERhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PfIP4//meg0o6OdFvbQGlEv29a++do92w0Zw2MtbQg=;
 b=Y1eXuzviorFItn1wHg02nt6pIcLklfin83S12JHW0SedtVQZn0e2+NjlFKw4CZ7O7gUpr9rvzfbHIUsGE5TZIrHSkQBWnl+sK0G8MtME7xdC12ykDagvc0c/8L80i4vUOWtqMiNmLazFyK2XkFuqrH8VJKVtVuDzTaQxKhfyOHB8W83zgYNLGXlFmJe7e1DxRYwTlaVIQWfn9evkLZw7idu8/yG+USPfsuxK8cQjRF8/lM22plWbRWPJNolrEY29Yyh+0tGJ9aMAj8b53YTr9Pj4iY7la3f/dPIl/DYEiboA28pauY8XgH8RwT6QxL1xdBSXklLdxZtcIVV8rCErfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PfIP4//meg0o6OdFvbQGlEv29a++do92w0Zw2MtbQg=;
 b=JeqC3hiIkbJ9kiQlyjBd0y1EgYXXUbFoGT2924wJF6zje1F//L6dsZwEIKTzwLGz34NhiyyJjgwllLzts3Lac+fGehkMPHnPVVzxJvFqgUh1hBter7uOHndLUb+WzJlcZvdAzJPM9EwS1Mrv84F7XsRyQn6DdSXc/H7IHesdc8c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from BN8PR12MB2916.namprd12.prod.outlook.com (20.179.66.155) by
 BN8PR12MB3266.namprd12.prod.outlook.com (20.179.67.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Fri, 3 Jan 2020 15:12:21 +0000
Received: from BN8PR12MB2916.namprd12.prod.outlook.com
 ([fe80::45d0:ec5c:7480:8029]) by BN8PR12MB2916.namprd12.prod.outlook.com
 ([fe80::45d0:ec5c:7480:8029%5]) with mapi id 15.20.2581.014; Fri, 3 Jan 2020
 15:12:21 +0000
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild test robot <lkp@intel.com>, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
 <201912280738.zotyIgEi%lkp@intel.com> <20200103062630.GD2818@vkoul-mobl>
From:   Gary R Hook <gary.hook@amd.com>
Message-ID: <de0bf6de-5c44-bb81-f3ac-2db1c1c4595d@amd.com>
Date:   Fri, 3 Jan 2020 09:12:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200103062630.GD2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0147.namprd05.prod.outlook.com
 (2603:10b6:803:2c::25) To BN8PR12MB2916.namprd12.prod.outlook.com
 (2603:10b6:408:6a::27)
MIME-Version: 1.0
Received: from [10.236.30.71] (165.204.77.1) by SN4PR0501CA0147.namprd05.prod.outlook.com (2603:10b6:803:2c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Fri, 3 Jan 2020 15:12:19 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c69273e5-3fe7-4234-d5bf-08d7905f5457
X-MS-TrafficTypeDiagnostic: BN8PR12MB3266:|BN8PR12MB3266:|BN8PR12MB3266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3266F96220E4160247933C40FD230@BN8PR12MB3266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(16576012)(110136005)(86362001)(36756003)(2616005)(66556008)(53546011)(31696002)(2906002)(26005)(66946007)(956004)(66476007)(478600001)(6636002)(5660300002)(316002)(6486002)(52116002)(186003)(16526019)(81156014)(31686004)(81166006)(4326008)(4744005)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR12MB3266;H:BN8PR12MB2916.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDnTSB7ybRQNHm4rQbFjEuZ9ELh6LWACJFU02YmE7nG7udXYPIgK829NxQ1DPedvkocgQGuN6zZqeNhrRuA+oNWyxnSXW9meSom/9dFkEiG0rd1wghmWbUIq8w6LXYzfGqc6lbWKy0NJry0iiKChsXLSFvNPw6KSImHy8etdgOUTpx8hDM17HUl9ehcjhLCwzzF6yQinHbmyx5emvc5tQHe/CmF3ZgnPMo2gIE5NjcRuZQucwRWlJpEpKequ1ZdQBAtWVya3rRsLyJ6lDX2krQofU9M47P4uZK4Ww7rrTTuWUnx6pfR35wGYFxMG8eRmTwaqKGcpunJ+Q/xzaxIF30HCct/2Y96Ab3J61pICv2RKqZ/87ajcg9QvZG2ficK3yXWYGbmAcy36Reb/Ih4HyNGXhmLqFBNuo+kYnWeUPwZB8qh4t732a4t0WhQpBQYa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69273e5-3fe7-4234-d5bf-08d7905f5457
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 15:12:21.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+69nq33nT2EHmlLVOWq844RH22kQJ9Q3nR6T11sdYqvvLIgKRrnboV4y6LwbN11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/3/20 12:26 AM, Vinod Koul wrote:
> On 28-12-19, 07:56, kbuild test robot wrote:
>> Hi Sanjay,
>>
>> I love your patch! Perhaps something to improve:
> 
> Please fix the issues reported and also make sure the patches sent are
> threaded, right now they are not and the series is all over my inbox :(
> 

What does this mean? The patches showed up in my inbox as a set of 3, 
properly indexed, just like they should when sent with "git send-email".

We've not had any reports from other lists/maintainers of similar 
problems. So you'll understand how we might be a bit confused.

Would you please elaborate on the problem you are seeing?

grh

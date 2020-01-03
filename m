Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF112F74D
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jan 2020 12:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgACLeG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jan 2020 06:34:06 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:31072
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbgACLeF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jan 2020 06:34:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVzUanb7dAam24pacZxZsTGLd48ktOFKFGYUU+8eeGHbIAdqmBH0u33ZjkgWlWZo1wbyUdKrF3m3GoSSFHOk5VrRN7PTjLS+2iLFWiqC7ZWDB5A+hI51Ksalv4rstLAPl3AD61Cp9EGxkaGDz7RQ/RdNwDG+oNzoiwczArr1YtCar7WKiHQnb3Va9zpkojUhZcQApWzQ4MbR/I4a6XVqqo6zDkoStSgRaQ2pctpjhysAxX/BqXMLkhbIho0dQ7Qr483t1B52ElGIqtjimkQZHaTSOIwHfqyEPtsXV8HAkHl+DHAtw1CQ4FsVInIjJs/uQvfOW1H4a0jAMDpr+4wevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28rDXYRYpvcpZTvZMfbXBdg6OBxlIdjAuZce/I8aeVE=;
 b=oRXRW71Kh7Vtqnk+DLRcCgOlESpPdQyRozLGFpuQHgT08AHQjr/foWrTlgQtzftR5GVmnUP6hEcyT7rmjJi4Q747hb0gXWDV1fO9dLrFbJToNaG3pPLL1ZwTNcvGd9Vmh/PghC6+Ym07mSZnJliiEUdltJGDMcor9XHSGqshwE5GE7jxV+XQtdYfDj+RhfzdgvptdkUnH0qlm56BDIv0+HUkYFmless2JjqvM6sr/zcUnzNrdRhLwfp7/Bv0lpNiNCKmzSg8y0sbQKZcGCjvdHoTKJLnFBH2IDwjXCDXb5thGO5EToBjZm16k5/1A71pMU7yZqy7C25aUWTzhSf+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28rDXYRYpvcpZTvZMfbXBdg6OBxlIdjAuZce/I8aeVE=;
 b=XlUMUXkV2pyMFjYFKaXuGnRBygnNX7+O+XXiOehUCMbN5g+i7R3tYqYqIW5USDu036komHMZg+A7CG+Zj47J2SsyzeWEVaUzjizOUt5ndBk0FzIeYzbhP5mCcl6+CG3fAXoL2orc2JrvQgv8R2fn46KZDZWGkQiVx/5wzZCtQuU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 11:34:03 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 11:34:03 +0000
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, kbuild test robot <lkp@intel.com>,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
 <201912280738.zotyIgEi%lkp@intel.com> <20200103062630.GD2818@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <4f821b57-9b45-6aa3-99a2-abe3539eb15e@amd.com>
Date:   Fri, 3 Jan 2020 17:03:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200103062630.GD2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from [10.136.17.186] (165.204.157.251) by MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 11:33:58 +0000
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbe21c11-f14f-46a4-6c15-08d79040d516
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3343E9530491345440B96F23E5230@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(189003)(199004)(66556008)(6636002)(2906002)(66946007)(5660300002)(4326008)(31686004)(81156014)(7416002)(4744005)(52116002)(186003)(36756003)(53546011)(16526019)(66476007)(26005)(956004)(2616005)(316002)(8936002)(8676002)(6486002)(31696002)(478600001)(6666004)(110136005)(81166006)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpDlppeyMfk7XcYbl6b7hR+OUFF/OuZX068hf8Mwth9r1hXDVnFyXsUE1fW6i3axC6Ox2wv1oSwdPDgMefyqE276sxjC02ktW37BLTCmq9Yfs/IUhH1LXSv+9cnhHnlxc9d8gmhNCtOPX0ugE6muhMmKXp0AyrkI8Jsw/4bRAubF4r38vOQIkV2dDAiPb4kN8G9+nNLLaOQEWBsMczxDCy3GEhwyxoag+XVlxg8iwpKLeU75BkJFQTUppdG+fLL6il3VFbr7ACupacCgsZ2QCZuQOsi4MjV9E5cwslechGkIUHmnTcyvNlR0syC11d+9dvsHQxFwhK/UDcRFf1yDsPVIFGOsvvLr7gWpnEC/9FPO4Dh7eE1wxao/pjnlQXdlMc5s9c09S0p8DqkDIwfKaSX69Vv2egEvUNshatHQBmDcBoq4IoJtkHh3yGX81XAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe21c11-f14f-46a4-6c15-08d79040d516
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 11:34:02.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE1D7DJYl8wFTb4BLBdwtom4TlFbPJD9245UvTmKGrbZtJQbXKtbgNKECGYOLzRUR5Xc2KPipUrbZATJmDuGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/3/2020 11:56 AM, Vinod Koul wrote:
> On 28-12-19, 07:56, kbuild test robot wrote:
>> Hi Sanjay,
>>
>> I love your patch! Perhaps something to improve:
> Please fix the issues reported and also make sure the patches sent are
> threaded, right now they are not and the series is all over my inbox :(

Sure Vinod, will address those fixes.

will check about threading. Just simply git send to the list obtained from get_maintainer.pl? 

>
> --
> ~Vinod

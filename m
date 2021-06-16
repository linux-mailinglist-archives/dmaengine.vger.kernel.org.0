Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0B3A936A
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFPG7x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 02:59:53 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:36320
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230508AbhFPG7w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 02:59:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzcSVNmNy91a7kglpQKuqQ61miNiV/odhkopgzeJq69vSG+/FtU4XFSFYxdt7/l2RGsuSxIDJHhjHZIQ/on0e72tOgg8GeRJV2iIrQ2B+39Qgx253seUuQaDqgtV93pHRw4a628ks9XS7vRDcrixycZdpdzmat5lD+9yec3bGJszoraDjMptK6mGjvF9fJxjLYeOadsneY+cPXKO1GoKBVHPjXyeqtO8mPqcYeLw/Y/DJNALu17W5enAi0IN/qlq/NRNBNmcrfSxqW5hKpz9QWj+ljPfDsqdJcwR+fQmBm/XXqwupuUo5Q10VQmD+PqsDQ01nDUFSc7SJeO3Q3nRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PQt8/wYeB2He8aNBuUecSzvzBOvoaWYIb0X2F//iI0=;
 b=EmDt5Ifvn4IXiQy+3+rtlRNwb9gKCI84F8Hfo3qH8d3dF1wTVAWaaI7u7xpClQFncajs3be9n181OISvc0DQxOl5CNdVbkQPaSvV4/IA+GF3lS7p/hdfYeRL/FKLF3tfTfYK32hGgC6oYl3ReEBDSl/AOoM5RiCDNmJF7yv1WFl0g+CFXUjTKBqh4zAhsHORFGAYVxxK2cFCGcv3HJ7bnxSkpoqUoP+TydL5zkgjn209zFINsYvAms4pD6SticKKizKZcgCQIpzCG4RM52YXeCkWfF+EC4foqjJj/+X4RZmrjMwXgYbSuEP8FgI5uDlVPAiLLv4sdZLidpGaDOmKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PQt8/wYeB2He8aNBuUecSzvzBOvoaWYIb0X2F//iI0=;
 b=qWe+epj5Nmz+YMPTJQ5qz113zJegepTxlYTaPgtNGCR2BmIZ+A8qrezFCrnse8x8EnmIIHtO1JzBlGJACAsVMgPIqypQs8RbmZ14mJx4uwfTap1Vrfb1wMPYRsW4ymIcv6PRMLkXKX4HM4m7HneM+iJoANN7TtJJgYnSPFmMtgs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 06:57:45 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 06:57:45 +0000
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl> <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl> <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
Date:   Wed, 16 Jun 2021 12:27:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMmXPMy7Lz9Jo89j@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 06:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8474a285-9424-4a76-f330-08d930940b71
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5400F2AE7E6DFED3636F95BCE50F9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AypCn9wP6R71MRfoG/LfycxdVCiCSLPQ3/Vp1Sb5ivN4DDL/d+WdsjlRCzQeh0cpju0US4Nrz86UtdWbhpq3oLDytuA3WueByeW6o+d7snCp7MXfQ5hLmDIRajcrjEMU2QD4hVv1v3qAgU7otDdQBdSJTihjPfl7FcUKoUCxcZ1lthrtOA3ktOL73W+n1jKcTsrvvUyriqC3QgzG+WeAs3mfxQZvkizDP7ddyu+vU+OTQHvia85RRahJO1NhvriKO1wB9ze8wb9vI1C2aYU/nQfE8KlPIiZDodo9ALYd17HzWl/WSSHGO1szQ7AUdtvXbd/qjtFYVxkE246tk1ST6pcEN+/3bFH6TGI9bEoyhdtceJsKlHGLBOB+Fq+Ve6Ytg6edmUQelatOa9wATUtpOSlo0XtvrLdAUwotWJ9Qsav5+pins2kFJ3FlhAqXKRToWZHCrtqRI/Dccmf6ITnoGNuH0a/odJrB9kLH8lyCTiDxbw6SN2n35x7X91tGq9/T9REQgcdETR8c2828b2CdoxEqnhJykafYfMM5YVCqa58KYW4T8AcUUeSPZAtGk4mOgpjeRoZEgVLv/cm1cOuuU0nLQuYr8lsss+GYyOj75+rPlSwLKJ6jXSP6iIRYSNGp4pb5Xdzsyme9KmJGT+AelMFzazRyE0hL/9+tgPAP9hmxmQqA211oO3XHn599Ryxy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(316002)(16576012)(31686004)(54906003)(66946007)(66476007)(478600001)(66556008)(4326008)(36756003)(2906002)(6916009)(6486002)(38100700002)(16526019)(956004)(186003)(2616005)(8676002)(6666004)(31696002)(8936002)(53546011)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxHbTlBMjM2Q3lFUWhQcTA0R3hFOVVFZkhCd2tBeTQ2UnNkN1VxSnpqYVlQ?=
 =?utf-8?B?Tk9kVU1UdnF5UEU1aEp0QUJxNEthL0xmOUhuUUp5eFExTlh5UVIvSis5Qnkx?=
 =?utf-8?B?UTBTVWcxUDgrdm1RL01uT0RHTm5NK0FZZ0tMRVpvZWJhQUpYbzJNamF4Ujdm?=
 =?utf-8?B?cTMvNWFqUHl4cVRyaTk4QmkzU0NTYks4cW42YTJTdE5FMk1pRUkyWkpRZHBo?=
 =?utf-8?B?cXFTTE5tTE1ORFkzWVJQNDZVcW5NTjJkQ2pQQzNPb2E4SVNPRWh1ODlsMmtH?=
 =?utf-8?B?TThKTVg4MTRKKyttbitjU0JhSEpRKzJob1JlNGdNdHg2NnM5VEwzTFg0aTNu?=
 =?utf-8?B?R0RSOW1vVEl1dlNjaWIwK2VVTDJ3SlEwZ3VXbEZKdys2eEh6RHlRcjBEdWYz?=
 =?utf-8?B?OVMyS1lTMzVUNVFjalJGK1JwcFh3ZjI0clVHcnE5U3B1Qlo4Qk1DdnNuQ0kv?=
 =?utf-8?B?K000U0Y1aEM0MGNONVVEVmtFQmpKU1hYcFVnZW0zR1NQQkNpMGtpZ1paQ2x0?=
 =?utf-8?B?Sk85Vm12TVJnNTkvQm8wOGhOTU9wM3IxK3dOeDVGcVpRdGcrUmtJNlN3bG43?=
 =?utf-8?B?NFhrMFhidTRSbU9oQllWMFVVTnpjQXB0dW9nZlNjQW50dWVvNWZPSWlWQnFy?=
 =?utf-8?B?YStVbEd4TnkxT1VXMzRFWDVHYmZ0Y0dmcHNGM2FxU01sMTgwYy9aVnRhTkpN?=
 =?utf-8?B?VnNFY1hwNUYvOEV0aUJKRnFRRkIyRmhFaUNWbE9CSzYxejQvWUdBMlJXWW54?=
 =?utf-8?B?Z0twV0JsbVRabCs2QVRDeG1RSmlyWloxZHcvWWViUm5paVVGT3VGQ0R4cTU5?=
 =?utf-8?B?NUJ4ZWRidHJPeTE3ZWwrZjlobWZiNHExSlRVMS9zZERtRTV1S0thdm1EK2lT?=
 =?utf-8?B?Vm9naWlJb1hyM0YyYlBmcjAwL1ZFSlZTaHFZWXl5T2ZXZHI4RTcrOGFZaHVi?=
 =?utf-8?B?akVUOTE1OUl5NXVhd0ZiSG55cnRHOG5tL2ZNdUNRQmFrQllJMUNBOVFEZVdi?=
 =?utf-8?B?UGd3MllSYjdxUmlwazZRemhIZGV1ejRJekR3dnZWNXQrdHdXM1luRzZabGJX?=
 =?utf-8?B?SmZjM2ZNUlkzUFdpVmVUQmdON2d0WFoxdjZRbVdBYnZvWHo4SjdBYVZOVDhw?=
 =?utf-8?B?ZGhaSUNIYkFvWnlqbHVUck01Vkg5N0Yydjl4Z01LZW1mUk1KSjQvaTVGaFkr?=
 =?utf-8?B?V0lPajJSOFZ4eXdaaTVlTG82K0JhMmdNSzRJdVNCV3VXMEJRY0VjU05SRU1E?=
 =?utf-8?B?QW1SblRtczNNY2t5M2pTbTBFTGtNUzhsTCsyeVhlZVFCdDBVWGhNcVRHQVFM?=
 =?utf-8?B?Uk5ocDlOUWtFbjQzcVR3cTZBRzY3ZC9MaW0yZnY5aVZDbFozczBtSjRJbGdO?=
 =?utf-8?B?VTdRck5jSTVnKzBXdjBPZWRjdy8rM3REZHJpTGxlK2YxMnNYQnkybkc3NXhE?=
 =?utf-8?B?L05SSndJNmFsOVJocGRObVp1b1RqZTNwYk1GVVU1QVVVZXRwQk52WGsrYmw2?=
 =?utf-8?B?UTdKVnhCWGVybThmdWF0dktoUkV3SkU3cDBiSVkrakhjR3BzbllPUDhtNmVO?=
 =?utf-8?B?WWpueEJKd3plRHAzRHBsdGIxcjFISXVBN1YydjJWS3hOM1dDNnBNYVdLVEYr?=
 =?utf-8?B?YTk0NzEzN05UTnFWUkwwQmc3aXRaQkwydEYwMGRqdEYrdy9zeStiK0ZUTU1l?=
 =?utf-8?B?NFpiY1dHcy9lUkE3c2Z0U04vRFRjcnhGSzZEcjdQT3dsRUVXdHp5VlU2LzN2?=
 =?utf-8?Q?rFGuztwl4rLrS3x7sYIERGhrdwT9qxQxcBQBvIl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8474a285-9424-4a76-f330-08d930940b71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 06:57:45.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47zMpr9bi9BpvCmsi1+LN2pXIipqJmqZJ+k0/3xh49nUoitPH6pL5L+6nSdiXb9Hft7RBPPfsfrPCnlNAiw1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 11:46 AM, Greg KH wrote:
> [CAUTION: External Email]
> 
> On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
>>
>>
>> On 6/16/2021 9:45 AM, Vinod Koul wrote:
>>> [CAUTION: External Email]
>>>
>>> On 15-06-21, 16:50, Sanjay R Mehta wrote:
>>>
>>>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
>>>>>> +{
>>>>>> +     struct pt_device *pt;
>>>>>> +
>>>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>>>>>> +
>>>>>> +     if (!pt)
>>>>>> +             return NULL;
>>>>>> +     pt->dev = dev;
>>>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
>>>>>
>>>>> What is the use of this number?
>>>>>
>>>>
>>>> There are eight similar instances of this DMA engine on AMD SOC.
>>>> It is to differentiate each of these instances.
>>>
>>> Are they individual device objects?
>>>
>>
>> Yes, they are individual device objects.
> 
> Then what is "ord" for?  Why are you using an atomic variable for this?
> What does this field do?  Why doesn't the normal way of naming a device
> come into play here instead?
> 

Hi Greg,

The value of "ord" is incremented for each device instance and then it
is used to store different name for each device as shown in below snippet.

	pt->ord = atomic_inc_return(&pt_ordinal);
	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);


- Sanjay

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC93A90CF
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 06:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPE5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 00:57:14 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:58752
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhFPE5M (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 00:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/AzpsSHV6PEvxmUCqIVoaGKjSSnB6dgADNwi9REr6Z84EdoYz1qNBnAau7atZLiRJpUh/3xLM34ss2pQal/S4/HyWIWsfxTR845XqW0e5n0uaPIbff9lo79GIE9mgwA0/CotrWQ1YIW7/mqLTKrRdzGZ0RceyfzyjD6CIBeShtM1RPKnitd0fB8cDiT2IKZC9oGzRx5ekgPK7bHiwnUarTNl/yEIc8H8jYvJ2WpLhW1wQN2VnuLylgeT94QZUYBL0TWzEtfjzKKEbAr6vCyWVFlQnrGWXhAAc7784a7SakGjidjw7ZfI7EBMYMaBfjzBwqaGo8pK+jA/0JhdZOfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlDCE+VAmVPr0X9zXk0jKbFUEXXKUSLW447hmlIQf8U=;
 b=A4NpAEV1ZFrwjuE7Wy69SqT7d4tiety8jUlCISwdVTq4P4f7TpJbmylvUWNnzFu/lYL6WBHGqgzggn6GmF6zqboHhGm8ETByCbkQ5bcuTON2mfzqGbYrAjZr8oXWXtCQ0Vb+2mZJWvnYw+rR3WzLhZua8fK5nY8Fbbs2KFG7A+A4cOKimbxp2tDQexPWlohLPJx2QrpMU02De1HzVmGf7I+LWdbKRa6K1qAWVcEqU7z5142mvVpHrK2KRrW8WQxBq+F6BKjblwFr7H58ozVu3azwwL4JW4UPPbRGZO0iCRrLrINEVPazLsQR5bKGZe4VqOz+b32zqu/joiApZfGG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlDCE+VAmVPr0X9zXk0jKbFUEXXKUSLW447hmlIQf8U=;
 b=U8PzqkI3u8lF0VZSlZqcpPgW+EwVXnkdJzKcwAgZI7dYCRZi+d4MtjklPqfZPpuEyZ6SOovsvXUHyCc881a51xBOQaddO6L9QhNs28SMQAyDW6Afn4SjnWx8hILmipK3+gjh/sIbH1hvJk1g/0K6rhhHPnVR8kw/3T+jXOEGhmo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 04:55:05 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 04:55:05 +0000
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl> <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
Date:   Wed, 16 Jun 2021 10:24:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMl6zpjVHls8bk/A@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.226.125.202]
X-ClientProxiedBy: MA1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::26) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (223.226.125.202) by MA1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 04:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0126745-9ecb-488a-2cce-08d93082e832
X-MS-TrafficTypeDiagnostic: DM6PR12MB5567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB556779FEBE717338685082BEE50F9@DM6PR12MB5567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIJDZit3p1K6Kua8DA5TLOISyUius0bVaEjQgg42MUNbSgSJmouHG/Tr3R3CFqNLxEuBDvS8DHr3Oz8faKrqUgLCF/JDoVC9st/ZMTxye2MI7t1AUgZ0aiVEtiWznF/aZyg/cqkluoogImmTdDl5PpDaxmESfQ40TjcvqSqjR+991X6gnQ4x6yz649fH64HRIHR7uW3lVS15h0vZiWaLuJgfndf0g61UKbSQfmLCTr+RG/bo5ZC65ejyQDaDpl6AR3Hri3hZA3nqHQhL/GQih3vM0btfOrzoddZ/wfFRI14C4fUVFM4l31q+ugNzeUP1N89xprxk1pebTwkp6sJ5Nu+L1W3KSoKhVaqReYxNk5CGGuT1r1rA2ICWzaEsSQvODBOkSp9otUkms4RqrbOFD3ySIRizGiWK0mgZQht22aoN6Osr+Omj+c4tSsLei5r2VaslmaxNk+3I85GomJOEmkRW9SgitriGNeaOQTkvYd6KCQHW+BNFjLiA350mrfYdgKOvjmyjwAvfdHyJQKp7+Fu76NWQ4peUSBGXOZ24j/O8qB/tQY5V+hxFBvjzdaPTKr1JfXs01jgDdRN9nehn6H1dmnCEOWvZuXYteRN9t1j0dKWv3Px6NecygYbcJItfFlMu9vIG20c219du95lf4KBgj63666xnGYuf3O5ocHqQTawizQgezONL0S84v2EU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(2906002)(4744005)(16526019)(31696002)(4326008)(36756003)(31686004)(186003)(8676002)(956004)(2616005)(8936002)(6916009)(316002)(66946007)(66476007)(5660300002)(16576012)(6486002)(66556008)(478600001)(6666004)(53546011)(55236004)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtwZEM4eFVERzVjelFJQlZNc0JMK241QlRiaGdTeUFVVE1sdWp6bmYwUWR1?=
 =?utf-8?B?blJnTE1hSXp6WXRjZXI4ekpIb2g5RXJxWE43a0VGS05KSmxYeDFOcDNyTUh3?=
 =?utf-8?B?MW9OR1NVV2Q2TWl0S1pjMHB0U1FSdXptV2JlWFMwS0ttQ2VxTTRPNmJtNU5S?=
 =?utf-8?B?QjNNSUtGRG1MdVhVd205SWpZTnFmOGd1ZUNWU3F1WlFEVTk3bU1TV0xTZXZ3?=
 =?utf-8?B?eG9qUXpQRzN3ZWVGS1F4Ty9VdGZxRlg2djN1WnpvNmRUdk9IZlRMRDh5dUti?=
 =?utf-8?B?dE55WlNzSmJEL2pQSG9LUDBHRVFLUFEwbzY5eVBtZ1JkOWp5OFZJTk9YOER4?=
 =?utf-8?B?ODRleWFONHRWR1E2VnJsVkxBS0xaTWRVZ0lCVUt3MktFcWdDT2xDaUh5bVl5?=
 =?utf-8?B?STluWEtrOU9PTEVtbkNQdWs2QW05b29FckttSFF0cWEwdGlGcHJlRTVkQUVm?=
 =?utf-8?B?Sm1ETWVsem80MktMRVV6RDRlTEwvbTBKMmdHLzhVVTJSc0VjSmM4dHZuOEha?=
 =?utf-8?B?bk9EMkpLM2N6M3VQK0hQVTQrZklkV3dYQjZiUVRpRW5PbE01ZnN6WW9yNjFT?=
 =?utf-8?B?MldYMTlOa0J1MHVBS2lLUWNISVd1YmpSQmR1L05sNWF2YlprZE9jcGdWc1R4?=
 =?utf-8?B?cTVHS043ZjdTMU1yaDhrb1FBanZnd3pBaXFhNWxteHJGRG1DMVBUTGRDaTJy?=
 =?utf-8?B?d1RvYkZtOWtzR2ZybVp2VjNxSWlCTTB3NkU0WmpZSFczMGVuU0ZQeURtc3k3?=
 =?utf-8?B?TmExYjQzcllaUmJwSnJDa3YzVStUMTFVQTNMYVdwV0diT1JseUo4cVdrcFFj?=
 =?utf-8?B?UnBtbzBwTXVCNmxabWdlc2NIeTczaVJEQitKZmdxcm9hMmY2eEFIUlllR1Fr?=
 =?utf-8?B?MTZNUGVlbmhHd01Gc0tMNGM5VVlkaGN5cXd1TEs1MUtaQ1NKSHNlamRNM01t?=
 =?utf-8?B?M1pYK2t4eHNTcDFOQTk1SWFiT2ZtakFJZkhtVlU0MzNXZ3JiRTFzVFJ1dEhM?=
 =?utf-8?B?UCszUW5LSzYwSUhtRzRmVXhUZEU3KzdmZEpLbkF5ZzhqamZEV0ZVVmg4aUI2?=
 =?utf-8?B?UjFzV3RzM0hsY1J0bGJwZno0SlQvYkFxSmFidWowTDBDWHJSVElLQVpzMURW?=
 =?utf-8?B?UVdIWTJoOTZkTmZpQXJ2Z0FSeEZaSFVsWGZnSG5kVHR3L3pFcW5wSjYwVHhT?=
 =?utf-8?B?NHdpMDhCRXpPNk1tWEFLZXB0dVpvWUh6dHlVVWl4czNiUnRhM00yR0hXbWty?=
 =?utf-8?B?a1Z2eDBtSkV5WEFXdnlrU3gzZzZuZlliK3JEUXVNbkJjbWtKcG1YNW1hcXhP?=
 =?utf-8?B?RXk0YXVqQURoRzI2ckRlM0hRRno4bkNhaVBvRE9Ja3ZPWGtYS0JiY0F5TmE0?=
 =?utf-8?B?SG5WZURCNXpCVDhoOFNwZXU1VzV4N0NYOUk3d0Y3Nk4wdU1NWnJWVThiUDRV?=
 =?utf-8?B?TTZZS25ZbjZBTENrTEZTV2FueDZKOUlYYnArN3J5bnl3VUoxWWxtV1k4ejhF?=
 =?utf-8?B?b1Vmdjl3TmhXb3lJU0w5L2dkckYrRE5JbkU2elYwbUpvTWwzWDNrNVVheUVM?=
 =?utf-8?B?dmhja2EwQW1EM0tFSUpyekJ5UjNQSjBCMDRFNXFyU3NXbllzdmIzdFNnUzkr?=
 =?utf-8?B?YjJmYmNuck0wVENYMW9oWHh0M2xBeFV5LzVHU3h2d3grR3R6SzJqNkZtM1Bo?=
 =?utf-8?B?ZGNTSGxKZW5Za3p6TFkvdmFnUnU2bUxEV0FaQ0N5TmhKcHBQUlhtcGY5a0xq?=
 =?utf-8?Q?h5N0QOImERoEl+uX+YizHExg4fScJ+h5LLxjUQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0126745-9ecb-488a-2cce-08d93082e832
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 04:55:05.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLYhwJqw8E4NvJNcvlK1gX5+QLYo++JuaQzUtUCV6+BrlFsXjM6tju/Ht1P4MQMncGy3E8pychzKVT0cCaZfsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 9:45 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 15-06-21, 16:50, Sanjay R Mehta wrote:
> 
>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
>>>> +{
>>>> +     struct pt_device *pt;
>>>> +
>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>>>> +
>>>> +     if (!pt)
>>>> +             return NULL;
>>>> +     pt->dev = dev;
>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
>>>
>>> What is the use of this number?
>>>
>>
>> There are eight similar instances of this DMA engine on AMD SOC.
>> It is to differentiate each of these instances.
> 
> Are they individual device objects?
> 

Yes, they are individual device objects.

> --
> ~Vinod
> 

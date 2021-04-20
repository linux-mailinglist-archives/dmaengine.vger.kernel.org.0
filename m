Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E536533C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhDTHaL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 03:30:11 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:17536
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhDTHaK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 03:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0a+8T7IuTfFbWdxefwLZXqwf66Hd7d79igDGVCuZiv2PTOG0iKX4+M6+V5K2NTvQK5Okuz6ikMQV5mDra/I0BKGMvUll6Do55lf6vWWZdzwXq1Fo2mdNETY7BwXgsBgAWfITQr534KewUz03IAQIJ2ti1Gms1gcrMXS2t4OXdvjJV1wy3g2lhfgQFC1azvX1/Mctfp38ZuQ7yen3iFCnI6/fOtHAwb89AGfncffXptsTr99C+ehJxP5GnID0o+cV+R72Ty4hEQDGfFGSwiBd2Xg/+auvLWSuOpPbEXBUSRd1KwrXaXDZjQq84fvVyGsEc7qgoK64r3JuozZZ34FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNToomE8QcSDlNbEslq7sRygE3kUenVDsVTSsxLoFGE=;
 b=bNCDy5u1kKWrnWYG8MBVQuervGSZtjkvBua9ux43ATqbjCnX8ag69YArv6jVFvsove74E/z54eUwTWW3SOVIEn9Y1Y0q2p1XytxukiNuw4sH7Uk260QHZGqXEHoMnqZ3J0GEACoyNp6r45dD22848TLz5hLFdu3+npmazFQ4wBQ6/rvqzlxIiRP487/Zro75AaZhSX69afycYnb/ah2F19a7PyQpH63jsy+2ybHPgbjLKsvvDDTlMPzJM8h7bze+HT6VfGmRKXndL51U4HdA69PlstPRCJOr+gJ3MaURUh870v0mVWC0i1Vjf1uyyhVQQiTukQumiAvWdMg2G16NGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNToomE8QcSDlNbEslq7sRygE3kUenVDsVTSsxLoFGE=;
 b=YzrvUKtV6zgMW2OFYCJQPOQLuN7ZLcSFqirMLwUDiVEC6tgV9n6cq/YiyQuNaVM/OXfVnunvEGLCQQml1xf9Q4/bjWc4IKDRbDCmFsGUdEGgm4zDp/NZsz4TDNteP3Nov06Hdjf58tDgw4zm1BZ6gi0mxrIaWfIo+OIu7CrFxFQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 07:29:34 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::6936:35b4:bd92:8d45]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::6936:35b4:bd92:8d45%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 07:29:34 +0000
Subject: Re: [PATCH v8 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
 <1616389172-6825-2-git-send-email-Sanju.Mehta@amd.com>
 <e33e0979-6688-0da8-c5a6-6b76073dbafc@infradead.org>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <df7b2c7d-6353-6ef6-6a94-707668646d54@amd.com>
Date:   Tue, 20 Apr 2021 12:59:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <e33e0979-6688-0da8-c5a6-6b76073dbafc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: PN0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::18) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by PN0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 07:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37b0a5a8-6344-49b4-aba6-08d903ce0b8e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB519925549A18AEDB1B1F930CE5489@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdANrVyeklQ9YHGHQdu7h7xLD0kkUnFO+6k/704sE+vyed6M9WtGX/ldYPl1Xlv/WR52s44hO71r0jYzgE8iF0XK9/0+A3GR7ve1a1RlgomzphrpTno9gWBpLHeP280IZTyiA2YoI3qd4qBctT2uA+NE5E9TSp1MKH+xASDebjnVxmR17A/IZinhYLj0ZJQQiim5kC0+Aphe+okzjYL48j/3B1BcGbJ4OIu57dsGaOqq79c0YTjzuskOx7+Wo96w2PaKlEQETK1lkCCm8OToSPdPeMT+1vpezQs61GtJs5IfaxZQ6O2ZrttpcM/RzZxK2B9YvhniHJGyp8iIsVPrObKKDqTX3QN7ARPuHXGzfmffWsUZ4b+taJSc59b8UdbKWJoy8hPBTic1bPKAilfjK0OFUKtHreZZFLAe2KnU+HC3zE926rC3VCwdzteuvhdgWLwCin5RdmRf+Eqy63yhvlc5F5AhcXDqnbrFucxJ6HsYbBiOIlX/89rXMj+6cvxRIFpRrwaO/B8eDM23nOXLSA+29kHfWXmlkphNxrFeGToMewTcDEN0Gw2/7xDcYsi0DoLk+g23NqORTPCF+Yx5Pcmt1IUQDwYzEW7IRr25bMjxd4VkXmkcxGI5v66Kz+okXUIiWfXJuxOxCvU5dkVzi99XACg3k0xS/oS1VOKD4MfZPPnHxI7xDo4ClpzeTvcvpOLoOrQK3daKxZfVNtjOl1gapT1XMFOMypOBHbbrSjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(16526019)(186003)(66946007)(26005)(8676002)(66556008)(66476007)(2906002)(52116002)(31686004)(36756003)(956004)(2616005)(6666004)(38350700002)(38100700002)(316002)(8936002)(5660300002)(53546011)(478600001)(110136005)(4326008)(31696002)(16576012)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RCszWXM4UFQ1aXBCVGZSVHRHTDZ0czVoYkZ4Q0M4OWZlSXhyV2RPTStYdDMv?=
 =?utf-8?B?KzIrSVlORE5VTEdJZFE5OEI5MUpLRVRqQmVtT29TYTE4eGpoakEvd1pZanFR?=
 =?utf-8?B?NkRHVEIvT3RPOXFGRXZmVnpFMmZpeTljdm13SXVqY2o3aDhvcEVRMS9teGk4?=
 =?utf-8?B?aFErRlpDb1BnbzNueml0NnZ1WFBwRHhHY3RHVzZralM1NmJsUTNmbkFOb28x?=
 =?utf-8?B?OVJqTGhIT1JPVThMTmhmd08rcWIzOTB3MUVQWWxGajd6UUNaM0ZITkt0akFs?=
 =?utf-8?B?MmQ0M3B1L2FIQ2dnejFIeFIvV210UlM3MEhPa0s4cllHZzgwejZJcGJFTld4?=
 =?utf-8?B?U2VKbW0xeWFjYXl2TEdUdG9QUEZMc3NnMkh4b0dkdjBlV2dxQWdNaUk2a3Rr?=
 =?utf-8?B?MXp5NEpSbTQzRk9vMk5zeWs4S3BVWVRrcjMyaXYxRVVEcDZKRUljSEdHR3B5?=
 =?utf-8?B?ZlhEKzFDSnVMOUFTRGhTSnNhKzhVMy81TkRONnZvSmlLY3ZUU2MyQWlPN0E4?=
 =?utf-8?B?Mi9SOXN0SGZ2UDJUZFpOdENOTEFlazFLN3lla3puSGtWYlJzOW1YM1VycC9O?=
 =?utf-8?B?djE3a1JaMHFaWGJlbjIxSjg0RTFNS0RlUjlTUmtPK01PaXVzSmk5eGFjR0h6?=
 =?utf-8?B?VXB5OUs1dS9PdnAvSUVpT3k5aCs4Q01ocFBoZ3lJUVhDYlk3SnZpbTVpZk9O?=
 =?utf-8?B?UTFaMlU3MHd4VGZKVXNkSXIzcGhlZUdXTmhmU2dSWmovRXFVU2VIb0RpYjBq?=
 =?utf-8?B?Y1ljMjJLR0F0bEdvenFvVWpGdlpYcmcxd1h6bGhhU2hhMVpwdGdpSTlCY1Fl?=
 =?utf-8?B?RWdyV2ExUW85QkJwdkw2RjRyMnhVZ0wweEFETkFwSmltazRRK00rRCt0Ykti?=
 =?utf-8?B?NmF0TDZnSW9Wb1ZyVm90aTRod0toRmkrZFRRakkwOElITkYzeUxCREFYQmY1?=
 =?utf-8?B?RzdjeW44OWdHUXNFZU0yWmFVeGpxeVNvUFZ0NE5yeFNtWDl1MFNxbVpCYTRK?=
 =?utf-8?B?T0dLZlRYa0FhQW1ya2poMFZ5TGpjczByU0hIRDNIQWFhTEQySFU1Mk5zdkJZ?=
 =?utf-8?B?TTVwTW1qS3BWTlZhSUZseUxETjE1d3ZvbmdCL3pYcitIRm9ldExONDFVOWpa?=
 =?utf-8?B?K2tjOGpBc0JOTEVEMEkxL24yMklydzA0cDVleHJaRmoxeGVNYm5PODJDdnIv?=
 =?utf-8?B?SWhLYnhjM1hOc1ozVXhxQmpnVFpJMUxRR2h5ZHUvWEhEOTlmYkFkOEZac3hx?=
 =?utf-8?B?Qk11UkxiQ0NMMFVTZHhWaGNodDNtUWZiWWdDeVBoYjRCZnZPbVAraWQxT01F?=
 =?utf-8?B?cERvaG9lNkRjVXd5YlJMNWYzQU8wdTZHNGJkSGJqaGptM2dLVzZ2dzdWNVlO?=
 =?utf-8?B?NmtMakw4OEw4RWdkQjErWnVPU3Jnd0RtaU9BRWZ4Yzlwc25QcFovZmdEYzRi?=
 =?utf-8?B?RFdSSEs0Q2o3MkNZRUVia2N6TmdDMmVMdHAzWUN0TTFQbG9qbjRlZXZwM3dI?=
 =?utf-8?B?WGN1MHMydTdMR29xK3ZYblpxMlIwV1BrZ0tRTThBWUNEeFVUVjRVNHJ4MUU1?=
 =?utf-8?B?WlpxWHhmUEM0cHhRUlFPQ3dCeGRpWmdValBPM3NQYUJnb29PaEVWNktWS1Jh?=
 =?utf-8?B?WVlrbWhza1JUOHd5SU9VQk9XWXdrcVhPL1ltZW5kMFBVcVhVaEFHUTZJRWZn?=
 =?utf-8?B?MVNUL21XZm9aUDAxdWVDbnNxbHo1ems2SmxObTdQSFhGZFQ2aC80ZERDQnp0?=
 =?utf-8?Q?9xe7pnqTAOkB/8qGlmRu5AYrbK3w13ArNTehskR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b0a5a8-6344-49b4-aba6-08d903ce0b8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 07:29:34.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjoIKLlXaU3zmvox4NfXa2DxRCE+v73LbTmRrkBSpfsI79K0seCZQSGmn0mzOcl3Cd4Kb6lJHZRvF+r6nuIeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/22/2021 10:36 PM, Randy Dunlap wrote:
> [CAUTION: External Email]
> 
> On 3/21/21 9:59 PM, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Add support for AMD PTDMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
> 
>> diff --git a/drivers/dma/ptdma/Kconfig b/drivers/dma/ptdma/Kconfig
>> new file mode 100644
>> index 0000000..c4f8c6f
>> --- /dev/null
>> +++ b/drivers/dma/ptdma/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config AMD_PTDMA
>> +     tristate  "AMD PassThru DMA Engine"
>> +     depends on X86_64 && PCI
>> +     help
>> +       Enable support for the AMD PTDMA controller. This controller
>> +       provides DMA capabilities to performs high bandwidth memory to
> 
>                                     to perform
> 
>> +       memory and IO copy operation. It performs DMA transfer through
> 
> better:                      operations.
> 
>> +       queue based descriptor management. This DMA controller is intended
> 
>           queue-based
> 
>> +       to use with AMD Non-Transparent Bridge devices and not for general
> 
>           to be used with
> or
>           for use with
> 
>> +       purpose peripheral DMA.
> 
> 
> --
> ~Randy

Thanks a lot Randy, I fix them all as per your suggestions.

And apologies for the delayed response.


> 

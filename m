Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9123E0E2F
	for <lists+dmaengine@lfdr.de>; Thu,  5 Aug 2021 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhHEGTC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Aug 2021 02:19:02 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:48425
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235960AbhHEGSf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Aug 2021 02:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJdAyv8XqyXA+ZvFg0Qhui3APZHzGn08db46WQ64JCrF2FSvnAMAXwyGpA4QhhgPXdPOhkXLTYsyXReRDm6YUSk435bxw5dDTKFQCrvUyt43UMk7q8JJhJbsfTuHv0FpxVnODE9LNhjMpfGucJ2JES39pD2nDwRTzF0rPEqAzrlxNq+NB6kgWseAJShQjBQzQMtcOYzCtmwWliaNFZV+mfkwq0APNWTQSoz0JAnpa5buNUwK8WLrGeJvq4wzybmTRabtd5uSJCzwA+Fg7dNVJjzaO25zGuUyBuKEg4dvvhsCQje/XIGyeYCmdkCGuHh2kIs39vpJ2DPAoDnFY2G3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL5TDjAw4dyUfznLf4Mtpm9jOfZz9CmImKj9mImK8SQ=;
 b=hvEdehJ9dP6AFJuhxOz2X9SxiiTvPNgOpe3iPQjj3oEZRxXhXBHi/RocKcCXK4FJ/kn+WxeZDIhxztwSyd19y+8nm+9zu2UVkfCErijXtEa5gJn3EPFHCjFgyddU4LsY5iNvz3u2F1VesWReFlFzW3Pu6afVIb/ZYuKpNV3kGhNBkIRerlVnzD1qQZIO5e5yzJS01yWl94c8NAoXDpfzormWp/lPhd82Sp3zrlzDUmJZni3IynZVYKXulhnPNzZQFmdM/pqcRRdiXWRN/3noEf+KJs7YxnuMoigVAS9WvKD2R+0thD4eb4NbCra0EEV6D3ES56k6UEh4dUjcn/HWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL5TDjAw4dyUfznLf4Mtpm9jOfZz9CmImKj9mImK8SQ=;
 b=5j24fPWIJGI8qJXliRaAME2sZL7ASvfTaZjaxIF0LOfrkyO+q2ODZPhi2J3A9JD12M5paeuIChjb2UxGa/zp/5hXDXCxIR28K3mKGziTSfkPzBI4rYlMX0SHTQKmRF0unDP8K0wce8SkH4Bmm+U5vyTGyRMDIotYdOnZTwfODL8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 06:18:20 +0000
Received: from BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::183d:373:a7ad:ed84]) by BL1PR12MB5094.namprd12.prod.outlook.com
 ([fe80::183d:373:a7ad:ed84%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:18:20 +0000
Subject: Re: [PATCH v11 0/3] Add support for AMD PTDMA controller driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
 <649e5d7b-54ba-6498-07e8-fa1b06a25fc2@amd.com> <YQt54U70927eUgr3@matsya>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <21aed77e-84eb-57e4-4060-a37fbe86b0bb@amd.com>
Date:   Thu, 5 Aug 2021 11:48:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQt54U70927eUgr3@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To BL1PR12MB5094.namprd12.prod.outlook.com
 (2603:10b6:208:312::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (171.61.80.116) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 06:18:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c611787f-c24d-483b-5dd0-08d957d8d247
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077BF765EE8ED51CEF8E514E5F29@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGL6D5utSQdRUXZkTCCHGEexKlsHzaW5GDi3pUl4lrCyRjXaD26Al7SGCg2kYo1iTRCVUFJszp7goyxAKMRiC/PplYzBskolskud8crhfSnT89RRbuWNvFyuSX+fjI7nn97zn05rPhnQR9FUdNpTo14r4jPcGmXkJmjvh6IHE+FjmWfDL4KYbxBTew0yc5Xopdf9bus6qcCia0w0o6V85cuREFraA+IooEicbXnJh7WdpRCE+TSKXmeeYdxk/rYPtJ5YikXjXE5ImuDS3/10/XTJydP+8XcAk+NLBylOKFUopz2hWsrYNRheUpaUhsG/JcQZlAqRTUm3VyAaq18zsKuJkDhc+bMVMdVjmGOgEJ2PYcDjuvm5v89xB8GoDGjoaiL7qHJuAcizsoIFrDBWofC7g3+svoQv7jOTCUu0QmG/Eq+oiqUDHhabZtNuwzvbZwC1IPpvPGMQpUWUa9/5ScHtlXC07BDGQd1kftgRTrBE3+b0rlnzjLPLS55s3N5qHEKvDPRThLtB9iAcxSpactzTmg2K5/MH8jr79O/zuuB0Q1462EibMX0EQOpusupmNOc78hzcN5AxKGnv5zy7aH5tgyrsSpA8J3nTHkX4e2xS1QTvzRbUdM+Fw9gCMhjpZRsiWCLCcm+4jCwpVBESJQby7dKtGYeMyQ2phrTMWv54EhLHcXT3sy0vMlbNiQuw754Yg8ukPbC67OO7vfMprYfUQ//jwb1bcJQDQ717HyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5094.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(4744005)(4326008)(31686004)(53546011)(36756003)(38100700002)(16576012)(8936002)(186003)(956004)(66476007)(316002)(5660300002)(6666004)(8676002)(6916009)(6486002)(31696002)(478600001)(26005)(2616005)(2906002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHR3VTd5VHZHV2xhbnJXWmE3NHVYYUxUV3RCa1RvcjlHbWRHWU9nT1RNL0t4?=
 =?utf-8?B?TlZxa0N5Z1FNeGY3blFlWWRiQUJ1clVUWm9DMGJEQmVTbTFSV2t6eDZUMU1l?=
 =?utf-8?B?bldtdDdpWCtPWmJraUZnS0xTa0ZzdzVFNUREdExpaE9UVmRkUld1YTZKMElV?=
 =?utf-8?B?ZDNQS3ZvYmFKN1RZNzRQRTYrOG1OMkpKZXQ2RHQ5NHI3YTdsRFloVUwzSnJl?=
 =?utf-8?B?dEF2QmZoU2loZ2Q4YW9jbWwrbHQrVCt3c2daREc2VmFick81elBhbDdXVEtq?=
 =?utf-8?B?WkxKeVNERE5ubVRCR3JYSkNiODVnQ1V5WXJTV1lkVlpyN3ZKZzRKQkQwTEp4?=
 =?utf-8?B?QUJTb1FjZFcreTlJU1lvWGNOaVE0dm1wc0Nrd3VSUStQbUZodTJPcnNCSVZ3?=
 =?utf-8?B?UVlIUXFLN1ZtZXRQQmNLQmVBL2tGTGw0dVkxUlltQTV6VFU1MjFoYU5uMkQ0?=
 =?utf-8?B?Z1ZqamVaNGgrOE1KYktmV1BBRGF2YlFxQk5BdjFvckE0QjcwSktLbHgrOVQ0?=
 =?utf-8?B?RzUyZFJpTlFNenFjeFRyRzdqeXV1R0djNFJmczNVemN4c3kwdkpYd1drWGs5?=
 =?utf-8?B?bmRKWHVKYnFNczdLQS91YUd4a1R5ZmFvWDhMRHRCTEZjVnhnUGMrbWVYbGY3?=
 =?utf-8?B?ZHFQTkswUVZUY1NYcUY0eUo2Z3krcjFqY1lYNjZYakVNTG1VUVp5ajFOU2sv?=
 =?utf-8?B?a1IxTWc1R2pRNTNoeEQ5NURwbEpnZ3BlUnA1WDNZQlJ6TUEwRGJQcTU3dUNP?=
 =?utf-8?B?cE8vVUtXTFFnNkpNQ1pEdUFLV3Qzd3pRTVJJeFc3dUhLdjZLRjgrRFBqQk9I?=
 =?utf-8?B?R2diUHgvS1hEZEc3TWxUVnROVWhDNDQxRmNIYlFLTHgvdzhRNy9BU1VseE5q?=
 =?utf-8?B?MS8xY2FYU3ZLY2Z3b1Nzcmlhb09zMkY0Z2I3YXFzbEE1SVA0YU1lWm1sOHJt?=
 =?utf-8?B?WTVLTTcrQVpvN1BXb1IySEpub0ZRNTY0dThVa3RrWk9rVGVuV2Z0WG9PaU5n?=
 =?utf-8?B?eGdVVU4xbkkvSWZ1RXNIRGZndy9uNEtiZXF2QS9oWC95TXBkSEhxVUF1aDA4?=
 =?utf-8?B?TTFJKzgzVTB5NnJ4S2VMY3F4Z0tGbDFWbTRHT255TkcyMjRGTDJ5VjhzNlA3?=
 =?utf-8?B?QWd3UlM2UWVkWUpTbHRaTGNSb3Nwc2trTmYzZjBQSjFvRVU2RW9XYnltNisv?=
 =?utf-8?B?bWwzcU9RV3VYQ0J2a2lEMGZWRzQzTGdGTGsvaUlENEJBNnRhdXJtLzNLY1pL?=
 =?utf-8?B?Q0NsTlNJK3JlQzl6a0R1cnh0R1RqU3F0TCs0aEkxSlZYeWUrT1hmYmdBTDRr?=
 =?utf-8?B?STRkNHZ0UFo2MFdETjFsZFhTV2lWaE9oMG1tS1NkRHNHWThYTEt6UnNsM0JK?=
 =?utf-8?B?czVqeE9JMjlzRklRa1Y4QlQ1Nlg0N1lqcUtGclBuSGZvVEduM3MzU2Z4NUtu?=
 =?utf-8?B?NGVsc2NoYmZwQkZQeGVKL3dMaG1vRit4OHFpN1NPSzhwS1RxUFhTUDl6RHFi?=
 =?utf-8?B?M2FvVGtjTzQ5elRsTGV6eXhNT0QxR3JQTllOSDdUendtd2plNHVBc1FRYlh5?=
 =?utf-8?B?bWtRZHBKUGd4Y29YSndRbEY3L1FsNDhTenRIdHZJcGhUdldZNm1mNHg4VFBG?=
 =?utf-8?B?Ykxrd3g5LzNUK3Vrb1JnRHAwdmlTN0JNNGd4VlU4Uml6ZTNtbFJFMXUwRDFX?=
 =?utf-8?B?OFhQWFkvUWxpYVZiQ1FpeFcreW5BVzJJSGp3K2tLVmNRejhBaE84QkFyUkE5?=
 =?utf-8?Q?r01gGAPpEAZ+Ow0Z172K4dxc1KZz194ddDVd01a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c611787f-c24d-483b-5dd0-08d957d8d247
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:18:20.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jNCi6cemKXwZnVVJwppcZVOvvJCoRMkLp1lHG4Zl8IZVsakOMuJKV777/v/ZOlopjbLSZGDuzc586khHeAJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/5/2021 11:10 AM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 02-08-21, 16:06, Sanjay R Mehta wrote:
>>
>>
>> On 8/2/2021 4:02 PM, Sanjay R Mehta wrote:
>>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>>
>>
>> Hi Vinod,
>>
>> I have fixed all the review comments suggested in this patch series.
> 
> Looks like kbuild-bot is not happy, pls fix the issues and submit a
> fixed patcheset
> 
Sure Vinod. Will submit the fixed patchset.

> --
> ~Vinod
> 

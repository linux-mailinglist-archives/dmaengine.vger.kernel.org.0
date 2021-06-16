Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B53A99D2
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhFPMDL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 08:03:11 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:50176
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232814AbhFPMDL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 08:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSyvcPde87irasmsdDdgn0IkjJpIIIwa4tbvo8QT5IrB0P+7aaFfRDzFGcU604CwhRqJ8G2RG9Co1sgYk2mrwVQ6K0SJ++RnjMPX7SFhcvHV1/dPxPslqxrRIm6glBN4TljJCTcv4/tKUBtyPartGq8IdKV5NgAuYiJKVarjV7e+/qJSlbriTReoLOoVwnmkRci72Jnr1YBSync9kJjRhFq9kS2m8rkZ3Y5aKyyihkDmfDnFG+vV0QSa6IJTDgIzwg8LWxuTBKqeNt0Qp2kFcCrJXhLIb0LoEofdxQKHug3iyo1HHCutgxfcJWaBwqPVFBA4pxFABbLn12nFoNNf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5avxpUFob0tcUmWIgpkInCqs4EHG7GF9PdtITyEAEE=;
 b=jV6q43p21u4kB005ib3M1rL1dyj+jEmd0dWXTdrgGkoNxCLyy3jfcVIXKaqizHshWVIXDOebmIcWeP07wB1hHHCnfsyGlQkAcejH/1/sJw6Lqbuo5c9mu1MV5LDyciLTP6rvsmTPa+EMV+MtpnvnWyZuB4XSeYozl8vS7eHoOW3kW/pwQwf/dA0QLJFPrmZfXX3JM08sGxG/O4J3WRHaZd3QXAMSLHjrUun9+mQpsFsOKgK8lBd88Ktrina19ml9SCbKr421qWIMgfWQeGIOTOFWQ2m58acnXoReO6ljgz7aFWDASc0D8RD0DiilXCIDD1TMAtqMEr73IlzTaMjV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5avxpUFob0tcUmWIgpkInCqs4EHG7GF9PdtITyEAEE=;
 b=ihQHIwpHzfUG6nCZK3JycRCIX4RHq5CNRmXUZVMoBzyG+VY/9MB3HY5mA9aKX0vvDKo4FwNMbQNFddbdEJJD7Pp+LOBBryQ1UNOH/liQyfzyUYp9xyeYLHb7fh9cKf/0Ss9KPeqV8RBV/Wo90irpXruEKoobelJY2eUdmxyPChQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 12:01:03 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 12:01:03 +0000
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl> <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl> <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com> <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <627518e2-8b20-d6a9-1e0c-9822c4fa95ed@amd.com>
Date:   Wed, 16 Jun 2021 17:30:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMmt1qhC1dIiYx7O@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31)
 To DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by PN1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 12:00:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec77a814-7cd5-4dcd-5a55-08d930be6a49
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5478AF6B1E18624CDF876FFAE50F9@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmW9HsnuQyW7G6upfEgfWwjz45zuCz3XJn5c0mIQ/dGCJJ1pefzNdfKicIbLfgF2uuvQuv+EnMGDxGvta8f14P98Vij+2rnWNg98ubAae0sUkVjJ2S/xZMxgukgTFzUJG4NzvCDYt7Q/axPjQXwz9LZ8pdyMUVPpsBI0Ge8ZvGhu5nJX+WHDDVNFuaVMjqlRCswbiIV8jy3hoSNC+UwnsVSBUyeC8xKyt3TqVzGLWDDMgRUgUo+F/omHgKhaSgj/MbwvxDtN9CJdlDnvqDFwSv6BV22cLPJHgL4ZLrJ0uJMaANOwqQ9wFLfTLIzumxyrTqjZIHa/fBy3/+5xrB8de471UnUtCRtMix1BJhiSCfn1nMGrOF+M7a/SJW3AgXSOF2v6d6/ys2ijJRlvTC0NPeLHwCje2Spy3MyjuyYsPxC3yhazh0yHa02MumwqKqWcvVUD4bQRVb23CbjCbOLF31zeGwQt+7/mlccVmxB+wQ9ekeNda9mxIvhHAFUYL3nM9HdgCd4EbC8j3v7q8SA0mXFdxnGPeNjDGX2CNswlYc66bD0Tl30spiyuzC8vaULIiJAMk/7g9tpdljEXPXXir626dglVOCl23fOculhxowx6L3fn1vLYOAk+f4aM3YU3Q33lS+76IGlvMUQNTfVllMLJ/UYtIaNdgDtqUX+CKpQIh3IInHmHTUZ7uT0x2AoX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(4326008)(8676002)(66556008)(31686004)(6666004)(53546011)(5660300002)(66476007)(66946007)(186003)(16526019)(6916009)(6486002)(38100700002)(26005)(478600001)(2906002)(16576012)(8936002)(31696002)(36756003)(956004)(2616005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBUdGlLdzE3cmxNWVZKaDczaUY4bG5OSjA5ckNGelVWaG5pU3NJUkozRDJI?=
 =?utf-8?B?bkkzQ0dpTEJNbVhKa3QzdHEyU0lpbW0yWWYwTWd6Z0NsTHIrRU5ORFZFcVdC?=
 =?utf-8?B?bjdNaVZvMXVFVExXUXZrNWFYek10YjBuL0hYeUg4RmJXTXlaL25uUmZ0RU5t?=
 =?utf-8?B?QWhaYTVYWGk1Q3J4OGsxNWthOS9yQWxjVzZNTXNYZDNFaDVuWUxtTFM2eTNl?=
 =?utf-8?B?b2xJS1FSMmZJZjFSREFVZFp2OUh3TXJCclpFcDkwRW9xN1hoOXRtcncwSm5B?=
 =?utf-8?B?V0lwQnJBY1kxeWg5RktiSUdlR1BJdzUvT3Q3YlBOaHNxcXdmN0d2NzQxUVZB?=
 =?utf-8?B?SndFSmphc0thR0ZaL3JSbVFsZWdmWFNHc3dKTUd0a1UveXNpNlRjNXZ6OFUv?=
 =?utf-8?B?bnhEM2NBWjdBSm1Fdmw3ZVFJVFVUTjhONEF5OGttMTgxUCtjK21hYmFDWDc1?=
 =?utf-8?B?eVUxWVQwUGhuaWNCbnFKNVdqdDB1UnhycU9YRXFtUnhzYWpnVndETjd4RUZL?=
 =?utf-8?B?eUI5ODJYUGNuL21HbVNGQXVYYWc2cVM3N2NCR3RXVy9pU1pyQVJhaTJFU1Z2?=
 =?utf-8?B?SGYxOU1ScnVPM1lHRSsycE40TWJMbE9JWTY5ZnYvbVNKRXMvM0tlQlVYV3Vn?=
 =?utf-8?B?Y3p6ZE1iSmtuU1pvM2JqTUFia3BKV2xZdnkrYlVUckRpRjVWOGE0bnd4bGsx?=
 =?utf-8?B?SWZ4aTh5SnFCeHhMZ2RnYWxObzJXRkdGcWwxcVpsWnZESDBBbEVDK3IzS3Jt?=
 =?utf-8?B?MWFQVUxLdHg3VlU4dkpDVWZoUXdFOE1aOVV1dEMxZjBINU5HV2ZWdUp2UURh?=
 =?utf-8?B?RWNhUW1nQXBnOFVlLzBUT2ZDK1lSak1KMnMxUThhLzB6dDhjMkVMSnhXejZS?=
 =?utf-8?B?K1libEYxTEtyb0laWDhvREI1RldzUFNNcWdWTklCS21zT3I5VHU1UTFMWk1u?=
 =?utf-8?B?N0NJUFRnQlQ0a1RPZ1BtRkRPNDQ0NkRCZEtqaEc0SW53NEpxWW1GQ0dxT3ls?=
 =?utf-8?B?ZnQ0Zm5NK3JSUks1Zjg3dDFrNkpyUTlxQzlMdVZJWUhtYUxWOW1HYXdaVHVO?=
 =?utf-8?B?dmIydGI5ZnRmNGJFNUVUaCtXRHdJTTI2MFJHOGg5NVNqRXhSdlh0QUUvR05P?=
 =?utf-8?B?WWJIRHkwaEhlMDhNWGxHYW9ER3plR01YTnZkSndXK01nVTliSktZZjIxNEpC?=
 =?utf-8?B?YWpTOFJhaVVlZzIxMncyV1RrVjBpRTZHSXgrUWU3SjJHVGJ5UXYxSlZyM1lq?=
 =?utf-8?B?TDI3c2MveTRBM1ZrTWJXOFRGa3Npb1BLcEVvRXk0bWFIM2hNVlE2REFHQnRp?=
 =?utf-8?B?d2ZrMHFENkR4NVZrUTNORFZFRmdLdzBEMzJ4OVpMblg2SFAvbGpuNWtKZUlE?=
 =?utf-8?B?Q2Z3NTJJZDVPSHVycCszS0hjZ0p4VHl3UlpseTlJdC9nN1haNW5UOUJCcS9u?=
 =?utf-8?B?YUtrZ0xBRTdFWVFsRStwZW9oeC96SUR3bThlWkVocGwwMHdwYTRsQkNSWmpr?=
 =?utf-8?B?aHo4SDNpOUk2TWp0NlZoN2Q2aUdrL0hSYjVsWVNYVkhGdkNxM0tsNVZjM0w2?=
 =?utf-8?B?TnRWaEp2YWczaStucnRKdVMvODJaQXpHTzljMmdJZ1NGb3hWWjhSbmM3VnF4?=
 =?utf-8?B?eXE5aUJRdlg4bnlJVFhNZ3ljTTk0a0tYcTFGeGVnVDREcnA0RVhTUWNRZ1lu?=
 =?utf-8?B?bkJqdE8xeVdmNEM0aVZZRllqVXE1aFVySmdxdGhEVFZhQ0I1ZytZSkRSWGt3?=
 =?utf-8?Q?tbg/rzMWTMJOQ9HeEfJF1JkiYZFcDjNN3X22/pv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec77a814-7cd5-4dcd-5a55-08d930be6a49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:01:03.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akqzzDxq9txH0Ox+XJQQwitdU3BbXZBOUn82LOdPBKNTXMkyX3eVKa7cYN9POhiFME3OovC9UrOFU/l59VgCOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 1:22 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 16-06-21, 12:27, Sanjay R Mehta wrote:
>>
>>
>> On 6/16/2021 11:46 AM, Greg KH wrote:
>>> [CAUTION: External Email]
>>>
>>> On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
>>>>
>>>>
>>>> On 6/16/2021 9:45 AM, Vinod Koul wrote:
>>>>> [CAUTION: External Email]
>>>>>
>>>>> On 15-06-21, 16:50, Sanjay R Mehta wrote:
>>>>>
>>>>>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
>>>>>>>> +{
>>>>>>>> +     struct pt_device *pt;
>>>>>>>> +
>>>>>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
>>>>>>>> +
>>>>>>>> +     if (!pt)
>>>>>>>> +             return NULL;
>>>>>>>> +     pt->dev = dev;
>>>>>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
>>>>>>>
>>>>>>> What is the use of this number?
>>>>>>>
>>>>>>
>>>>>> There are eight similar instances of this DMA engine on AMD SOC.
>>>>>> It is to differentiate each of these instances.
>>>>>
>>>>> Are they individual device objects?
>>>>>
>>>>
>>>> Yes, they are individual device objects.
>>>
>>> Then what is "ord" for?  Why are you using an atomic variable for this?
>>> What does this field do?  Why doesn't the normal way of naming a device
>>> come into play here instead?
>>>
>>
>> Hi Greg,
>>
>> The value of "ord" is incremented for each device instance and then it
>> is used to store different name for each device as shown in below snippet.
>>
>>       pt->ord = atomic_inc_return(&pt_ordinal);
>>       snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);
> 
> Okay why not use device->name ?
> 
> Trying to unroll further, who creates pt_device? who creates the dev
> object under this..?
> 

Hi Vinod,

The pt_device is allocated and initialized in the PCI probe function and
then we just get the "dev" from the "pci_dev" object and save it in
"pt->dev" as shown in below snippet.


   static int pt_pci_probe(struct pci_dev *pdev, const struct
pci_device_id *id)
   {
	struct pt_device *pt;
	struct pt_msix *pt_msix;
	struct device *dev = &pdev->dev;


Thanks,
- Sanjay


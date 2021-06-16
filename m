Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AB3A9B29
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFPMzb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 08:55:31 -0400
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:61905
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232879AbhFPMza (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 08:55:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7wpCoV0E1ZCPGL9zHrdN4yf1+xkpsCIMaWKFZ5GwezATDenDTXPnuo1a2PpFgmmyBclp929CjwFF7Qdds6Bvj4LGi1KSJtJAdSz3QU4YeICxWDzkxwFG6etDRBPZE1QpIDLWdFkoD9kvdhkb+b4uu7SCB0Y0S74PhDGh4n+DMtBIBsCBuKQwRvm9OOl9GKzziAhQNaeeWXCoA/7Xprd/Ys8FwD53GKt1ucxM75l6MsTrFvBGuXXUUvaStcw9MioLUXXHGnbebWXTxsVfOel7efMT9DPMCiUpxebygztcKINUX4utOC9h1X5S0HlQFO0jr04Fz0wiYawPQIeZoQKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaRc2VwqOn/Dgun91Jjs8d6f3V3bGXxzaB/VJXiJ/GA=;
 b=l5Se6OGpd0dK00j1R/HA/yV3xIQaeprGNBWub4PZNL0MvHFyxuz8zcpUpEH4iJC9HHwx2bDl3CVQZgJzklpunLjrQV0wq5RIjPFPMQpatQeL5kcLWNgGel6il9WeB387/2XpRAyauaYGgmw+uMbKFlpS5MiU1Z2xE7dIqv8bpqeqTg4RTbJBwvZf8qAa2STddmAbzsMx2+h4e/ST3QlYUA4jvL/0vQMNOJY/ShkLhUHQBYxgkOnYMzlemIVZxDPmvpkhjEHmiPyhBufF1rubrcc/rzQ70CYN24nd8oVN+JC8GhukVvJi3mGHJHz3zqBd5TqdYjlBpQvX/0/U/+fKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaRc2VwqOn/Dgun91Jjs8d6f3V3bGXxzaB/VJXiJ/GA=;
 b=1yexwMSPxdVnBkZ3nxlZRNDL36EA5LxDTXQl78RL5wJ1QODUU3276mHBaSL4MO3vyOlbqLIgmR1H9DjA5YilDVwHeuKbjLSk4yWY0VQEUg5LsuZUROwj8WaeTcwC+LIbU/v6/d++kzUbQJJYq7wjtFQn/pGKwdfNuz/o6FhIvWk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 12:53:23 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::e065:c90b:5f7:7e95%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 12:53:23 +0000
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
 <YMmXPMy7Lz9Jo89j@kroah.com> <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl> <627518e2-8b20-d6a9-1e0c-9822c4fa95ed@amd.com>
 <YMntRILEO3ceyeZU@kroah.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <0221d964-1cbc-c925-133f-40c3eaa11421@amd.com>
Date:   Wed, 16 Jun 2021 18:23:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMntRILEO3ceyeZU@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::32) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Wed, 16 Jun 2021 12:53:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd2c8c5-550f-4781-3372-08d930c5b9b8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB508694EAE9084CDF6C044543E50F9@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNfmN42BQdh45ZiIz04Zhagt6cITX15cx105GRt5i2etCwUqM+Wv4l4feeZAI2bUTXFYQFKibio/AzkH9WNp/jKT11QtdPbmG0y/P1sw3Byl/2SW167qQKciEF54Wi67SBvhX3raXr3k0AfosvMkW8VWBYt6zXNlin4ya8pEpUTnt3ncTJH/aAgnRmMoJKRH5Cpc557xQktNjwE2S790VSnTtE0WP0nsgCCnFgFRoxxAOQmERAKaGKKi5k73JelBpVpwjpHs3tVDNKV/P5MS60evCYvUYzHgPGYf5qaJSjmKoFpx1IAw/En8FIQyx+22hjPSQdmDlBj4WSeTbW4cQDNJ3gCRISE1OMd0LcX4738sz8PaXeQ0ifq5zCrLP3bvzE2+QHs/020QieDPJqs/H2ROPKtwJRLqSeAo3daqRlcqFgtgkoOp0zZ2In3TIC6s8lKLqII5iLrKaR5dMRylVInbnZ6zo//dGPnowUr4wV/TJpGObl4NI0d7+5rhPTF1KxipBFSvG1YGziMCjgr7XtaaJJJhie7Ldp8SMyKBpScqaT5ygdt94QStHEu/Au2QsyVRIPBJw3jMtA30bYMmnGLuYnSVEJkqPFSBnK+Fnfx7pgRvzxd5kTBckR9HGGeo8JtTV8WEjVWhdgkkAssyZBIogCKjgSWLvwT6CBPM4mLgoJe85kyPvSRTnQ4bhaJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(4744005)(53546011)(38100700002)(478600001)(31686004)(956004)(26005)(6666004)(6916009)(316002)(5660300002)(2906002)(16526019)(16576012)(31696002)(54906003)(6486002)(66946007)(36756003)(8676002)(66556008)(66476007)(2616005)(4326008)(8936002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGUyVkdUVlNqTG53blBsUUpiM3d3ZldLK05pRkVMY2lGY3dYaUxyZkpMbUVE?=
 =?utf-8?B?Q3IvNzl4UHI5dFpwdkhUOWxGOGo3bkZNMG9xQjN6Rzl2TjF5NjBpWnlBRmZ4?=
 =?utf-8?B?aUNKU0Y2cE1QNys2OFNzcWtCRlAwREpBUG9Ib1cyYUs2SkpsdFoyNnVMNy9G?=
 =?utf-8?B?WmhpYldVdFJmZ2kyT0gwaFMxWFRWdDltSTN1NnpJOW8yRG9LamJoNXU0eWpH?=
 =?utf-8?B?L05hbkpkVEowc0pGUDRZMFM0U0o0SFpMMGtzSTMvU05YczZ2Qi9DZ3lGSlNU?=
 =?utf-8?B?RFFUMVZRNU1JNUN5VEpkVG93VzlLVFZmcitkU2JzL1Z4aThSM2w3cTAzOTB6?=
 =?utf-8?B?NERnWmdkR2tXY0ZzNU1JcXdYR050dzgzUW1ZaDJyOThFcytwMVdvZ3hlcVY2?=
 =?utf-8?B?aGh0SDB6V0VKNXFNZkdVOU5KL0tFR1pUYVhmOFEzb0t3TURvekRqWmpOYStV?=
 =?utf-8?B?c0U0SDByUlA3b3JTcGwzZWZ6cGJUOXFGbGkzMGUwWFhTcWI1elZlb2RCM2xh?=
 =?utf-8?B?VDZ6d2NSQVhGMXNyZE5lZ3FmMk5EL0VRK0dpK0R2blpJUVIySUZacms5U0tR?=
 =?utf-8?B?N2dSUDJrL0dCMzIxYjlyRzlqZjF0WGpvbUdCdmNQZXBvbWd4OXI2ejJFamJW?=
 =?utf-8?B?TnlveEhiVnFwdE4rVUgxTmpoSngxeHZWWnB5eXVUTlhGVWU2S0RkSE5ZclpH?=
 =?utf-8?B?Z1pQNXpOSndYb1pCd3pmTnRFVDNvZG45YjUxdk1jdDF5ZHNCZ2lBMGx1Y3BI?=
 =?utf-8?B?R3RRQ1ZFYWgxN0hRUXpmYUQ1NDRYMFI4QzlSeFF5T3plSE9oTEZycE5yamlY?=
 =?utf-8?B?YUZkNjFrcWJUdzBRb3d6YTdqc201WTNkays5N1B6bE9xQ0pTekF0VlFiWkJT?=
 =?utf-8?B?cXN3T0h3UEt5SXZLVTY1aDh6TStBK0NVUm1qUGNzWXpSenNVeGlNYk94K2NL?=
 =?utf-8?B?SHdsTXdKRkxCcithbCs0MzdGTU8vRXRhYko2VWxPVmQ5OVBjSEw4UjV4TVNi?=
 =?utf-8?B?d3lyOHNKZDBJZEdaYmVOQ2VNNWNTenZkcjg3QVFQZ0h2TEVYRmNRSDVxVkIr?=
 =?utf-8?B?QlVJMVNuMzRveTBsNnZXOFc1V3B5SUowWjVMLzc5R1FpcDQ3OW5uMXNkUkl1?=
 =?utf-8?B?ODlydXM2ek5nQnpBTnhRQk9Eb3FGQ3l4Nmp1RERwaXhaNGZTQW5DUVhoQUtV?=
 =?utf-8?B?cTVkMXhMQ1Y0NjYxbWdCWmE5VVhIb2VCQkROUVFhN3IyeHk1bE5kMitJSkVz?=
 =?utf-8?B?U2wyNFZER21hQ1VQeE1VUUltMjNtU3hybzJuVHJYa2dHdDFpMThnR3BoWUNy?=
 =?utf-8?B?KzRmT3oxOFRRSWQvS0w0ak1qMWhaWEVWNVBaS1pudkhTcHltaW5WaVd6SW9l?=
 =?utf-8?B?U2xleXRBUFp5NnpmN1NxTU5CRjN2d1o4ckJmMGxKSGhBNzJDYURPUkp0bVRR?=
 =?utf-8?B?ejNZV29oYlYzcU4rcnRxZ0tEVG43YVZ2cnVsOFVXV1R6dEdvTGVWbVdOYmJ4?=
 =?utf-8?B?ZDI5ekgxT0NzR3pKZzd2bGlHSTRqek9ZNDFqQ0dFaGg3dEMweWEzOGhScmtO?=
 =?utf-8?B?VnRIUVc0elFZR3l5V0hvdUw4VDdsNDZENmNSb3lNclFRU1NibFFuQnpSd2Na?=
 =?utf-8?B?emlHQjc5ZTd2elg3K0hrVDg4MUtuTG5JMnFyUGpMay8xaHlZdk9JWEFodnVi?=
 =?utf-8?B?VkRGbzRjdk5nbEZzU25YNXA4Y01jNlRXak1xUHkrMlMvK2lGczFNV1VPQ0lm?=
 =?utf-8?Q?j1MkUFKpTd3MRfvUusPOk6JppTjOfZOInZ/Py6J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd2c8c5-550f-4781-3372-08d930c5b9b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:53:23.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N44c9HfvJH7eujlIo44nXB4WFQhlLXizN9Q3BFiSQ276eG8jmOQLy1z9WZ/OOkqlW8Jy9ELathTi9rUyiUbWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/16/2021 5:53 PM, Greg KH wrote:
> [CAUTION: External Email]
> 
> On Wed, Jun 16, 2021 at 05:30:49PM +0530, Sanjay R Mehta wrote:
>> The pt_device is allocated and initialized in the PCI probe function and
>> then we just get the "dev" from the "pci_dev" object and save it in
>> "pt->dev" as shown in below snippet.
>>
>>
>>    static int pt_pci_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>    {
>>       struct pt_device *pt;
>>       struct pt_msix *pt_msix;
>>       struct device *dev = &pdev->dev;
> 
> So "dev" is a parent here, or something else?
> 
> If it is the parent, please call it such otherwise it is confusing.
> 
> If you are creating child devices, what bus do they belong to?
> 
> Can you fix up this series and resend it so that we can review it again?
> 

Hi Greg,

Yes, "dev" is the parent here and there are no child devices created.

My apologies for not calling it rightly.

Sure, I will fix up this series addressing all the comments and will
send the next version.

Thanks,
-Sanjay

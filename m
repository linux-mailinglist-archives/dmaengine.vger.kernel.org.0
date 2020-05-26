Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04BE1E1B70
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEZGgw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 02:36:52 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:6224
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbgEZGgv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 02:36:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCPYz2zAry7y/hXCEifHcEl7CgrpJdx+WO4FijJhRyzZi1TibUkCW1cqT1zmPUbU3wBX05N5LHoApuueF5KS568IFqxunB7f1lLMAkOZH5lefl1WK1vl/HXogF/aMpkXzhMAzfBE/7Iak/7WMd9ZIWXEIOM9J6q5hxwa922/2dfW/b1PR+DvokBkSUeUw0Z56SEn/4a2cuP2jxm7oRRHdks12CZsTxkLQT/SvN0TS8+y0iz9vkZq4DRPIiRrC12H0uGeiK22E5lqio3mehCkzdi6v8UrYaHqiz0Bo2wTNfUc/EUCYXEQ+ZfpdMux/xRrA0Jg+YYTw9LHAG5UB4MmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Kq2Oc5nROnehSLmhDMOwFMFAMsC7r5+idwKy9FYqs=;
 b=Zr8teT8VVMiSjtjWp2emWj/I1NEXg5388H2OiSYZNN1q0zPntmy4/kTg2db9BUQa6C+tMoMLBI8eSIHqO+trIWX4mduN4xdgOoKvmfDjT/rHUAsGRRy976E+LOwidEzfshsrrg+BjVoMJ4gypvOYbex2Hp4FLnHgVzDW7tGusXofutqiop9J9NREAZ+1YBx1ryRIodBVyTwk6xY05/hXgbAC6zcU0cUgVR3BmmKLCqAIUhaOD0BX5eRrGVzCtivnbphZdCEvU+RvnJ12YJnIl1ZpVp7qmUte7R751o2mjdX4sVUM1tYzniwTdMHl6TuEsCzKci/IHnM8Xm2bXYiZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Kq2Oc5nROnehSLmhDMOwFMFAMsC7r5+idwKy9FYqs=;
 b=2xc0jw9PipLr9s2vHZv1OvDuvtgJrq5agyKtM5zoc4v/8TIIMLc9cNBEOyNSPQnKLwLHcx5Z+HVHNHr06Vv8XUtCFDCB0i+M8m5ZJ7cmeOI5bmXR1M01HEZh0gm2HeIedh934kkS2hLh6WR2TUJk7GrQJgtpyt18tbZdCmTIxrg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.25; Tue, 26 May 2020 06:36:47 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 06:36:47 +0000
Subject: Re: [PATCH v4 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
 controller
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-2-git-send-email-Sanju.Mehta@amd.com>
 <20200504055539.GJ1375924@vkoul-mobl>
 <f016a02b-ebc4-6280-dff4-25e189ff2d49@amd.com>
 <20200526062911.GA2578492@kroah.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <f2bbbaf7-3b4a-6dfe-6683-1c14c18b3adf@amd.com>
Date:   Tue, 26 May 2020 12:06:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200526062911.GA2578492@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::15)
 To DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:7400:70:65d3::1] (2406:7400:70:65d3::1) by PN1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Tue, 26 May 2020 06:36:38 +0000
X-Originating-IP: [2406:7400:70:65d3::1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0e861c7-0919-411d-2567-08d8013f29e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3753823C97524C2AE6303989E5B00@DM6PR12MB3753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ed6tDzT5Al8Atq+8gK759a4yg/eytKqB1gp8Hxi2mr5quoWzyeYQo/zHpKyzq/mfygZXPoDNFh5jIxJLM6MMrIzO3qLoZJE54mqNl0qNUMDZs9osDLA0wTQK1v9eM4wMaLJozw4f8Qc8NLt26v13obVyfwCdGaimtujfMZ2fTJGVj3D/xrX40jY8U4Whm/6o9Nsm9IbN7ZjF5EOR4diR7nq8EHg91qxzerN7jKXKyxz7EoxuiyHaqj2LmDCs1hf+meyaJPn3KxjqQkc/0ZjCyqW+EowOeXK8+ev5hcE/IwZdj9B6hzJBtfhPQMHOhzo5DyEgYw8BA8T+ayD3txjhRSifoHNMF5JlS3QCV2wzqzMsXvOO8xV69Ds9U6/gj5Gc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(66556008)(66476007)(66946007)(52116002)(6916009)(6486002)(6666004)(5660300002)(53546011)(16526019)(31686004)(186003)(316002)(8936002)(2616005)(36756003)(54906003)(2906002)(31696002)(4326008)(478600001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hJ0jPIoto7Akim4MIGsHG09V8Dv9qMDqlmP7idJWE9MOJ9ktkRiITd49GqNWFDoqxWoPCwVGqEfTjkyxJXUtbORy+SQoM+F1ESC4BlW0MhwJIeTG0KA8Dk3HRYf/pem1MMWfuiX50dTCR8PkTOYR2ZJ4HRPiqOu7Ii0NGNyZDAU6JjbRLLcx4wBVyzSvolTGfIZIWCV5F+wUrTl3brAVojQiHpwCr8inHcFXkDRfnGyxGs7hLbowvYKXZJuc6Hv3VUoC4Kh0tE0RGHaTyJ+Pkn9HLFg9WUmycjwJBGG9RcCOf/twxkbytsJm12kprZGtsiSkiA4oeG4jzN3iDYIezWferwwIF/xJwsHI7JEyyfBKwTzjztgS1tQsE7V1YW9wK3zQNSCz4Fq0o6jnTjPCZlNs6Xlvtc/oiXLOHLipfp7WT+rJh8CvyX+3oibq2DJ7QFICZ22SVVRX47lkXdjPusBK4g7nkH1l8cJWvwGs2gtTv8EwRH5Ic8e4ka+waAC7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e861c7-0919-411d-2567-08d8013f29e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 06:36:47.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLka7EcREnTFnUUkLAQD+tlx9JupIDKcP1T9+oj7c7F83tnfeh38dUfrplJge7ALqoO2/ueeMoHpkOvWMeshvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/26/2020 11:59 AM, Greg KH wrote:
> [CAUTION: External Email]
> 
> On Tue, May 26, 2020 at 11:35:02AM +0530, Sanjay R Mehta wrote:
>> Apologies for my delayed response.
>>
>>>> +#include <linux/module.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/interrupt.h>
>>>> +
>>>> +#include "ptdma.h"
>>>> +
>>>> +static int cmd_queue_length = 32;
>>>> +module_param(cmd_queue_length, uint, 0644);
>>>> +MODULE_PARM_DESC(cmd_queue_length,
>>>> +              " length of the command queue, a power of 2 (2 <= val <= 128)");
>>>
>>> Any reason for this as module param? who will configure this and how?
>>>
>> The command queue length can be from 2 to 64K command.
>> Therefore added as module parameter to allow the length of the queue to be specified at load time.
> 
> Please no, this is not the 1990's.  No one can use them easily, make
> this configurable on a per-device basis if you really need to be able to
> change this.
> 
> But step back, why do you need to change this at all?  Why do you have a
> limit and why can you not just do this dynamically?  The goal here
> should not have any user-changable options at all, it should "just
> work".
> 
Sure Greg, will remove this.

>>>> + * List of PTDMAs, PTDMA count, read-write access lock, and access functions
>>>> + *
>>>> + * Lock structure: get pt_unit_lock for reading whenever we need to
>>>> + * examine the PTDMA list. While holding it for reading we can acquire
>>>> + * the RR lock to update the round-robin next-PTDMA pointer. The unit lock
>>>> + * must be acquired before the RR lock.
>>>> + *
>>>> + * If the unit-lock is acquired for writing, we have total control over
>>>> + * the list, so there's no value in getting the RR lock.
>>>> + */
>>>> +static DEFINE_RWLOCK(pt_unit_lock);
>>>> +static LIST_HEAD(pt_units);
>>>> +
>>>> +static struct pt_device *pt_rr;
>>>
>>> why do we need these globals and not in driver context?
>>>
>> The AMD SOC has multiple PT controller's with the same PCI device ID and hence the same driver is probed for each instance.
>> The driver stores the pt_device context of each PT controller in this global list.
> 
> That's horrid and not needed at all.  No driver should have a static
> list anymore, again, this isn't the 1990's :)
> 
Sure, will remove this :).

>>>> +static void pt_add_device(struct pt_device *pt)
>>>> +{
>>>> +     unsigned long flags;
>>>> +
>>>> +     write_lock_irqsave(&pt_unit_lock, flags);
>>>> +     list_add_tail(&pt->entry, &pt_units);
>>>> +     if (!pt_rr)
>>>> +             /*
>>>> +              * We already have the list lock (we're first) so this
>>>> +              * pointer can't change on us. Set its initial value.
>>>> +              */
>>>> +             pt_rr = pt;
>>>> +     write_unlock_irqrestore(&pt_unit_lock, flags);
>>>> +}
>>>
>>> Can you please explain what do you mean by having a list of devices and
>>> why are we adding/removing dynamically?
>>>
>> Since AMD SOC has many PT controller's with the same PCI device ID and
>> hence the same driver probed for initialization of each PT controller device instance.
> 
> That's fine, PCI drivers should all work on a per-device basis and not
> care if there are 1, or 1000 of the same device in the system.
> 
>> Also, the number of PT controller varies for different AMD SOC's.
> 
> Again, that's fine.
> 
>> Therefore the dynamic adding/removing of each PT controller context to global device list implemented.
> 
> Such a list should never be needed, unless you are doing something
> really wrong.  Please remove it and use the proper PCI device driver
> apis for your individual instances instead.
> 
Sure, will incorporate the changes in the next version of patch set.
> thanks,
> 
> greg k-h
> 

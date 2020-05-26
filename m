Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2624C1E1AF3
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 08:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgEZGFU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 02:05:20 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:39008
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgEZGFU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 02:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXFbbJmVFUIdNI0EZPkpwXa/+PC3UDpLAdhxm6r9dDxh+43hpdfHXMru0wDV518kX2piNHNo5g7ZMy1FDGTWIDWFp5ihtFN38iHTKgDtk67y+0rIQzJSCUUQZx+7lSRimIzZ+5cZG7F05eHuRZd4ca94l9s71gYhK7g0VsDH395CtxS2GZda/fHTnR7aVtWZznsldYsFZseCAkJSpjhMWnVeqNEUEDSVSUbQ0t5aZxeQ9yRDM0GMnfDB5+kc35CKOM2Z1zsLr1mV+8DeQT9KlMdrdvubAXqL+n42Xeagjf+qw87q/g5NXBictyR5kk9eGE5WpsK6wook4BK0WwevpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUa4bADADBOhG3tCpkfSCKHPyQ+8tJ2lloe4Zb75FG0=;
 b=aVCEmomzlq9CIzIgKpt+G/4oW7CRyRzbU43BrMXYBhRcUGN914sICcJkr+dcV00w+S7+S2P/vztgiDiCDxX8R/G9TCKfpj4zKQCzXtfBESUTZxAwu3KGRnI3l6ifsiRzjr06kHmx6Gumls3yA5a+u4phYZKHKPnAphkO51QGC2/eaW6P4r+IJO7b3fEKbWF5+bO4GZgp5h6OqgNhYgTDaAK1RcZNGrUr03LZ3AFH3QwO/jIi3UlpynK0KZWGG83qr/xsWg+tDWb0NaCqzP0VxFtFSPrATkc1Zzy6n1pVTA5n1c+26h0Y0/L80wxmdNJE0gXURFUN7fkzyPraS4QHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUa4bADADBOhG3tCpkfSCKHPyQ+8tJ2lloe4Zb75FG0=;
 b=FV3TTSZUSSp9xPXl/DNpN1XUYM7tY6QNrDbym1N6T4phn0AFa9YpMtYsOOLxLYiY8Rp5Br2DqRs6HW6Mo1nDy+F6Nmw9P1ocXXI7yt9XKL/I7fyZP1FU39BkN9BeNlkXv93InXfezobZu39tyE5+6ZyawDoZ9v5mXgcoJQ+2Liw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Tue, 26 May 2020 06:05:16 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::d007:1b50:9d7c:632f%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 06:05:16 +0000
Subject: Re: [PATCH v4 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
 controller
To:     Vinod Koul <vkoul@kernel.org>, Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1588108416-49050-1-git-send-email-Sanju.Mehta@amd.com>
 <1588108416-49050-2-git-send-email-Sanju.Mehta@amd.com>
 <20200504055539.GJ1375924@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <f016a02b-ebc4-6280-dff4-25e189ff2d49@amd.com>
Date:   Tue, 26 May 2020 11:35:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200504055539.GJ1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::33) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:7400:70:65d3::1] (2406:7400:70:65d3::1) by BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 06:05:11 +0000
X-Originating-IP: [2406:7400:70:65d3::1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4ab657e-1f81-470e-9223-08d8013ac2c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3291146FF0C79538CDAB212EE5B00@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4TV7KPNmXR1yx9MFvC/TusuVAZG5iTHoywfKup/Q/d9ujIT323VHHt0DWdGZSbIyvI57BQGm/qh/iijNhRj3aGjb3G52dY60s1ZP0HmqwG0+egVkI4teIRgK1miUgTRuwv2pLTcGAj4YrByWqHUyJJDgBj30AwaA6RGb+dxYXdMcsAaLW0iNUjuluEYfiVq8gnWm/uUqVdzbY5Tlap/ZE84nREMluHkMmu3zZwpkQ7Gbtbd9zgixOVQ9t04++rZHdopjH5Io/slb6mEgr8ur+y143/POiXPNiCP+4z9Op/2OTCgvp1L90hPs4PcLY45d/1WoslbpmkPnqUXS3vof73tBYSnmNNE5cvHdq0NPK7mMuwsaqlizgnyx0sJ1wwc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36756003)(8936002)(2616005)(110136005)(8676002)(316002)(4326008)(478600001)(2906002)(31696002)(6666004)(6486002)(6636002)(66556008)(66476007)(66946007)(52116002)(5660300002)(16526019)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EiOgUr4hXwUQ9TvRAZEjnqRnUXz7jtH4dH/D3ZCgTJ9c7sWQsjpc+kkPNaEN6WbW74leVtIfqNK18GJYsXJBDM/OwDJgwktGejP7eTLAaDZWslgQCoh4mfeRiKykOPwfLm1o8ztb3Sguvx+4KLy3Brj+cN80mKLxSW1qxyg7HwDz1321RUVoMtbO4TdnlzuhRMNhxI6kbjLAUSQWe7Y8rxu6vAlJW6dIhOrNEYNGyiX9v0c6g4/Coz15XaIlBVAbyW/gRVFN/qlzfx76nyCe0yYT58o5e6crWwC9U4iZqlgw3DDjPi4RKB3cllDhILBdKrqo38CW2xqVb8MGCVwB5u6MM/Ye2tNRnidOqvpmCTVr2lPzqCVaPqh6prcI+xxH5LKuAfXr5D5/E2ra7u5laJg8QLzgU3oVXkigWfWuGrsbQJaJe6sstR3L7KwlBcp3SW4VZE7hxbwINCdGYezFAYBc2ChwxTNFLX6iS/F9eaqCm5p75DaKRomYae31vZMp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab657e-1f81-470e-9223-08d8013ac2c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 06:05:16.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH/rYTItsNGn/vERn8FT/gBMZIviXNy4+l8tdNtoQtGyJ9TzHVzlzkxiAGRPmpoZ33Dwd3xrTooju39Gi1yXMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apologies for my delayed response.

>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +
>> +#include "ptdma.h"
>> +
>> +static int cmd_queue_length = 32;
>> +module_param(cmd_queue_length, uint, 0644);
>> +MODULE_PARM_DESC(cmd_queue_length,
>> +              " length of the command queue, a power of 2 (2 <= val <= 128)");
> 
> Any reason for this as module param? who will configure this and how?
> 
The command queue length can be from 2 to 64K command.
Therefore added as module parameter to allow the length of the queue to be specified at load time.

>> + * List of PTDMAs, PTDMA count, read-write access lock, and access functions
>> + *
>> + * Lock structure: get pt_unit_lock for reading whenever we need to
>> + * examine the PTDMA list. While holding it for reading we can acquire
>> + * the RR lock to update the round-robin next-PTDMA pointer. The unit lock
>> + * must be acquired before the RR lock.
>> + *
>> + * If the unit-lock is acquired for writing, we have total control over
>> + * the list, so there's no value in getting the RR lock.
>> + */
>> +static DEFINE_RWLOCK(pt_unit_lock);
>> +static LIST_HEAD(pt_units);
>> +
>> +static struct pt_device *pt_rr;
> 
> why do we need these globals and not in driver context?
> 
The AMD SOC has multiple PT controller's with the same PCI device ID and hence the same driver is probed for each instance.
The driver stores the pt_device context of each PT controller in this global list.

>> +static void pt_add_device(struct pt_device *pt)
>> +{
>> +     unsigned long flags;
>> +
>> +     write_lock_irqsave(&pt_unit_lock, flags);
>> +     list_add_tail(&pt->entry, &pt_units);
>> +     if (!pt_rr)
>> +             /*
>> +              * We already have the list lock (we're first) so this
>> +              * pointer can't change on us. Set its initial value.
>> +              */
>> +             pt_rr = pt;
>> +     write_unlock_irqrestore(&pt_unit_lock, flags);
>> +}
> 
> Can you please explain what do you mean by having a list of devices and
> why are we adding/removing dynamically?
> 
Since AMD SOC has many PT controller's with the same PCI device ID and
hence the same driver probed for initialization of each PT controller device instance.
Also, the number of PT controller varies for different AMD SOC's.
Therefore the dynamic adding/removing of each PT controller context to global device list implemented.
> --
> ~Vinod
> 

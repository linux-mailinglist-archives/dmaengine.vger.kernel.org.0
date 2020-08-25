Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0C2517B4
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgHYLeH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:34:07 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:30081
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgHYLeG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbCUBNSH50axq+yjXKWYl3QsywGGGbuT9Ekry2cSZvAWq79mGrpthVsrL+zoJrQPDdzX4Vp14rZ9QE3Hzurgv2Og0ZSgBXrJ4rUDkeN/CrM/EVmK7laI3xHL5gXUOYewv9f44Njyhdg1EyVP2Sg9doNZjPPll49kf6DcY6UTT7JNzEShlHHlDfAfRC1GjKJNEskzzDpZ/sch0OQR+GQjopmq2xnG/AO3UuoszA5vvk+1wLnT1dgMsumKPc0z407e4Jj5q8Ahzfw085erQLUBcp/IYPxulnyVWH4UUtzkkwugMGI4+DNQRSFqVIMIPwAp5/9kM1VEhM5M8fjdU3y7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsgYUm1SttPoXuoYXy+c9CP+h9MziHt/7U3f9XGzFvc=;
 b=FH1tk/hjn/8WI6vCDXhrb1ozC/PqaZtCwndc+6vuGYpTozGdDGFJlSrlZ3ImB0a4TY0ORrEXf/e0bSsDhfwaHGaWtCZhkC5DW4rdZBV3e3M4d8B8PDEIUFChxVQUjIBjywokGPi3LzDLe0Kft5wMroMLvufcYHJFR07pcBOiFgo1inXKMzFu0GP0rE5qXy1pr0svUSfyjQKTBC72N54SxadfvdeL/ugMM4OVCO2jU01SyL6SSJxv4D9sOArWwcpY7pdlYY4hkh1twOnbnCiMHYjLCf7kVVdhQaNmmurHnWLLojcrh7xtLNzJkMddj0Ga1RImdH2/G2WzkYzOjOZCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsgYUm1SttPoXuoYXy+c9CP+h9MziHt/7U3f9XGzFvc=;
 b=Zp5It0Ag6Aefb6J5DbgF5J3jmUvbFCWBOy2iLk59rafV+U1hDU2PnnWRWoAqGh7amWVjlG+6yXeFDtcl2su0lh5iH5fWHYNAUZaGFZ3/zvIIlUdwSDon8/+pkYM5zP0nGbxebwuDZajQNiFa9jTigYzXse6+zl3pAfolcQJaNy0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 11:34:00 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::b5a6:78c7:bdd1:543%7]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 11:34:00 +0000
Subject: Re: [PATCH v5 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
 controller
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Naveenkumar.YA@amd.com
References: <1592356288-42064-1-git-send-email-Sanju.Mehta@amd.com>
 <1592356288-42064-2-git-send-email-Sanju.Mehta@amd.com>
 <20200703071841.GJ273932@vkoul-mobl>
 <19b20b55-0748-fb3c-755d-87ee6bdccf48@amd.com>
 <20200825111659.GM2639@vkoul-mobl>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <9f1abb41-84d3-4e8f-3efe-f708a33aec85@amd.com>
Date:   Tue, 25 Aug 2020 17:03:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200825111659.GM2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::20) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BM1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 11:33:56 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a8a4a91-ed05-42d8-76a5-08d848eac2e8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073089822C02EEC4379B19CE5570@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XvEBUwP3Rmgm3uOta+sW45AmUZ1K30jIOko+p4+bRuwAcinP9ODxC2MlfaIl+bv5Km7uYtEUJnOyQxsZDRrsrmQi4uwoXmnnMxmNntuBpQRI1Enmns3Uyc115CXuXilu9UqegPl4CtcYNAVWfMKB9irbe3UTe5XkwIoOWxmZgjNaiFH/eSX5+Lze+9KwrnpEpKm8HQN27ccJwJlRZTQO628H/CKvuVQQh8E3m2jbr4+S4knJCjr7hLzeslO3TjfP+vMJvuivEDzo6E1OAJ6Gcu1vk5XyzoEzyLI8Y7vHh5vCLfyzG+gMp/OsRqMWxgKujjLUByQqv4AyD2h9FXGtskUAfdqcIJcj7V3GDtIANwOwOWlHJ7hSUBGpFblzkv3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(2616005)(5660300002)(6666004)(53546011)(186003)(8676002)(6916009)(26005)(316002)(2906002)(36756003)(6486002)(4744005)(478600001)(66556008)(66476007)(956004)(52116002)(31686004)(4326008)(8936002)(31696002)(16576012)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: U8CUTRteTe6dMu5erUqfwIDumdmw6UsKZ8wudSm38uCAF8t2EaH5A0mHELJXcn9OE8xym3dSJ4hRytFTZDwq5SXeOZV6NIwF/jiaWVVCqdNprg6t66iyaQ7rzLudIUbItlyrls2aytnNKwvtOlLjSvfoIct9gjGQcd5QjGaXpqkdLxY6sl/eBvYMh+7v89de55xtes8VV0MbLRz4yrEmNuh+L8qtUyRXJguMoRXz4vOXdp0WGip2tWeQ5xxsO7F9ESmtOsMD5rliAf2F9Hg0Db2k+JnEaywYglqai3mLMxd2JJlWntL1IqPHC9awp9nnlMTpJSdLJ0vIn0pskeqlsqBUwpwjvRf09jhBjUzPc8ep0Fqy+iaky3ogypKTrvsMO7+lijBiB6uKOdu6J1HF101+9HiPl5blRXsXcN7BGqfiQBeuTu+IUnLG2HkNdfB2NA0PuN2PPvT603QL9CmUhYu/lLsXL3+oFe7uWg9UdqClkvUt3keGTWImSsNViIbb1Syb+hlFFh8FRV322j6YXsDJ/MlY+7XbReocTHkRUUL/SR4rB4sGKh48xzEuEh5qz3uQ38EbZoH3tDsReoGds+izLwYrDV5SGMt2tQgq206Bn1D/RlqV5yy2PuOU04VspV1H/6DXQarx14zjgu37rg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8a4a91-ed05-42d8-76a5-08d848eac2e8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 11:34:00.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFP0paTBj3VJJ53hIU6uOsKyX2e+eUe2LprnbxXKPrw1xvv506VuH0/o9X3qFL0NQTwJQKnB+cZSNy2iKz5QyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On 24-08-20, 13:11, Sanjay R Mehta wrote:
>> Apologies for my delayed response.
>>
>> On 7/3/2020 12:48 PM, Vinod Koul wrote:
>>> [CAUTION: External Email]
>>>
>>> On 16-06-20, 20:11, Sanjay R Mehta wrote:
>>>
>>>> +static int pt_core_execute_cmd(struct ptdma_desc *desc,
>>>> +                            struct pt_cmd_queue *cmd_q)
>>>> +{
>>>> +     __le32 *mp;
>>>> +     u32 *dp;
>>>> +     u32 tail;
>>>> +     int     i;
>>>
>>> no tabs, spaces pls
>> Sure, will fix in the next version of patch.
> 
> Also, please make sure you run checkpatch.pl with --strict option, that
> will help out reducing the churn here
> 
Thanks Vinod. Will make sure to run the checkpatch.pl with --strict option.

Also, please do let me know if I am missing anything else too.
I will make sure to submit those changes too in the next version of patch series.

> Thanks
> --
> ~Vinod
> 

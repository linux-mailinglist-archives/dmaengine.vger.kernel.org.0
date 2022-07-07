Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9756A51D
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGGOLQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jul 2022 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGGOLP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jul 2022 10:11:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCB12CC91;
        Thu,  7 Jul 2022 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRBlOfhOgJCINpRQZQmnUozF3S0FpDwOicx5oI4sKxgCDOnGSGdyta5xFxUIpvN52+1jVOVjhEwwq+6025P8JAVXM/91TE9NvNTIrUAebflPuRdgCUjDd+jfRIt9UTqgeznsU/wqc6xM90bKhtEl+KVQaON4hVW26so6ArgB6YeUqX2s3Z7PW3HjP20UPTm+PqbEb+/ZDxUSS8jc0bHLw/PZr/pdJ55ZTaavO3RT8tnMBov1uANIGqRJObBNxU08Q7daEnYyHOS55DnyoDLbRnZc7t0vKsVPifor3VYuVi9UZ3XwYLfktCC2kKYwaIFmFqd4n00kp9TDo0iF+K/4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wS9YhSKqnr/Cx8rIRo4kY2ud2kLU+A9+ebNtFsilDI=;
 b=d1GTeuY5ydurqNETA+hyzaoJpGtW6RxsfCTtYPP4u1yGbCRObMRY19RaXxL2RwEhA3y/ov19el+1nuS6+qkAFOwp9XXF4bfQyhAWfSUXCn5o1/ANx+kTEOMgJbQPgR2g+LEe75Gf9t0e/iI2Rf69cn60tpUb05aYsLrLtZAHZ8kK7BKZt8ybv8uyPKSIzMdoME4rd33nX3pfMn0XJHbMt6S3ii553MWqIagqlLrxCZ/GtmjCNDEgJ068HwXvgWVTXbw3cY9UlCStcA313lx/AYarAkDPWFofPihfXvtQmXjj6DHx4qBfAMQ9GxS7K6hjcv7CMw2+syPWFGkFKjy6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wS9YhSKqnr/Cx8rIRo4kY2ud2kLU+A9+ebNtFsilDI=;
 b=uc+dfXpyJ3ZgDeStLp6A+3GxXVnBCfDoN6eQpT2TKsyfZLGFCBwFACpGxkBhpVUWiLUoPFLOZ1uxnl5KhgOWjmGt9Tuo/Brc50QvwthTlS2N8KvOFP8Mi54K0tLpndvUmKKZ6QWsz2Y4A8y/QtmtLAAIYS4mbv7TMOsCKihdEEz5C4OHOsKq88EPc+opGLl7spIXyxY0oj+oNbXMcYZSuUt0xiM3uHDFYdUHhhL7lsQCkt5+pB9EY3aRTwC1K46w5fP/ZUoqVjxxcmjxtF5OgBCWpv1ll/jvpuZgowWTA4qXcVHixdGu4I4dDdImEIusxjqbPlyF7oJR5HfQl8hpKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Thu, 7 Jul 2022 14:11:13 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b148:f3bb:5247:a55d%2]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:11:13 +0000
Message-ID: <3be05c10-d26a-7dec-d642-4a3c36883a54@nvidia.com>
Date:   Thu, 7 Jul 2022 15:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dmaengine: tegra: Add terminate() for Tegra234
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220707102725.41383-1-akhilrajeev@nvidia.com>
 <20220707102725.41383-2-akhilrajeev@nvidia.com>
 <1d0826ed-97e7-9571-b5e5-9da12286a626@nvidia.com>
 <SJ1PR12MB633907810FD7D59B7BF433A6C0839@SJ1PR12MB6339.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <SJ1PR12MB633907810FD7D59B7BF433A6C0839@SJ1PR12MB6339.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::28) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c54cea85-c3ca-45c6-0b76-08da60228c61
X-MS-TrafficTypeDiagnostic: DM4PR12MB6544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paYT8SwtKpXddRSpUEUxmmiMXVnaWuFVxGb6TYsxD7DQyZv7F3/5KkvBUwseWwSc/pAFyb4tEUJRctjjPM0Nh7S33b0h4NPjeLSW/fU3Eod0k6cp/Hyoz1eABS8xK29UYeagBGmf5ZxEr7pZiWQfDVDPGTfVZ1NvyCBNCVK70mAvf3MfUwm3PVLmevl9/yKsT+Z4oOE9Eae96NTghxeKIFQCzIhwwJZIHmST6i3mCO8isWeXUucJ24+2+erOMiXa4nELmUW1O0FCBCDcWBdWi3wgxRTRpzp4WRSt8nkpmy71BtZ2xhE0wv213gojlEVW5qlGnumJhZ3lmza9R9JFXd4Led2VbJkjuGKQfxuS7zmi2pawSmBdVhAEbtMxycot/vp7W6QAcXsffty/b8nCbQ2oxyIxG0MZZlNeLnjnf50U26T+sInfJAZJ12QUPqsfqJj6h0x3t9XTFwGuxdyT/AiYCEYU4OLvDg+YoZdUolf5fjwondF6aWwZKhVjoKgAxWm2B5sNbvtn08a4Ua80jcfGegGkhn82b+sleCki1vqQ9Osj0wC9pGFgZK7TGEQj6cd9/xVcaY1LKJ+83JBZGVvcIR+DNTH9kkwPphWAr1WSseAkjAVXiia1n8/KS9fgYJD+YQs10iqby1CUIvr5zGXnst+UM1v5k4gggG1bnfbxv0W7Ltln3X+YK+nCpulUKMm0tzyMhnvxNt9IFVJMpFSThkB9AYj+YTPPC3fejU2PFG0bsP7jWlaKnFWFSrVNjU5/QCcIeiJI3BkF1WKIvGmCSuA+3o4b52ECurISjuqUMQNRC8EdrvuCJSKukhyiAEuYPoIGk7/DTxNtjljN66qA5Z1P2OQu00LCxhB1V5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(66946007)(86362001)(38100700002)(478600001)(66476007)(66556008)(2906002)(8676002)(31696002)(6506007)(5660300002)(2616005)(53546011)(921005)(8936002)(6486002)(6666004)(55236004)(41300700001)(110136005)(316002)(83380400001)(31686004)(186003)(36756003)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckcxdlZ5cW9FdkUwb2MwQWplenVDQUVrWUtKVWN2NUxhNm1PTDUyUkV0UlZw?=
 =?utf-8?B?U1FIV2tMM2ttL2wzYUVCVUVkSXQ5QVZmRUtxc0tRVUdYWDFWNkNFOVpPNlQr?=
 =?utf-8?B?UEJrT3JvcFVBTVNjdGFkZEk1ekFPaGVmNWxKcUQxUms4UFEyeE1nK05BUC94?=
 =?utf-8?B?OTkrdXlmZnNGQ3RRWlZ6aTU3U08wb0ttYWN3TVcxU2dPZlZmMktoa2oxMnZ0?=
 =?utf-8?B?dDE4bVhNQ1VhRlR5YzVJTWtPaEtkbHRXV0luamd1OSsxRTdQMDFlNEtHVXFi?=
 =?utf-8?B?UFFVS3NxTWJlc0o1akJ4QktDR2IvSXBoRVprWmxIajBuNmxlRm1RSDdla2lr?=
 =?utf-8?B?enpEV3VIYnk1QWg1TUEzR01pT2lJdXVSTmYwczIzaWZnVERzMXhxYWs2TXJI?=
 =?utf-8?B?L0wwbER4UTZ6Zk1UUVlNYURYejhwOHRuZmQ3aktNcXBLSzZFdXVCNEZNYUw4?=
 =?utf-8?B?K2RQaitOK1lBVG9uYlJRcTZNbEZYUzB6QTlhZ0gwSnhtYWhMa0xJT2xDVzlp?=
 =?utf-8?B?YlV5NmJwOUZXS2dCcm8yZFdIVGw3WEg4TVl4ajFKbjJFUXRtRERSdkJlNmZ6?=
 =?utf-8?B?VWl1UUYwZk1mL0R4T2Q1bDZtdmFoWFplVWpYc2xzRUVaTVZmQk5IWHZCbnN0?=
 =?utf-8?B?NmZ4a1dnTlp0WTRMR21tR3FyUU1CdWZ4cytWclNFTUtYd09vNHFaWW94OC9B?=
 =?utf-8?B?RmVPYXZXNDk0SlFPOVhhbWxhYVVCT1pTaEpoRTVCWm9VVUtPWG16emRaRlRm?=
 =?utf-8?B?cEFkTnVoOWRZalRHd2o4ZWhZU3pZNnpXNkZOZ1FYSzRhMlJEWU9UaHFzUGlz?=
 =?utf-8?B?R2c4V3BsbnRVWDRCV2dUYXhpK2pZNlA3a1hKRnRvYmRzRW16dGlBSzRpbXo4?=
 =?utf-8?B?c2ZONVA3WkJZVk9CTGxOU1c0ektTbnAvUUw1dzVXeFM4Sy9DaG5OdmpZL2RM?=
 =?utf-8?B?ZllCdjFRQjkyU1VFajBXNHdHVm9xUk5DdjFxdFA1emFnMGE2TERTQldmQmlw?=
 =?utf-8?B?V2piSWp3dE5tUjZ2SmduaHVpNHdUSjRTRWNBMEc3MXhtWnI4aEJ6Q3BGOFNj?=
 =?utf-8?B?MTMzREZJWEpyTjZkZVRPTWRoSVNlTW40OWJhOXRBOU5hcjhYR2ltQUNiVDR5?=
 =?utf-8?B?aEhucEQydTBPdFlDMG1peENhbnJxL3hqQ3JwK202L21wK2RKSUhUU25Ed0cy?=
 =?utf-8?B?c00yUmpSYXk5TzlGc2JqTjNVRFNYSVltY1VXN3B3dXYwYUtmTklEazQyU1Uz?=
 =?utf-8?B?ZFFKdmpvRzdnZjhYYllNcW9sNlltMGpMbzAwcGxKdEI0S1hwN0RhOERhb1c2?=
 =?utf-8?B?YUpTV3U3ZTZWTEtQSWFySDlZdm1EWW5nQVh3OERHY3BuYXB0N2JFb05kWHcw?=
 =?utf-8?B?RGtrUDlQMkx3RVFKaUR5dnI4b05wV3N5U0hNWnlXZjlpZXo5a09TeUYrbzhO?=
 =?utf-8?B?ZVBmNHdIMndGelZMa2s4WkxhVTFCVVU5ckFtVUxFQmtIV2pDUkYySHN3aGlx?=
 =?utf-8?B?WjErRnpkdTNJYXlJcjNjcG1OT1NBejg5TXlPWExBTDl1LzJwUWhickhJVm5x?=
 =?utf-8?B?TytYTGNRTVAvRStCZnlNK0VhcTZUMjlIcEl3cEVJMXBxRlRVNytkSWVvS1A0?=
 =?utf-8?B?VEszTEFVcDh0T25mNERZZUJKWTZTYmdISi9xNmp5VEFVVUpocWtRWFBidlBh?=
 =?utf-8?B?eXJLSDJYckVGTTc2Vnl2b2VTZVRtSkpLNTlwU3F0eWtIc09TWXJ1Rlo5bnky?=
 =?utf-8?B?TEhoa2g5N1JjN1ZoZXgzeGNzb2ZwSTJZSE8rN2N1cGwrQ1hNYndwa2Q4angw?=
 =?utf-8?B?dTBCaDVyYkxOSXAxQkpXZnZ1Uk4wTlM1d2hZSXFzR0toNWdya3E4aUF3WlR4?=
 =?utf-8?B?NFpHVkV2UCtSVXFHSmJtMy9EUWtEUGlqUDFiL21VY01kdGNUMUF4eG80TkxF?=
 =?utf-8?B?L3k1cUNHa3VaL1RZeXludUd5K3ZUOW1WVDFYYjVvYWxOQ005YmhpVExjWEc3?=
 =?utf-8?B?dFl4RTNjdVpQeWVqREM2UmZnRVJFRENYNEZaMkVQODdvbXJnQUx6R0dmbHZY?=
 =?utf-8?B?QnVmUW9sZXdkK2twR0Rrd1pyd1hZeFU3aDF6VzhsdWFKb2ZNaDJVaWpndllM?=
 =?utf-8?Q?S7k0RONtjwoz/rplowhYX0Qyb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54cea85-c3ca-45c6-0b76-08da60228c61
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:11:12.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED1yhyP33O94olOKxCkDzEbK60peY1e+jTKxyHzI5zOv8wYpZNj3LMtrQ2h+D60aw25xxdDY6c86SI3MLu6COw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 07/07/2022 11:47, Akhil R wrote:
>> On 07/07/2022 11:27, Akhil R wrote:
>>> In certain cases where the DMA client bus gets corrupted or if the end
>>> device ceases to send/receive data, DMA can wait indefinitely for the
>>> data to be received/sent. Attempting to terminate the transfer will
>>> put the DMA in pause flush mode and it remains there.
>>>
>>> The channel is irrecoverable once this pause times out in Tegra194 and
>>> earlier chips. Whereas, from Tegra234, it can be recovered by
>>> disabling the channel and reprograming it.
>>>
>>> Hence add a new terminate() function that ignores the outcome of
>>> dma_pause() and disables the channel.
>>>
>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>> ---
>>>    arch/arm64/boot/dts/nvidia/tegra234.dtsi |  5 +++--
>>>    drivers/dma/tegra186-gpc-dma.c           | 26 ++++++++++++++++++++++--
>>>    2 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> index cf611eff7f6b..83d1ad7d3c8c 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>>> @@ -22,8 +22,9 @@
>>>    		ranges = <0x0 0x0 0x0 0x40000000>;
>>>
>>>    		gpcdma: dma-controller@2600000 {
>>> -			compatible = "nvidia,tegra194-gpcdma",
>>> -				      "nvidia,tegra186-gpcdma";
>>> +			compatible = "nvidia,tegra234-gpcdma",
>>> +				     "nvidia,tegra194-gpcdma",
>>> +				     "nvidia,tegra186-gpcdma";
>>>    			reg = <0x2600000 0x210000>;
>>>    			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
>>>    			reset-names = "gpcdma";
>>
>> I think that this should be split into two patches.
>>
>>> diff --git a/drivers/dma/tegra186-gpc-dma.c
>>> b/drivers/dma/tegra186-gpc-dma.c index 05cd451f541d..fa9bda4a2bc6
>>> 100644
>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>> @@ -157,8 +157,8 @@
>>>     * If any burst is in flight and DMA paused then this is the time to complete
>>>     * on-flight burst and update DMA status register.
>>>     */
>>> -#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
>>> -#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
>>> +#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	10
>>> +#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	5000 /* 5
>> msec */
>>>
>>>    /* Channel base address offset from GPCDMA base address */
>>>    #define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x20000
>>> @@ -432,6 +432,17 @@ static int tegra_dma_device_resume(struct
>> dma_chan *dc)
>>>    	return 0;
>>>    }
>>>
>>> +static inline int tegra_dma_pause_noerr(struct tegra_dma_channel
>>> +*tdc) {
>>> +	/* Return 0 irrespective of PAUSE status.
>>> +	 * This is useful to recover channels that can exit out of flush
>>> +	 * state when the channel is disabled.
>>> +	 */
>>> +
>>> +	tegra_dma_pause(tdc);
>>> +	return 0;
>>> +}
>>
>> The commit message says that "add a new terminate() function that ignores the
>> outcome of dma_pause() and disables the channel". But I only see pause being
>> done here.
> The function is set as .terminate() function in chip_data and is called during
> terminate_all(). Since this return 0, tegra_dma_terminate_all() will proceed
> and calls tegra_dma_disable() in the next step.


That's fine, but it is not clear from the commit message.

Jon

-- 
nvpublic

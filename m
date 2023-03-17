Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A406BEF78
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCQRUH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCQRUE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:20:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EF4C9CB1
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 10:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9mB9QOfJocm2LjT/QcoUr2rKJaRf5JizjZEtx5IsSH0EbQh7brj2ek2Yc+qCGtFlPmli+CEPozoMci9lrM1FpNGGIk8S4+zYLjQQZy/wWiFmxw/+32m7+71SGq890NyWoOmjEyueYrVWE3pMLHZTvrF2omqxkDOPK+4gOavWefokgtNThNi9G957nQZSzzxTwkMvd766tB8l/KJ0bB2KUJdzO/XQpO/O7rp2wVM5rDy+36ZLvZAWe0y2eNHpMWCZ4aM2EVYQ5FkFGiowXnz+m60VEmaZ7QtDzhBPchgtitRDm9iWXrB95PF4u4Q8sbLoM5BaaNKjWNjHoGkRmZ0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTNjs3wfxg6qnZF6eQtLIpE6R1SNuFPoLloljkkHYTU=;
 b=WiRbwRSbGLflXAWYKje28XEP+RP4z+F7u6sajnjSwCw5O+rpouWzs1X4PFOHI6/97kEpWBTJXj5KyNhw2myA7oHGfDtnCZ4wxj08d04sMvppusizHdNW/qEOtSiaSSrMEyPwb2BvBYGdJxjV/HywGH7SO1TJIZJfWVrX0k1qt21dNf3XFpsRDyPoyURwlH4PWXN8W8jEM0XqwdIav7oe3OZizGgwVj5dP5cUx9bvrUk6DnsBS+WVGn5vs5JNmpqom27f3SkQTnGaRiGtT8d1y2XAZwPnnla/A8WSL5YuKo8y6q0TPK41Nc6EE4Uf1/fFq3w6G3EQ7fk6lGO3NgVKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gpxsee.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTNjs3wfxg6qnZF6eQtLIpE6R1SNuFPoLloljkkHYTU=;
 b=NsGVvecKCiFOIpfpv0iQpaWTWLRHMSDADw8QdIXSAqHkqotftO0JV4enjef6IyQXVf2b7PZgBGJiUiKF9EZ8fj/iKnDrlGdEn35mJvR20owSJzpY2dGwXI6SraLT18NQWh9XI3WN8z8RPNErn1/fMT7H2eALWVgNNLPt48hWObs=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Fri, 17 Mar
 2023 17:19:57 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::f0) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 17:19:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:19:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 10:19:55 -0700
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 12:19:55 -0500
Message-ID: <fd0d728a-0440-ed6f-29c1-6104dbd6ab85@amd.com>
Date:   Fri, 17 Mar 2023 10:19:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: XDMA crashes on zero-length sg entries
Content-Language: en-US
To:     =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>,
        <dmaengine@vger.kernel.org>
References: <529849b0-2ba9-85bf-c57f-0abe93cfdc42@gpxsee.org>
 <f6a0051f-acec-f661-55cb-8b2504bef79e@amd.com>
 <51071604-c97b-2f98-d382-d70e7916a7c6@gpxsee.org>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <51071604-c97b-2f98-d382-d70e7916a7c6@gpxsee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: b716a01b-dec2-4c5a-63de-08db270bd482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ch7ZsG7mqUOm1gm2BPKA4k/6yv9kuQrAdIoGQKTszsXe7/xqA2cJGzthLsDk77j3ryKLHj2MiZFKwYe4mwfc659LZerQMHS+bffACgC6VyRkFIGYlEUu6rYYZKHkrlfjmLvD4mid7ck/uhm1D2Xr5TWmGZ+z9zQi26PV/LJ7zC7IwcxAYGwPATfgPrdsNlB62PI/XdpSYfx6JaV+ZOcyj75NNyZq9mC/Xp4wRWSokgFYOF9xF0Yp5eXfHabOw+GULbYSxHW8LiSqsxB/4KSDQDaNg49RE3POp/6xif6QZNf/jNXqqyTrQfG80k/Z7stHBEo/xGR3hIwTUCrPw1Fe4K1yA3pLyuBJUV9oLsopLnVf3tewaIzMHaat/dkJqpKZ3kx5xvpiYhBt9TKz1bGdXfcYb3H7XeU1CRG6nW+bmRpcVK+jwJlIMe2yJdA+s0wC0ZYw61+LEx38V9zmLRfM5GStP/W1IHJ5MfsmmM1HvT9JAaLZtjB+aGymVbvYMgGbYlBCvaMi2ebrjEtAH48qxBvOki4AaI9TwCOU3j5I7YUWqbEMU1GykYlJiYVzWsVU1KN4FYvEyAPMOP4F07oTV8UPLVEf1cUzqBae+I0X1s82pZZ3IZ46UkIqCyPk523Pn9D8a5YBiHWVHDlRm4xb/H7YXtmhUw5lm0H3MU1BwhPrvXKzMiuMztcpvG/9sslD+02KsbB28ThEKVBiK9pYkb1RjpdUD8BSdFuGxd9z6XBPFzTLsuA5oA5WEbqjBHKK+VEiZPqrAAkcojXvZi+1jAbmN3cXA8YreGH8ueADz3g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(31686004)(356005)(8936002)(53546011)(2616005)(186003)(26005)(5660300002)(336012)(40460700003)(86362001)(41300700001)(316002)(36756003)(82310400005)(31696002)(66574015)(36860700001)(426003)(2906002)(47076005)(8676002)(44832011)(110136005)(70586007)(40480700001)(966005)(478600001)(16576012)(82740400003)(70206006)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:19:56.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b716a01b-dec2-4c5a-63de-08db270bd482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Martin,

On 3/17/23 04:18, Martin Tůma wrote:
> Hi
>
> On 16. 03. 23 19:25, Lizhi Hou wrote:
>> Hi Martin,
>>
>> Based on the dmaengine document
>>
>> https://kernel.org/doc/html/v6.3-rc2/driver-api/dmaengine/client.html
>>
>> The sg_len used for dmaengine_prep_slave_sg should be returned by 
>> dma_map_sg.
>>
>> This implies there should not be zero segment for the first sg_len 
>> segments.
>>
>
> I do get the mapping from vb2_dma_sg_plane_desc() which internally
> uses dma_map_sg_attrs() and yet in some special cases sg_dma_len()
> returns zero. So this is a "real-life" scenario. I'm still investigating
This sounds odd to me. dma_map_sg() is supposed to return number of 
Non-zero sg because the zero length sg will be merged.
> what the root cause is for getting such empty mappings from v4l2, but
> the DMA driver should IMHO not crash the kernel in such case anyway.

I checked some dma driver and I did not see obvious code to check the sg 
len. e.g.

https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/dma/k3dma.c#L531

> I have looked into some randomly chosen kernel code that uses
> sg_dma_len() and all usages that I have seen are prepared for the case
> the length is zero. All but one driver simply stop the iteration while
> the remaining one reported this case as an error.

Are those dma drivers?

Adding a check sounds fine to me. And I am going to create a patch 
anyway.  :)


Thanks,

Lizhi

>
> M.
>
>> I think that is why we need to provide 'sg_len' for 
>> dmaengine_prep_slave_sg().
>>
>> With 'sg_len', we do not need to worry about zero length sg in the 
>> driver callback.
>>
>>
>> Thanks,
>>
>> Lizhi
>>
>> On 3/16/23 10:03, Martin Tůma wrote:
>>> Hi,
>>> The Xilinx XDMA driver crashes when the scatterlist provided to
>>> xdma_prep_device_sg() contains an empty entry, i.e. sg_dma_len()
>>> returns zero. As I do get such sgl from v4l2 I suppose that this
>>> is a valid scenario and not a bug in our parent mgb4 driver. Also
>>> the documentation for sg_dma_len() suggests that there may be
>>> zero-length entries.
>>>
>>> The following trivial patch fixes the crash:
>>>
>>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>>> index 462109c61653..cd5fcd911c50 100644
>>> --- a/drivers/dma/xilinx/xdma.c
>>> +++ b/drivers/dma/xilinx/xdma.c
>>> @@ -487,6 +487,8 @@ xdma_prep_device_sg(struct dma_chan *chan, 
>>> struct scatterlist *sgl,
>>>         for_each_sg(sgl, sg, sg_len, i) {
>>>                 addr = sg_dma_address(sg);
>>>                 rest = sg_dma_len(sg);
>>> +               if (!rest)
>>> +                       break;
>>>
>>>                 do {
>>>                         len = min_t(u32, rest, XDMA_DESC_BLEN_MAX);
>>>
>>> M.
>

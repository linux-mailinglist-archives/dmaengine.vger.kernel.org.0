Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189060DE16
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 11:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJZJau (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiJZJat (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 05:30:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC343A3F42;
        Wed, 26 Oct 2022 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ME99EE0zI+hD1VPsykOGMaJCBtSPNUumQ26UEYhj00PDy6vxHs3d8U1LjUS6C/357OIvkGqIZahCLOph2oA4W8GEbcFT1iG9lr4lKNFq/Vm90cydV0iZliWY+CrQ3S/qHYnrsDToDnvo0QalIDAah/tBKAgCmVCU6QzlTK2xD8R2+rllK2omNjgPSAE/3qTOLjhaX789i7i5DHaGHmSeukKnI/zgjFvglCnK7Sj0iwWwi9yCs4rRjDj2jqU0roTBVZ6bFHHj98165QvveNkj/k4XPnVZdMBZ6DSAjsajnkms7HsllWMg/gGd0XCmTV3n8F0HoHMlfZG35mBlJDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmDo4GsrOGfmeDAhpBZmfkcUJAUjezT0OblUIoDPIYY=;
 b=dAz4q9eXszghwu3ETgDCYGkKhjOQ++vM8kQL5douX8TVVfHJi7ZuR6RBkD80x4SRN/hF+o8P6+XiIB1MUU4BblkDSL2dfmKw51aPL4EW2+zNoB5GnNrULRHxrM4Qd4SJU+lGqOEeA3oe42pKmAl2kRrTUVwDg+sORGpiYWdo169MpKjzAZnevj9diKmO6GGwXh3CsOhMzCKsR55zsa2nu6wfYUU7B2PFURPRxEzFlb8qlPno68hizXDVBFjraVgKtLW9hT25i3Yg3KHEZOpQR3k22fwNBtz+nageZJFeYJ4PDjOpqqA79sQheIskNPJ+VpOyuOxzsByaFv1+nRq9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmDo4GsrOGfmeDAhpBZmfkcUJAUjezT0OblUIoDPIYY=;
 b=hBKHb1MeOlr+d4hfRhPszHpNvAiFsozO68BHa225MN1WYuskAWgfZEh+p/ZQfigOhLB9n4MUx+DruCNRfEZR4wyWjgXt3CoYuP7nXuZqEwHnXP8ZD0gYde1In1nxj2ZRSyB6xv4ejbaZL4ui+Za8xgkcoQ+B8RpVP6VxV9R9HDGdpiWBvYaSRfjxOr6vAO/1bhb+a0cRCqq+/sp5303ojAG6rEnAlFS/3xxEizuxUTBtiJTMqUs5CUw+C+JYWJ5FvgjSE3h5HgO11yOmBMJO/5uy6zNpnzoohfkuTLmLeher/ZjwQMdqLWYMm09HyqGKEm68ixYwdVSPbOJ52QGaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 09:30:46 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 09:30:46 +0000
Message-ID: <76617e20-2a1d-baba-719d-bd8b32fa69be@nvidia.com>
Date:   Wed, 26 Oct 2022 10:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-4-akhilrajeev@nvidia.com>
 <20221021021604.GA2181729-robh@kernel.org>
 <SJ1PR12MB63399B01D750CD4725A13A03C0309@SJ1PR12MB6339.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <SJ1PR12MB63399B01D750CD4725A13A03C0309@SJ1PR12MB6339.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaed7ce-0fea-494f-ecdf-08dab734c316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYxIc20Xkv/42Hl/0TyrZkTv15WyL6j5TwEFzwcRJb7iSxYqh7ifCmJopCJ4tt+D2pdUzJf8ee1VAjFOoD409C7w60vRvdjJyY2zTLxqupfwJxaLdIOB6Hel8oGY0fdqzoKKo4m2cwIuRs46YYNWdcNhvaDZafGyXcV6KbQnE6b/UGZeivtnBdhts1SzuvDx30laEi6DAIcWYXjmz4l1nbeIKI5WyPL2QuZdnRiIDEh4dPKNMRupdXkXWu2lBXdJJCTMxvu7sSOf67PMVjp/51EuZljK5A2NRAFPHWFGTY5wJmCNSMTvVtvVEYEFjs5/o3afcvt5cZvRHlfXPtyAEJ++eTP+iKcgcOkR0suXsGjJCk2TCuAanv/VXrnKm0rHRDnDJDZ5SMSUjyxBbQQvColA6hB4sWt5EvVtY1ADRdX889EZlZTLRgdPDwKVmSaCedjCHz+8K48iMy9SSZcAkB5VBzRYi9KsQTyHRgr7MKnpZegFZexn9x8rdUvdisGf90YiqwGGW4qXHfDe1uXSdPwXikiS3DrYwMqVl1EHNLQ6oF6jpBGoLnXq7D/7mk2ZAF54bFZFTMyO1N3cWblnX/A5hFmEKzm5ydO0tJfmUfWhiUApTbHnl1t0IXXTVkbe3jYg1XeeR1cCqAbM+PsYdmRNSQFCliQyDuwHn4FmJA2fc/G97C8n/hqoj72OQyJR86pLYLTmnK06nH2pKt+NVojQXNmpSlMkupcv8LCJPMbXhKIFagC0LuTyr34WPwZkDmXPL4rT9Ptc70xCp4oYhk7rmhFkH9yCy18aqqiqSg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(6486002)(478600001)(31686004)(86362001)(4326008)(31696002)(8676002)(53546011)(66946007)(66476007)(66556008)(316002)(54906003)(110136005)(6666004)(6506007)(6512007)(41300700001)(83380400001)(2906002)(186003)(8936002)(5660300002)(7416002)(2616005)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNQaTQyU2Fpa3lDaGdxUjgwSGtROG9EZzFMRWs0OW9xeDZ6V2ZmRVg2TkRH?=
 =?utf-8?B?WjdyM2k3UXV4OTZpRTFic3BYM0lKcm5qNE1nZlo4dzVqcnlxMkI3SzlOM09C?=
 =?utf-8?B?RFoweGZlc044bzBJUTlmcXdjZWZkMWd5dnZRck40UVZGMWtzTDBndUl6akpT?=
 =?utf-8?B?alRKQTNSejhFSFgwbWV1OXNkS0NmVzIvcEpvMC9WWmV0WVo5K0V5UC9yZVho?=
 =?utf-8?B?YW5Hc2JIa1NtZ01hVzNnY0lnRTcwcGwxMTYvbFo5Um1SVW9YRmJxd1Bmdk1O?=
 =?utf-8?B?SjVoMERTSHNQS0JjRXhRc3RGaE1sRTlab0k0NXd1SnEyUjhNWHkvYWZVQ1Ey?=
 =?utf-8?B?Vm9mSUJsV1NScE5KOGlab2NjS0M5ak1POTVQbXhJRGVtVWdnTGNnS2FmTjJn?=
 =?utf-8?B?QVVlRUFSNmphRXdLU2gza0d4UmxqSnhHT0cxZThBWng0ZjZpUEVTUkxsVWR6?=
 =?utf-8?B?RW5HR3RseTFxSzN5dlQwYmo5M2M0a2JxWlhjVDVDRFNZcEVncU9KUjhxSzFH?=
 =?utf-8?B?SVBVNHI4R09VTEdmbVdYcnllQ1ZKdEdVU2I4Mkk0MHI5SGwrSWszUEFlcFlr?=
 =?utf-8?B?WWl5V3AzUVQ1ZVlTaU8vTkNHYnBuQ2VGc3dTK3YvQzF4VXM1ZjVoK1Ntd3U0?=
 =?utf-8?B?aXAyUEVrYW9TOUpKY0tMNXJacHdYSXd1K3J0UVQ4NWd6Z2NheUh0bG0rR1o3?=
 =?utf-8?B?MXBQbGdhTW9OYjloa2EwV0xESEpya2V5UTlCRm9aQ2QrMm5KbmtWVEU3VEJl?=
 =?utf-8?B?aElBSDNFK0ZuOFR1YTI1RDFGTkd1d0RqRkt1Z1dxUlBpWVlrNGwvdWpXelpT?=
 =?utf-8?B?eXBQaHR3bjNqZTA3N2dvV3B2TlNZMnZLT1FBZlpGT0ppSG1oWER4WDROVi9u?=
 =?utf-8?B?SzhQdnkwamRWYUdTbGU3RE9YNkh4QWJiR2toZkVaUUN3RlNLTzVmZVFFQWNH?=
 =?utf-8?B?TE5NMmpUNk1qdjlQRk5BdEhiWnlNRWU4SEcxVmNyRTdjMVEwbkhYNjJxNVFo?=
 =?utf-8?B?ckhJL2d5VmtuWmg5YzhuL0dtejFucm5TZExISDRxUUlWK0hLN3lsbnh0NXhv?=
 =?utf-8?B?UzBsdzdTaW4wRHRoOTRYaVlybER6TTNrZmlYeXBlaVorMk5mNld2SE54UkdM?=
 =?utf-8?B?M3BBRFdnaG1ubGpTY1c4cnBlNWVXN0h3dzduVUxDcFowMjFPNUFITUVncm1F?=
 =?utf-8?B?MVFPYVFPZllnMU5adGtNRmt1bFJXU0htOTI0TWJXbU0wYkFBNFhZR3Z0c0pa?=
 =?utf-8?B?d3Z1KzBJU1FUNlJqZ0RNNytzQ3lEbkxiQ2NqRTh3Z0t3NHhwc1pleVdvZkdi?=
 =?utf-8?B?RFZCNHlWTlRyNlhkMTBnRUY3MzdLKzEwOC9CYXk2ZThWbVFlcXQwSkxCK3lh?=
 =?utf-8?B?U3UySVkzcHcrRkVrN3VJRjMySm45U2EyNVhHSG00S05HNDlnQkpjUk55UWZL?=
 =?utf-8?B?R3BZM1ViNHI5c3BFT0tkZjVzWDVSR1YwMStpT2dYNmtxK2RTQXFMT01yME9O?=
 =?utf-8?B?YW8xRE9uV205L202N2RPZ3QwcDkyZDZqTnBDNWl4VUdlcjE4b0JkNnZSSEQ2?=
 =?utf-8?B?b0NWN1JMbTh1ZSszSTQ2ay9rb3BxVGNtM1RibzllRlREc1RMa2JBVEJDY2g0?=
 =?utf-8?B?dmtQVlNkT0lPUGppSEZQRXF2SU0zVWhhSE5JUDFWNzJFcDJPODc0N3FKOHVV?=
 =?utf-8?B?QmJ1Q3BCMng2UmRJMlFsL1RvbzlBVVpDRzdmRUh3aVJTQWVZV1J5VWRqaUJQ?=
 =?utf-8?B?Z0lSQnIzNnh3WFBKaFZHU2NoWERnQm5FNXVOMFR3dU5meFZlVlZzOGM1bS9F?=
 =?utf-8?B?Ri9JL1FDcTdrVW9COVM3YXBzRTl2V3V4Z0ZiellDZEY3N29EeXBrM1JHcDQ5?=
 =?utf-8?B?S0JxbEU1bk9jaUJJaXpDemRSU3hRZ1hZTkozNFA2TFVSakxOTVhzaEc5YklY?=
 =?utf-8?B?MExqdldBNDNyQUx3UjA1K2R1U2pUMlh2OE1CZTZkTGdSMTFFdGlIRmlpN1M0?=
 =?utf-8?B?bG9iNDVjUURyQ214YlFUSjdEbnFwYlM5dUJ2TElkTnZ1bVpWOWpDSDNCSUpE?=
 =?utf-8?B?TjN4dGlhVjNpNHJtTFZxekt2VXBZUWNFaHNVWUp2SklHcSs3aXd0dGJnQTJi?=
 =?utf-8?B?UzNWUnRKdEZSRjhWZThxZEJWRCtKMi9UVjhTbys2ZjNyS3RubDhwcEl1Wlh4?=
 =?utf-8?B?MjhCYjJ5bXlweVdGRWQ4aS9PemM2TFpWUllZYWdCQ2ZxWmJ2ck5MalBrMkhQ?=
 =?utf-8?B?R1RlMnNzenRKUERSUjBwVkpoTlZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaed7ce-0fea-494f-ecdf-08dab734c316
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 09:30:46.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND3UNDEPXRlVo3ZLyGdyeMrj0/eqIh/UFtyz3EZTh41XQwA9Klo9iLrvhD91VvT1x64+/+cfqCh6nkVrsI+NxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 26/10/2022 05:44, Akhil R wrote:
>> On Thu, Oct 20, 2022 at 02:03:22PM +0530, Akhil R wrote:
>>> Add support for dma-channel-mask so that only the specified channels
>>> are used. This helps to reserve some channels for the firmware.
>>>
>>> This was initially achieved by limiting the channel number to 31 in
>>> the driver and adjusting the register address to skip channel0 which
>>> was reserved for a firmware. Now, with this change, the driver can
>>> align more to the actual hardware which has 32 channels.
>>>
>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>   drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
>>>   1 file changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-
>> dma.c
>>> index fa9bda4a2bc6..1d1180db6d4e 100644
>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>> @@ -161,7 +161,10 @@
>>>   #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT        5000 /* 5
>> msec */
>>>
>>>   /* Channel base address offset from GPCDMA base address */
>>> -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET 0x20000
>>> +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET        0x10000
>>> +
>>> +/* Default channel mask reserving channel0 */
>>> +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK    0xfffffffe
>>>
>>>   struct tegra_dma;
>>>   struct tegra_dma_channel;
>>> @@ -246,6 +249,7 @@ struct tegra_dma {
>>>        const struct tegra_dma_chip_data *chip_data;
>>>        unsigned long sid_m2d_reserved;
>>>        unsigned long sid_d2m_reserved;
>>> +     u32 chan_mask;
>>>        void __iomem *base_addr;
>>>        struct device *dev;
>>>        struct dma_device dma_dev;
>>> @@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct
>> of_phandle_args *dma_spec,
>>>   }
>>>
>>>   static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>>> -     .nr_channels = 31,
>>> +     .nr_channels = 32,
>>
>> This is an ABI break. A new kernel with an old DTB will use 32 channels
>> instead of 31. You should leave this and use the dma-channel-mask to
>> enable all 32 channels.
>>
> Hi Rob,
> 
> If using an old DTB, tdma->chan_mask will be default to 0xfffffffe since it
> would not have the dma-channel-mask property. The driver would still
> use 31 channels even if it uses an old DTB. Shouldn't it prevent the
> ABI break?

Unfortunately no. Yes for an old DTB without the dma-channel-mask 
property, we set the channel mask to 0xfffffffe, but this is not correct 
because it only has 31 interrupts/channels and not 32. So I think we 
will need to use of_irq_count() here.

Jon
-- 
nvpublic

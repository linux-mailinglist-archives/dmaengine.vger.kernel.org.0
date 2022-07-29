Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE35855ED
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiG2UJq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiG2UJo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 16:09:44 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00128.outbound.protection.outlook.com [40.107.0.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F787372;
        Fri, 29 Jul 2022 13:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuGgep/qOzdPjIATYe4+8IWNsEG6dJCHLlBv1Bnbf9EN+9lRyQIHQCRHECyIJF1Vt2rGkaCJjIma45N4RliIZAFntE84ET2Qkid3HDrgY5lbegztagXyOIrLDQ2eQ8/DQ7wB1vGpy9qhiuv6nkp8exMzSE9Gal2IpDTHupv0cyzLXUrwwUClgsj7i+uLRzfxpKBX/wLdk76TEunlZkhBobkMfPI83bUuorxb7QEEp0ap4puz8uYpMRHGy3y2axr7plm63nNzCikZBUlVGzFCgPoswflirqxEpCB88g5BKbJMpEiVGcJcnaCxK7WRKW2F6jfUuVP8kLpWry4W1wS6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3nwSAZh8tYPw1r06TlLVPC2mkKBTg4+2c+/3g7TqJ0=;
 b=n32hiOSA5nylh+n3LsOcYHwem92EI0vruHEMNeIh4OS0wHHti4dKdAfXOmMNjh1+BsZYiL3TWoeEGF4pWB1cdghoLn7mpXlPtbvW+tVVGEov8tIdOIBwm1GKeHeYvS3rzP9HuYHYuiglHCoOxWpwcUoYxtJO8qDXPBM2nZai+5VBOvAHNvPWXaABKIUlIKvYRbEw0POIO9nfsYG+YMq00iHfe6cWiz3UwCT9ldnWaOvMNqhi/AvbKXgdDEH3lLUvYH8aKpYHSTKzUqurFFUjWh+nGP/SexLbEzte2C2dUSMhWFS2cFdwRHr05XCvT/wpunhRtGqPzTEC6RVf7YEyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3nwSAZh8tYPw1r06TlLVPC2mkKBTg4+2c+/3g7TqJ0=;
 b=E8+nLqmjmxE9MSouAAC+D7JJJ01D+g/GVei/moai6JQafb+ihQkV2Le5o4aIKziSie1KkkmmFMaXMsVacWwSBgFGCagWoF71D9PX+vv3inJ1uP+fLc/BYoU6uC5mzbUVfNJMcCp+hWQWnCwloJwDXwOJgt735haRlHqQ4PGPeRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM6PR02MB4215.eurprd02.prod.outlook.com (2603:10a6:20b:50::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 20:09:39 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::90c8:5675:c744:9403]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::90c8:5675:c744:9403%7]) with mapi id 15.20.5458.025; Fri, 29 Jul 2022
 20:09:39 +0000
Message-ID: <52c3b37f-dde2-9dde-df92-8ae114fa43fc@axentia.se>
Date:   Fri, 29 Jul 2022 22:09:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, regressions@leemhuis.info,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     du@axentia.se, Patrice.Vilchez@microchip.com,
        Cristian.Birsan@microchip.com, Ludovic.Desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        dmaengine@vger.kernel.org
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
 <9104267f-6dd5-4e49-6a81-f377edceffe9@microchip.com>
 <684f7262-13e0-f519-ffee-bbdb3ed80717@microchip.com>
 <0d3beabb-5786-14a9-2918-5fc76b38034e@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <0d3beabb-5786-14a9-2918-5fc76b38034e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c06bea2b-a93e-4dbe-fa57-08da719e4342
X-MS-TrafficTypeDiagnostic: AM6PR02MB4215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7wG6K07oCsIcWS+u1qwQTYsfrvI3IJlS4xTt7kih+a1ZQgo0vyhdTwmMI5608g7RX/0mIqpcTWUo+a1ZBIN2nr44NLqHM8SdjBNAa0pU+DZNLckq7Dq+Lt69DFgdy8vv267jHv9WVT/ZhId6rUm9t6v5IKEME5uUxGkKZA3ap2+CrnwJUL0N2CHnUr1d8DLpGMA3gucjC2GDyJmThdyu+OloTNNwr0k1+CN6ueBnI4ogPjzmUYekQYqfqEYIUqCfqfJ+uzzj0GBZKk2sN12e0PM0XjxLNaB1eLxLi501jahBjHfB+dHEgqaEnkh9hrz8fRBDsSw/Gx+jadpsliSq7GlndcjL3LnyNva520xXkXcN6XFLAUhyeHycHXkkmpYgfW/dfi+dF+f2nS2FZnU1ZPAlsDtHqdXRXDUM/vtSU5xETHaRjjY3GfANOlzP4/nMYBCouCC4mTo1XRQ7CCN6wJ5Dc5NMoTdwiq8955uWwA+s6spZoyBLYiLTmL5hMIoa8drVxBH06RucChB6/hKktsqsKBagwuIP78xAwqGbG8EJRI4SeEa81iX8tBQZtQaF34WFK4KBNCR7WYVAZKDwQH5OqJ9LrLK/3thgrm4nkAQnvNL62Lz5x1q/HUP0FkFzDaZjbRClA+UnCASm4D+xkrDHdvKegUmcg4fb/RPZMbukMiEbzO3sEgd7nXkG6/Y9qriFoh/i5cU7qOP98QaLRL15Bnqztj6m3+q8WwkKHflClicmr5gTRvIlslhyXWgJ3Hy+k6B/GMHiw+Urqr9GTekKH6Z/ZTcSkwcgYXTh2ZKVuoz8hFoqUNOZRiZhpC/eWN216dMr2Zix93rkeyGvcv0OSn1FIMV569KqJomUQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(366004)(376002)(396003)(346002)(6666004)(2906002)(86362001)(41300700001)(36756003)(478600001)(31696002)(38100700002)(53546011)(186003)(6512007)(6486002)(2616005)(5660300002)(66556008)(316002)(8936002)(7416002)(66946007)(4326008)(26005)(31686004)(8676002)(966005)(6506007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hjSEIyKytaMkliME5DTEV0STAzckhuaUw0WnBiV1Q3YkNGajlwNWVuQzBE?=
 =?utf-8?B?OC9NcmgvamFDMmIvZ2piMFZ5aEZ0bTJmWDd1WmpFTW5vMXowT256YTdtcmt3?=
 =?utf-8?B?eHBRK3NpTUFCZzdNMkg2d3lKaVdPQjNnY3hRNUFrQ094QnoyN1VXU3cwWUlI?=
 =?utf-8?B?WGZsMUdlTktsc0VrSUdacVFoQlZneGtKQ0FRSkEyRXFwbW1oNThjZ3lVZGd1?=
 =?utf-8?B?UDZtYm5DU0xBMG5RUTdVUGlHMHdNTHJvZ3E0MEl5TnRSNzdFNWdKUTFqWWRj?=
 =?utf-8?B?U3hrZUd6VGZRRkp2a3JMUFg1QmFZdlJGTGdwNWp6dENBVXhUdG5PL0Qvckdo?=
 =?utf-8?B?eWZzVVZrbG1ObU1VM2gvRm1ZaTM0Zm56Vk4xL0xlcGZPbWk4cnRKRFBmcW04?=
 =?utf-8?B?WitXWTg5Vm1DRkdJVm9GN2ZvSzU1RWxTMVo1MTViay9CNWxwWWlMbVF1b3ZJ?=
 =?utf-8?B?TWhiN1NrQWt3L2FiL1c0Q284UVc0bjFWZ2ltSzlGMmZoaCtyYms2ZklzcmdS?=
 =?utf-8?B?RHl0L0pldVZUcDhxTGpia0VUWktLeE9pSkxVNERXUmd0TDlERUgwRGtKSmJU?=
 =?utf-8?B?Z25EcTc2WTlDN2FQWmEzRGwvS25tSUVCYkh1YVFycXFudmZBSTF5MVdXSnVE?=
 =?utf-8?B?VWMyWVVRSUd4WTF5SHN6a2xhV082MmhrQjdIK05SY0ozNEtCdmNFWDFwZ3Vr?=
 =?utf-8?B?RGhKYmxWdWtJQTBJcWpRWHc4Rm53L0pzUDhMMVlVQXBIV3lVeXc1bWMrRVJ2?=
 =?utf-8?B?VmRHek5YczZUNFpYVVVVaW5md0gyZk9oZ1VoZk8yQ1pkQ0VCVkxHNEd3dnhK?=
 =?utf-8?B?V29mdXg0bjkyN1l4MVorODBCNFZMT0RBbWFkTUpmRXFJMDlhSGdEcm5PQW9r?=
 =?utf-8?B?MnNMNFNXcmhoZlJXSHdVSW1yR1ZuR1Erb3J2a282V0l6SW54NTBPY1RFZSs2?=
 =?utf-8?B?dG5MWUtQWFZiNEh4b0NlcXh0RWM5RzRkTTJkczMvMU9DS2ZpNEsyTkNZL3dw?=
 =?utf-8?B?U0grdGF0eWdrbnRUWDdiUkE1MFB6MmlKL3pkWUxQOVM1OFpZclFWOTBXR2NW?=
 =?utf-8?B?c1pUQVFhTmNvZDJ0eWpLN1EyNGNiMUJXTkpWTVB2L0VSZ3I2cDhVRzdwOW5x?=
 =?utf-8?B?WFR0Y3BYMmswdElmZ2lrSHU2SGRkOXI5ZjRjWU1nUC9BbmtnT0xLTmNJMlY1?=
 =?utf-8?B?cGd2d0xaNnZ1eE81VmkyQ3BIYnBkeDgveG9IUlNPNmk1TWpJbzJtZE9tdFpI?=
 =?utf-8?B?TVh5VVpaVnQram42M3NsckdxZUlQMWVqcjZRcnhHTlJLc21PdldBQVFKMEZT?=
 =?utf-8?B?T2Zja1cvWGM4ZGtOampMaWR0T2o0S211RkFzbGV2OHBoTWxPUlpxQ1BkQ0NI?=
 =?utf-8?B?Y0dySUovQTRLalpsdzBwbzJhZ1I1NVlVMWZJMWQvS2lQdHBDdjVibXJoQ3Er?=
 =?utf-8?B?Y0h2Y3RhT21sTGpseUJEbkJKOU41VXMwMG0xTTAzRkt1ZjhkcXJwVWhtQ2tS?=
 =?utf-8?B?cEFHa0Irb2w0d0NYRnE1ZkRRNk0ySUQydExXU0h2dk1tQ1BiT2FsM0h5elJy?=
 =?utf-8?B?cVJ1M2FlektQZGZ6R0c0VkVabkJnblRwK1cyT3E4a1Q1YzlKb3ZsMTV0YlM5?=
 =?utf-8?B?T0g0L2U5QnoxUG1mMnpRNHVFUFNEQk9QMkhlWVl6UGZONFdQVHZyZVMrQWJm?=
 =?utf-8?B?ZmxzenhxL2dmdWdRMWwvSSszRTRmblNZZkdvZUI2QzlVYnBXQnZoc28xSUdW?=
 =?utf-8?B?NXhBT0VsRFpXNGtnNndmQWVwTXFlTTgyV2FPSEM0ZEZWSVNxVzhRNUVNM0dX?=
 =?utf-8?B?MnJaMkZLbVVDODFQcDNUb0phVWpBQ3hvWVNCR05YenphK056YjVvcVVsNFNF?=
 =?utf-8?B?bTdMOVNzb1R3cm55amxmaVJndkFtSmZHWjFIaFNZLzZxUVdTTWRwdW1FMmJR?=
 =?utf-8?B?VG83OVQxemVPekJlRnpBOExOZXl4NEN0T0lIOE5XZXdxRzIvY0RVS3VQNlRi?=
 =?utf-8?B?RldpQXlndytFZzZGOHpiV1FORkpJMEd4NDZtNVUwdGV3T0ZHclpqVnJBWHdR?=
 =?utf-8?B?ak9tZ2lxeGNhdW5YT2RCaGdLRkFWL0VJVVYyMVI1UGxYVzBrYzF4OUVvMkUy?=
 =?utf-8?Q?vzY1Sv1GnXTwGWCmY1hx4BPgn?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c06bea2b-a93e-4dbe-fa57-08da719e4342
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 20:09:39.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkDMBY7sUoJ9Ul6D7s8X+43y1bSAadPxrAJ+4ALGEQEs98JnlNT/KImZgI6tWf/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

2022-07-28 at 10:39, Tudor.Ambarus@microchip.com wrote:
> On 7/28/22 10:45, Tudor.Ambarus@microchip.com wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 7/13/22 19:01, Tudor.Ambarus@microchip.com wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Hi, Peter,
>>>
>>> Thanks for the patience. I was still out of office last week,
>>> but now I have some news.
>>>
>>> On 6/27/22 19:53, Tudor.Ambarus@microchip.com wrote:
>>>> I think these are the last less invasive
>>>> changes that I try, I'll have to rewrite the logic anyway.
>>>
>>> I've chopped the driver to use virt-dma (check [1]). It's not clean, but
>>> it works and one can see how the logic is changed. Unfortunately the mem
>>> corruption is still present on high loads. Maybe it's a coherency problem.
>>> I need more time on it. Will get back to you.
>>>
>>> Cheers,
>>> ta
>>>
>>> [1] To github.com:ambarus/linux-0day.git
>>>    a7351e6f4c12..1557e0df0fd0  at-hdmac-virt-dma -> at-hdmac-virt-dma
>>
>> Hi, Peter,
>>
>> Does this [1] one line patch solve the mem corruption on your side?
>> Even if yes, there are still bugs in at-hdmac that can be squashed by
>> using virt-dma. I'd like to follow up with patches that integrate
>> virt-dma logic in at-hdmac.
>>
>> Cheers,
>> ta
>>
>> [1] https://lore.kernel.org/linux-mtd/20220728074014.145406-1-tudor.ambarus@microchip.com/T/#u
> 
> Hi, Peter,
> 
> Looks like I've already caught an oops in at-hdmac driver when not using virt-dma,
> see below. Would you please test with all the patches from [2] instead of just
> using the patch from [1]? I've run stress tests over night by using [2] and
> everything went fine on my side.
> 
> Cheers,
> ta
> 
> [2] To github.com:ambarus/linux-0day.git
>  * [new branch]                at-hdmac-virt-dma-2nd-iteration -> at-hdmac-virt-dma-2nd-iteration

Hi Tudor,

This last one feels very promising! It's been running for a few hours without
incidents, so even if it isn't fixed it's several magnitudes better.

I'll leave it running for the night. Fingers crossed...

Cheers,
Peter

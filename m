Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85A4FB0AB
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 00:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiDJWaV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Apr 2022 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDJWaU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Apr 2022 18:30:20 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2111.outbound.protection.outlook.com [40.107.115.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46AF1BEA4;
        Sun, 10 Apr 2022 15:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkW9+6IVXUjZ2aL7T4RZdb7/p+2AVdtGmtDGzRD3VTcvs0ft8fTq3x30Z44fGl4jFtC/XepiWO64E46bHy1HAPJ39ShYRs2QWyaHRMdtClyDmrIAP14sMSnZylUrfnLXvo547tP/+HelDwWcO6VEzd5wKC/6t3KcCfunj3jy++AIoibWffWo3AZJJAeFbj94FprZlTbErATOZwKt4RWBbYXOYqxSKJ1wsltulzrZ4AUNiESzdmwC/r/AVQQISrYo1I4aVD1gZmiOx/9dca+0kBP20KgyIT/Q3w6GAGzhIjcJr3l4zt9XCAY093sLY4/9dbVLm1GhTt2RsifeybcDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvYovq/7i+ygx/P7jmTbZMO+eLtuNmP8XJBRqGPQ7wQ=;
 b=UsabgTsqXSEN5pA2kcIUtghcNcQxZBNXwgvKd6JeOxUg4PGZhNDOIBJySQ4s5BJLjspUUulbKjVRsZ/gulclEXHSmffzYJqExfmJCDnnepGfTxgl8/Ol8pOfZVezqqYjSY96DpuhAQiHT6KfgYU7J5+eaXjsRfnz8LBHVGip2cTlHk6jlqjydbWfgUbphzl/1FfewoxQiniNN+UG463N7I9VwjXSsx5KHnIIhsSAs7Tjdyk9dpxjWr/g/27lQinTXcM0rZaCE+i1c03bLTjQJPeoEPNUbkHAf0fsFXeAfegfQaC+JPT7BqR9P3MbN04QbbPKJOOy6FOJdZU2MwUHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvYovq/7i+ygx/P7jmTbZMO+eLtuNmP8XJBRqGPQ7wQ=;
 b=eM3C0IB2nJ8LV9juG9+1nAyHXMZRtDMEjD2RogS70TvKxJrW9DB7TnC1/D1YzVDEGd8EJzx258aeGoNqXLC7bMNxDhdijLa7yZi7TnlwJR+hK/OUolLRuDAenv0k5zDOyltjVmOEzIiJNuWwtbNi2V3F+wLE8ohLrd4AgMiloOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YQBPR0101MB8160.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sun, 10 Apr
 2022 22:28:05 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4d4d:1d22:58bd:2f76]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4d4d:1d22:58bd:2f76%5]) with mapi id 15.20.5144.029; Sun, 10 Apr 2022
 22:28:05 +0000
Message-ID: <3b26a4e2-93a8-8b3f-20c3-c1593ea0d48b@lenbrook.com>
Date:   Sun, 10 Apr 2022 18:28:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
 <YlBzQpWEqMHz/HsU@matsya>
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
In-Reply-To: <YlBzQpWEqMHz/HsU@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733ab89f-7017-4a49-75c1-08da1b4161a7
X-MS-TrafficTypeDiagnostic: YQBPR0101MB8160:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB8160F1B9BDD99E91C1507150CDEB9@YQBPR0101MB8160.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzO0geKOri0WhutUd8IAGJhjOGJWN2RN3uex94sHWAZBe8/d9mGvAoeLvwdGqahgUCeU/f0dygVmPN7SaKSm8LGIYlfLuyvF2Q8y5akbhrp5XDci+QoR3pVBPkCFEhLH34IQZBmUnoArJamug7ta52MAGjCST9QBXo0Rr25dqsvJY4Qbvqak61XrcYCKnt99usGkwANdWs9lqZVBDLAcweyl4OlAJYnvSAKG+ZjZQSPtAxnCcG7TAExsxEe0XlVeSwE7Em9XQb4xABxmL5tpwPeaRVJC5FE/v2e/wYfceBnXSoa28jqnGUfRvvX87znKBtEOYlUHV93zC9piVw4hW/OLRwJ4d2mctA3agP4U0PpsyCHRGPaoVlVbWmsVy9ctrg+cnp9mtvIs3KcI/u6Im08CqPS+ZKIO3uLWiEM1Z2CPQRQp9LfIkb4kSuVdSwjzDdMUk+Mf/w2v7Z0EQ82EFS6hpbqEovVqcBTICM9ki2kIW8rs3Q5DzBsqALyB5dKrd96o9mxZXHZXZryyUIJOoSfWGrSu2dmF+ywF8X5qpFInK3M4QZWBvB38ozl2qfLg5P2bXog0RX9depEioiMLfjCmkzZmSsbYIhlqFnrvIOeyg8sRAYk4wnnWEYOxu4wb5VW6pX3Fj9QHTKcqvp1nAtMY8IObuiw9zMZa08wsN8MnfTJQbyOrwPQeO5N9ivwbDXZNiYR9U2y/wkR5zYSuIWbkiRQxuiWFzkEM6ugcZGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(53546011)(2906002)(36756003)(31686004)(5660300002)(4744005)(6512007)(31696002)(83380400001)(26005)(186003)(7416002)(86362001)(66946007)(8676002)(38100700002)(2616005)(508600001)(4326008)(6486002)(54906003)(66476007)(66556008)(6916009)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtVWTFsOFNpbThyWDlaSlRDdXpYUFl4aVBNZUpaTGVxallEeUlCMGVwQVps?=
 =?utf-8?B?S3RaZjB3K01mMENqU1lsZmlUSG04TE1ZYUlXU0hOZXZIajRmK1cyeE1zRENR?=
 =?utf-8?B?ZVlaalY2OUdBWE1yQyt3dlhmTEViZERSTTdBNStjeDJOb1pMVGZWTGFwWVVQ?=
 =?utf-8?B?ZGt6Um9iOTRPTDdVbkxpdzVyQ3BscU1Gd2Frc09vTkFybWpaT0FWTFNxN0oz?=
 =?utf-8?B?V1o2NW96bjVXS1lvdlRSR0JSNUNicEFyaFVYOTM3Zm1ZVzRyQkUxKzQxZ0RL?=
 =?utf-8?B?UGdIQVMyZHRMNkQ2TFZOMWxjeWhBTTdjR0k0dUwxOCtEZlJEY2xCdGNzcjR5?=
 =?utf-8?B?a05zRHVpWnYxS2thbW1XQXVmZEl1V1ArcDZSQUIzNVQxcDdUZS9mWmRYbnRs?=
 =?utf-8?B?ZEl5OWtuZEZhQitvb3MvWWF4cnphblZRaGdZLzIyRDBmSjFzMkxjVHZLTC9P?=
 =?utf-8?B?V0RZQ3orQWNZakROTmM0bGVuT0djejc3RGNVTjFXNklEZ09iM2FKNnhvZ0ND?=
 =?utf-8?B?UGJGV1VlTVhBbDVyT1BKVDVlN0F1eHdQbVNtSk9rYlB2c2RHZDZ6N2dZKzZB?=
 =?utf-8?B?YjBycXhjYXU2N1FJMXBuTys3NnkyYWt2bUJUczNUci9mWmc4czhjWUNYZ25X?=
 =?utf-8?B?NlRhUGxsZFp2c2l3cDFsQjNvZTQ3dWd6Z3NJeElBK1Y5aWVGUklnUTJCb0p5?=
 =?utf-8?B?RWxHRjNzV2YwNGZ0bXdoa3R4WkFjWjhZck13cHVUTGpCSnJrcndNZHhkZlEy?=
 =?utf-8?B?eFBWcVNaTkw1Szl6ZVVGZXByWUZTaWhUQzl6RGxhdjB1T1VWdFZ5Unh2c3Ji?=
 =?utf-8?B?WDRQWEdPV2JMdlBKUkQwaW9qMDVEd2Nka3NndUJ6TjlzNU1TN1M5ZDNNRmE5?=
 =?utf-8?B?OVZhOStXUmFpQTZOcHkxMVBwdlI2a2RnWlNtdDVzNUJaMnFvQVZyc1ZoRFpl?=
 =?utf-8?B?amdBZnpiejJXeGtCK3RjVDdvVnVHVUduNWphT3dVWXhiMWlCamxlYzJIN2J5?=
 =?utf-8?B?SW9YVmtFUnZLM0JXSUVlR1lmQzlSamZhUjBjTUluL3pBTHpzb011QmxLUUR1?=
 =?utf-8?B?MXZHNVdEekhkU2tBa2VXTktaZGlyNlltak5Vek41N29yNGFJdDhnRDEyNWZW?=
 =?utf-8?B?MHllYTg2MkcyUmZDd0VMOGhoeWJ3aDdzZ2E4bkE3eUVaWW5idGxHK294SXpS?=
 =?utf-8?B?MzNZbGQwOG9TTkhXUlNqSHhnOUh1S2pyaDE3UVlzYkExOFU1WWJMbStNMmx1?=
 =?utf-8?B?Z0F0NElLMFZpTFNvdEhVWFhCSUM3MUNpR3R3NXFUbjNOU01JdjBCSWpCZlBF?=
 =?utf-8?B?ZFpIVXJhQ3hiNnd5NVpYeVdQeUx1ek9iaTMzd3JabTg5UWNNdmNiWTJScDQ4?=
 =?utf-8?B?SUJMYnFnTXJRZFMxdEFRS3RqZFVIbFB0c0pGNnlaVmdpVVBzVE5kTGFORmpn?=
 =?utf-8?B?czlGTzRsUFJYVHRaOTByRDVVNW1SU3Vhd0RuVENZNFlzWVhSaFhOK3h1enRC?=
 =?utf-8?B?WnJwa2tQSDRUa2xjUDBPRWk5K253VWFYbE4yT043Z2pDKzVYYW5SY3hZVUtW?=
 =?utf-8?B?V3B0djFnSkxJRS9VN3BKODVkUGd6QmVISXpXRU91T2dYMUhLZWo5dSt5WWFB?=
 =?utf-8?B?VWFQVDJxMjhHRkV5WDVnYjFZUzZ6V2NNbkNCMHR1dHlWQTRNb1Z4c2RTUzls?=
 =?utf-8?B?Ri9tZ1BGTjRjK0V2djFlVkJnTjNZb2NQanlwb0Y4Y0R4RUdUYytGbS9lakxv?=
 =?utf-8?B?NTlZdENOcUxqVkZ4Z0NJRXhyeHBIajJFWExhblZnRDNyK0lHV1dPdzVoQzJG?=
 =?utf-8?B?bUVoYUZFcEhLL0p0RmJ4S0NHWkRsVEViRVBhRzNIOUt0SUtySDR6dGFzTVF0?=
 =?utf-8?B?ZWkyeGpib1hQZ1E3WWpzMnRLYnRRT2JFOHkwdWNqMkpScmZaVmtqMmoyekdk?=
 =?utf-8?B?eXExWEplWlE0ajA0UEhhc2NVbWc5cGZjV1ljRDlEbDhRdXlLamIzRHZUcDNy?=
 =?utf-8?B?MzRCRHhqaDNZQnRqQzFkWkl5WUZ0LzdESWMrWUdkMlhpZjROS3JTK1dMdTBz?=
 =?utf-8?B?MWV0QjFYZk1kSjI3cWpHUlhJajUrZmV0cVZIMnIvN011YkNSempaN0hhTVZC?=
 =?utf-8?B?WGJra2MyWlV2RS9wY24wemVCNDZKcnBRazZ4anRuMk1lNWNmU1ZYNTV0RE9w?=
 =?utf-8?B?YmlzTGNhc2hTSncvQUQ2VlEvd1NKdFVTZ2w3NHF5L1lNL3BPdUxOLzdrWmZs?=
 =?utf-8?B?NWYrNmlkNm5qQS9DNllJdGIrY1VDemErV3RlT3V3SVZvcWlwKy9IUG52eW84?=
 =?utf-8?B?czFhRnY0cFc0Z1g1bkR1bVNRZ3hWTDEvd0xOTTNrRlBvYTZZM1ZPK05MSGsz?=
 =?utf-8?Q?hk8lkr4qPN8f1YvU=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733ab89f-7017-4a49-75c1-08da1b4161a7
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 22:28:05.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJAf7mRJwsDlnluqll5twn0WncEWO/hfqxRCFYVdFbmwnWBh+mgWNqSicx7t8zfadPPJY3mRz8300MOBng9tx0iwjUIh+mKdjIFok9L2JiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8160
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-04-08 13:39, Vinod Koul wrote:
> 1. Patch title should reflect the change introduced, so the title is not
> apt, pls revise

In hindsight the title was not very descriptive. I will update and send 
a v2. Maybe something like:

dmaengine: imx-sdma: fix init of uart scripts

> 2. Is this in response to rmk's report, if so, please add reported-by

No. I am not even aware of any report on this issue. I discovered the 
issue on my own and found the problem commit by doing a bisect.

> 3. Lastly, I would like to see some tested by for this patch..

I have tested on imx5, imx6 and imx8 systems. I will add some brief 
details of this to the commit message in the v2 patch. I am not sure if 
I as the author should include a Tested-by tag.

>> Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
> 
> cc: stable ?

That sounds reasonable. I am relatively new to submitting kernel patches 
and that thought never crossed by mind.


Kevin

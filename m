Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC37585A3F
	for <lists+dmaengine@lfdr.de>; Sat, 30 Jul 2022 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiG3Lhu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Jul 2022 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiG3Lht (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Jul 2022 07:37:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2124.outbound.protection.outlook.com [40.107.21.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE825597;
        Sat, 30 Jul 2022 04:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htk8YeUIRcIHzPqgQYPA+6Z8Lx/RljwVbAzywvrHEbHOFHCLTy+EeNadvTfl2y0s4NbBUuESzivzx9XtuF6/XIc1vUWiZ5csQBZwhgXfCunlrmiDou4nKWSOx7975Bxd/sW7a5hGPil2DfHRDQhLa31yMat+0iRHXkfKkHUax4FF34m8eLBYU1vgQDosgGaJTahmEfQokw4l8G/htbr+3f5MRkVq9UTxJ+6JHOVrkdw5UeXfpk0E/arUSF2Qo1V8RS4EtOwKeeIwUyTlo8zT7a/bgDeb6kOmzJ/V438pr32vTzf1XY6pdTOsRfTcn2IcloVpZoS8ZaJ9e3bLtI5D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN+OPPi+nA3ELDc868OEI4uZ5peM7v75Gx+Px7Ok0ms=;
 b=LFO9uOXDYPIPYbtkZS27EcYgWSzFCgiYMGH/1KxQ2L4GBT8rDwnIVJJXLp15v0rsjpC01YVfbtMXynev6epNfZnh22x2SfLLr/hAz/pE3RUt1wCGOFPgJtNVHy1XUuR8dLnMuPf4TWYxzsUI2EI3JhMwMLSVgDfWpy+uwsY3bsDCZJdYwiHynW+QjJoEXgX7+fRuWFLQCh16JjNss4bPihBHxWNBH9610uxUPgswgELQFdySm0rx9LQ+r2ww6i4Sv4sFfZxx60wpmi1CG9Xx2J/wPcZ4Jlm2FwWXCgdMeO1DFVFwhOIec974hLcisq5j7yO6G+3Tcy0fNQq+JFDvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN+OPPi+nA3ELDc868OEI4uZ5peM7v75Gx+Px7Ok0ms=;
 b=U8DHevaUAgFJ+KK9Pq52uzcwV0ZISpaJT6xO/3j5Ey8/Hb0Xbd+Uol+Ule/l9EB9pXuyREZluinqcyxc7b5Pw6KOg05Ex1aHgmgyFJ9Rj927brOc1vKbH1anIMl5xLSC9SkMlBAYGs+r3kKSoCvGbOD6Qb9ptuTFYgeT72xDlGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR0201MB2271.eurprd02.prod.outlook.com (2603:10a6:800:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Sat, 30 Jul
 2022 11:37:43 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::90c8:5675:c744:9403]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::90c8:5675:c744:9403%7]) with mapi id 15.20.5458.025; Sat, 30 Jul 2022
 11:37:42 +0000
Message-ID: <ae13fd5e-050b-b41d-b8d5-c8b339ee4528@axentia.se>
Date:   Sat, 30 Jul 2022 13:37:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Tudor.Ambarus@microchip.com, regressions@leemhuis.info,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     du@axentia.se, Patrice.Vilchez@microchip.com,
        Cristian.Birsan@microchip.com, Ludovic.Desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        dmaengine@vger.kernel.org
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
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
 <52c3b37f-dde2-9dde-df92-8ae114fa43fc@axentia.se>
In-Reply-To: <52c3b37f-dde2-9dde-df92-8ae114fa43fc@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b74f7d-533a-4ca5-943c-08da721fea34
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RNeKaiRypRVxp/G5mKcIF5GCfHl65CEYhkCnxJu6Yzec69hPZ/QQzi5qj3O+9Ur2r6P38MjS5oMv8S3pS0mLPlJg+mnnfu15cL2lC0lHFtaWS5Z8a+59hZAAUJqOWpbNCYJWLeHFM+xvv3Gxszg0GHZbJ4TIYFK9zrFAobD4bvQWnjWiGqxbmcZi63kljC+svI0gJeBwdojqhmoC9/9w7x5UTCxgEmsl3NC+4qDIb2hmBGKBxOly46X0wCcUS74EUJbjvNx9dw6bv/MOqoMRJZlJGBYYOBNGgFK/E3qZcA8vrg0nAtZXGa/nD5eVR+cVEy2DVvkP45NTKKA3tho3LxDwBS6WKXhZe03XnEPJh9TP01efSZubeGHzHI6Q/hq95YNP8pw9pHs1sJ71ymq2RRF+edbwJNWl/CMMBZQtW0DXO7IaD1Bm2KoC/O/uAGCqzz+SeVrI/vTGp4uMsRACVi+LuNx2a7YjaCwV2QOs2r1+FsJLcxEMdoUZRGUPsjqZFGtlWhbK1XRmaHCBW3crPQKfjueyM3HcCPJiu2nWkdCaQFWiWT4hKgQFGjsiqF0QgZCfym9erpl8CcUMdusqlzoqMWk/zbUapOazdqfA3m2qBBFurCcPqsj085JJsRWNIcWG6fJom1ZBf4vifgNbMyNzjxx9mez2FDQcvuWsuo+2WFxemz2W7wVWbpKlhpPGZeoko4iFb8ia4/F1ClJN/Yfd9QoOqeXbfT5F22JaKSjqUW5vK/SORdWtCKYfaIwbh0T11hBa3BRGzu+Hys0Xs5akC/uAmW93hL/wjOhi4V4StTrYUZASSVNQkDdLOm5LsJUUBEbJcQA7Vp6vuUgIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(136003)(396003)(346002)(366004)(376002)(2906002)(38100700002)(478600001)(7416002)(6512007)(6506007)(6486002)(41300700001)(26005)(316002)(4326008)(8936002)(5660300002)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(186003)(31696002)(36756003)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW0zZng5d3ZCNFZUU0lkbnhTcVExcDg2bkxiZklNaktqN0tESFNqd0ZjUWNY?=
 =?utf-8?B?TU1ldkVVNktIeno5V2liYU5RcVVKOTZ5UHJVYXoyeU8yelpORGUzMmVaUFhK?=
 =?utf-8?B?ZSsyMEZHWm5qWWIvSWxBa3VaRGpLWmlpWWhDNlhQZ1NsTUVWb1RhdmtnVnVW?=
 =?utf-8?B?ZnZYS0FOaHRFZ2FPQno2Y1dIVXBicE1wUVNwRmt6TEVFdlduRVg2dTNLc0Fv?=
 =?utf-8?B?M1ZKWjNCajV4R0I4bEs5V2NVY2FiYS9jZ2kwakhLWndLdzk4blJwREJOcE5O?=
 =?utf-8?B?Wmt1RGNFeE1CYm9NRGRSYi92M2JkeTFMSzFhc1RPOTBydkZDWUVOUHJTaFNY?=
 =?utf-8?B?VDMxVmpqSDFocy9jWGh5dkJIYVRYdVBOOGlyeG10ZXAzeEJQK0RtaEZVUUdZ?=
 =?utf-8?B?d1hCWVkzTzZHM2FoM3dZS2RNK2FpOENrSkZFZnJLTW95aGVVYWJ5Q0U0YnFo?=
 =?utf-8?B?MHU2WXNMc3pIQUZLQ2Exc2Z1NC9XMC9uMW9JUG5jT3dOOEhlU09XM3lTZEEv?=
 =?utf-8?B?aXg2WXdRVjhURWtWSHcrQzBVS012U2N5c1h6bzBQbnVPY2JjT3BVMVdzam9y?=
 =?utf-8?B?RjgxWmdjM09na1Vlakppb016V0NGaWxjenFrdTRkdEpRazNrS0xyN28wUmNF?=
 =?utf-8?B?NURzWEIrY1IrWHNkZDQwTmxoVmJhLzBibkM5d3dpSTdoNDhzY1dpekYrSEtk?=
 =?utf-8?B?VmZzNmNFSmVhVFpYd2l3RXFKUVZxSDZSZG1Kb2JMZ3UyeStJbzZvKzhUY29T?=
 =?utf-8?B?bldrOU5NNkVibmhiMWcxQndDa200MlNQUVAwMTZiV2NSTXpVT3N3SHZvVHp1?=
 =?utf-8?B?UitTNTJ3a3NiT0M1TEtIUXo2U0lyYmNoaU84Vk56dmNiYUZwUjV3SEt5K0U1?=
 =?utf-8?B?Y0hUQUwyUk0xNENpUkYwTzVvY2lCWk1LT0p4c0NIYUo5N3Y0ZkVEalJiazAy?=
 =?utf-8?B?VWp6TjRaRUJIQnVHcy9tWWZ2eTljZENpbVFWa1dBSmlTbFRtNFFJY0xrL2J3?=
 =?utf-8?B?Q0JNdkFTM29lNTZ4bjVzVnJvUnkvTkdwNkxhRm1UbktOaGkxcGhuY3lvU1dC?=
 =?utf-8?B?N0xYS1R1MWRTMkRROEN5OEVnZXpNdDNIVW5LRWIxelQzWG5Id1hUOXpnUXVJ?=
 =?utf-8?B?dnZETjRuaEZIMG1wZjEvdkQwaUk1SERUUDZYVThZYzhtcGVXYTVVNEsyeDNU?=
 =?utf-8?B?dTNGejJ5WGdsaWJMc2IyVjVHVGdyS1MzKytVSE13UHluMGJtdTJ3eFZtZStu?=
 =?utf-8?B?U3pXWGlVdUxxMjIyeFBqRXhkWlJCYzgxZjRlU0dmanhPN3M2Ty9nRzdVNXNI?=
 =?utf-8?B?NUp5bnEzQk1DdHZYdGFEZWYvTXZVdDYrdjk3bjRFeTdJSTdIT3p5UFhSN0pG?=
 =?utf-8?B?NnJrQWsxd1F0elZOdU5VVUluc2dPbkpUeGMvdml1ZmhFcUtqS1czMEUrWGJC?=
 =?utf-8?B?NFlYR290R2dzRWR1UUtzRFNqNUZNREx4d3pndWVNZXJNSjluczdESy8yc2Yy?=
 =?utf-8?B?TGl1YTBNeEYrTzBhQm50UXdFVUw2OWg3NEEwSXQ3NVJLVWZNRVR4SUdMSmla?=
 =?utf-8?B?TG4yUUFaQ0lZcmxDbjNUbk5ObEV6ZnJpeGxJZU9MMDRvdjI3cS9mL3lUUlBK?=
 =?utf-8?B?U1o5VGkvenZrN1dmWm14QU11TnJPRjBhSm1rbHlDWm1BenhOaHNydkVQWStC?=
 =?utf-8?B?ZnN5enQ0TWVDNzJFUkljM3VCMXg5aHh3aGlCU2Z3enEvaGd6eWh0MzJwMTB5?=
 =?utf-8?B?cUxHcys5SGZDbjlJV1d0UE1tM0Z5RWhZSklzTGlMcVVuZ09HSnFXejB4MzU3?=
 =?utf-8?B?QklyMWthZEZ3eEZqRU5UTEdLNVhpV25zTG1SUjk1bWZtMkpMRC9GQUlTdTNw?=
 =?utf-8?B?d1ZiUHE1SHVwNGsrU0RjQ3NMZCtRQVpYUksyaVZRZ0xYeGU2bjdpdVgzNG12?=
 =?utf-8?B?Z29jYWJLMWpvdTZTQmVpU0MzVXE0OWNtK1NIZm85MFFZenlSc0NtUDVZZEpq?=
 =?utf-8?B?NmxkSTF5eVpFVXA4UzNWNnBwZWtvVGVSMjNxWlp4WEFteHZuMVEzQ2kzQk8r?=
 =?utf-8?B?eTMzTERzUW85bzY1bXhVR0R1RDNUbjVyVExONDRSY1ZIUDZ1Wmgzc2VMdW1R?=
 =?utf-8?Q?LZaxD8SbyQ5ujEkiiN8mXBpf8?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b74f7d-533a-4ca5-943c-08da721fea34
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2022 11:37:42.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g/uoCDfDWQA+aHn59hmpNL1xLD1GzkV6Le4Ns4TDTP1o5r/zgAJl80ob9H28Jdr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

2022-07-29 at 22:09, Peter Rosin wrote:
> 2022-07-28 at 10:39, Tudor.Ambarus@microchip.com wrote:
>> Looks like I've already caught an oops in at-hdmac driver when not using virt-dma,
>> see below. Would you please test with all the patches from [2] instead of just
>> using the patch from [1]? I've run stress tests over night by using [2] and
>> everything went fine on my side.
>>
>> Cheers,
>> ta
>>
>> [2] To github.com:ambarus/linux-0day.git
>>  * [new branch]                at-hdmac-virt-dma-2nd-iteration -> at-hdmac-virt-dma-2nd-iteration
> 
> Hi Tudor,
> 
> This last one feels very promising! It's been running for a few hours without
> incidents, so even if it isn't fixed it's several magnitudes better.
> 
> I'll leave it running for the night. Fingers crossed...

Reporting that it's still all good and that I think it's time to declare
victory.

Thanks a bunch for you effort!

Looking through the patches on that branch, I suspect not all of it will
be submitted upstream in that exact form. Please let me know when you have
a cleaned up series so that I can retest and add some tested-by tags to.

Cheers and thanks again,
Peter

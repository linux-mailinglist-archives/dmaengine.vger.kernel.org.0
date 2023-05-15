Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5C70271E
	for <lists+dmaengine@lfdr.de>; Mon, 15 May 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjEOI0R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjEOIYP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 04:24:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B0171B;
        Mon, 15 May 2023 01:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5BUWeX0s7KGIgMkocWoV3sCZarSQubZnPINEi//y7ymKPUNAazJvrvRx7CPLwmQF8RqRmN1H0KaxXAwVWqs16w2tNkEwlbkilWmPkxeaRllwrTtzKw4O0rQdoP1fFfzTM2MriZL4k/Wu/MK/fnum1sixKAoPVbrKRJ33djMvKuk7RpwILOp9Y5HU5NZkhyT4+UKzDtzPPFy0bOwwRz9ba4R03N2U+kA8J06t0wqjKNQ5cikZqRoHv4a92/aLmyZduzEJRdPA/3TVT9UmP2Mh+6iW3Nqz4Dz413u+g0coB02exXaCs4OGSQH8ZWyhhdh8iKCf+XtcAi12tpZsU67TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAv10xk9gAwY00Y84Y/jdiVSr2ipnPhGfXs3791lGdo=;
 b=Si3VyNLk5QukRZhRIZGGSodBS4zs1xWkQhJ4oBnDLdZL7M9fqfEcDU2iKzbXFh24D+DbluEr8K8K0kg99LTiR0ZUgvH/ucQBwF7bely69GcGYBJ/lVhK7pri2LOp1M0+R549kEJvdLL3jQf1ucb2ccb5cZ2UDzCFTTnsIqnXHnSPYJenFrN3NudvSeZNsNe49Bb4MY0ALMOGQ+P/5rHPYHo7+hxkVtLF6fwcefs1Cg/cb98BmMCuKHoIYJp6Upmgjz141RI4bhkT5oljuDmw9OUW0An8U7TTeLsRjYwpOiKZbvAT6gUQnpP161aBrj4G0cwkTEwM4XPYqRHzNOrrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAv10xk9gAwY00Y84Y/jdiVSr2ipnPhGfXs3791lGdo=;
 b=H4YSLE5ayPgWqKRix0laInWEXffwcNupTwVr4upXgA36+Do4Wj5EddWgTCIo3V3UXoH03fuJLwXuIqXLmkm2cj+pd9MaVSaY34oU3i4D616huOMLUGecxdKon78iOb9my7z+BZDrVAyKfBetqz3wVWdmqOn+TkErAuYMkqDLZ5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.25; Mon, 15 May
 2023 08:21:26 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Mon, 15 May 2023
 08:21:26 +0000
Message-ID: <6d34bbf2-4864-67fc-8d5f-813471f57080@amd.com>
Date:   Mon, 15 May 2023 10:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <8f5651634df338743f95a7253a741f9ddc92487d.1683891609.git.michal.simek@amd.com>
 <20230512-urging-entrust-4cfe21b362dc@spud>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
In-Reply-To: <20230512-urging-entrust-4cfe21b362dc@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba0aad2-d584-4cf7-435c-08db551d6038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRXy7g0lJgGLLE6ljwjbEvoR+3uck4u7RQSwMlxlw/FqXoFC8c1BfDHPP380UNN8hyjlqm6CRGspz0ngrnIrT2CbNeRirgrH4QYxSoDKdzo0dnkuAHRobk+uF59JEMaW62pY1vBNlcYGMyvBZFoHL0+OkZq2wdOOQy46/NDJOi9LfXFOHhUFvozW4ez7H/lpgsnX8l8PTUWwtKwfNRVjVqumUHNJFZbmX2PIAuFc64o+3C070rD3TRx3waCYRDjDOYhKMD84wIh3ElpiE1YsiyishubQ6E8CXNgBeLg867SFlL9dLzIGy2CXDkWiG+GTHZc06u4KZwpAHAKW6H5/zX67uTctzR7er46LJSfkt1p1ctRoU6DV6jBmzhJALXHNmFZ/aFgQxc08wjvMdELwEklTt0vuCio99eTfduS2KG1UrH+/ItHqJd4Riz5BCX4baIabU7hQCjr62bahfstlc246SYYHU09FjmXiWZrBqxbB59btFOxcCypJZw5F7FJTKsROOo2304dpdQXJ+Ggf0eeF4tjI88vtZTVYuKddZMBGCj4fAWiSfcKzALZ2c1m9LsIoc2ccp3lq//fVweu9dW8DVnrioK74TcwFTKvibJz6wN6Wzmtag9ee0Fr4izC+NLWJQFxCOOy2OG0rxq84DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(478600001)(54906003)(8676002)(8936002)(5660300002)(38100700002)(86362001)(36756003)(2906002)(31696002)(44832011)(7416002)(66476007)(66946007)(6916009)(66556008)(4326008)(316002)(41300700001)(2616005)(26005)(6506007)(83380400001)(6512007)(53546011)(31686004)(186003)(6486002)(6666004)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNnei84ZVJVVlNGWXpqc0x0dlNIeWM0Y3Z2R29KNW1lODdwYmpzM2o3Vm96?=
 =?utf-8?B?VkVKU0xCVmJjbXg1cy9nNVdzQklmckhqcWh1RGdyYllUSWFoWnlwNlQ3R1Ra?=
 =?utf-8?B?RHFNVHJvVDNnaXVza1NuZ3o0VnQ5bklGUkxuc3VxTHFmNFRTRGJXNDJ6eWI2?=
 =?utf-8?B?dTVLNVgyb2NTRm1ESHhwNithbWFCNXNYY1VsSFgzNnZCbFdTNnVwM1I3M2VX?=
 =?utf-8?B?cVkvQ2ljK0c1cGlIL1pXR0dROTl5Q1FwMlpiTjlmd1Y4UXFjR3NaUEQwM2U2?=
 =?utf-8?B?VmcveEp5VXM0NHl2dGo2eXNoV1JSeXBESnQ5WDZwd0FNTFB5ZEhYaVhtMHVF?=
 =?utf-8?B?N1RmRnVuTWk1K0lxWFFrNjBhRGNGNGdXQzYzRHVmVzd1UHk5TEF5aFd2K1I3?=
 =?utf-8?B?STJuU0JERlBId0RWYWgrSUFxcjAvaEhiWkhsUVBCek5oVUxURTJGNURFTGpV?=
 =?utf-8?B?Tjl2Y25rL0tWelZ0NGx5UTBLQzJVbk9XTEw3MDNwME05eTJpM011WHQxS20x?=
 =?utf-8?B?UnR0SU91dHZ4aGtrb25qNkpoaWE4bzlnWHpHYjBQYTNVWEt0K0lUT3c3VFhI?=
 =?utf-8?B?S2dVb2Y5WHJEY2xWSmh5Vm1idG54OFlMdU1tYVhyME5MbjUxcy9YY0RmbHFY?=
 =?utf-8?B?VVV6V2FOei9DY0VIblBCamZKV1VJekVCQ01IaXpqSkUvUi9Pa0ZqTzZITE9i?=
 =?utf-8?B?U3BBNThSY1diUFNnaUZGblJsN0JwSWhWSHgzZVZ5eFQ5c0FZTU5mdjFHMDV2?=
 =?utf-8?B?VnBzMDVrZG9QV2sxZmdFVjgrUHN5MjZqaUNzYVVQMHZsZU9QdjZ2Z3ZCZHlh?=
 =?utf-8?B?QXZwbUpydzhhZzlyVHpyRUtZbCsveTFWL0g1dXFZNCtUL0ROclNhQnFrOWhp?=
 =?utf-8?B?NlEyQUxxMGZIYi96YlFnN01jN1dnUS9Cc2ViMUJWWFh6azFicTQ5OW1DUE1Z?=
 =?utf-8?B?WndGb1cxeEdUbHlYeXRvTmNvR0sxSW96RTE5Zk5OQWNvbnBZTG1QSWJCRlB5?=
 =?utf-8?B?RDU0REtHTzI2QnNrc2o1QWFYQ2VTTHZBdHpWeDJ5eGdmUHNlVU1aNklPZEkx?=
 =?utf-8?B?TlhOd0N3ZG1kc2QweEUxN3o1dk5BYVJtODV0ZkhtL0IvUnJpbW9lSUxkQkNx?=
 =?utf-8?B?TnhwSkpHT3J2cXFBWFZDUlQyODhSRnd2UVhGcEtpczd6eHVjbWdET1lIY0Rs?=
 =?utf-8?B?R0I0aDkvVENYczA0OFhEYTJnS3pVYjJGYTVUQ2NDQUhtaDRNMnc1bG5RaWFw?=
 =?utf-8?B?MkpsN3ZDZ25sbHJ3Q1QxVDkxMTNSZExubkdqaVZMSk80V2wwcC9xTUZaNkor?=
 =?utf-8?B?NHJOeUl6OFp4a05xODZIb2NxaUgwUDNJc3N0UGIxbmxpNCtDRXg3c3FRMWR4?=
 =?utf-8?B?elArWlJpT0RmeFRscm8xNlJHZmZSTVRaNFhtNDc4UERpVmdQREozSnNVZ3pn?=
 =?utf-8?B?d2ZHcFJSQU43MkJQbXdEdnhsZ0dyQVFyZXk0dmI2dnJSdGFUSDFlSTZIdkVZ?=
 =?utf-8?B?MmdScmNnNm1Uem12RmRnZVpJSk9xN0kvYVRPNlEyeWJnRllvc3BxYnFSTWl1?=
 =?utf-8?B?dytTbEQrSFZ0VmdheVNhU0wvY2ZhcUJ0L25neUl6UWJueVNuYlpqTEZQUkty?=
 =?utf-8?B?Z29YVURZOU1VMUxJVlpmTkRnYmx1QVFhR3BTenMrZVJMakllb0sxTlRSTXFm?=
 =?utf-8?B?WWYvSUNBcE9BN0NrK3dxT0JpdlZ5WjlHZVpPK0diM3NrOWlmeVlqNEVmVnJZ?=
 =?utf-8?B?SjkzUTBPbzk0OENzdzdrZ1F4cTNoMUJya0ZTMmJjRksvRmNnTURCYUxsam1L?=
 =?utf-8?B?Vk9mRDBUdU5tZkVQUWcvVjZZem1Sb01hbDNaNG5DRFpsVlZ1WjhVOXZTM0xF?=
 =?utf-8?B?RHp3b0lMZkZOZ2k4ZnREaTEwcmxSMnFscGxmdUwyUnJObDRqU3M2eG14YkI0?=
 =?utf-8?B?NmdrTytDbXh4bXQ0eVREcStOR1R5SDIwWDJxdjdWOFNNWnVRdWxpRXlFWnlS?=
 =?utf-8?B?Ri85N1BKYTU3SjE4bklXc2VLUEt1VUorS0IxQ3UzaEtCTTVMUUNSclllMlNx?=
 =?utf-8?B?NFVOakU3eFBDc2hhWWEwM1U4Y2R5Yk54cGdJQVMyRFdTQkgvbHRiYUJQUW9p?=
 =?utf-8?Q?aZjWsKI9vU+U2TjAf5cYpnWIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba0aad2-d584-4cf7-435c-08db551d6038
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 08:21:26.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4UnT5ASVPNI8HsguMR1T3En0pbjSC7LnMAdYnfySy7aOTXwaYi76a3NCRAoImuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/12/23 22:40, Conor Dooley wrote:
> On Fri, May 12, 2023 at 01:40:33PM +0200, Michal Simek wrote:
>> DP DMA has own power domain that's why describe required power-domain
>> property.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v3:
>> - make power-domains as required property
>> - also update commit message
>>
>> Changes in v2:
>> - rewrite commit message - requested by Krzysztof
>>
>> The commit b06112cd5e08 ("arm64: dts: zynqmp: Add power domain for the
>> DisplayPort DMA controller") added this property already in Linux that's
>> why the patch is also fixing dts_check warnings.
>>
>> In v2 I got ack from Krzysztof but not adding it because of additional
>> discussion about required property in v3.
>> https://lore.kernel.org/r/029ba923-d13e-ea7c-018d-95e179dda2e5@linaro.org
> 
> It was not entirely clear reading that whether the driver actually
> functions correctly if the property is omitted.
> Is it the case that if the property is omitted, and the power domain
> controller driver is enabled, that the dma controller will not operate
> correctly?
> If I am understanding correctly, it very much does sound like it
> should be listed as required, so:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

As was discussed there are 3 things here. One thing is if property is required 
from simple description point of view. In silicon there is own power domain for 
pretty much every IP separately.
The second if driver is using it. The third if power domains are enabled in the 
kernel configuration.

On our SOC pretty much we should look at every dt binding and make 
power-domains, smmus, etc all required because they are there (it is not said 
how exactly described but HW have them).

And SOC basic setup for 2nd/3rd point above. By default they are enabled and 
power domain driver has capability to disable it to save power.

Thanks,
Michal


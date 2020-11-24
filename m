Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF82C3181
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgKXT6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 14:58:00 -0500
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:2232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729708AbgKXT57 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 14:57:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIxAEdavaSaRVRYWWnyjHAW28zGM+LLQJZSuw/jffnuBcildei2SHsxMaud1JqrtMrSFLUMR4UgOLn/C9k4jTdLDndBXkpPGFMpkDgQexGMBaBix9E7HauLctsIJnBavKJJ9OfdJoxjo1XZkXJr2vIRBuSEHLeyCKcQ06dLHLokL/ANkg3sd+AHcrqg9wYdXKyqOpyUgISI/UcgrVUZV5tI3F2wD8tM9X3t4Ed/LeUgOJC6V6II2mDsU7l5DLJh94M+0t+mmEgKpopYPIhoMeolYvkMJisjG8mua5vcIyX1F0JKweSh40RLQRftXg+gWvFvJlk+LsxHk70pn7x8GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIu8k1sBggDYRrl/3CPpf2xnP6CK3pgPvAmpSIDAN80=;
 b=AHuroG/WMIV39RurFIJx8RIpaBaRrgMxnmimu7xzx0cXHVgYPXU7TkWveyol1zayMB970cTwTOA4gkLL6kFVHAollr0uU+JkpcO3/jmUPUjFX/iQiuG0pIMdOR0x+yam1Bqs1eQz4CprLbNueMIPJjU/JY3gc+TLM+TabHliIwwCHsdkpmJ/ELLV158uVBy4ZIn9ar9dVnQfKqVJcFH5SHBjsSvrOriian0nUYVa2bdbJ3YF9xUiF9mw5GpZPVgCqJEYAB/bZIaWic+dtcpcoto1Y39rucroUQdqknaVpSU5fNkJJXnbNmZtxDagDd+TjxVSOM1dO/ZdtKlGb7d/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIu8k1sBggDYRrl/3CPpf2xnP6CK3pgPvAmpSIDAN80=;
 b=uw4wbousYHX4gKB3iJYH6LHnOl0KEF7UF/Op1FV4OKZuZ/qgaX2FO5oWcz/QB43jStPjCjPDDMP36pi7yRXhyu83omqOvH3y4IrQ42778hooB1HxqC9fT07agqsN6VrZUR4CvSFxQFPMQttKnZIUGbAWgsWtfg/z/f8QzedFbDU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 by BY5PR12MB3810.namprd12.prod.outlook.com (2603:10b6:a03:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 19:57:53 +0000
Received: from BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::e552:71a1:999d:e411]) by BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::e552:71a1:999d:e411%7]) with mapi id 15.20.3611.020; Tue, 24 Nov 2020
 19:57:53 +0000
Subject: Re: [PATCH v7 2/3] dmaengine: ptdma: register PTDMA controller as a
 DMA resource
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1602833947-82021-1-git-send-email-Sanju.Mehta@amd.com>
 <1602833947-82021-3-git-send-email-Sanju.Mehta@amd.com>
 <20201118121623.GR50232@vkoul-mobl>
 <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <aec28f66-d7f7-1ec8-9d71-83a92b6e1899@amd.com>
Date:   Wed, 25 Nov 2020 01:27:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
In-Reply-To: <CAGF4SLi1qqj6xSBB6=9rS=M_Wvaj9Zec7XzMc7=9EsgPLM21OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:802::33) To BY5PR12MB3956.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.71.123] (165.204.80.7) by KL1PR0302CA0023.apcprd03.prod.outlook.com (2603:1096:802::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend Transport; Tue, 24 Nov 2020 19:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 625c2161-adb1-4151-e040-08d890b33a77
X-MS-TrafficTypeDiagnostic: BY5PR12MB3810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38102106B4B8B81626C7E3ECE5FB0@BY5PR12MB3810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBA9H0JSk52WILW7UjvFINsujsrdifOSHLY3/X8pKxVW4EyVtuQNgMuYk+qBb+aE1uA7Xw7R5zWbhV9ahKJJEDaN+pTHJu5pdYebSzCvP1nnRWgU+ig4w8DvSpCgwByeG7X1vCuT768T9GPTLlI9Zg2WXPnef/nR0jgdEdPSqlPv2bqxf6cKEOc1AW4eHvsG6fCJWPSJ7klPiyOfqiuzdFpZ8ZIiDh39xFCmoR3m1/J5/HqbowV63whfRDjc/Pa7CkxQU0LKqGUHo5zJ8RQ+hrk8ra6nRL+uR0ru9ZDukcSVoeR5CsENTkSvtSuLboS5Oko9mqatWtgEEJ8J7bgfmGuB7Qs7t3b9m49JhepI2RrCP5kHWyBl8vX761RP3Ovy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(478600001)(31686004)(956004)(2616005)(66476007)(66946007)(83380400001)(66556008)(6486002)(31696002)(2906002)(316002)(36756003)(53546011)(4326008)(16576012)(8936002)(110136005)(6666004)(5660300002)(16526019)(26005)(186003)(8676002)(4744005)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTVyZllNb2RkTXEyN2dvYlVHYXlUdzZLVFVTWkFXNGx2VVdHTkIxT3dCRHJx?=
 =?utf-8?B?TlZvNEU2UXJ3V1ZJYVVKYTlmSzkvckx3QXgxL2pCSmdBUXE4K08rQzZBUWp5?=
 =?utf-8?B?VnZtYUdFUkRob2ZrdnZ4OVFDUWxzaklVeTFyZThnRUFoczZ6MkV0S2djMkU4?=
 =?utf-8?B?c1MvNjJUd0RsMEd0N293ZHRURCsvL0Rka0dFL3dBMGduYlN5cG1LRHNKY1Rm?=
 =?utf-8?B?dHZuTWU3SmpWZzdDc25jWkpNZTNzeEppY2lDR01FQjVmSXl3TGMxU0h0Mm12?=
 =?utf-8?B?aThNOEFhUDd2eURXL3ZjaWlBcmxqajhlaWxndm0vR2Nkc2s0V3RwdWpsQm9E?=
 =?utf-8?B?c1BjR3NwdW9vcm5Va1VNOFFmNVk1d0FLekFSZldiUmpKSjNsS0ZhWnErT0hS?=
 =?utf-8?B?TFhwMXNsZm5mK3FROHRJb0kwQk0zaVVVVVpQUE0xV3ZhbVpEUG1hY1N1dWda?=
 =?utf-8?B?amJlUmhPZzF4d1A4Q2RNbGt6NGx1cjQ1M05vYmJZVld2M1N6WGNFMGtTL3ov?=
 =?utf-8?B?K21uSUU0TWxuMTl0V2xscnFJRThYVTArYTBEYUlsTkFQbW1zR1lDNWkyUC94?=
 =?utf-8?B?RWNQaUhjaU1rL2pDQ2pFNXBuTE5kNW04WmFzc21vejZ6ekJ1WGxDNm9Ocjda?=
 =?utf-8?B?cHM1WStwY0JXVHpvWFBPYVRCMjBDS2x0OUE0Y0hRdWFIRjdOdjBRZ3hkYjZz?=
 =?utf-8?B?MEhBc29FR1ZJQWlyenBCd21VdWhscUJkWHZFamRiZkJVY2UweFJkQ1FyTjNq?=
 =?utf-8?B?ME5MRk9iSCsvcUxXZGxwd0J6NXcrMjVhSCt2Um9OMWxyTGdzcklSMXY5WHNN?=
 =?utf-8?B?RHRoYXFkdElwZmV6TjZwYUI3UngydVdjby9rVERZTW9CeDZHa2VRbGlDMDRm?=
 =?utf-8?B?UTdydERRRG5PSEdSaEY5dHZQVXVodVk2WDlWY290akVnd3k4ZUs0UmorTTV6?=
 =?utf-8?B?R0VnZjRiYTFYbGlLVDlBbks0TFM3THUzRUM3ZEpGYnNXVE94eGNNOFFOelgw?=
 =?utf-8?B?dndWZkFOS2c3NFVZRXRqTjJqelNjdzU4c0hEWDdmMGlPRituQlhFZmhhaUNj?=
 =?utf-8?B?elltRUtxcmNhZCsyazg5WGlZYmF1UHRxV1krelByL0l1UXpSNEYvNTN6dWxp?=
 =?utf-8?B?QnZzQTdiU2RhejlrTU8wRWRzRVZwdE1xdTR6OE43KzBBSUg5WmQ2ZEFwSS9S?=
 =?utf-8?B?TURXeG5jZmhlMXcra0pEVm5PTllZQlYzVnVMN0JiYXBFelJtR0VXZVZwYkE1?=
 =?utf-8?B?UVBWblRXcVRtM0J4REhOQS9WKzREWkxzbkRHTURabmRGQ0RpZU1kdGUrcDBw?=
 =?utf-8?Q?rVr0RoTyjYK27fcQNUIOCO7/85iRS4RlcX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c2161-adb1-4151-e040-08d890b33a77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 19:57:53.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDt08ZAlJosRvtefBciUFfrx2nbKGhhqozKTmHpQZV/m3vSOHbF3u3NByWZ0PvE9ZqXezvlwI+MUipUl6s3pBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3810
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/24/2020 7:53 PM, Vitaly Mayatskih wrote:
> [CAUTION: External Email]
> 
> On Wed, Nov 18, 2020 at 7:20 AM Vinod Koul <vkoul@kernel.org> wrote:
> 
>> this should be single line
> 
> Vinod, do you see any obvious functional defects still present in the
> driver, or can it be finally merged for us to start testing, while
> Sanjay is working on improvements and style fixes? I'm sure the driver
> has hidden bugs, as any other piece of code on the planet, and Sanjay
> will appreciate bug reports from the actual PTDMA users.
> 

Thanks Vitaly. Appreciate your suggestion.
Currently, am working on Vinod's feedback and will send next version of patch set.
please let me know if you have any feedback, I'll try to incorporate them as well.

> Thanks!
> --
> wbr, Vitaly
> 

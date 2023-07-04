Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446427470A6
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jul 2023 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGDMQM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jul 2023 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGDMQL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jul 2023 08:16:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ECFE70;
        Tue,  4 Jul 2023 05:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmfgLSqA7WQpr0EpnjOvfUcNx3g1OCE5VH3pMgtWTsLxtcil3gjjxjMqvh9afXsgHo5L1iNeFxZXSSO0WdFEWqjZOIyZyy3rwZ27b+hHha5k8YD27ujY7rFETBndOshGtBEbmvf0H2JT5ay5v5dopin9BSYyEPwMrJfqcQKWECAnUmPaifJyxULfv0d6mU8n2i5UcIIXP6gH5THu+lGgkvARXgBMsKpUz6oRWb5ESzuQCH4w1hXjrGmdCQQpG/sbGr3vNUajXD8U+8wTocIoOX8uk0EaxVkTzBjUuPKH59l79DjmRhhszr5x3ZgYw1695OP0pY1lWFKNrYnN+lrtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F63KrLcXRjfKU22OjEav0GhtBW/SgcTN3m8+1vxXnLg=;
 b=mQvuQqzojkQzyktmkEWZCr1d6BxVypGEsfCYrdYakrxCCRSnZQM1StdDvFrMyWSkIpPZtVOtYAq6J4+rSsIbFHb01dxL+X7MIvJ/dNqyLD57tsM8cLz0Dd7BsCvwEyJ6oJ1qOWNCXIFCkD0dvQ5j0FOb7RA1CqmYd/z0LBL/3OwySvSj7jAnSzhwhzIfKHS6Btjxd3VtC2ivuklYst9jvnQ2J9AJJJo/nfha7AtuTgbIamKqtTd0WKrhgAu74NcLI4/Xbgkx69k993qfA4p51sO0Xwd1nboyFDHeK/b+MurixxEYla0N0liQHHQ+IGLYTE5y2Dopzz1Q1BymvgFh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F63KrLcXRjfKU22OjEav0GhtBW/SgcTN3m8+1vxXnLg=;
 b=SgUOywkRYVL0XP7IhzceKyMQ4nk9jKDUSQbidN6o5gj6YnkYTYfefyj6Gsj+utViJ8HuX2decrFGSuHZE5Wsl39R987Se5PwSTN6Y2Anl0KwlM4anK5OEJu+Cb5P90uB8EnunT6XMmBgS3a6L3+yVsB1JChTy6yoFPiWM5qy/sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:16:08 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:16:01 +0000
Message-ID: <b4e780ed-0ab8-164d-e158-ce9450fee705@amd.com>
Date:   Tue, 4 Jul 2023 14:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] drivers: xilinx: Fix Judgment of the return value of
 the devm_ioremap_resource function
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Lizhi Hou <lizhi.hou@amd.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:XILINX XDMA DRIVER" <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230704120458.11125-1-duminjie@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230704120458.11125-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: e67859d5-94a7-4f78-2abe-08db7c886e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6ZFJURd5dZbKshX2aY9FPxVWdOqjmTFZkBX85EVa8i17VtIaCvQhjtDP8mvQaQATdE459r6qvS+9onL1BdG3NrseHKVObndBZxQenGlGFSHzXv+FRHSQR01lUojSIdKE+6AqntuCd0w71qzcrd/J1K0yzmX4lco9gRFerL49vXwZTcxW4FyOcQOkwzEmBg3/71wsYGBZvxjwxHhpW05G4KZgpu4Di3RMRIiOWqGXRRfjIg5foXlQpic+342n0ivDPppMuEafssufUxIgraGN/3cIvN9WkNcF63pLKfNthEqAruD8ApCaEGBCA9nOJN8QgSOwmJnB96BCzFh8ctHSe8V88eNyVGOhTW4ipoegD8jAQMCC5gnDiOgi4Lid2OH99VrT126WBlARnwsfN1aGcYTtsaaEgYmGCpjVpACsqYLDO1AMhMbYRccRunuGqgEB5GJ3n9xWQlYGuEo/vECNryZyvxTH4zuX1UOGqeYPxEN8rvLZp/9m6Uwp15gcxHlNWkSg3L8ln8qW52Y53MQadIbRXSq5HSpAMLZLz2eXFw1LHXa3GBDCqkS0xWlg3W9sLJQpPiOAG4/hn/MqoJrd46XPgFKdIWBP+sOd6BZ71LOKXb2WIQG8HQKLuu3RT01z4JoxEMc4z85Q8fLc4Takg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(2906002)(478600001)(316002)(66556008)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(110136005)(6666004)(6486002)(4744005)(38100700002)(53546011)(6506007)(186003)(83380400001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRaMGVkaFBKaU1TOUYwaENCSWZCL1hIRTI2YXBSRVFMVUttTkhlYTBkeXBx?=
 =?utf-8?B?d3FkV215eXpFSlduK2tzM1JUdTAxUTROVGNneG9oSGszQ2pScnBCd0JGbmhh?=
 =?utf-8?B?alA5TXgzV0VaNTRQeUJrdUQ5c2l0dWFWK08vUzhpMS9kSHYyOVpSTUpPR3Jz?=
 =?utf-8?B?UE12UWs1QmNFRzh4bTFvVlRqUnZ2TlQ0UUlXMjVRME9VN21Wb0lUQ2tMVU8x?=
 =?utf-8?B?Ym1sQjE2M0JiYTRXaDJ2RzVzdDgwWk1kcVlqelhMNHF2c1VrbG5ZK0xEd1l5?=
 =?utf-8?B?TmdrQk11a1JEOEtXL29CK3dtdk9HN0lvSWZlZWpJamY1eWZpK1F5ZlJzajJ2?=
 =?utf-8?B?UXVsd2tDeGJZUlFKS092NlI2T21Idlkram5tR1NqVzhiaU4rL0hsT0c2ekJB?=
 =?utf-8?B?TEh4Mllwa1FHbzRpZWV3QWxqVGVrY0JCUm4xWFdoa2k2SDl4dFpiY0tZYTJE?=
 =?utf-8?B?Sk9kTW9kZmNaZGZTTk5yNzFNbTVqc2Q5NGo4QXBpK1R5ZUVhRlJVOUtQVE1C?=
 =?utf-8?B?R3VmNkNDMFFQbXpyTDI3M0xidmI0c25WL3dwd2NGYXJwWFhTK253eTJrWk1z?=
 =?utf-8?B?YUNqNVNsKy9McElKemxYcEEraWVSTnNtSVI5dXY1dW1uSHBNVkhUeFVaaWlw?=
 =?utf-8?B?Z0hzYUgzcS92T0FEMUkrUm5taTVoWUZOcE1wSzBqMU9XMFlQMDRjSDQrOTgw?=
 =?utf-8?B?a21jaXdDMmEyMnlrcWd6b1I0QlR6MDRoVlFwRXloVEhBYzFJNlpxQ0JjcUF6?=
 =?utf-8?B?KzZhK0tsZk9saXdkUjBSMzI4OG5DeTJWRk9YTjNGd3plRVZRK0xSNWpGS3dj?=
 =?utf-8?B?MkhLN3doaDQwTHNxREFLU043bnp1WUFUdGJ1YktKRGFIVVZJWmsra2ZHMG4r?=
 =?utf-8?B?eE1HRFUyQWNYcjJ2ZFlHUmZNbDZmK3Q1UjJUTmhjdEI5WTNEMHYyTHM4U0tR?=
 =?utf-8?B?YXZvSEhiNjBYcWlhTnQ4ZTdEL3pxWkRhMzRFNmZ0NEN3VE05RUF4R21OSHpl?=
 =?utf-8?B?Wlpqb0Ewdk8wbHpOa2VjNnVZclFsQmYxRm5EK092aEJKRkRNS1pMYStXQXRO?=
 =?utf-8?B?OXFQUW94cjhJNE1YdW5uWkRCTXJqQ2VYMzNSV3BYTFBPdmdSZjZWZHdHUW5Q?=
 =?utf-8?B?SnJ6Y2xud1cyS2FXM2ljcS9rcml3eEl6MTZzdHNHZW8zQTI1WEtFTEQ5bU5k?=
 =?utf-8?B?N0taMmlQanhWS3JnZG5PMHU5TzZvRmtYaVNONTVvbW53bjF0Tkp2azhnbm5m?=
 =?utf-8?B?TDJCbFNPbVpRQU9XVE1rL0FYcEdrZVVZczdJUVZnZWg4Yzh4c3M2UkNDS3kz?=
 =?utf-8?B?MklCbW13RFZTSG5zQjM1cEZHTDJMdElTLzNxZlBqZzVjdEgxT28vUVI4Z1ZM?=
 =?utf-8?B?eU1NY29vZEJOMHROSHVDUGZNSllCOVBPZ2JTYU1Vdzk0VDRTcFNMa2I0VDZ2?=
 =?utf-8?B?MFRBbVFUdFpkQzdCMnNMNEcveHlQTzN4ZU9XWld3eTVyZU5BV0lKNjBWa0Vq?=
 =?utf-8?B?VCtuaytnL2N1K1hPeVYrZ0RqaFdGS2pGS2lmNkg5eDB6ZHlwSEc5QjMyVzBZ?=
 =?utf-8?B?Q2ZxY2hMVmtpb3hxalpkMlJXeDB4YmxIakFsV2llaXVqUnV5dmRkc3RZNjRI?=
 =?utf-8?B?bjU0NnRVQ2s3dUJZNVBjVXlZZXAwcGt1cXR0aWNTVkRodmVjVTJUKzJtc2ZY?=
 =?utf-8?B?Ylg3VG1nQzgzVi9rNUU2aW5NWkgzMVFoOG1WYW4xODNDOEVoUWRmWVEyU2M1?=
 =?utf-8?B?bk9UTnZCSEQvOS9NOFR4Wmh3VEdacmFPWmFaaEdvUHNyNlpNeU9NeGt3ay9Z?=
 =?utf-8?B?WHAzSzhYVzJUQjc3alBSb1lJWk1IT3BzUVc2SWRFaVJLa1Jsa2s3MlVTdE1K?=
 =?utf-8?B?YXYrM09iSHpySXpzU2dBWXBKbTlFYUhSb1lYZW5HcUdPK2JQOTgwSnNueE41?=
 =?utf-8?B?ZS9OMTJzUmswYitGUkx2U01JQnNadDRRZWQ1eEYxWkZGblpYSEw0d1ZaYkc0?=
 =?utf-8?B?MFJkWlNDQVZrTEV3WGZuQWlEZ05Yd2JwL0FhTGdKQ2gzSDFLYTlMYU03V2wz?=
 =?utf-8?B?aVIwYUhIcWJIWjB0ZVc1R1d5ZGJOcXBZTDdDWkpBU1c2N05DOWZWZXA1UUtW?=
 =?utf-8?Q?p+xQH07BDqxLk2Ofmt0cIaGOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67859d5-94a7-4f78-2abe-08db7c886e6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:16:01.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0Snm92dI1NVG3z9zffvI6kTwVLF4TQzZZ8nogc5FbojtFfk2v5yaYtluWHJciK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Start subject with:

dmaengine: xilinx: xdma:

And shorten description in subject.


On 7/4/23 14:04, Minjie Du wrote:
> IS_ERR() fix devm_ioremap_resource function return judge.
> Could you help check it out?
> Thank you!

These two lines shouldn't be the part of commit message.

Also add there.
Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")

Thanks,
Michal

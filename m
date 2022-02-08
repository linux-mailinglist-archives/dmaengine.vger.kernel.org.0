Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279E74AD056
	for <lists+dmaengine@lfdr.de>; Tue,  8 Feb 2022 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiBHEY0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 23:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbiBHEYZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 23:24:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63AC0401E5;
        Mon,  7 Feb 2022 20:24:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwpeJAxYOeoVsLh3kJux2ZV1q5fvaUulxGkPDImWKKGDDXwQbFI1gm61MMM811TZe/3uf5DswSwtRD0w6cm9Y4xmIJfxpvli8Idj5pjowh66dNy2mwutVUuIvU5Kp3NChwJRfYfo/e7w7yMscaL1kstr9xlWA9Aj5C6PAqH3lZsDKCdQIp8T8HSWYDIlCFAOjVy2VfKcY4/+nJqa8LnxoKgRL5S5FDw4F0Aj00r4vZ/ZxoD8sCNS1g1lN4Hbe9LeDchxVtP4r/6YoXb6UsW90En+1u3OODrzJgoN/VnQjvaWHqmhNQS419GpIzons1IfTOhcWztmmfn+5nH8cxCCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmRHfzkMi84hiJPh0k6g3iUR8t9qjpiNNvP/vOenh7Y=;
 b=Z56g3S3RTif/6evZ6j4d9+7R6cb9Opf81R6toPspG8VHskd8qJmJhTiMJiJ0JGKOFHWWC6EWZ2Fr5/VTWKA8Cc9rYQQMtMnkyViqNB6hH0DWGUa+Qf+4MZgqjFkD2bBUvJhOuIGjwIGE2Z/TDpJE95+7bLTaTCu8A30FKDup3UM4IuLoqCCTfzDyT+YpSwagXAYQHRDFZlFYY1wo+RxfkfIpY4TDw5WBKpdo0AmLj1P8xPNaK3xOjDWAhcVXodLLZayIzYKsoQYsbGfad9zuJTOEl3YiwJhyapQU486G9fYVYWyvzCa2MqBcEknuPxEbHeLRn+QBFWkIRjRr5HSHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmRHfzkMi84hiJPh0k6g3iUR8t9qjpiNNvP/vOenh7Y=;
 b=1RuPnupbp8HjZhNehUvQbWwyF8xQSUA6zGh0f3JW0WaYSigLyUEHZtiT3CqQUjtPqHGuFoXxu2EfN9P1UGQCnExv028URGYDYDsm1dBdT2G9in02rlyLxEk1lZyaaQOfsdn3bA4M7coIr4T72bJ1sJ/WkTgGRdO+Y4PAwPwikJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) by
 CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Tue, 8 Feb 2022 04:24:20 +0000
Received: from DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::e848:f5e6:6c9e:47c6]) by DM5PR12MB1242.namprd12.prod.outlook.com
 ([fe80::e848:f5e6:6c9e:47c6%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 04:24:20 +0000
Subject: Re: [PATCH v2] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
References: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
 <20220207165117.GH1951@kadam>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <aa78a0f9-9bd1-5c24-f834-61085d9fe3a4@amd.com>
Date:   Tue, 8 Feb 2022 09:54:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220207165117.GH1951@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To DM5PR12MB1242.namprd12.prod.outlook.com
 (2603:10b6:3:6d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c9e6ece-8532-4618-3fcc-08d9eabae077
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1288DC4A3AE5A906281F289EE52D9@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RdqK+oZ1SwYZ668NSP3aO81a/M4a8wpj1Qfm8GVwl8U4DW6FeGXgdZ9yuxebi6H7dCFY0UDPv+9kk83hXAIXOvNYEXPuH0H0Ao48ShBEutqiL+vT+L7g0iAKbNmXAWEk1RUJNtuM4tP6ZZJPpSFJ9vbvWa0nNBST6TnkcxWT1TCmj2BPQHU6ia9MgAXc2qflZBOoM4fuMhGSDLC03CyJqmRn91peFH90Ypty7cFBYH7K5DJGm6Cd56PHGFIiSCYaP5Nut+dgpJzFSxLVk3RRYUFVwDRB6o89IXUhiekVIKpeWsN41RSs8Jh8NU5P0dJNsv9Td+NsiFUdUJL9DIARAZbYiKYtipLwA3HIAu33vq6Uc64cw9e381/5kouoz4+u9xaXgUuY8S46a6vlKZqonEavJRaGeb+fsOoissmKf3XDr6cIbXqNkXNGXYfgo2VSyvUcqZM5zPRaRWUNTTn8hhFwnwjYUdG1EnXq9q++PJJV0HLCU/nfeaHc2QbJhTEJVr5xzrQBhlaAlUFGD5RvSBNYiYYKS1JHNWI/rW9/bmfAmsVVzeT4pWVLnSi4JLAM3liZ7xrW5N7qgs3RvgSDiFyeO/WoSvWEDy8k25n8du/6wDpbX2UjpgjAV2KW/MfVraFm21ENSPVzJnKusQjKgdwj5uRHqQ8MHddpJbKAJb2cpNjFz9h3qu3WP1ScG/Hc1fh9MeiR7uYA+6oCy9nLEk7QKslhLZN0b3ypk4+YRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1242.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(2616005)(4744005)(5660300002)(186003)(26005)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(6506007)(6512007)(6666004)(2906002)(31696002)(508600001)(316002)(36756003)(54906003)(6486002)(83380400001)(53546011)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjU3dEZiOG9jazlZUGVXRUx3R1JLWGtOcklxbjZiQmtHeitJMlh6dmZ3Ly9P?=
 =?utf-8?B?dHNxdjhWL2gyYVNNS2JPbnlYYnNkbFZzMk9Yc2RxNmhnbnIwaEVEcHdvYnRC?=
 =?utf-8?B?TThiVUhFZTNzL20vYTBjaGtMTHpqWDJKb0wvL2RWa3liV1ZmSk9PUGtwZFFQ?=
 =?utf-8?B?RktFYXZuNkRkdVZNN2x1a2E5bXZFR0twSm1WanM1aXB0TXI1anZDQ2Z5NUhj?=
 =?utf-8?B?TkJ1R2Rmclp2QVQ0eHJhZTFNUEk5eXQ5SGI1Rmh5eUc5SmZXTG5xR0pnUkJS?=
 =?utf-8?B?VC9ISUhDMkxmRnhyanZ0cUQxdHlEcHV2dFRadWVnZ0tYK3oxWHRZNWxYOHQy?=
 =?utf-8?B?TkJOcGFvem5ld0J4NE9ETkI3RDVwcTJWcm4wYXkzemtiOGFwUmpoUk13SGwx?=
 =?utf-8?B?TEZsMHFOeXdjOHhlcVladG1ha05DWk1tbzVMTW8vNGtieFE5bkpWSzRtNTVp?=
 =?utf-8?B?b2RqTjFRN0Z6Ni9CMVdxSFN2Z3NTeEhCYmZyZzFIQkxzZUpibXBtWkZtL2RQ?=
 =?utf-8?B?T2lzWVc3VGVlMk1JL05LanhGRjNrRVRnYzYzLzl6VFl5NVlpRHFCZ0szNkJB?=
 =?utf-8?B?Z0FyMTNkaGdkYy80WlFOc3JnZEZrUGpFS2pSODQxcWFieSt2TzczL0I1a2N2?=
 =?utf-8?B?NysvN3J5RU81a1ZyWHZkNEp6cktkd0h0RVFKYmZmWmlSRnRaM0Y4c01BSTFp?=
 =?utf-8?B?TVVnMExCRDFTb3VnVlB0SzZITlB1ZUpBQnhTSS9IOUVVVVBzVy94Yko4UWZZ?=
 =?utf-8?B?SUlqNllUSGMyN3VFdm9wL09zdXV5d0NWV2dxMVdNVUdnazc5VDlzYjk0VHgy?=
 =?utf-8?B?d2tVZE5hWUIvSVhNMTRLdlIzRUhWWEp3dEh1NjdSTWJEWExVbldIWmc3aEJK?=
 =?utf-8?B?d3Mrdk1RMFdIeDNzc25DcFVvem5wem9aZy8xZ1dNZG9UZHR5STVmRTlHRUJq?=
 =?utf-8?B?UFlBcUIrWHErREZVdzBnOWx0WE9rcEs5VlNsN1NRTm14U3RiQndPTkFmcC9H?=
 =?utf-8?B?NmhmZUJjeXg2aEJzRnFSWE5QbUxSWUF0Ymk0VmRvYy9IaCt3TkZUZHR4dVEr?=
 =?utf-8?B?SWdyV0tINFNSL2hERENXazBzRUsvYlRZNXRpZ3E5REhVTWgvNW5xb3BVYXpB?=
 =?utf-8?B?THEzeEZ1VDdkeVpFTFF0bmN6LzFZbFpoQW1yNG9xM3N0RWc0ZDA3cVdna29O?=
 =?utf-8?B?Y1gybTBiZWhjUzlVc0RRSElXK0JYaTU5emE4Z2dIOW1tWDR0RHU5MW1WQjJv?=
 =?utf-8?B?aWpFNmhsNVg3MVJRYW1SVzlwbzlIWHZwc25qNk9VN0JsTWpoVThKZGtRYnNI?=
 =?utf-8?B?U2tRSVVBTndpdGgrYmJ2eVpzS3BmeDZVTmp3bjk4aENQZjZQbE1DdjBnelVx?=
 =?utf-8?B?V1NhRG9NWituai9rdkwxQnhIRFg3RE1LRHdxdHpKOUx0aTF0WFh6QUxNRG50?=
 =?utf-8?B?RFFDTUltTjh4a2xFaTB0ZWYwMnZaejVnc2g4ajYvTHVaeUt4T2Q3R003QzYz?=
 =?utf-8?B?S3pTV3k4aE9VU0JPUHgzL3hzTUY2dnA4R0ZlZHpidkdUSkYyZ2dRVjJkNDYz?=
 =?utf-8?B?TGRRK0NiTCsxdzdySEtvdHRmYXZ2L3dGUkZyNEtKUGY5Q29JNnAwOEJTRDJw?=
 =?utf-8?B?V2tLM1dpYWhvYnE5aU03emlxTDhkVkFTWVRLUjEyUldxOXB6MHlLeTA5WFpF?=
 =?utf-8?B?WDdWSVNoMXFRSFdvanc0Q0Jmbjd1dnI3WStFOW5US0xLQXViUVArL0h2UjVX?=
 =?utf-8?B?ZEhsVElNVGxLQ0JLVUIvRnVIR0hTeHlCSS8yMDJ3QmcyVWQwQklkT3lWTGd3?=
 =?utf-8?B?WEhSTTljejhDMTI0NWRyYTlmUFlCNkdHTlU5RitRMG5CTUpZazJobTYrUkNh?=
 =?utf-8?B?Q3VPKzRCdlRhWEdvQnNUaS9obXRVUG5XaGhqVHVPTHZndHFWb1FXRHF1ZENI?=
 =?utf-8?B?Y0F0aCtEQTd3cHgxcFltT2l0cGNFa3NTTjJ2VGFXZS8rL0J3SVVaMVZEOEc1?=
 =?utf-8?B?NVlLMVlCWGszNTNqb2xZSm5QVUdNMzU5NFl6Z1lzY2FEWU9xeGZYbk8wSlAw?=
 =?utf-8?B?OGttWWVnU3BERXF3Rzh1NUtkeVJwbENYRmhuODFUMkh4QlhwUHBGdFRrY3dB?=
 =?utf-8?B?VEZlNmFmMjcyeDlId0xDdWRBQXh6aCswNnV6OXduNVdtZ0JrMkpoVHc4YkNQ?=
 =?utf-8?Q?CPS3a5KIrlIwa6bGNUOKw5M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e6ece-8532-4618-3fcc-08d9eabae077
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1242.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 04:24:20.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPkflLsLumScy5cL10LBXd47ghwKp+cwN2G+HtoNHP+5zxCUTgnU3MIdSltk4wNeI0ZdSFiunF0FCKiPH2gdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/7/2022 10:21 PM, Dan Carpenter wrote:
> On Sat, Feb 05, 2022 at 07:58:44AM +0100, Christophe JAILLET wrote:
>> In order to free resources correctly in the error handling path of
>> pt_core_init(), 2 goto's have to be switched. Otherwise, some resources
>> will leak and we will try to release things that have not been allocated
>> yet.
>>
>> Also move a dev_err() to a place where it is more meaningful.
>>
>> Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> v2: update label names
>>     move dev_err(dev, "unable to allocate an IRQ\n");
> 
> Awesome.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Thank you!

Acked-by: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> regards,
> dan carpenter
> 

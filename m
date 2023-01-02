Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2E65AD52
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jan 2023 06:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjABFvn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Jan 2023 00:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjABFvl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Jan 2023 00:51:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8375B16;
        Sun,  1 Jan 2023 21:51:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbBfHEKgo+4gEQPO60R8bfUARXlM4dpgj32voWsjryDc7z5BV3qVO90gltoO7sqRehS+lGEEvs/sPVUJRxC+iuzabLneskYbgZ0cibXWgIGlyeAKtkS1z1KZY4mPZVQdQTDjp64VS40DPt2SFT6/QaL//Li1KE+sEcowUnOntiFdqgEpX5qyB/ZC7U2TVFoAB6OCbp3scPk3K3tI4i742zz4+eqFAWWojnS0oQILxrMweXeD8gwVCZuI5d3OdSdlEd9BfJI19y7XePguMuHn1gLcs639ikqS/+aYuNC43SanP2Fr+O8+eT+hjwMho6gk41CS82qIhhke3qIjvi+njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUDlEdWwywvHuoOmyzsxFnKCfDqKfPbGjINn7A1ray8=;
 b=AxFjW30BWX4VSOdRPLtQYesRxtbV45DpSdRMuO1muCmEdxRJ6s+pggK1CVjJg3bRx68CLsiSWT2Wsy4Ot7TjO1hiWBkcE+0Q5EKBdt8O91ByIRf1gTR2ZxI8a9pV+p7vvZoI2r2GJ9P1u+NO8pV+PScAsOjJzJUPQiURv1MNHr6ODuOqk9gGDqgP5HueVBZAaR//kHAZE4+I1ZoHFfmSNUGT583j/4mAkC/bwOAvcdw4Pzbx7A4Qd96wMbk/8o4PEEe47KS0eKifR0ACYFhoKTEEdz6Ox+NxMvjvNZqWHCCtjcSdzLP/XJCLnx5R/3YzVHSxlubYV8BPiuE8pdpbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUDlEdWwywvHuoOmyzsxFnKCfDqKfPbGjINn7A1ray8=;
 b=OxCsF+flVlUAu+DY3wQ17bmh33cNRTpbqKke2KSu8MRgiI9aI61CAmDarVTzPg5d3N7BqepWspmTpuwalZodHVihLU/+dL1AZdFULfaVESCkkTvTJ/ea6RhxHp1ejN7uhKZPPRT757x+jgX/KNedj5pW0nLCZs+7QOwT59p4MSlzwt2uZeRkxJGBSY/asWvv08WpiqijSRaPBI5WGne+Gj9FIWc1PlzsPGSu7z0oMC+qrJSuERjN6VFwObX27FO1fkDJhqscc0Oc11GG4eM9F3QymY4v8w/P0UAwa2cKCFi58fmVuN7intBUhBLFZ7uVvXhoYW7jmHx+sLwnmvQGrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 05:51:37 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::6f0e:b001:378b:5ae4]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::6f0e:b001:378b:5ae4%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 05:51:37 +0000
Message-ID: <eab6f26a-6ea7-afc5-bc3f-e29cfe61dad0@nvidia.com>
Date:   Mon, 2 Jan 2023 11:21:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix global intr clear
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221226065153.5558-1-mkumard@nvidia.com>
 <Y6ve2MUrG+/DtjbG@matsya>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <Y6ve2MUrG+/DtjbG@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cef97c-fd5b-46e5-1c98-08daec8569c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QP4gQMJydEFoP7dZdfj0G8KvdOQCHqYYz79bPRaATOWclnuM0KgTZqLI6HGTnSJlo1I0PlLvMo/OlfSAMA6R7K6r5JEpLy5V8AwpP5UPOkaITr9GNx0c6TQwyotijagMga0C6tKzAdVBxIN8YtkfkfHt3zwrlAgeJZblN/q2xnGfyS+4idJiDD3q+0ZTX/FnV+9GN9W0J8nc4W4rZh9cUy2z08XEPcM6ceuhOn7QOGVxFpk7oTKD84HGHBWkq3u9OBBT5ywx/c4aBkx1FlHbQcKFNgzycWych6iUV9aPBrLXO2TzwnA2sm+2twn5xRdcpFyshYpd7lVwBzlyzLTK54H1AG2OU6yWlOlMl4huv5klr2zWYyg8BsQGaAtGB2Vjbg+vBsYC8HtuWy+d6ogxveZSWzUzR4fuQkAaepdQiOXog0q7JO+Z2y6wOzmRs1oUJ/iTA2Z+j5ZMIX0h6ZG7AHEf/im9l89nsQJOKdYOMLejixZflPUlx+HfFVUXdRIr398yItzQxIZEPkNpl9cVcQv5fOl7mgHKDAXlEzVqmO/qo2iUcC9qUxkSqFkVSJKOK7OICpPo2CTk0aL0u8HUgc+QRsZmM76lDiIOrTYyPuDyvRTYdB/pAZN10FaL3RQaSwOSGi73fu+I6pvcaVV5LrUuL8xIsez10n6RaTnT9IiWF/iEqIbXv55lEuqr6cXZY0h+q0LYAKB6k1sG3zsGI9KiRfAt1KIUaXr9x/sYzHZLYjdTqrO1FU+Ud0L3Fxv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(38100700002)(36756003)(31696002)(86362001)(478600001)(6916009)(316002)(31686004)(6486002)(2616005)(2906002)(6666004)(53546011)(6506007)(26005)(83380400001)(41300700001)(4326008)(8676002)(66946007)(66556008)(66476007)(186003)(6512007)(5660300002)(8936002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0p0UkxQMGJ6TVJUWThBU1NOR0xYMWVvUUJKZVdtSUJINmZqYXg5c0lqUnAx?=
 =?utf-8?B?T2d1cG11U05DLzg0aXVSbGU4NG5UeWdVSm52Ry9WcXhLanQ0aVdRT01sUGNk?=
 =?utf-8?B?SWRsRk05SkhNaGhLQlBkTHE5NUJ5WThDNzUzL2d6MFpEeFh6S2FabmI1cjll?=
 =?utf-8?B?ZEVUb0JMellUTkNvdSszMkdVdStRNlRCSUE2bU9WU015bVZOQzBuTkJqbzF1?=
 =?utf-8?B?UTJwOUZGZERHVXN3ZjQ2WnVXRVZQT0NsWXNFeXIyeXBZTTA0cGRxbnl5c2Nm?=
 =?utf-8?B?RVJpbU5MU2FrTDdSQUxQcVpiWTVXaFZuM3RuV2ovbHdPYlpCLzJKL3FyR0l4?=
 =?utf-8?B?RDJicDhXay81RWJpeWVqWS9EWEIrL3ZPTmJUelVSeXNtNHZDZ01XdnR2Y0Y0?=
 =?utf-8?B?amV4dG92RlRRQWFUcENBc2ZBMzZKMFBUVCtRcDZURGdCNW5yWFUyZmJiNkNu?=
 =?utf-8?B?VzVBbE05OHJGaEFqVVppbm0xTm5Hc21ONTcxOE9oWG1Gc1hjdDNGVE1Jd3Z4?=
 =?utf-8?B?T0ZLcmNLTkNwaGNuRGRIeXNyS0xnVmM3aE5jdzFObmViZGtNK1dRUlNvZU9h?=
 =?utf-8?B?aDhvWkJhWTZnbCtXNzhxa2ppMEVRSXVzS3ZLemp2ZzArNTFFbVZXNjA0OUVW?=
 =?utf-8?B?K1N3Ym9ieldYckJtazc2MjlpcEFxczlkcmtXNnJtUEJ4eUlQY1RJeVZnTjBk?=
 =?utf-8?B?TEU1WWNGMUlnM281ZzNBL00zZURlaVhmZFh0VXVPR3Nrc3doVDJRMkdVaFpJ?=
 =?utf-8?B?SzdOenQ1N2grNnU1L2M3cWJWU1c2Sy9JWEJVUGpRNUZQRXh1dHZOa0lsVGoy?=
 =?utf-8?B?UWlrOU9DdFduaFl3UXorR1VsTkhac21pTGRzUDFia3NuY2twbFROUk9FWEJI?=
 =?utf-8?B?aXNNeVFZMWRuaTRSSWlRYTBpenh0ZUdWYndQZXZKaytpbk4wdFdGYXE0TGtN?=
 =?utf-8?B?TFZiaGpJekFOSDFUVmFoOE4rZ2dVdk1WU3hDZlJvazRBendpNE1mRUt2Qnox?=
 =?utf-8?B?dWhFcmxoNkxGeUJ0bFByOVFUL2Z1aTJRTUphMlliazlYV2lSTEVMaTUwUCtu?=
 =?utf-8?B?RFN4c0dnK1QveVJhMW5TUnJVWUhrSU81K2NGR1lvSEw3dkxiSXN0N3I1YjNR?=
 =?utf-8?B?QUpEREZYb2x4QzVndVpraCsvVjR4TnQ4V3BPOGpkbXBMcThnRGZOVGYrT3FU?=
 =?utf-8?B?OXk4MC9VNkJ2QmFPOVgxU0hJZTlQUFU1SHdIWGRISkNpUW5jcDZaYzNpUGhW?=
 =?utf-8?B?NFcyTkVzYmtKeVIwRGg5ZHBlVk4wQzEzOXJVTTcwamdQWVM5QTFhUnAxRDBy?=
 =?utf-8?B?ODFiNmxpejQ2R2lHQUVKNnJLcGEyb2IrSnZhY2hPMTdZSHpETTBPTEthYkF6?=
 =?utf-8?B?dk1xVmROQ2hza2ZMcnBDVStQdmQvTnRkUEVhRE9BazhLcG9iVDRxeVhnd3pV?=
 =?utf-8?B?ZWJxQWJJcXhMOTc4QktVYVUyZWtEZnVTcUNVVmhaMjFUaEl5ekgzMHRXb1FZ?=
 =?utf-8?B?N2l0ekI0RHFPckcwdnFkK1VUVlducklXN0NpeFpoalQ2WmN5MmkxY1UzZTFV?=
 =?utf-8?B?OFZ5T0NOZit5NS9yem9kRmJaOGd6Z3BXdU5CMWQ2alFTZTVOd0RaeGk1KzRa?=
 =?utf-8?B?OWlKNWZpMTR2SUdlWWl2Q0FZMkY4OVJTdDJ6ZG42NzBBdGRRTCs1NkpGMEpF?=
 =?utf-8?B?NXNGRmxGRlA4TzlKeVU2Wmt3Znd3WnpiNDRPN21hVmNYWU9veTBmTng4V3B3?=
 =?utf-8?B?ZVBta3g5Q2t0cUhvZGV3SEZhdCtpdHhqa1pCaXBhcDh4N3k5bzllZzRqY3I4?=
 =?utf-8?B?S1FwNm1Dc1ZLL2xYdkV2bXhnOGJndkVLMWpwUEtIN05nb2JpS0RqcHFKV0M0?=
 =?utf-8?B?YkpXeG1lU3NHSTFhNmx0dlpqTVJrNUhVSE43M1VLWDBEUHd5ZFp0bFN3d1Vx?=
 =?utf-8?B?cHhWNmRybnVYWklrck5UVGFwNkFSU25MK01OZDM5d0lwSjZaaTBTQlpxUlhX?=
 =?utf-8?B?cDZENU9tL0J0bk5uMzYwdHk4THkyMW1WOXRWV1lJNGM3eVpaZmd2a3hqcDVz?=
 =?utf-8?B?cnVFZFlQcmoyNnJuU080UXp0M2k1dmd6VThHUEoxdFpQVVFnUUdXbER1OTJl?=
 =?utf-8?Q?/aWbvWs74Cykhqg/qja9xbUGf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cef97c-fd5b-46e5-1c98-08daec8569c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 05:51:37.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7GiW284CrKXg7XlqICevda8p9RQCEFMr5CuuDd0XAHPrGFyfIj7WxbyjV9lDMaqDEgurubqDEJ9TkcnzNwGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 28-12-2022 11:44, Vinod Koul wrote:
> External email: Use caution opening links or attachments
>
>
> On 26-12-22, 12:21, Mohan Kumar wrote:
>> The current global interrupt clear programming register offset
>> was not correct. Fix the programming with right offset
>>
>> fixes: 'commit ded1f3db4cd6
>>        ("dmaengine: tegra210-adma: prepare for supporting newer Tegra chips")'
> Ugh, this is not the format for fixes tag, see Documentation/process/5.Posting.rst
Thanks for the pointers. Will fix the tag in the next patch for review
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> Why did you CC stable for this email? Again read the process!
My mistake, will add cc to stable in the commit message of the change as 
per process in the patch V2
>
>> ---
>>   drivers/dma/tegra210-adma.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index ae39b52012b2..487f8fb411b5 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -221,7 +221,9 @@ static int tegra_adma_init(struct tegra_adma *tdma)
>>        int ret;
>>
>>        /* Clear any interrupts */
>> -     tdma_write(tdma, tdma->cdata->global_int_clear, 0x1);
>> +     tdma_write(tdma,
>> +                tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear,
>> +                0x1);
> This looks _very_ ugly, one line should look and read better:
>          tdma_write(tdma, tdma->cdata->ch_base_offset + tdma->cdata->global_int_clear, 0x1);
> We are no longer 80 char limited!
Ack. Will fix in the Patch V2
>
> --
> ~Vinod

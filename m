Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4593D24F2
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 15:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhGVNRc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 09:17:32 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:49888
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232118AbhGVNRb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 09:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REpikljKa4l7G6DWGBXnRw2lvseJHmEaRSud4fXHeAzx4EaYrds2dLoAA9ltcbLKYoIW21L7fi21SxL3fBK8J2WD0Hv7bd1NqgXPNEHq6VJOLjDg2lEFAq5Ra+92gQmWfMJLKRUseNLC0hvKqDy8cM+N/kg0UvTDTEo6GbSl1GV5C1OTVLjpJB0JqEhAEHdeA79HG3FY1Bf6qJpGjM4GFzmB1ad7IElZi/nanoGfG8Rep01kSkd/T95kHwN5d/GjK2wGoJ+nROuWpHUOQz/J/j1eyWUYkeXzuyKx9+uywdhC38XN0mJzWyY2DurT4euufSWU+vmVLpEZoa4NF6U5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R0k+fYAyMmW3Uj3ju8oPx3N1LuUaQI9K1aojbQM9uY=;
 b=k9PBX33bco4y7X8gZNNnWwvgR61KQxvyoj8F++DfsXPwt8wZjvDYh0hDMreAHc5FBsIvouAaX8MdQ1No53WSdOpdr/9SwZAIzNTsDeiOtOJmaw5y+lPpsSaI2HBIKlhwQwHV206mOwhAHv1sdCbZUvuhUCpz3/W23/zFbdTA4FwjuoIOHMh0rOoltHvg026whuQOK0uZHaq5pWdckme9KwOmeTpIL+Lm1TVXUDmuxM5YIVb2wqDqEfyBjc/HxJRFfE4wOMNQAaX2oMRET9WZJPyxoyu0YVX9Iw4uZH41eDRJZvEYWFVxLZW8DLZxPweBc7MYnS3TSw1Si4iCqaZ2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R0k+fYAyMmW3Uj3ju8oPx3N1LuUaQI9K1aojbQM9uY=;
 b=moslp4yELOMlPjUiRYCz1KjsEkVfMHmUXKQyDyTavpio2QzZ5AxwHrVqip1Boibl8L+qK97IXqYDHhzoJK+SaHSiIVvw3Ywk0NsS3vXbLrNWRynZeIfBkQ7nJun85INdjzewhoWSRIB19mbpxV0Q7MOEdYNjyW0/VKguiBoOQrs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 22 Jul
 2021 13:58:05 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%2]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 13:58:04 +0000
Subject: Re: [PATCH v10 0/3] Add support for AMD PTDMA controller driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <5dd9b34f-3e12-6ca1-1d4d-ddc3f82e341f@amd.com>
Date:   Thu, 22 Jul 2021 19:27:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::28) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (122.182.203.158) by MA1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 13:58:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e6f9a0-88e6-4da9-9a31-08d94d18b9df
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5053E4E62126D9CCD11297B7E5E49@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNZUi07JJjui/rGTP5AmRRTyCMtYsQyKES+0o93I+7h794JRriKLnA7t5Cx/PjpWV4KCW8bJvIqloj0uzwuxwGUAi0tdKC4jMFcCNCp4EVsuPMN2ve0sfwOhHhu7/Jxf+XF+1UgZ9LEE4N12jZWD8tT3Rd1I7KF354sw0PpeJykFhRiMb37nl5K0w2LQbjbqU8RvMizQ0fTjiwIB7ZV+2T7UKhAbCFyY5bqO3qzRA4UjQDOsz7kcaXBjyKGHEY7Fr0CwjkIO4648fN3l0QGti9F8CGm0X87gFDAvs0R3bgBYXxrUCQJJeft1a9Ri5leUTGyfzI/4d/2pyzRVZTJIwx+BzCfsPz98DEhYb55aiNiu/LxN3ppJwR24+Au7ljq7uJ1o4a38k6OBmJFgW1hRWlLyccCxLcDlJ8ZqdHnCr8APLw4i8kuZdFKGsczdbfo+XnqU46OLLZNjUvydxkRwD6vTLCgXTvoAJFJAsiH4mAdWJ9BumY+NoGdCnrIi/WxsPcXU+5vIdiFwmhJfnZ7cvTPfUL2bKrg56DDwM8tV+/ja4XKZv7LzxxJPKfwflg0sXFk5XUGNqRAdHTq/VqGFii8AKxE7Xl1/xEP8er6wSwxgF5hN5IBGHzh3IApAsTpZUKBeZ1rNdrRdO/g5gLDZF6ReWrn1uc3k89LLFGhCip85VOAz0JaopZ7GxgJMdAgqBDPkOUrH++q7zIuaDkIaCIf8++m++qDnaf30QaJIDIir3/oezd4T8DalOQdZfK+caMEIYvyPdTu5gvdXvI7VWqykIY/2TnGeo9XAbkJ1q9MAdcejBRIyT3hQMBW0vvtSalCCkD0lZzEy+Lor4uNYAK45NIlXIkSjo4l3dqqQvDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(376002)(396003)(346002)(136003)(66946007)(6666004)(6486002)(31696002)(66476007)(66556008)(966005)(8676002)(956004)(5660300002)(38100700002)(4326008)(31686004)(53546011)(2616005)(26005)(2906002)(8936002)(83380400001)(16576012)(478600001)(316002)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0w4WXZIeVkvU3ZOaGY3WDBJSjh6OHk5ZFlHUndRWWNtaEtqbWZ0bUg4Mmps?=
 =?utf-8?B?YmVOOTJjajhEb2RUZWRKTmVRTU1aWDUzQmFOY2hvZDZoOWJMMjYzclZtQTEx?=
 =?utf-8?B?SGR2Tzh0S0YrLzJSTHRFNU15V3BBMEU4dlZBN0R6RVo1YjB4WGx4YTdLMmhp?=
 =?utf-8?B?ZEFRamZWNFE3RjVtZ3BRMFdYQVNTNHI1d1Eya21YQXZnU0ZCVU9OMXNyS1hT?=
 =?utf-8?B?Nk1LR1JxY3c1dHdqRE40VEJpWlhtQUwrR0taZmpaMVE0U2pBSVk2V0pNUlIr?=
 =?utf-8?B?ZjJyQVQ3YzRDdUFRdU55LzNGeGE5aVo0aldDMm1UQmx2MVlrR3pXcU9udzly?=
 =?utf-8?B?NnVLdiszMjk1R25OSkRLRGN2bEZQdGhXYjhLMDRTSlpOcFAwQmltb3F5K1ZL?=
 =?utf-8?B?UTNhNVhmZjlRekRnbjdKcUI5SCtZdWloMjVlY3QraEFOdUxJSm9zeWRHYnBU?=
 =?utf-8?B?a0J3VjN0QmNLOEFMWk5DWGJwdC9LT2R1RTFLdE9qR1NRNld3d0JKRkRtcW12?=
 =?utf-8?B?VEJFMWJlWDVMaWd6TWFWRnQ0SUo5UjlXV0c3bkVqZGdreG5lWnJPUjFtcENp?=
 =?utf-8?B?ZytMWUJTRUZDTUwzNm9YKzVxZWNxc1gzaUpockxCZFY2N3ZrZmN5WDd1WW5m?=
 =?utf-8?B?SU9lTU5KNDcyR1dnOVFHOXFrMkduU0JBSzVsRXBuSk80eEUzUnBwNVVUWnEz?=
 =?utf-8?B?Y21MRThPR2FYV0IzakV0VHVtcVVJNHlqNXFEeFl1VitPb2dKRXVPYzZMMXpZ?=
 =?utf-8?B?a1VHeGQwTTVXOXNoMSsrTDJ3WEkzN1NkbnVkZ296SFArdmN2cU8zYXZQY20y?=
 =?utf-8?B?djhZeVk2aGgybzluMytSd0dlRGplSHo1Y0QxWi8wcmx3L04rNmZjQ3lRa3ZP?=
 =?utf-8?B?Z0hlVUZxbWJITEZVTnNEcXhMTmN4b3lNYmlvWGQvRGpaZkg3bGlYREhJSElG?=
 =?utf-8?B?akYxelNWbGs0TU9CbXRJcDFqMmkrWkxwaUlwWTk4cHFYeGg5ZDlUZHlTcVh0?=
 =?utf-8?B?WktoWVlEZ1pDNGlVSHRCbTZUY3ZydEQyVlROd0E2bUhraU5ZQVR0UUhOc3pT?=
 =?utf-8?B?UlcrNXNxVFBzc2NTcVFHTGFMRFUyay9wYjhCOUU5RnphTDh4aW1CeFlzYXJJ?=
 =?utf-8?B?VVZlRUsya3I2dUlRa0ZvbG50eGFkS0I3ajFMYUhuVGZlQnVaYWluY29RcGR6?=
 =?utf-8?B?QnI0cmdYM2lxMGFyWTEyRlZQTzF5b2JFZGFkTi9wSG5JWEJSajJCY2gxY251?=
 =?utf-8?B?VzVXWURWRGZETlFoVGVXdEtGRXo3NXlaTEJKbnJmS0hEZUtKMUdMeEcyNzg5?=
 =?utf-8?B?QTN2Z3NpWmxqVkJjNlhwRUI2aDBYQWlLM0krR3hRNzY4QXh5S1U4bmNPNWh4?=
 =?utf-8?B?VGRMZUxoMzgyMGVDeVpCL21LaE5SUFVaT2REckRHWVk1YUZBUXFGTldBL0ZV?=
 =?utf-8?B?dzgva3FXZE42eFUxaDcyNUlMZG1SZkJTR1NLdVlDa1NNMlZXckJJdWR6eXZD?=
 =?utf-8?B?ZlNrY1BseFIzYXVKUG9zaUY0cHVMaGE3SEN0NU5TZkV0ZTdNT1plaFRrbjgy?=
 =?utf-8?B?TEY3TFIzRnlmci84SUhaTk5GVEQybFNIUTA1QWMzM0RMK3ZndkZjeUtmQ2JT?=
 =?utf-8?B?cmJNSWlIZ0FJV2hlaGxwQng0aC9kbTREVEVkcGZRNThib29MMnc1RXBQdkZx?=
 =?utf-8?B?eU1NbElIRWR6a1pBSVFXMTVEZnZsejJRRFBRczNYK21MYmdEOWZvWXRBRVRr?=
 =?utf-8?Q?/ypkG60uQhjjf7qDPxB3RVwtowesjqMrNwAjpQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e6f9a0-88e6-4da9-9a31-08d94d18b9df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 13:58:04.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urH20Pm/L/kvtZHJvurrgrTsrmtdWWiMiOTDMGtPOh/OazSH9h2gJGcPf2BJ8t/cbPZMfrZAEvi4KIM+Lxq2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/20/2021 10:11 PM, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> This patch series add support for AMD PTDMA controller which
> performs high bandwidth memory-to-memory and IO copy operation,
> performs DMA transfer through queue based descriptor management.
> 
> AMD Processor has multiple ptdma device instances with each controller
> having single queue. The driver also adds support for for multiple PTDMA
> instances, each device will get an unique identifier and uniquely
> named resources.
> 
> v10:
> 	- modified ISR to return IR_HANDLED only in non-error condition.
> 	- removed unnecessary prints, variables and made some cosmetic changes.
> 	- removed pt_ordinal atomic variable and instead using dev_name()
> 	  for device name.
> 	- removed the cmdlist dependency and instead using vc.desc_issued list.
> 	- freeing the desc and list which was missing in the pt_terminate_all()
> 	  funtion.
> 	- Added comment for marking PTDMA as DMA_PRIVATE.
> 	- removed unused pt_debugfs_lock from debufs code.
> 	- keeping same file permision for all the debug directoris.
> 
> v9:
> 	- Modified the help message in Kconfig as per Randy's comment.
> 	- reverted the split of code for "pt_handle_active_desc" as there
> 	  was driver hang being observerd after few iterations.
> 
> v8:
> 	- splitted the code into different functions, one to find active desc 
> 	  and second to	complete and invoke callback.
> 	- used FIELD_PREP & FIELD_GET instead of union struct bitfields.
> 	- modified all style fixes as per the comments.
> 
> v7:
> 	- Fixed module warnings reported ( by kernel test robot <lkp@intel.com> ).
> 
> v6:
> 	- Removed debug artifacts and made the suggested cosmetic changes.
> 	- implemented and used to_pt_chan and to_pt_desc inline functions.
> 	- Removed src and dst address check as framework does this.
> 	- Removed devm_kcalloc() usage and used devm_kzalloc() api.
> 	- Using framework debugfs directory to store dma info.
> 
> v5:
> 	- modified code to submit next tranction in ISR itself and removed the tasklet.
> 	- implemented .device_synchronize API.
> 	- converted debugfs code by using DEFINE_SHOW_ATTRIBUTE()
> 	- using dbg_dev_root for debugfs root directory.
> 	- removed dma_status from pt_dma_chan
> 	- removed module parameter cmd_queue_lenght.
> 	- removed global device list for multiple devics.
> 	- removed code related to dynamic adding/deleting to device list
> 	- removed pt_add_device and pt_del_device functions
> 
> v4:
> 	- modified DMA channel and descriptor management using virt-dma layer
> 	  instead of list based management.
> 	- return only status of the cookie from pt_tx_status
> 	- copyright year changed from 2019 to 2020
> 	- removed dummy code for suspend & resume
> 	- used bitmask and genmask
> 
> v3:
>         - Fixed the sparse warnings.
> 
> v2:
>         - Added controller description in cover letter
>         - Removed "default m" from Kconfig
>         - Replaced low_address() and high_address() functions with kernel
>           API's lower_32_bits & upper_32_bits().
>         - Removed the BH handler function pt_core_irq_bh() and instead
>           handling transaction in irq handler itself.
>         - Moved presetting of command queue registers into new function
>           "init_cmdq_regs()"
>         - Removed the kernel thread dependency to submit transaction.
>         - Increased the hardware command queue size to 32 and adding it
>           as a module parameter.
>         - Removed backlog command queue handling mechanism.
>         - Removed software command queue handling and instead submitting
>           transaction command directly to
>           hardware command queue.
>         - Added tasklet structure variable in "struct pt_device".
>           This is used to invoke pt_do_cmd_complete() upon receiving interrupt
>           for command completion.
>         - pt_core_perform_passthru() function parameters are modified and it is
>           now used to submit command directly to hardware from dmaengine framew
>         - Removed below structures, enums, macros and functions, as these value
>           constants. Making command submission simple,
>            - Removed "union pt_function"  and several macros like PT_VERSION,
>              PT_BYTESWAP, PT_CMD_* etc..
>            - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memty
>              struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passt
>              struct pt_op,
> 
> Links of the review comments for v10:
> 1. https://lkml.org/lkml/2021/6/8/976
> 2. https://lkml.org/lkml/2021/6/16/7
> 3. https://lkml.org/lkml/2021/6/16/65
> 4. https://lkml.org/lkml/2021/6/16/192
> 5. https://lkml.org/lkml/2021/6/16/273
> 6. https://lkml.org/lkml/2021/6/8/1698
> 7. https://lkml.org/lkml/2021/6/16/8
> 8. https://lkml.org/lkml/2021/6/9/808
> 
> Links of the review comments for v7:
> 1. https://lkml.org/lkml/2020/11/18/351
> 2. https://lkml.org/lkml/2020/11/18/384
> 
> Links of the review comments for v5:
> 1. https://lkml.org/lkml/2020/7/3/154
> 2. https://lkml.org/lkml/2020/8/25/431
> 3. https://lkml.org/lkml/2020/7/3/177
> 4. https://lkml.org/lkml/2020/7/3/186
> 
> Links of the review comments for v5:
> 1. https://lkml.org/lkml/2020/5/4/42
> 2. https://lkml.org/lkml/2020/5/4/45
> 3. https://lkml.org/lkml/2020/5/4/38
> 4. https://lkml.org/lkml/2020/5/26/70
> 
> Links of the review comments for v4:
> 1. https://lkml.org/lkml/2020/1/24/12
> 2. https://lkml.org/lkml/2020/1/24/17
> 
> Links of the review comments for v2:
> 1https://lkml.org/lkml/2019/12/27/630
> 2. https://lkml.org/lkml/2020/1/3/23
> 3. https://lkml.org/lkml/2020/1/3/314
> 4. https://lkml.org/lkml/2020/1/10/100
> 
> Links of the review comments for v1:
> 1. https://lkml.org/lkml/2019/9/24/490
> 2. https://lkml.org/lkml/2019/9/24/399
> 3. https://lkml.org/lkml/2019/9/24/862
> 4. https://lkml.org/lkml/2019/9/24/122
> 
> Sanjay R Mehta (3):
>   dmaengine: ptdma: Initial driver for the AMD PTDMA
>   dmaengine: ptdma: register PTDMA controller as a DMA resource
>   dmaengine: ptdma: Add debugfs entries for PTDMA
> 
>  MAINTAINERS                         |   6 +
>  drivers/dma/Kconfig                 |   2 +
>  drivers/dma/Makefile                |   1 +
>  drivers/dma/ptdma/Kconfig           |  13 ++
>  drivers/dma/ptdma/Makefile          |  10 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 110 ++++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 245 +++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 334 +++++++++++++++++++++++++++++++
>  10 files changed, 1437 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h

Hi Vinod, Greg,


I had re-sent this patch series as per your advice a month ago with all
the review feedback's addressed.

Need your guidance and feedback to get this code reviewed and up-streamed.

Thanks & Regards,
Sanjay Mehta

> 

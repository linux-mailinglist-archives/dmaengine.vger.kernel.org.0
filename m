Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8623D25D5
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGVNw3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 09:52:29 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:63105
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232272AbhGVNw2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 09:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkEdluWqVNIGj3EcCbBtKbfSEbIL6oeKKlmyaDGri+YFIpZY/46M0dszaIfSCpgWm4+Ln3xwIYHxnuNMt+xV+ddi2rSYg13fnagyLOsTzjVfPazOpCuT2Qyo4v0KOux35zdMzZK4TEvWBYsN4sKT/7jjPK6JIewiAISDyhtq55g3FO0lh0St1TETND+SZEjYkCoHCvqA3UxnlWKzLAhVAUZ13pwM2zPlG0NTxzFoSpYMGwrIT00oT30iEGAVlXeyhjJXwxT4fn1F4xFPw4b6s4z4UIubQIx3AP/z+X00T9wYgwdusgnJKd7newRE5JxhbseqaXkTkiyF1pKfIoOWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng3cXNd8yQ4tRxMCrEqXgOg4VkYyEdEHnfObrebxhnU=;
 b=ES0Wmznz78I0aP4oZa64Amcl8j5W3JGPcTximqsP90k6N8PGOD4/MtnZOHIFRea9qFbfGj277dYmZC/9bbPW643Xwhc+mKTonYDWLEazVvDR+y/InhJiE4M1EQoBb6ZjyXZLjFq/eNCMGtWhaf0faOlax1vL4wOQhhC7bEjR+aTcZcV0X8/cpkGUezTqznNpwMkX7Da3FUqMR9ezCSsvET30Q2mXj6p/racchOkmCMideMgKF+BA7fkzYvxRfUgVGuC1kvctGdZTdUe2qXSLkKMbB6QamfwNyBZS+vo3qPXE4EF5oXxzc2fyLifyGxQLwdTWmGiweeE+029tcT/WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng3cXNd8yQ4tRxMCrEqXgOg4VkYyEdEHnfObrebxhnU=;
 b=Tfh4TZKCS0fO+Y6oqghoREaS10HBOVM/VVU1TtY5TnxAbVLwTLTgRcVIQ/2uibq5LjKRu3uFOcZabT3Ln3mBWeJbVNHC2IOsydNI9z1Mlnyx/8sKSmR0ODZYaEdgyNuOZL0bnBDoa266iQ2ODrIz2pNWCOdebov01h8l6hKNGd4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 14:33:01 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%2]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 14:33:01 +0000
Subject: Re: [PATCH v10 0/3] Add support for AMD PTDMA controller driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <5dd9b34f-3e12-6ca1-1d4d-ddc3f82e341f@amd.com> <YPl8OZwMlKs7a+lK@matsya>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <6674b7db-dedf-9b0c-7ae8-0218978a65ce@amd.com>
Date:   Thu, 22 Jul 2021 20:02:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPl8OZwMlKs7a+lK@matsya>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::14) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (122.182.203.158) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 14:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7aa015d-2d40-40a5-e8f8-08d94d1d9c08
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50388F074BE96EFD500C14FBE5E49@DM4PR12MB5038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7HJtUKrDspjP8dsonTfYgi1y7ve5MoeHobqmlavBDIZ5vcSMNBOdxhq/2XTMhxF+I5/7ZMZ8sU7frKjP7hUAHz+Mi3NX593IfnwJhIer6FjWPTHlJl4hwhF6kWVBfrTInUpMjH0xg2LSH0WD9wPxHsyc0u2bOpNHaMjdFCHNzGVHH3fUcGpV9cSFLJW3gJpdbSx4selMuYlnZlo4CqWY87Rqy0BihOPyirJi4alWfikzE4k4eeDwdqbXtWY8syhziq6JRFp0kkrdkxhdn1ZqZsn2Fy85ikL7SX41lQOEKQIIt5XYZxbTQW08Di8T+B1b4yIwHPWp2Tbc/4CWULUwmv7UZxPUyv1DnhSisyshinaBs7TtzkfYXyZbZv+P/GVaQYPktgDJsv4gtQCvXv1w12qS21e/JaoSYWIQQczWNLCpUMYFNr/MXTfb3DisbfSd9msW907tztHAOTmoOY8P80XwxngEom8LKDirLfqu5j1zHAvP+VfrmqT9bpzNfK90Oe31yxnJl93AojdJoQmEx84Wz57WCbLTW97T1gmO7oaFpvUlfLY4Xiz1SZvsed/KnNQELBCK9ppRJWi7XrPjwHTe/LlryyWI/YNJYCRptkYh6slVFutxu2mBuDNslgZqV/HbFqtctVvt39tGhY1ci6uXH7EODeeTkLWN5TI8OD27OfCWTUnik4QbSqd7p1im8ZI6YOPBVehQ/3XfAsxtV6yZ+CT5x2LnQGl0hAzePK6PA5xigqWRFnLfG0E12XFj2Skw10LPqnARlJ/gnSlwHipoO8pK/27F2mliUquLjpjSLP1pldvf9LfJNkbg3e6DUYhU/aQHbkpYSSvF8NgLwOG1AMoe2CmoNQn1D1DrFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(39850400004)(396003)(53546011)(8936002)(6666004)(478600001)(38100700002)(8676002)(316002)(956004)(66476007)(31686004)(66946007)(2616005)(6486002)(66556008)(186003)(6916009)(45080400002)(31696002)(26005)(2906002)(5660300002)(30864003)(4326008)(83380400001)(36756003)(16576012)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUIwU1ZwUk11dW5FcVRXRUtpaU0zZHhyL1dFa3JqUStjbkxLUGlhcjB6NDBm?=
 =?utf-8?B?cUhGRVMxc2VOdmtOOUppVnRUcDZIc21uVDYvZXNKeEpicVY1YmJUcU5TRHE3?=
 =?utf-8?B?bXVZaXI0djdoaDQ5ZFVXTXBCNXR4RGVBT2puQlN0ZXdZTTVxR2Vaczk0UXJk?=
 =?utf-8?B?cGlZS2syWmNMWlVOQlQ1U3R6MzJmRTkxMlVad0didDBJOUdUbzVzUUdmSGMr?=
 =?utf-8?B?SmY3Zm9wRnFOelhHZ0FvNzlFeTJJUzlsR2lYSmRvSmN1WkhHaXJ4bWkzVVdx?=
 =?utf-8?B?TFI1OWhWY05XdzU2VXpuSnZkc2JQU0RDV0dLMzdHWGM2anpUWXdOZGdBbzVz?=
 =?utf-8?B?UGo3MXk2NDRPT3JvK2NWUENlMGdqNnVXN1QxeGF2QXdrQ0N0L1lVQnM2ajAv?=
 =?utf-8?B?NWRRWGJEdTRzaTFiY2ljK3ZyTzZxM3RzdVpjN1RYcnNVMDRhVEZLbzgwaE11?=
 =?utf-8?B?MktBZGkweDV3end2SnR6MFJWQUpaVjRlVEtoQzJHUmtScG55dUE4SkxXNXAw?=
 =?utf-8?B?d01aMThEUGJyZGxwbFBZVm5rdzRSbjJteTJjS3ZMK05QR3RRNWNOd1ZtTDdQ?=
 =?utf-8?B?cUoyUkswUTJtYTVjVE9LQWtFQXN2QnFVNTJFbEZra2tKYnZ6Y1ZnNTV2RWM4?=
 =?utf-8?B?QmlSZDhKUU1lRUFjVlgvS1hWQ1ByTHJURXRqL3JhaDlLdEhBdnovejFYa0lM?=
 =?utf-8?B?emRjd1ljc1ZpdGIxNFlWRCtNbWZyM3ZsTmROMG5YVEorcXQyTUJmN0FjTDFP?=
 =?utf-8?B?L0RYVFc2dm9sYjBiQzBBbWVnRnFTVC9wMVVjUC9Kdnp4bVBiR1RUbFFNK0ph?=
 =?utf-8?B?Y3RpYXVmT3VlbHRsMW81ZVd1SHBDTWpST3MxaWNER3JHR29hdkFKSWJBRWFY?=
 =?utf-8?B?ZDVRYlZ2aEF3cUdmWVl5VVdnR2JBdkhLZmZBWllWdUJoYk8xOCtjc3kyNXZ4?=
 =?utf-8?B?YkxUb1liaHlCckJJajEwc0k0eUxjRFVsZnhsK1BZblhnVFVRc05pdktaWklk?=
 =?utf-8?B?YnFwTnVHSm11ZmtHekFEWTlwV29sZmRyUGNucEZmMmowenNKSTNzQ1V6elBJ?=
 =?utf-8?B?TEJZRjAyblU0cWMyZWprZ2tHMXVCQ2w2T3h3L1dyZ0FLeDJwRTcydkhLdTZp?=
 =?utf-8?B?RWZmWHl2RGIva09oVzh1dFJOVGgzeEg3ZnJldDgwaXdXZVJnbjFDTkhxeUs2?=
 =?utf-8?B?SkhuUXlRRmNEcXZPZ3hSSW9PYVJSQW5mT1FGR2FEZWpLT05vcm13ODlGTDJE?=
 =?utf-8?B?OHplSU8wd1UwQTl6bFFUcmZDaktHZEV4b0hSZXNleFJFbFJwTjA1YkVHSjd5?=
 =?utf-8?B?QU1Iam1LMXJlaExjRmZ2MWVudno5VkNuc3ZadmwxSGljbzN0aDBUcko1TlBt?=
 =?utf-8?B?YXgrSGp2RzJBV3cwWng0Y25ldUdpN0IyRDJVdDRUSU5sWFpCWUw0VGh0N25K?=
 =?utf-8?B?L3c5aERHZ082aGdyQ3BBWGF3TmpXdVdqTndiSVNtbWlKUWVOUVlvcjRMMGc0?=
 =?utf-8?B?N2lHNzdyY2h2NHlVRFZFa2VFcGxnaVU1dWU0UVNrL1MwQ05Ib0JmUjRDV2NJ?=
 =?utf-8?B?S3l5K0JWbnpUNTlSRk96UGh3N3lMdno5WmtWT0ZzMnhUUWFSM0t2WENiMVQv?=
 =?utf-8?B?Y1BpNUYrbVRZZWJRN2F4OFJBbFFBZHFCZVpicmQ3SjFCRzE0d3hKVlhCb1RB?=
 =?utf-8?B?VTFGdnhra05YcVlrTnpKNy94WEY0SVltYVRLWGpzTDdyUjFPcytDblk0NTBI?=
 =?utf-8?Q?PSMNLmzLQ4p+gN+71XMWlh6t1/uC4r8gPfLVAeu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aa015d-2d40-40a5-e8f8-08d94d1d9c08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:33:01.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XROWHrfPGVlZ+wSJw9srDUuZCJptVGN+ieIRLAtcwiaK5o3cgCECIEY8P66Q5V+L4lve/qflea+DQ5Oi2Igp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/22/2021 7:40 PM, Vinod Koul wrote:
> [CAUTION: External Email]
> 
> On 22-07-21, 19:27, Sanjay R Mehta wrote:
>>
>>
>> On 6/20/2021 10:11 PM, Sanjay R Mehta wrote:
>>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>>
>>> This patch series add support for AMD PTDMA controller which
>>> performs high bandwidth memory-to-memory and IO copy operation,
>>> performs DMA transfer through queue based descriptor management.
>>>
>>> AMD Processor has multiple ptdma device instances with each controller
>>> having single queue. The driver also adds support for for multiple PTDMA
>>> instances, each device will get an unique identifier and uniquely
>>> named resources.
>>>
>>> v10:
>>>     - modified ISR to return IR_HANDLED only in non-error condition.
>>>     - removed unnecessary prints, variables and made some cosmetic changes.
>>>     - removed pt_ordinal atomic variable and instead using dev_name()
>>>       for device name.
>>>     - removed the cmdlist dependency and instead using vc.desc_issued list.
>>>     - freeing the desc and list which was missing in the pt_terminate_all()
>>>       funtion.
>>>     - Added comment for marking PTDMA as DMA_PRIVATE.
>>>     - removed unused pt_debugfs_lock from debufs code.
>>>     - keeping same file permision for all the debug directoris.
>>>
>>> v9:
>>>     - Modified the help message in Kconfig as per Randy's comment.
>>>     - reverted the split of code for "pt_handle_active_desc" as there
>>>       was driver hang being observerd after few iterations.
>>>
>>> v8:
>>>     - splitted the code into different functions, one to find active desc
>>>       and second to complete and invoke callback.
>>>     - used FIELD_PREP & FIELD_GET instead of union struct bitfields.
>>>     - modified all style fixes as per the comments.
>>>
>>> v7:
>>>     - Fixed module warnings reported ( by kernel test robot <lkp@intel.com> ).
>>>
>>> v6:
>>>     - Removed debug artifacts and made the suggested cosmetic changes.
>>>     - implemented and used to_pt_chan and to_pt_desc inline functions.
>>>     - Removed src and dst address check as framework does this.
>>>     - Removed devm_kcalloc() usage and used devm_kzalloc() api.
>>>     - Using framework debugfs directory to store dma info.
>>>
>>> v5:
>>>     - modified code to submit next tranction in ISR itself and removed the tasklet.
>>>     - implemented .device_synchronize API.
>>>     - converted debugfs code by using DEFINE_SHOW_ATTRIBUTE()
>>>     - using dbg_dev_root for debugfs root directory.
>>>     - removed dma_status from pt_dma_chan
>>>     - removed module parameter cmd_queue_lenght.
>>>     - removed global device list for multiple devics.
>>>     - removed code related to dynamic adding/deleting to device list
>>>     - removed pt_add_device and pt_del_device functions
>>>
>>> v4:
>>>     - modified DMA channel and descriptor management using virt-dma layer
>>>       instead of list based management.
>>>     - return only status of the cookie from pt_tx_status
>>>     - copyright year changed from 2019 to 2020
>>>     - removed dummy code for suspend & resume
>>>     - used bitmask and genmask
>>>
>>> v3:
>>>         - Fixed the sparse warnings.
>>>
>>> v2:
>>>         - Added controller description in cover letter
>>>         - Removed "default m" from Kconfig
>>>         - Replaced low_address() and high_address() functions with kernel
>>>           API's lower_32_bits & upper_32_bits().
>>>         - Removed the BH handler function pt_core_irq_bh() and instead
>>>           handling transaction in irq handler itself.
>>>         - Moved presetting of command queue registers into new function
>>>           "init_cmdq_regs()"
>>>         - Removed the kernel thread dependency to submit transaction.
>>>         - Increased the hardware command queue size to 32 and adding it
>>>           as a module parameter.
>>>         - Removed backlog command queue handling mechanism.
>>>         - Removed software command queue handling and instead submitting
>>>           transaction command directly to
>>>           hardware command queue.
>>>         - Added tasklet structure variable in "struct pt_device".
>>>           This is used to invoke pt_do_cmd_complete() upon receiving interrupt
>>>           for command completion.
>>>         - pt_core_perform_passthru() function parameters are modified and it is
>>>           now used to submit command directly to hardware from dmaengine framew
>>>         - Removed below structures, enums, macros and functions, as these value
>>>           constants. Making command submission simple,
>>>            - Removed "union pt_function"  and several macros like PT_VERSION,
>>>              PT_BYTESWAP, PT_CMD_* etc..
>>>            - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memty
>>>              struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passt
>>>              struct pt_op,
>>>
>>> Links of the review comments for v10:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F8%2F976&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082849269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WeGA5LwGm9mnQ594VpBPAbUGZXkLZ4oup1T77fJoitc%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F16%2F7&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z3iiY0cfRUgtA5cP2lJqwmCxICyCN4FjsRI1u4aLPVU%3D&amp;reserved=0
>>> 3. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F16%2F65&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=TABmc6i98zw%2BpjIq0hxawCL2L%2BiQe9uJvRtajCFsR6E%3D&amp;reserved=0
>>> 4. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F16%2F192&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vnmjIVQfPdTaoSIAyQiA%2FjyKWY6YXnmIOuvpn3QCj%2BI%3D&amp;reserved=0
>>> 5. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F16%2F273&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZtH5A19dQYiHMHQS6rVenSj2Jo7%2B9pNjC8%2B24FK5zNI%3D&amp;reserved=0
>>> 6. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F8%2F1698&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BrlAck2STVZ82dnW6MeJaSvelS7FK5sKUEdh8ftMrvc%3D&amp;reserved=0
>>> 7. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F16%2F8&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5EP0t9eYgx0tWUu1W8eR7MhvzGtLhJm1%2FYMvJksr5jU%3D&amp;reserved=0
>>> 8. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F9%2F808&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WzeuQCeW2q%2FU8rEZybHezhBnYH9yG0Z7PV5dH4KeK28%3D&amp;reserved=0
>>>
>>> Links of the review comments for v7:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F11%2F18%2F351&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0uFWTom212inntZl3C2jmQ0EYVRG8hXlDKDkMdxToAA%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F11%2F18%2F384&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=agZRP0WYYpWO4c1AoVSmbi0%2BPv%2FHYIsmknPkDUqwcuU%3D&amp;reserved=0
>>>
>>> Links of the review comments for v5:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F7%2F3%2F154&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rhXLYx8qk6Uwt7hYiUv8zZFz%2BAekntk5x7%2BF7yrDi%2Fg%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F8%2F25%2F431&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qeIQAK%2FtcrsJjJLftPVp1h2jAewJxcUOFWYiCsBFgC8%3D&amp;reserved=0
>>> 3. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F7%2F3%2F177&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DM3NiBmaXQRbe7dw4vyDwaWtkGB9IMDBkM9ieSzJ%2BlM%3D&amp;reserved=0
>>> 4. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F7%2F3%2F186&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BU8wRPlcKJXRSVbNO9o2a4WzPIRCBj%2BHVqK9XWWBUog%3D&amp;reserved=0
>>>
>>> Links of the review comments for v5:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F5%2F4%2F42&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FLzrpW49oJQvOojpJcnyEPH6886BfeBdbPnAv8Gzyxk%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F5%2F4%2F45&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fNCM6mogdUJtziiyTS5VeaigZcOdTRovTiAgLN7eNlo%3D&amp;reserved=0
>>> 3. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F5%2F4%2F38&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082859237%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uZnxL%2FzXr8D6wgZffIZQpEiXtQfJTlAWtJ5X5k%2Bxm1c%3D&amp;reserved=0
>>> 4. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F5%2F26%2F70&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bTNsPcdGciOdNnj7%2FFCOBHc%2FevZBQAqhyJZAkHt1iLI%3D&amp;reserved=0
>>>
>>> Links of the review comments for v4:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F1%2F24%2F12&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Tox6tf88tSPVA%2Fq5y6ssuNlskxK3cgBpynJTtHEpPOw%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F1%2F24%2F17&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=cWe5KvRLulu55PlsxwoQwJAZFbgoV0H8mLVqCe5eePw%3D&amp;reserved=0
>>>
>>> Links of the review comments for v2:
>>> 1https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F27%2F630&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lSo%2BPMBxKI5nB%2FWXscbJBUvaCn7n7TfbozKhPhhDviU%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F1%2F3%2F23&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=e371CMeEbKW1K2%2Fn%2BukG0DU5U9x2LsbmgFrRrva25CM%3D&amp;reserved=0
>>> 3. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F1%2F3%2F314&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IJ2xiQSIH1jfDxDKuLg9F4bjJJGgxXJq5jHBNWeSAV8%3D&amp;reserved=0
>>> 4. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F1%2F10%2F100&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mDUnVUEREIpoUeYUeACYMQSzAon4t9652Uj4PQCrwPQ%3D&amp;reserved=0
>>>
>>> Links of the review comments for v1:
>>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F9%2F24%2F490&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=MvwpsDwevzgU8Qn3zc29u8hjhFBZIAFZJy7lSYcegnQ%3D&amp;reserved=0
>>> 2. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F9%2F24%2F399&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6v6SMJY%2BY6RfGty9QxG72fsQ%2BV7NfJm%2B8Dh3cVIx%2BtQ%3D&amp;reserved=0
>>> 3. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F9%2F24%2F862&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7cY3MBVmXSQ40wVpdVWDDYqTV3Z%2FzCB0j%2ByNeiIO3FA%3D&amp;reserved=0
>>> 4. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F9%2F24%2F122&amp;data=04%7C01%7CSanju.Mehta%40amd.com%7C775e5c3c08a24a2a7dc608d94d1a67e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637625598082869186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IoLPSuBMdz8T8Qyyknb2%2FJzzV8o62BqzkrQ6kirzOIM%3D&amp;reserved=0
>>>
>>> Sanjay R Mehta (3):
>>>   dmaengine: ptdma: Initial driver for the AMD PTDMA
>>>   dmaengine: ptdma: register PTDMA controller as a DMA resource
>>>   dmaengine: ptdma: Add debugfs entries for PTDMA
>>>
>>>  MAINTAINERS                         |   6 +
>>>  drivers/dma/Kconfig                 |   2 +
>>>  drivers/dma/Makefile                |   1 +
>>>  drivers/dma/ptdma/Kconfig           |  13 ++
>>>  drivers/dma/ptdma/Makefile          |  10 +
>>>  drivers/dma/ptdma/ptdma-debugfs.c   | 110 ++++++++++
>>>  drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++++++++
>>>  drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
>>>  drivers/dma/ptdma/ptdma-pci.c       | 245 +++++++++++++++++++++++
>>>  drivers/dma/ptdma/ptdma.h           | 334 +++++++++++++++++++++++++++++++
>>>  10 files changed, 1437 insertions(+)
>>>  create mode 100644 drivers/dma/ptdma/Kconfig
>>>  create mode 100644 drivers/dma/ptdma/Makefile
>>>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>>>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>>>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>>>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>>>  create mode 100644 drivers/dma/ptdma/ptdma.h
>>
>> Hi Vinod, Greg,
>>
>>
>> I had re-sent this patch series as per your advice a month ago with all
>> the review feedback's addressed.
>>
>> Need your guidance and feedback to get this code reviewed and up-streamed.
> 
> This was sent during the merge window... and right now this is in my
> review queue and will be addressed shortly.
> 
Ok sure. Thank you!

> --
> ~Vinod
> 

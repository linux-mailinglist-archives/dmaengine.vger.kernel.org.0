Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38003DD3EE
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 12:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhHBKhR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 06:37:17 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:39552
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232553AbhHBKhR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 06:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU+6ROmAFZvqjlx5G7+Wdmqhd1d3O1YABG5opAfe8zyIidRNSK1RBplIQ6JCvtHnFzer70EMKKquC0w4Dp3t9gZXYMjPNNRfU57b3psvTAolWO/sj41/1bA9sK1mBg9idtMGytqfYrgYzeOrQWzv7GKl7A/k/lmnALE0j30OPIR4+4aghGNWeO2Fkgbf8S1jl0LJSsiZRqg6pjikeRBU/QdPo3iyv3GUxGhXGsegcWO3DyxNtFXlJH64xYKBni6IR8oNKyQE/0oz+P9vvaBdh77edzpqEOfLhefqJVZkvVgDEudobYiUzbC26QIKsHgaF3yfOi2+fFKVct4NNEJb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0He4D2Uv8lIVAgh/a/B5rjr51KQT7utD+VBaQF7KZU=;
 b=X8TMywuaiTxhLcNFz7Zbpci1qgTbX/Kl//E/q4CacZpMHR0xkbyIY677hUzzCnmW+E+5DJrOEZROwh1KlgDYxo3M+U5ACvhV6WQzD/N2oxcDo8DBMRvainWQY0JvqoG4pqDZIQ7/p0JBsHfqUa+H/MLHjWUpi3iZI9niO1ZkNrOat612Hga8q7pUb7LwFCNmPs+BCkNvHzZx46rqDcV/b28DRWw1mghRdf3W8vPRe3XMaCDLGBbM93Fv3T+QsaBG87Qrb9Klc1vwQIfYgdgi/P0Sa05lsNRICMOx7BNmYyMvk3d+CCI3X39ON3n/4JnWIRbIA9gRRWfv4gA7Cuwmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0He4D2Uv8lIVAgh/a/B5rjr51KQT7utD+VBaQF7KZU=;
 b=H7Nm/+EAUXmtOs/iqyQPUVEsgMOt4pqanPYiKf9mXoz4a7TPtnOarQsJxpxoViAJ0gzkN0wY8B2awat4iacU5c0G4gaO7QzIFFFrrpBLFdJHRhTXd7VzAaE0FfltY/nqCnZf49tsyADf0zMIGBCOIUQpjNHNu02OlK7EYdYUWzE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Mon, 2 Aug
 2021 10:37:06 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 10:37:06 +0000
Subject: Re: [PATCH v11 0/3] Add support for AMD PTDMA controller driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <649e5d7b-54ba-6498-07e8-fa1b06a25fc2@amd.com>
Date:   Mon, 2 Aug 2021 16:06:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.44.125] (165.204.157.251) by MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 10:37:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320e512d-f17b-4641-c0d1-08d955a17907
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5200DF2BE6997B5A05C0642DE5EF9@DM4PR12MB5200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6acup9mQGQye7tSkNDR6e0YhJr9xBkgS2+RZ5SB6uwtyy0KziFNxod5vnXixkLvrgEimM4UaC4exrxaZ/d8Fb2FpvEt3lIy7EiLXX1UMbtMYRbRmQuSjaf7UDf22nFzwIFuYloaCrwYIWtQ/xalO7HV9JvOoMx/orIJSKY6thPF5PBca/7Buw5ijQUFQU4oyajE2O6nkLn6eExjJ0CF2xHPXam012QT1jI4HzYSPJ9FpYv2qp3d1NQ1hRjB27UReiD/ME2VQH15HbgKW+bGJzOCXRfOYNnBOslc8Vlx+Wu6cqo5ADr4qJQQPvjgamDCq5r+8EJ3csxGsXtewcTgTVTPvD5prT8cgl3T6y2MmUIyZCkeuDJRggtZWAoYI1NkUjuKo7X2EcZmB2hDbsJmMT3HzOAKsg3qaywF3ZCW5Se5+qToN9Vtb0+O3baN4h//EHpjwn+RQTZie2IF5cRO/cbfC1b5d8Jqg6tC9e/PtDkfNSRVqhXSW3Kc5Hg+aITYnnn3QhdD4WmVdSOSymnTrBUNUkhEAs6PiP14CfDRG/myLR/sHe6lqmnpykKKOgWdCn7oqmg5BkZMSHvv/IH5Ab93eMvJXaNg/awvN5ZZL9ZKnNrTTGjONtoDPVUkAHwH3rNF1GUIOhG/vLijOd3OuZt7PK9wAj7ffZJnmt8atoMuVGm71cWjdsUofjFylCNyQPZMjYKKlSFVpnragQohKX9gyMBpJfDRsA+X8C0HwD/55gXXdOFDVFVMjQnEgtY0OPH4Wel9Mk6WKLjFTfCz2lHIhKvzidW0K2GlT8yRGYYSfLWgS5WjYVmiC+/OKkuXs2MOrWHjod0dXAE+5hFDBNV04G4nK+4CmeiXvEEtrEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(36756003)(6666004)(6486002)(2616005)(956004)(26005)(2906002)(83380400001)(31696002)(53546011)(316002)(186003)(16576012)(66556008)(66476007)(8676002)(66946007)(478600001)(5660300002)(4326008)(8936002)(31686004)(38100700002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RncyRkpveUllc3dnZkFJcEVOYUdlZTFKejUzclptR3BtdzBYSGpmcGxzeDM4?=
 =?utf-8?B?N01PVHRSVlFIMExVay9aMXd2Ry82NjFZRzdkMWgrZkFVajFmMTV6d1p5OUZy?=
 =?utf-8?B?dld1VWFHcSs1K2liV2FJVDlSTkJtbHFsU2hSc0l0MVZnN1QzTWFMcFNQaG9y?=
 =?utf-8?B?a2FPYkRtaGFHaWVEM05sWmVJN3lEWWZOZVdzNnFUZFV3RUJkUFdVbjViV3hu?=
 =?utf-8?B?bUVVNEJLVDQ3TExacEVlQTlEYXdRemVFTDVJZ0x0bXlGc3pSREF3b2NaMmkr?=
 =?utf-8?B?VDFCSEJlUU1ZT05OT0pIOVJ4RGpVNFljVXBOeFR0enc1N3NncWY4Q2dKTjlq?=
 =?utf-8?B?TEdSTkdsdnIrZTlhQWlCWml3dGQ0aFdFY0dKdlpxVzJ4R0NsQWpKNkp6czRG?=
 =?utf-8?B?TFZUQUVkVVlOTkJIRkEzTFpiVWRNYzVmSXh0T0J0b0pWb3VVK2hlR0hSRDhS?=
 =?utf-8?B?dVZuZHJEVWJ0QkVWbTdtS2VrSTJob0txei84U3UvekF2ci9EVVo0dWtNNmhj?=
 =?utf-8?B?NnY2di9CQlltcGdwKzJXVDdGYmdlSG4wSGJGM1c4VUc0dGppMEhIUHdPb21z?=
 =?utf-8?B?anNCbHdkSW56SjlublFNWEg5Rk0zUllzK0tGSUZPc0ptcjVoeVNSQ2N1ZzBh?=
 =?utf-8?B?eTViaWRBaFE3N3VsRy9KTlFHV3k1MUVmRlEzUDZmUnFGSWpTSW0zVjI2TkFz?=
 =?utf-8?B?enM3STJFU0tsSmliNDErV3JZT0lraW45ejhnZjREeGwxRlRGVVlJVkc1djhu?=
 =?utf-8?B?VVlPZnhkYUd1VFZDU3p1MW5XeGozQWxHL3pZcEc1Ty92eVp6RnFzK3pzQUVX?=
 =?utf-8?B?Rk9NeExkQVZJbHVXSjhlVnhWdHhpOWhBQ1J5czF4enRmNlBVYmlrNzZwSzV6?=
 =?utf-8?B?NUJEZTlOLzJDSHRXZkkzMUp1TnZSRDMyTW5OdmhIWmFqUzNFQkRkbFVxNVRv?=
 =?utf-8?B?OGkrNWdGbG5kOHkzS3NLbjA2VkR3c2NZUUVjYjkyWGNGME5XNFcyUzc3UG03?=
 =?utf-8?B?eHptYk5xejdXSkEzMHhCN3ZWV0F3SDhlaEQ4WUt5QVExd01FTzYvUUIraUps?=
 =?utf-8?B?eFpULzRYNWd5dTEzV0phWUFYYmRQbEt3RHR6NkYyVnFnSWYvb1lZQXR6VTB2?=
 =?utf-8?B?bzRmMEpSdXdZMFJGemlsUGswRGdQdXd5UDA2Sk9XZCtWd3NVS3F5QU1wU3hD?=
 =?utf-8?B?b0FVZXVvQ3NhajVMT1lLZS9iYXErK3g1UllZZDRIWEp6aVUrRFdVVFR6REN2?=
 =?utf-8?B?QXJSSWF4clZaRDBuSGk1WDB3SHVsR1c1Tmp1MjBzSTY2N2xWN1VCMmIycURC?=
 =?utf-8?B?eEpUdDJ1eDhTZHVrbTBwWGxIWDVaKy8zYXZNZVkrbGZ6K3JSd1BHVU5kblI3?=
 =?utf-8?B?NVAxT3F0U3I1ZGlTR3NjZ3VaeEorWmRXelBjRnhOclpVNWFQdTVlS25OdGR4?=
 =?utf-8?B?Q2JqUDJhN2Z0RjhSS3d6OXVkMy9TdFVZdXZUODdQczVRQ1JSa3Rrc0Nqd2h2?=
 =?utf-8?B?UEYyN3NvN1hyekp2MWlRK2xNVmFMb0p1VVVNYTNmajl1TnpNaDI5T0E4Q3lv?=
 =?utf-8?B?QjVBMkhEc2dyTXJ5Z3A1YUx1dnZ6YXRpMTBMY09xUEkvOXY2RW5Sc2lpcFR4?=
 =?utf-8?B?SHlOTFprL0h2ZXNVWEROSmUvN1RMazlsMHVYQmtTWUdUaDQ3MUJIMW1aQ2cr?=
 =?utf-8?B?NXBWV1Uvb0NOVFlRSnNEcm9OelVFOHZyY3F1M2J1dFE1andpcld3UU1Db3cv?=
 =?utf-8?Q?rDJnx5rq7YEUXVMWj16/eqcjLJfRDH2MS71W9X9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320e512d-f17b-4641-c0d1-08d955a17907
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 10:37:06.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMyBIob+d0Avc7qIHzVyzUXeI+wiJlY1PIbLqBs/A1kA0Zweo6QBGCoYcyLZGfBS2VuId9bvker+fPT2MvUqhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/2/2021 4:02 PM, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 

Hi Vinod,

I have fixed all the review comments suggested in this patch series.

Thanks & Regards,
Sanjay Mehta

> This patch series add support for AMD PTDMA controller which
> performs high bandwidth memory-to-memory and IO copy operation,
> performs DMA transfer through queue based descriptor management.
> 
> AMD Processor has multiple ptdma device instances with each controller
> having single queue. The driver also adds support for for multiple PTDMA
> instances, each device will get an unique identifier and uniquely
> named resources.
> 
> v11:
> 	- removed IRQ_NONE from irq handler as suggested by Vinod.
> 	- removed pt->name parameter and instead used "dev_name" in the
> 	  code.
> 	- used register offsets instead of having pointer for each
> 	  registers as suggested by Vinod.
> 	- removed few unused variables.
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
>  drivers/dma/ptdma/ptdma-dev.c       | 308 ++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 243 ++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 325 ++++++++++++++++++++++++++++++
>  10 files changed, 1407 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
> 

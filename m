Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6352B355A21
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346826AbhDFRSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 13:18:33 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:34944
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346834AbhDFRS2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Apr 2021 13:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ4CPsmTWMlPcwmWphL/cZjMrSU/IbWa6w1g0XSGSa9HZpX/v1bY27/FpXsIp+pM72SFKjCq0VtzMx9yljGM6q9BE1DxVvoGsuuvu0j4NTiZ18gBrhECtPLbbqmRMOHx0Vor3+jeIKQrB00HlmFOk8DdKzyNk1QE5nhfWoX2KeqT4WJRkb98Vxrp3XctPG9U+wZHcqpVTSGaT/oP1T/iesDSXvJIe6TzNeHF4krWD02BGnskxG9spIMRflSbaxH4qs8rCPSgn9EwByBD8ZVzJl7eGXyTza5FVAIRKMN0mgCt8pXBnFV3wsZ4o4lx40vVSndgxXiYQYLEwCDyJ79w6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj4dXsdv0rCZylBhHcitKODSpFoxNRfetvArLJFH4D0=;
 b=hS8ACK1E1emizPrxxRrsSK6rQtXLVU35AIZQuMRYBj9wHik9kWgIlCOGF07YKne2xYLShDYBFuqFGnZiMKDR1/bBR9dL3CDiGGfjRhaJ7nOYP8pJO4DNkUD6qjPxlmb+10CBGCHaxmzfhhPyTNUGflifNQLk97DOXHfTjxBDEdnWNZ4UCw69gnHpg63L0xIt3hPKm6nXSDQ2O1U+P2WiyH1Jhh5L1MwoMMDe0+QZL0nbs19MKbdfCZs2nqL9ABSK+pjQTowTHUsxT7MZ/KI0Aj8MoFVlQH2B5ABQHAqoQNlwmmwMcPUGcy6V+nRrgmYHXoEkj9MAAuAemkPIGH2BnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj4dXsdv0rCZylBhHcitKODSpFoxNRfetvArLJFH4D0=;
 b=ugUS8yZK/GHqzWFxnM2JC7TWo3AV2zKiUQKnD1UO/jTP1jSt/N02b6toRFNeLDGkPyN8wyQcDbWpqLwIXsCMogKChb9g74f44BRsvF3E41Z1dQ2yfZGnpAOKnm5MfhWLJenkWFzu/EnbTDsMAMYoYEYEAHkOZbhauUbFDS8LYjE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10) by CY4PR1201MB0120.namprd12.prod.outlook.com
 (2603:10b6:910:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 17:18:18 +0000
Received: from CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e1c9:1f8e:5175:392f]) by CY4PR1201MB2549.namprd12.prod.outlook.com
 ([fe80::e1c9:1f8e:5175:392f%11]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 17:18:18 +0000
Subject: Re: [PATCH v8 0/3] Add support for AMD PTDMA controller driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <dde31ffb-5bf0-423f-5236-4d289d6d0891@amd.com>
Date:   Tue, 6 Apr 2021 22:48:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <1616389172-6825-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [122.181.217.9]
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To CY4PR1201MB2549.namprd12.prod.outlook.com
 (2603:10b6:903:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (122.181.217.9) by MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 6 Apr 2021 17:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9efabe5c-ca6b-426f-9877-08d8f91ff877
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0120B856E1E3A5475BACEC0AE5769@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJO8HNaMOQa7G/bYNRIOVdMxSvkNksy1OFfbj8E11LkQ7fTnDvNm6xN5fWStlLqrdElukG0QUWh23LKn8SXnjGgeGtH/knijsOuk0HUUOxUozFuFtQr1G72fP2PehEP9D03oHRYK1cCH5yRA4RuqNKHCYRosG8MqqBPGp1T8fEph1TuZ3do9EZph6mwyX1HKH/b3r9bMf37oH6uAI8AwqRANkc/Qw+MTaLAJk2imIQCXPlgx5Lo1pauRfDprUE7BZghNRuO7EClbpCmAY4+kHxi38wXQ/st4aNrhNmyg/QamhuNPsuWPAXaTrd9UwCwyI1R1cJ/7n8uiAdlbnN4JjYZzmG1UrY7pzq17es7REGqBaehaKSR1Dt3voRQN3RMqEKcg7gmxJelas8MpzHJ0iSp7iyTCv6I7hF4sRhEQN2DQrxIk1BigB7IYhEqr55JDFJsjX5oNtxBzbVXi85S2X2HgFfmw8ZWvfbDmMGY3bgPpYts4DJdsVoTgjKi01nMXmfnGkgqn254ajDOr4W+fXfxnbqmyeDtmovIsNRG5pSgjw3en2k4aD9fA2LlogH5oXDbFW/QUOW6FxbfT2e0rAsdMP286tSfHc1uumy2+TTyZdqLDXoBi817Xp8YXyhqMc09soPr/v2SemCjpJnNAd05UpsW6w6oM4XEFhKC4qnTwUfCQRy4xNu9edDJznqaTK4FEbvG+g1AGADpJiEgsupa7yErWX17RXQsTns+l+/tboRlQRVBidkOuCPaLscm+fvlntt12pXb0RRo7EaqY56jKknXlBzg8EVw97Z5Ecqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(186003)(52116002)(83380400001)(2906002)(53546011)(8676002)(478600001)(5660300002)(6486002)(8936002)(4326008)(36756003)(966005)(31686004)(16576012)(38100700001)(2616005)(956004)(66476007)(66946007)(26005)(16526019)(66556008)(6666004)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UjhHMHQ5Y29pNkJSVTlkd2VLQW8zaWxOOEk2VkNGNlgrbDdhVVgwL1dpcjFE?=
 =?utf-8?B?YjlnaHpjcnpoV3dpdEJPU2ZOMGp3MXdBQlUvdnRXR0xaOVVwSVcrUUwxY0RF?=
 =?utf-8?B?VDIrZ2JlVDVKUjcwT1VsQ2hzbSsvU3ZmWFluZlNoRVNWL05JbWwzSERPVlJQ?=
 =?utf-8?B?WXpvTS92Q1dQYzhDem1tMU9FbUNNM01ZVC9ZQnlqNVVXci9vWnZaMThERllW?=
 =?utf-8?B?d3oxSDZUa0Voc2tlckk5SW9kM1Zvamc5TlhUTWFEYS9XRjdVUWZoaWtHYjE5?=
 =?utf-8?B?ZHl2TWhoOXo5YmJnUVdLSlV4b2RmdzhZR05kdjUvTnJZeFhVRTdkb05lSEJN?=
 =?utf-8?B?ZVZNemZtekZmMDVGbmxieVg0ZnFqZHhERzlOcEI1WXRScll4L1IvbHpiaUIx?=
 =?utf-8?B?VVllVGxrMUR5cVpKRzQva0FZTXBaNXN0VSt0bFFBYzI2WEF3OWZaQzFOdTZp?=
 =?utf-8?B?MFkvaTVzbmx0WDIwOTVOQk13ekkrbzN1OWRpTEpFYk1YWEpFWSthdVRQRkpC?=
 =?utf-8?B?M0dCS0FZN3luclZ4Ly8xSTQ5b3JrbjRJci9ncmtRdHZCd2JMeU9lVElDdGRl?=
 =?utf-8?B?WE1aNEpnakNmY3VxcmIrRXVIOUNrSzBxSEY0SW90UmNOQ0s5Tytya0NzdXdX?=
 =?utf-8?B?ZWtiMi82YU1QT2d2VFcyMEU5TFR1anV4YTd0ZWFLem1ucUp1M3FQMlovOXVl?=
 =?utf-8?B?TG54M1dwNmtwYTg4QVg2dVIzMEhxdkRlMGgxM3N0aUc4NHdWMmlsSDFJc09C?=
 =?utf-8?B?anZZb2xjdUFLckVIWGVBMWdYOC9KZzFxUEdIYVh2WTl0TXBkbSs0L1kraDdB?=
 =?utf-8?B?YUxSNHdtaGtpWkt4NHZNYXNRSmJJQkFwV1lXT01jSTBpcmVJYnFWUnk5WXR6?=
 =?utf-8?B?QVdjbkVNUkxudFdBQ1lDc0g3cTJBeVB6elQxaGlTNWN2OExDd016VXJkdFRj?=
 =?utf-8?B?RjVsc3diY2xiZmVJM3F5K0U1Y21BQ0xoSS9CVC84eUE0YmVlSktTL0ZZclZW?=
 =?utf-8?B?NjI5RUlKY1BNNFFMZkYrVHlXRVNHb21tNXVEVEQ5TEd3WVhFbGR4VVZTNndC?=
 =?utf-8?B?dlIycldPM3RGWThsUVdFMllLMHFMengwTGhsZ1p6MmtMMUUvWnZyelZtclZF?=
 =?utf-8?B?R2EzNW5tZFFEZ25Vc2lZNnFlVHk4NGNBd1kzd2ZCY3NHWUwvK0xIajlKKzZv?=
 =?utf-8?B?SzlGZmhYUkVzRWRQaXdoZVpnQmFzTm16S3NkNWFtSXYyS1NIZmdndzJDSGRX?=
 =?utf-8?B?ZFQyb2JmU2ZXd2lCTDNvbXlFUzYvV0hYOER0bEZFSlhSNm5aNndCWnJBZDYz?=
 =?utf-8?B?M0wvV1FNTEM3V2o3ZTVpb0lqOHltVHFXRERINEtva3J0V3BFeFB2K3FaS2c0?=
 =?utf-8?B?RDNSODVwRDBYanNZdHJlZmYxRVQxc2FsTmVlaDhNanRWdlpHTEJqM3pOdUl4?=
 =?utf-8?B?aDNkNXdidzRCWnhBc1JkOU0zcGJpT3YrRUE1S0poV3FTc0xxdHhUaVhJckV2?=
 =?utf-8?B?UGZhNGJTU2JBZXpRTHk0ODNmcjhOWExYMXhTb2YxaEt5aXI1dGJsZ3IrYlBH?=
 =?utf-8?B?aUZXK2YxMlRhYisxaklCSHVXV3R3NUhiY0JPWHpwV0tmRnpma0VaMGRlSlVx?=
 =?utf-8?B?alhIUDkxRUdJMTZ5bnh4Y2tTWWNxUWJIaTJhL01Oc2ZJOUoydW5tbGlCc0Yv?=
 =?utf-8?B?dUpFckRjd05vU3ZnRk1hUS9tU1U2UTN3YTVDdGNKbjhhSVg2WHlOeERiem5j?=
 =?utf-8?Q?+LnJRjPmAGEZf1dshfkgEhOyhhf6B0UjqogzvMY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efabe5c-ca6b-426f-9877-08d8f91ff877
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:18:18.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDIMOBMzdYXJxcl8eq5Xhf3sBA1DoFw2sRpwwLEv2uiFAhcfCVwfz1eb9k0Es9P7J0THA8+nF65+pN4LTmNTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/22/2021 10:29 AM, Sanjay R Mehta wrote:
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
>  drivers/dma/ptdma/Kconfig           |  13 +
>  drivers/dma/ptdma/Makefile          |  10 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 115 +++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 480 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 251 +++++++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 342 +++++++++++++++++++++++++
>  10 files changed, 1547 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
> 

Hi Vinod,

Any comments on this patch series?

Thanks,
Sanjay





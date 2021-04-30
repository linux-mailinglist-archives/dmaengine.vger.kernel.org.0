Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B911636F609
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhD3G6w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Apr 2021 02:58:52 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:64248
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229610AbhD3G6w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 30 Apr 2021 02:58:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvESAKhyLMekZ2NjMAfxpYz/zapr4KfQGZn1LYb1EN2DD5Ywyoha3UeFN19xRxrqUAYhtFI4Yd9ERk5S6tv13GEK2+9fCkxHNywsol0fysbYirFHquexVRKluiimJjIO9XZA2cuZ4e05snRqRLjIJWUiGRb6/JP0dd/IWDvJ5kIJKgUoHRag0PXV74Kt553Z1j2+EKaUO9NIlKbOhB8O7b8ms9SCsHJVHY8P+3SCT8fvcF4Yyv0QCMEwJET6WsIfB/HN8m5ja6WdCxvjg8srrvEBTWUl0sKschoqY5zaUsGOJ7L7qagiwkBl5TPgrrhBMsrOVimrH4R3c3FqOPcpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqZakN8sSqxoZlgaRDFf7RDgcAgumUe2zgoUUxmcdUI=;
 b=ZzWZRg6hF0AwO6gUs5ht3MsB2QBue42scasfgpEFX/pG8MxZs+2mwLflwMhRsjpadbHGAr+IOpZfrWdgho3xypzGe7CZHoXZP2Mjvcryg2xiTjkmVMXE1WAQO2z0qiQGDYG59ApkrMzUNmSA6g+onpo3b8gKnPqx4gfQIkWlaq7YJrXsSqxo2QVOssI74IsrEGCZSTBU12hVOejetFYV3WgqS0YnQC6Ur2VSOc2IiMMABjxC7cZXoTy0ApjpelHPztXQA6OoqL//yTs1uR06Cg+GVIRlgejflt50vQwrlBKMyL92giZuxjqXtzIVM3WLip/hM9oxz0wTpHCyzClluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqZakN8sSqxoZlgaRDFf7RDgcAgumUe2zgoUUxmcdUI=;
 b=YAl8+wWCEVj8PTWQtBdnq6yxbTop6VEOuBEKR2AMM++msBXQQI9Cx+eeczKdo7QtNImGaWZiE6U/C2ZlC4PbMMHuDkAD5Wi6SumHzh2fKudi1A15ksLUNinaoY9ZiEwx6c41rCQYLgjwK29l86LYGufr0FMXkS9COYXvWtjFJ8c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2102.namprd11.prod.outlook.com (2603:10b6:910:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 06:58:02 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 06:58:02 +0000
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: request_irq after initializing
 dma channels
To:     Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210429065821.3495234-1-quanyang.wang@windriver.com>
 <YItRB7SBhiilzDLk@pendragon.ideasonboard.com>
 <1d88d67b-aaf5-823d-0cf6-c9422c01918c@windriver.com>
 <e8a245ac-e326-0e10-728b-b0ded7c03a71@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <a0a471fa-c9ea-a838-95f2-3b688fe10505@windriver.com>
Date:   Fri, 30 Apr 2021 14:56:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e8a245ac-e326-0e10-728b-b0ded7c03a71@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 06:57:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132ab6e0-32da-47ee-c41e-08d90ba54be5
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2102:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB21027E39AFBE5BB5F174BB82F05E9@CY4PR1101MB2102.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc70fHtw4Z9ZBs4Deg6nfrVe8b9oXYpfc0v+MRl+LcrcfTRcblDLIEN2fJRON+AnnLEQaWeJ15XMDyRKCdK0Ew+DNoOlGswYQHN4z/Xt4R62+vdcCLyggaSeMB2xyoNMG5xOz0R4BjGJ7B104oADy00imQ9a3HzroJ1GbSphjTpaiLlmciEWuLXndeuQ/OE7Zx+Gl0BI0OIldBOv0ERMCU0FAvrQVux9YMCRe+hdUIf1Az5V1Vh5YvCK1Wf6f+9nFTtzcC+bRSDV7SAzFtXkT+9MGxg6pPmHlPRjNll5ahyTP+gZp6F65Ce7LYKEPLHIZGROK0MHYOzGFtGzAJX7oSrK6/BoB/+NVMYbhL0SCOkwfQKA7xgElzt/J2oEIjH7Gydpeok5lVLWZC3z4AoYllozRWp2M42hcKmsZDrUmEM/G0CO0Cz8doqqIYLkBpsYmuckfHGDn9N/jWBrHM9n151jKbQ3lQ2hG1YiW35IzlocSgiX0Uc3oHmSdVOjVpnLRivwxNw1wqoFAluqlwRZRqYwVy+t+Ch7nc2RkfthcowcTJRV7RXDsecEw9ZkLH3r1gkPJBj7nJEJVUKeaVEgavQ8cUDAiKV7UIJw0oMKH6KhMAozM8ia+horCxolyca6r0mgnm3n1rmcnGzgSwOKFFYF8oYX/U1usIsQoeG5Mzmmq6+6PHgpprGGHWz89afPegJU0J7MYa/IwGq0Wn2kEp7aheCCOoK3bmXjkR5HkGfQOaexSYsCOzeae/6xjhrU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(6486002)(45080400002)(66946007)(16576012)(8936002)(2906002)(110136005)(26005)(53546011)(66556008)(52116002)(66476007)(316002)(186003)(16526019)(478600001)(6666004)(83380400001)(86362001)(4326008)(2616005)(31696002)(956004)(54906003)(36756003)(6706004)(8676002)(38100700002)(5660300002)(38350700002)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmZKMkNnekk1R3c3OHJaR2x5cDZFSUJzUFZXTFp4U0RlaVBnU1dPaG5hQjNQ?=
 =?utf-8?B?R0JxeFpaS0pLUkN5R2ZsRjRiWk4xVDBnbVBKajhGbDhTeE9sK3FLMUVsNHY1?=
 =?utf-8?B?S1dVcGdldWtwRnViNlZqZVY5RUlCcmlReU8veWhnZVZ0UWlZNHpjM0h6YUVl?=
 =?utf-8?B?L3dDUGdGRHNBcVY4bjViWFp0RzlNbTN1VTcwdXpVWUFjV3JUdGY3Y2k3RTRD?=
 =?utf-8?B?aFNwd2RtL2srSXdVNlNlT3A1MzhZeDdiS1FNd0pwelFnT3Rnbk1FWjFZcFVL?=
 =?utf-8?B?TldIQ0lXOVZzZjB0ZWlqVVJpZktTRmJLRUNjR0FXdFdNZmNyRW5TSHpFZWVG?=
 =?utf-8?B?R3UzT20raVVGQWYvZ2pLNkVFSTgveWoyVWI0UWNWRmlXN0o5VU9wUHBMZjB4?=
 =?utf-8?B?TEJBZXVzaDltVlV2MHVIR0ZzYjFyTE0rTjNYQlNSWWhKZ0tVTU5NcXp2RHhY?=
 =?utf-8?B?VVNxNXFnMmwvOG1TWkc0TkF2RDdEcHpBS3E1UWxMS3dzSWdOUlpXYVkralJz?=
 =?utf-8?B?OUVoV21RUDRTRkdvL0F1UGdmTzA1TEI0eFpUaFJYY2xydUIzY1hyN2ovejY3?=
 =?utf-8?B?Rm9FZjBNN0o5elBlbEd1eWpGZ2JzZW1BY1oyTDE5cCtVK2tPbm9CTTdWaERt?=
 =?utf-8?B?MDZVWTdBdW01YWFOSCtaQTg4MktqV3ZlVGpoYjhTandVVW1qdldzTVpYZjdD?=
 =?utf-8?B?clR2Wis4RlFvTEF5dzFlNVpFV1ppdmFlQXVmS0xzbng1OFJaN0EvU1JpbmNn?=
 =?utf-8?B?TEVXT1dFSU10MEdFSXB0WUpWZ2djcS9WaFRQRjRSQkxsdFhkcHN3YnBKS2g3?=
 =?utf-8?B?MlVBWUNzcXovZCtYNVEyVnFCNyt1ZDVVUXZvOUhkRFhVcVlhR3RKcGE0RjNW?=
 =?utf-8?B?R0dUN3RXWHNMVVY1TGp6akRFSTVaVUpkZkl6TGhPQW4xQjU3VWFXcFRpQ2k2?=
 =?utf-8?B?My9RSWNOc29KUzZ4YW1MRVFFSDZRK3ZpUFZPbFhzd0V0L2hMNWNTVWZBa014?=
 =?utf-8?B?Uy9HUWJBSTBMZGRpNllmazM0bTJrMWVZTmVaUDdRSDVEdm1MQzhiMEFUR3hX?=
 =?utf-8?B?OGdYRUNYOXVSN25mZTJqWVFGYS9kWHlheFlvM1F6TUxEZFF3bTYzQnkzT1pX?=
 =?utf-8?B?bFFjdlhvVkh3UTNoOUxubDNBRDBqSThHSGhFZ1BGVzQxczJXcytmMXp2SHph?=
 =?utf-8?B?NkdkRnZVZkVncnlsdVc1ME9TM1FpK09oWm9iWWREb1Bvam9pSVhDcDY4VHBS?=
 =?utf-8?B?OFJiU1hZaSsyWTA3NjBhMTFtQU92U2t6bFJVb1N4VnFzczY3TDJ4ZXRFTzA4?=
 =?utf-8?B?cEwxTkoyWUhtM0tnWTd4TEJNQ3psRjFhSkZVY2xMeVkrQjlvOEtBVy9qdjFu?=
 =?utf-8?B?dU5FVHdSUUZOMzR3eDBKN0M5Z1NKVktXZE96ZFFLYUNtUHZOTVMzVGxFRXBB?=
 =?utf-8?B?dEliMUNISUo1M3NmbCs2c1BnREFqcS9rc3VTMFZObGtrb0FSK21nTEJ6OEdR?=
 =?utf-8?B?QWVudjAreVp2UjJGSGxuL25yTlhRUC9wcHRoaitlRHRhNCs2bmdYNThtVlMr?=
 =?utf-8?B?Y3dobkFjaE13WkVNZWNtdG9pRWZTWTkxb1k3QytkZTltR1ZQV0pNY0ZYenNZ?=
 =?utf-8?B?NVNiek1Bek0ySmVDWDd3a2R5VmVFOGMzZzlnMi9kNkt4NkVsWWlIaERMdXBC?=
 =?utf-8?B?a2I4eUdGZlp5L21XOU10OFl0c2crMzZFY2JoVFUzUEJyRnVsbmdJMFVLS3BQ?=
 =?utf-8?Q?foBEwvQ76TNwChCa560th0aJkneWZVlBe5siqr7?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132ab6e0-32da-47ee-c41e-08d90ba54be5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 06:58:02.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzwR0D4qjnvjstfeJGRCF/Gm+9aCjpWpN8mIas8tdjpTNmc6zCTsEYG2f2zy+edzIJ/5IbvgtH8pMD8425D+XtbRRzdJd5hPVPvJCO/F7rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2102
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michal,

On 4/30/21 2:51 PM, Michal Simek wrote:
> Hi,
>
> On 4/30/21 3:45 AM, quanyang.wang wrote:
>> Hi Laurent,
>>
>> On 4/30/21 8:36 AM, Laurent Pinchart wrote:
>>> Hi Quanyang,
>>>
>>> Thank you for the patch.
>>>
>>> On Thu, Apr 29, 2021 at 02:58:21PM +0800, quanyang.wang@windriver.com
>>> wrote:
>>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>>
>>>> In some scenarios (kdump), dpdma hardware irqs has been enabled when
>>>> calling request_irq in probe function, and then the dpdma irq handler
>>>> xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
>>>> this moment xdev->chan[i] hasn't been initialized. So let's call the
>>>> request_irq after initializing dma channels to avoid kdump kernel
>>>> crash as below:
>>>>
>>>> [    3.696128] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 000000000000012c
>>>> [    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx
>>>> DPDMA engine is probed
>>>> [    3.704900] Mem abort info:
>>>> [    3.704902]   ESR = 0x96000005
>>>> [    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [    3.704907]   SET = 0, FnV = 0
>>>> [    3.704912]   EA = 0, S1PTW = 0
>>>> [    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using
>>>> dummy regulator
>>>> [    3.715585] Data abort info:
>>>> [    3.715587]   ISV = 0, ISS = 0x00000005
>>>> [    3.715589]   CM = 0, WnR = 0
>>>> [    3.715592] [000000000000012c] user address but active_mm is swapper
>>>> [    3.715596] Internal error: Oops: 96000005 [#1] SMP
>>>> [    3.715599] Modules linked in:
>>>> [    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>>>> 5.10.0-12170-g60894882155f-dirty #77
>>>> [    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
>>>> [    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
>>>> [    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
>>>> [    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
>>>> [    3.798089] sp : ffffffc01186bdf0
>>>> [    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
>>>> [    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
>>>> [    3.811996] x25: 0000000008000408 x24: 0000000000000003
>>>> [    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
>>>> [    3.822604] x21: 0000000000000000 x20: 0000000008000408
>>>> [    3.827908] x19: 0000000000000000 x18: 0000000000000010
>>>> [    3.833212] x17: 0000000000000000 x16: 0000000000000000
>>>> [    3.838516] x15: 0000000000000000 x14: ffffffc011291740
>>>> [    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
>>>> [    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
>>>> [    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
>>>> [    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
>>>> [    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
>>>> [    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
>>>> [    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
>>>> [    3.880948] Call trace:
>>>> [    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
>>>> [    3.888079]  __handle_irq_event_percpu+0x5c/0x178
>>>> [    3.892774]  handle_irq_event_percpu+0x34/0x98
>>>> [    3.897210]  handle_irq_event+0x44/0xb8
>>>> [    3.901030]  handle_fasteoi_irq+0xd0/0x190
>>>> [    3.905117]  generic_handle_irq+0x30/0x48
>>>> [    3.909111]  __handle_domain_irq+0x64/0xc0
>>>> [    3.913192]  gic_handle_irq+0x78/0xa0
>>>> [    3.916846]  el1_irq+0xc4/0x180
>>>> [    3.919982]  cpuidle_enter_state+0x134/0x2f8
>>>> [    3.924243]  cpuidle_enter+0x38/0x50
>>>> [    3.927810]  call_cpuidle+0x1c/0x40
>>>> [    3.931290]  do_idle+0x20c/0x270
>>>> [    3.934502]  cpu_startup_entry+0x28/0x58
>>>> [    3.938410]  rest_init+0xbc/0xcc
>>>> [    3.941631]  arch_call_rest_init+0x10/0x1c
>>>> [    3.945718]  start_kernel+0x51c/0x558
>>>>
>>>> Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx
>>>> DisplayPort DMA engine driver")
>>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>>> ---
>>>>    drivers/dma/xilinx/xilinx_dpdma.c | 30 +++++++++++++++---------------
>>>>    1 file changed, 15 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c
>>>> b/drivers/dma/xilinx/xilinx_dpdma.c
>>>> index 70b29bd079c9..0b599402c53f 100644
>>>> --- a/drivers/dma/xilinx/xilinx_dpdma.c
>>>> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
>>>> @@ -1622,19 +1622,6 @@ static int xilinx_dpdma_probe(struct
>>>> platform_device *pdev)
>>>>        if (IS_ERR(xdev->reg))
>>>>            return PTR_ERR(xdev->reg);
>>>>    -    xdev->irq = platform_get_irq(pdev, 0);
>>>> -    if (xdev->irq < 0) {
>>>> -        dev_err(xdev->dev, "failed to get platform irq\n");
>>>> -        return xdev->irq;
>>>> -    }
>>>> -
>>>> -    ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
>>>> -              dev_name(xdev->dev), xdev);
>>>> -    if (ret) {
>>>> -        dev_err(xdev->dev, "failed to request IRQ\n");
>>>> -        return ret;
>>>> -    }
>>>> -
>>>>        ddev = &xdev->common;
>>>>        ddev->dev = &pdev->dev;
>>>>    @@ -1688,6 +1675,19 @@ static int xilinx_dpdma_probe(struct
>>>> platform_device *pdev)
>>>>            goto error_of_dma;
>>>>        }
>>>>    +    xdev->irq = platform_get_irq(pdev, 0);
>>>> +    if (xdev->irq < 0) {
>>>> +        dev_err(xdev->dev, "failed to get platform irq\n");
>>> As reported by the kbuild bot, ret isn't initialized here.
>> I will fix this in V2.
>>>> +        goto error_irq;
>>>> +    }
>>> This part could stay where it was, just after
>>> devm_platform_ioremap_resource().
>> OK，I will move it back.
>>>> +
>>>> +    ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
>>>> +              dev_name(xdev->dev), xdev);
>>>> +    if (ret) {
>>>> +        dev_err(xdev->dev, "failed to request IRQ\n");
>>>> +        goto error_irq;
>>>> +    }
>>> Ideally we should reset the device before requesting the IRQ, to ensure
>>> we start in a consistent state. There doesn't seem to be any global
>>> reset unfortunately. Shouldn't we at least disable interrupts ? It may
>>> be a bit pointless though as we reenable them right below, so I suppose
>>> this would be OK.
>> Yes, we should start in a consistent and clean state. I will disable
>> interrupts
>>
>> and clean up registers state in V2.
>>
>>>> +
>>>>        xilinx_dpdma_enable_irq(xdev);
>>>>          xilinx_dpdma_debugfs_init(xdev);
>>>> @@ -1696,6 +1696,8 @@ static int xilinx_dpdma_probe(struct
>>>> platform_device *pdev)
>>>>          return 0;
>>>>    +error_irq:
>>>> +    of_dma_controller_free(pdev->dev.of_node);
>>> Why not free_irq() ? This change isn't described in the commit message.
>> I will add it in V2.
> When I was checking it that request_irq was called last. It means it
> wasn't necessary to free irq in error path. But double check it.

Thank you very much for your reminder.

Yes, free_irq is not necessary, and I have abandoned all modifications 
of V1 and

make a new V2 patch.

Thanks,

Quanyang

>
> M
>

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34AC36F3D0
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 03:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD3Brt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 21:47:49 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:38401
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhD3Brs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 21:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPbPX3xOkZ69I9jwWiS+XV+rBinq1x194NnCJrqq+bWmG7WEB4fljzf88WbYqahjx7HRrAj4w36n8BjjZYkcFHxeYNWoV3R3gzXb+lAsbo4acFIfc3/oNIVnDMNTwNa0Z9YkYeRB8KE3SNxHj1FAlNmGAVS+APBOgh8EKc69HWJhLJJ4rieZPLu8rl2CyAq8stLNPh1OXgWw1WNWhZtIbJ0bIC3Zc4rOQfu00FuSd7M4I2uEDXMc2AKVmFH9FUfPZfyx2sPcn8jnfSenIqyNFgL/VFxoAxb2QTa/ymBj0PXA11UQOMxkEWh/9RIogBbvqYnia74PdA2o97ScxB53/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Hw9Ib/Ch9hTN80nP8w2ZLuzQsAnnmGRk74afOnVYM=;
 b=J/DFKNV5uah12sbckEBMRBF5vtgT4oQceoBbxtEqeAYCAqERzsefSXBpkFFynVdeOIHeeF+ChhDiE/PwR+oVaY9xQAGBmttVqoCmpvmS3K2eTJQvHML/0YcJ2YGVMdunTyzimGJFLHoqdJGWwD36umEpKTjJczQhKgDU++JUzkLMvNET4xo1Vy8HXFUQoGZNt9QPG++KBGpAu0jcBw7XIzUdLpAcHoTY6TvrccZQwBpCBKC+cRPEmjgoZnIMnInHMS6r/9gtX44fBmyyb/KJLCWqDXZRXiDNEpLuOQoIbfPkSS2stOxfifmNjzEIEMzBD69yeyrcoEQugf/xJLZVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Hw9Ib/Ch9hTN80nP8w2ZLuzQsAnnmGRk74afOnVYM=;
 b=aW7mM2Kss6FP4KqE6gDp9SjrnwNvimgO0wYp+t+PxaHrUQRcQ0HRmPS4d7n1YKuuGEYzFzqr5Ps4eDNz8JiPoVJiTin4GWhtMJdS5o14TiywADxlsN967MEH/Hxml6N72kvMaCdgliXjQYQSXNs36X1ewl6/XMhwaGpY3LRmD0g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1942.namprd11.prod.outlook.com (2603:10b6:903:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 30 Apr
 2021 01:47:00 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 01:47:00 +0000
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: request_irq after initializing
 dma channels
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210429065821.3495234-1-quanyang.wang@windriver.com>
 <YItRB7SBhiilzDLk@pendragon.ideasonboard.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <1d88d67b-aaf5-823d-0cf6-c9422c01918c@windriver.com>
Date:   Fri, 30 Apr 2021 09:45:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YItRB7SBhiilzDLk@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR0401CA0023.apcprd04.prod.outlook.com (2603:1096:202:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Fri, 30 Apr 2021 01:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 630a5988-ef23-472a-ddbc-08d90b79d875
X-MS-TrafficTypeDiagnostic: CY4PR11MB1942:
X-Microsoft-Antispam-PRVS: <CY4PR11MB19428E56690A2791B1127878F05E9@CY4PR11MB1942.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhrjT1DOAMMbdvVox/2tdT8fEKRujxyg3EYzvHxmqvNdESwVH12PWVKMeZwH43mqIE7j1fOw/k9jHlXcpq4Ortd7k2EdpgEeiUOPfd+xmDxAKAeydolWpf+915Emi1SZahjvOgz1K77kQdQ9RxWyHSanMW9kunuoyl/KV/2XuKndc1L0rPHN0a/3FdwuSEeaiBqXcDPh1fM+5AyX5Bko9kV61h+RUMDTXn41Vm12pJV8/LIUctlE0NmMvXRNelxYyWTTX2h8g+MyPQzlgcjjWBdTRIxzyGoNuzC74hPuyVeX1w0ecCrcW5tLSnuNpEAs9SneLiv7DKJv9BDY1i85K3pfnekQiKgTCJR2FdwZH6jLk1btNcNayxRksJPl32JmZKDMW4AWTul0O2XHsbGxUVD0BGXiuBSsiSJW0f45dz9QU7NffcFMowEWoBn0LK092S6RBbq5Zg20UPxVzGd4BmeXyEtjbfh18ESu41IM1pyxi86lQVEfyNT5sN1ZA2N+FBJeLUESPEtpwm/uRMJQT1cyvres0EhBzojIyephoNNFm2dnv42a7lPUXyuoEgoJjn25rOzm/nDYWnL3DBiWQImL8xfXk9O8LR1CbTYiQlE5rB4vxxfkgdhFlONhWSf9IXk9ycnKY35o/jFaRrhsk1Nfox5HElYkRJNMU6b58FEV6JWi3IVpThHvfDWBcSIYLDnwXdpH0oiQyQjUqSjcIiKakFjvj/uErjqPxgJrkBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39840400004)(31696002)(52116002)(26005)(36756003)(16576012)(6706004)(6916009)(66556008)(54906003)(6666004)(316002)(66946007)(86362001)(4326008)(186003)(16526019)(8936002)(66476007)(956004)(2616005)(53546011)(45080400002)(38350700002)(83380400001)(8676002)(2906002)(5660300002)(478600001)(38100700002)(31686004)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckZnM0J1c3NjSXAwM2NneUxaMU1HWFp3MGswS3Rsc3U4MjZEL01HejZNMFNq?=
 =?utf-8?B?OGtYa3VnOW5hYzNYRWdzbmtJMUVCSWdDWmxmSHRHb0VVR0V1ZEtTaEgvdWU1?=
 =?utf-8?B?aitBeVJZMFRZK1h3WEpmdDJ1YXpIQU41WWNYUTVjUVZmNWptV2w4bDBRZVB6?=
 =?utf-8?B?VzBJSjNYdVNHNkg0NTJJZ0U1MWhBZng0L08xKzJncHZUcDhKQ1c3MDVYM0ZW?=
 =?utf-8?B?OC9vUGdhRGNRM2dJd0RnczBUMjRnamtMVTFLTm5VTEQ4b2hGenNxT0g4cktX?=
 =?utf-8?B?TTZ6U2VONDVHSkErTC9vcDZhNFdVNzY0d2xydXJjVGFXUUFmZzExdHVNSm8r?=
 =?utf-8?B?RHBuZVF3eUdsTWh5Z2lSUHJxd1B5bGlKS3kwZllPQTd3R2hNOVpmSU82Rmlu?=
 =?utf-8?B?ZVJDdGZrV3U0a3YvRkNYSkxTcU5IVVQxVFU3SERVKzJkYSs5SXhBd1ZqMmNJ?=
 =?utf-8?B?UGsvQjY0Wmo0LzZuRjZodHMzT05YUUg0NHRuc3FqZkNMQ21VdXFuKzVMWFlY?=
 =?utf-8?B?bDRRQzRrTTZkVkovbm5BcjBqNzBMRG9pRDYva1lMQWVHZEZvR2hKN1MzbG1x?=
 =?utf-8?B?cnN2UmVPTCs2R3g1ZjRWZGxnNWVTUk1kK3pWajlzVnZyM0JZQ0o3UnBVU1kw?=
 =?utf-8?B?d1FPSEY5ZTdPd01GenNFSDhtU3NzcEJ3dStENi9LaUdYYWV6WUJRdHZmck9r?=
 =?utf-8?B?WmdvNW55K05UNHorTzF1SFRHbmRQNm4xbkZDK0FQR3FJc3l1Mm4wRjhCK24x?=
 =?utf-8?B?MzhHejVMcHZSdG5FaEZwOWdQZWZWTjhNbXlocFRucis0SXpnaThzd0plYzI0?=
 =?utf-8?B?K2NzcVNXTFhqUFFoODVjT1VTVUZsU2dCUGN2SE14eUxURHVDVVdnb2JSeWtm?=
 =?utf-8?B?akVGU1cyT3F1cmI4VEdYSlAxOVQwQmNDRUEyV1VFOElGSElLMGoyV0d4OWFS?=
 =?utf-8?B?K3hibGp5Um85NkI1bEdzM0pJd2ViRGVFcEk4OHRpV3owR3hvNlhoQWxwZVFl?=
 =?utf-8?B?aFhKYnhaWTQxd3BXS09RLzdMelJPNENVVzhXU3ZGZnFYalRabDA1NDNsMFEr?=
 =?utf-8?B?MmVHRjZrTmd3elJrWEJBZHNYcmZwK0ZQVmFzVG5IejlIUHdWUjdXRkFVeVIz?=
 =?utf-8?B?Mld4MFlrMVVPQ2NXcU5BdWJTejdoQVFadktvT3FTcWJvMVMrMVp2dWdXQTd2?=
 =?utf-8?B?QXFxWEpGNFc1S2MyRnc1MXBkMk9sc08vcUxTVlV4LzZybUVVTXAwdml0OW1M?=
 =?utf-8?B?aFA2blZGMEY5Q0dnVEFlaGhFNVA0Y0dlOXY2SHVoN3NHZGdzdjRWR3VZcEIr?=
 =?utf-8?B?ODZCWGV3VjFHQkQ5Z1UrOWxYaVp5NXZjcTlaejA2UmVtV2FiT1BlTlo0cHdL?=
 =?utf-8?B?aUF0ckNGa0h5c3NTMDJ4M3hoTXNvQXFPZWQ1QnlobkMrTXZKUjBMRHFlbnlH?=
 =?utf-8?B?NmxRSmtOeC9RVGhHN3ZTTC9QZjB2eTBJT1NWcmFyb0NEdWEvTVVFNlZxZmJ0?=
 =?utf-8?B?N2p4cVRxcytPeVBYNkVFZ2o3R1JZaGhDcjhTWVI5RWlSbXBxNEdpcjNQMXZY?=
 =?utf-8?B?YWRrS3RTSFJRcUNKYmFPUlFYNGtXUGx6Si9RL0llUjk2Nlg5Szg0RFozZ2RZ?=
 =?utf-8?B?QVBrT0pKSndQMFhEWHFKYXpCaVkrcEVoT3lscFpOcmdTV1Vvc0RLOXBrbjZL?=
 =?utf-8?B?QTZSWUFlcE5VMTkzKzltN3lxM2tsRjhSc0hNUDgrdTJ1WHQ3VHU1S2hRcTFH?=
 =?utf-8?Q?yxqIXs2pcNaahByEqrjnY/X5sM93XRiWOQgc6Ad?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a5988-ef23-472a-ddbc-08d90b79d875
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 01:47:00.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfLM4LF8w8Q07U2TB8hFYi/osn5iiHe9gqSrzZKve+aPKDi+2RdLkmGOfF8VJi0F5q5/+FJsq+tR3Dl2G9Tmf5tFg7u2nf+1v8btHumJhZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1942
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 4/30/21 8:36 AM, Laurent Pinchart wrote:
> Hi Quanyang,
>
> Thank you for the patch.
>
> On Thu, Apr 29, 2021 at 02:58:21PM +0800, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> In some scenarios (kdump), dpdma hardware irqs has been enabled when
>> calling request_irq in probe function, and then the dpdma irq handler
>> xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
>> this moment xdev->chan[i] hasn't been initialized. So let's call the
>> request_irq after initializing dma channels to avoid kdump kernel
>> crash as below:
>>
>> [    3.696128] Unable to handle kernel NULL pointer dereference at virtual address 000000000000012c
>> [    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
>> [    3.704900] Mem abort info:
>> [    3.704902]   ESR = 0x96000005
>> [    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    3.704907]   SET = 0, FnV = 0
>> [    3.704912]   EA = 0, S1PTW = 0
>> [    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using dummy regulator
>> [    3.715585] Data abort info:
>> [    3.715587]   ISV = 0, ISS = 0x00000005
>> [    3.715589]   CM = 0, WnR = 0
>> [    3.715592] [000000000000012c] user address but active_mm is swapper
>> [    3.715596] Internal error: Oops: 96000005 [#1] SMP
>> [    3.715599] Modules linked in:
>> [    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-12170-g60894882155f-dirty #77
>> [    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
>> [    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
>> [    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
>> [    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
>> [    3.798089] sp : ffffffc01186bdf0
>> [    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
>> [    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
>> [    3.811996] x25: 0000000008000408 x24: 0000000000000003
>> [    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
>> [    3.822604] x21: 0000000000000000 x20: 0000000008000408
>> [    3.827908] x19: 0000000000000000 x18: 0000000000000010
>> [    3.833212] x17: 0000000000000000 x16: 0000000000000000
>> [    3.838516] x15: 0000000000000000 x14: ffffffc011291740
>> [    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
>> [    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
>> [    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
>> [    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
>> [    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
>> [    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
>> [    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
>> [    3.880948] Call trace:
>> [    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
>> [    3.888079]  __handle_irq_event_percpu+0x5c/0x178
>> [    3.892774]  handle_irq_event_percpu+0x34/0x98
>> [    3.897210]  handle_irq_event+0x44/0xb8
>> [    3.901030]  handle_fasteoi_irq+0xd0/0x190
>> [    3.905117]  generic_handle_irq+0x30/0x48
>> [    3.909111]  __handle_domain_irq+0x64/0xc0
>> [    3.913192]  gic_handle_irq+0x78/0xa0
>> [    3.916846]  el1_irq+0xc4/0x180
>> [    3.919982]  cpuidle_enter_state+0x134/0x2f8
>> [    3.924243]  cpuidle_enter+0x38/0x50
>> [    3.927810]  call_cpuidle+0x1c/0x40
>> [    3.931290]  do_idle+0x20c/0x270
>> [    3.934502]  cpu_startup_entry+0x28/0x58
>> [    3.938410]  rest_init+0xbc/0xcc
>> [    3.941631]  arch_call_rest_init+0x10/0x1c
>> [    3.945718]  start_kernel+0x51c/0x558
>>
>> Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   drivers/dma/xilinx/xilinx_dpdma.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
>> index 70b29bd079c9..0b599402c53f 100644
>> --- a/drivers/dma/xilinx/xilinx_dpdma.c
>> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
>> @@ -1622,19 +1622,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>>   	if (IS_ERR(xdev->reg))
>>   		return PTR_ERR(xdev->reg);
>>   
>> -	xdev->irq = platform_get_irq(pdev, 0);
>> -	if (xdev->irq < 0) {
>> -		dev_err(xdev->dev, "failed to get platform irq\n");
>> -		return xdev->irq;
>> -	}
>> -
>> -	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
>> -			  dev_name(xdev->dev), xdev);
>> -	if (ret) {
>> -		dev_err(xdev->dev, "failed to request IRQ\n");
>> -		return ret;
>> -	}
>> -
>>   	ddev = &xdev->common;
>>   	ddev->dev = &pdev->dev;
>>   
>> @@ -1688,6 +1675,19 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>>   		goto error_of_dma;
>>   	}
>>   
>> +	xdev->irq = platform_get_irq(pdev, 0);
>> +	if (xdev->irq < 0) {
>> +		dev_err(xdev->dev, "failed to get platform irq\n");
> As reported by the kbuild bot, ret isn't initialized here.
I will fix this in V2.
>
>> +		goto error_irq;
>> +	}
> This part could stay where it was, just after
> devm_platform_ioremap_resource().
OK，I will move it back.
>
>> +
>> +	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
>> +			  dev_name(xdev->dev), xdev);
>> +	if (ret) {
>> +		dev_err(xdev->dev, "failed to request IRQ\n");
>> +		goto error_irq;
>> +	}
> Ideally we should reset the device before requesting the IRQ, to ensure
> we start in a consistent state. There doesn't seem to be any global
> reset unfortunately. Shouldn't we at least disable interrupts ? It may
> be a bit pointless though as we reenable them right below, so I suppose
> this would be OK.

Yes, we should start in a consistent and clean state. I will disable 
interrupts

and clean up registers state in V2.

>
>> +
>>   	xilinx_dpdma_enable_irq(xdev);
>>   
>>   	xilinx_dpdma_debugfs_init(xdev);
>> @@ -1696,6 +1696,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>>   
>>   	return 0;
>>   
>> +error_irq:
>> +	of_dma_controller_free(pdev->dev.of_node);
> Why not free_irq() ? This change isn't described in the commit message.

I will add it in V2.

Thanks,

Quanyang

>
>>   error_of_dma:
>>   	dma_async_device_unregister(ddev);
>>   error_dma_async:
>> @@ -1704,8 +1706,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>>   	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
>>   		xilinx_dpdma_chan_remove(xdev->chan[i]);
>>   
>> -	free_irq(xdev->irq, xdev);
>> -
>>   	return ret;
>>   }
>>   

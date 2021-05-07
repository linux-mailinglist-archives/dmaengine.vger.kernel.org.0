Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E338375FBA
	for <lists+dmaengine@lfdr.de>; Fri,  7 May 2021 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhEGFg1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 May 2021 01:36:27 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:45569
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232987AbhEGFg0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 7 May 2021 01:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVFxnrQiuUlhrEu1+AXrX/bf+x5nogLgI9mIm2k/z6Hh91870EgE9vZl9phvsj6Qz93b5JWiH0IE6tlSBus5TAgpYKssUhEU+DxzkpKA6QalQ5JBJ2APWYIZ3dKu1KTn0M7ATIzl8jDtnkcHsMXrmGuydok8wwas9GwDecdVGiI0lkYO9trzClA+2sXo1Pa6/IdTHGtBkTWs4y5HczxBvkU9hpkpbpgsdPF4KOJAVWgzlyNw3XU1xVcB6kZzdCOm0Zg9gaioMgy8PookcIWbhfSMFrkwcHW0/Y53b4H+MrMjBiIbLHtxHoUZy7fBxanEXQl37T3aqSKnXPRgQw1l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pcp5TPee0X8op+2vHHs+L0R3kIXrcsxl4nschIFsTE=;
 b=GQrm7OydAPLYoHbBoFOYg7njcTlsU3yryL2liqJDl5CQt0HFHv9iW9XHy5CL5lFggVguHe+Va2ayJsUWww9g2bPCrkfyW1pGbS9bSzvyuQrlnMjZx44nbC5ROCGWMsoRsMJyyXTkEgtVEuW3zhgzYR95pzFFyeEWyvOihyG4H2sIDHFTm6Wfrp455l5LcafKUq28F0Z+eOak/Oa0zfdCc5WlAa+0wRRN8QN6NeE3VvdHyzsRO0Za+rh4b8Q1rxCVILkl9yS7qsTlrQgFDeMOTWo2pbaMEr49RH8dnrI5I3mWVf2260RDOq7W7NXj0sXw5Xj4Gw1B+PDfdD0d1p3ZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pcp5TPee0X8op+2vHHs+L0R3kIXrcsxl4nschIFsTE=;
 b=AZeaknNLN2IKXk3u1Sqj8JxSzAbBOTVwjqhKLrkADMek+soMbj/G9oMfwWjW4ZKtRzk0yLB8H4FPJgvddYExU5R9gH7n2L7JC0QrINr6SogJxJT67Krwys2D8LdvC8RO3YMmZ7brFmjZqXbrhF7CDRSqjT9hL0KSE+teH37fM/I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0070.namprd11.prod.outlook.com (2603:10b6:910:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 05:35:25 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 05:35:25 +0000
Date:   Fri, 7 May 2021 13:34:12 +0800
From:   Quanyang Wang <quanyang.wang@windriver.com>
To:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] dmaengine: xilinx: dpdma: initialize registers
 before request_irq
Message-ID: <20210507053412.GA8813@pek-qwang2-d1>
References: <20210430064041.4058180-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430064041.4058180-1-quanyang.wang@windriver.com>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::24) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1 (60.247.85.82) by SJ0PR03CA0319.namprd03.prod.outlook.com (2603:10b6:a03:39d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 05:35:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a54fe0e-6379-45df-eb7d-08d91119ea08
X-MS-TrafficTypeDiagnostic: CY4PR11MB0070:
X-Microsoft-Antispam-PRVS: <CY4PR11MB0070C4385EA1C0375FEF0739F0579@CY4PR11MB0070.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I86Wp+EIRgnOGgn9AgTU0FPqfbzhc8UYcEfpq0LLqhUz+MAMykecO1UZhRcHT+LlioTMNdc62CXk7eANPVIK3ifGvbKaICULYirOPcuC3u33xfo9w5G790xRj/sPg3ATCNAqdCOYT4j4eaxMBrCVSw1wtYSNvsoOKqatw3AskORCW0cBLgEMt4Lr0704SaaQrl0EysjQfOxq+lq61/zVzBQlH1WV/OyDmLNK967UaFxTLUbLsKrdkf9sEobCPj09lDERo4FAq8FVNG/JVUGGTnEkX5MMxE7C6mmna7PGcbG+Iv9PLmnX/+uOuZDyepQLnA7sQntWn4sDZUmOXz13C1+Q3putrFhkS2P046h0+137D6bHilznCVJcCzUPa8SjzVqITiLiqsc6YbHOvx6pXx7Q8I4Z6Yxc/rPYP0QxGB+4ls651oFbeszWKGhm85BZmByzEZdCa6NSiTZVMsEwxBrabSinAaRqivB/9ND7wcV6qEiRakC0SuXh1SAZA/3SgnBnziXD4tOQB0MFYnBsKN1hiI1AUSvAC19gSwjpPeD8FCPptJ+PpS1ov0wRgYVFJkyveFSdnCNtqLOP6AmPE1qb8WUmSLH/MFubZepap7uaWKp8LNMCXrWOpPUvi1RtbIJ+JvY6n3ieXbDissQ6wUxUuXL6kVqBcRlgbTHNJIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(110136005)(316002)(8936002)(66476007)(956004)(52116002)(478600001)(38100700002)(38350700002)(9686003)(83380400001)(33656002)(26005)(1076003)(66556008)(55016002)(6666004)(4326008)(5660300002)(2906002)(6496006)(16526019)(44832011)(86362001)(33716001)(66946007)(186003)(45080400002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YTZUQVBVb3QxaHdQQXR2Zm5OQ01kL2xKV3IxcFd0QlpvNHFSODR5SW9GeWs0?=
 =?utf-8?B?MEN6S2NINytrM1BNaEtBL1FPWHMyWnIrdXlVS2U5K2swRVg1TXJsY3hnL0ha?=
 =?utf-8?B?YUxaWHFCOHdqU25ncUNHQ1hmd3AzUFFwMndMQnZVU0tmSlZmQWJRRUU4R3Ny?=
 =?utf-8?B?aWYwUUd2dzNYV0JZdW1Tbmh2RlhWR3QyZWJTbU40Y3NseFk2QmhTZ3hRZ3dk?=
 =?utf-8?B?NFpCV1hCTnh3UWdkcVVQMlNUeUpVL0JnQU5tWlJzYXJjT3I0cDdURGY4N1Rl?=
 =?utf-8?B?L0d4VXY1NVl3bHFxcXRiSjNXV0NrdVN2OEtnN3RBNldrZUdtYldHUXdFd2Qv?=
 =?utf-8?B?QnNLeU5NSU8vMkZta0NMcjlXZ2l2UGc1MGNhbkRSOTFzeVBPaDl3N2wzNSs3?=
 =?utf-8?B?RHcwSHN0c3dJby9CaWFWTktJVC9EWXFLT0lzVkVuTlV3WVBEU3RlTUlidFh4?=
 =?utf-8?B?bjIrSTN1UklOYm5VcjBtYmFBZ1JoMTVJQ2E2ajFTaDM2Zkt2dmFRZ0Nabm5l?=
 =?utf-8?B?OHQ2LzNRUUppamVaa1pvZHJROC9JWkpoTVNZdjFpS3NtaXFZVWRYZW9qY2Y2?=
 =?utf-8?B?U2hObDRNdG55ZHYzenVHNG1aMm12TjJScHBsZ0pjTytCcUw2STdGckJFdWZJ?=
 =?utf-8?B?VWdseFhaZzl6RnBydFJUMjdhSFVRRXBBaVpScXhnTFRCQnA3TklDMU0vZWhn?=
 =?utf-8?B?S0loQ1NmdXFRbENhTjdTNGVUUXJlRFBUa2hLV2lRN2l6d0dWbExZYkxGSm9K?=
 =?utf-8?B?c1JvMnhiUVVvMW16Um9uaFJEY0U4YVdNR2poNHNDck45Y0V4ZWFrb09hQ244?=
 =?utf-8?B?UkMzWXhsWG0zRnpHVElGMURBWnZFc3Mrb2o3ZGgwTVBhaVNTZXlqRndERUxF?=
 =?utf-8?B?TmEvU00wZVBOUlJDTGJiSUdkUXFVK0IzNS9aaW9EeGtPWnM5bHdMVlRxT1R1?=
 =?utf-8?B?V3RpQUZMa3BidlczWlBuT1NiU2VQVEQzSXYrQ2NsU0Y1bUllUi9xYTdSdDNt?=
 =?utf-8?B?Mk5YTHBZUnVoaitmSTliVjVEb2dPSCs1ZmV6Ny9yVVMxcE45ZUNKZ0I3QUsv?=
 =?utf-8?B?b3E1Nk1aNmVKUzQ2YmZQUzkrQ3huVUZyVDVNU3QvRHZSK0tMd0VGZHFoUklM?=
 =?utf-8?B?RlBHbUJiQ1B4dUdZbFpPQ1pCbFNNbUZkTEZNZUVlQWxVVEh1eHJpenUxUHlK?=
 =?utf-8?B?cUNqMEQ2cFNNSmUrbXd2YXNjdkdqcHk0cXNDc01ZbFB4QXo2VEkwcVdmVjBH?=
 =?utf-8?B?YVJXQ3NnR0hEeTlwZ0dwMmNVRXJ0bWJBaklETnZ4U2RuNDRvZzFwdTIvUXpV?=
 =?utf-8?B?NnZJVXMvQ2dKUlg5ZjY1MHR4cFp6UGk0cExqTXU1U0w2TDFiajRJVzhVaHgx?=
 =?utf-8?B?UkR5cFRBVDhlK0JWbEhwN3hRU2F1a2JZeU9Vb2ZrV2d4djZwOHM3RmVjalIy?=
 =?utf-8?B?Y3UreU1rK1JRTHM1REEyenVDZDRpVWp4eUxBWWpPdU5XUm5BVjBPUzdOalJX?=
 =?utf-8?B?a0dwUWhlSGpLRHJiWFlvTHJMZlVvRzFxdVkyMWQ4NjNmamhGUEhCM0kyQ1V0?=
 =?utf-8?B?NCtVczVINkNUcGR2WVVFUDJ6Y0NnS3Zya3VzczJRbDd6MWZsWXpvcVdHcVlB?=
 =?utf-8?B?WHVpMjA3MFBlekNqajVNaThkTFpwSzdQYUkvSUpOc0hWNEoxMWRRM1U2T1R4?=
 =?utf-8?B?K3RHVkhIaXQ5TWlmVW1aNy8xVEU2NHpwWnJJWjJEKzNObjJHY2EyUHVUU25F?=
 =?utf-8?Q?bBJHULv8vibGF2mt8qKlPg7qi8tOszIWszBWT56?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a54fe0e-6379-45df-eb7d-08d91119ea08
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 05:35:25.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQM8tXtOuZkSLqQyLQQg9Ylzv87Cy3O1ADcc9bIcdJJrniPGaXrbpxxbYG4Z6s2vCMB6MNN2WSPsur8qOGnm7xOdEgf5R8TACNciTiebAzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0070
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ping.
On Fri, Apr 30, 2021 at 02:40:41PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> In some scenarios (kdump), dpdma hardware irqs has been enabled when
> calling request_irq in probe function, and then the dpdma irq handler
> xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
> this moment xdev->chan[i] hasn't been initialized.
> 
> We should ensure the dpdma controller to be in a consistent and
> clean state before further initialization. So add dpdma_hw_init()
> to do this.
> 
> Furthermore, in xilinx_dpdma_disable_irq, disable all interrupts
> instead of error interrupts.
> 
> This patch is to fix the kdump kernel crash as below:
> 
> [    3.696128] Unable to handle kernel NULL pointer dereference at virtual address 000000000000012c
> [    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
> [    3.704900] Mem abort info:
> [    3.704902]   ESR = 0x96000005
> [    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    3.704907]   SET = 0, FnV = 0
> [    3.704912]   EA = 0, S1PTW = 0
> [    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using dummy regulator
> [    3.715585] Data abort info:
> [    3.715587]   ISV = 0, ISS = 0x00000005
> [    3.715589]   CM = 0, WnR = 0
> [    3.715592] [000000000000012c] user address but active_mm is swapper
> [    3.715596] Internal error: Oops: 96000005 [#1] SMP
> [    3.715599] Modules linked in:
> [    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-12170-g60894882155f-dirty #77
> [    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
> [    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
> [    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
> [    3.798089] sp : ffffffc01186bdf0
> [    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
> [    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
> [    3.811996] x25: 0000000008000408 x24: 0000000000000003
> [    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
> [    3.822604] x21: 0000000000000000 x20: 0000000008000408
> [    3.827908] x19: 0000000000000000 x18: 0000000000000010
> [    3.833212] x17: 0000000000000000 x16: 0000000000000000
> [    3.838516] x15: 0000000000000000 x14: ffffffc011291740
> [    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
> [    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
> [    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
> [    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
> [    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
> [    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
> [    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
> [    3.880948] Call trace:
> [    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
> [    3.888079]  __handle_irq_event_percpu+0x5c/0x178
> [    3.892774]  handle_irq_event_percpu+0x34/0x98
> [    3.897210]  handle_irq_event+0x44/0xb8
> [    3.901030]  handle_fasteoi_irq+0xd0/0x190
> [    3.905117]  generic_handle_irq+0x30/0x48
> [    3.909111]  __handle_domain_irq+0x64/0xc0
> [    3.913192]  gic_handle_irq+0x78/0xa0
> [    3.916846]  el1_irq+0xc4/0x180
> [    3.919982]  cpuidle_enter_state+0x134/0x2f8
> [    3.924243]  cpuidle_enter+0x38/0x50
> [    3.927810]  call_cpuidle+0x1c/0x40
> [    3.931290]  do_idle+0x20c/0x270
> [    3.934502]  cpu_startup_entry+0x28/0x58
> [    3.938410]  rest_init+0xbc/0xcc
> [    3.941631]  arch_call_rest_init+0x10/0x1c
> [    3.945718]  start_kernel+0x51c/0x558
> 
> Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
> V2:
>  - As per Laurent's comments, add a new hw_init function to disable interrupts
>    and clear register states.
>  - Abandon all modifications in V1 since the new hw_init function can
>    fix this issue
> 
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index d8426f915c3e..60dee30a4930 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1554,7 +1554,7 @@ static void xilinx_dpdma_enable_irq(struct xilinx_dpdma_device *xdev)
>   */
>  static void xilinx_dpdma_disable_irq(struct xilinx_dpdma_device *xdev)
>  {
> -	dpdma_write(xdev->reg, XILINX_DPDMA_IDS, XILINX_DPDMA_INTR_ERR_ALL);
> +	dpdma_write(xdev->reg, XILINX_DPDMA_IDS, XILINX_DPDMA_INTR_ALL);
>  	dpdma_write(xdev->reg, XILINX_DPDMA_EIDS, XILINX_DPDMA_EINTR_ALL);
>  }
>  
> @@ -1691,6 +1691,26 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
>  	return dma_get_slave_channel(&xdev->chan[chan_id]->vchan.chan);
>  }
>  
> +static void dpdma_hw_init(struct xilinx_dpdma_device *xdev)
> +{
> +	unsigned int i;
> +	void __iomem *reg;
> +
> +	/* Disable all interrupts */
> +	xilinx_dpdma_disable_irq(xdev);
> +
> +	/* Stop all channels */
> +	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++) {
> +		reg = xdev->reg + XILINX_DPDMA_CH_BASE
> +				+ XILINX_DPDMA_CH_OFFSET * i;
> +		dpdma_clr(reg, XILINX_DPDMA_CH_CNTL, XILINX_DPDMA_CH_CNTL_ENABLE);
> +	}
> +
> +	/* Clear the interrupt status registers */
> +	dpdma_write(xdev->reg, XILINX_DPDMA_ISR, XILINX_DPDMA_INTR_ALL);
> +	dpdma_write(xdev->reg, XILINX_DPDMA_EISR, XILINX_DPDMA_EINTR_ALL);
> +}
> +
>  static int xilinx_dpdma_probe(struct platform_device *pdev)
>  {
>  	struct xilinx_dpdma_device *xdev;
> @@ -1717,6 +1737,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(xdev->reg))
>  		return PTR_ERR(xdev->reg);
>  
> +	dpdma_hw_init(xdev);
> +
>  	xdev->irq = platform_get_irq(pdev, 0);
>  	if (xdev->irq < 0) {
>  		dev_err(xdev->dev, "failed to get platform irq\n");
> -- 
> 2.25.1
> 

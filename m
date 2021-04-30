Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CE36F5CE
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhD3GnC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Apr 2021 02:43:02 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:27232
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229482AbhD3GnC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 30 Apr 2021 02:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3tzSYt3qT0VggdzjZU4982/xFf7vaFSwerLLiUAvcClBnAXY49e2PKbjTwlCPl+YFjPzSRF38lC0ysW0hprutpXTXA8VxuHedJd1+xTQG8sWBUSJ/9mql/GcOi+7Y+cdEVJw3+lds5BVZVAFEh2cWFouIMX4VdYfC5OhoHQ+5LZJgBkLgBnhVXJCkkOJvkOBVFnnZkapo5WrDszaQp8SknYn2zSZri5duu53bxr5KVeImlhioZ07bH9sHGObwTBkqbCMgo/UMagSPxdea3q0cZyKpPyWkuSaBmwVA6d9mTKlYlTI1pV1x5TdS9FNaZKQ25AktnpJzxcVsTo7cD1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u++JutOSQOpY/+bMCpDEDKt6uBSr0IGQrHP+fOBjXSs=;
 b=MOZRKt6rgX8BlzTw5Kqnf79L1EXdzLFiDMXOjCy+dMxOxIAD1wey+sOYivQxJXJ2jAqdeRiPpfv/LyqLgGZ6fl3Yesb/KDA65E0xlE4FmZVw6MbKd0hPYJuWNDgKVgPJlteu30fVeYjbRTHyItgDT9uHXtaO1Me7ISA7hTc2Lx0WbUzqu5cXJr5PQnjDTi/6qFFKExTFCWLvu8nFicnUHYe0NGAOcJTP6Q7GvRIpJoIFtnUa7wqNIByq9zeib40tHBeoEBtCm78fAnJAIV3fheIq96BjWFoyTCX+6lt26VImSio4Ov8KDpqwzUrEGGLg35x2RzwrRcbTcn13lqKdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u++JutOSQOpY/+bMCpDEDKt6uBSr0IGQrHP+fOBjXSs=;
 b=AsTBY8Aj3yCaJbW0p0BO/jgfiFgb910hRpWork1hizSWfryqnyHo+TKldkkMIa38UPsOxnAVLS8hTvrBG4bl1NkGttTsbvlmTN2Jq+6ea6yYZR3025Dq27bzUZKfEM2zUXrkg2Vrzj5+owXBAKJQIQ56Yw0s5Y6ZGSl2JCtvDDM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2342.namprd11.prod.outlook.com (2603:10b6:903:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 06:42:12 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 06:42:11 +0000
From:   quanyang.wang@windriver.com
To:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH] dmaengine: xilinx: dpdma: initialize registers before request_irq
Date:   Fri, 30 Apr 2021 14:40:41 +0800
Message-Id: <20210430064041.4058180-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 06:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11dae3c6-0fd0-4448-b2af-08d90ba313ef
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB23420A0D70C89E0D12A88DD8F05E9@CY4PR1101MB2342.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9wrK2gZDp3JosTEr1QlI3E0B7Wz5Gqil+dqWxCSPUo8qhl/lgTgQLziTKlLJ/MLcx9A9bh7x/okiTdls9HNDrnWjOWoaTLZBK7SBermjbWGJVNh7MQZxvzo9de3gja3y/fZLv/BFF8WXMs9NF5Z4lQca1C5hOTyHaMd7E/koahz+0VAcyFtsOgELD9/7Kc3tt1U3huU3yD/59IBVKdoqvz6pwsQIdlqx56yQ+gYDvMNpKmQRqaGLRn16ceZVwy55iigMly/pVg/Z2iseapVpJJYXkCcpBTsbhs3GrSvpALzZjR5vIEawOrtlhuUZqcy7XPMh1YYt4CAxu52DKXTe2qnybfanTZq6a2jovrxZLVb5WdpdyXm504lgclVRNelH+/Zxl+F4YQSEVBD25Vp6Dj4Hvx65EMOUBq37y5zWocm9nt9ii4q80H9BBJl3mCYRR/CFn3O5By/sk/samI1Nl+OjHZ3ZGMGBmLeHj5AMIx3a/Sdhe+zNrOc7tq0HjM1iyzua+W6vYKU39bUczbeGhlf8G6ASIgR4zxGXlQVgVYN00NsxLZVxp0n2F6SlkPGReDuGIoC2AU9cPa8EoJZOGOjIfm7hz59Y0bOmeVeen+mfZA45cCD9r2im91i039DXUlKMH75k1ACmeLUZQJC5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(8676002)(52116002)(9686003)(8936002)(110136005)(316002)(38350700002)(4326008)(2616005)(83380400001)(66476007)(86362001)(956004)(66556008)(2906002)(38100700002)(66946007)(26005)(186003)(1076003)(478600001)(16526019)(6666004)(6506007)(36756003)(5660300002)(107886003)(6486002)(6512007)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uXyH6a6iR+sxMWP6YlCdpjfZtSa5k1bXmhb4SVOuc0TqiQmdh52wmJ71tMMd?=
 =?us-ascii?Q?4FOulJAV8hqTDXTtoPfNUek6ESdVuEOKcQMGWIWZd4EDZsaBkgbAVa+xMsMl?=
 =?us-ascii?Q?6AnDpkEMdnePjXY5vonATG7G7Po/CoatspkMMPRIMGSImcfwUsvDrMpKsWhY?=
 =?us-ascii?Q?Wx1JwWie0BCAaqMbZmCG7aejHFd0wRr52OhOgW2vOPtcZCWm3H5YM5ruxBo5?=
 =?us-ascii?Q?tGSOyMSfAg9CcXFOSqJITGyUcyOrmoP2EEcy0P2UHoK2ZuUwIdqJ+9mhk/Hh?=
 =?us-ascii?Q?3/6Jev7q9PUIK3zy3gMmuePkiE/nAsiNS/rSao3H3ZDbYmK85GrCcx6i2uGS?=
 =?us-ascii?Q?IQRQukqFIFipD7dwYTTQkRZZDhx7yUn8zJAcx2pZt0jSeaHT4WUUePodgWpU?=
 =?us-ascii?Q?Mx8vCnhr8bwv6oSaWr9OXyxUDWExEbTOcBgTt0r2MuZM43zRbZmWeOMzd9iQ?=
 =?us-ascii?Q?fHK5SU9z9Gk39UfAADh2TprRWRyUbccF3Jmggg/300RIRve2epoYHmaOTTPS?=
 =?us-ascii?Q?QdcPQodwO/oxsQgU2NRJwYWeSdNP7WJss/0tkqJ7T6oXcs3rjuJDTcQOFmrG?=
 =?us-ascii?Q?EKNxMG/YAxj02GyhkjbckV5HqBia9dQBr4lAMDG0nsLRxyuqrp5Azn/1/hWI?=
 =?us-ascii?Q?+XA4nDsqzWb3JeCb7QSwuDdTFIvHUHOHXzRZFN6LFRaBHCZ1jjtodWRTq4sb?=
 =?us-ascii?Q?GiStEc3JmqQUDKCtPRjVvPAyt86cMFNAbuZ8fUc8mnpCReW5NfaFT5SP1aND?=
 =?us-ascii?Q?sYT5G9qryQ+lfj9fLHkK1y9AAAtmfpY1YgdDxCvKK5fy/cm1L7qSQ4crFldu?=
 =?us-ascii?Q?FSkMPf0xhkDFiTbfy5Wm6fsQ/JHFqBpoy7zaEF22VbzG/KhSoEqpr23G4DG9?=
 =?us-ascii?Q?g/yQQ5+rDRMg8QqZrfQ2wesMsykjuELWjgN4ZzEcal0WDbd4knbqBlK0E0Gn?=
 =?us-ascii?Q?8E/SELFIPmK92TWs3ZI6km0kwzoYZTp0jrgzDdLJNiFlzkrLF/Wu2IT0N+Yw?=
 =?us-ascii?Q?fo+47jbVJqP5lxaHx+0UWKPZsX2VvPXZCe3HBBCv0j+LuwM5pjPZqDE/Q5rW?=
 =?us-ascii?Q?cs5oWQh28aPs8CTTuNMhymFwsPOBiqhMddaYRYX1XMrx4m/6nA2nzDF6nu5G?=
 =?us-ascii?Q?5/t9/JuogL/trq7vtttA4MD9S2zU1zHNeylaajGouXifBjRw0VeXeg46lJN5?=
 =?us-ascii?Q?OxPkWIh2us0bYBFI1hClVY1TNtlXdusjdLdZZY5SbokAtJ2JzreDbuThC3Mj?=
 =?us-ascii?Q?MKhabq6gFzFPTcqqNfhOet2L7fl0z9UoMlDyjJAcmxXdpwWRu19XJmPnDNM+?=
 =?us-ascii?Q?kbStHYbveC74fMrGtYp0k0t5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dae3c6-0fd0-4448-b2af-08d90ba313ef
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 06:42:11.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxYR1Kt6TpTLEiqV+5fSLfNVBt/0JCZyc/sw59TYiKTmSilxSl6gbZe9KNJO7IU6EjMV9wS9MlWZmM2IL1lyi1zn+c8ngcJzzDhXkdAPIqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2342
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

In some scenarios (kdump), dpdma hardware irqs has been enabled when
calling request_irq in probe function, and then the dpdma irq handler
xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
this moment xdev->chan[i] hasn't been initialized.

We should ensure the dpdma controller to be in a consistent and
clean state before further initialization. So add dpdma_hw_init()
to do this.

Furthermore, in xilinx_dpdma_disable_irq, disable all interrupts
instead of error interrupts.

This patch is to fix the kdump kernel crash as below:

[    3.696128] Unable to handle kernel NULL pointer dereference at virtual address 000000000000012c
[    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
[    3.704900] Mem abort info:
[    3.704902]   ESR = 0x96000005
[    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.704907]   SET = 0, FnV = 0
[    3.704912]   EA = 0, S1PTW = 0
[    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using dummy regulator
[    3.715585] Data abort info:
[    3.715587]   ISV = 0, ISS = 0x00000005
[    3.715589]   CM = 0, WnR = 0
[    3.715592] [000000000000012c] user address but active_mm is swapper
[    3.715596] Internal error: Oops: 96000005 [#1] SMP
[    3.715599] Modules linked in:
[    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-12170-g60894882155f-dirty #77
[    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
[    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
[    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
[    3.798089] sp : ffffffc01186bdf0
[    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
[    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
[    3.811996] x25: 0000000008000408 x24: 0000000000000003
[    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
[    3.822604] x21: 0000000000000000 x20: 0000000008000408
[    3.827908] x19: 0000000000000000 x18: 0000000000000010
[    3.833212] x17: 0000000000000000 x16: 0000000000000000
[    3.838516] x15: 0000000000000000 x14: ffffffc011291740
[    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
[    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
[    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
[    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
[    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
[    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
[    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
[    3.880948] Call trace:
[    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
[    3.888079]  __handle_irq_event_percpu+0x5c/0x178
[    3.892774]  handle_irq_event_percpu+0x34/0x98
[    3.897210]  handle_irq_event+0x44/0xb8
[    3.901030]  handle_fasteoi_irq+0xd0/0x190
[    3.905117]  generic_handle_irq+0x30/0x48
[    3.909111]  __handle_domain_irq+0x64/0xc0
[    3.913192]  gic_handle_irq+0x78/0xa0
[    3.916846]  el1_irq+0xc4/0x180
[    3.919982]  cpuidle_enter_state+0x134/0x2f8
[    3.924243]  cpuidle_enter+0x38/0x50
[    3.927810]  call_cpuidle+0x1c/0x40
[    3.931290]  do_idle+0x20c/0x270
[    3.934502]  cpu_startup_entry+0x28/0x58
[    3.938410]  rest_init+0xbc/0xcc
[    3.941631]  arch_call_rest_init+0x10/0x1c
[    3.945718]  start_kernel+0x51c/0x558

Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
V2:
 - As per Laurent's comments, add a new hw_init function to disable interrupts
   and clear register states.
 - Abandon all modifications in V1 since the new hw_init function can
   fix this issue

---
 drivers/dma/xilinx/xilinx_dpdma.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index d8426f915c3e..60dee30a4930 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1554,7 +1554,7 @@ static void xilinx_dpdma_enable_irq(struct xilinx_dpdma_device *xdev)
  */
 static void xilinx_dpdma_disable_irq(struct xilinx_dpdma_device *xdev)
 {
-	dpdma_write(xdev->reg, XILINX_DPDMA_IDS, XILINX_DPDMA_INTR_ERR_ALL);
+	dpdma_write(xdev->reg, XILINX_DPDMA_IDS, XILINX_DPDMA_INTR_ALL);
 	dpdma_write(xdev->reg, XILINX_DPDMA_EIDS, XILINX_DPDMA_EINTR_ALL);
 }
 
@@ -1691,6 +1691,26 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 	return dma_get_slave_channel(&xdev->chan[chan_id]->vchan.chan);
 }
 
+static void dpdma_hw_init(struct xilinx_dpdma_device *xdev)
+{
+	unsigned int i;
+	void __iomem *reg;
+
+	/* Disable all interrupts */
+	xilinx_dpdma_disable_irq(xdev);
+
+	/* Stop all channels */
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++) {
+		reg = xdev->reg + XILINX_DPDMA_CH_BASE
+				+ XILINX_DPDMA_CH_OFFSET * i;
+		dpdma_clr(reg, XILINX_DPDMA_CH_CNTL, XILINX_DPDMA_CH_CNTL_ENABLE);
+	}
+
+	/* Clear the interrupt status registers */
+	dpdma_write(xdev->reg, XILINX_DPDMA_ISR, XILINX_DPDMA_INTR_ALL);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EISR, XILINX_DPDMA_EINTR_ALL);
+}
+
 static int xilinx_dpdma_probe(struct platform_device *pdev)
 {
 	struct xilinx_dpdma_device *xdev;
@@ -1717,6 +1737,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 	if (IS_ERR(xdev->reg))
 		return PTR_ERR(xdev->reg);
 
+	dpdma_hw_init(xdev);
+
 	xdev->irq = platform_get_irq(pdev, 0);
 	if (xdev->irq < 0) {
 		dev_err(xdev->dev, "failed to get platform irq\n");
-- 
2.25.1


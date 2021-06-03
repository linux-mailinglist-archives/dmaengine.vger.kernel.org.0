Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1939A18F
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFCMyu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 08:54:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51670 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFCMyt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 08:54:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153Cqs0e105157;
        Thu, 3 Jun 2021 07:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622724775;
        bh=kX3Vnpe0CNzmIKQsx1/9iW1gdYworEm0x0O1S6UEdgo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NMHfxgpV3fmYV5dV4UqR6MMC57Gtw6PXEqSOYV75BsBUKfE3aH+Y1WGETHQR0IfrS
         jV3SLan5dl+rNqbxKZwsBcZ/tLb8k5s2jVzxfCQdkZjHIPYaw6aXAgK5j5RVHXFzPS
         9hpHegxR1jk2RqmmzKK9ABXKFP58D9xd9Yp21Fq0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153CqsNq078084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 07:52:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 07:52:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 07:52:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153CqrvG081814;
        Thu, 3 Jun 2021 07:52:54 -0500
Date:   Thu, 3 Jun 2021 18:22:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 00/18] CSI2RX support on J721E
Message-ID: <20210603125251.nmzibyvfzkkxfbtj@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <83bcd60a-2a45-59b2-8ebe-26ad5d828965@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83bcd60a-2a45-59b2-8ebe-26ad5d828965@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/05/21 04:23PM, Tomi Valkeinen wrote:
> Hi Pratyush,
> 
> On 26/05/2021 18:22, Pratyush Yadav wrote:
> > Hi,
> > 
> > This series adds support for CSI2 capture on J721E. It includes some
> > fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> > driver, and finally adds the TI CSI2RX wrapper driver.
> > 
> > Tested on TI's J721E with OV5640 sensor.
> 
> I also see this after a few captures:

Can you share the application/command you are using to test? I used 
yavta to test and didn't see any problems after leaving the stream on 
for around 10 minutes.

> 
> [   84.115503] ------------[ cut here ]------------
> [   84.120144] DMA-API: ti-udma 31150000.dma-controller: mapping sg segment longer than device claims to support [len=1900544] [max=65536]
> [   84.132376] WARNING: CPU: 1 PID: 594 at kernel/dma/debug.c:1172 debug_dma_map_sg+0x304/0x390
> [   84.140804] Modules linked in: ov5640 ti_cal j721e_csi2rx cdns_csi2rx cdns_dphy v4l2_fwnode tidss ti_tfp410 tc358767 display_connector cdns_mhdp8546 panel_simple drm_kms_helper d
> rm drm_panel_orientation_quirks cfbfillrect cfbimgblt cfbcopyarea phy_j721e_wiz phy_cadence_torrent
> [   84.165298] CPU: 1 PID: 594 Comm: cam-mplex.py Not tainted 5.13.0-rc1-00206-g98bb91e95a28-dirty #5
> [   84.174236] Hardware name: Texas Instruments K3 J721E SoC (DT)
> [   84.180051] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [   84.186041] pc : debug_dma_map_sg+0x304/0x390
> [   84.190383] lr : debug_dma_map_sg+0x304/0x390
> [   84.194725] sp : ffff800014d0f730
> [   84.198026] x29: ffff800014d0f730 x28: ffff000801544680 x27: ffffffffffffffff
> [   84.205148] x26: 0000000000000000 x25: 0000000000000002 x24: 0000000000000001
> [   84.212269] x23: ffff80001163abe0 x22: 0000000000000000 x21: 0000000000000001
> [   84.219390] x20: ffff000801fa3010 x19: ffff0008075c7580 x18: 0000000000000000
> [   84.226510] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
> [   84.233630] x14: 6e61687420726567 x13: 6e6f6c20746e656d x12: 7420736d69616c63
> [   84.240751] x11: 2065636976656420 x10: ffff8000116b18f8 x9 : ffff8000100eb920
> [   84.247871] x8 : ffff8000116598f8 x7 : ffff8000116b18f8 x6 : 0000000000000001
> [   84.254991] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
> [   84.262111] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008066f8000
> [   84.269230] Call trace:
> [   84.271665]  debug_dma_map_sg+0x304/0x390
> [   84.275660]  dma_map_sg_attrs+0x70/0xb0
> [   84.279486]  drm_gem_map_dma_buf+0x6c/0xf0 [drm]
> [   84.284177]  __map_dma_buf+0x28/0x80
> [   84.287742]  dma_buf_map_attachment+0xe4/0x200
> [   84.292172]  vb2_dc_map_dmabuf+0x3c/0x150
> [   84.296171]  __prepare_dmabuf+0x1dc/0x514
> [   84.300168]  __buf_prepare+0x1a0/0x25c
> [   84.303903]  vb2_core_qbuf+0x3d4/0x72c
> [   84.307638]  vb2_qbuf+0x9c/0xf4
> [   84.310767]  vb2_ioctl_qbuf+0x68/0x7c
> [   84.314416]  v4l_qbuf+0x54/0x70
> [   84.317545]  __video_do_ioctl+0x194/0x400
> [   84.321541]  video_usercopy+0x19c/0x910
> [   84.325362]  video_ioctl2+0x24/0x40
> [   84.328837]  v4l2_ioctl+0x4c/0x70
> [   84.332141]  __arm64_sys_ioctl+0xb4/0xfc
> [   84.336053]  invoke_syscall+0x50/0x120
> [   84.339791]  el0_svc_common.constprop.0+0x68/0x104
> [   84.344569]  do_el0_svc+0x30/0x9c
> [   84.347872]  el0_svc+0x2c/0x54
> [   84.350916]  el0_sync_handler+0x1a8/0x1ac
> [   84.354911]  el0_sync+0x198/0x1c0
> [   84.358215] irq event stamp: 0
> [   84.361256] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   84.367507] hardirqs last disabled at (0): [<ffff80001004fe2c>] copy_process+0x44c/0x1800
> [   84.375667] softirqs last  enabled at (0): [<ffff80001004fe2c>] copy_process+0x44c/0x1800
> [   84.383824] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   84.390073] ---[ end trace af3448c784059129 ]---

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

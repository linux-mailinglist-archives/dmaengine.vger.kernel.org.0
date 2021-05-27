Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B35392F71
	for <lists+dmaengine@lfdr.de>; Thu, 27 May 2021 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhE0NZg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 May 2021 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbhE0NZf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 May 2021 09:25:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A8C061574;
        Thu, 27 May 2021 06:24:02 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B4FC2ED;
        Thu, 27 May 2021 15:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622121837;
        bh=DV/sXGP9GWQVpqSUl3M/6iG027x7LNyVu3A0F+XjFAE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GzEgR5OZO9B2c/tDgu2McnKqP1rwzxOfwVFZRCybS7RqVgX9imDsseE95UMBgkpnY
         8lQalkoUAEshVFLY9IxI4taN+XGAuJ3KL5Tvw4lTqpkVKvbR33cqz2gjfORQ7jmECs
         A8vaySUeZxfOR+EuRiQLv7Pcp1ULRj10D1959QPA=
Subject: Re: [PATCH v2 00/18] CSI2RX support on J721E
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <83bcd60a-2a45-59b2-8ebe-26ad5d828965@ideasonboard.com>
Date:   Thu, 27 May 2021 16:23:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-1-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

On 26/05/2021 18:22, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> driver, and finally adds the TI CSI2RX wrapper driver.
> 
> Tested on TI's J721E with OV5640 sensor.

I also see this after a few captures:

[   84.115503] ------------[ cut here ]------------
[   84.120144] DMA-API: ti-udma 31150000.dma-controller: mapping sg segment longer than device claims to support [len=1900544] [max=65536]
[   84.132376] WARNING: CPU: 1 PID: 594 at kernel/dma/debug.c:1172 debug_dma_map_sg+0x304/0x390
[   84.140804] Modules linked in: ov5640 ti_cal j721e_csi2rx cdns_csi2rx cdns_dphy v4l2_fwnode tidss ti_tfp410 tc358767 display_connector cdns_mhdp8546 panel_simple drm_kms_helper d
rm drm_panel_orientation_quirks cfbfillrect cfbimgblt cfbcopyarea phy_j721e_wiz phy_cadence_torrent
[   84.165298] CPU: 1 PID: 594 Comm: cam-mplex.py Not tainted 5.13.0-rc1-00206-g98bb91e95a28-dirty #5
[   84.174236] Hardware name: Texas Instruments K3 J721E SoC (DT)
[   84.180051] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   84.186041] pc : debug_dma_map_sg+0x304/0x390
[   84.190383] lr : debug_dma_map_sg+0x304/0x390
[   84.194725] sp : ffff800014d0f730
[   84.198026] x29: ffff800014d0f730 x28: ffff000801544680 x27: ffffffffffffffff
[   84.205148] x26: 0000000000000000 x25: 0000000000000002 x24: 0000000000000001
[   84.212269] x23: ffff80001163abe0 x22: 0000000000000000 x21: 0000000000000001
[   84.219390] x20: ffff000801fa3010 x19: ffff0008075c7580 x18: 0000000000000000
[   84.226510] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
[   84.233630] x14: 6e61687420726567 x13: 6e6f6c20746e656d x12: 7420736d69616c63
[   84.240751] x11: 2065636976656420 x10: ffff8000116b18f8 x9 : ffff8000100eb920
[   84.247871] x8 : ffff8000116598f8 x7 : ffff8000116b18f8 x6 : 0000000000000001
[   84.254991] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
[   84.262111] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008066f8000
[   84.269230] Call trace:
[   84.271665]  debug_dma_map_sg+0x304/0x390
[   84.275660]  dma_map_sg_attrs+0x70/0xb0
[   84.279486]  drm_gem_map_dma_buf+0x6c/0xf0 [drm]
[   84.284177]  __map_dma_buf+0x28/0x80
[   84.287742]  dma_buf_map_attachment+0xe4/0x200
[   84.292172]  vb2_dc_map_dmabuf+0x3c/0x150
[   84.296171]  __prepare_dmabuf+0x1dc/0x514
[   84.300168]  __buf_prepare+0x1a0/0x25c
[   84.303903]  vb2_core_qbuf+0x3d4/0x72c
[   84.307638]  vb2_qbuf+0x9c/0xf4
[   84.310767]  vb2_ioctl_qbuf+0x68/0x7c
[   84.314416]  v4l_qbuf+0x54/0x70
[   84.317545]  __video_do_ioctl+0x194/0x400
[   84.321541]  video_usercopy+0x19c/0x910
[   84.325362]  video_ioctl2+0x24/0x40
[   84.328837]  v4l2_ioctl+0x4c/0x70
[   84.332141]  __arm64_sys_ioctl+0xb4/0xfc
[   84.336053]  invoke_syscall+0x50/0x120
[   84.339791]  el0_svc_common.constprop.0+0x68/0x104
[   84.344569]  do_el0_svc+0x30/0x9c
[   84.347872]  el0_svc+0x2c/0x54
[   84.350916]  el0_sync_handler+0x1a8/0x1ac
[   84.354911]  el0_sync+0x198/0x1c0
[   84.358215] irq event stamp: 0
[   84.361256] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[   84.367507] hardirqs last disabled at (0): [<ffff80001004fe2c>] copy_process+0x44c/0x1800
[   84.375667] softirqs last  enabled at (0): [<ffff80001004fe2c>] copy_process+0x44c/0x1800
[   84.383824] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   84.390073] ---[ end trace af3448c784059129 ]---

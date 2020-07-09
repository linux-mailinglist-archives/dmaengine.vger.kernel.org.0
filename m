Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3A21A0B2
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGINUk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 09:20:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37682 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgGINUk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 09:20:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 069DKaB7122231;
        Thu, 9 Jul 2020 08:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594300836;
        bh=JoZGlv3UsIhKnKWzUWths0Er0fErfodjyWI5xdkZkuc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rSFRzfuubsBBCkPy+npFmwFGd8RE803M8xvtT9clca0pkStFVVytZK72qa3lFE/MF
         1jaBVViMxIExofSUtzzzCia4M1vqEPlFQdElbWUu3E4luc0/vOMM8EBz9FkmyAFQJr
         FVyajfsdKxS5Zqy92IRRLm0HXyOL0tqF9BGHllEw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069DKaqi037003;
        Thu, 9 Jul 2020 08:20:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 9 Jul
 2020 08:20:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 9 Jul 2020 08:20:36 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069DKYDK005048;
        Thu, 9 Jul 2020 08:20:35 -0500
Subject: Re: [PATCH v6 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dmaengine@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <64817596-1ba2-97d7-1dde-600eead16b05@ti.com>
Date:   Thu, 9 Jul 2020 16:21:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 08/07/2020 23.19, Laurent Pinchart wrote:
> From: Hyun Kwon <hyun.kwon@xilinx.com>
>=20
> The ZynqMP DisplayPort subsystem includes a DMA engine called DPDMA wit=
h
> 6 DMa channels (4 for display and 2 for audio). This driver exposes the=

> DPDMA through the dmaengine API, to be used by audio (ALSA) and display=

> (DRM) drivers for the DisplayPort subsystem.
>=20
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Signed-off-by: Tejas Upadhyay <tejasu@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

=2E..

> +static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan =
*chan)
> +{
> +	struct xilinx_dpdma_device *xdev =3D chan->xdev;
> +	struct xilinx_dpdma_sw_desc *sw_desc;
> +	struct xilinx_dpdma_tx_desc *desc;
> +	struct virt_dma_desc *vdesc;
> +	u32 reg, channels;
> +
> +	lockdep_assert_held(&chan->lock);
> +
> +	if (chan->desc.pending)
> +		return;
> +
> +	if (!chan->running) {
> +		xilinx_dpdma_chan_unpause(chan);
> +		xilinx_dpdma_chan_enable(chan);
> +		chan->first_frame =3D true;
> +		chan->running =3D true;
> +	}
> +
> +	if (chan->video_group)
> +		channels =3D xilinx_dpdma_chan_video_group_ready(chan);
> +	else
> +		channels =3D BIT(chan->id);
> +
> +	if (!channels)
> +		return;
> +
> +	vdesc =3D vchan_next_desc(&chan->vchan);
> +	if (!vdesc)
> +		return;
> +
> +	if (!chan->first_frame && !(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
> +		/*
> +		 * The client forgot to set the DMA_PREP_LOAD_EOT flag. The DMA
> +		 * engine API requires the channel to silently ignore the
> +		 * descriptor, leaving the client waiting forever for the new
> +		 * descriptor to be processed.
> +		 */

This hardly going to happen. But if it does, a gentle dev_dbg() might
save some time for the user on debugging?

> +		return;
> +	}
> +
> +	desc =3D to_dpdma_tx_desc(vdesc);
> +	chan->desc.pending =3D desc;
> +	list_del(&desc->vdesc.node);
> +
> +	/*
> +	 * Assign the cookie to descriptors in this transaction. Only 16 bit
> +	 * will be used, but it should be enough.
> +	 */
> +	list_for_each_entry(sw_desc, &desc->descriptors, node)
> +		sw_desc->hw.desc_id =3D desc->vdesc.tx.cookie;
> +
> +	sw_desc =3D list_first_entry(&desc->descriptors,
> +				   struct xilinx_dpdma_sw_desc, node);
> +	dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDR,
> +		    lower_32_bits(sw_desc->dma_addr));
> +	if (xdev->ext_addr)
> +		dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDRE,
> +			    FIELD_PREP(XILINX_DPDMA_CH_DESC_START_ADDRE_MASK,
> +				       upper_32_bits(sw_desc->dma_addr)));
> +
> +	if (chan->first_frame)
> +		reg =3D XILINX_DPDMA_GBL_TRIG_MASK(channels);
> +	else
> +		reg =3D XILINX_DPDMA_GBL_RETRIG_MASK(channels);
> +
> +	chan->first_frame =3D false;
> +
> +	dpdma_write(xdev->reg, XILINX_DPDMA_GBL, reg);
> +}

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


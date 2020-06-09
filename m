Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB331F37A1
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgFIKJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 06:09:20 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:40127 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgFIKJT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 06:09:19 -0400
IronPort-SDR: jErgPSIB/WSiH+a1Hq3pftnMY6r1FcRF2ElYPKPuTxNAL4T+rIrm63FXJtd8VaWQvXYiNJOkmK
 GtMMkWEkh3lc17sCykdwIjxBqQbGwbIx57MbTntVjEvSbMK/LPIKSeqvly7GZl8wG3fXJ0rChQ
 5PTRNvTtOzNy/MY6ftbgH8H6lWPsbDsxfognad+WoWL35VvueL0kZPClQqTsT8iix0PJ5RpOtu
 yj5mbJ3qv0T296MYuMq7QDuHNSEhE8STGq+EX0WVMT4UAB7l+I2r7Aqwqkpet85ymu5yUsok7y
 E6o=
X-IronPort-AV: E=Sophos;i="5.73,491,1583190000"; 
   d="scan'208";a="12612833"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2020 12:09:12 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 09 Jun 2020 12:09:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 09 Jun 2020 12:09:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591697352; x=1623233352;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MtHoMJGjG11zHUOCfPMyUFC2SmxvJOGVvGMQIDbciW0=;
  b=HYPb0tzsXEpnqbEPGGQjjMyVPiIhr/AWFfp0EFW7jfQ1nf2BBCVrxys3
   ywHQ7VGkxVd4caxR8WVZs+Sw1vIGI8TAAcUV/VA9pKlp84HRGieyNqwad
   Fu7XdnwIimoJkDdp1Bm7Aw+1+VbZkOM8hA/dcyt14fE9NWUnj+GpIsJMn
   b5EwDAQeHXgPcu+v2AGbRxPw249Xt3oYJQtrOSFjr+mR6Qv50AL7zdl12
   E0f8CKRLlAXm+I4nwsswBy6dArjEya/L5pVY6HHrj962Ig0UnsibkMXLn
   CqVO61q6fiYBvN1V7H+7Mmq5LJpewYuaYxSF4Q9i5OrYqn/ng8+6QpKwy
   g==;
IronPort-SDR: KCraRdimNvw/UGtgYO/E9pVrjS0c7g0UfkmuCv8NnFRstj3BPvALb83QZGeoOI7RK4NJTNYfCI
 WSZvS9Rb/HjuoWsiJArNnpbQjviseAg6htmr0Forqf+UPOPXYP0a1BOqw7fSyiC4FW5yBJU2sK
 8ZrGJFge7359WBHeN3e1lj5hSa5XzIqbUDZ6pCphnpsOQxFMdLMdJjqiZECQARu1Y5YNkGVG/v
 VJaN/gOddTLvlTfLOrPnfI414HITUvJfj4waT0W0G9N2RrpXwCpAbJA2evU5FSm1jf8KOfE4G5
 JvQ=
X-IronPort-AV: E=Sophos;i="5.73,491,1583190000"; 
   d="scan'208";a="12612832"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2020 12:09:12 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id CC0B8280065;
        Tue,  9 Jun 2020 12:09:18 +0200 (CEST)
Message-ID: <4a663b38fe5c6b2ee37049fb0dcd88b70dbf232e.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH v9 RESEND 01/13] spi: imx: add
 dma_sync_sg_for_device after fallback from dma
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Mark Brown <broonie@kernel.org>
Date:   Tue, 09 Jun 2020 12:09:09 +0200
In-Reply-To: <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
         <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
         <20200608143458.GH4593@sirena.org.uk>
         <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
         <20200608153139.GI4593@sirena.org.uk>
         <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
         <VE1PR04MB6638B1EC49D295C64292B7BD89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
         <bcfc3637-65af-577a-ddbd-890b6c83a6e6@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 2020-06-09 at 11:00 +0100, Robin Murphy wrote:
> On 2020-06-09 06:21, Robin Gong wrote:
> > On 2020/06/09 0:44 Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 2020-06-08 16:31, Mark Brown wrote:
> > > > On Mon, Jun 08, 2020 at 03:08:45PM +0000, Robin Gong wrote:
> > > > 
> > > > > > > +	if (transfer->rx_sg.sgl) {
> > > > > > > +		struct device *rx_dev = spi->controller-
> > > > > > > >dma_rx->device->dev;
> > > > > > > +
> > > > > > > +		dma_sync_sg_for_device(rx_dev, transfer-
> > > > > > > >rx_sg.sgl,
> > > > > > > +				       transfer->rx_sg.nents,
> > > > > > > DMA_TO_DEVICE);
> > > > > > > +	}
> > > > > > > +
> > > > > > This is confusing - why are we DMA mapping to the device
> > > > > > after doing
> > > > > > a PIO transfer?
> > > > > 'transfer->rx_sg.sgl' condition check that's the case
> > > > > fallback PIO
> > > > > after DMA transfer failed. But the spi core still think the
> > > > > buffer
> > > > > should be in 'device' while spi driver touch it by PIO(CPU),
> > > > > so sync it back to
> > > 
> > > device to ensure all received data flush to DDR.
> > > > 
> > > > So we sync it back to the device so that we can then do another
> > > > sync
> > > > to CPU?  TBH I'm a bit surprised that there's a requirement
> > > > that we
> > > > explicitly undo a sync and that a redundant double sync in the
> > > > same
> > > > direction might be an issue but I've not had a need to care so
> > > > I'm
> > > > perfectly prepared to believe there is.
> > > > 
> > > > At the very least this needs a comment.
> > > 
> > > Yeah, something's off here - at the very least, syncing with
> > > DMA_TO_DEVICE on
> > > the Rx buffer that was mapped with DMA_FROM_DEVICE is clearly
> > > wrong.
> > > CONFIG_DMA_API_DEBUG should scream about that.
> > > 
> > > If the device has written to the buffer at all since dma_map_sg()
> > > was called
> > > then you do need a dma_sync_sg_for_cpu() call before touching it
> > > from a CPU
> > > fallback path, but if nobody's going to touch it from that point
> > > until it's
> > > unmapped then there's no point syncing it again. The
> > > my_card_interrupt_handler() example in DMA-API_HOWTO.txt
> > > demonstrates
> > > this.
> > 
> > Thanks for you post, but sorry, that's not spi-imx case now,
> > because the rx data in device memory is not truly updated from
> > 'device'/DMA, but from PIO, so that dma_sync_sg_for_cpu with
> > DMA_FROM_DEVICE can't be used, otherwise the fresh data in cache
> > will be invalidated.
> > But you're right, kernel warning comes out if CONFIG_DMA_API_DEBUG
> > enabled...
> 
> Ah, I think I understand what's going on now. That's... really ugly
> :(
> 
> Looking at the SPI core code, I think a better way to handle this
> would 
> be to have your fallback path call spi_unmap_buf() directly (or
> perform 
> the same actions, if exporting that to drivers is unacceptable),
> then 
> make sure ->can_dma() returns false after that such that
> spi_unmap_msg() 
> won't try to unmap it again. That's a lot more reasonable than trying
> to 
> fake up a DMA_TO_DEVICE transfer in the middle of a DMA_FROM_DEVICE 
> operation on the same buffer.
> 
> Alternatively, is it feasible to initiate a dummy DMA request during 
> probe, such that you can detect the failure condition and give up on
> the 
> DMA channel early, and not have to deal with it during a real SPI
> transfer?
> 
> Robin.


Would this cover the transient DMA failure that is happening between
SDMA registration and firmware load? This is exactly the case for which
the PIO fallback is triggered for us: As soon as the SDMA driver is
registered, the SPI driver can be probed as well, usually failing its
first DMA transfer, as the SDMA firmware is not loaded yet. We would
still like the SPI controller to use DMA as soon as it's actually
available.

I assume the actual issue is that the SDMA controller is considered
registered before the firmware load has finished, but I have no idea
how feasible it would be to change that (some comments in the code
explain why this currently isn't the case).

Matthias


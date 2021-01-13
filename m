Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E872F48E4
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhAMKnw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 05:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbhAMKnw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 05:43:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B126223122;
        Wed, 13 Jan 2021 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610534591;
        bh=IjaLNWMxl7BcN8GIlfrWVAomY1gS2k79ZK0wI+WSQ8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/6rT9qmqKve7EQ94uZivUXRrR+xyAoeqXc6HiwcgTuSiEjQOGt59kdawXAv9BnuO
         TbtEyrBPyVXv/qWXSaScLz/GMd/0aarOit8tayCGUf66BdG6gAJ1dgiojM3AaXFOz8
         6DYZHPbH4X8E3+RXIgVMm75DVu/cZK82hKGD4LgKdZVTkOJnNXkvQ6VEyTMNHdV9mV
         pJVEKR7gNBXebEOl54Ch5V24NJml5PzQTe76KgwX9HWJsOd9VSOSprfIL82dtg13KS
         JXn6XnkpXKqXcqLYsE6nbBRlzfSsbEkzs8Vebyucv5fJK6N0tKUX2QeTTUCziNrD8P
         okSqjaMCLSOtQ==
Date:   Wed, 13 Jan 2021 16:13:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: Re: [PATCH 2/2] dmaengine: ti: k3-udma: Add support for burst_size
 configuration for mem2mem
Message-ID: <20210113104306.GZ2771@vkoul-mobl>
References: <20201214081310.10746-1-peter.ujfalusi@ti.com>
 <20201214081310.10746-3-peter.ujfalusi@ti.com>
 <20210112101637.GJ2771@vkoul-mobl>
 <76cabf10-7747-73ee-1c42-8d5a7eb85b6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76cabf10-7747-73ee-1c42-8d5a7eb85b6c@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-01-21, 09:39, Péter Ujfalusi wrote:
> Hi Vinod,
> 
> On 1/12/21 12:16 PM, Vinod Koul wrote:
> > On 14-12-20, 10:13, Peter Ujfalusi wrote:
> >> The UDMA and BCDMA can provide higher throughput if the burst_size of the
> >> channel is changed from it's default (which is 64 bytes) for Ultra-high
> >> and high capacity channels.
> >>
> >> This performance benefit is even more visible when the buffers are aligned
> >> with the burst_size configuration.
> >>
> >> The am654 does not have a way to change the burst size, but it is using
> >> 64 bytes burst, so increasing the copy_align from 8 bytes to 64 (and
> >> clients taking that into account) can increase the throughput as well.
> >>
> >> Numbers gathered on j721e:
> >> echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
> >> echo 2000 > /sys/module/dmatest/parameters/timeout
> >> echo 50 > /sys/module/dmatest/parameters/iterations
> >> echo 1 > /sys/module/dmatest/parameters/max_channels
> >>
> >> Prior this patch:       ~1.3 GB/s
> >> After this patch:       ~1.8 GB/s
> >>  with 1 byte alignment: ~1.7 GB/s
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  drivers/dma/ti/k3-udma.c | 115 +++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 110 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> >> index 87157cbae1b8..54e4ccb1b37e 100644
> >> --- a/drivers/dma/ti/k3-udma.c
> >> +++ b/drivers/dma/ti/k3-udma.c
> >> @@ -121,6 +121,11 @@ struct udma_oes_offsets {
> >>  #define UDMA_FLAG_PDMA_ACC32		BIT(0)
> >>  #define UDMA_FLAG_PDMA_BURST		BIT(1)
> >>  #define UDMA_FLAG_TDTYPE		BIT(2)
> >> +#define UDMA_FLAG_BURST_SIZE		BIT(3)
> >> +#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
> >> +					 UDMA_FLAG_PDMA_BURST | \
> >> +					 UDMA_FLAG_TDTYPE | \
> >> +					 UDMA_FLAG_BURST_SIZE)
> >>  
> >>  struct udma_match_data {
> >>  	enum k3_dma_type type;
> >> @@ -128,6 +133,7 @@ struct udma_match_data {
> >>  	bool enable_memcpy_support;
> >>  	u32 flags;
> >>  	u32 statictr_z_mask;
> >> +	u8 burst_size[3];
> >>  };
> >>  
> >>  struct udma_soc_data {
> >> @@ -436,6 +442,18 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
> >>  	}
> >>  }
> >>  
> >> +static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < tpl_map->levels; i++) {
> >> +		if (chan_id >= tpl_map->start_idx[i])
> >> +			return i;
> >> +	}
> > 
> > Braces seem not required
> 
> True, they are not strictly needed but I prefer to have them when I have
> any condition in the loop.

ok

> >>  static void udma_reset_uchan(struct udma_chan *uc)
> >>  {
> >>  	memset(&uc->config, 0, sizeof(uc->config));
> >> @@ -1811,6 +1829,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
> >>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
> >>  	struct udma_tchan *tchan = uc->tchan;
> >>  	struct udma_rchan *rchan = uc->rchan;
> >> +	u8 burst_size = 0;
> >>  	int ret = 0;
> >>  
> >>  	/* Non synchronized - mem to mem type of transfer */
> >> @@ -1818,6 +1837,12 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
> >>  	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
> >>  	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
> >>  
> >> +	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
> >> +		u8 tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, tchan->id);
> > 
> > Can we define variable at function start please
> 
> The 'tpl' is only used within this if branch, it looks a bit cleaner
> imho, but if you insist, I can move the definition.

yeah lets be consistent and keep them at the start of the function
please

> >> +	switch (match_data->burst_size[tpl]) {
> >> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
> >> +			return DMAENGINE_ALIGN_256_BYTES;
> >> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
> >> +			return DMAENGINE_ALIGN_128_BYTES;
> >> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
> >> +		fallthrough;
> >> +		default:
> >> +			return DMAENGINE_ALIGN_64_BYTES;
> > 
> > ah, we are supposed to have case at same indent as switch, pls run
> > checkpatch to have these flagged off
> 
> Yes, they should be.
> 
> The other me did a sloppy job for sure, this should have been screaming
> even without checkpatch...
> This has been done in a rush during the last days to close on the
> backlog item which got the most votes.

no worries, that is where reviews help :)

-- 
~Vinod

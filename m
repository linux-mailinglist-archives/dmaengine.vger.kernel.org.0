Return-Path: <dmaengine+bounces-8431-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIdjOSYScWlEcgAAu9opvQ
	(envelope-from <dmaengine+bounces-8431-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:51:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C85AC3B
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5445994E2F9
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8E358D19;
	Wed, 21 Jan 2026 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenfTo0r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894993563DE;
	Wed, 21 Jan 2026 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011361; cv=none; b=f6t+rPQx2Oiltt9gLqFr/f+53CQzbdUUIK7oenv2dRjVrvLrzXI5BC1OrhW/it4uGSX4Y/C4oCIsuySSwVzyXhJDu8w8fZPo4rGHqSmpLz4OdbQObq+grLYD/cO4Yr9wvCcdqzggMawtkKI1f6Y6b2TV8V1Hw3CiL5kPEW3Fde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011361; c=relaxed/simple;
	bh=s3XpPRssPWCk4SPsWJWdTukbpa6Bkklf5AXcN7vN9zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3z+cJNADt4GXN7JFYhtwsKDK+wf0DeUaZ0FbCAylwlCVfTahnwiny3t4OwIDitdCn+hJ4CqDEOqVa8DRoicbN19HYQFPEi06qqbSpyvUH+InwNr8wu/+m4T+z8Wry0J8FfZSGWKO/BZfBdGBJOszAQirA/uHuLsmcywOZLBV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenfTo0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6D9C4CEF1;
	Wed, 21 Jan 2026 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769011361;
	bh=s3XpPRssPWCk4SPsWJWdTukbpa6Bkklf5AXcN7vN9zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WenfTo0rD++V0c/6izuN+kVheJq6ZXs1S5L/MLJ71yNEUIXYDSvC/Axs6hzL5MZEn
	 m7as4iM7XG86H+md5VlBg4rRwCUXC10xmv+VjWxrSLhhsNw6c//c7RwdjEmdlwFD6u
	 JOvFOFmQmJJa+tgTrmZAyu1DS/Eedbgdx7ScLYXcaBsvDOv9E5VRYWyotH38sIIe+u
	 hHcqEB4GCDTagXD0oc5V4x7DkEn9c5fL8CQ953HM3tlqsVLpQZT1sjBJVWJqa3wkR7
	 J+j9C5BVuPTzwHORPKaJQQgBOyGsH5lEEQqSymgZNtEdM6GRbN/QLMeNXm6NrFgqkk
	 LgWVSaPQtLxig==
Date: Wed, 21 Jan 2026 21:32:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, dave.jiang@intel.com, cassel@kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, geert+renesas@glider.be, robh@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel
 interrupt routing control
Message-ID: <aXD4ncvjZWljUyxe@vaman>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-3-den@valinux.co.jp>
 <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
 <32egn4uhx3dll5es4nzpivg5rdv3hvvrceyznsnnnbbyze7qxu@5z6w45v3jwyf>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32egn4uhx3dll5es4nzpivg5rdv3hvvrceyznsnnnbbyze7qxu@5z6w45v3jwyf>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8431-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,synopsys.com:email,valinux.co.jp:email]
X-Rspamd-Queue-Id: 684C85AC3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19-01-26, 23:26, Koichiro Den wrote:
> On Sun, Jan 18, 2026 at 12:03:19PM -0500, Frank Li wrote:
> > On Sun, Jan 18, 2026 at 10:54:04PM +0900, Koichiro Den wrote:
> > > DesignWare EP eDMA can generate interrupts both locally and remotely
> > > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > > completions should be handled locally, remotely, or both. Unless
> > > carefully configured, the endpoint and host would race to ack the
> > > interrupt.
> > >
> > > Introduce a per-channel interrupt routing mode and export small APIs to
> > > configure and query it. Update v0 programming so that RIE and local
> > > done/abort interrupt masking follow the selected mode. The default mode
> > > keeps the original behavior, so unless the new APIs are explicitly used,
> > > no functional changes.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
> > >  include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
> > >  4 files changed, 116 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index b9d59c3c0cb4..059b3996d383 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > >  		chan->configured = false;
> > >  		chan->request = EDMA_REQ_NONE;
> > >  		chan->status = EDMA_ST_IDLE;
> > > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > >
> > >  		if (chan->dir == EDMA_DIR_WRITE)
> > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > @@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > >
> > > +int dw_edma_chan_irq_config(struct dma_chan *dchan,
> > > +			    enum dw_edma_ch_irq_mode mode)
> > > +{
> > > +	struct dw_edma_chan *chan;
> > > +
> > > +	switch (mode) {
> > > +	case DW_EDMA_CH_IRQ_DEFAULT:
> > > +	case DW_EDMA_CH_IRQ_LOCAL:
> > > +	case DW_EDMA_CH_IRQ_REMOTE:
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!dchan || !dchan->device)
> > > +		return -ENODEV;
> > > +
> > > +	chan = dchan2dw_edma_chan(dchan);
> > > +	if (!chan)
> > > +		return -ENODEV;
> > > +
> > > +	chan->irq_mode = mode;
> > > +
> > > +	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
> > > +		 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > +		 chan->id, mode);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
> > > +
> > > +bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
> > > +{
> > > +	struct dw_edma_chan *chan;
> > > +	struct dw_edma *dw;
> > > +
> > > +	if (!dchan || !dchan->device)
> > > +		return false;
> > > +
> > > +	chan = dchan2dw_edma_chan(dchan);
> > > +	if (!chan)
> > > +		return false;
> > > +
> > > +	dw = chan->dw;
> > > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > > +	else
> > > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
> > > +
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 71894b9e0b15..8458d676551a 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> > >
> > >  	struct msi_msg			msi;
> > >
> > > +	enum dw_edma_ch_irq_mode	irq_mode;
> > > +
> > >  	enum dw_edma_request		request;
> > >  	enum dw_edma_status		status;
> > >  	u8				configured;
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 2850a9df80f5..80472148c335 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > >  	for_each_set_bit(pos, &val, total) {
> > >  		chan = &dw->chan[pos + off];
> > >
> > > -		dw_edma_v0_core_clear_done_int(chan);
> > > -		done(chan);
> > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > +			dw_edma_v0_core_clear_done_int(chan);
> > > +			done(chan);
> > > +		}
> > >
> > >  		ret = IRQ_HANDLED;
> > >  	}
> > > @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > >  	for_each_set_bit(pos, &val, total) {
> > >  		chan = &dw->chan[pos + off];
> > >
> > > -		dw_edma_v0_core_clear_abort_int(chan);
> > > -		abort(chan);
> > > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > > +			dw_edma_v0_core_clear_abort_int(chan);
> > > +			abort(chan);
> > > +		}
> > >
> > >  		ret = IRQ_HANDLED;
> > >  	}
> > > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >  		j--;
> > >  		if (!j) {
> > >  			control |= DW_EDMA_V0_LIE;
> > > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> > >  				control |= DW_EDMA_V0_RIE;
> > >  		}
> > >
> > > @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >  				break;
> > >  			}
> > >  		}
> > > -		/* Interrupt unmask - done, abort */
> > > +		/* Interrupt mask/unmask - done, abort */
> > >  		raw_spin_lock_irqsave(&dw->lock, flags);
> > >
> > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > +		} else {
> > > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > +		}
> > >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> > >  		/* Linked list error */
> > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index ffad10ff2cd6..6f50165ac084 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
> > >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > >  };
> > >
> > > +/*
> > > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> > > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > > + *
> > > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > > + * Write Interrupt Generation".
> > > + */
> > > +enum dw_edma_ch_irq_mode {
> > > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > > +	DW_EDMA_CH_IRQ_LOCAL,
> > > +	DW_EDMA_CH_IRQ_REMOTE,
> > > +};
> > > +
> > >  /**
> > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > >   * @dev:		 struct device of the eDMA controller
> > > @@ -105,6 +122,22 @@ struct dw_edma_chip {
> > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > +/**
> > > + * dw_edma_chan_irq_config - configure per-channel interrupt routing
> > > + * @chan: DMA channel obtained from dma_request_channel()
> > > + * @mode: interrupt routing mode
> > > + *
> > > + * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
> > > + * not belong to the DesignWare eDMA driver.
> > > + */
> > > +int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > +			    enum dw_edma_ch_irq_mode mode);
> > > +
> > > +/**
> > > + * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
> > > + * @chan: DMA channel obtained from dma_request_channel()
> > > + */
> > > +bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > >  #else
> > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > >  {
> > > @@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > >  {
> > >  	return 0;
> > >  }
> > > +
> > > +static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
> > > +					  enum dw_edma_ch_irq_mode mode)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +
> > > +static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
> > > +{
> > > +	return false;
> > > +}
> > 
> > I think it'd better go thought
> > 
> > struct dma_slave_config {
> > 	...
> >         void *peripheral_config;
> > 	size_t peripheral_size;
> > 
> > };
> > 
> > So DMA consumer can use standard DMAengine API, dmaengine_slave_config().
> 
> Using .peripheral_config wasn't something I had initially considered, but I
> agree that this is preferable in the sense that it avoids introducing the
> additional exported APIs. I'm not entirely sure whether it's clean to use
> it for non-peripheral settings in the strict sense, but there seem to be
> precedents such as stm32_mdma_dma_config, so I guess it seems acceptable.
> If I'm missing something, please correct me.

Strictly speaking slave config should be used for peripheral transfers.
For memcpy users (this seems more like that), I would argue slave config
does not make much sense.

-- 
~Vinod


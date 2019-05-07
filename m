Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AE158C6
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 07:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEGFLn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 01:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGFLn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 01:11:43 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCD620825;
        Tue,  7 May 2019 05:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557205902;
        bh=DhGcLuNPmEe+wui1gUyB30BTjYJWqF5WS3OUjoUnFNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elaAKIyLZawJXjWixh6NrJpXsyL6MHcA60hoFLKdBW5Dw+c5GPCj3vuY8oHe2II+k
         o3JCTrGvaFVhGtszsj09NpHw9+uTumMOQmOZySZ1YdL0sBz1Rni5RN8d7TzJiRe56n
         AiPkX0YKwLnGjScpveq4Wh+bI+JSZ66Fut4Lj428=
Date:   Tue, 7 May 2019 10:41:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 3/6] dmaengine: Add Synopsys eDMA IP version 0 debugfs
 support
Message-ID: <20190507051136.GB16052@vkoul-mobl>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <ba56a34f11c4bb699079946ca51bb11244ac713e.1556043127.git.gustavo.pimentel@synopsys.com>
 <20190506120710.GG3845@vkoul-mobl.Dlink>
 <305100E33629484CBB767107E4246BBB0A2386A1@de02wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305100E33629484CBB767107E4246BBB0A2386A1@de02wembxa.internal.synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 17:09, Gustavo Pimentel wrote:
> Hi Vinod,
> 
> On Mon, May 6, 2019 at 13:7:10, Vinod Koul <vkoul@kernel.org> wrote:
> 
> > On 23-04-19, 20:30, Gustavo Pimentel wrote:
> > 
> > >  int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
> > >  {
> > > -	return 0;
> > > +	return dw_edma_v0_debugfs_on(chip);
> > 
> > who calls this?
> 
> The main driver. This was done like this for 2 reasons:
> 1) To not break the patch #1 compilation
> 2) Since the code it's to extensive, I decided to break it in another 
> patch.

Hmm I guess I missed that one. I was actually looking at usage and not
questioning split :)

> > > +static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> > > +{
> > > +	if (dw->mode == EDMA_MODE_LEGACY &&
> > > +	    data >= (void *)&regs->type.legacy.ch) {
> > > +		void *ptr = (void *)&regs->type.legacy.ch;
> > > +		u32 viewport_sel = 0;
> > > +		unsigned long flags;
> > > +		u16 ch;
> > > +
> > > +		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
> > > +			if (lim[0][ch].start >= data && data < lim[0][ch].end) {
> > > +				ptr += (data - lim[0][ch].start);
> > > +				goto legacy_sel_wr;
> > > +			}
> > > +
> > > +		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
> > > +			if (lim[1][ch].start >= data && data < lim[1][ch].end) {
> > > +				ptr += (data - lim[1][ch].start);
> > > +				goto legacy_sel_rd;
> > > +			}
> > > +
> > > +		return 0;
> > > +legacy_sel_rd:
> > > +		viewport_sel = BIT(31);
> > > +legacy_sel_wr:
> > > +		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
> > > +
> > > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > > +
> > > +		writel(viewport_sel, &regs->type.legacy.viewport_sel);
> > > +		*val = readl((u32 *)ptr);
> > 
> > why do you need the cast?
> 
> I can't tell from my head, but I think checkpatch or some code analysis 
> tool was complaining about not having that.

ptr is void, so there is no need for casts to or away from void.

> > > +static int dw_edma_debugfs_regs(void)
> > > +{
> > > +	const struct debugfs_entries debugfs_regs[] = {
> > > +		REGISTER(ctrl_data_arb_prior),
> > > +		REGISTER(ctrl),
> > > +	};
> > > +	struct dentry *regs_dir;
> > > +	int nr_entries, err;
> > > +
> > > +	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
> > > +	if (!regs_dir)
> > > +		return -EPERM;
> > > +
> > > +	nr_entries = ARRAY_SIZE(debugfs_regs);
> > > +	err = dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = dw_edma_debugfs_regs_wr(regs_dir);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = dw_edma_debugfs_regs_rd(regs_dir);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return 0;
> > 
> > single return err would suffice right?
> 
> By looking now to this code, I decided to remove the err variable and 
> perform the if immediately on the function, if the result is different 
> from 0 it goes directly to a return -EPERM. 

And one more things, we do not need to check errors on debugfs calls,
and if it fails it fails...

-- 
~Vinod

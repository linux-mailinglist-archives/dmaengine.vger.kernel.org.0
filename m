Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57814953
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEFMHR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfEFMHR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 May 2019 08:07:17 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592E320830;
        Mon,  6 May 2019 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557144436;
        bh=G6r1hJ56O3Ptuo7d/d8TIA581V33XYv2keXBIZwzRIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4hrG6RTpaLO50xdtvOlVm3ADZdpfj2f/0TMVWUH+wPurtC56fkJ5949i59t2EXvk
         ZU+0ZuHJyx/rhhToaxbL7gmq2lfxYgfjUxBzPr1Rk/3mLGoNzaVVn4D4pw6M0stDp/
         9X6iW0Eud4GWl5CWjWziOTRrtrN1/RhGFF+i0voQ=
Date:   Mon, 6 May 2019 17:37:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 3/6] dmaengine: Add Synopsys eDMA IP version 0 debugfs
 support
Message-ID: <20190506120710.GG3845@vkoul-mobl.Dlink>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <ba56a34f11c4bb699079946ca51bb11244ac713e.1556043127.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba56a34f11c4bb699079946ca51bb11244ac713e.1556043127.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-19, 20:30, Gustavo Pimentel wrote:

>  int dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
>  {
> -	return 0;
> +	return dw_edma_v0_debugfs_on(chip);

who calls this?

> +#define RD_PERM					0444

lets not use a macro for these, 444 is more readable :)

> +static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> +{
> +	if (dw->mode == EDMA_MODE_LEGACY &&
> +	    data >= (void *)&regs->type.legacy.ch) {
> +		void *ptr = (void *)&regs->type.legacy.ch;
> +		u32 viewport_sel = 0;
> +		unsigned long flags;
> +		u16 ch;
> +
> +		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
> +			if (lim[0][ch].start >= data && data < lim[0][ch].end) {
> +				ptr += (data - lim[0][ch].start);
> +				goto legacy_sel_wr;
> +			}
> +
> +		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
> +			if (lim[1][ch].start >= data && data < lim[1][ch].end) {
> +				ptr += (data - lim[1][ch].start);
> +				goto legacy_sel_rd;
> +			}
> +
> +		return 0;
> +legacy_sel_rd:
> +		viewport_sel = BIT(31);
> +legacy_sel_wr:
> +		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
> +
> +		raw_spin_lock_irqsave(&dw->lock, flags);
> +
> +		writel(viewport_sel, &regs->type.legacy.viewport_sel);
> +		*val = readl((u32 *)ptr);

why do you need the cast?

> +static int dw_edma_debugfs_regs(void)
> +{
> +	const struct debugfs_entries debugfs_regs[] = {
> +		REGISTER(ctrl_data_arb_prior),
> +		REGISTER(ctrl),
> +	};
> +	struct dentry *regs_dir;
> +	int nr_entries, err;
> +
> +	regs_dir = debugfs_create_dir(REGISTERS_STR, base_dir);
> +	if (!regs_dir)
> +		return -EPERM;
> +
> +	nr_entries = ARRAY_SIZE(debugfs_regs);
> +	err = dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> +	if (err)
> +		return err;
> +
> +	err = dw_edma_debugfs_regs_wr(regs_dir);
> +	if (err)
> +		return err;
> +
> +	err = dw_edma_debugfs_regs_rd(regs_dir);
> +	if (err)
> +		return err;
> +
> +	return 0;

single return err would suffice right?

> +int dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
> +{
> +	struct dentry *entry;
> +	int err;
> +
> +	dw = chip->dw;
> +	if (!dw)
> +		return -EPERM;
> +
> +	regs = (struct dw_edma_v0_regs *)dw->rg_region.vaddr;
> +	if (!regs)
> +		return -EPERM;
> +
> +	base_dir = debugfs_create_dir(dw->name, 0);
> +	if (!base_dir)
> +		return -EPERM;
> +
> +	entry = debugfs_create_u32("version", RD_PERM, base_dir, &dw->version);
> +	if (!entry)
> +		return -EPERM;
> +
> +	entry = debugfs_create_u32("mode", RD_PERM, base_dir, &dw->mode);
> +	if (!entry)
> +		return -EPERM;
> +
> +	entry = debugfs_create_u16("wr_ch_cnt", RD_PERM, base_dir,
> +				   &dw->wr_ch_cnt);
> +	if (!entry)
> +		return -EPERM;
> +
> +	entry = debugfs_create_u16("rd_ch_cnt", RD_PERM, base_dir,
> +				   &dw->rd_ch_cnt);
> +	if (!entry)
> +		return -EPERM;
> +
> +	err = dw_edma_debugfs_regs();
> +	return err;

return dw_edma_debugfs_regs() perhpaps..?
-- 
~Vinod

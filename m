Return-Path: <dmaengine+bounces-6511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFBB57A14
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4785D17A064
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2639305958;
	Mon, 15 Sep 2025 12:11:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B472F0661;
	Mon, 15 Sep 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938319; cv=none; b=Q4CKX/03buU4EVD89ImOzdrr/cwJPynI4MaUc0couliNYYF85pG2cxc8MGPyd7n00U0KwNFEGfM1HiLaQ3Lo1ktyz4LSMkhSC9M9xFOfwOAEj61K89tr+/VrE3k1//KoQSgi6KPl6kI4awZH0rnkDUHFYsLlcpKmd3FPpPv1ZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938319; c=relaxed/simple;
	bh=v76aSgIomYEhuZfch6qrk9HyPL93jBWVa3EGkekZCwQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ1YDXoZdq//1P6g8bUFqJkXwmWQN7OVr8wtCdjSGLUARHEOu9y0nGCEductlwSwlu1BmDSjvVYWjInTz6N6iFKQzPvTYK5OR+Ibgg1x/ARe2DTR+EnmdhaDX7Lb9NkgHc5HuUHNmoR/S2t+IUsbrhXEOg0tYHMGZNwEwsMT64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQP2q2H7Qz6M57M;
	Mon, 15 Sep 2025 20:09:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D84A21402EA;
	Mon, 15 Sep 2025 20:11:52 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 14:11:52 +0200
Date: Mon, 15 Sep 2025 13:11:51 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 06/13] dmaengine: sdxi: Add error reporting support
Message-ID: <20250915131151.00005f26@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-6-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-6-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:29 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> SDXI implementations provide software with detailed information about
> error conditions using a per-device ring buffer in system memory. When
> an error condition is signaled via interrupt, the driver retrieves any
> pending error log entries and reports them to the kernel log.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Hi,
A few more comments inline. Kind of similar stuff around
having both register definitions for unpacking and the structure
definitions in patch 2.

Thanks,

Jonathan
> ---
>  drivers/dma/sdxi/error.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/error.h |  16 +++
>  2 files changed, 356 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c5e33f5989250352f6b081a3049b3b1f972c85a6
> --- /dev/null
> +++ b/drivers/dma/sdxi/error.c

> +/* The "unpacked" counterpart to ERRLOG_HD_ENT. */
> +struct errlog_entry {
> +	u64 dsc_index;
> +	u16 cxt_num;
> +	u16 err_class;
> +	u16 type;
> +	u8 step;
> +	u8 buf;
> +	u8 sub_step;
> +	u8 re;
> +	bool vl;
> +	bool cv;
> +	bool div;
> +	bool bv;
> +};
> +
> +#define ERRLOG_ENTRY_FIELD(hi_, lo_, name_)				\
> +	PACKED_FIELD(hi_, lo_, struct errlog_entry, name_)
> +#define ERRLOG_ENTRY_FLAG(nr_, name_) \
> +	ERRLOG_ENTRY_FIELD(nr_, nr_, name_)
> +
> +/* Refer to "Error Log Header Entry (ERRLOG_HD_ENT)" */
> +static const struct packed_field_u16 errlog_hd_ent_fields[] = {
> +	ERRLOG_ENTRY_FLAG(0, vl),
> +	ERRLOG_ENTRY_FIELD(13, 8, step),
> +	ERRLOG_ENTRY_FIELD(26, 16, type),
> +	ERRLOG_ENTRY_FLAG(32, cv),
> +	ERRLOG_ENTRY_FLAG(33, div),
> +	ERRLOG_ENTRY_FLAG(34, bv),
> +	ERRLOG_ENTRY_FIELD(38, 36, buf),
> +	ERRLOG_ENTRY_FIELD(43, 40, sub_step),
> +	ERRLOG_ENTRY_FIELD(46, 44, re),
> +	ERRLOG_ENTRY_FIELD(63, 48, cxt_num),
> +	ERRLOG_ENTRY_FIELD(127, 64, dsc_index),
> +	ERRLOG_ENTRY_FIELD(367, 352, err_class),

The association between the fields here and struct sdxi_err_log_hd_ent
to me should be via some defines in patch 2 for the various fields
embedded in misc0 etc.

> +};

> +static void sdxi_print_err(struct sdxi_dev *sdxi, u64 err_rd)
> +{
> +	struct errlog_entry ent;
> +	size_t index;
> +
> +	index = err_rd % ERROR_LOG_ENTRIES;
> +
> +	unpack_fields(&sdxi->err_log[index], sizeof(sdxi->err_log[0]),
> +		      &ent, errlog_hd_ent_fields, SDXI_PACKING_QUIRKS);
> +
> +	if (!ent.vl) {
> +		dev_err_ratelimited(sdxi_to_dev(sdxi),
> +				    "Ignoring error log entry with vl=0\n");
> +		return;
> +	}
> +
> +	if (ent.type != OP_TYPE_ERRLOG) {
> +		dev_err_ratelimited(sdxi_to_dev(sdxi),
> +				    "Ignoring error log entry with type=%#x\n",
> +				    ent.type);
> +		return;
> +	}
> +
> +	sdxi_err(sdxi, "error log entry[%zu], MMIO_ERR_RD=%#llx:\n",
> +		 index, err_rd);
> +	sdxi_err(sdxi, "  re: %#x (%s)\n", ent.re, reaction_str(ent.re));
> +	sdxi_err(sdxi, "  step: %#x (%s)\n", ent.step, step_str(ent.step));
> +	sdxi_err(sdxi, "  sub_step: %#x (%s)\n",
> +		 ent.sub_step, sub_step_str(ent.sub_step));
> +	sdxi_err(sdxi, "  cv: %u div: %u bv: %u\n", ent.cv, ent.div, ent.bv);
> +	if (ent.bv)
> +		sdxi_err(sdxi, "  buf: %u\n", ent.buf);
> +	if (ent.cv)
> +		sdxi_err(sdxi, "  cxt_num: %#x\n", ent.cxt_num);
> +	if (ent.div)
> +		sdxi_err(sdxi, "  dsc_index: %#llx\n", ent.dsc_index);
> +	sdxi_err(sdxi, "  err_class: %#x\n", ent.err_class);
Consider using tracepoints for error logging rather than large splats in the
log. Maybe you add those in later patches!

I'd then just fill the tracepoint in directly rather than have an unpacking
step.

> +}

> +/* Refer to "Error Log Initialization" */
> +int sdxi_error_init(struct sdxi_dev *sdxi)
> +{
> +	u64 reg;
> +	int err;
> +
> +	/* 1. Clear MMIO_ERR_CFG. Error interrupts are inhibited until step 6. */
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
> +
> +	/* 2. Clear MMIO_ERR_STS. The flags in this register are RW1C. */
> +	reg = FIELD_PREP(SDXI_MMIO_ERR_STS_STS_BIT, 1) |
> +	      FIELD_PREP(SDXI_MMIO_ERR_STS_OVF_BIT, 1) |
> +	      FIELD_PREP(SDXI_MMIO_ERR_STS_ERR_BIT, 1);
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_STS, reg);
> +
> +	/* 3. Allocate memory for the error log ring buffer, initialize to zero. */
> +	sdxi->err_log = dma_alloc_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
> +					   &sdxi->err_log_dma, GFP_KERNEL);
> +	if (!sdxi->err_log)
> +		return -ENOMEM;
> +
> +	/*
> +	 * 4. Set MMIO_ERR_CTL.intr_en to 1 if interrupts on
> +	 * context-level errors are desired.
> +	 */
> +	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
> +	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
> +
> +	/*
> +	 * The spec is not explicit about when to do this, but this
> +	 * seems like the right time: enable interrupt on
> +	 * function-level transition to error state.
> +	 */
> +	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
> +	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
> +
> +	/* 5. Clear MMIO_ERR_WRT and MMIO_ERR_RD. */
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
> +
> +	/*
> +	 * Error interrupts can be generated once MMIO_ERR_CFG.en is
> +	 * set in step 6, so set up the handler now.
> +	 */
> +	err = request_threaded_irq(sdxi->error_irq, NULL, sdxi_irq_thread,
> +				   IRQF_TRIGGER_NONE, "SDXI error", sdxi);
> +	if (err)
> +		goto free_errlog;
> +
> +	/* 6. Program MMIO_ERR_CFG. */

I'm guessing these are numbers steps in some bit of the spec?
If not some of these comments like this one provide no value.  We can
see what is being written from the code!  Perhaps add a very specific
spec reference if you want to show why the numbering is here.


> +	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR, sdxi->err_log_dma >> 12) |
> +	      FIELD_PREP(SDXI_MMIO_ERR_CFG_SZ, ERROR_LOG_ENTRIES >> 6) |
> +	      FIELD_PREP(SDXI_MMIO_ERR_CFG_EN, 1);
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, reg);
> +
> +	return 0;
> +
> +free_errlog:
> +	dma_free_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
> +			  sdxi->err_log, sdxi->err_log_dma);
> +	return err;
> +}
> +
> +void sdxi_error_exit(struct sdxi_dev *sdxi)
> +{
> +	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
> +	free_irq(sdxi->error_irq, sdxi);
> +	dma_free_coherent(sdxi_to_dev(sdxi), ERROR_LOG_SZ,
> +			  sdxi->err_log, sdxi->err_log_dma);
> +}

> 



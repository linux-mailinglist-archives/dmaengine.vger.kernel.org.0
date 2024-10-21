Return-Path: <dmaengine+bounces-3397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43019A7114
	for <lists+dmaengine@lfdr.de>; Mon, 21 Oct 2024 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DAC1C223A7
	for <lists+dmaengine@lfdr.de>; Mon, 21 Oct 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC621CC161;
	Mon, 21 Oct 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODl2emVD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AA1CBEBC
	for <dmaengine@vger.kernel.org>; Mon, 21 Oct 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531958; cv=none; b=n7cM8IPp5dFH76NzpleTA643QUAogBIO1gP5WvSyFi/wuRyNelPh831VPSu24JXamEpa3Y8MY/TvQhHu4Jn/ffG6ftGcEVuv1TFjTWFmr6ATyztOzCgq59NwtsV0yteGVuzExKY6kDBvaIEoulzjh7rIC84cZhGVKnEiuhl+MYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531958; c=relaxed/simple;
	bh=flSwQdtIhuDFNi6B/6E4DBHc+VH6UTI387gdCcpusOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr5Br3v4ARjvQwoBmWztSC4G8plolgsgs4/5F6ArsKt87Vogis8MuSNH5q+VVN00l1d2tKqjLsQoCJYe+I1cWTtA+IZqv5LhTSziREexKQRncyHVnbom7zKbRzPuyTdfx023isgjfvlU/tj7rs40CkMgWhNZoMGuDlVuEHXgITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODl2emVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B36C4CEC3;
	Mon, 21 Oct 2024 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729531957;
	bh=flSwQdtIhuDFNi6B/6E4DBHc+VH6UTI387gdCcpusOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODl2emVDdbwuYty+XDkRkMNN1FIY2+b/EVseBVa+NLxfYmbsWuXr6e+eKZUNN3Vvn
	 WWAmD+WaRhAmsGwRmvXJeNUqkhZC0wSvkqU/mDKf5hVdln4e7BPLL/esFIkfJ7nysA
	 R9dsRokXLEbSDOLGHhY1mjm9dC0q3iLVCZmZDdW5cvKKxrewrPjngO5hiGbcOUA42g
	 hr+wiijtKNHHKAKpzrJPlFDDdi9eRONRr2L4vf7g8GIvOrQVOve6oZUjBA1R5pXfMJ
	 NcPVUu09RRM9x/y0/csYRlV+hnt2F3VRuqyLe+cR/Hq5Gh8gxRGLwZwfF45WPzM7zy
	 1NsO4vxv/s04A==
Date: Mon, 21 Oct 2024 23:02:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v6 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <ZxaQMP8b0Dfk96aa@vaman>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
 <20240909123941.794563-5-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909123941.794563-5-Basavaraj.Natikar@amd.com>

On 09-09-24, 18:09, Basavaraj Natikar wrote:
> Use the pt_dmaengine_register function to register a AE4DMA DMA engine.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/dma/amd/ae4dma/ae4dma-dev.c     |  51 +----------
>  drivers/dma/amd/ae4dma/ae4dma-pci.c     |   1 +
>  drivers/dma/amd/ae4dma/ae4dma.h         |   3 +
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 114 +++++++++++++++++++++++-
>  drivers/dma/amd/ptdma/ptdma.h           |   3 +
>  5 files changed, 123 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> index f0b3a3763adc..cd84b502265e 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> @@ -14,53 +14,6 @@ static unsigned int max_hw_q = 1;
>  module_param(max_hw_q, uint, 0444);
>  MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>  
> -static char *ae4_error_codes[] = {
> -	"",
> -	"ERR 01: INVALID HEADER DW0",
> -	"ERR 02: INVALID STATUS",
> -	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> -	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> -	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> -	"ERR 06: INVALID ALIGNMENT",
> -	"ERR 07: INVALID DESCRIPTOR",
> -};
> -
> -static void ae4_log_error(struct pt_device *d, int e)
> -{
> -	/* ERR 01 - 07 represents Invalid AE4 errors */
> -	if (e <= 7)
> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> -	/* ERR 08 - 15 represents Invalid Descriptor errors */
> -	else if (e > 7 && e <= 15)
> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> -	/* ERR 16 - 31 represents Firmware errors */
> -	else if (e > 15 && e <= 31)
> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
> -	/* ERR 32 - 63 represents Fatal errors */
> -	else if (e > 31 && e <= 63)
> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
> -	/* ERR 64 - 255 represents PTE errors */
> -	else if (e > 63 && e <= 255)
> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> -	else
> -		dev_info(d->dev, "Unknown AE4DMA error");
> -}
> -
> -static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> -{
> -	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> -	struct ae4dma_desc desc;
> -	u8 status;
> -
> -	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> -	status = desc.dw1.status;
> -	if (status && status != AE4_DESC_COMPLETED) {
> -		cmd_q->cmd_error = desc.dw1.err_code;
> -		if (cmd_q->cmd_error)
> -			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> -	}
> -}

why is this getting moved?

> -
>  static void ae4_pending_work(struct work_struct *work)
>  {
>  	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
> @@ -194,5 +147,9 @@ int ae4_core_init(struct ae4_device *ae4)
>  		init_completion(&ae4cmd_q->cmp);
>  	}
>  
> +	ret = pt_dmaengine_register(pt);
> +	if (ret)
> +		ae4_destroy_work(ae4);
> +
>  	return ret;
>  }
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> index 43d36e9d1efb..aad0dc4294a3 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -98,6 +98,7 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	pt = &ae4->pt;
>  	pt->dev = dev;
> +	pt->ver = AE4_DMA_VERSION;
>  
>  	pt->io_regs = pcim_iomap_table(pdev)[0];
>  	if (!pt->io_regs) {
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> index 666bc76735cf..265c5d436008 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma.h
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -35,6 +35,7 @@
>  #define AE4_Q_SZ			0x20
>  
>  #define AE4_DMA_VERSION			4
> +#define CMD_AE4_DESC_DW0_VAL		2
>  
>  struct ae4_msix {
>  	int msix_count;
> @@ -55,6 +56,7 @@ struct ae4_cmd_queue {
>  	atomic64_t done_cnt;
>  	u64 q_cmd_count;
>  	u32 dridx;
> +	u32 tail_wi;
>  	u32 id;
>  };
>  
> @@ -94,4 +96,5 @@ struct ae4_device {
>  
>  int ae4_core_init(struct ae4_device *ae4);
>  void ae4_destroy_work(struct ae4_device *ae4);
> +void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx);
>  #endif
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 3f1dc858a914..cfc60cf571c2 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -13,6 +13,17 @@
>  #include "../ae4dma/ae4dma.h"
>  #include "../../dmaengine.h"
>  
> +static char *ae4_error_codes[] = {
> +	"",
> +	"ERR 01: INVALID HEADER DW0",
> +	"ERR 02: INVALID STATUS",
> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> +	"ERR 06: INVALID ALIGNMENT",
> +	"ERR 07: INVALID DESCRIPTOR",
> +};
> +
>  static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
>  {
>  	return container_of(dma_chan, struct pt_dma_chan, vc.chan);
> @@ -62,6 +73,52 @@ static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma
>  	return cmd_q;
>  }
>  
> +static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
> +{
> +	bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +
> +	if (soc) {
> +		desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
> +		desc->dwouv.dw0 &= ~DWORD0_SOC;
> +	}
> +
> +	mutex_lock(&ae4cmd_q->cmd_lock);
> +	memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
> +	ae4cmd_q->q_cmd_count++;
> +	ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
> +	writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
> +	mutex_unlock(&ae4cmd_q->cmd_lock);
> +
> +	wake_up(&ae4cmd_q->q_w);
> +
> +	return 0;
> +}
> +
> +int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
> +	struct ae4dma_desc desc;
> +
> +	cmd_q->cmd_error = 0;
> +	cmd_q->total_pt_ops++;
> +	memset(&desc, 0, sizeof(desc));
> +	desc.dwouv.dws.byte0 = CMD_AE4_DESC_DW0_VAL;
> +
> +	desc.dw1.status = 0;
> +	desc.dw1.err_code = 0;
> +	desc.dw1.desc_id = 0;
> +
> +	desc.length = pt_engine->src_len;
> +
> +	desc.src_lo = upper_32_bits(pt_engine->src_dma);
> +	desc.src_hi = lower_32_bits(pt_engine->src_dma);
> +	desc.dst_lo = upper_32_bits(pt_engine->dst_dma);
> +	desc.dst_hi = lower_32_bits(pt_engine->dst_dma);
> +
> +	return ae4_core_execute_cmd(&desc, ae4cmd_q);
> +}
> +
>  static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>  {
>  	struct pt_passthru_engine *pt_engine;
> @@ -81,7 +138,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>  	pt->tdata.cmd = pt_cmd;
>  
>  	/* Execute the command */
> -	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
> +	if (pt->ver == AE4_DMA_VERSION)
> +		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
> +	else
> +		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
>  
>  	return 0;
>  }
> @@ -288,6 +348,52 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>  		pt_cmd_callback(desc, 0);
>  }
>  
> +static void ae4_log_error(struct pt_device *d, int e)
> +{
> +	/* ERR 01 - 07 represents Invalid AE4 errors */
> +	if (e <= 7)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> +	/* ERR 08 - 15 represents Invalid Descriptor errors */
> +	else if (e > 7 && e <= 15)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> +	/* ERR 16 - 31 represents Firmware errors */
> +	else if (e > 15 && e <= 31)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
> +	/* ERR 32 - 63 represents Fatal errors */
> +	else if (e > 31 && e <= 63)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
> +	/* ERR 64 - 255 represents PTE errors */
> +	else if (e > 63 && e <= 255)
> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> +	else
> +		dev_info(d->dev, "Unknown AE4DMA error");
> +}
> +
> +void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> +{
> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> +	struct ae4dma_desc desc;
> +	u8 status;
> +
> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> +	status = desc.dw1.status;
> +	if (status && status != AE4_DESC_COMPLETED) {
> +		cmd_q->cmd_error = desc.dw1.err_code;
> +		if (cmd_q->cmd_error)
> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ae4_check_status_error);
> +
> +void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
> +	int i;
> +
> +	for (i = 0; i < CMD_Q_LEN; i++)
> +		ae4_check_status_error(ae4cmd_q, i);
> +}
> +
>  static enum dma_status
>  pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>  		struct dma_tx_state *txstate)
> @@ -298,7 +404,10 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>  
>  	cmd_q = pt_get_cmd_queue(pt, chan);
>  
> -	pt_check_status_trans(pt, cmd_q);
> +	if (pt->ver == AE4_DMA_VERSION)
> +		pt_check_status_trans_ae4(pt, cmd_q);
> +	else
> +		pt_check_status_trans(pt, cmd_q);
>  	return dma_cookie_status(c, cookie, txstate);
>  }
>  
> @@ -464,6 +573,7 @@ int pt_dmaengine_register(struct pt_device *pt)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pt_dmaengine_register);
>  
>  void pt_dmaengine_unregister(struct pt_device *pt)
>  {
> diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
> index a6990021fe2b..9d311eef50c2 100644
> --- a/drivers/dma/amd/ptdma/ptdma.h
> +++ b/drivers/dma/amd/ptdma/ptdma.h
> @@ -336,4 +336,7 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
>  {
>  	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_control + 0x000C);
>  }
> +
> +int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine);
> +void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
>  #endif
> -- 
> 2.25.1

-- 
~Vinod


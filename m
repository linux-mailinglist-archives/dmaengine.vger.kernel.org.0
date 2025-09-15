Return-Path: <dmaengine+bounces-6513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99678B57E7D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F09818948BB
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A92F3624;
	Mon, 15 Sep 2025 14:13:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88031B80F;
	Mon, 15 Sep 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945585; cv=none; b=ZCbULJT7hEU3Cr70qDqUTq8SnvnEzr2JS8Z2Jwm+U3sotSQZn/V1mHhMshydyQLxJJtf1pYI5X5HhV4X/Yu8EVdISH7jpKd/w7wayOLm34HUfwbdqgYu51vvzp7zNbGVOWYyxrCanbAPqWC/gntWmHgDFjjwwmphqygF20y44Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945585; c=relaxed/simple;
	bh=AwTu8u9YiJquU5bgb96v3Ixdf9OaqS4HYjtVwL6W5NQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N24VzdqJATKZLSnvYIV5WWHlpIJVu+DNJ4m0yA25zAciNncR3tYQ9AHtkb22JssQCoVlC+FtHpxBrc2zH/qVpGdqzg1yq3rcnh+tZtcx6Dk0UOZBD2VO17+iUAj8JQKLVPZJKqoRhxSx3TxZgvyKdx09pTp1ENB/HJ7SDLrlEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQRhc713mz6L6kL;
	Mon, 15 Sep 2025 22:08:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C50C1402F7;
	Mon, 15 Sep 2025 22:12:59 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 16:12:58 +0200
Date: Mon, 15 Sep 2025 15:12:57 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 08/13] dmaengine: sdxi: Context creation/removal,
 descriptor submission
Message-ID: <20250915151257.0000253b@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:31 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add functions for creating and removing SDXI contexts and submitting
> descriptors against them.
> 
> An SDXI function supports one or more contexts, each of which has its
> own descriptor ring and associated state. Each context has a 16-bit
> index. A special context is installed at index 0 and is used for
> configuring other contexts and performing administrative actions.
> 
> The creation of each context entails the allocation of the following
> control structure hierarchy:
> 
> * Context L1 Table slot
>   * Access key (AKey) table
>   * Context control block
>     * Descriptor ring
>     * Write index
>     * Context status block
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Some superficial stuff inline.

I haven't yet reread the spec against this (and it's been a while
since I looked at sdxi!) but overall seems reasonable.
> ---
>  drivers/dma/sdxi/context.c | 547 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |  28 +++
>  2 files changed, 575 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..50eae5b3b303d67891113377e2df209d199aa533
> --- /dev/null
> +++ b/drivers/dma/sdxi/context.c
> @@ -0,0 +1,547 @@


> +
> +static struct sdxi_cxt *alloc_cxt(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cxt *cxt;
> +	u16 id, l2_idx, l1_idx;
> +
> +	if (sdxi->cxt_count >= sdxi->max_cxts)
> +		return NULL;
> +
> +	/* search for an empty context slot */
> +	for (id = 0; id < sdxi->max_cxts; id++) {
> +		l2_idx = ID_TO_L2_INDEX(id);
> +		l1_idx = ID_TO_L1_INDEX(id);
> +
> +		if (sdxi->cxt_array[l2_idx] == NULL) {
> +			int sz = sizeof(struct sdxi_cxt *) * L1_TABLE_ENTRIES;
> +			struct sdxi_cxt **ptr = kzalloc(sz, GFP_KERNEL);
> +
> +			sdxi->cxt_array[l2_idx] = ptr;
> +			if (!(sdxi->cxt_array[l2_idx]))
> +				return NULL;
> +		}
> +
> +		cxt = (sdxi->cxt_array)[l2_idx][l1_idx];
> +		/* found one empty slot */
> +		if (!cxt)
> +			break;
> +	}
> +
> +	/* nothing found, bail... */
> +	if (id == sdxi->max_cxts)
> +		return NULL;
> +
> +	/* alloc context and initialize it */
> +	cxt = kzalloc(sizeof(struct sdxi_cxt), GFP_KERNEL);

sizeof(*ctx) usually preferred as it saves anyone checking types match.

> +	if (!cxt)
> +		return NULL;
> +
> +	cxt->akey_table = dma_alloc_coherent(sdxi_to_dev(sdxi),
> +					     sizeof(*cxt->akey_table),
> +					     &cxt->akey_table_dma, GFP_KERNEL);
> +	if (!cxt->akey_table) {
> +		kfree(cxt);

Similar to below. You could use a DEFINE_FREE() to auto cleanup up ctx
on error.

> +		return NULL;
> +	}
> +
> +	cxt->sdxi = sdxi;
> +	cxt->id = id;
> +	cxt->db_base = sdxi->dbs_bar + id * sdxi->db_stride;
> +	cxt->db = sdxi->dbs + id * sdxi->db_stride;
> +
> +	sdxi->cxt_array[l2_idx][l1_idx] = cxt;
> +	sdxi->cxt_count++;
> +
> +	return cxt;
> +}

> +struct sdxi_cxt *sdxi_working_cxt_init(struct sdxi_dev *sdxi,
> +				       enum sdxi_cxt_id id)
> +{
> +	struct sdxi_cxt *cxt;
> +	struct sdxi_sq *sq;
> +
> +	cxt = sdxi_cxt_alloc(sdxi);
> +	if (!cxt) {
> +		sdxi_err(sdxi, "failed to alloc a new context\n");
> +		return NULL;
> +	}
> +
> +	/* check if context ID matches */
> +	if (id < SDXI_ANY_CXT_ID && cxt->id != id) {
> +		sdxi_err(sdxi, "failed to alloc a context with id=%d\n", id);
> +		goto err_cxt_id;
> +	}
> +
> +	sq = sdxi_sq_alloc_default(cxt);
> +	if (!sq) {
> +		sdxi_err(sdxi, "failed to alloc a submission queue (sq)\n");
> +		goto err_sq_alloc;
> +	}
> +
> +	return cxt;
> +
> +err_sq_alloc:
> +err_cxt_id:
> +	sdxi_cxt_free(cxt);

Might be worth doing a DEFINE_FREE() then you can use return_ptr(ctx); instead
of return ctx.  Will allow you to simply return on any errors.

> +
> +	return NULL;
> +}
> +
> +static const char *cxt_sts_state_str(enum cxt_sts_state state)
> +{
> +	static const char *const context_states[] = {
> +		[CXTV_STOP_SW]  = "stopped (software)",
> +		[CXTV_RUN]      = "running",
> +		[CXTV_STOPG_SW] = "stopping (software)",
> +		[CXTV_STOP_FN]  = "stopped (function)",
> +		[CXTV_STOPG_FN] = "stopping (function)",
> +		[CXTV_ERR_FN]   = "error",
> +	};
> +	const char *str = "unknown";
> +
> +	switch (state) {
> +	case CXTV_STOP_SW:
> +	case CXTV_RUN:
> +	case CXTV_STOPG_SW:
> +	case CXTV_STOP_FN:
> +	case CXTV_STOPG_FN:
> +	case CXTV_ERR_FN:
> +		str = context_states[state];

I'd do a default to make it explicit that there are other states.  If there
aren't then just return here and skip the return below.  A compiler should
be able to see if you handled them all and complain loudly if a new one is
added that you haven't handled.

> +	}
> +
> +	return str;
> +}
> +
> +int sdxi_submit_desc(struct sdxi_cxt *cxt, const struct sdxi_desc *desc)
> +{
> +	struct sdxi_sq *sq;
> +	__le64 __iomem *db;
> +	__le64 *ring_base;
> +	u64 ring_entries;
> +	__le64 *rd_idx;
> +	__le64 *wr_idx;
> +
> +	sq = cxt->sq;
> +	ring_entries = sq->ring_entries;
> +	ring_base = sq->desc_ring[0].qw;
> +	rd_idx = &sq->cxt_sts->read_index;
> +	wr_idx = sq->write_index;
> +	db = cxt->db;
I'm not sure the local variables add anything, but if you really want
to keep them, then at least combine with declaration.

	struct sdxi_sq *sq = ctx->sq;
	__le64 __iomem *db = ctx->db;


just to keep thing code more compact.

Personally I'd just have a local sq and do the rest in the call

	return sdxi_enqueue(desc->qw, 1, sq->desc_ring[0].wq,
etc


> +
> +	return sdxi_enqueue(desc->qw, 1, ring_base, ring_entries,
> +			    rd_idx, wr_idx, db);
				
> +}
> +
> +static void sdxi_cxt_shutdown(struct sdxi_cxt *target_cxt)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> +	struct sdxi_cxt *admin_cxt = target_cxt->sdxi->admin_cxt;
> +	struct sdxi_dev *sdxi = target_cxt->sdxi;
> +	struct sdxi_cxt_sts *sts = target_cxt->sq->cxt_sts;
> +	struct sdxi_desc desc;
> +	u16 cxtid = target_cxt->id;
> +	struct sdxi_cxt_stop params = {
> +		.range = sdxi_cxt_range(cxtid),
> +	};
> +	enum cxt_sts_state state = sdxi_cxt_sts_state(sts);
> +	int err;
> +
> +	sdxi_dbg(sdxi, "%s entry: context state: %s",
> +		 __func__, cxt_sts_state_str(state));
> +
> +	err = sdxi_encode_cxt_stop(&desc, &params);
> +	if (err)
> +		return;
> +
> +	err = sdxi_submit_desc(admin_cxt, &desc);
> +	if (err)
> +		return;
> +
> +	sdxi_dbg(sdxi, "shutting down context %u\n", cxtid);
> +
> +	do {
> +		enum cxt_sts_state state = sdxi_cxt_sts_state(sts);
> +
> +		sdxi_dbg(sdxi, "context %u state: %s", cxtid,
> +			 cxt_sts_state_str(state));
> +
> +		switch (state) {
> +		case CXTV_ERR_FN:
> +			sdxi_err(sdxi, "context %u went into error state while stopping\n",
> +				cxtid);
> +			fallthrough;

I'd just return unless a later patch adds something more interesting to the next
cases.

> +		case CXTV_STOP_SW:
> +		case CXTV_STOP_FN:
> +			return;
> +		case CXTV_RUN:
> +		case CXTV_STOPG_SW:
> +		case CXTV_STOPG_FN:
> +			/* transitional states */
> +			fsleep(1000);
> +			break;
> +		default:
> +			sdxi_err(sdxi, "context %u in unknown state %u\n",
> +				 cxtid, state);
> +			return;
> +		}
> +	} while (time_before(jiffies, deadline));
> +
> +	sdxi_err(sdxi, "stopping context %u timed out (state = %u)\n",
> +		cxtid, sdxi_cxt_sts_state(sts));
> +}
> +
> +void sdxi_working_cxt_exit(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_sq *sq;
> +
> +	if (!cxt)
Superficially this looks like defensive programming that we don't need
as it makes not sense to call this if ctx is NULL.  Add a comment if
there is a path where this actually happens.
> +		return;
> +
> +	sq = cxt->sq;
> +	if (!sq)
Add a comment on why this might happen, or drop teh cehck.

> +		return;
> +
> +	sdxi_cxt_shutdown(cxt);
> +
> +	sdxi_sq_free(sq);
> +
> +	sdxi_cxt_free(cxt);
> +}




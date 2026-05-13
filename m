Return-Path: <dmaengine+bounces-10405-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFEBHzYCBGqzCAIAu9opvQ
	(envelope-from <dmaengine+bounces-10405-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 06:46:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104B52D37A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 06:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 050EC304F7B3
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9638E8DA;
	Wed, 13 May 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAWe3AAf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE383812E9;
	Wed, 13 May 2026 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647599; cv=none; b=sEemCf97cf8zmBxC2704IeOW9UcClWyA+aeY9a8VenD/O5+eijQ1q/AWqYzR2xVS55AGmPJ5M9KlXHRSa96sJ7oYiR9m0NuhX0eAYtgcvPy0EaUTJ4exZ000w3RDstRe0Sn5ODEniIQLG/RJ0cseiPc2M7SimlHtIJd/q9M6xVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647599; c=relaxed/simple;
	bh=xwq/XWX4trdCJpQsmA8bbTspKF3EQnFJDHu1o7xaUkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/80aonba23uxKHrmJhUI+cnOSKqW+z+sZzWYH+FbzMDZu6EsBMiYx4Gh8XsF4z2+LRDAEXdMyCFYs7JuBHOIydbw80IIpnt/xlLRbb9G49wwGryf5iky3/2+aYPYq9Tbsq3LhLl9HyEExYIs+fyE2u3eGuVSHYj0siq5om91us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAWe3AAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691DBC2BCFD;
	Wed, 13 May 2026 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778647598;
	bh=xwq/XWX4trdCJpQsmA8bbTspKF3EQnFJDHu1o7xaUkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sAWe3AAfXiuGkvuYYaZsafucqj6iqD24jetSYNIUA2QU/hvjX6AUVilutBCsqW7ND
	 R/3CX2syijDUYve5e1ekfwqmdhciam9TZbBaUrcUajDIRtqDSFgFM5CO2EVaVbFXiT
	 mR2/d8UW2bhxTQCG9rlmrA3Vc3hb474Xgj/y1gcHVRLTGctMOPg5dmfswMpKwQaRfK
	 SzkaP7qfJpjxXBdbgtTv1Mvzw51JU4WjBWc86SsZYS787jMp4qnTOXUKs1Xh2edLKY
	 uZJWYUfKpt82kDBriqnkVehcKV8itQj7w9e1wYTNP5euWKIsU/Lyqb0JCEQkv1kbhy
	 pDNRiBdm0O8SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-11-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-11-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:46:37 +0000
Message-Id: <20260513044638.691DBC2BCFD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 2104B52D37A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,amd.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10405-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing hardware synchronization and premature context teardow=
n causes DMA Use-After-Free.
- [High] Forcefully freeing client contexts in `sdxi_unregister()` breaks o=
wnership boundaries, causing Double-Free/UAF.
- [High] Broken XArray ID reservation allows concurrent contexts to receive=
 the same ID, causing L1 table corruption.
- [High] Lockless `xa_for_each()` iteration over `client_cxts` races with s=
ynchronous deletion, leading to UAF.
- [Medium] Premature publication of context in `sdxi_cxt_new()` exposes par=
tially-initialized objects.
--

commit 441cde89ecc6054dc9032c18c35585d44565e4ea
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add client context alloc and release APIs

This commit exposes sdxi_cxt_new() and sdxi_cxt_exit() for creating and
releasing SDXI contexts. It tracks client contexts in a device-wide
allocating xarray and introduces a local sdxi_cxt_id class for early ID
allocation.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index c0b55c945cc4e..c0b294836edeb 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
[ ... ]
> @@ -258,6 +282,17 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *c=
xt)
[ ... ]
> +/* Invalidate a context. */
> +static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
> +{
> +	u8 l1_idx =3D ID_TO_L1_INDEX(cxt->id);
> +	struct sdxi_cxt_L1_ent *ent =3D &cxt->sdxi->L1_table->entry[l1_idx];
> +
> +	invalidate_L1_entry(ent);
> +	invalidate_cxtl_ctl(cxt->cxt_ctl);
> +	/* todo: need to send DSC_CXT_UPD to admin */

Since the hardware is not notified to halt processing here, and the context=
's
DMA memory is freed in sdxi_free_cxt() right after this returns, will the
active hardware continue writing to the freed physical memory pages?

> +}
[ ... ]
> @@ -288,3 +323,90 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
[ ... ]
> +static struct sdxi_cxt_id sdxi_cxt_id_ctor(struct sdxi_dev *sdxi)
> +{
> +	struct xa_limit limit =3D XA_LIMIT(1, sdxi->max_cxtid);
> +	u32 index;
> +
> +	return (struct sdxi_cxt_id) {
> +		.sdxi =3D sdxi,
> +		.index =3D xa_alloc(&sdxi->client_cxts, &index, NULL,
> +				  limit, GFP_KERNEL) ? 0 : (u16)index,

Does passing NULL as the entry to xa_alloc() fail to reserve the ID?

Under XArray semantics, storing a NULL entry marks the slot as free, meaning
concurrent calls to sdxi_cxt_new() might be allocated the exact same ID and
overwrite each other.

If this is fixed by storing a dummy entry, will the WARN_ON() in
sdxi_cxt_id_assign() below incorrectly trigger on every assignment, since
xa_store() returns the previous entry instead of NULL?

> +	};
> +}
[ ... ]
> +/*
> + * Transfer ownership of the id to the context object, recording the
> + * context pointer in the device's client_cxt xarray. sdxi_cxt_free()
> + * is responsible for releasing the id from now on.
> + */
> +static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id =
*cxt_id)
> +{
> +	/* We reserved the space in the constructor so this should not fail. */
> +	WARN_ON(xa_store(&cxt_id->sdxi->client_cxts,
> +			 cxt_id->index, cxt, GFP_KERNEL));
> +	cxt->id =3D cxt_id->index;
> +	cxt_id->index =3D 0;
> +}
> +
> +/*
> + * Allocate a context for in-kernel use. Starting the context is the
> + * caller's responsibility.
> + */
> +struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
> +{
> +	/*
> +	 * Ensure an ID is available before allocating memory for the
> +	 * context and its control structures.
> +	 */
> +	CLASS(sdxi_cxt_id, id)(sdxi);
> +	if (!sdxi_cxt_id_valid(&id))
> +		return NULL;
> +
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) =3D sdxi_alloc_cxt(sdxi);
> +	if (!cxt)
> +		return NULL;
> +
> +	sdxi_cxt_id_assign(cxt, &id);

Is it safe to publish the context in the xarray here before it is fully
initialized?

If a lockless reader traverses the xarray, could it fetch this partially
initialized context?

Also, if sdxi_publish_cxt() below fails, the cleanup handler will free the
context, potentially exposing a freed pointer in the xarray.

> +
> +	cxt->db =3D sdxi->dbs + cxt->id * sdxi->db_stride;
> +
> +	if (sdxi_publish_cxt(cxt))
> +		return NULL;
> +
> +	return_ptr(cxt);
> +}
[ ... ]
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 8e621875b10bd..cc289b271ae22 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -338,6 +340,12 @@ int sdxi_register(struct device *dev, const struct s=
dxi_bus_ops *ops)
>  void sdxi_unregister(struct device *dev)
>  {
>  	struct sdxi_dev *sdxi =3D dev_get_drvdata(dev);
> +	struct sdxi_cxt *cxt;
> +	unsigned long index;
> +
> +	xa_for_each(&sdxi->client_cxts, index, cxt)
> +		sdxi_cxt_exit(cxt);

Could this lockless xa_for_each() iteration race with a concurrent deletion?

Since xa_for_each() drops the RCU read lock internally for the loop body and
sdxi_free_cxt() destroys the context synchronously using kfree(), it seems a
concurrent call to sdxi_cxt_exit() could free the context while this loop is
processing it.

Additionally, since sdxi_cxt_new() explicitly transfers ownership to the
caller, does forcefully freeing the client contexts here violate that
ownership contract?

When the DMA provider eventually cleans up its channels after
sdxi_unregister() completes, it might call sdxi_cxt_exit() on the
already-freed context pointers.

> +	xa_destroy(&sdxi->client_cxts);
> =20
>  	sdxi_dev_stop(sdxi);

By tearing down the contexts before sdxi_dev_stop() halts the hardware,
could this allow the active hardware to continue writing to the freed conte=
xt
DMA memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D11


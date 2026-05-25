Return-Path: <dmaengine+bounces-10840-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGJXAar6E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10840-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:30:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330F5C728A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2027300351D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D83AC0CB;
	Mon, 25 May 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxSTqck5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF13AC0FD;
	Mon, 25 May 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694244; cv=none; b=iE9uws4tQKCxhd/BblUYQubJ+Dh4OMOXAV2Ix1edZ+hJvD4Rvb7ZrG7RsAuc8apReYUJdwjRJRk51+fh80CTPP8XKVFi5x5O/EVXE9kK7iyq1zhRb/CNLyytUaxVQyd4j9ONEgbmcIWdbNmyys9rqf/XVZM1f+3GWEXcUcW94Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694244; c=relaxed/simple;
	bh=It8iZuM6QP7I6MwV9Ai3AdUjJEiAZ1wpyqKVZaW76yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A49XG+b1iKTHdzaB3LGbywl/8AHNw5OyrS09Q3ZkLh1ISmHfuj9PRYSwBdwX0zKVYqDHimhTgtvX4MLBX2u6TlQyxw7l30a9h+IFod/Aul+1zYpjm6p05rP23R7a5W/d2Pd117Z1YmzTwYuQ8lh4M/8GR/JYEAr2OITAYZoKGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxSTqck5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD771F000E9;
	Mon, 25 May 2026 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779694243;
	bh=H/GJXMbIrHfp+EV5iYznnCqyd/ERlgXKCLBbiVMKu1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LxSTqck5DjG47msvzDgb4i41t/eYv5iLLU+QtWBGUSvR9/b552UO3PgIaxuO7p69N
	 NnSUug6vsqjPFHKzSEx0iQnO6aspKfYT9Qa4Ht261lf8oCzaEl1d0eTAaZq+mtC6WT
	 47pB+i+Y8tkp5AtnJUlELoYxPhQLEkPaonZRBz8CvFUnv+A8ws+1ncf40ZDZPm21k7
	 Zqmyap6z60P5i+l6t9SrtPpijvKaG06M286Zzef83o7s73wdThGKBAe3OEzpdRbrK3
	 uuxQ05/dWr5u0drqnN7+wOwQncxTiv+0Uw7FpZBNoxbvnsmLuTSU2zZBUxkwCLpKVl
	 kvjME/eguSFhg==
Message-ID: <cd75b429-3259-456d-9551-272fe32780c0@kernel.org>
Date: Mon, 25 May 2026 10:30:37 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: sashiko review (Re: [PATCH v5 13/17] dmaengine: sh: rz-dmac: Add
 runtime PM support)
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, fabrizio.castro.jz@renesas.com,
 kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260512121219.216159-14-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10840-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7330F5C728A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 >commit 537bc713380d43d1dfa0d61269accb53a834436d
 >Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 >dmaengine: sh: rz-dmac: Add runtime PM support
 >This commit protects driver exposed APIs with runtime PM suspend/resume
 >calls before accessing HW registers. The changes avoid accessing HW
 >registers after a failed system suspend leaves the runtime PM state
 >improperly reinitialized, preparing the driver for suspend-to-RAM support.
 >> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
 >> index d6ad070be705c..df91657fd5e3d 100644
 >> --- a/drivers/dma/sh/rz-dmac.c
 >> +++ b/drivers/dma/sh/rz-dmac.c
 >> @@ -488,7 +488,15 @@ static void rz_dmac_prepare_descs_for_cyclic(struct 
rz_dmac_chan *channel)
 >>
 >>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 >>  {
 >> +    struct dma_chan *ch = &chan->vc.chan;
 >> +    struct rz_dmac *dmac = to_rz_dmac(ch->device);
 >>      struct virt_dma_desc *vd;
 >> +    int ret;
 >> +
 >> +    PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
 >> +    ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 >> +    if (ret)
 >> +            return;
 >Does this return early without pulling the descriptor from the queue? If PM
 >acquisition fails, it seems the descriptor is left permanently stranded on the
 >virtual channel's issued list, and the channel queue could silently stall.

The rz_dmac_xfer_desc() is called dma_async_issue_pending() or after each 
descriptor is completed. The documentation of dma_async_issue_pending states:

/**
  * dma_async_issue_pending - flush pending transactions to HW
  * @chan: target DMA channel
  *
  * This allows drivers to push copies to HW in batches,
  * reducing MMIO writes where possible.
  */

Thus, I'm not sure we should free the descriptors on this path. I think that's 
the scope of ->device_terminate_all() and ->device_free_chan_resources()

 >[ ... ]
 >> @@ -549,6 +557,12 @@ static void rz_dmac_free_chan_resources(struct dma_chan 
*chan)
 >>      struct rz_dmac *dmac = to_rz_dmac(chan->device);
 >>      struct rz_dmac_desc *desc, *_desc;
 >>      unsigned long flags;
 >> +    int ret;
 >> +
 >> +    PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
 >> +    ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 >> +    if (ret)
 >> +            return;
 >If the runtime PM acquisition fails, does returning early bypass all subsequent
 >software state cleanup like vchan_free_chan_resources() and freeing allocated
 >DMA descriptors? Even if the hardware cannot be accessed, shouldn't the
 >software-allocated resources still be freed to avoid memory leaks?

I'll adjust it like this.

 >[ ... ]
 >> @@ -697,8 +711,15 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, 
dma_addr_t buf_addr,
 >>  static int rz_dmac_terminate_all(struct dma_chan *chan)
 >>  {
 >>      struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 >> +    struct rz_dmac *dmac = to_rz_dmac(chan->device);
 >>      unsigned long flags;
 >>      LIST_HEAD(head);
 >> +    int ret;
 >> +
 >> +    PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
 >> +    ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 >> +    if (ret)
 >> +            return ret;
 >Similarly, does returning early here skip clearing the virt-dma lists? Failing
 >to do so could leave orphaned descriptors active, which might lead to
 >use-after-free issues when the client subsequently frees its DMA buffers.

I'll adjust it.

 >[ ... ]
 >> @@ -909,8 +935,15 @@ static enum dma_status rz_dmac_tx_status(struct 
dma_chan *chan,
 >>                                       struct dma_tx_state *txstate)
 >>  {
 >>      struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 >> +    struct rz_dmac *dmac = to_rz_dmac(chan->device);
 >>      enum dma_status status;
 >>      u32 residue;
 >> +    int ret;
 >> +
 >> +    PM_RUNTIME_ACQUIRE_IF_ENABLED(dmac->dev, pm);
 >> +    ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 >> +    if (ret)
 >> +            return ret;
 >Is it valid to return a negative integer error code directly as an
 >enum dma_status? Client drivers might check the status against specific
 >enumeration constants like DMA_ERROR, and could fail to recognize this
 >raw error code.

Indeed, I'll adjust it.

 >Also, does this add unnecessary PM locking overhead on the hot path for
 >software-only status queries? Since dma_cookie_status() might resolve the
 >status entirely in software, and hardware residue is only queried if the
 >status is DMA_IN_PROGRESS and txstate is not NULL, could the PM acquisition
 >be deferred until after verifying that reading the hardware residue is
 >actually necessary?

This will be adjusted as well.


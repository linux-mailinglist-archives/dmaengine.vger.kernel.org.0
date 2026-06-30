Return-Path: <dmaengine+bounces-11884-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LAqhFoSwQ2q+fAoAu9opvQ
	(envelope-from <dmaengine+bounces-11884-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:03:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FA6E3F1A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 14:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bP5lOibs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11884-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11884-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D17F531CCF3D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAFF3FB7F6;
	Tue, 30 Jun 2026 11:34:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD73672B3;
	Tue, 30 Jun 2026 11:34:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819258; cv=none; b=Bhnir5Kf6BhCmIAGGT4l+t9GmKezj+IJfu1rtjfPoim2cL9rgGeR2TqFNwLrH+Ov7b2o9ISPGf23g9LPAYNJ2GBgYvgz7PoGjr/vGpHTYf2vgMeS8vMFJZEvXuXF25XWqSDkTVxe7mp0C2vw1xw31wWrzay2KqVzBifs0HvXkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819258; c=relaxed/simple;
	bh=QE+pM2IqrECD7KfCNKfPvP1EP2u2C0wIHXBqh1bX8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8GlO8g6JEQ+44+FaIBtFsNYuDDXivAoabGfyI7Y7FxfnJ3wn/G153MnEFGp8axyjDvOaSuymw/m6+KC0Z2+92n8j/xKkLhAbtO0tFcnJo/PxWS3G360ZZeIsWkDxeuUNWG0ks41XMEUX1oQ/xxqmg52vplPt8KGsrWo3rbI1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP5lOibs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1070A1F000E9;
	Tue, 30 Jun 2026 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819256;
	bh=9ewpUf4cNOvt9d0UUmC8hZbJDc1XmG2sBxDSs3hf5Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bP5lOibsywM0z0kYIuPgcMctuls7Wc8cuV6rpo6h9xoL/qFdCtDV0QEf4OnT3goU8
	 aX1GV+F4rgt7BKiMrSznJXKmXepiYPjrpAhF46V1wBdIz5u1cdbj01xfVPSHTW+1Nk
	 XCcIbBnYP/s4mPrXGyDuzsn8hNZc04w59T5aeLUHR7HEWZz+ABa8r+drFZMfkaEai1
	 3UXRtAhHr1ecB8z4Tt4ikaS2ifKOua2ZDJugtltbh928rUgjA0H4nHDHr0h/Wu82gA
	 exuVqh7N4OZlmPeWYJ9TjyH5pfBPJXesCzc3tDo09Ok4QlFkW+ny5/MZzL+uFGhy8m
	 FLacHYjHZC+2w==
Date: Tue, 30 Jun 2026 17:04:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, mripard@kernel.org, arnd@arndb.de,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhongling0719@126.com, Frank Li <Frank.li@oss.nxp.com>
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Message-ID: <akOptOSkd7o0Vivk@vaman>
References: <20260618020609.1155962-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618020609.1155962-1-zenghongling@kylinos.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:Frank.li@oss.nxp.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11884-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com,oss.nxp.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F6FA6E3F1A

On 18-06-26, 10:06, Hongling Zeng wrote:
> When terminating DMA transfers, active descriptors are not properly
> reclaimed. Only cyclic descriptors were handled, leaving non-cyclic
> descriptors and their LLI chains to be permanently leaked.
> 
> Fix by using vchan_terminate_vdesc() which handles both cyclic and
> non-cyclic descriptors by adding them to desc_terminated queue for
> proper cleanup.
> 
> Add pchan->desc != pchan->done check to prevent double-adding completed
> descriptors, which would corrupt the list.

Thanks for the patch. Please consider revising the subject which should
describe the changes in the patch and not the fix/issue.

A better one would be "fix reclaim descriptors while terminating"

> 
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Suggested-by: Frank Li <Frank.li@oss.nxp.com>
> 
> ---
>  Change in v2;
>  -Add pchan->desc != pchan->done check to prevent race condition
>   where completed descriptors could be double-added to desc_completed
>   list, causing list corruption
> ---
>  Change in v3:
>  -Fix by using vchan_terminate_vdesc() as suggested by Frank Li
> ---
>  Change in v4:
>  -Correct the commit message
> ---
>  drivers/dma/sun6i-dma.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7a79f346250a..134ae840f176 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -946,16 +946,13 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>  
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>  
> -	if (vchan->cyclic) {
> -		vchan->cyclic = false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd = &pchan->desc->vd;
> -			struct virt_dma_chan *vc = &vchan->vc;
> -
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +	if (pchan && pchan->desc && pchan->desc != pchan->done) {
> +		struct virt_dma_desc *vd = &pchan->desc->vd;
> +		
> +		vchan_terminate_vdesc(vd);
>  	}
>  
> +	vchan->cyclic = false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
>  
>  	if (pchan) {
> -- 
> 2.25.1

-- 
~Vinod


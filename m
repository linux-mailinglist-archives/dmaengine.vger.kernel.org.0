Return-Path: <dmaengine+bounces-11769-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aZ2HKGf5O2p/hAgAu9opvQ
	(envelope-from <dmaengine+bounces-11769-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 17:36:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3696BFB2D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 17:36:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dkVTd9sq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11769-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11769-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E5D300BCAD
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E537C924;
	Wed, 24 Jun 2026 15:32:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB230649C
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 15:32:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315173; cv=none; b=bugOzPQFDinFI0Z+95q3hEATHPDteeFaSMH8WGjQ/A/FykNBIewUeIsAPod3tWF9F6IjVkNDzbyu8zFUD4LOK7bhUW8VrXXCsuEm+bInu9EERe4SFBb0Sl03j1ljgrhD7JJGdZ3iYmT0V+doPibMQri+RAPYCdjqDAC82n2ySTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315173; c=relaxed/simple;
	bh=zmaMjgv40gr9Cbe4PP1/xmSyogH/GhfILjqn5Z331oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4jExEXXpHzhJ8qRKRlXLpB5iIlP5gqKA6SdSunyOr80w6Nagy1FtQ4oBmm5C3mq6aUF39dPOf6ciUHtxh0lcu2iEdm862Otee+O3dowe8P16V3apPUXrUlRjV3t6rBYrNA9PUfEquYii+rPfthjFgv2HXiPSvVUD8NGtnDg7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkVTd9sq; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eeea039ebso767889f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782315171; x=1782919971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezPfHam7P5uRLw1NJIu4UguQk94Etz5IiSadwTXLKSc=;
        b=dkVTd9sqb4bi34C+k5oIGqm8UsEVy4ygNm6mVnAcsttnDzcYOKef4buJhnP3mAVJ0U
         X5seLZszpe0AeMVhfjAndjvez0yLyzyRMesY9mzp7pJPOF28D7dl3COJNJ8xWkcVJCZ2
         ptr8SRL3kYU+xqF/VG2Afll0gWIs5TKGK2qXA+pZhz1sWxasx9xTZKYacPxeqttLbW9/
         8O00R8wY8a7fZ9d8bCUamVfHp6SRKGMEceUq26891N67CfljPB4GF0YwTmP1TSOaXNU2
         zvr55jKNS0U8Vj5B+E3hCwW+KRZNitA8mrTknuv1gXHCqioHYcbxx4xpjfgGFK+POXYh
         2ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315171; x=1782919971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezPfHam7P5uRLw1NJIu4UguQk94Etz5IiSadwTXLKSc=;
        b=AaMzjdaJJL/1bOeK5BNQv3LTG6JcF5Y20RRjkFuATyMjKtnmFTFcjVq2v/iBasmLt3
         CQCWK9hFmIn2+VhUuOt2nrjfwaza/9IopEpUX1xzJa1pjmyeOYQP7k46esg15yoWYJ+5
         jk2/FHe9jUod3+uD2p77u9TUJEDL92gN2wzKokTQBiZWXd2Tq9eHxBugAf3+bJXoaOfe
         QzCFOvJ92O5umu4Sns0qcq0oUVRI4IFu0ZM8CpbcIO0K2LQm14y8tDJlLh16rn5aE9Sc
         qJC7o3SxS8MUCiLtE1z4EGdR9xNdey34umgM/vTLkwN/wrJt87qw7Dst4Z4Sn69tJlt5
         7HVQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCo3toZihtiah2Lzc6C2H/547Vh+VaqhXEW+ZX0Ly9RgsvAIFomEda8VLCCxkL5FIkVNtOgDTREGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUkpX3e0dZKrNOH87kBknuf9S19VlU52OY7K15AeqUwwJ6XSS
	MzmwQX852hsQmwTsh1bXKfNuWZzYN5PaicpmVY1Ye1axMElrRbvTDdDU
X-Gm-Gg: AfdE7ckUKx4VVMYSjKVfd1DtOBBTvJvDD1zyaI7CEBBc25FnUp22azMw4k2hzBXD/FS
	hrBAbEmn90bdKuOio2P0lbqCZOWEQiQHSHlMk10Y3QYwgvp2HErFaVjQlSb0XFe/7vYFn/kLk2w
	BWfJsTwHajOQhAkuf0C8Rg6AuA6kiVy4EbpOmZahGTkcL+1RAo9GWqR0nwJu9MbvhkpOkE470vV
	Kddz3sLxRGrtRqWnmPr23lAQyy1aYewoXKZ+bkRNX9a6SvP0dmhySfxNKkmBGVcD5YN4KXvBVe7
	DH4j1Uh5J7YPP1ZvkkliFCqiZRDxMiNMpIKWPwJVSyvi5pVaidGofyVZ0m/d0Agvs0rYBZX0qMX
	BrQPFf0FHjywhBRJtHj/Y0rmJN8rr4i6VbHC/TB8vCtvJPKe9sBecfnOsmoDUrVsspgFqhLtuYy
	U5izrX
X-Received: by 2002:a05:6000:4305:b0:46c:f1be:2f9e with SMTP id ffacd0b85a97d-46cf1be307bmr2219481f8f.38.1782315170532;
        Wed, 24 Jun 2026 08:32:50 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caa798f43sm3963188f8f.8.2026.06.24.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:32:50 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:33:53 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, nuno.sa@analog.com, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajv4NVSmSR_dn9CJ@nsa>
References: <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
 <ajpfmQ6JID5rHLMF@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpfmQ6JID5rHLMF@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11769-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:Frank.li@oss.nxp.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nsa:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE3696BFB2D

On Tue, Jun 23, 2026 at 01:27:37PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> > On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > If support 4Byte, it native supportted any N*4Byte.
> > > 
> > > So needn't bit mask to indicate all support bytes.
> > 
> > > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > > >
> > > > > If memory have requirement for 32bytes, typical cache line length for
> > > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > > >
> > > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > > >
> > > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > > there... The code seems to use the dma bus width to match against PCM
> > > > formats supported and filter only the ones we can support (per dma cap).
> > > 
> > > if cap is one byte, it should support 8, 16, 24, 32, 64
> > > if cap is two byte, it should support 16, 32, 64
> > > if cap is 4 byte,  it only support 32 and 64.
> > 
> > Well, Now I see your point but not exactly. Because we do have
> > 
> > DMA_SLAVE_BUSWIDTH_3_BYTES
> > 
> > and it might be used by the pcm_dmaengine code,
> > 
> > There are also some controllers that set it. But it looks like all that
> > set it also set 1byte.
> 
> But this might be not true for all HW in the world. In previous reply I made
> a comparison with MMIO accesses where not all HW that needs 1-byte read can
> cope with that. If there is some proof that this is the case when 1-byte
> DMA bus implies 3-bytes (or other odd number), I would like to see it.

True. I'm also not too keen in making the above assumption and have no
proof that it will work for the controllers we support.

- Nuno Sá

> 
> > So your suggestion might still hold and work but I'm not too convinced
> > that having the array complicates things that bad when compared with the
> > risk of breaking existing code.
> 
> > > Needn't mask each bit.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


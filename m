Return-Path: <dmaengine+bounces-11565-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N5cYFDKBMWp+lAUAu9opvQ
	(envelope-from <dmaengine+bounces-11565-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 19:00:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B33692A6D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 19:00:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YyJqEFza;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11565-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11565-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E4633040318
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A19478E41;
	Tue, 16 Jun 2026 16:59:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75F466B4B
	for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 16:59:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629171; cv=none; b=uY5Y7hBwkC+qUNIQVTpdb4zvTIG2IRgQacqsH5YOBIkCDolpRmeeRIvvWSKJk5hLnhy5VWQ9iGzYte1jnIW9GuI8nek88vZVOu4zYrgMAiGL/zAVbXK6Z7V30yn/W8WC0/N0Kii8tb2KBWaBDv10R/DE0yplCAw0EOJb81XP5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629171; c=relaxed/simple;
	bh=RmlQGoLfci9osWvKrydhp2LNMfnznzpLPtUIkwc+vAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPpR8igMSYAY6lsZrN369OYSwCKlWI1k8NXZw+v6NrVBD1HR29yWmdREYdHDIfoVRD7QUel3T9pJ7803z2sQcJ0tcj8pI448iKvYeeLDsiGolBrYzJNxhK4ks+d9nZmzW2O5q+Ujrt4tBrz/LVHwXxCZlW/yckNlJCsZb00Yhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyJqEFza; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so31528725e9.0
        for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781629168; x=1782233968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2MzvP3M/Lvdf+YQEoRrr/63qV3jwcTxyyvjTUVpfjs=;
        b=YyJqEFzaO1Bd1JhN7ivVOdZWE6ev203ngAw7vIvDR8IRYxVs/48fynoN+FjcigD8kI
         Ho2Bz1/Kvic4fJrqs7qAXu5Zd20NStzqfxiiK+0lzGXnYt8XD0g5sbfJV0WOHWP4zZEB
         QScwKebx2RmkADzF6m/nVFfZ3VaSuMtKnzc7/VYWu26wzp5q8oaI8rVJs/unbRaa+fwZ
         xQSxbt1J+M0egszmcXfj1XR4GXkh3E8tzypULDqqi1zNScHfqIifbB/goCao2fFCqy7D
         Lhq+BuHVtkX4XRQWKqDthvtb4MrKEIztWqzUbdP0SNrkfavezCXBzIebqSDur25hPF4I
         2+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629168; x=1782233968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2MzvP3M/Lvdf+YQEoRrr/63qV3jwcTxyyvjTUVpfjs=;
        b=NtNZRON6AUCBcUUM/2v8gpLRSLLEqRh/hx/t7Tns22ye3Z9y4kJU5rTopZF3oCJPrY
         FI6iUaQlM0U9YfggDYQwxRyd3kUbsCXrlGSm+LwX9V1+0DAxoRe47Uij2encEBxxmewz
         PhUUAxFC6LbM/0EPuMsHgdcDP+qeCiRzYb/DSWSgqTPfQXWwJd7Cxtjp7srTXX4C8wy6
         5+dGrrubbB1ZA6XYnVhps77xFLJed97iOlzT4hyxNCY1I8ucs9yGKgSUtC7++kIyxsOU
         gHsQGY0m+djUE7/ZBExtDwORUq2qAu+X88yC/dtsEzRaCMmUcc3mE5c+2LFE7fKzEC3g
         52Lw==
X-Gm-Message-State: AOJu0Ywimy3mEZCR7Nq6eJ4TDQ3ydpUtZUO1YtUuncWQZjZIz5P4DFvK
	N0NnvzxximdRaWNxFutSffCNR9f4nH491gVjV31wJKz2ql5satF8cPNj
X-Gm-Gg: Acq92OHZtC1y8ji+hnYYLfYs3IYSs+bTQD2zz/2in9GhlwEz+mVajLkvSyKugFl6VID
	FfjvJER7Eu/AF1HsT2Ue8ktRHx3/Sd6iDYO37xioC4odht3XMUMeMs8V6rkCl3VX5HrCGcwdguc
	94thHESh9ObneKYmQoBMt1ures2luZgYrf3Kr/GWqpIbrgdmkjnq/NFlxc2Nd9+aC05beMyxCv/
	+IP0zGRSLNJGr9ILwAejr2vUMuZ4pF8nNa3dG/iTT6aUsw1Lw7Uuhlw8NuNz2o0bBt93CiX9Rwo
	zwiaoiU/ytdlpS13bV8MUmeTDUVhVlXeTUpkqz8HivHSmfjazxEEYn0oYxbePw6kSbRI5LROI5C
	33vq9xaFYoB+6yufWKdOvrmVkCEyLKPe098N5Jh7yVYysYtXtKjGveAqR54XCfK1kzlRZ/pcs2I
	w+wZQH7lQW+sw2hCGO00anKsav7SErGZVxpsTSG5zOL6Fd5pVaH/ZYnSXDTQ7WVkzsVQRh0vgXS
	6+ZT1/wQs+qKYHX4BtbWghbeRHnZiGRhVGC
X-Received: by 2002:a05:600c:3b02:b0:490:6237:521d with SMTP id 5b1f17b1804b1-492333a8e2cmr6254255e9.13.1781629167571;
        Tue, 16 Jun 2026 09:59:27 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-99-120-gprs.simobil.net. [46.122.99.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa890d8sm103698875e9.10.2026.06.16.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:59:27 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject:
 Re: [PATCH v2] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Date: Tue, 16 Jun 2026 18:59:24 +0200
Message-ID: <9Stif-p9RWiht_4RVVcSpg@gmail.com>
In-Reply-To: <20260616060449.42225-1-zenghongling@kylinos.cn>
References: <20260616060449.42225-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11565-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com,kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jernejskrabec@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jernejskrabec@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28B33692A6D

Dne torek, 16. junij 2026 ob 08:04:49 Srednjeevropski poletni =C4=8Das je H=
ongling Zeng napisal(a):
> When terminating a non-cyclic DMA transfer, the active descriptor
> is not properly reclaimed. The descriptor is removed from the
> desc_issued list in sun6i_dma_start_desc(), but in
> sun6i_dma_terminate_all(), only cyclic transfer descriptors are
> added to the desc_completed list before cleanup.
>=20
> For non-cyclic transfers, pchan->desc is set to NULL without first
> adding the descriptor back to a list that vchan_get_all_descriptors()
> can collect. This causes the descriptor and its associated LLI chain
> to be permanently leaked.
>=20
> Fix by ensuring both cyclic and non-cyclic active descriptors are
> added to the desc_completed list before setting pchan->desc to NULL.
>=20
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 =
DMA controller")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> ---
>  Change in v2;
>  -Add pchan->desc !=3D pchan->done check to prevent race condition
>   where completed descriptors could be double-added to desc_completed
>   list, causing list corruption
> ---
>  drivers/dma/sun6i-dma.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7a79f346250a..12d038ef5f2e 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -946,16 +946,14 @@ static int sun6i_dma_terminate_all(struct dma_chan =
*chan)
> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
> =20
> -	if (vchan->cyclic) {
> -		vchan->cyclic =3D false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd =3D &pchan->desc->vd;
> -			struct virt_dma_chan *vc =3D &vchan->vc;
> +	if (pchan && pchan->desc && pchan->desc !=3D pchan->done) {
> +		struct virt_dma_desc *vd =3D &pchan->desc->vd;
> +		struct virt_dma_chan *vc =3D &vchan->vc;
> =20
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		list_add_tail(&vd->node, &vc->desc_completed);
>  	}
> =20
> +	vchan->cyclic =3D false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
> =20
>  	if (pchan) {
>=20






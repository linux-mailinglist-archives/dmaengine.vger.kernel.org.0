Return-Path: <dmaengine+bounces-11500-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 43RGJ/IKLWpxZgQAu9opvQ
	(envelope-from <dmaengine+bounces-11500-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 09:46:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5C67E04B
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 09:46:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L1UrkO5N;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11500-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11500-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F60303DACD
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2026 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F393C0A09;
	Sat, 13 Jun 2026 07:46:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A361BF33
	for <dmaengine@vger.kernel.org>; Sat, 13 Jun 2026 07:46:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336787; cv=none; b=fmPWKx3Zs9LcNbdJg72pAzeDMC6XSYeTCLHtE/vqpWQANbbmdsPDB3XaNYBXENZj76nlqC4RM5dZaz6flcCuzLNbXdDfRgRFh3q+pxy8oaDJLJW1FZYm1r+jJCHN0LgxSRKidGoTD+VBF1MfSC5trsFhsF7AdXgBCNegBHrCWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336787; c=relaxed/simple;
	bh=7fVG15Gm7oG900vnZ44bPuyYJ9HGjnOY0gNg7QGMuqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAtKbKqT5tLusmg27LqbCkJXHdvQqkHU4vDgiHwhGjgA7SjQjVEaAeydM2jGPEErPhRhvI++tpnw3EFOW2EKMUyQyCewSVY5wshZYJZemS/rOMwQY9Ksqjh2WK4Ifuu0w+vLrYHFzmGH7E51JABHtMlHrvfL6lEIrfn6Dz8bQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1UrkO5N; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b613a17bso14467435e9.3
        for <dmaengine@vger.kernel.org>; Sat, 13 Jun 2026 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781336784; x=1781941584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veSLkLuVXjwdrZzfCCj4w9cK+dyeH9xMaJHceYyp2QA=;
        b=L1UrkO5NzTa+0jNk9cs6ay6GeuKk2McwRuESgrnCKN/wE1Ws/gWYewajvCqYz56zBr
         kt0z3o1rPTkDdPpp+e7OgZLk3LxAL9qnRhFiSDhHPaJHrImix1DOTD6WYeasPcAzgII7
         l2rO/4xAMVxFRGAnMbhIf2fR+IEdOgnNi3n2wjVwn3Ckj3qLLW9IvhMpio78dXJQJYFR
         +3b4syiGULljDq7emNO0T1XkUI1pMbNPwCKR8VkJBOBMq2lKw0zvWsJfdeE2NAtyTX9N
         Gj9Nw7JhPN1cZxvjXTYmzK6qbgXazIO5egdISkRM8W6JSDGB8Lgj3Q79i2PCRL3KHs6l
         8QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781336784; x=1781941584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veSLkLuVXjwdrZzfCCj4w9cK+dyeH9xMaJHceYyp2QA=;
        b=foJCkbcMYy5jOA04BdanhE3ZxVwE1axcSTe0GhJW9bAAtdYB4TDcr2oTUoUja0NCzW
         /ukNBKbbz1l/pvDTZziIsBX+69T5a0zLGWs1eQvUg6YKN7NY4fEiCz+uhNdilCtE7adF
         CsdifvNAYuVTdTAT+cm6h0AWPtLNLPFlObiZh3OFQ65TNivbOhACwqplOpMlv+mV6tnz
         bPQcFuSedfaSbOWr18S3v90bxtEr8CP7RlpXFePXwkrFlYFEafkKT5V0WYnD8vWXf9Wq
         4VGNSTh+d6XvLQYlnA1X1sChbqMd2ECLmfAwq82rKv63fMZArNsmGZGiL2gTVZdRiNPc
         KmjA==
X-Gm-Message-State: AOJu0YxKpqTxdsf5ExWtYbVA2HIfbx0gbv3E1V3Ssiqkx1l5e6HDo/kf
	C4vkFizpvUhJpdEE8LzpXr03oifs0VroLtYL57B6CEC9hswz0bWd1e4u
X-Gm-Gg: Acq92OHZDR1Hss86nlkK3Cc1mKZJ5sLcRDcZQMEWMEcw4M5vmBr7smABYLhHuw2krHt
	M5cDy1RTNjAjn1Dqq47I4LWkafGlBwa7qczvHrs0saRrMwCueF/q68REUn0+7+gvYep5mvBIFWX
	wR49rmsL1FzWCtc/3oeWIKI8MUOsq4FOWluczcLk9CpFunHY/0YAhEI9C6kNs1S9hpE4Y6XrchS
	5yRSeLHPDJNEvlC2hdXiiUnkpx0JQ9+S6zLQZCbiWO6MqDi3ncEiOEtKxwWLxZZ9izPFE/m/v0j
	uxHsbFK1WaaEkvTrgLIe4w/hP4Q8jAdAORr7D4X1zy+npJbzXfTieGOfj4gqPlDb2pqNA1pxEke
	IrPFPbf9NptXW/YAIycmXWQNlL/qxuvXfkX6OT3kSoxYKUL8qXUIcJEDOoBZSq5zspgIwOwbQDY
	VvHgZJodFl5qiAuifJ6zem1FvwUkVmuoCXTmkjbPgUnTG7
X-Received: by 2002:a05:600c:3548:b0:490:e196:e8e3 with SMTP id 5b1f17b1804b1-490ec501a29mr82066385e9.18.1781336783742;
        Sat, 13 Jun 2026 00:46:23 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm13078689f8f.14.2026.06.13.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 00:46:23 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject:
 Re: [PATCH] dmaengine: sun6i-dma: Fix use-after-free in error handling paths
Date: Sat, 13 Jun 2026 09:46:19 +0200
Message-ID: <CyWPMXMZRBuYyL_Lpl2t_Q@gmail.com>
In-Reply-To: <20260611063631.96566-1-zenghongling@kylinos.cn>
References: <20260611063631.96566-1-zenghongling@kylinos.cn>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11500-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com,kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jernejskrabec@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jernejskrabec@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33A5C67E04B

Dne =C4=8Detrtek, 11. junij 2026 ob 08:36:31 Srednjeevropski poletni =C4=8D=
as je Hongling Zeng napisal(a):
> In error handling paths, the for loop frees v_lli in the loop body,
> then accesses v_lli->v_lli_next and v_lli->p_lli_next in the
> increment expression, which is use-after-free.
>=20
> Fix by saving both the next virtual and physical pointers before
> freeing the current node.
>=20
> Fixes: 555859308723 ("dmaengine: Add driver for Allwinner sun6i DMA")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  drivers/dma/sun6i-dma.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..eb9c4ae87ac8 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -788,9 +788,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> +	p_lli =3D txd->p_lli;
> +	v_lli =3D txd->v_lli;
> +	while (v_lli) {
> +		struct sun6i_dma_lli *next_v_lli =3D v_lli->v_lli_next;
> +		dma_addr_t next_p_lli =3D v_lli->p_lli_next;
>  		dma_pool_free(sdev->pool, v_lli, p_lli);
> +		v_lli =3D next_v_lli;
> +		p_lli =3D next_p_lli;
> +	}
>  	kfree(txd);
>  	return NULL;
>  }
> @@ -869,9 +875,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_dma_cyclic(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> +	p_lli =3D txd->p_lli;
> +	v_lli =3D txd->v_lli;
> +	while (v_lli) {
> +		struct sun6i_dma_lli *next_v_lli =3D v_lli->v_lli_next;
> +		dma_addr_t next_p_lli =3D v_lli->p_lli_next;
>  		dma_pool_free(sdev->pool, v_lli, p_lli);
> +		v_lli =3D next_v_lli;
> +		p_lli =3D next_p_lli;
> +	}
>  	kfree(txd);
>  	return NULL;
>  }
>=20

This is certainly a valid fix, but it's replicating what sun6i_dma_free_des=
c()
is already doing. It would be better to split code to accept struct sun6i_d=
esc
*txd parameter and call that instead from all places.

Best regards,
Jernej




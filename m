Return-Path: <dmaengine+bounces-11521-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y9YzKMEXMGqFNQUAu9opvQ
	(envelope-from <dmaengine+bounces-11521-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:18:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C368791C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CMBCE2AH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11521-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11521-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13EA31815BB
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C35B4014A9;
	Mon, 15 Jun 2026 15:13:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555E401495
	for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 15:13:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536435; cv=none; b=oclczxkJjMmg3zXxOFNHFMWVh40Ttyd9flccqh/0GQf2BCP28rkHeu0VeLx1aexps1qjQa63gJV55OH+K+fV0nPYLTrciT9y1VVmQ/6jDnRHj5Bn6VDdKaXIy9eRfWknxiI29y3x6xUCmP69H5EOPZgwDiLhKPadPUPEvD+Yk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536435; c=relaxed/simple;
	bh=D4bpvPbdM+wRVQt1hbGIs82yUi2P+/2hMfI01v/vvlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixXlDhs/p7GDy1riiYSEwfxFLVK8BasmXV2drct9tCwCQB0AacSfcYk4xdt17DpEYl+Zu9JglPA9XPeE4Ml7QjguQLAnVXNt+2Dd4wYEONII1HBMs4PBdJ831+fqLUV0cEPGb76NG/WnnxtZodzPhQ+scZboZskLXHuzMHEz108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMBCE2AH; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so36033175e9.1
        for <dmaengine@vger.kernel.org>; Mon, 15 Jun 2026 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536432; x=1782141232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOu5uWEEG32depN6lamngfrPC9NH0+eC4cO0/sZPFE0=;
        b=CMBCE2AHpu3mvZyuyKOyUHaHAmZfs78bURmyFLUlctytfYI1iUUr3ucqLk09P8aWef
         o0hqx88yJ0qqRlefzS+hCI6Ajcbk0UJ3IfATtw0EWf5BPLRuZ35iDK77DAHYtV8cQHoW
         C4wXeuvj1DuOU+JRe0ZBux4JksmDT3BKqn/WdfMbJI9gj7PN2oAkfminPPUftVghC3rG
         TgJUYXqhHd9qRj2g+7GKcsIZKcdpSx5Vjs5xlWl324kNxeJhkthKkxzxcJiq4ewrwt/I
         YcmlR0ywRxnFD1fgqaEWSg2PfWyxBBUvOBKQ7pjjbEMhftpteKS+T7AiNLX670fle3aG
         h74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536432; x=1782141232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOu5uWEEG32depN6lamngfrPC9NH0+eC4cO0/sZPFE0=;
        b=cnHpma4JX508QCu+O9CyD3UrBaJpQZOOoD5fi7dI3S1UjFOR+CczZPD75c0eR0NBMj
         1OGjSa4l/C9HcB9hPKTQRsNWw9byaCiJcxF1E/ZOT+ZzimPpyFz9Ju/edYcA5316QzwL
         XlP0liQhhO42crgSDzEOCLL+HWW6HIZZcArFAFbNAxX2ZbMeOJqVJgrvAXWmlC01opBg
         ETCPHkrmirycBd46s1938y9OEYyCMqDkRdVx1wiwC3j3bKb/M618qsW2MN+8Adg5YAuv
         Vcda0U8oGU7y/B7eEyEpiirguIN8+SIMSd8z1XR3c/zR+5VKYc2mYrAKvCOfDOx/0Tzp
         Gw3Q==
X-Gm-Message-State: AOJu0YzNKxGGRDUik5WMtIVT4yrH4bA0z2slihGFi6VhescmdQjsQnyb
	uobjEzsZWH3wm9XoGxK1brSi8O8MoNI0r+rx7AR+ms98v+2UxvSkEOO/
X-Gm-Gg: Acq92OFgHqsI5uHQcBLIViEs+cVUykYtuX8eaUB4fx2Rka4H1QBQs9DJcKYUV0m34QK
	uP41tuWibwFzFRb4zfho+RNO4t+e0bemHzPqVLyBITuIquavPv8Id03QzFj/QDVuCAa0EOou3iS
	QnQj+84jIkJSAQysoDD+Pd36Y6Wca3sZm0o5p+fCL8LcEwS3Da+rebewsH4TaokCa9/EfClQB8u
	gog5lzwVYM10CNrJyU143Dih8dBFGoy38oKZ0DDF1FjWnPEf5w+9meaX6AnS/melQ2urb/4RxMr
	t2BIjLQ3A9vJVkiephmltPVmC9bLglmuwyGMtUD2HZCjFZculZvWjET7wABoPpbR7w5B0MANIg4
	TZWmR8FzMd2M4iGyFDOxw6xSUfLSiO9jJ1rfPBVnbq5Dq+ky62Pnn8mWTP2ZjXWLkP8OeOsTuCZ
	EAZLucIk5pzM0qP/y+gXULaOJ0Mx7AR2yzMEwnEzU6NTPz0OGBRaw9kVXAbsAUYmIpVLnRE6Q0Y
	CQJME2uOrU9Ke08q3mQXkTO92r3DmklMC4m/g==
X-Received: by 2002:a7b:c5cb:0:b0:490:5429:1515 with SMTP id 5b1f17b1804b1-490ea9721c9mr127671085e9.0.1781536431914;
        Mon, 15 Jun 2026 08:13:51 -0700 (PDT)
Received: from jernej-laptop.localnet (92-53-159-70.dynamic.telemach.net. [92.53.159.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d28sm36364453f8f.20.2026.06.15.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:13:51 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject:
 Re: [PATCH v2] dmaengine: sun6i-dma: Fix use-after-free in error handling
 paths
Date: Mon, 15 Jun 2026 17:13:49 +0200
Message-ID: <m3OXKiXNQhuGBq_OoFe6nQ@gmail.com>
In-Reply-To: <20260615022400.13454-1-zenghongling@kylinos.cn>
References: <20260615022400.13454-1-zenghongling@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11521-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F39C368791C

Dne ponedeljek, 15. junij 2026 ob 04:23:59 Srednjeevropski poletni =C4=8Das=
 je Hongling Zeng napisal(a):
> In error handling paths, the for loop frees v_lli in the loop body,
> then accesses v_lli->v_lli_next and v_lli->p_lli_next in the
> increment expression, which is use-after-free.
>=20
> Fix by saving both the next virtual and physical pointers before
> freeing the current node.
>=20
> Fixes: 555859308723 ("dmaengine: Add driver for Allwinner sun6i DMA")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Suggested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> ---
> Changes in v2:
>  -Refactored the fix to avoid code duplication by creating a helper funct=
ion
>   sun6i_dma_free_lli_list() that handles LLI list cleanup
>  -Add Suggested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..02dd07001d5a 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -406,16 +406,12 @@ static inline void sun6i_dma_dump_lli(struct sun6i_=
vchan *vchan,
>  		v_lli->len, v_lli->para, v_lli->p_lli_next);
>  }
> =20
> -static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
> +static void sun6i_dma_free_lli_list(struct sun6i_dma_dev *sdev,
> +					struct sun6i_desc *txd)
>  {
> -	struct sun6i_desc *txd =3D to_sun6i_desc(&vd->tx);
> -	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(vd->tx.chan->device);
>  	struct sun6i_dma_lli *v_lli, *v_next;
>  	dma_addr_t p_lli, p_next;
> =20
> -	if (unlikely(!txd))
> -		return;
> -
>  	p_lli =3D txd->p_lli;
>  	v_lli =3D txd->v_lli;
> =20
> @@ -428,7 +424,17 @@ static void sun6i_dma_free_desc(struct virt_dma_desc=
 *vd)
>  		v_lli =3D v_next;
>  		p_lli =3D p_next;
>  	}
> +}
> =20
> +static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
> +{
> +	struct sun6i_desc *txd =3D to_sun6i_desc(&vd->tx);
> +	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(vd->tx.chan->device);
> +
> +	if (unlikely(!txd))
> +		return;
> +
> +	sun6i_dma_free_lli_list(sdev, txd);
>  	kfree(txd);

Why not also move txd handling? That way even more code can be put in one p=
lace.

Best regards,
Jernej

>  }
> =20
> @@ -788,9 +794,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> +	sun6i_dma_free_lli_list(sdev, txd);
>  	kfree(txd);
>  	return NULL;
>  }
> @@ -869,9 +873,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_dma_cyclic(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> +	sun6i_dma_free_lli_list(sdev, txd);
>  	kfree(txd);
>  	return NULL;
>  }
>=20






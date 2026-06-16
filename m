Return-Path: <dmaengine+bounces-11564-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V14ALaWCMWrjlAUAu9opvQ
	(envelope-from <dmaengine+bounces-11564-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 19:06:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A06692BAB
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 19:06:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OSxg1Bw1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11564-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11564-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97A831BA6B6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6246AF1E;
	Tue, 16 Jun 2026 16:54:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3433A9EB
	for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 16:54:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628881; cv=none; b=FETPPed9YofkFCaF500MDugsywtrCxIzaTTyMwB4ygk7TYDsIMRLkULkwmrKymj+6QYkqIBGnbyoBvpCuCW8Wn45bCdbmgrh/L2qc+9kdpDSeVpip5tZxpwFYYZrRU7QiRcPM6EBVk6/a/ueyodcCIzTqKa9f1pe4iax00YFpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628881; c=relaxed/simple;
	bh=Q3ogCEiEplFsajmHh+DrlKd0CFRslk5VBsvGzlR4oX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRJStPOecD/6Aw3Ed8keDb4EbvNkRZs/qfuYA1iDrwmXGgW50qFHT52E/v+vNG0nCR9O+/LKE2tZxrgDEVvcF22DKpLoOtT653orHRrSzuS7kxDPAxHpG87vanzmUFkJYkQA9BrbddfEismlbjV0nLuD/H+8+jMOHXbg3lP6bb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSxg1Bw1; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490afc47455so21987385e9.2
        for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628878; x=1782233678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exFxm0hh9AfcFczlY3WuFGnTo6SOwxmm6hFx+zY5Z3Q=;
        b=OSxg1Bw10IsREGiBf1ZE0l799sFTQuRvmqfI8ENfeDPi5YzRfMBHDnNlCHGM9Z8SsG
         hCccjlOTYeeL4NTm/zxp+Uv+sitJjxnJUs4lbG4H1dPnva0ihpOyz5tol+gg4gnWak2x
         G9Zh099QAKbjSJXn5P3cwiAXgLDPFcEVNsnQLpQYmhVnOVM7Zhay9C34k+UZw0KCkBbs
         eqJf3XBDcKq5UdT44+fgMWtZHrekbSnKrqsXG9wqdQ7szglOB8a+pqzND2L4YGJgh9Hq
         zLES3FsHdITSkYpenK1besLahqCRiagFs7plKX2NfFID2V4YbcS6lLuPi4AEsJkyZHlr
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628878; x=1782233678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=exFxm0hh9AfcFczlY3WuFGnTo6SOwxmm6hFx+zY5Z3Q=;
        b=nz463OY+1ZzVJkOJ7mG971P7liKzMhXZKHy/V98XIsIMyyI8UcpZWlwYecwCcGTzVW
         t4JT39sXALmxitg6OPQ4O9S4aThSnqYajTuwW6n9/nw9HLmvF5goM2aJ2q5Mq1vzRA7x
         npuXqx1SOrXp5yGp9W8yshE0CnoZAYnDFVobi+i1RojFUEgXXiZIerFIoaRgzpLg7jHn
         T8mfh960Ob21tnk1UwtXgATjwWjX+uERwox33rq6Hpn+KCvpt4qoukuKTkiwjQ3/Hqvy
         UHf0QaoPo0VH6XY6231UiDaXN4GT4i4BQwejNtzmCkP2+89In6zfUL8C1QaRlc38UgXa
         ezRA==
X-Gm-Message-State: AOJu0YyjkGgK7JO6nSXQ5G2WTyUZ0Myldm6SC0+DHyg6GfndOIKZxr+V
	g5fuo0wcGcmhy9tTrTO48jc2oXvK/ZXMYosThfmWN2lK3u7K8+4cuKyC
X-Gm-Gg: Acq92OF6aifVxPRDa94xxpfizhY/MPfdd9FMl3nkxR/7sSYqEEAa3dUPmXxKHbhpHhs
	Vcoo6yo4aTdcjn9q5hbzzx471ug3/ToHZ54Md+k6cNOQyeeGcZ+oQi07UrgmF0iLoqP8UgQ7tHU
	lQ/E/4nV8RDXHj3v/JZ8UogzH+1IrfeO9rCGACIM/rUYy+pgRADMv+E0W8S4A7IAFDsiOgRtLdY
	0x7qcRcUSnpu+lD5qhKx9Bka6qyKN2fZYuVgUIQ1M1ptABuUcPF1/FNB2KKHCn5k1KNdJB+6jkO
	IJFfcq3a2sYwmY+ZDke1+fFaVNXpXLKbv/U47UsBiCNXI8fUTu8pXoIiD7l8DkqZ1kg+b17vzYF
	d+WXpZpbQTUjH/VIaewT6jupCVgHb4pNUYB2eP3FJqxEfporVHrtSICc+K8+wdtyK1FdjnAm59G
	MQKtCMh5YVpd96u0tdRFjxJJuM4BQCfB8nzkwcwpUHKG4KrFNPMNaquhtKMhSDwIhpWSdXRqR2i
	3Ao6T5SeAk+NxZ27E3AKyfBdEbmAlsNtSXPF9kT3ZOEOFw=
X-Received: by 2002:a05:600c:a111:b0:492:301e:3270 with SMTP id 5b1f17b1804b1-492333af267mr5549255e9.13.1781628878052;
        Tue, 16 Jun 2026 09:54:38 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-99-120-gprs.simobil.net. [46.122.99.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm1842555f8f.20.2026.06.16.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:54:37 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
 samuel@sholland.org, mripard@kernel.org, arnd@arndb.de,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject:
 Re: [PATCH v3] dmaengine: sun6i-dma: Fix use-after-free in error handling
 paths
Date: Tue, 16 Jun 2026 18:54:35 +0200
Message-ID: <phINRqN0SQqjDvxjLw8DWg@gmail.com>
In-Reply-To: <20260616023138.15904-1-zenghongling@kylinos.cn>
References: <20260616023138.15904-1-zenghongling@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11564-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33A06692BAB

Dne torek, 16. junij 2026 ob 04:31:38 Srednjeevropski poletni =C4=8Das je H=
ongling Zeng napisal(a):
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

This looks great! Thank you for your patience.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> Changes in v2:
>  -Refactored the fix to avoid code duplication by creating a helper funct=
ion
>   sun6i_dma_free_lli_list() that handles LLI list cleanup
>  -Add Suggested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> ---
> Change in v3:
>  -Further refactoring to move txd handling into the helper function
>   as suggested by Jernej
> ---
>  drivers/dma/sun6i-dma.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..7a79f346250a 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -406,16 +406,12 @@ static inline void sun6i_dma_dump_lli(struct sun6i_=
vchan *vchan,
>  		v_lli->len, v_lli->para, v_lli->p_lli_next);
>  }
> =20
> -static void sun6i_dma_free_desc(struct virt_dma_desc *vd)
> +static void sun6i_dma_free_desc(struct sun6i_dma_dev *sdev,
> +				struct sun6i_desc *txd)
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
> @@ -432,6 +428,17 @@ static void sun6i_dma_free_desc(struct virt_dma_desc=
 *vd)
>  	kfree(txd);
>  }
> =20
> +static void sun6i_dma_free_desc_virt(struct virt_dma_desc *vd)
> +{
> +	struct sun6i_desc *txd =3D to_sun6i_desc(&vd->tx);
> +	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(vd->tx.chan->device);
> +
> +	if (unlikely(!txd))
> +		return;
> +
> +	sun6i_dma_free_desc(sdev, txd);
> +}
> +
>  static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
>  {
>  	struct sun6i_dma_dev *sdev =3D to_sun6i_dma_dev(vchan->vc.chan.device);
> @@ -788,10 +795,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> -	kfree(txd);
> +	sun6i_dma_free_desc(sdev, txd);
>  	return NULL;
>  }
> =20
> @@ -869,10 +873,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_dma_cyclic(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
> =20
>  err_lli_free:
> -	for (p_lli =3D txd->p_lli, v_lli =3D txd->v_lli; v_lli;
> -	     p_lli =3D v_lli->p_lli_next, v_lli =3D v_lli->v_lli_next)
> -		dma_pool_free(sdev->pool, v_lli, p_lli);
> -	kfree(txd);
> +	sun6i_dma_free_desc(sdev, txd);
>  	return NULL;
>  }
> =20
> @@ -1431,7 +1432,7 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
>  		struct sun6i_vchan *vchan =3D &sdc->vchans[i];
> =20
>  		INIT_LIST_HEAD(&vchan->node);
> -		vchan->vc.desc_free =3D sun6i_dma_free_desc;
> +		vchan->vc.desc_free =3D sun6i_dma_free_desc_virt;
>  		vchan_init(&vchan->vc, &sdc->slave);
>  	}
> =20
>=20






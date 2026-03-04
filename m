Return-Path: <dmaengine+bounces-9239-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGBwHWVCqGlOrwAAu9opvQ
	(envelope-from <dmaengine+bounces-9239-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:32:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BD2018B5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01D773051B70
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CF3B4EB4;
	Wed,  4 Mar 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nc3Dadeh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1183A9DA3
	for <dmaengine@vger.kernel.org>; Wed,  4 Mar 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633766; cv=pass; b=iCOxLDtpRAjcNHaRqrt8hFSPys5FermvKqWr3gijpWQt0L2aFpMYWtwQnSRF+he/H6mODMZ0IkacP1QfVa1eKRYovDZ3V09wtG3CE6cp5HnbU8Vo2AmSywufQRgpX33mrg+xLkIJX1gL3DKfUhBj7Bggoe/4SPL+OxJiT93EbCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633766; c=relaxed/simple;
	bh=M8N8n08iO/ohnjBo++QVndSj6M5N7aaFg3GXa++LBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGC33QyENKFDh6dDJDM5EMfC/DuZ4Hd5+e2GEiZwNdEbzMlVrnsPUfblKueLbvFK+7MI0nBmyDjyZY6cytbcqdZyRGETmAtE9KzamfHIaTG+PGv0Fs2SefjDTZRP9L1ppOSYkz+pZD+AnZ4nJHFL9Ampy+Ak+YqsSq974YH/hR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nc3Dadeh; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=FYFA42ojX02uc6vcNPxxquciL8D8ZUQxPHLK9Ii1tuk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772633702;
 b=Oql4Ju4DE2EDEcVInnWt2+ydVpJWLFX1E/hNNrdQbfCyeGyZr4h9Y7jbHPE6enrCxvGL6ZXs
 DGQYByQA4ZTJLoyOC8IsYOXMjmTujsb+Ysj3nWEhUWsRPbvFZTvM3PMPuxyvZcOkj30nNfK3n+5
 +FQRRdwuDFgIO+diIIr4eKwOFHZ/yG8IIpAbXAz/0Jj+uz+dNHC1jazjAqcXayNtkpbI+Z9nKVe
 /6wLF63mTZcsw1Llso6zBNqNkn1iVBSGJGeSqhIvAak+WA8U4Gdo1FweAgnJI+Ab8FQuGN/sjTO
 HcqW2tfpQePQmLLgBuCRqrbJ9m4rjuukL1AZFi5JKQCkQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772633702;
 b=H0mkEwjPzkZrDWkp9aKq9GAabWwP8dB+W5p/B0KeJfWh6tnVYwukBt3bMbtoPBKYShSjO7ht
 ZpMU/wYlefeqdHFcge1SL75kmJPZNVOrnsgfCOMZoYaneFwV/lLJhAVr2+mDpKs0i1Cu56jkR4T
 foeY0FnkV0x68lydwbxHc4SrkgeGKeuEbm1PYkPtsLyhLOhJE4Og5uXNh5Zmmwfze2OXYlN8x2M
 6t5izpi0T6KWp9rNUh/tdDXTQDuGdNGPyjgMn2HFFuCie42ZCXinsVVfRuEX3hxNwQUxyFjdIvS
 oUGBVYEeVqoxue+qWuiBAYjERYak8Tp//HnYbbAOh8KBg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Wed, 04 Mar 2026 15:15:02 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 35234220EC7;
	Wed,  4 Mar 2026 15:14:55 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/1] dmaengine: xilinx: xdma: Fix regmap init error handling
Date: Wed, 04 Mar 2026 15:14:55 +0100
Message-ID: <3640054.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
References: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15345406.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:dmaengine@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4fQvnW5SSxz4Mb6T
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:18b88d27d6f57275e2308e9afc64a81d
X-cloud-security:scantime:2.059
DKIM-Signature: a=rsa-sha256;
 bh=FYFA42ojX02uc6vcNPxxquciL8D8ZUQxPHLK9Ii1tuk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772633700; v=1;
 b=nc3DadehcNx9W5eZgKKWU/jSgkhAr5q9XGF7TGJUlMbJ/fhGrHipA6d6JoBGiGhPRVXezaT1
 XiTZH2xXZen9caXci92qgJl2oWWt5Z5xT/Y9QiwzZk0CaffJV3HbLkuBEDOWJvmY+/+/RQtFedA
 LW64som7IsHy+qBcJzKFcxHR278xMx4d4C4sWFfn72ayhT0TRR+Or1lyQ7qkE1ALmLjWNnUxvUt
 Mo6k2VLHgswykffORjQXCIVI0G2c2aOiYyfNAAEaNuo5fHP2G/crxirQkZavPFVROuiQg2fjjP9
 F7JVlE76nbYETF+0R+fqmq8BFuBijcFnBy9vbmh6M17eQ==
X-Rspamd-Queue-Id: 736BD2018B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=hse1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9239-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:url,tq-group.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ew.tq-group.com:dkim]
X-Rspamd-Action: no action

--nextPart15345406.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Wed, 04 Mar 2026 15:14:55 +0100
Message-ID: <3640054.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
References: <20251014061309.283468-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0

Am Dienstag, 14. Oktober 2025, 08:13:08 CET schrieb Alexander Stein:
> devm_regmap_init_mmio returns an ERR_PTR() upon error, not NULL.
> Fix the error check and also fix the error message. Use the error code
> from ERR_PTR() instead of the wrong value in ret.
>=20
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Ping,
any feedback?

Thanks
Alexander

> ---
>  drivers/dma/xilinx/xdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 3d9e92bbc9bb0..c5fe69b98f61d 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -1325,8 +1325,8 @@ static int xdma_probe(struct platform_device *pdev)
> =20
>  	xdev->rmap =3D devm_regmap_init_mmio(&pdev->dev, reg_base,
>  					   &xdma_regmap_config);
> -	if (!xdev->rmap) {
> -		xdma_err(xdev, "config regmap failed: %d", ret);
> +	if (IS_ERR(xdev->rmap)) {
> +		xdma_err(xdev, "config regmap failed: %pe", xdev->rmap);
>  		goto failed;
>  	}
>  	INIT_LIST_HEAD(&xdev->dma_dev.channels);
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/
--nextPart15345406.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEByESxqszIvkmWRwbaS+g2M0Z/iUFAmmoPl8ACgkQaS+g2M0Z
/iU+vAgAhVn/PEgWR46nYGIDjXs2WVYaZ0jy+MzJwSpGsh+jaFAzTvUpHE16Uc+1
UYxIMMl0imWI1gGkg1woWnlr/9sHrleN8tAq+cXWZbC7dwaaOonIxJxI5bUvSXPq
+O7zYQmMYhP6JuzCpiM8q5WkbYUX0EanSx/OrSpCdVID6Daw5C/kmEGPdN0YNvMY
fIIE9wijsqrebamhTMsztxaQkBIcZagLCPq7+EfMDlvbKkQnDZdkWqijKqO3HpZe
jOsrYjvi0J7/5gwNl34FHAxYKuxG0YObJLjeGIryMAFGfxppTqmjQNT+XCSIjWX5
pRhqhNyqrTlwekwdXcynMNnVfVEi0w==
=tJUS
-----END PGP SIGNATURE-----

--nextPart15345406.uLZWGnKmhe--





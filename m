Return-Path: <dmaengine+bounces-10459-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D4xGi8qBWo4TAIAu9opvQ
	(envelope-from <dmaengine+bounces-10459-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:49:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D155853CD93
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 03:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDA03017FBA
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2E30E834;
	Thu, 14 May 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/GaKFj7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F925B0BA;
	Thu, 14 May 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723370; cv=none; b=a08nzKLZ0qBtiPsrzlWfc8az84NwIrdB2prVn21Ck2ETORkwW/Fq13DzpoHgWHdfSquAR08hWZfPvP/rxkC7HWwLfZ1jvXpTtWRDgxDD2qSswycuAMoDNChUItLOtXZdD15r998siqZZ5TOe6Zcck5g2tvenWHL8zsgWOv9G9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723370; c=relaxed/simple;
	bh=mhIgowFJ/NsjjgimUMPdzodKvuhjEXH3/32vBatMPR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dFnQu4lJfkz1eqdJ4yUcv1iLoiTlZswu7d8QbpTVpeCF7mKViIBOGV7CuKTO4ceOUwUGXG7i0gatbaf2V1+i+VKmoGM8sPj4TkEY19aqQ2UIWzaO1IuQ+ifbulEh+5369PHtXK1A6fD4hjmCInrh+7zSc/ZlZDRh3xtMGwv49Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/GaKFj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C2C19425;
	Thu, 14 May 2026 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723369;
	bh=mhIgowFJ/NsjjgimUMPdzodKvuhjEXH3/32vBatMPR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W/GaKFj79nddJanysnTGVv0wLCr6CLSodE93+jhA6kS7k5/eSiqk2+vqtffuhHdi+
	 Siz0DRqZGeIWfcuy8IbK8ihO8KeljBv/zzPfVlaAzmgqw4bRD7QNdLr8RoVMADy6et
	 B/+zk6J2aw2fEs3YyIMXbA5IYsjzElhy2kIj/0ro+9sMDr8oM2SzXTP8WTdd/+Jfpk
	 sT/C6l+WpoelcnasXwCllDPyfOJLkj90LTuNAJaoMV/xG73Fnx53DY6LUGjkxrsAY9
	 p0BjzAsCvQdMF7JJ9GpmOH/zLNJnHz+qPVFSLuvP7Y4S62K8UjvR6Hbgp+8/OuCIxl
	 HzwnWDzVJyMMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] crypto: atmel: Use
 dmaengine_prep_config_single() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-9-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-9-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:49:23 +0000
Message-Id: <20260514014929.7F6C2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: D155853CD93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10459-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatch between the commit message and the actual API used.
- [Medium] The patch masks specific DMA configuration error codes, uncondit=
ionally returning -ENOMEM on failure.
--

commit 05fb1a88b098522438016a4c4b3491605a64cf5f
Author: Frank Li <Frank.Li@nxp.com>

crypto: atmel: Use dmaengine_prep_config_single() API

This commit refactors atmel_aes_dma_transfer_start() to use a new combined
DMA engine API for configuration and scatterlist preparation. The commit
message notes that this is intended to simplify the code with no functional
change.

> crypto: atmel: Use dmaengine_prep_config_single() API
>=20
> Using new API dmaengine_prep_config_single() to simple code.

This isn't a bug, but the commit message and subject mention
dmaengine_prep_config_single(), while the code actually introduces and uses
dmaengine_prep_config_sg().

> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index b393689400b4c..d890b5a277b9c 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c

[ ... ]

> @@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel=
_aes_dev *dd,
>  		return -EINVAL;
>  	}
> =20
> -	err =3D dmaengine_slave_config(dma->chan, &config);
> -	if (err)
> -		return err;
> -
> -	desc =3D dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> -				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	desc =3D dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> +					&config);
>  	if (!desc)
>  		return -ENOMEM;

The commit message states there is no functional change, but does this alter
the error propagation?

In the original code, if dmaengine_slave_config() failed, its specific error
code was returned to the caller. Looking at the definition of
dmaengine_prep_config_sg(), it returns NULL if the underlying
dmaengine_slave_config() call fails:

include/linux/dmaengine.h:dmaengine_prep_config_sg() {
        ...
        if (config)
                if (dmaengine_slave_config(chan, config))
                        return NULL;
        ...
}

Since atmel_aes_dma_transfer_start() now handles a NULL return by returning
-ENOMEM, might this mask configuration errors by presenting them as
out-of-memory failures instead of their original error codes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D9


Return-Path: <dmaengine+bounces-10454-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8INQIp0ZBWrOSQIAu9opvQ
	(envelope-from <dmaengine+bounces-10454-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:38:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8A53C633
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E5DF300EC58
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16442D29C8;
	Thu, 14 May 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmUVjk0V"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93A26F476;
	Thu, 14 May 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719126; cv=none; b=CWc7R5HpIrm4wy5dUoO3urzFP8tSOy+ArjNm9cvP5NsYm493xabtmnZ4OymUkIy/vjD1IxoPuq236E8q83QY8yjcT8kJF5I/T1vgsSx1t90xRJdV8eKqdNOID2DI4Et/YW17lGF6bKaJAk2XUCyTXxkWK9+jsc621nOFdL3dEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719126; c=relaxed/simple;
	bh=0pm2so/gT8FBwtcqO3Wc625VGbJi1uk65jlu5tB71k0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHEkIaBJfLmrnF3LjCMuBgCTiY+++C212h52jA/HeLCjnhAPCEHcGpxjrUvaYlCjQikD8xIznv8zvv+2sqLVTyN2AYiWMFexQlz2lLfJvj5HLO7xRNFKGFaogNudFwG1tIEUB3u7eaLpHDbuWcXlh9RD6e8K8UJppctBmfBABFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmUVjk0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB2C19425;
	Thu, 14 May 2026 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719126;
	bh=0pm2so/gT8FBwtcqO3Wc625VGbJi1uk65jlu5tB71k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dmUVjk0V6c3cIOQmVYOme1LOWxhrUKp5FhM1cWIovvW2z2o9QnlNrLHCsJeZf1J6N
	 IRjjW16wKRp0F/+3PtCDEYkQa4llwobDFZZs0PIwGD8YgkexjZ9EXFtKIaRojr/CC8
	 ITZgYUaTJxG6+HSFfGabOSsp92U4ewqvZiljTSUjDroYd6c2+Azu6VbLvKesBNEQRM
	 5LakxrBYShlmh65Kx2zCosafj4AV8DlV0FjQBniRRvNEtrWHGIxLfJZqyEvMfsEeBJ
	 uORTBsbuOrq7kGogBxd/AbTwQS/5e+a1Tu8ypbxIjueshqb1Mir4jAyeIgSgHjS1zx
	 mwM1J/VaUjTtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260512-dma_prep_config-v5-5-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-5-26865bf7d935@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:38:45 +0000
Message-Id: <20260514003846.0CBB2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 80A8A53C633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sashiko.dev:url,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10454-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `dw_edma_device_prep_config_sg` function ignores the return va=
lue of `dw_edma_device_config` and proceeds to use an explicitly rejected c=
onfiguration for DMA transfers.
- [High] The implementation fails to achieve the claimed "atomic configurat=
ion" because it locklessly mutates shared channel state, corrupting concurr=
ently active DMA transfers.
--

commit 8f2944930122fd18a6a04f03176bb9c6eddcd9ba
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()

This commit passes dma_slave_config to dw_edma_device_transfer() to
support atomic configuration and descriptor preparation when a non-NULL
configuration is provided to device_prep_config_sg().

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f7f58b0010e26..ec6f6b1e48256 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan,=
 struct scatterlist *sgl,
>  	if (config)
>  		dw_edma_device_config(dchan, config);

Should we check the return value of dw_edma_device_config() here?

If an invalid configuration is passed, dw_edma_device_config() returns
-EINVAL. By ignoring the return value, the code proceeds to extract the
source and destination addresses from the explicitly rejected configuration
via dw_edma_device_get_config(), potentially resulting in descriptors
prepared with unvalidated hardware parameters.

Additionally, the commit message states this change supports atomic
configuration, but dw_edma_device_config() mutates shared channel state:

dw_edma_device_config() {
        ...
        if (cfg_non_ll || non_ll)
                chan->non_ll =3D true;
        ...
        memcpy(&chan->config, config, sizeof(*config));
}

Since the dmaengine API allows concurrent descriptor preparations when
device_prep_config_sg is provided, could this cause a data race on
chan->config and chan->non_ll?

If chan->non_ll is actively read by the interrupt handler to dictate
hardware execution mode, could modifying it while preparing a new descriptor
dynamically corrupt the execution mode of currently active transfers?

> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, =
config));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512-dma_prep_c=
onfig-v5-0-26865bf7d935@nxp.com?part=3D5


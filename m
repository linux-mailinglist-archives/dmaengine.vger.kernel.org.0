Return-Path: <dmaengine+bounces-10723-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP1sNOQsEGphUgYAu9opvQ
	(envelope-from <dmaengine+bounces-10723-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:16:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1735B1D7F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4703304EA20
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB13C5DB6;
	Fri, 22 May 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnpYdhy+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96155351C2E
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444630; cv=none; b=o5r3wS6+9W4ILhddLBPvdgMyODLHASgPvEIoitMo7ksKt9FGRCE0AUnqLul32m0+hd4GrjU6XwIKVW6jweH2kI00pQIYFVpQ43fgx+Wu8UlNvZSs5A0+KXlg5i+KT7cvMesknXAML9uI1HL0tOcSR3EOAgdUnsETUz4UI1rBfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444630; c=relaxed/simple;
	bh=nUDx/Hx8QDCc2KH4E9IN4IE6QLtAgB3+QS3Q1sgq2N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiBCnlXguyT1AkCnsgbkB1wcBTxvRCvbA+g1r6Iru6tzrJdIqgvB3A8knr6u5rQY4yHktvAVcbehmHlOfrJk59UKdRYDLRA9zQp9YL7FnlZZrWN+3GmAwC3CRoqfonCWJhzCIWUPoXRBF5YeS26Ys5ttrTOuZl8vkETwfLbZZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnpYdhy+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso53767675e9.1
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444627; x=1780049427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksYNE5DgGi8aj7hSjdkwqCdfXo+PZrlzO7PfP46SpzY=;
        b=RnpYdhy+bzbYrqzy6uw6pFfgsGKs7VZhW0Crea3JkSmhYM7lk0JGXr0IGa7GnRPPDg
         Kq+t4rD+gxncYSUw4bj6X0MJMQYZrvjfv/JK0/YeehEjzd7fbOwhAP8wf+BBjwCn2iTS
         xHgOpMrysrPabCsb7FvnVzz8fYB5GymHuwhEq5EE+o1KMZNRMzqhZzLjiQYs87+Jzf2k
         ecQsmUKZHGbNRjK1Y9QE8XeT3Fy79K+r4EBdNogP0c4dj7e7SVejHI/L6zLuQudrf71e
         kWP61PH5+rBtdsqelxde7DAlIQGJJDKNr0QTJutj+2eyJZ+mHOdukhdXBVjKi4AeikFv
         0z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444627; x=1780049427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksYNE5DgGi8aj7hSjdkwqCdfXo+PZrlzO7PfP46SpzY=;
        b=pM9iZdj1AqkzJaCXrh/pt98LkvXYWdZI3YX6AUwbJBGZaDBo89E34L2UWUhgqOgkFA
         LqhLAyHz5v5SihBKUUSIpRR2M3pAF+PSpQcH29r4G26ZEDsYy/OPm8sFeS8J/JKXmDTA
         j9m/LwPk3SFwd/gL5tD9NF7xMG7jtuSFWMeFArHJxJaaf4QByQFjPaVLRHdEjWamdVu5
         geM35hNlh4GP3i1KgDvmDLRWcYEI1vbG+Um2yTfD0sxyb7xI+H38ek75q2bKBiIdhZ93
         LAxnvifMKruP6SMW0Rm35wCB5lvtryykmZo0GDDA5922d411qvc8uFdyEl94RmWKrmxZ
         xNMA==
X-Forwarded-Encrypted: i=1; AFNElJ8LmmZPdHFzTFR10CHqQF2h01iS1beU4QjHo83wfKeY5zlUV4nujqR8fhXTwdCeXSFNQ3AWCh4EyRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVARpDB/2T+Lx0Z3ur0NfJ2WxvJKeDYzdJ/cSM9ft133pZwDY
	tHnMROLuF2LR7+iABZ1E2Fa2L8WXEgTvh+CrfWKSuL5JQFV3ubBSR4wr
X-Gm-Gg: Acq92OHB2OqSPx72KW5clHWN/na8cJzAKATZuZzUjlEN7K4uL4Pr7j4WISYRbGjewzi
	jyXid5AEhQsP6tR3Vm86oSE5hpyBCjVTrJ1wj4KJta1n5vc8r9dAVGDgzO36M0L4vBU6+6iJZEg
	wFZTseDZbcohAWVhT93hU4/vu1ePfNSLkKa/w82qgqSO/8/1RBpgVPyNAsAaQVwFHyDU/lh55s8
	QWQNfJR/tft1PW7cnCFe6SA/psYztYbJQ+ATuXTvBbQ5AxaPEkW+W8rlX+M3MZD04v2iyk7JGJl
	XeCwR9RAYYQRuI2NrJjnomAPBKL973SMnWwly7ecRgebqOJsjINclouBVn2P4jCOXnesxrd0NNG
	wqeWHMyVfnS6iwOPiAyBYI1bQZ7roNsf4bLjjyi4EnRSNDDHRTiGVFt/i9sKaa/nqjw0u8tfVqS
	d6Dc5zrLXhCx6CkG5jQYxbLOmpQIDxCN8WzUYKZP/s0tIpd//sOqpDkvQ4YK8rXzIivA0x7fUmA
	FTLpHbIehlmcA==
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-490426cefe0mr28149535e9.18.1779444626854;
        Fri, 22 May 2026 03:10:26 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4850dsm2798642f8f.17.2026.05.22.03.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:10:25 -0700 (PDT)
Date: Fri, 22 May 2026 12:10:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
Message-ID: <ahArhz2rJrUx-3As@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-4-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfuujhnhen7f4kbw"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-4-akhilrajeev@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10723-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierryreding@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A1735B1D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cfuujhnhen7f4kbw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 03/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:52:56PM +0530, Akhil R wrote:
> Add iommu-map property to specify separate stream IDs for each DMA
> channel. This enables each channel to be in its own IOMMU domain,
> keeping memory isolated from other devices sharing the same DMA
> controller.
>=20
> Define the constraints such that if the channel and stream IDs are
> contiguous, a single entry can map all the channels, but if the
> channels or stream IDs are non-contiguous support multiple entries.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--cfuujhnhen7f4kbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQK48ACgkQ3SOs138+
s6GAew/+JcdwaY780zCzuK455YnQ+eLwg86S3a4AOS3x5iG0/m8f2Amil+VB72nZ
ci4+qK7+yV8+3+6uldI0g7LZDzGflpyZrUDNuQLCfj+vYmEb61o1JoZbNhoE9+ic
nag0sS5coucJKY2Gc3RD357norEY3DBhMNTr28tn58ydg442Uq2gx/6ZVK9GnYfF
XgK3rr80mq7WB2bVqK3GTiC814TPhlldNXxFxqRV8y4h/D764MMQ9qHocmgx2qW4
5I8InPisLbTCb8p8HBwRlA3h8YYMsMth3CHVUXXkmTb8NBEmjfQnoDWB4pxmIpf/
KzJb+/Qk9OTBOhy86/zUp+fCY4KZvNKcD8csC84lEIzPzUuRcIFv6ILoGvzUo4EO
YwuDJpsMrOf1K1K5hHm9qGugZ2DBSK4Vx4fOUBWoZIjGH2/TRCg7Pn6JBhJuT5o8
hThxuFO8909jWAoKMknu1oQD6ShIuVj+FbDWHhYAlbI5Dj+mT7QtQ1z750r0gtj0
2RkRveEDOOUuv+Zla1iw3NQkkSLogplGwIp/OVbyzkNCkxClBkWP/7/D2c9+ZdOU
orMrAVeNg3+t+xWUKNNsTIJs7UHY/Ijp9T+msaNIZnojc0XnIGHfcTHDJIWeXhnD
Ze6C+O9gJTwgdsYARNevxitPP2/O4tnp6JP22PWc6ueoyrvbSxA=
=xacF
-----END PGP SIGNATURE-----

--cfuujhnhen7f4kbw--


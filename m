Return-Path: <dmaengine+bounces-8858-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDwdBZJRimmmJQAAu9opvQ
	(envelope-from <dmaengine+bounces-8858-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 22:28:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42861114CE2
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 22:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB105301809A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501E30F522;
	Mon,  9 Feb 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lliXtfSS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17130E843
	for <dmaengine@vger.kernel.org>; Mon,  9 Feb 2026 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672527; cv=pass; b=MmIM61mJmDAf4PARngw9R1zAU5JcZu7TONfcffQpck4tVTf2lYOMIDmK+ER6cy4KjFjCqC46WZbQZvITgq/LYNZgOkLl/fG/tO2rq1qLxNz6phL79TrL9NF5rg2imVBIwdWK5B12BqlXTyUctGUAfu0ZbYx1rQETIbLpklDEUNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672527; c=relaxed/simple;
	bh=7VxxRCEOKnnPs1JTdwiGqaK47NG0gxr65sECLL3hgHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8Mlvx8f2MSoOrOU5JpgDzPvIcKeGEJ6oOZGajfTTFyklStkPXhwCDs+0ryu4JuH/C9Gh2ES+6jcn6XpVb/q5cTrJERreWN/5FKbSm+H7TB6SkoineZYxln343sfrVYN3sKrh549zPMwiGNgU3JgolWnjgkSck7boaRdFbK1Msw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lliXtfSS; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7b47a5460so28472785ad.1
        for <dmaengine@vger.kernel.org>; Mon, 09 Feb 2026 13:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770672525; cv=none;
        d=google.com; s=arc-20240605;
        b=RpKEGbzLH/gqTnkKO6bcuXRe4/L6Y+NGa2m2QasUAd2NY2MDTdbDHP7kdoi8AiWP9L
         OEutiF5ZaJC5Jjqj9/Sl1uW/0Wwd+N+CQWJNyNc7AzHtWhBQsaJHYEI4l4Z1YFHfQ9NV
         RfkSN1g0wlv+TtHv2T8dHxinW2XKQ3RxQAeDtdEWrCO0gL/2ktXHyHTHwKqPR9c/Tcpd
         7I9XYRk/FftBVI8NHTqkzAdsN+V0VyaRx+NLvvsyLUEuSqQSsQuL73rJaJz1B5/ypUm6
         yUEUPc3kgdTvmxoEcPoWBWbnLDW6L4AYD4mY6bK2KsA/AqQgghSDdWO/9hbQyFGUPDD2
         9EtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        fh=Y7nwdi85J4tyCsThZMjAVWKT5woBD7f759WYXTUHxY0=;
        b=Jm0POG0HUdNwYofan8HnEsUnLQL84PjcyO393wlkPAo3zoY+Vw+Dj7DqNMcdNG1lwk
         Ag4GrZXcPN6fKOZsIPt0AJe65YCyqG94qlbHpxV8qFAJzT+vsiKDqOib7lWOVcS9SLzD
         D45OUbJd97t5yvthEO0esHlTj6XOfqJJzQdjHsic5dGWWtUiDykr++oIPOh3M35wmlUq
         keO+cSupvbC1nSaPY199eNgaS/SBgkl4Qbx+D67pCL4wahiPKW/nKbrRrRdJeZuxB3l1
         ZWDyg2rH4ODR9gOCIIgKtbz57afhOeVz1xJQ27fx2PiGTMTLS56sdXOC/gBU8H5cPwW7
         9LfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770672525; x=1771277325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        b=lliXtfSSblamQDZpJMmNHXYwt3eEpHfg8DqTJk78TXldCuOK4mD3+g1XSfiD1S5sa6
         SbsUo8h7tipmgGHUfBI7Bi0rmrCnuKfws/MbrDSLO3VSskxygc3k9FE/niTPoq2UvmVV
         SBMnmR53t/eDil6s+kBGn+JRvdy3+pGpcrcXZl82G77nT2Z0jc3w4FWszNOI5zWQsFny
         Dl3DqbvCZCP6rlHHGY0WAOhnCo95baHiM0siE/jyuAo5lCQ3J75KWS86H6MAn+rPnf7U
         FM4wkM79jH/Bs76Rg2UytbzqH9FtH5RW1Mk8K3VVWmY3YVNACkC8mWTUolE7WI2MfkO5
         vD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672525; x=1771277325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k5FyOhy1MJGzIJn1ngR3+3z96yOozaG6Ty++CDkfdvU=;
        b=aHOi1s7hbb4owxvORyz+2bWlRYooxQ7LZdSEtVf6mZ3NUCvTm49KtkogKiS7wq1H0u
         cUZ55qQWEgSpgW2Iqu6ZJRtPEkJcwnt8vj59XYeqmuLEnIt+lnluyNiClnMFwIc9lpcC
         dlNYCDxF6+EiO4z1n0kUSQ0CRHbZcQVxlyvh8oIb0/VHyob7g4XWf96iiAYacQeGqI5k
         DMRY00rkY4GYD67AiP/38F65C7TAE0K2JTSse/P6U8cLtKtaER8JxxYdoWMIcGIE/45S
         1ifUBUU9+ixhysWnSWDmjvl5fkw5nLXgL/5awD2Ju2k5mNV+1mU+rLqvUcel1zDo0e4E
         5RXw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uHzFyN7aiRimEA0+tnhLqKbSGZYLsjdEniFR4t2194Mlih8OjxU5k30hsEDIN2AASGL/7Cwh1ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pWNfykePvCvHJLKWwjl/3LLnk4Zx+1vBvcAZzbjPgK6a2xLg
	tYGLziBxYQVKu6iL+JjpKuECw9cEGnu7Tda7YsTpSia2EYXyRWrYwvR59EsJ2wWqHCROeEA+a/5
	zLPrN23VlGr2uux55aeWFW/a2tWX8UZs=
X-Gm-Gg: AZuq6aIB989+2Lo6WGVC5R4WQj1DqFaUhKc6mKUYIxpSzvJsltMrxd1v7ay7RQJ6b4O
	VijuGbwu8jpgKHqduwkkfOXFsJa6OsjRqbDozUoptrO80WS42XSp3dxp3ppR+FI23QjxbybvK9Z
	XV1vKXU7sI9Jj9wQKIHHE0NNewz13t4AyUrp7ythMJsoaD4dY6dfIYcknAg8HsZY+aEb3tX4UHF
	GYHhh9gLj5C5Qi0Bfa4YmJztebkTJd1E3IjqZLQOB47AVWv1w9uvTecAhEGCCyD7iIsmwVEbzoF
	RC8HnguqlifPGUeH4JSFa98sKLyD
X-Received: by 2002:a17:902:c942:b0:2a9:5ac3:a925 with SMTP id
 d9443c01a7336-2ab1005a1ccmr1466005ad.3.1770672525352; Mon, 09 Feb 2026
 13:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com> <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Feb 2026 22:28:34 +0100
X-Gm-Features: AZwV_Qhsvy9MKoHxeyazUY3RMdma2GB_qfE0DFHV76hqeFYCbzBl5BWm6SyiZlo
Message-ID: <CAFBinCD5ZzjQc6ve-zZJ0MqN-a0rrp6pHYf3X_0ao3MRwi2Jrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
To: xianwei.zhao@amlogic.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-amlogic@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-8858-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinblumenstingl@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 42861114CE2
X-Rspamd-Action: no action

Hi Xianwei Zhao,

On Fri, Feb 6, 2026 at 10:03=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +       /* PIO 4 bytes and I2C 1 byte */
> +       dma_dev->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA=
_SLAVE_BUSWIDTH_1_BYTE);
I have not seen this way of writing two bits before.
Should this be:
    BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE)
instead (similar to the line below)?

> +       dma_dev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV)=
;

Best regards,
Martin


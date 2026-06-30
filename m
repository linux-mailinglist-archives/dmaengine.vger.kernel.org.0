Return-Path: <dmaengine+bounces-11874-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0WJ8FIoOQ2oeOgoAu9opvQ
	(envelope-from <dmaengine+bounces-11874-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 02:32:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C46DF643
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 02:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ANGSNIVS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11874-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11874-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B55130099A1
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 00:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49E175A6D;
	Tue, 30 Jun 2026 00:32:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB77CA6B
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 00:32:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779527; cv=pass; b=CUkn7cUTgzapZIHW6FJBuUkDykIPELtR3YnClLLqXav3Y8GvXKO/usNrdZuj4U4WbVRzQQttdqJ7ztX6kzkHIxNnIr8+71ypjclsVVXQu9qFES+kqksFPoSngxpTRKycnhdHaCH52GAR+Hne9Beuk/XF6Z6781Yhee9/5SWIUXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779527; c=relaxed/simple;
	bh=Stv/EoGdRG9ASHi/1ijqr+t9ypiADGTyswBNzui6cls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+3/bR0sW8UKAbNfAzCig/06b6uC/pdRNLJVFM23+zVedxskuWlfBNwgrdTL0+sf6lAgNQeNWwUVCkaYvMdVm2WILbhMsXdCoZ8Yo588sud0YwYzS5mw743UvGTh7qqgtIXv4mBLpFR8FJwfiKw2CoUDo44uC0C/IIjqv5DAXJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANGSNIVS; arc=pass smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so7620111a12.2
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 17:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782779525; cv=none;
        d=google.com; s=arc-20260327;
        b=EflLcXNvG67J4vMImHxemZvFE6wHsXdhocjbf4R5eQC1HL8fGxVLHqKOtYEecJPTIQ
         1B+eIpImk9SwkJQyPRJQR5qcRM0pNIH5zt4fwQwvfCHoLLvlWz1b9cWBUwI0fD8bW86i
         JfRtdAaV48b/HvgfioaVNAABoED3A941hXVmxg+NvKW1YNTOqjPRoxMaEFllbb5kUwjb
         iPsTRq1yexnWwpvmTlo0y3TxGp1w2QifGoo/vjYRou8CyVbh+eY18UwoHqUYaNXnkvoX
         mkLQ8By3704BcZ9f5V4aAQtTMvtqCwsFqWAGJ8QG723RmGRuFiZH8Az1Xq1bOq7pM1na
         hMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wpFmbrfbWlP1ZXWzSm85Y63bTGD4RSCBbCB3/t7eeX8=;
        fh=8ha++ZqJHgcqUHY5BFA5s/TGImAioVdBfepMyGV8Qh4=;
        b=cwtkNV4W0Y9JCVDnc8fvYQ62SMmXgTpW3wOYkYOWJhnzGBuHQpsnpresePsr/MQLz6
         CH7u5O4pqJ1uAz/fT35A6NvsoA64XAI89MB5o7wk5bXRBU5W7Kh9zYwgTAnq8lSr2DyD
         BJA3rNpw1ePOevqQt0W6W/VnshAJ1g8IlKfqgfKDdoZLP59e8LwaY5pkepN/R0OpEMnT
         b389T3dxmkxQ3vVd5LchjBDcGU35gKJybcWJH0tZjf0OdFngtbVX7fkqDluRBv4C0OVV
         ImXFOcu6ZIbuu11UeWLyexJ6iU63VyHpBx3mgtbRU87x2f8n4FbL5hgE4CbNdBS+YOKJ
         4hSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782779525; x=1783384325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpFmbrfbWlP1ZXWzSm85Y63bTGD4RSCBbCB3/t7eeX8=;
        b=ANGSNIVSWjrKq+Jarl8EklJk4ezQHFFL07EkuEBi7DSCBMr5JmtEQFaYJero7/qYwl
         JOAERtn3DCEAtwKR/XMBO9d0pZmlDmehowl1VaKU2nqV5TUdxFGCbXs1A2sFAOZy144L
         YpyEPr1S8IS5aUHphIMdSw7n0HAA0/mfuGMATdqkK13vnY61k7p6WP0xs8AvXsAXNCBx
         iMwHqf/5b1SJqD3vpFFTo2Qs9w8CIoqfWkevV4asWmpR44jyt4Z4zAuT02qeyOp4rciH
         OcSvJ6CKi3wBWcDshLYSXLUTRqYMRlQpItT8kbfDnWTk17ZjefUBoA9g0zXg+AfiaPny
         VbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782779525; x=1783384325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpFmbrfbWlP1ZXWzSm85Y63bTGD4RSCBbCB3/t7eeX8=;
        b=X1Xkkt/8ONKlTJHKHynzkMENXjjJz5BvZ9dNI0BcN7OQHjALtFUw/5y9O5Yi6OQ9n3
         ti3USkNpv+ZEXuMY8b/iJVpI27kGojdbSR+LA5xXDTggF5SN7rNXZeKCyVryXjHjmCMj
         NpkFjAgppGChSn/tf9DteIu2LQ8H5QWXSs4hWE5aXQ6rZW0Vl4tVM/bjIP6n/AFH6CxP
         jVTwLMN9pBsKlmVSBhCspDPxwMlmxjvY9ChZ7xuIAVBn30SVrdGRs5WYDhfwmMxLDHbq
         GVjPCV6ms/OoV0RNIy6sZR0jh7D37YKVLvpW2Dwg69NcBKhAIjyoR7NRbAur6aBzgm91
         bbdw==
X-Gm-Message-State: AOJu0YxM2pwhS+RHRgTnBo7kCqlQmiiDv5xL0jZiTj41i67aWJhLAh6w
	zj1shzEWherQWgHi4podSyxRDnarXRVjDCWBz9t+5UBFi2bc/Q6w6nrvPIJQR/SuNrIEiaSZYzi
	rEFbJDcWC3SlRkiNVhf/MCDK8ur8xzGE=
X-Gm-Gg: AfdE7ckRfx8IH1FeFgY2uYTLBcRm6S+up/Z8VJEnStN/Aut0a79+lJbYp6kqHOfZdii
	/hP+qiCkVbrRVLf9dGWASoK5He5LzMuCr+kQPZ148wnN5fIij3aV18/Uq4VYj7AMXHknDkI5dsb
	n0WsLhaBNThgEqIMEzYZ8O8/2gsZXQcjyWi/SrPoNTIyzZUe86kv5+/zfROOI/bHyI5voo1AMnW
	eIc+QWzCK0MCN1mfYvdhcR9Fwy0vLybaEXHXTIccNjv8ORzoMOmmpL7tqvIgWRCA4qRL3nQVEyp
	UcPp5nBI+2AHSIYYav0BmJHxj0U2Ft0CrXGIC3u0nvnEJIYKKTdtR2uPGSqSuIVm/BQ64POvcf8
	xMketNFZGAyWAFCdLZAhVaRvHxGE=
X-Received: by 2002:a05:6402:210b:b0:697:be0e:4b72 with SMTP id
 4fb4d7f45d1cf-69879dcd8c9mr529822a12.1.1782779524530; Mon, 29 Jun 2026
 17:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609212531.22044-1-rosenp@gmail.com> <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
In-Reply-To: <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 29 Jun 2026 17:31:52 -0700
X-Gm-Features: AVVi8Cd4Bft5b9XJ3dVIwMux45umBZiiJ9R_2r0zjmH4edtW8dHEPIxh6q8FZzE
Message-ID: <CAKxU2N-DELS8D=ZFk++s-AW-uZv4gKvqmKM0gzDdbGy2zvrGKw@mail.gmail.com>
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
To: Jon Hunter <jonathanh@nvidia.com>
Cc: dmaengine@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11874-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jonathanh@nvidia.com,m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B17C46DF643

On Wed, Jun 10, 2026 at 1:43=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 09/06/2026 22:25, Rosen Penev wrote:
> > Simpler to call devm_platform_ioremap_resource() as it returns multiple
> > error messages for whichever part fails.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   v4: rebase and reword commit message
> >   v3: change subject
> >   v2: reword commit message
> >   drivers/dma/tegra210-adma.c | 12 +++---------
> >   1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> > index ceaee1e33e68..21a381d022cf 100644
> > --- a/drivers/dma/tegra210-adma.c
> > +++ b/drivers/dma/tegra210-adma.c
> > @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_devi=
ce *pdev)
> >               }
> >       } else {
> >               /* If no 'page' property found, then reg DT binding would=
 be legacy */
> > -             res_base =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
> > -             if (res_base) {
> > -                     tdma->base_addr =3D devm_ioremap_resource(&pdev->=
dev, res_base);
> > -                     if (IS_ERR(tdma->base_addr))
> > -                             return PTR_ERR(tdma->base_addr);
> > -             } else {
> > -                     return dev_err_probe(&pdev->dev, -ENODEV,
> > -                                          "failed to get memory resour=
ce\n");
> > -             }
> > +             tdma->base_addr =3D devm_platform_ioremap_resource(pdev, =
0);
> > +             if (IS_ERR(tdma->base_addr))
> > +                     return PTR_ERR(tdma->base_addr);
>
> The dev_err_probe() was purposely added to assist debug. Please don't
> drop this.
If you're talking about the memory resource error,
devm_platform_ioremap_resource() prints

ret =3D dev_err_probe(dev, -EINVAL, "invalid resource %pR\n", res);

That's more descriptive, no?
>
> Jon
>
> --
> nvpublic
>


Return-Path: <dmaengine+bounces-11901-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wg45BNQvRGoXqQoAu9opvQ
	(envelope-from <dmaengine+bounces-11901-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 23:06:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36816E8041
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 23:06:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JIC9N2QC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11901-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11901-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BE61303F981
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 21:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756F2FE56A;
	Tue, 30 Jun 2026 21:06:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1206298CB2
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 21:06:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853586; cv=pass; b=fRZslKdLMbTmH8BzeUA+EJUZ3JFv83mqLNTbddNR21wpwhtC709BYHrq3UPWI52+K6o7f5GXma/821OYn7X3je0KioVGy6wjL/usvdUp9G+6cz0b8m7yVO3TSADVNidIOi6yZjJax7QvBRVgBQe8BJQb8k5HPDFFa9zrQE+N5Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853586; c=relaxed/simple;
	bh=mFaXjl6dZ1/2S3o232oCxEHpBK6iw6hUHR/OvwGcwxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJTn0jbWowfHjhN08haEXVdiiam3OFW1wpIZpvuceJIq3UhVyJx2zg0pCvzAmCMhOtSKISNye6PMIbUTSTNvKJhE3T//RNhf2qnopZp3WGt0qU6I7TYHwYX8oF87L9dYPMipd1RY4R1/or7MyPj6/pLqGNguQKNjJC4UxV6vxkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIC9N2QC; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aebbeba529so2110828e87.0
        for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 14:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782853583; cv=none;
        d=google.com; s=arc-20260327;
        b=V+mxlTZmz8s1R0+PPfKI1X2CdgwpuPYAFIlFL+vs0oKknfgAGlDiMH+zES3N79DYd4
         MBRB+NzWJZqUUQDJqkstxR6CnfzuqH3/3mGDyyZaKFPqqwcJhFWYL5V3ckW52zPBpXgz
         7zfdCgqH14m/QxCdPmpsGwelBEHAb61zxY5aq3nr1iydSN2AArMvczfWQFWlM/84ap+b
         SzjxyIM8S9oHR0+0h/vfVs6QLFHUat+tOrg9sI8o2CcyJn9Vzl2q8VcDdFBUjNa2IMJF
         0Uz7Zmqi2DucJYG1gHAcqx5K28fjfycfX65LHShqqSmY/nsQxTjI5boRETiLvsuOnp24
         SBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YcF+NbaiHR14liOaNUkioRurzY2meGEqjWBbBBaTOQY=;
        fh=8ha++ZqJHgcqUHY5BFA5s/TGImAioVdBfepMyGV8Qh4=;
        b=rEyugfAc0I3TbOuqPt/DofA9mly0TUjIGBYC/ksMy6+AbS10H4JVLbsCII5tALxWXe
         Xaef9hhjciEiL7Rx+8Am3M4mWzrbw6Kcu3s3W7y0LzWsB263bZ5VWjauElG5O3L9LbF5
         Ei8oNZIpZcpzEB61/0y4fF1wNCAo1H4SVUeGndQOlWFEqFUN9gCaqu8VMCuQfctkAsEy
         xZ07HPzaB/pmfcYiCdh6K/nkMtnoUv1ln0hJicoC2ECNp4oa7EU7BBw/+m6XV0coPHpz
         5ou4PznYKZF2DBU6OOqSnjtJJTcZe+wtYWeaCdQelYxQfvn4HJRO3jiJpXeOEMzn4qNt
         fBYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782853583; x=1783458383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcF+NbaiHR14liOaNUkioRurzY2meGEqjWBbBBaTOQY=;
        b=JIC9N2QCgWjf9Khrnd/h5Mi+p9HI5aZmfbC6WCY4b72YVSlWC4ynY+DlbMZ5MYBjNm
         nr/+7KmEpfUfrPzo1CJfrhz/BTXwfSl8S4ERThUGWWLGkoT+9XSnXM0Mk8Zc74wiWnlc
         5D1OAwCGLcuUHqwkmNxQHFKaFhmU7w9nqGqCO9Xl5wfR/paxmEgfdn7jxhr0+c1eiqFF
         SUcRlhq8c2DeAHCNHBYBiWw/l9g6sRPxbnFBsbw3Mxq3sF5yqlzQJwAF3LrOl4TkCkiT
         I3js2LIyoNUbaJU9QUlqK2czk58LVonyVfT7poD0LluO1nxE1e/F75Adbkp7VzP5cvob
         6ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782853583; x=1783458383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcF+NbaiHR14liOaNUkioRurzY2meGEqjWBbBBaTOQY=;
        b=GIMgyNxGr/EX0mjPlrwCRRDNlxEkOuiGmvnuY8Vkwf5h22GMVB8m1LZCShq9iflvSm
         k4Jxt3yP7nVCS8Sm5TSj6U5xKEpidb0f/weFo7zCG+62yzC5w3vuiS2rck0QZK5P+hsh
         H+0GEUC4ty6632xxCAQ7SzMPLblm/LSYwgZFom5avo43n5xmcAOPv8q5BeA0ZFftVVQ8
         uJ5h911FWI//l5r5dphSFlKqkQWWCsvGe3XtN1huAWvu2/Y0e7jxCdRHtrwTVQjT+uMQ
         flryYUjpaNygN6kvvwqVc7JdtiYcI+BX6si3EmQDGQEFSH2vvkSoUtgW6VriX+38IqUK
         Pqyw==
X-Gm-Message-State: AOJu0Yxn/jPSi45bhek6xPWjj81/tLA+0kiPqMppFJnhLLCojc2HgoD3
	QNesh78T+8GE/5hfAQYfhrhSanls8a3AKGIzW9+xlUkjmuK+cXEDMucju4MW5gmNF309PUQVESC
	G/wcaR8jM4adF/qNsL5pcd2vWP/HzD/g=
X-Gm-Gg: AfdE7cljUjgtxkut14u/ICoKAKDD3k8G+O/C1J05h9DnSZE0z6gYS8DboIusm6FEXYr
	CHy11LtSaTyEN6TSrbsSOpI9Wj5SDhp3pXOslHf8XPfb0Ed4aLblmsvkrP95k5OH3Q2wAJqjlND
	DYodahvD1wMerH4AmPIEvRvweGkVILWvoZj3EMVM4OmtfOCa/FByHRMwEhPiTGgKPcr2JqRmVPg
	tgh7Xepo39mPqmJWxu15hjqw5Fm0oYsGF07KEji8uoLrIRHavFvoagdsmbhYXsX/5/+Faw3McWQ
	iiSfuQLSVspHYOF/szhF4CIpSYA3EEd+d72N4I4BSNqfJBKn60jr00R6h05S5Pt0j7SEiooW6hW
	1YxW0nfp5NldKSvAwKPQO3krsX2Y=
X-Received: by 2002:a05:6512:3144:b0:5ae:b918:af30 with SMTP id
 2adb3069b0e04-5aec10a7085mr502707e87.4.1782853582682; Tue, 30 Jun 2026
 14:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609212531.22044-1-rosenp@gmail.com> <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
 <CAKxU2N-DELS8D=ZFk++s-AW-uZv4gKvqmKM0gzDdbGy2zvrGKw@mail.gmail.com> <4bbd8cad-581b-43a7-b644-f6202f7aa293@nvidia.com>
In-Reply-To: <4bbd8cad-581b-43a7-b644-f6202f7aa293@nvidia.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 30 Jun 2026 14:06:07 -0700
X-Gm-Features: AVVi8CduV4yaDwoDs3ZqEzXGSkubc0ROFEm-h-J0blBD0wrnaLCY5zozxL96TyY
Message-ID: <CAKxU2N-GX5grrSm75mfAUqDXiXcQ0xMUX5Sbd7CLvELpF=QNTw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11901-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A36816E8041

On Tue, Jun 30, 2026 at 5:17=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 30/06/2026 01:31, Rosen Penev wrote:
> > On Wed, Jun 10, 2026 at 1:43=E2=80=AFAM Jon Hunter <jonathanh@nvidia.co=
m> wrote:
> >>
> >>
> >> On 09/06/2026 22:25, Rosen Penev wrote:
> >>> Simpler to call devm_platform_ioremap_resource() as it returns multip=
le
> >>> error messages for whichever part fails.
> >>>
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>    v4: rebase and reword commit message
> >>>    v3: change subject
> >>>    v2: reword commit message
> >>>    drivers/dma/tegra210-adma.c | 12 +++---------
> >>>    1 file changed, 3 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.=
c
> >>> index ceaee1e33e68..21a381d022cf 100644
> >>> --- a/drivers/dma/tegra210-adma.c
> >>> +++ b/drivers/dma/tegra210-adma.c
> >>> @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_de=
vice *pdev)
> >>>                }
> >>>        } else {
> >>>                /* If no 'page' property found, then reg DT binding wo=
uld be legacy */
> >>> -             res_base =3D platform_get_resource(pdev, IORESOURCE_MEM=
, 0);
> >>> -             if (res_base) {
> >>> -                     tdma->base_addr =3D devm_ioremap_resource(&pdev=
->dev, res_base);
> >>> -                     if (IS_ERR(tdma->base_addr))
> >>> -                             return PTR_ERR(tdma->base_addr);
> >>> -             } else {
> >>> -                     return dev_err_probe(&pdev->dev, -ENODEV,
> >>> -                                          "failed to get memory reso=
urce\n");
> >>> -             }
> >>> +             tdma->base_addr =3D devm_platform_ioremap_resource(pdev=
, 0);
> >>> +             if (IS_ERR(tdma->base_addr))
> >>> +                     return PTR_ERR(tdma->base_addr);
> >>
> >> The dev_err_probe() was purposely added to assist debug. Please don't
> >> drop this.
> > If you're talking about the memory resource error,
> > devm_platform_ioremap_resource() prints
> >
> > ret =3D dev_err_probe(dev, -EINVAL, "invalid resource %pR\n", res);
>
> Well technically it is devm_ioremap_resource() that prints the above
> which was not obvious. So clarifying that in the commit message would be
> good.
I mentioned it returns multiple error messages.
>
> Jon
>
> --
> nvpublic
>


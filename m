Return-Path: <dmaengine+bounces-10076-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHB2Nu1Q52mL6gEAu9opvQ
	(envelope-from <dmaengine+bounces-10076-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 12:26:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD464397A9
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A35F303A9FE
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE738836A;
	Tue, 21 Apr 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2Qn1CPA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1C3A5E9E
	for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767165; cv=pass; b=VStVbKnk2WxDH58STDYgv6EYpWD1E3wpbXZNkDwav8uqlXVR3QsV54wX4c6LHFg+4hLDl2YBIhjWD1BrOdkGQfi8Jvk2Q8/UIjNmVkyQ2pk8jcSWwC/fYJCyeALn81iZ1wtTDDqQStl/fD1APhI8x5IW79SI/Jxu4hVDVKu88w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767165; c=relaxed/simple;
	bh=fzRXlMPHf81MpBz9M+qEmJle+xL6godSrHPGAUjKBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3ZqB6Wb71PKRpC5VhFi5G1YBlxw8neYTiWaty66hf2MtHb1wIIDHyhGRalaFcipF1AsVx67h3aMMr9PwqP0K8p82oSwU7v+zSct85Y7h59zzKQwPSLQR8OK/NgGE/Fz/W+x+nVQztsoo8xYFy9/U05PO4qYC9fzEOrnUiqDfPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2Qn1CPA; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso2709731a12.0
        for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2026 03:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776767164; cv=none;
        d=google.com; s=arc-20240605;
        b=BcvZwGkkI8+of7n8OwwSQ2lggklWQI0l0C09iSFDcojD27ecc8A51kPJBjR6lVaFtM
         7mOWndFdnRIGU//g6HatrqIEWuIz3gtuMKB3yZMBnsCNr35eeuPq/hRMofx9io4sZUAV
         UwvttWW0wUNoFHJppNY/Rz/Uxotcypc3lGguJkky7sJ4PUvtoMxTCf4bsmzOAwcJxQZ2
         UIxY9uCWhsGNOR+FkLLA0Q+FCOuUo9GRf82g2LpAp3nfUyzaaRp2H98yGX2hG8lnHJfx
         vl+dhAaXXo+I1kTrdUSQwFRcVtoi055O7J8iiIvgR+z22mjpZE13evDu+Kw8eu8PHlL/
         ZcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1FvfcveV+14dOucFk7RAnQhXMQK/CgP4W5FAbyii2JE=;
        fh=D5Dn95btu63JJ7o6p8syGlYYYcWsa7KiLGOzom2fPEA=;
        b=DWUc0gcNkoDrCnHEFuw/zbXzwaXsAox6TSJNH9+XdgZn+4uMnHJkYxndplUrVygPGa
         HGjRD+nOLwEPETnWHx95euRFi6pCd6K0frGaEeRikA3jhCaULyQCH7mhDOxdzG5chLMJ
         wap1+j9mG63d4DwKPAFs+BICPBi87/33EU7j4pAXFhio/++LBtMqfRXk5fixjxboTiSZ
         bAiA12Nefw91cL0A0AgRQHmwCGypwGpR8l4doNe49gbTuwR8M5DFND6wdKWBwMatAqOB
         gLeP5lQFRxgfi/rYPnIxbKVESGI1b6EYLY1iBhTpJd2TQbg4wsaB560OJoNDfV1aVG1I
         Bk+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767164; x=1777371964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FvfcveV+14dOucFk7RAnQhXMQK/CgP4W5FAbyii2JE=;
        b=o2Qn1CPAtI2ItiCzMWluC38xT1U94d2FON37cu622bGENnbcu5MBtde7GR3XIwKvk7
         Bw7qYYlucMsU2EphhoEF6lODYpYIcj3qR684OTQ3tI3XEbLaH+dB+9GOi5o+tqnOXa5a
         /vFGXhiL0fyPN/ImmRXKj6n2nzJAhwVoqOIl1QZ+uPoh+qv7Viu678W/T25AjJ3sMlHW
         Sd9g92hDZ6HGbNZTjkp7fZR+1FR+awpmSfSDgoq2+noWpcwJc4yyvEB6wwsfFLxMXPzy
         Z2U+rlLrfCc4fco3KXVOI17bamPC8ZYRCGIVUc2fPw2RsDVT9Mj1Ny7+x/gDHqSIFdCi
         oswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767164; x=1777371964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1FvfcveV+14dOucFk7RAnQhXMQK/CgP4W5FAbyii2JE=;
        b=pyvKX00FB7OqicCWRMelPYlu+0W3NW1OhrC3T+aCy/7NLbwBR7m6IvGorefuVfmWz7
         C32xL9CO+WOGVddwXxZlSd6lvYdNeKbMvSm7wDya/xWeExv6bqHPnVsLONPHZZ1hR64C
         z7mayLCd0LGDW5pOI5xiJ/LXRJgg2WK6GVHZ0bA5FIieATwoiudW65afow7/4LeMBxzQ
         yGm2OVpwfhi9sCMd598GoWBVTbqNMPuEr+J1+9kDsoyyYOU6bDyNuZq69D6K9tjMgAZD
         d4Ga5nXpW+ew1zO4AChbxpYlgOGQyWp4oBCbDPi9ChONnHfCWMPlfSvF+M0tm+w5FRQ5
         cPyA==
X-Forwarded-Encrypted: i=1; AFNElJ8ntr8GqndT25mDl3pn/4v8zUbwmhFZ0GL2/dq8fVhN6aMJRCeO6+4Tue3DzAHJaBKq3D50QDF8YA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkxTyFeu8DsPRQqObsjw9sQ6DTKmkY5saPUsLEHB+0nFbNCZT
	kcpUBlT7ByBoBLrA6PzoTI55Vw7bYenzyjZ4mZUCSRtAowOrBfCdcjTum7IsuS8qTXLQOkaM9B0
	oZPcMloGVqS7nDDbpJQkRq/xsKMvtQIM=
X-Gm-Gg: AeBDieuD8J7QlzfzfniZ8wiRtauBCvYheFcORqyK+/TRQESQxZBdbnMjEOuMSVF8JR2
	4Q8I54gw/7VNlpa7rwDh+l+txyIzTIuFvkN8Qt3hWg33Z5XA5x+9QRTm/XAvATPxJNYF0mWooN9
	l/ZOROMnf6KognYnXRvJnSSqh9aRLL1ZBAahDTZEpxxD3fTXoZX9Fpu/JZg7+pS/ud2dJu956vo
	WXwQh3vMHxK7KlL3HtllXxGYuYbnW4P+tdHPdAxsimy8TzmKBAzbaJ4FTUUuEvjjW3rM6VxOYhN
	ClSLtqSoHqXomXsWag==
X-Received: by 2002:a05:6a20:12c4:b0:398:8026:4811 with SMTP id
 adf61e73a8af0-3a08d8a8814mr21400230637.35.1776767163577; Tue, 21 Apr 2026
 03:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
 <lkwfzz4lia37wv56g6ymzpossm42epz2oylhl7vgdpp7odt23h@vszl4uu2wg65>
 <CAA+D8ANwT0GKusZtvo6h8mzVf=xXSEkHXsb6nwHGZ2YQzPm5ZQ@mail.gmail.com> <4xbeeozhngkkc66r3ho523vr45yksbyftdckfzwk72zfvwzgv2@7lodth3abysr>
In-Reply-To: <4xbeeozhngkkc66r3ho523vr45yksbyftdckfzwk72zfvwzgv2@7lodth3abysr>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 Apr 2026 18:25:51 +0800
X-Gm-Features: AQROBzDhXWgla_oCt6bVuib2j48W1hMySGsnPl8g4tOPNfdTT8qGzf6cm0imj8I
Message-ID: <CAA+D8ANwgkzKA2aDja=RTLeJX1s7-SfHS8FVC_cjKcRvbREFcA@mail.gmail.com>
Subject: Re: [PATCH V3] dmaengine: imx-sdma: Fix SPBA bus detection on
 multi-SPBA platforms
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, Frank.Li@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	dmaengine@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10076-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengjiuwang@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,30df0000:email,pengutronix.de:email]
X-Rspamd-Queue-Id: 5FD464397A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 5:44=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 26-04-21, Shengjiu Wang wrote:
> > On Tue, Apr 21, 2026 at 4:57=E2=80=AFPM Marco Felsch <m.felsch@pengutro=
nix.de> wrote:
> > >
> > > On 26-04-20, Shengjiu Wang wrote:
> > > > i.MX8M platforms have multiple SPBA buses under different AIPS buse=
s.
> > > > The current code searches the entire device tree and returns the fi=
rst
> > > > SPBA bus found, which may not be under the same AIPS bus as the SDM=
A
> > > > controller.
> > > >
> > > > This breaks SDMA P2P transfers because the SDMA script needs to kno=
w
> > > > if peripherals are on SPBA or AIPS to configure watermark levels
> > > > correctly. Using the wrong SPBA bus causes DMA timeouts and transfe=
r
> > > > failures.
> > > >
> > > > Fix by searching for the SPBA bus under the SDMA's parent node (AIP=
S)
> > > > first, then falling back to a global search for backward compatibil=
ity.
> > > >
> > > > Example device tree showing the issue:
> > > >   aips1 {
> > > >     spba1 { sai@...; };      /* Correct SPBA for sdma1 */
> > > >     sdma1@...;
> > > >   };
> > > >   aips2 {
> > > >     spba2 { uart@...; };     /* Wrong SPBA - found first by old cod=
e */
> > > >   };
> > > >
> > > > Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device sup=
port")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > > changs in v3:
> > > > - add fallback to a global search for backward compatibility, which=
 is
> > > >   to address comments from sashiko.dev
> > > > - update commit subject and commit message
> > > > - add comments in code.
> > > > - add Cc stable tag
> > > > - Don't add Frank's RB on v2 as there are several other changes.
> > > >
> > > > changes in v2:
> > > > - add fixes tag
> > > > - use __free(device_node) for auto release.
> > > >
> > > >  drivers/dma/imx-sdma.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > > index 3d527883776b..592705af2319 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -2364,7 +2364,18 @@ static int sdma_probe(struct platform_device=
 *pdev)
> > > >                       return dev_err_probe(&pdev->dev, ret,
> > > >                                            "failed to register cont=
roller\n");
> > > >
> > > > -             spba_bus =3D of_find_compatible_node(NULL, NULL, "fsl=
,spba-bus");
> > > > +             /*
> > > > +              * On i.MX8M platforms with multiple SPBA buses, we n=
eed to find
> > > > +              * the SPBA bus that's under the same AIPS bus as thi=
s SDMA controller.
> > > > +              * First check the SDMA's parent (AIPS bus) for a chi=
ld SPBA bus.
> > > > +              * If not found, fall back to searching the entire de=
vice tree for
> > > > +              * backward compatibility with older platforms.
> > > > +              */
> > > > +             struct device_node *sdma_parent_np __free(device_node=
) =3D of_get_parent(np);
> > > > +
> > > > +             spba_bus =3D of_get_compatible_child(sdma_parent_np, =
"fsl,spba-bus");
> > > > +             if (!spba_bus)
> > > > +                     spba_bus =3D of_find_compatible_node(NULL, NU=
LL, "fsl,spba-bus");
> > >
> > > And yet the search is still broken for i.MX8MP case since this platfo=
rm
> > > has two sdma engines below the bus@30df0000.
> >
> > I tested on i.MX8MP. It works.  Above line is for backward compatibilit=
y
> >
> > The search has no dependence on the number of sdma engines. It searches=
 the
> > spba-bus, not the sdma node. it will find the aips5 first, then find
> > the spba-bus for
> > sdma2 and sdma3.
>
> And you're abosulte certain that NXP doesn't introduce a 2nd SPBA bus
> below the same AIPS in which case the driver is broken again?

Good question. Currently there are no two SPBA buses in the same AIPS
for all existing i.MX platforms and there is no such plan in the
current roadmap,
SDMA is replaced by EDMA from i.MX9.

>
> Sorry for beeing a bit picky. I do see that NXP decided to drop the SDMA
> for i.MX9, at least I don't find any reference in which case I'm fine
> with the patch.

Thanks.  The change should be safe.

Best regards
Shengjiu Wang


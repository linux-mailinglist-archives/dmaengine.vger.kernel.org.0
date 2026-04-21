Return-Path: <dmaengine+bounces-10074-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMK5DudA52no5QEAu9opvQ
	(envelope-from <dmaengine+bounces-10074-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 11:18:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC75438BA0
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7AE300696B
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6E3A1E73;
	Tue, 21 Apr 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTH01MkT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276303A1E6A
	for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762851; cv=pass; b=RPRrRnW3oc3qVS+5sUT+u48gwRHgOK9KtjA8meEm37Y8I80GHfhbRYQRtYs221CiNz+kANAZUe63qjwsczWzStlD95AZpDTo5rhle+lC3tlxCPCejsZO05NPTTxuk9X3S79GyQ/2sfbvlc+2Ink+KltpviyD3F16QNZx/5JUZzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762851; c=relaxed/simple;
	bh=ZzRwQS2qgmALD6SzLJul7x1AeveQ3d2kpARqQZFKsiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkFmwCnBMWnpXUJgpmzOlumoRyvXUdJoh7VAzBfDwDdsAmQYHr49sW4ypUFH5NIl9WpWV7T6911zSlzvr8E7a1jT4X1jVCTbTcitajUFnNtx4Dvhy6BHG776eZzBqimnOlAHGimvzrFhEl1U4IuZaSefKiQ8+POiANY8SXnaOYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTH01MkT; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b299b3c739so18193875ad.3
        for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2026 02:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776762849; cv=none;
        d=google.com; s=arc-20240605;
        b=F+jwMYX0GhYdsdX/U+6im7/Qd8FrPFrE1rCD2kEVXxJDWvXvrM+AssoJuVQnG541ho
         xbD6walnCdcukbK78huOuTbEP3ALBEWxfCh6HR95WkcyeZTm8cxFSmdWP0JTghFsYig4
         DCKiWj/o2ZNLNHXhlaP9HgASTM8Sc+aCkoQqvDMRlVoIsjBho2HIYRCvnOoG92MAOf9b
         iQ2j0nfPwRXr/caZbeHGpE2JSiwq1brMk0iWe1urVvPA2BbEWMlif9iEveh92sATRPuo
         C12wIBZ15z6u5bsz4DPQHNPJ9taegRBE8O/IRil82QO7hXw0ey+C/S+p9TvDMuNXShiI
         EBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuf/J2tmMgGjZTkx9qFzoIJKXecVr6IXY6lWgVYmZ1s=;
        fh=bzt4XsTb7Z0yi0JwoeDFj83n8lo7ZUAbsPiDCCcjJ4w=;
        b=llCo8XAw9kbfw2lnzUGfUcQw60eJyo25OGQsYYApVABmY3xe2Bzmm8kAKH9ZuAzrM5
         UvJYu/deSF88LYz0KVz+wYh8MeGHFAlqraELbkRyFIEIN+1hxsSSKDn1lBkDvTb6lk3Y
         jG77LZK4lJ6lV6GBzlciYGK4F2ik3I421XAlKPbEuarbvnYhffhxq5hEocV1edA5lOTR
         GV9XaCQ6aqpaqilP8/zOwYhgAmfasBNFI9xksDCUBEd5vC6FXdNm0PLMw0vBpS+2NLL1
         kz77ixJPvti84WNTj2Mu+NXVumVp/fyNg0Us45E53gSfP7z05tyWTdLmwZYZDsQdOtBj
         wRpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776762849; x=1777367649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuf/J2tmMgGjZTkx9qFzoIJKXecVr6IXY6lWgVYmZ1s=;
        b=GTH01MkT4jvqnaTH3NBbXpuoaqGzYssGxAyYXqO+YzTcUOhGNd/XLQI2f+t0ulX+ke
         LuMgtx15q7DN4lxRnNzP25JHpBW6AC7SJu7k6///VWBhjCE2EzICsCOee76CP9wTNKg7
         r45/q1ft0r7Q4V0b4rlH9NFL33y9/1mIVZAltx+8Ah8ayshiWkh2QORWEOg5aHdlRbT9
         RuQNfibH1uI3a2X2LsqmQN74LS3tHgBQFoqi0lZSt+XcSOG7rpgzQksybHXBtCGpLK1V
         EzCJFqmI+vsExVTao/fXbprS26tUZcmIpHrTM8WGi6uCQno7MmFTa6Ht44KgqZ4pE3wS
         hl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762849; x=1777367649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuf/J2tmMgGjZTkx9qFzoIJKXecVr6IXY6lWgVYmZ1s=;
        b=lqE6AkFIga9oqCAeto+PyfxqyEwV+sy33HV1gYSLRnWOU8N2q4MpOBiEZ6O4vPhvL/
         5Rakk4kvRkAATQCYNsNdo8Aq2D1OicEiAJF8rs3h/11p2doQ8kzw05VT7Nw7njrtcf3u
         aL7FXerrFNSfY8oG2f3xC5hObB1NKQW6zJ2zc8cEs0iQKxbt1tY76N8KbaP2FrLbaYji
         O5AqvE9DmgjBSX33E/Vl/bp9Ro9agAq+gq6wPKmNnuD5B6v0Rgl/XYeYojGoZYObQo0J
         luqmbQH7J2n+UH65i4BjFDIojlDUjXMrk5F3WwY/kUyixWYyL99I7rMxeIHg0NAtZd6t
         Bhag==
X-Forwarded-Encrypted: i=1; AFNElJ8jbmtLx6SHU/3sOFA8T8/OwkLjlhFnTkFGhgrwOcMkhLHT+OvAOFa/4wJukTbioz9IzJZ0ICOsbtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4czvde89tQBXV8T8Q3XTO+ED5Dzcmx9Y22cM9DJOxm2GnJVT
	bZ6xsDcUjZ36/zOpzEksf3lsLUh8hpIWk4xfYuUXx9FtJGtZZRobTHwEjnjHQBn576Z/Glyk+gu
	7u3btH92xfL/occqsfVmyAwQqPnUsB6E=
X-Gm-Gg: AeBDietAiI80FaVsJsTaTFS5Aee5fumMRh95cs2g2rXjN4hEqv8ePSAusWaALOfUvQ4
	2n+c8iUoG5AtmHVTZEM4xnak9rZmimeWbor23ek5BFCm1PpIcMxeefHwVjzKZ+q5BTL6fHLL2da
	iXh20mBetLZcfDxVPYdiuP6GVlw1BjMTVIoZaZP1emVsUoPcQ5TGUGnlw0jG/22TwocucTs4dHB
	3zXqCbQWGGfnF0sHnE7AcBpDZGN8QCcAC2FZwmj97qCRa8a09h9mGnlO/b+TzZYgug8NW27N1Fk
	rGs/IviYPSP/eOyY8Q==
X-Received: by 2002:a17:903:1aae:b0:2b2:45b7:306e with SMTP id
 d9443c01a7336-2b5f9e85fa7mr170155595ad.3.1776762849302; Tue, 21 Apr 2026
 02:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420100854.2095549-1-shengjiu.wang@nxp.com> <lkwfzz4lia37wv56g6ymzpossm42epz2oylhl7vgdpp7odt23h@vszl4uu2wg65>
In-Reply-To: <lkwfzz4lia37wv56g6ymzpossm42epz2oylhl7vgdpp7odt23h@vszl4uu2wg65>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 Apr 2026 17:13:57 +0800
X-Gm-Features: AQROBzBWcJIwpzrKFBZScNTFM92k2xv5PUM8F5xurNN76m464r4UBrs-7HGJBag
Message-ID: <CAA+D8ANwT0GKusZtvo6h8mzVf=xXSEkHXsb6nwHGZ2YQzPm5ZQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10074-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,pengutronix.de:url,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,30df0000:email,sashiko.dev:url,30c00000:email]
X-Rspamd-Queue-Id: 8AC75438BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 4:57=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 26-04-20, Shengjiu Wang wrote:
> > i.MX8M platforms have multiple SPBA buses under different AIPS buses.
> > The current code searches the entire device tree and returns the first
> > SPBA bus found, which may not be under the same AIPS bus as the SDMA
> > controller.
> >
> > This breaks SDMA P2P transfers because the SDMA script needs to know
> > if peripherals are on SPBA or AIPS to configure watermark levels
> > correctly. Using the wrong SPBA bus causes DMA timeouts and transfer
> > failures.
> >
> > Fix by searching for the SPBA bus under the SDMA's parent node (AIPS)
> > first, then falling back to a global search for backward compatibility.
> >
> > Example device tree showing the issue:
> >   aips1 {
> >     spba1 { sai@...; };      /* Correct SPBA for sdma1 */
> >     sdma1@...;
> >   };
> >   aips2 {
> >     spba2 { uart@...; };     /* Wrong SPBA - found first by old code */
> >   };
> >
> > Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changs in v3:
> > - add fallback to a global search for backward compatibility, which is
> >   to address comments from sashiko.dev
> > - update commit subject and commit message
> > - add comments in code.
> > - add Cc stable tag
> > - Don't add Frank's RB on v2 as there are several other changes.
> >
> > changes in v2:
> > - add fixes tag
> > - use __free(device_node) for auto release.
> >
> >  drivers/dma/imx-sdma.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 3d527883776b..592705af2319 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -2364,7 +2364,18 @@ static int sdma_probe(struct platform_device *pd=
ev)
> >                       return dev_err_probe(&pdev->dev, ret,
> >                                            "failed to register controll=
er\n");
> >
> > -             spba_bus =3D of_find_compatible_node(NULL, NULL, "fsl,spb=
a-bus");
> > +             /*
> > +              * On i.MX8M platforms with multiple SPBA buses, we need =
to find
> > +              * the SPBA bus that's under the same AIPS bus as this SD=
MA controller.
> > +              * First check the SDMA's parent (AIPS bus) for a child S=
PBA bus.
> > +              * If not found, fall back to searching the entire device=
 tree for
> > +              * backward compatibility with older platforms.
> > +              */
> > +             struct device_node *sdma_parent_np __free(device_node) =
=3D of_get_parent(np);
> > +
> > +             spba_bus =3D of_get_compatible_child(sdma_parent_np, "fsl=
,spba-bus");
> > +             if (!spba_bus)
> > +                     spba_bus =3D of_find_compatible_node(NULL, NULL, =
"fsl,spba-bus");
>
> And yet the search is still broken for i.MX8MP case since this platform
> has two sdma engines below the bus@30df0000.

I tested on i.MX8MP. It works.  Above line is for backward compatibility

The search has no dependence on the number of sdma engines. It searches the
spba-bus, not the sdma node. it will find the aips5 first, then find
the spba-bus for
sdma2 and sdma3.

aips5: bus@30df0000 {
      spba-bus@30c00000 {
       }
       sdma2: dma-controller@30e10000 {
       }
       sdma3: dma-controller@30e00000 {
      }
}

Best regards
Shengjiu Wang

>
> Regards,
>   Marco
>
> >               ret =3D of_address_to_resource(spba_bus, 0, &spba_res);
> >               if (!ret) {
> >                       sdma->spba_start_addr =3D spba_res.start;
> > --
> > 2.34.1
> >
> >
> >
>
> --
> #gernperDu
> #CallMeByMyFirstName
>
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | https://www.pengutronix.de/ =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    =
|
>


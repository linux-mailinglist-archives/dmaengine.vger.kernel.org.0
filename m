Return-Path: <dmaengine+bounces-8759-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOfcBCyehGmI3wMAu9opvQ
	(envelope-from <dmaengine+bounces-8759-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:42:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52685F36F3
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A8B300463F
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89E278E63;
	Thu,  5 Feb 2026 13:42:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3227BF6C
	for <dmaengine@vger.kernel.org>; Thu,  5 Feb 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298920; cv=none; b=fiaRf6iBDnly6a6nMZdrpfu9mftMRmc6KrgxdbqQL5Np0uOIS3vtRpiOOjyK569xu7cWmHdanmZd5Lxfy5HbFA6npLobtiWIBJRxB5FMmeC/Lk2fYfS32KxWhqAN2ZoZ+69niMn8kO5hkA2Lhcy2G+9Dcl20NXIlu7/LeCToZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298920; c=relaxed/simple;
	bh=MvdDi56nBcqeVhfFS06RPVpbBEwUFgl1c2WoubkP7c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH2Vieh3L8NGBuh6eUniEjyd6BJC9x2qj0uHsRPnkuzIZy5ncWIAtfhfMT4HjHg16yEcjweKxUsY8pyAvwLri7xFmjyyD49m+xhcaxXHUP8wuLtfugFBkbGTbClq3oP7dNG225GxHgLjFUYbDu7q09vxGrqnU34uV3eFZqIq9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c69ffb226eso124317185a.1
        for <dmaengine@vger.kernel.org>; Thu, 05 Feb 2026 05:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770298919; x=1770903719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlFVvwC8fg/1wsOmrxHFIGxiwllHqY5skW1aHs4QBXc=;
        b=weFOJZkgkEXf69KsvagUKaCr6UUKqX03WZ/Cb6cD4WRubOxAucOYk0ftdRqIoeQdem
         hntGtVnU/I6iVNcgZb110m77W12CHUYMUSk4S0h8ZLn49MvoYMfWmKtpx+g+HFxgXPAH
         zmzYo7ymME+hGtD25EHE5cXpJ0tKFviUqsgTSyYveFBnFp58gqNMOPmaIfXvKDnrU3MH
         7RiemsLfuma/r9YjKhnFrmBC6m4e9mWAiYiaMVp0/FsNmy5W1L6DLA+xlZK4bRyFZfIY
         Yq8vAQxzhKXroPobuvCtEYgxvjQBNKRd4mJN2772cfmpdyfrVZgl12H7u3Q9NUghf0WD
         O02w==
X-Forwarded-Encrypted: i=1; AJvYcCVH9q3wyNCOCSTPU/Jg3b7g77DqNHUAFQvj/eyILStmjrT3bd33iyWLJy0bAuKFsBn6CbMn17xz+eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8teOEDVJxyevxtBoQm03qNSOYbEcysQNEOpiyASj8fUTEntJ
	Cjk9R+dkpwSG3uMt+xsYIgViYqJioIkrt8uxZam9i71WpL/gK/rzwE8ljRNFPLs+
X-Gm-Gg: AZuq6aLpA02qgmrYA8r5z6Del8VhD17yA2xaWfDGWkhKype2w8YrNVTiINpt55ElAVQ
	p1zLxd7UycC1NbA9Ve4++208iitT645sQodpAxMOP0DaTsoCRRimwcFY+PUs3Ko5W7dr44qWOdM
	rwbgG5SYbvkepR2zaUcZ4GMyZ21snP+v3Pl5ft/f5o5sRPQH8Caz2kKEcJW96hyaWMSAbveKbPF
	YRJy/sLwAd7mB/7+GrQ79naLCzQUAPdEAVUZFn36QQ3aJ1HY9nuAXNmVtKLpTimyCrb05jaUHdF
	zBs0RiD1mBXahzbnxJ/rE4HEsC1jGtCupyqUqhSvkFs62Zk7WkfDKu0O31GMzvKCwwOB/DckCjr
	2Yw3Ifer2ktH9JSSc7Q69XM2VqnqY+Njhc6ON0uC7BHonEm6bYDkq7rz7SMBKdQE+ZXmv7fHpRM
	qkPSXVeSKNhmWhYSwss3CmKhZVXwxXqi1t8ziDI8mo7pW4nyL/aPK69WiynbFsXWw=
X-Received: by 2002:a05:620a:1714:b0:8c6:a84e:2a2d with SMTP id af79cd13be357-8ca2f83c034mr886128485a.31.1770298918671;
        Thu, 05 Feb 2026 05:41:58 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8e8ccsm402967585a.21.2026.02.05.05.41.58
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:41:58 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6a822068eso115292585a.3
        for <dmaengine@vger.kernel.org>; Thu, 05 Feb 2026 05:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbOkxLnJrYZb6/r3r/u7i2gIvYPoQJY7sGkrcJRPaswiqZZR8NGlqVutOOE4gCEbfTkFousX/es6w=@vger.kernel.org
X-Received: by 2002:a05:6102:38c6:b0:5db:3111:9330 with SMTP id
 ada2fe7eead31-5f9395a4fbfmr1887930137.27.1770298443995; Thu, 05 Feb 2026
 05:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev> <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev> <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev> <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev> <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Feb 2026 14:33:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
X-Gm-Features: AZwV_Qi97SNEv7WiclTdTjDZPIBKqJuIZIg8jIizASzQUOTxleO9LeGP-MsKx4c
Message-ID: <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
Subject: Re: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tuxon.dev,kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8759-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tuxon.dev:email,mail.gmail.com:mid,linux-m68k.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52685F36F3
X-Rspamd-Action: no action

Hi Biju,

On Thu, 5 Feb 2026 at 14:30, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > On 1/26/26 17:28, Biju Das wrote:
> > >> For s2idle issue on RZ/G3L is DMA device is in asserted state, not
> > >> forwarding any IRQ to cpu for wakeup.
> > >>
> > >> For S2RAM issue on RZ/G3L is during suspend hardware turns DMAACLK
> > >> off/ Asserted state. Clock framwork is not turning On DMAACLK as it critical clk.
> > >>
> > >> Can you please check your TF-A for the second case? First case,
> > >> RZ/G3S may ok for reset assert state, it can forward IRQs to CPU.
> > >
> > > Just to summarize, currently there are 2 differences identified between RZ/G3S and RZ/G3L:
> > >
> > > SoC differences for s2idle:
> > >
> > > RZ/G3S: Can wake the system if the DMA device is in the assert state
> > >
> > > RZ/G3L: Cannot wake the system if the DMA device is in the assert state.
> > >
> > >
> > > TF-A differences for s2ram:
> > >
> > > RZ/G3S: TF_A turns on DMA_ACLK during boot/resume.
> > >
> > > RZ/G3L: TF_A does not handle DMA_ACLK during boot/resume.
> >
> > I'm seeing at [1] you are addressing these differences in the clock/reset drivers. With that, are you
> > still considering this patch is breaking your system?
>
> Still, thinking whether to add critical reset or go with SoC quirk in DMA driver.
> Some SoCs need DMA should be deasserted like critical clock
> that can be handled either
>
> 1) Add a simple SoC quirk in DMA driver
>
> Or
>
> 2) Implement critical reset in SoC specific clock driver and check for all resets.
>
> Is simple SoC quirk in DMA driver, something can be done for RZ/G2L family SoCs?

What if the DMA driver is not enabled?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


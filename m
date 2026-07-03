Return-Path: <dmaengine+bounces-12028-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TzuPFzsiSGrGmgAAu9opvQ
	(envelope-from <dmaengine+bounces-12028-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 22:57:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F3705A79
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 22:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aiQRNQq5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12028-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12028-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9C33011104
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF134C9AD;
	Fri,  3 Jul 2026 20:57:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD72FE0F
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 20:57:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112248; cv=none; b=rhNqiWYdNFXTW0yr/JdWrcu+davyLa8G19ZL+R2GxDvTxMhZJ10DT4qRkSi/7Qjnm+HCVnFbL6uZjxVn8TqxT3mleNkCV7LF1CV25HFEK3Fl5l9HwqUSHY45SjQma498I3cmBJxBuGC3ueVWWzJvvBy54DSN0yj5ntW5LjjZXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112248; c=relaxed/simple;
	bh=owKNuZPwGizoY/2HoaPNsqYew6wKbLa6JivEhSPbWXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH7sADn9NoYeo0lcrBwRadPFHeEwPN0dhljDVMZ5L3MjGB/IreFw8aFAS+cfo4kKyQB2/lTucUYyuHqcDPZfjhQ5BWEr1+ey95BDkWsJswwGEPZQZOclM5OxrSKCxXPA3RJWGCNY14L+m9KVu0cT9gDjohk/spnRj2zKClBIpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiQRNQq5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07551F00A3D
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112246;
	bh=Y25vXV3t1GCxqlAl1osZrotdon2GGO2WDyL2Qc56+ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aiQRNQq55eymVHbQFXIbokkf0/A9R+VyD0Z+MDi8MICBy9t/74ZLuWnb/dXsxG+C5
	 eDUmpx5nsmQEj4OEEfHqck8a0skRlyEVrSUKFMuLngmUujWUaPl18K853LeZ0MzCxo
	 0/+HPcavAynqDpu8D2TifjvhRoGGPrq6mWcO9WpOp72gTR2qQ2SmBRiSBwvsq93bGf
	 g4lruNT3uSvWaJEgqd50kLkg1vPHKDUuHRiVhglt6c3icWQrD0f21rmNzlvHxC2Zei
	 VayNErRxc1Mre1pbvHBRqyVjjI4hAENAbNYfLfh8XHz7G/v5O7OC/tlNWcViN7DtPQ
	 /A+zIaGrhja/w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1062548e87.2
        for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 13:57:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqn57wuwSRMHgp7xdEbRDZZQJZDbPW/1j8OVA4Tm6FPyXVN5ErjIh098vJJL/6L6zPb1jqQFFD2yBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLj/euDvWCYoZG9wpP/CDeLgUlGnnmGXD/aB5/uwVRdhJs9apD
	eGJ9K2BJK/xXgucqR9mzUvvngpEn30+bRzRK1s4DBIW2KWj+4UIs2Mb4ItI3ixSecJENG+4BCD1
	8+OzbOaWVrZtB7Eyv0MF4PDD0irfoWus=
X-Received: by 2002:a05:6512:4041:b0:5ae:bba5:aee8 with SMTP id
 2adb3069b0e04-5aed50953famr82424e87.24.1783112245519; Fri, 03 Jul 2026
 13:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org> <20260702155113.GW2108533@google.com>
In-Reply-To: <20260702155113.GW2108533@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 22:57:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
X-Gm-Features: AVVi8CfHunFNc0klBzqgomE1zDWiF88K1FZrzxv0woj_6dulz5xhJDaFP-6xKg4
Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12028-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA6F3705A79

On Thu, Jul 2, 2026 at 5:51=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Thu, 18 Jun 2026, Linus Walleij wrote:
>
> > Remove the obsolete DB8500 PRCMU regulator drivers.
> >
> > Drop the regulator build hooks now that EPODs are power domains.
> >
> > Keep the MFD cell around because a later patch reuses it for a
> > small compatibility regulator driver.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> >  drivers/mfd/db8500-prcmu.c             | 239 +---------------
> >  drivers/regulator/Kconfig              |  12 -
> >  drivers/regulator/Makefile             |   2 -
> >  drivers/regulator/db8500-prcmu.c       | 501 -------------------------=
--------
> >  drivers/regulator/dbx500-prcmu.c       | 155 ----------
> >  drivers/regulator/dbx500-prcmu.h       |  55 ----
> >  include/linux/regulator/db8500-prcmu.h |  38 ---
> >  7 files changed, 1 insertion(+), 1001 deletions(-)
>
> Any deps?

Not really, was planning to split off the stuff that can go
directly to MFD and resend it with all the ACKs.

Yours,
Linus Walleij


Return-Path: <dmaengine+bounces-12360-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNq1NhQSVGqthgMAu9opvQ
	(envelope-from <dmaengine+bounces-12360-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:15:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89F7461EF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XSeOSyFq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12360-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12360-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABD4C300A7D6
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8B30D3FF;
	Sun, 12 Jul 2026 22:15:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C12BEC2B
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 22:15:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894525; cv=pass; b=A/Cv/NVid9Y6ny62dp0Q+XJb1m+rsYTqcPGZVOqjhHyPVduqZFcyPH+OZvTJC7/eiXsoif05AWJLhzzbjyILV9Ixt1IDINDJPGvqqv6QnN4TTyS2QOZ0eKQh8iyC4B/e8YFy5HHqZwwJl0hWHVIRiSj+wrh0LtxQRnk3crzDgug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894525; c=relaxed/simple;
	bh=0fCXXFEDAD7mvMeuL7r7BbbiMn8MPj1+tl1viAJTJfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8Fd27lmQc2WhH4HdGrShezltDcJrih+EmIonffZiTFcPMWqDWPJe9LlFGJFpiieIQNwztWzpN+w8LJs2lyYHwxWyar8YlDmOTPFLELrqRYOOSBQ+2mTVYvn3QEUyz6qQW/USPpXWt/sXz7BGdfDhO2GbZbPSfD7o6OzQ4KgUus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSeOSyFq; arc=pass smtp.client-ip=209.85.167.54
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aea0fff535so2697670e87.3
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 15:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783894522; cv=none;
        d=google.com; s=arc-20260327;
        b=kfZxpKUN6s4MlLpyveFHZ3sQCEoxc3WF5/f7Nd0+SWsDXCID7VumTgKBOyZqh7fzSW
         V8lpG+EagrfTmliNXNGtZf/XNd9oUUoCbRpU67Kf/yQxkMt0mdonogxBwEX5vQEGgtnK
         9WRmbeWIV6uscHsz98OuL5r4NankTn8ReuR/kVEOobNQ25/JPxCXMKv2z2DbFdRE9vZs
         bCpoYAMgd2tbdyKF4/2MdsEu1y49bpTbCoIC7YVuRyRC/SvtI34E8MWB2E+ADS9+4Dxw
         nltqv3dFCDeyp4xaKKtcTO36cg7s3DKz5NznaknpX9M7s3KUkj62weZY5vsAgXmVAxiX
         DwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzFgxOk+HAGOIQ1gtBaMzwBhzfd5e2hGicmuSHTdE00=;
        fh=a7lQY6lk2Y6O9Q1q8mUmO18zNkvELhwLo4LTw/IERqA=;
        b=Ugt9uhDCKu6xB9AjVv4jPKF7eyFikRLkcu/t4WjP+NKFVb7slaqFytswCpQtUCLZG1
         9NRFwIo3VirT5X9vEu8l60nFJ5j6r3tyF1z+/8j2VBaN/Qmthm10OZIYKEyh2l1GcIl0
         XEiSx7f5ObOeoaz/Ug0FZi83EvLo1Xr9gykDJ6JGsAGL620SBE/vroHkpP7YPpoD2nyM
         Tl9FGSHbJ4fXdrWELdIu26vJ3P7tMcV73fgRGhq9efzjJYTF+AdfKgF3G4H5fWcB6Rbi
         fAknSnoX6EHp7UqFezcf/tQdFcIx6vLQ0KcIaLw6Xfx0HGDEgN3bB+81vJS+Fp6v0PUz
         AwNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783894522; x=1784499322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dzFgxOk+HAGOIQ1gtBaMzwBhzfd5e2hGicmuSHTdE00=;
        b=XSeOSyFqCEeqo0ufaLuccFawQO9uj/t2a8wNuy0GGmN+BcgYfsB3/mAkSxtgTtUp/+
         nyEQe2w/SYhziEVoSajiezoId2BwqB9SgRuaJ6+XN54ctS4RbJHYHIQpGESqq3Tnhsha
         FGG4WW4ZS6pQ81Dr3KdZL4xpjxYlpCzp5yV5j6b8srS1WUv4fkIVn2wS6+pmFJU5Jgy4
         O7JPQq2JsZslOkM+vVMXdF0xWHTXMzTycCZFqTn3/+KY4BZDjGbk4YjOm7an1TZzVBcg
         dkvc+g3l+ou3Z3K9DIy5/VEYTo8n48kpaelKxmmF9Jj7VenCHIH96DvTtDueds5lqz3T
         VEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894522; x=1784499322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzFgxOk+HAGOIQ1gtBaMzwBhzfd5e2hGicmuSHTdE00=;
        b=T1qPu3B0gyXHaYJ9TEFLzdMLX94+F6AhQ63ecp8D7a4YzT8onlvm6zjOSCG+ek3wnM
         c2IbvIA/5vFaKTMasY11+cjA+fohQdmAcsmYopM4GX065+5q0iLDyv7HTLhs7Fk3w5aS
         a8jWHqKU7N4TjDyQADHYroYM3rCcpq2ZnKBcjEE3Vj0iE5mEURspsNHqkCIYNmoPEZyg
         QUXFPc2nkBxIsX+61GtvjB7LHlXRclVUcQizEwCRJBuOHwMwUfllC/5O4mFCe3VBQHol
         IlNKpqMSe+zXzOx2mENL0u3A0Kowx87CZGTN1aPtAmP4/ieQ0ndkUITvKnoE6pTptJZQ
         F2Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqCOAdl0GiXqMUmUJlDFRO1YY9prKuerP2JXI0Do8sfMKVqZuHKbZt844UM40vcGLPbefIGNay6RyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbN+hEvANlGpwg13gnlbAkoVERMaYPC/s7c4ww2oMt8yO4/cPN
	JrgnCZ9lUYP6RglGZ2joQZ0JUZfLqEecji8JMInTVAuJkNyC0c4ydOS0w5tw+tzNbz0dqJxp1vu
	lfuwh+z2G6YPwKj3V3d5EEA96h8zfbYo=
X-Gm-Gg: AfdE7cmLc81oMMVDO0kyZBiLDDQK+Fp6UrwLF51MYkiFC8WoTKAyIp7R9E8gm8iFfTq
	Q1isthjoSc8DBAyV6b933gV/bHT2fdJll6kAYyj9QlMS8nIN+yrwB/v8xir9zF7OVA4bZMwhaLE
	OqEREc264EQWbMQjTzBbQ7O0SzHAUiH2jU3s6iHM5TeypJV7GGnARAgrkIz8rzGhxXCUXY9ZOC1
	YSLH7jztpUFA+zm9iQV1gcEoOQKUsGJytqJetUqDASkVAaRyCyhItojSMPQdGYud/exCvv3uEyQ
	Bvw7ASNdYyvgWDj59RafJObcNFkhAfdzhW5qeYTjzyv+9g0E1K7HQJ2NRYE0ViCrifX6I7D4STw
	L2r0Obt1RAROCOkkymmE20aKAvvhyA60rsnFd4fvCCfMXmw8l5fzBvpA8ftStj25izABZ4x+BBu
	nHjLo6OFE=
X-Received: by 2002:a05:6512:159e:b0:5b0:20c6:a9b6 with SMTP id
 2adb3069b0e04-5b0236b9303mr1400872e87.56.1783894521684; Sun, 12 Jul 2026
 15:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712220039.924958-1-rosenp@gmail.com> <20260712220039.924958-2-rosenp@gmail.com>
 <20260712221110.7A0531F000E9@smtp.kernel.org>
In-Reply-To: <20260712221110.7A0531F000E9@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 12 Jul 2026 15:15:09 -0700
X-Gm-Features: AUfX_myv349aji-6oOm_gzkc6hXvmyh7Nl69nJb30alWyDMkR4Sb-h3tn5_dgE4
Message-ID: <CAKxU2N-w_Uccz=upLvOVBGVy5p5UYYv8+znhc4w1rM2d8b-pQQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] dmaengine: idma64: use kzalloc_flex
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12360-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F89F7461EF

On Sun, Jul 12, 2026 at 3:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] If `idma64_prep_slave_sg()` is called with `sg_len =3D=3D 0`, it=
 eventually calls `idma64_desc_fill()` which accesses `desc->hw[UINT_MAX]`,=
 causing a kernel panic.
Fixed in the second patch. This is just sashiko being broken with v2 patche=
s.
> --
>
> --- Patch [1]: [PATCHv2 1/2] dmaengine: idma64: use kzalloc_flex ---
> commit 54aec29a1bbe69497782adf915ba6169fd73e345
> Author: Rosen Penev <rosenp@gmail.com>
>
> dmaengine: idma64: use kzalloc_flex
>
> This commit refactors the idma64_desc and idma64 structures to use flexib=
le
> array members. It simplifies allocations by using kzalloc_flex and adds
> __counted_by annotations for runtime bounds checking.
>
> > diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
> > index 5fcd1befc92da..d914f50ec3096 100644
> > --- a/drivers/dma/idma64.c
> > +++ b/drivers/dma/idma64.c
> [ ... ]
> > @@ -307,10 +289,12 @@ static struct dma_async_tx_descriptor *idma64_pre=
p_slave_sg(
> >       struct scatterlist *sg;
> >       unsigned int i;
> >
> > -     desc =3D idma64_alloc_desc(sg_len);
> > +     desc =3D kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
> >       if (!desc)
> >               return NULL;
> >
> > +     desc->ndesc =3D sg_len;
> > +
>
> [Severity: High]
> This is a pre-existing issue, but can this lead to an out-of-bounds acces=
s
> if idma64_prep_slave_sg() is called with sg_len =3D=3D 0?
>
> If sg_len is 0, desc->ndesc is set to 0 and the for_each_sg() loop is
> bypassed. The function then calls idma64_desc_fill() which does the
> following:
>
> drivers/dma/idma64.c:idma64_desc_fill() {
>     ...
>     unsigned int i =3D desc->ndesc;
>     struct idma64_hw_desc *hw =3D &desc->hw[i - 1];
>     ...
> }
>
> Since i is 0, i - 1 underflows to UINT_MAX, causing an out-of-bounds
> access on the hw flex array. With the new __counted_by bounds check,
> this will likely trigger a panic immediately.
>
> >       for_each_sg(sgl, sg, sg_len, i) {
> >               struct idma64_hw_desc *hw =3D &desc->hw[i];
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712220039.92=
4958-2-rosenp@gmail.com?part=3D1


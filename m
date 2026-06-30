Return-Path: <dmaengine+bounces-11876-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KE2GLiEfQ2oNRQoAu9opvQ
	(envelope-from <dmaengine+bounces-11876-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 03:42:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C70E6DFA14
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 03:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vb36f0SG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11876-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11876-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC752302BEA0
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C3369D43;
	Tue, 30 Jun 2026 01:42:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1633655CC
	for <dmaengine@vger.kernel.org>; Tue, 30 Jun 2026 01:42:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783771; cv=pass; b=texL+BD3Q7GJNLUl6Sa9uF3ewzSck/iZkRP09hdHkBbBSSqvgVnRW6OlU1K2U0rlIPb71uzF1Gvohrfiu3apurEJC/7IEr1Fxx56OAWujKzhBc/m2Xr/mzizasfMgDbuH3LF8NwCzDxpUlvPOdu+5QRSlxuntSITD3sV+vNqFjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783771; c=relaxed/simple;
	bh=nhdxmG2CnVr/CRr4beMAPrLypobZ0ZIzUMCKnbLP61E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJu0aSSVi0pGaDaTRz0kYq6dAfkBHmG1jYGhyIM41jLEDeUbT7sA6y1WKdMuQ8YpKG5d3WBVLlxFdPI0ZX76am81ce/TOtTkTyEdJZrNmKrbbDiAF5V3c1ktKBrhsuUkfrZx7atgtcIhqyezXFJ7W4EuuCxI4A0tRT1S2w33E64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb36f0SG; arc=pass smtp.client-ip=209.85.167.43
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebd52488cso799696e87.2
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 18:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782783766; cv=none;
        d=google.com; s=arc-20260327;
        b=nwUiPnLxGpuilKXKbNyHekr0GSYY5oOvueBVeVDmrmoPsT5/FPnvUWURMqhjcfBlmW
         3orxxHXFgSRgkmKhf65zqqSh1Vmny/h1AubzOfSh1vsROP+GQXPkItZK69gly5alYXe2
         eV5u/2hN7WdmMLEKFqA6uwuHtlLO9t+wFBLP/4njUZavIgkvURkX9ceQakbOV0CBNU6q
         2szAcnXeM7CpoEYyC13Igc0hsm8TTigbasdHzU6jUqXga3ul9A8DJlHGI9Qfra2PPcYM
         WH0tcjZoAPmaVUP6JHQXHGZbutoTOXx0EUUXGC1Gidq6miuQEVy41rv7y5Hn+Bl+hrCW
         Vk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        fh=R58UPJfnjpFD+Mu+qx+W109JiL86gsXdBZ9UpuirA8Q=;
        b=nd29zPzqbGcNyPFR4sXNX3kjJSNiNf2x3tS5CAV26crI/tlDLy6+Znl+R/moXExDfS
         ew9XOq4Ht19+0MSiZQcv0W4kWmgLtrMIF5gwc7hTGWZB7HVUNU43wkzEgI9Q3jgXnVKb
         CDb3ro/c7y5cDqTqCojFtk1DTlRFh9CXq4uU6GP6NTjeulLJ8l0yzcPbTNF+D89VXTpl
         nidldGhAoWf2aheSfAczXGHl8zhHWxWqUzJjYDmy5CjZ1GG94OYE0gbjVilUVvKe7JfF
         r1kjLUOK8tTRdeHGqlxjCKu9s8Thb/SK6cdp9PrN/lsAFKCf7F5l6A8RdqFEWWbq6TuR
         G6kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782783766; x=1783388566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        b=Vb36f0SGBnaDOf9LAXYNFJ92O8TYawJBwyz4dumckLlqCN+06l81blLL2ZOZ+uv9Ud
         BejmZF8A+tTeloehwic0RcJ5ReyFXxwEtlQY2fSL5tn/ZXHfPSKdzjcNHnz8DTD4kHsf
         wtB+wz/clOC8wXnWAeFSxYeHqUn986FMlVjYjyIz/DYgzisHz3NztRzX2Lv4MiIQeUW1
         eqzFj18FSQ5eqXGjaN5Hjw8KFp+vl0j2u3GWXKnFmv5CmYG7GJw1Db22HbQeeGV1x58+
         Pu8KyP/HoWD1TF4XPlDPMx+9ZtKokf+6VuRbRZ+OQWDyepLVuphZ8uP5U7QdaSsKNO4M
         +3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782783766; x=1783388566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54ZSdcYDtnus7s+PnlVyh1eGHNk8J873Vy4LrzmGSk0=;
        b=DDH7I/opCqwAoh7pkdKPIH7EBqTBYbsfkRQE41gluKJzGUIyKqLaUQe/+WoK63A+n5
         TWG8bZi6f9EuHsVJrjesxyPeBDqdDrY/ppqEHvVpoUZXSrEDz59zRalr4mRsPD+lhDmh
         /oz332GF65v300mXnzIWqVcB7wlyhB9Q8/7CvLhvL7kn4to+axcgCgiPhpcLF5grdwp1
         mNeS0wixetSX0zhqVCkUqTdMNQNg4jvDpWkrYl6+kksg7rlUD+sPn7T69RRfUAe5Ld53
         IPg1tqeWPTodk5woxdAzDCMC+4cA5McjdDOjPmh3Y2mCShkDIVQ8jYMDHzTzseAvt7ye
         HxBQ==
X-Gm-Message-State: AOJu0Yzbdk7nNWrC52SMrsRTqSNRZYeABZcB5K2gvZD0Xm4m23OHTZvN
	nka4YFZ2wvf7DBJIsFmtlGsQB+hss6ZFlMuC0WAOY3jIwwKneS0xHkZghm5K6MghB2WdXfRm/jU
	/pGaki7RaW3UwQYxUC3lWmkr0HQjqsnQ=
X-Gm-Gg: AfdE7cm/LXDS19Coj47b8KxBuYnSHx5pB9SfF0wpDoDieW69uKoErvfBuQYE87HhP7y
	/m9ikadAn9/zTBbDIHRMRiQZl/D221u1XW8/NL1zaH29oVROOAm20OZNZ7idkMm5D39xdev8iV7
	tjoiX4/Q3kNieCd0lSmyrczk69dVadNnF5Sk60JedDNT/1xOX9/Qq38VrkVWgLpOE+ckZlh8uiR
	QCrTogk5uanfL+D0uG0l9LdPzLqoB1UJ2M1W3fjftSJqRi8cGgxwZoM/QNTV4DKjk3vQHrMwX4V
	rA3KuSAY6XVXK3WHAbGum1vUAhTKWndjutr4OBGFIB/l1aOPiFsHmRYcrOz2/0UHSrkl6DN8SZ3
	x9YjNwujIhJaCH/JJws4uNRbZDMs=
X-Received: by 2002:a05:6512:15a7:b0:5ae:b489:b844 with SMTP id
 2adb3069b0e04-5aebdbd1019mr285139e87.32.1782783765734; Mon, 29 Jun 2026
 18:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504031209.618949-1-rosenp@gmail.com> <20260506110910.su2s6ncsi2xfdiwm@pureblood>
In-Reply-To: <20260506110910.su2s6ncsi2xfdiwm@pureblood>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 29 Jun 2026 18:42:33 -0700
X-Gm-Features: AVVi8CfGsOdNjYThOJxFiCSIqzZLS1O4KyLXKY4lRZyMqOtKIckcWa9Mym5j2e8
Message-ID: <CAKxU2N8PUdxo54oHtcroqe+Q88k0obxPg_9OCRsNsoOwvcS25Q@mail.gmail.com>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
To: Nishanth Menon <nm@ti.com>
Cc: dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Vignesh R <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11876-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nm@ti.com,m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vigneshr@ti.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kristo@kernel.org,m:ssantosh@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ti.com,kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,ti.com:url,ti.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C70E6DFA14

On Wed, May 6, 2026 at 4:09=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> For some reason, replying drops the CC list. manually added them in.
Found the issue:

https://lore.kernel.org/lkml/20260630014129.1548147-1-rosenp@gmail.com/T/#u
>
> On 20:12-20260503, Rosen Penev wrote:
> > Use a flexible array member to combine allocations.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Fixup k3-udma as well since ti_sci_resource is used there as well and
> > needs fixing up to use kzalloc_flex.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: add k3-udma fixes.
> >  drivers/dma/ti/k3-udma.c               | 180 +++++++++++++------------
> >  drivers/firmware/ti_sci.c              |   7 +-
> >  include/linux/soc/ti/ti_sci_protocol.h |   2 +-
> >  3 files changed, 98 insertions(+), 91 deletions(-)
>
> Since majority of the changes are via k3-udma.c, if this could go via
> dma tree, it would be nice. Else, please give an ack and I can carry on
> my tree.
>
> For the following:
> Reviewed-by: Nishanth Menon <nm@ti.com>
>
> > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > index e027a2bd8f26..04d99c1fafa1 100644
> > --- a/drivers/firmware/ti_sci.c
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -3574,16 +3574,11 @@ devm_ti_sci_get_resource_sets(const struct ti_s=
ci_handle *handle,
> >       bool valid_set =3D false;
> >       int i, ret, res_count;
> >
> > -     res =3D devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> > +     res =3D devm_kzalloc(dev, struct_size(res, desc, sets), GFP_KERNE=
L);
> >       if (!res)
> >               return ERR_PTR(-ENOMEM);
> >
> >       res->sets =3D sets;
> > -     res->desc =3D devm_kcalloc(dev, res->sets, sizeof(*res->desc),
> > -                              GFP_KERNEL);
> > -     if (!res->desc)
> > -             return ERR_PTR(-ENOMEM);
> > -
> >       for (i =3D 0; i < res->sets; i++) {
> >               ret =3D handle->ops.rm_core_ops.get_range(handle, dev_id,
> >                                                       sub_types[i],
> > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc=
/ti/ti_sci_protocol.h
> > index fd104b666836..7632bb11c862 100644
> > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > @@ -599,7 +599,7 @@ struct ti_sci_handle {
> >  struct ti_sci_resource {
> >       u16 sets;
> >       raw_spinlock_t lock;
> > -     struct ti_sci_resource_desc *desc;
> > +     struct ti_sci_resource_desc desc[] __counted_by(sets);
> >  };
> >
> >  #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
> > --
> > 2.54.0
> >
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
> https://ti.com/opensource


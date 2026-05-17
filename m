Return-Path: <dmaengine+bounces-10491-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDJoAgUlCmqpxAQAu9opvQ
	(envelope-from <dmaengine+bounces-10491-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:28:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F5563C39
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15C9300D738
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC730FF37;
	Sun, 17 May 2026 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxOhZ9Ks"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B430E85B
	for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049721; cv=pass; b=qDA7qSPol5MIhETa5yyqPDbEHMNGTDaciG3jAPWjSFP8lMh2nh888j5Wp7rxLQW+aZoAju8SKWsLyQc97gIWytj9ctZKb6ejlynDihj46b33fxPaYXjHjJLKJK+hJ9xv3pjTtdF+oRHzpIZchwdSHvzTMFJJPWtPgmDHcPzI8/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049721; c=relaxed/simple;
	bh=2RwNPXEv6s2JoaROSCh5jyEVahMOlqAe4M3ndGU/g1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzqZo/IaRqLr2/aLOwaiEyUVrBeV6+LxKEs2FFu1JGlJ/hhOE2vTudMyYs1u09hleF9rq0hWTYEbHGb9D1tAs/ItaPIcFErOTa5V1cNeXPySFiZWLz26hMQLHHUfswqbe10NVwMaoPqY45WThJ+Lv7DEu1v14DDoL/NPc43150k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxOhZ9Ks; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso2645976a12.1
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 13:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779049718; cv=none;
        d=google.com; s=arc-20240605;
        b=XgSRYF5mAibVCeADblvPtIo13DZuK3YOXnpAbpKHeExEIekQizlbICSK8BlJsQZOxS
         d0LTLGL6MjMpQD62ULlWoCA2QpJXULo9SR0oIEC9XFkaF95vRggD+oKCa6cl61SPfhze
         fzwl2MOlm0SwSAunII0/Vx0fgrttgEpefidOghZxqNrHPXxuTUkUdd24YbL4Xx0TPISq
         6FiiXEvTAdx77KyyI4kRyhG3D/lRiWWbRa+V5M/yhGNc7EB471S7hQjvcSIfGqt7xJBe
         mhB+DnBKi/kQ7TPd8Lh+gISCWQ2mXKfPalK4bTrv+b87fEisMHHzU2vIUNqpNsulDSmt
         GdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KvnfTYk6N67AKhY+UfuwULwRynjPAQarihdrw81Qgs=;
        fh=TetZ0/espx2WNaT47jWHJyWhTgPGdilRsfSUDC9eikw=;
        b=BwfPL79einS21zDZwiqUqOAfzGSR7OXPK8QzmU/DS3SQcIHu+PljOUtzMNX93CaEeq
         aYbeayK9QWS4FwA6OlVMBT26rJwzYLwgqZurb4ZzTZrBRIAGvyVbNVQ21SRNt9myyxvy
         nSULHw3ZsrrAuk5+9zQylpSmafLHv/Uf//JAfrFvB6G0s4r2fPSIbXnGUY8hBoBNujJ0
         A6gF9EDCd9LzlSijXK7Yn3SC7BXZrB51oYaHM9NuLxTzRs2UQrts/jq8F8X8CM7LMvI0
         agxNXVnpbqwAcWi9mCbMfDmIS6BON4IgvrrsETMAOER+YwhHV/gDYspkET8+EqJR6x1B
         uf2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049718; x=1779654518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KvnfTYk6N67AKhY+UfuwULwRynjPAQarihdrw81Qgs=;
        b=rxOhZ9KsSQxCitRDEEsviYwA9xjhX9qjszTWzLrYvOtQl6SAJCqjYzzhb89Ze4nSoS
         CeTu2Wznwbyb/J4arsw41Hf0IfEiRF/5vOWu6SrpFNaV/TzgvSrdP40gLxM8bDIQRSmT
         xwEoDXRGAF8SeP5gi5I34JXH0BkcRDW2t7Y2AGqC8r78cpfyVeElEGt2T9kcsEt2I4Hi
         WE8aXr+7ub0JatvQXnyhkC5v7Vkm22b22t5743tV5snBQeBlUdjon/VTtTW+uaLRgCza
         qshmT3qwddMndXy25auNvFEJy0THQxXQhcAUc8e7J5RwW0bB4N9KlVgNV/qMv//QURFw
         9/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049718; x=1779654518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KvnfTYk6N67AKhY+UfuwULwRynjPAQarihdrw81Qgs=;
        b=CGxah/+iF+z2PwM+Os2vEU6ToUXaaLMj3eUa9cvUe17IG4jIiaBPcpfZEFcdwDJJhH
         yzaVyZcIRw3vm3sb5yamIU0QSW41rRv0o48oaJlb6hf3KMYBtf2JUWVicP74Df+Fo3xX
         JQ1dn/LbAzM5jFE1gUFQK7JX2ACaCmSeAgnTv7+eJ1u6gUkRyg0jIuJp7+c8zkxCkimd
         5OcrcqQZRILJgOn0uFPuoCf9aci4xFpF9AqJ3LwDykchHfSaybxnxbicDXOqR1w1JadA
         4ziJRiAVpTD1zNGhZox4YKqhqmtYgc1Dq9vzkqzLm6VDC84dYizUQJJGSZdJQsSswb7T
         nO5g==
X-Forwarded-Encrypted: i=1; AFNElJ/WCpCGBo0mZ4BqN+fNc5V9toq9tQFRhYOr7HtWsaNELONiXBbTn5ZkSbg/6aqG4+itlmrE2/lD9UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YtKZBlXPWZo2xIevtXASucRtt0HRT+QpjGQ3h4oVElVhOf6T
	Q9EFucQQflIzCJPG6ydIAV+h/P3ok3xDl5Ak9d5Rjvjf74Zifz+fFeiuXgzpvOw6U+h6BWpNs16
	NPIVe0SvNwnIaGxXU6AD8brmywAD9shg3eHov3zfW8A==
X-Gm-Gg: Acq92OFAPT1BjF0imcuDiPbmnnMCAV1WFQaOQxTgfkhW2YBY4PiEoeQjWzJRlt6jj5p
	Dg0WlNwKp8hdJDS49r7p0hxpP8wV0/FhsSOxWqvuffhBjzmnMXLy8UTvfyQHyRNBHj31sqHT92x
	yp+fH981R+BiTh3rMqffSfrxBe9o+Kk7zNh2p3jx8A6AfJ3EEXM8HUwFNvFX75t/sfTOYjUDun3
	kFxTPv6AOt5SD0bsGQQimuDiAjfcXC0heWG49wE0p3GooV3GjdzCnWwzkfV1PJt2vjsxJwmYbVh
	xU1KlcQ=
X-Received: by 2002:aa7:c78c:0:b0:677:1ce0:c08d with SMTP id
 4fb4d7f45d1cf-683bd58a162mr3936886a12.18.1779049718038; Sun, 17 May 2026
 13:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515142623.793549-1-dbgh9129@gmail.com> <8407feed-0619-4b94-95c7-0d2f27c643c3@intel.com>
In-Reply-To: <8407feed-0619-4b94-95c7-0d2f27c643c3@intel.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Sun, 17 May 2026 16:28:26 -0400
X-Gm-Features: AVHnY4JqF3qO5nzUeJD3ZHApPOfeMuKpojr6RhYzE6m--LFENhqVSjUCqkyK0z0
Message-ID: <CACrCO_XjRw74R36OVOeVUCvsF1g4bPEEf+uEduG0sJWB=o1n6w@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: idxd: fix deadlock and double free in idxd_cdev_open()
To: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 933F5563C39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10491-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Thanks for the review.
Understood regarding mixing scope-based cleanup and gotos. I initially
introduced the scope-based cleanup following the first feedback in v1
but it became complicated. Since fully converting the function with
auto cleanup would be overly complex, I will send v3 with gotos.

Best regards,
Yuho


On Fri, 15 May 2026 at 11:53, Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 5/15/26 7:26 AM, Yuho Choi wrote:
> > The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
> > drop the file-device reference while still holding wq->wq_lock. If this
> > is the last reference, put_device(fdev) runs idxd_file_dev_release(),
> > which takes wq->wq_lock again and deadlocks.
> >
> > Those error paths also fall through into the later ctx cleanup labels
> > after idxd_file_dev_release() has already freed ctx. This can make
> > idxd_xa_pasid_remove(ctx) operate on freed memory and can later free ct=
x
> > again at the failed label.
> >
> > Use scoped put_device() cleanup for fdev and return from the fdev setup
> > failure path after unlocking wq->wq_lock. Take the WQ reference before
> > fdev can be released so idxd_file_dev_release() always balances a
> > matching idxd_wq_get().
> >
> > Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the f=
ile opened")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> > Changes in v2:
> > - Use __free(put_device) for the file-device reference.
> > - Take the WQ reference before fdev can be released so the release
> >   callback's idxd_wq_put() has a matching idxd_wq_get().
> >
> >  drivers/dma/idxd/cdev.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > index 0366c7cf3502..18ff29118d12 100644
> > --- a/drivers/dma/idxd/cdev.c
> > +++ b/drivers/dma/idxd/cdev.c
> > @@ -216,7 +216,7 @@ static int idxd_cdev_open(struct inode *inode, stru=
ct file *filp)
> >       struct idxd_user_context *ctx;
> >       struct idxd_device *idxd;
> >       struct idxd_wq *wq;
> > -     struct device *dev, *fdev;
> > +     struct device *dev, *fdev __free(put_device) =3D NULL;
>
> It's probably not a good idea to mix scope based cleanups with gotos. Use=
 one or the other and not both. Otherwise the whole thing become a mess to =
read and maintain. In this function it looks to be pretty difficult to comp=
letely convert to scope based cleanups so I suggest avoiding it.
>
> DJ
>
> >       int rc =3D 0;
> >       struct iommu_sva *sva =3D NULL;
> >       unsigned int pasid;
> > @@ -289,6 +289,7 @@ static int idxd_cdev_open(struct inode *inode, stru=
ct file *filp)
> >       fdev->bus =3D &dsa_bus_type;
> >       fdev->type =3D &idxd_cdev_file_type;
> >
> > +     idxd_wq_get(wq);
> >       rc =3D dev_set_name(fdev, "file%d", ctx->id);
> >       if (rc < 0) {
> >               dev_warn(dev, "set name failure\n");
> > @@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, st=
ruct file *filp)
> >               goto failed_dev_add;
> >       }
> >
> > -     idxd_wq_get(wq);
> > +     fdev =3D NULL;
> >       mutex_unlock(&wq->wq_lock);
> >       return 0;
> >
> >  failed_dev_add:
> >  failed_dev_name:
> > -     put_device(fdev);
> > +     mutex_unlock(&wq->wq_lock);
> > +     return rc;
> >  failed_ida:
> >  failed_set_pasid:
> >       if (device_user_pasid_enabled(idxd))
>


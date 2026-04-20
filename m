Return-Path: <dmaengine+bounces-10068-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA0hCUCH5mlHxwEAu9opvQ
	(envelope-from <dmaengine+bounces-10068-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 22:06:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9343386D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E4D3011BF2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A218383C9C;
	Mon, 20 Apr 2026 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maduyh/c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B8150997
	for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715581; cv=pass; b=LBGt/kRGiEzY0Z+qlwoPAqXhlN4+YEq8V4kw5LOUbViQqXrBmECE2s1HW1qxfUt8HmU4k549Ghjm3O8VWcoyA5M10UTrUK9S4v+5iMwV4Z/8ZXqCYUBmRJiUgFRw6WbuB9UMcB7uSw+t6oboOYm7OCAs4osRmGY5l5MHKbxzMPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715581; c=relaxed/simple;
	bh=RgnpwnXZMk/u5r3ZCAUsrG1fzGOXHv5FLbJH7g7/ZzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdhDN0EYtaN1Y1HSC8GRVAIGb4f7LD0sLCMIzLaplXBLiEHxrXQ6Mc/5tUJNw9Sa4PoNpk2NQmyH9D5LeNVPXKTqG8OfhWysK0l1tGTzSRgu/UWBzKYskV/Ir84YzbnMYkTgrpubKdvzowlpcRr67LSqLdrMfIFcX8LkCVDo0Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maduyh/c; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso3127932a12.3
        for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 13:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776715578; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/MC1EhJGGFqCOa7075o3FwRPnTqSFB8CiIqT0F24p7Uv4p2D94kUIM01GVLJY+N7q
         WfU50BvezHdzxyzZNGU2iy1OnE7diJrppvmU2XK5qWQEsCWNccQOOkjkQVSknoIQU5Uj
         qJp/v8pmnzU8MFwHbkXoP1YEuyiRjtONwphnFhVrIEH2odl8jxqxXIgWza+c3Bh0dGE+
         f3eX+LsBKkKu8xyA7sf9+XDtFboe/tRNZbJiiwBrSrXW+PftiugQoHI6zJaGbjGNCrAA
         5frYWqal0YICmMd9IaVtO8Z3gz3y2oBbeitygh0/JrljN+fc19/oqSr69y1aeEtgBweb
         CQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMBafyl9U9T3/5JLuCORI9yHKRbb9sNWR+NfxA1SVHY=;
        fh=xEH8+oxPt16gQuQuOeLqPTEXQDeJllf4Lhb90rHVeqg=;
        b=AuIeomWWQkf/BOILst+cTiHMAKwzpb2TuZo8eIlXWMvuxDlM4CBttyXLQaPv7iNgC5
         nar0nOjAZizRdJB5VV2+szrK9JobUrQao/9NiGehlPLyEXdVwidvzMe0CStbdvedjEId
         6QArnUns/onFixrQsPcgsnZw7wDhAz9JmqMZT0uVOsxRcgC+rgxqtoD1FEqnMpjQGE3v
         opUbGi9QhzPRBIxFjvFH3p+/P19XaAKgMX3rfEXE+g9GMc7UOVLBHMLsvr9xopt+Amxu
         mDVQxeavHXbmv6o1pMPxxUX0d5pE0aQH7PtcJ6S5YEL9CqQQtXL1pwwsytOvGDfaa9Ux
         zwLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776715578; x=1777320378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMBafyl9U9T3/5JLuCORI9yHKRbb9sNWR+NfxA1SVHY=;
        b=maduyh/ce3/5bEpWk8Zn9EHDQq4Kvy65ntfiOEdfqCW4FLHrmvpV3J9ueSkaGT7a+M
         ADWPKMsZGKX7lrmPJctbia3JmHG+1w2FxwEn696Yg9Cwdn18PQn1ZYtnm5H6ZsmL7+C7
         Ohn2vTVqjJfsLiMP89prcAezOLRI+bCL0U14Qh6j0Sv4NEl8lQANojRhtnVnX1ZWpNpS
         kr+upRjsIkCtDlpgfvBOEHTrQ1jnft8Ky3FLR28ycXtJuu48StTKvF5NdE/WI3/knJ4e
         AjSMtFLnbc2E1zd0yCtKevMKcUq41DfY86EwkIRnTYXb22O746+g9KFfKJVZmA18AQY9
         DQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776715578; x=1777320378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMBafyl9U9T3/5JLuCORI9yHKRbb9sNWR+NfxA1SVHY=;
        b=PZKYKM35q4mlKeGbtA+iTGfuqNJcGx1uPYKkrWRt4zbE88hOYkBmNx5reFCKqMSAGK
         FmjGJgy402vc0G0/qGMOjzpE08nmH/cHUqVXRbvJqlaoFbKZrnQtLBWNILIUOBn1dDlU
         zXF7v9ce2MB//dopNdiL2vcD/RKTq1HfAOqMKJKIQjesjIYqr1Rcq7x8y42OFbMusM7n
         KAFkGKe8H0Jqvn4wkW9CDiR0/nmm+tGQoujbZ33Um7k2cUu3JTDx+wiByRkLdrik2t2V
         UVTv3aIrMBAlCOc8xnDzl571KQEboKd5/lnOx+uRz0lTExiJ/hT/8WAT3tE9jAGLEKTY
         6Anw==
X-Forwarded-Encrypted: i=1; AFNElJ+YCjliS+EIvrDxYIETe9JMflfNBHBt+3CnTI5rMRYS/mNYe8WZBgFTQhn6/JXIJD0M2ma5Bf1XmII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjjJxcCa6LUwl8QBkxmlWnYw/6oEiqhE+JeJvGytBqkUNWRdz
	fshIq451K6DdoO48N1i2u636mfPGVyvpih1NUuOhKkLQH89NID3uiyhMcnC/1yveQjUQAfVKX1O
	7HdDSr1nXZRm7wrqzPJgxdkOHB359dj0=
X-Gm-Gg: AeBDiesip7mv4DWpSAv3Tn7oGAQAOGuCmx9jAXI7BcL+GzM7iz+blVS3mYOND5MG7em
	ndtw3cJLlhOmkhp9CVbq2xKjrucimU+95nOSQCXck+Cs4vKaGdsiZp98UkHkYt3e5JUMH+EAPwE
	TG+Nk6SW7bEzyN7PrO/nRaNUyBsvAZIHdCeGxwBuCnt+KbAC/FA2fB8NgE7PWfKpmQali44Hl+q
	GqwEQPkM1rwciGbtPYd+tMBaXeKQI31Rfv1LhiF6LYJ4kM53j+ZOZVKwWIELrMk3cUizsELlghN
	3UrDJAH7gs1NWuBZGA==
X-Received: by 2002:a05:6402:4408:b0:66c:1736:ded with SMTP id
 4fb4d7f45d1cf-672bfd9c29cmr7233478a12.11.1776715578087; Mon, 20 Apr 2026
 13:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416221957.51250-1-dbgh9129@gmail.com> <aeXBVKLvHANxqGGZ@lizhi-Precision-Tower-5810>
In-Reply-To: <aeXBVKLvHANxqGGZ@lizhi-Precision-Tower-5810>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Mon, 20 Apr 2026 16:06:04 -0400
X-Gm-Features: AQROBzCrdQXOD6z0OwIjTQiqtCrpKi1ZrveHybwpqhktO9bpOpk7ocxvVQCQPXc
Message-ID: <CACrCO_WCtKfWUDXGYcsqT4zWTxBdpRpXyW34QmOs3-y1vhVTJQ@mail.gmail.com>
Subject: Re: [PATCH v1] dmaengine: idxd: fix deadlock and double free in idxd_cdev_open()
To: Frank Li <Frank.li@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10068-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80B9343386D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Frank,

Thanks. I can rework this in v2 to use auto cleanup for fdev instead
of explicitly calling
put_device() on the error path.

I plan to keep the change narrow and limit it to the fdev lifetime.
The idea is to return directly
from the failed_dev_add/failed_dev_name path after unlocking
wq->wq_lock, so that the
auto cleanup runs only after the mutex has been released and it won't
fall through into
the later ctx cleanup path.

```
static int idxd_cdev_open(...)
{
    struct device *dev, *fdev __free(put_device) =3D NULL;
    ...
    fdev =3D user_ctx_dev(ctx);
    ...
    rc =3D dev_set_name(fdev, "file%d", ctx->id);
    if (rc < 0) {
        dev_warn(dev, "set name failure\n");
        goto failed_dev_name;
    }

    rc =3D device_add(fdev);
    if (rc < 0) {
        dev_warn(dev, "file device add failure\n");
        goto failed_dev_add;
    }

    idxd_wq_get(wq);
    fdev =3D NULL;
    mutex_unlock(&wq->wq_lock);
    return 0;

failed_dev_add:
failed_dev_name:
    mutex_unlock(&wq->wq_lock);
    return rc;
...
```

If you have a specific auto-cleanup pattern in mind, please let me
know and I can follow
that in v2.

Best regards,
Yuho Choi

On Mon, 20 Apr 2026 at 02:02, Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Apr 16, 2026 at 06:19:57PM -0400, Yuho Choi wrote:
> > The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
> > call put_device(fdev) while still holding wq->wq_lock. This triggers
> > idxd_file_dev_release() synchronously, which calls
> > mutex_lock(&wq->wq_lock) =E2=80=94 deadlocking on the same mutex.
> >
> > Additionally, the original code fell through from failed_dev_add and
> > failed_dev_name to the failed: label, which called kfree(ctx) a second
> > time after idxd_file_dev_release() had already freed it. The subsequent
> > idxd_xa_pasid_remove(ctx) then uses the freed pointer.
> >
> > Fix both issues by releasing wq_lock before put_device(fdev) and
> > returning immediately, so the release callback acquires the lock withou=
t
> > contention and no further cleanup is attempted on the freed context.
> >
> > Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the f=
ile opened")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> >  drivers/dma/idxd/cdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > index 0366c7cf35020..19a449333782b 100644
> > --- a/drivers/dma/idxd/cdev.c
> > +++ b/drivers/dma/idxd/cdev.c
> > @@ -307,7 +307,9 @@ static int idxd_cdev_open(struct inode *inode, stru=
ct file *filp)
> >
> >  failed_dev_add:
> >  failed_dev_name:
> > +     mutex_unlock(&wq->wq_lock);
>
> Can you use auto cleanup to fix this problem?
>
> Frank
>
> >       put_device(fdev);
> > +     return rc;
> >  failed_ida:
> >  failed_set_pasid:
> >       if (device_user_pasid_enabled(idxd))
> > --
> > 2.50.1 (Apple Git-155)
> >


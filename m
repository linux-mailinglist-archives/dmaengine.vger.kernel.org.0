Return-Path: <dmaengine+bounces-9854-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPf5E2RdzmnvnAYAu9opvQ
	(envelope-from <dmaengine+bounces-9854-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 14:13:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76914388E65
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0874A300A8F6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7883DEAD8;
	Thu,  2 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABjT3/v7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27003D6CBA
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131853; cv=pass; b=RyOs3Fb83btC45y4XdJEw4+QlqiTYvFgkYdvR2z6ZHJ3wii15j5UdrmCWBHizDldpFfPNzo0QN5/Wp/6FmBMcnKDwkjdVDm0aj7ZOw/NODJoTbqJyg99nZb3nIeMo7g99NFrUDBXWSlXVxXiW38YhyO+OzDqion/7OdsiGIjpok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131853; c=relaxed/simple;
	bh=Jx2vOZ3aK+H94UvwlSlpY2GIR8TTTJNpCM772tGT+EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9ktWxPhN5NRujCocLg7QacCTQyALBvwGMLNaXT8Od6QCY9xeAhH36/gpxyFIJMY68OmM43pP7tXsBhAm5fWH6HG09vDA1HRrKDVvmR3RL0exMst8ez3kXDKVDxCfi4J00xQk4feUx+RF0G8mQlcF/fnPZVs/CIcOHULLF6F6a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABjT3/v7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501cbb52e5so861920d50.2
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 05:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775131851; cv=none;
        d=google.com; s=arc-20240605;
        b=jWwnD64ENZk+xPweZ6yhUJ8cMirKN3cfsuguWw/4MaKTToZYP/xn5VqLpDhFraBCz6
         JGX6BKy2i0oKGZt6wZ9qj2QN+FyvhvobyjyGfoD/Bi9hbQnrKQvjJ5TKx4nMN2guG0Ar
         2lSTFuMXMn+ZAMM7QyHt6eXdPiA4sN4EB6bvVq8mFKUYTm9zVaNAr5EbNtXF2Sk2F2nb
         8EW798RutUNBwqeUSEwbRnKJBBFbS3VsVyNsw/bIv27aAY5WKiOmH4KwkugPqKg0wegY
         urTGlFJQ6d0r6feE17xSfZnHnWxyhysZ1zACvaEC8OS8Cm4CHEf4FQYsukAEDi0ZHiJ8
         iEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        fh=kHMLQLpQ+HX8Q509vE0b/HdHXJoKMuaBZvgrc6xUT/M=;
        b=YvipL9ls0ZEN6aypNQS5bYZQ4sY55OPo/54IL7NT08RZ0DQKpYkpjd7xEdyau5cxDw
         YevqnBLu2B+TjvPtyeQda05YHUeJsPJc7Jplo+DxItt9o+pKoZr7+W28hR2MQoGekdJp
         UjrWVzf1hVYd9roEtEwaX9Fz+qfrXeSveUysvIjd7fCZ8BhX0FDtOSWfWweRLPT00d8g
         JAvoJCh6zxMu0btDu/qNl/0yBHmCcA+MTqJz33qrwWWoh1LnAKnQ9ltMg9tBE6uKVOID
         g67jOATuIjrqdtExWhMZiAAmTuZ3ppO9B9dXB7KQ/0DvMJ3EzKu8UskCG5kUeVTsDBh7
         pmsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775131851; x=1775736651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        b=ABjT3/v7Q+q0SfPTQH7M/1bch9ddn6IaqKesPw8cpoJPeDfxQJwQWZ9KRv0tgBC747
         ybFTcNBJC0YUYRRxrp842L6w9huXIjRl7mu7uV4X5/QqCkHuyLVQFg2wOOGGqVa3hMlI
         00xmHzi97DSzYZd4NHz+0tq21PB+9UNUzjfm99BPQT+iH8FWQqBbUl2IN1PDfhSTLs+r
         CiBtpPr7EQFUXmorM2RbwawnO0JyB9nlsraYf/wBwc3EgCbmsIIeS09EC2Um6jwQQsFP
         27LH8tfRkc3x63ZhF4OZSVrci5m+E8+nv0aXy4Tw4ffeme/n/q7wcCkm1dHyzOr7/X8W
         vlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131851; x=1775736651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXGE4RWiA7WqJLGf36CVelIpTJ6eR3ehqb3g2RtbVMY=;
        b=fxDwK52ZLqu1qFoi3hJh9QQxYhpF6eeDV7udkIEcFo0mU7SJCgTvBSi6SexZZxVL8e
         AsBxoWChfHW5ATKAC3FRn3/cX470LPba33L0hzzIF5gJ5DcAIXTf42PjUqXbSNTDNzKy
         tRDQAlcz40CGAA6gepXtL3/emJg3op5CEZYdOPU9QC0WIgSgYbd8egmBDak2cSMixPpl
         d0xbe1pFbzBaClVPCWtH4kIlcj6m5PRcpLsKau5xwExWcqA7cQv6Fl+d9yZPnettc/ww
         TIgJGWoP1Zq5+6bpCCYrvMr+UhMIlpy5ltEAVEV5BkMFZIEvoDre0k2bQHm4zLQiRX9j
         oXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWBQHafe5mtTHhVkmrNh1P/CDobZ5c/d6ZxNNqXdKTG8Guq3EDc0ubviGWgizvmx2MIUxp15zqpvUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkhCF811DsKD6FIvK5ckrVlZWpvlihQ9dDlOPmK4atYNlnAE0
	qO2K+kvAEkBWj0R2KurO4b+hpRbmCRyo9hAOpOU1vvywBW1zVcIqoueYUf6ukkStm2MM9USrNWD
	GPR1ENsP77iBy/Z9o4ldQWVFU0ec3F88=
X-Gm-Gg: AeBDies0zru3QdQqqSu3mz/H5FLIyvlyKb0/XMfzbUWrX3MH20VdqFZByvQJ/I7IX6N
	+VS6V1PS+JXdr6fl2v+WbSNFaG4cmAwEA/JdVZ6vRNwFkZpzMvBcCKN/JbQoMdmG2Q9NdVL701F
	jA6s1wepb/wbvGz6lkpPk4xAoFpwp2OtASONYaE1UjW0SjYmWE3u2wpHu7O8U74QpPvmAScWFxH
	76O+BL9rZXTvPra2UGkCYSBr29OhpgNw9rXgg/viUe1uZbQRGcuKFxHP2X52blKEXjJAKlrie6C
	O0M37FD9
X-Received: by 2002:a05:690e:12c2:b0:650:3e1f:9079 with SMTP id
 956f58d0204a3-6503e1f945emr1607300d50.10.1775131850932; Thu, 02 Apr 2026
 05:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401094003.1482794-1-lgs201920130244@gmail.com> <87h5puxoa2.fsf@intel.com>
In-Reply-To: <87h5puxoa2.fsf@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 2 Apr 2026 20:10:41 +0800
X-Gm-Features: AQROBzAgDXLDasVS5yX_W4qD-ueX2Hms7568bo3hSjKUDmVrOGa4_8H56gZoHPc
Message-ID: <CANUHTR94+ZEO6d3+Pm1cdHw3firrAaVqxO90XwfHGrAkx37wsg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error path
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Fenghua Yu <fenghuay@nvidia.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9854-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76914388E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinicius,

Thanks for reviewing  =E2=80=94 the feedback is helpful.

I'm working on top of v6.19-rc8-214-ge7aa57247700.

Regarding the concern about put_device(conf_dev) triggering
idxd_conf_device_release() and hitting a NULL idxd->wq in
destroy_workqueue():

idxd_conf_device_release() does not call destroy_workqueue(). That
call lives in idxd_cleanup_internals(), which is a separate code path.
The actual release callback is:

static void idxd_conf_device_release(struct device *dev)
{
    struct idxd_device *idxd =3D confdev_to_idxd(dev);

    kfree(idxd->groups);
    bitmap_free(idxd->wq_enable_map);
    kfree(idxd->wqs);
    kfree(idxd->engines);
    kfree(idxd->evl);
    kmem_cache_destroy(idxd->evl_cache);
    ida_free(&idxd_ida, idxd->id);
    bitmap_free(idxd->opcap_bmap);
    kfree(idxd);
}

At the err_name point in idxd_alloc(), idxd was allocated with
kzalloc_node(), so all uninitialized fields are zero/NULL. Every
function in the release callback handles NULL safely:

kfree(NULL) =E2=80=94 safe
bitmap_free(NULL) =E2=80=94 safe (wraps kfree)
kmem_cache_destroy(NULL) =E2=80=94 safe (explicit NULL check at entry)
ida_free(&idxd_ida, idxd->id) =E2=80=94 id is already allocated at this poi=
nt
bitmap_free(idxd->opcap_bmap) =E2=80=94 already allocated at this point
So relying on put_device() =E2=86=92 idxd_conf_device_release() to clean up=
 is
correct for this error path.

Regarding the other points:

I agree the patches should be sent as a numbered series.
For the put_device()-then-kfree() double-free pattern in
idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
idxd_free(), I'll address those in the same series.
Will send a v2 series shortly.

Thanks,
Guangshuo


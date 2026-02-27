Return-Path: <dmaengine+bounces-9152-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEdKE+2QoWlZuQQAu9opvQ
	(envelope-from <dmaengine+bounces-9152-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 13:41:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E995D1B741E
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 13:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27E8A300683E
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7BF3E8C5A;
	Fri, 27 Feb 2026 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKMe5PdK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAA3D4115
	for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196074; cv=none; b=fxUnCHSJFfDTgiRL1ogZnfIObGZ690z0QuyP9a8qksqF/HSECqGy/osA57SWXnRWrraCvXBvP4RXUF+u/z5Qafk9eyJXgJRXp3UZdCu0jBMLydxfy2JWHItwSciPuVgKf3L+Pq+0gwYMm/BKMadsU9STAkRHCx0UMTTfkErxVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196074; c=relaxed/simple;
	bh=bu6LksbaTJ+xcwDED2umTKgJQSgKu+bRRvIX7chKhdk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phquI9yRGUAF1zjXWASCl8Yb5s55bjkeKuGcmVXh7jbJwiiUeE7IkLrlOeem9Xu2o0kbSWm/PuFbs6lHcukVAzNzybhRRbNeD6C/gPRi4uP/yqd+B2NSqGpZUuoZptOpoYxHsp5NRMqmSfjYNZfifPYZs7DvMtGEuEARIEJuu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKMe5PdK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376acce52eso1381276f8f.1
        for <dmaengine@vger.kernel.org>; Fri, 27 Feb 2026 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772196072; x=1772800872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bu6LksbaTJ+xcwDED2umTKgJQSgKu+bRRvIX7chKhdk=;
        b=gKMe5PdKARs0tn8G47AUt4Ta12u8TCAdVNh3c4hnXwfDwRl/nPNNnEHMTdKhzCwfsl
         ehBbGsv8k34YxE1ecWrfyZ6jBiLu/X/+C0fIBZmxQJyfOOgbHAC73v/FeyQuNjHT9xoW
         ihtMEhD6SHq25/LQW3Y+eTT1z49B81uXPMN5EZNWZYjUvMeOvi20WQaPe09OmtB8pSqm
         nfYwcZL5snCehMKEBHipDZ5fTO+mNJ+saSUF4k7O5C95by1rJeoOAV8a1BFA6Xxs6Ud/
         V+k+tRb3WES7LHIZ1YZcnJCVC0ySS2utWrBrEp+u1h1jPCCSxHaUY/Ej3S9Z7ZWna9AZ
         0ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772196072; x=1772800872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu6LksbaTJ+xcwDED2umTKgJQSgKu+bRRvIX7chKhdk=;
        b=F4mDbrtY5RSnAdrXovgIRJ40jL2g/YZYZ7Quk1VLDjIS5STgGgp2cSZEP7srIoz7aw
         E7NbcvuZk+xiAXJg1SDw87XMGaKu6WO7Ap0YuGF+T7G9LJ4+q/QABfuGJXhHshSoG59V
         KDd9wgfmpmtPwNGdAaCRJKMlvNrpvttV/Dt1QxVgkcdYEouYiMGz4r42Q3gj8PlYlRC6
         TrVR9sDBNZpimQ2+MYAAM6VilX07/1O31zbnF1DmH/34iMlapyPXVRO9es2Vs7UxPD7i
         35HO7tP/G7STxPBUxZVTecfphPios7SRbP7myXYm3PYQjR5Yheo3cDwZubvsVWeGJubO
         CSwA==
X-Gm-Message-State: AOJu0YywkAixQfSAPEEC7bzYXTjwbe8nZP7uRe6Mt5ENtz6zGshuFQKC
	b0hnKV0S0OFFo1d7/Eal1a0TpJkELeFOKAQl+J2ZiSvHY0cdTgQjvZpk
X-Gm-Gg: ATEYQzxh7jySiUz8J3ajz1d/qpgtx6NhMiyL5AUNNsMFshTAptktSNvxNV7iybgN/MM
	lDX4pqd2tz29R5B6M9l2/gsEXVXe9Ba8JRZmEpsh8jJ8Rv7zZruhJrUpBr0R0o3tba5Ph6pj5Fz
	WOu4lhwmgiJ5GW+VdJdY346VVrXnGvb7mGw2pfqW1QTzuGp7XBPiZoXUKAH44ktImgNAhOxP/Er
	FLc4N4bYFvkRvZ1NgOwNw9sT2LH1FrAPoAdHP+MnqYOTgYfyUEcncwSzjS+KdXM56PyahfuxxlW
	gVhHrKZgD8rJuP/OhGZNc++Gp1x1KKBVGs+7ufXgNmxrJftSbHvaz+5NW69xZfcu8ASPeVVxp/G
	Z/bIbgyC2N3fwyYpHOO0LOyEjWcjCUeDVg6hRCVvN9qYkh72ovQCnEDV+vfQrfzNmxKp/dSiAsQ
	e1ZcYtwE2q6L1u2QbssXduMUCxcNB5Dmg=
X-Received: by 2002:a05:6000:40ca:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-4399de206ccmr4523998f8f.36.1772196061155;
        Fri, 27 Feb 2026 04:41:01 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b327sm7164780f8f.20.2026.02.27.04.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:41:00 -0800 (PST)
Message-ID: <00863862d66cbb3393576d5dfbede9200f323b9d.camel@gmail.com>
Subject: Re: [PATCH 0/5] dma: dma-axi-dmac: Add cyclic transfer support and
 graceful termination
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 27 Feb 2026 12:41:45 +0000
In-Reply-To: <aaD-xxghRKAhS8Yc@vaman>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
	 <aaD-xxghRKAhS8Yc@vaman>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9152-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,nuno.sa.analog.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E995D1B741E
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 07:47 +0530, Vinod Koul wrote:
> On 27-01-26, 14:28, Nuno S=C3=A1 via B4 Relay wrote:
> > This series adds support for cyclic transfers in the .device_prep_perip=
heral_dma_vec()
> > callback and implements graceful termination of cyclic transfers using =
the
> > DMA_PREP_LOAD_EOT flag. Using DMA_PREP_REPEAT and DMA_PREP_LOAD_EOT is
> > based on the discussion in [1].
> >=20
> > Currently, the only way to stop a cyclic transfer is through brute forc=
e using
> > .device_terminate_all(), which terminates all pending transfers. This s=
eries
> > introduces a mechanism to gracefully terminate individual cyclic transf=
ers when
> > a new transfer flagged with DMA_PREP_LOAD_EOT is queued.
> >=20
> > We need two different approaches:
> >=20
> > 1. Software-managed cyclic transfers: These generate EOT (End-Of-Transf=
er)
> > =C2=A0=C2=A0 interrupts for each cycle. Hence, termination can be handl=
ed directly
> > =C2=A0=C2=A0 in the interrupt handler when the EOT interrupt fires, mak=
ing the
> > =C2=A0=C2=A0 transition to the next transfer straightforward.
> >=20
> > 2. Hardware-managed cyclic transfers: These are optimized to avoid inte=
rrupt
> > =C2=A0=C2=A0 overhead by suppressing EOT interrupts. Since there are no=
 EOT interrupts,
> > =C2=A0=C2=A0 termination must be detected at SOF (Start-Of-Frame) when =
new transfers
> > =C2=A0=C2=A0 are being considered. The transfer is marked for terminati=
on and the
> > =C2=A0=C2=A0 hardware is configured to end the current cycle gracefully=
.
> >=20
> > For HW-managed cyclic mode, the series handles both scatter-gather and =
non-SG
> > variants. With SG support, the last segment flags are modified to trigg=
er EOT.
> > Without SG, the CYCLIC flag is cleared to allow natural completion. A w=
orkaround
> > is included for older IP cores (pre-4.6.a) that can prefetch data incor=
rectly
> > when clearing the CYCLIC flag, requiring a core disable/enable cycle.
> >=20
> > [1]: https://lore.kernel.org/dmaengine/ZhJW9JEqN2wrejvC@matsya/
> >=20
> > ---
> > Nuno S=C3=A1 (5):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmaengine: Document cyclic transfer for =
dmaengine_prep_peripheral_dma_vec()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: add cyclic transfers =
in .device_prep_peripheral_dma_vec()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: add helper for gettin=
g next desc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: Gracefully terminate =
SW cyclic transfers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma: dma-axi-dmac: gracefully terminate =
HW cyclic transfers
>=20
> Please be consistent in naming, it should dmaengine: dma-axi-dmac: xxx
> everywhere!

Ahh sure! Sorry, not sure how I did not noticed such an obvious thing!

- Nuno S=C3=A1


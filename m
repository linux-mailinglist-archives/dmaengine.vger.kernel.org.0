Return-Path: <dmaengine+bounces-11117-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC6XNFObHmpllQkAu9opvQ
	(envelope-from <dmaengine+bounces-11117-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 10:58:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D462AF82
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D89E030634B6
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539283BED27;
	Tue,  2 Jun 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njPpWsxE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69F37474E
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390452; cv=pass; b=Ty5ldT8yZu1ZZqBBVUVpI2QiuGmF1FmvIweNRSUFO0hoDP3gncL0p2oiJRAvDZ//h9PuNzg+yTvzg/DfnBuz7/ugQOcWTs2WZVuBDzj/1tYydlTIeMT2lbRw2HwO81pa/IHjbtKCqIPu9X5DGKYqOhURdgMgMusxOkpznnhhRf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390452; c=relaxed/simple;
	bh=BYV7G/B6I9W9fPZFqJVghf+uG971LNGPJiniM0v0MG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9kvvWZxLFG2ZpkYgsgMF4hdluE5hauKgABOjk1GoFhY3tf6selLaeZppl0rPuR9fodHQEPMinVRVgTHIKz9rInUf/EEf7CqYzLED48bCOcF6tkvPRGnDhxEIvGCHrzU/u99+k2OvpO7uNyUEqDaOeQsEs9Y894ZkGOffcpvffg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njPpWsxE; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c5eecdd56so5003159a12.3
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 01:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780390449; cv=none;
        d=google.com; s=arc-20240605;
        b=bSANW2XrKz5xeL9Ejp+rKoiMqKIAihbQWeasFqSnQRHwDE8dcVTRCWPsjQ9A/plRo1
         eKFiXyz4giHW3K8oowSTHfjvhZs7WHxslRdN5+khh0bHPm04Gn22DtwvFowWHHP6i+U9
         70Kwrh+keTRC74wBiG0uYlFZHGTdHIK8x5Nfk31a0GKx5sgZL+lWHeDS2P8EXPHyYpto
         XonZPxHEUhf9Ia6o11wJeZJyyhDrYYqnAxVNqLHmbMuXBhRJPsa3PbyBtf+URJBR8T+h
         E9YA+E+WdxRcR6/59Nb374CFqZICh6/tTEVo7EBz4xRsQyFOV8JfRb9CdfLIh+sGCD6O
         T7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rks7RgU8lnN1tl1OcZKY8fr3t/XyAMQZ/mP+r7NDPTc=;
        fh=3m3hNYqHzh1VkDU+h+ayK3hEt1MCN7wMBLQtIQDt7qg=;
        b=b75IKAdHWfTUlgFlYxQlK1IONEoA2sFfm7fYJuuTn6ldXsSn/ttKay8Tooy5rTRX7F
         sVgc/kJbQ0SDeIc/St1kxoIKiUFCUBQ7v0k9oKqHVNKySoGRZ/6wGJb/rU2Dv13I5mme
         +7asDNf7XZRFNDPAprPMR+VZ9irQi57fZV2qrCUq//JEpYgeAtEo75S0sF0pzqfwYMRZ
         UPqKCz6BNBPLwyxoaSLJjlaKVNU9E1AmDVdvdMqVYvkv/0gYY0ZO/phC1nbl4tKldI5h
         wzXfbFYzENH8Dz7hkeaC/F0lJdiWtd52QgsH4dnt/AU4k99HoH/924dJB+pJasrTpySr
         uYnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780390449; x=1780995249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rks7RgU8lnN1tl1OcZKY8fr3t/XyAMQZ/mP+r7NDPTc=;
        b=njPpWsxEzPIRCfLTeHqySztGEY6JL8G2gKDVHNkN1DT92H4wn1tid2NVmG4DHZQZVR
         vF7UTtYydBryJEtMBVv09sd+00ZClLWoDzOlXOJBzBEKURsPL2xhgyOem93ClcJmppKI
         lo//OOvbsW+7rqnd/hzms2NBD9IBMqwbmnVkiT0FK7b9Yqg0ekNa678NMXB9xsu8ocbW
         a70UEh+yMJr6b8ypGoNFDl6JowdU2XJZHfGhaQKz7oNfFpcIltfUYgAEQQh7GC6rEj1v
         0r36pcusbCRHBYRjIJhE5DGCZddPyABjmMQDzESihcz+WUcYNIgXddODwqxWoAAatFiV
         lYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390449; x=1780995249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rks7RgU8lnN1tl1OcZKY8fr3t/XyAMQZ/mP+r7NDPTc=;
        b=ow104kGfajqWeuiF7zGWzFpd7d5rRxcF52Lfh+ElL1B9ORfRS+1xsaC8l1mL7+hu7n
         ETFoMaIQrv+aP83MHCtY/CbGjpE5mFE5rxSN2I59z8ud9UyY/07kvnH+eoBdaSghzwSX
         rbEsM38ELLr/7vzHzVTcqA3Vx2Gtp7ZpX5Afl05xM+XsDI1KZALNatd1VKcUlQpWRfsp
         BNUuz2wR/M48GgsbyuxEjidQUN+h5hoiCVOkl+1hpa46lBKZjeleGW9Sxp4llAOAgf76
         ENTEduZmdfEASyB726Po/ynDXCPYy9shDySOqkGCGDCBJYhuvnZ1cSwdvyM05Wayln9K
         PyvA==
X-Gm-Message-State: AOJu0YwBRsuKcmkNSCmqfNiYUqaHw5bM2xDJLQ4vqmrEITs25STN8FpT
	96Bf45/DW+JhEnuoulXx0TtLr1EIXqi8NginrXwSmf5WIRm0SeRVliBsi4BOPsYgqijHYgHhVd6
	fLukpJGGYRET2yjxvfXBoyNT1jEVI9e4=
X-Gm-Gg: Acq92OFYUFE20gYNlsMMM9v9n55EgfpMECcEl3aFs4dB3IPBbo+bPOQKph8bZLPCGhC
	XG3y6TYsE2epoQC9yfYC4KuPGj1kpYbZx0LdjIeTIrxxDYC2QUq5eKr39Ta5Wv/e4/SuF8zMtIs
	kq7uAOMxLZ1qOB5Axq4C3XGO5z+W09QMm06Egb1hy+TsttjdujrXb88I/rEjIwSOctIQqYPlUAO
	YI0yxnOea3yWlPzKAZU1ofANX0BB8d5IJyHpXg+aqiLHvrDNnsGw4ZgWmplKUIAduxClQ61gEHQ
	ft3Qk4HrrYs7NgJ7Kf0lrQ2w0DAo6yTg0JbiNgojECKMWle2Z4BwKmfsy+cIx147tEdih8XP35c
	GISt7zQJWG6NuT5zI5coQ53pz2yvzmN9etcNghHpBHzFqIuJSaQnYdhHloQcan9ZZX9Ib
X-Received: by 2002:a05:6402:3554:b0:68b:f026:f381 with SMTP id
 4fb4d7f45d1cf-68c8ab2e567mr7105442a12.8.1780390448854; Tue, 02 Jun 2026
 01:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531210747.11401-1-rosenp@gmail.com> <CAD++jLk3HmmTBfjLaVKBcRi87EmAdzs9BGy6teerJ-rN92MtCg@mail.gmail.com>
In-Reply-To: <CAD++jLk3HmmTBfjLaVKBcRi87EmAdzs9BGy6teerJ-rN92MtCg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 01:53:57 -0700
X-Gm-Features: AVHnY4KscwoQmk_hWxdvXdiz9lrBDSO5kvhYw84zUg0Fx_ut4kbOFRTKcKnGsdY
Message-ID: <CAKxU2N9BKyz-8y2Jyrv9xFpCWL4euv3uCZXBrQdT7mWn3q6eMQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: fix out-of-bounds access from D40_MEMCPY_MAX_CHANS
To: Linus Walleij <linusw@kernel.org>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11117-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E3D462AF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 1:48=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> On Sun, May 31, 2026 at 11:08=E2=80=AFPM Rosen Penev <rosenp@gmail.com> w=
rote:
>
> > D40_MEMCPY_MAX_CHANS is defined as 8, but the dma40_memcpy_channels[]
> > array only has 6 elements. This mismatch causes an out-of-bounds
> > issue:
> >
> > 1. d40_of_probe() accepts up to 8 memcpy channels from DT
> >    (num_memcpy > D40_MEMCPY_MAX_CHANS allows 7-8), then writes them
> >    into the 6-element dma40_memcpy_channels[], corrupting adjacent
> >    stack memory.
> >
> > Fix by defining D40_MEMCPY_MAX_CHANS as 6 to match the array size.
> >
> > Fixes: a7dacb68b35a ("dmaengine: ste_dma40: Allow memcpy channels to be=
 configured from DT")
> > Assisted-by: Opencode:Big-Pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Excellent find Rosen!
All credit is to our robot overl-i mean sashiko. I'm under the
impression nothing can get merged unless it's happy.
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Yours,
> Linus Walleij


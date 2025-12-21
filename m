Return-Path: <dmaengine+bounces-7857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA50CD428A
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495513006467
	for <lists+dmaengine@lfdr.de>; Sun, 21 Dec 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A829BDB4;
	Sun, 21 Dec 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni/bg7ps"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AA28727A
	for <dmaengine@vger.kernel.org>; Sun, 21 Dec 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332632; cv=none; b=uiVSfEqw7TrFjOlLqDoUD+MEDihA2v/iBTOQaWYCtPOFmwnwM7B3XkzFLh0eEDHNJR6kVQIL39E6e9fLW0vV5pFBXx8eRZd44CyzgjxI4X1lkR/Dt8Es5LDCZrthb74VmYQO+NJe9Ik97GVNlgYeG7KmXBfBxRxtz2qPHC3IQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332632; c=relaxed/simple;
	bh=mrMOQdDsAyBJL5Fgn/G2OhbffuTYYry72mzdpWhvbCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFqmTcR5mSgZN3IyxhdAl4fvOZl9rdoudb7lRgFnTFTFs4UfgIitaDmHnG2pcFtY88gr/OJzrz+4rrOgSJ1DYhJoJAtmjpoBesRHGTdMoUlo86dt0+f4g7kqoA3/O2yigdJTWuwwueeGy+ewxg+7QNXjY6XnXVh9pMXwoEGXjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni/bg7ps; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47a8195e515so23143625e9.0
        for <dmaengine@vger.kernel.org>; Sun, 21 Dec 2025 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332629; x=1766937429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrMOQdDsAyBJL5Fgn/G2OhbffuTYYry72mzdpWhvbCI=;
        b=Ni/bg7psCSUyErsoea9IjsITMxN04bm44C4CpaE1rGtK4etMFEvaNojWjYiJ6iG/Yx
         EuyOl6JGsmrsMSJlzpb6/CN8OCiHK+QxxvWmj4YT8q+F+SI1wAW6RZpMUI9hdAhe8NW7
         WUWpGAX/DKkhN71hMy3k8f1P67jRcKnOTzdnt7+gjv6K9yW4C789Vuv194KzKID7+NXv
         1tK9pbp1Be6rK7WHAPRd+lMnaTGVkdXUJ/RkvMVhyJq99wmXK5iF853F7/9/bSMR/V9T
         XcSN4O6MsCoR9lirgeLuHI7WguIbmNY58cCf5leDpAH4d8ptVQAcC1s7opSkc3aWGO8b
         QK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332629; x=1766937429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrMOQdDsAyBJL5Fgn/G2OhbffuTYYry72mzdpWhvbCI=;
        b=IIoPCBaUsF4gDKI/VLMpYLept2nt+MA50i2j9zHh6R1jAegqky6jwUlFxUlrEIJxsn
         xPaKVwXkbqDQ2fNCL6Vo3yAsm4UczpgleYlVr6PRgDZ+su6JRX6+nxuvXMBxsRUWOKy3
         OEbH1F5qsq/rSlo9WJG/E4SW6vb3ybTm3xKwtA1bNHxEG8NAkxLrPLJ/p3LqLPwJMlLF
         Vt5vojP2zEUIZNhKyTI4ALdBUkcBg955Hartdl8cRAHnhInJTYhJIPpUcjIn+cKQBBfm
         YS+6cKeQ7HWbDjcHouS6pHK+1vxYMU/SpEpiruK9wo5DdxFcXfLzCPwEufoEvaZMhF9/
         Uc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6VfGcoAv/pMErE4SdHFS5hhFJq2JiQSZu75E68yCKin+SbcD0P/PAlchG1xkSSS+KUIFbpdodR9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4X9VUobrE1xjVylIeR6zZmzwd/64sRBD4cxUZlPb+FiAWrewA
	bZeA6tC6xOtHfT94zqtygtwspqhxlcJ+44D+8gmUCOT3O7ps6BJxXeSZo7kY2w==
X-Gm-Gg: AY/fxX5pXkrEt2Q2Q/jUlfUB0cs7p/MQzoHVnctDKmYIOQ2/mQLfyihnIYmBh/KVSmR
	ZPszoq9S/DtGDBpkjA+JqpAZlER9Gl7EpfKwCis8qAWAMcYr6sLfSviF+JBiCxv0owsvThhLYuA
	rwuXWMPEZBy83gjrXl/snF2PiC4Rzu4krjjtY9fhfFoVmzYGccNVvnnw4x+sHmRZuxdB7bLOvp/
	prDzNjGQ88BeXQYJdrvlVPw8Qe9VRBn0HV9oIf83cfh1kDzqw3JXOzWqj232tw6eJY1kb1IcpVR
	xvb55aKyvDGN9rzxK8wTZ+SCg4qSdhAPlMVXyxz/AcEN5f8vDpaJjOAfKQvBsqcACgeqZTFy2y9
	eQpl3Rb8uDhtdsmmAt45P0L0l/PlEhL2pcrtfkDJspLA0mG3ZqH3rm31DUYO/em4lpJzexK4h3a
	HafK/Q8odi6ZW36YfQNQTG1u3P7dnRj3mc7mkPjk4fnj7GmhKnpKZ0bJz6II1m3/qCSBnP
X-Google-Smtp-Source: AGHT+IExEA0mdDUqUtqXOeUL++O53ldVOc/C42cZHo7ZCg0+/iRgPqjs3JCL6tqxJgQuhZDXsn6nRw==
X-Received: by 2002:a05:600c:6388:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-47d19557cd2mr82943635e9.16.1766332628749;
        Sun, 21 Dec 2025 07:57:08 -0800 (PST)
Received: from jernej-laptop.localnet (82-192-45-213.dynamic.telemach.net. [82.192.45.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3ac5409sm75866275e9.15.2025.12.21.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:57:08 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, dmaengine@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dmaengine: sun6i: Choose appropriate burst length under maxburst
Date: Sun, 21 Dec 2025 16:57:07 +0100
Message-ID: <3385264.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20251221080450.1813479-1-wens@kernel.org>
References: <20251221080450.1813479-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 21. december 2025 ob 09:04:48 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> maxburst, as provided by the client, specifies the largest amount of
> data that is allowed to be transferred in one burst. This limit is
> normally provided to avoid a data burst overflowing the target FIFO.
> It does not mean that the DMA engine can only do bursts in that size.
>=20
> Let the driver pick the largest supported burst length within the
> given limit. This lets the driver work correctly with some clients that
> give a large maxburst value. In particular, the 8250_dw driver will give
> a quarter of the UART's FIFO size as maxburst. On some systems the FIFO
> size is 256 bytes, giving a maxburst of 64 bytes, while the hardware
> only supports bursts of up to 16 bytes.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




Return-Path: <dmaengine+bounces-4657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EAA5690E
	for <lists+dmaengine@lfdr.de>; Fri,  7 Mar 2025 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8609716F936
	for <lists+dmaengine@lfdr.de>; Fri,  7 Mar 2025 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85744219A94;
	Fri,  7 Mar 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="irJauzcN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73C21A459
	for <dmaengine@vger.kernel.org>; Fri,  7 Mar 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354672; cv=none; b=VxwApX4RTpJ39s/WZyvrXJ2uDleMPxMh+tV8UoI6Qg4DUBAiUirOxeczGbc4ZUdAU+sqEAbEpOvJGKH4QG4uVGozKG+p+68zGTRl0PikgdTgbU1h0atUPe7cZEJZmq1IBRUoI9cjgSFScVmaF3S8hds8aLvoVWYBP8xRwJiX8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354672; c=relaxed/simple;
	bh=yhAiG+qi3GeaVQhP5HW92YO4rjUq5KzIddSEtmQYAwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMBa4NKDvjaiGlOrhg8yp+6ThZyp7rvsfTv3EZarTDK77uEsP339J8sdAQUNOL1Fd0zZjsceyXwFHr0wG1SawzkESyLS8XeXyGNO/UOq0Al05/XLlziQpQUFrV84ucwItEnI5dS3qE4VL7ho0eKJegbipfJHOr/JTFu04dU2r/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=irJauzcN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54991d85f99so830179e87.1
        for <dmaengine@vger.kernel.org>; Fri, 07 Mar 2025 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741354669; x=1741959469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhAiG+qi3GeaVQhP5HW92YO4rjUq5KzIddSEtmQYAwo=;
        b=irJauzcNX9RDwDK9m+6GWPRDXgRBdNV8bbXKLyQZoDe2uDbJ2TF+W7sp047ao4GAOV
         vEA0K+KD3zb/BnhJXXcQrFXHTI6nE9ht+9vhHBfoLTg7perJFZ7rCaqkKsUgVRJVG4Ar
         VhvnLjqGmVZNL1By4jKht4tITJrB2X0q7NgBjPP8n0N6bqETEe0eDK8bb0wfwDzVsR7s
         t1rCH4GmTFB+VDMhcYOpSi6zK/D5R4vwuw73GUN6biYbuSZ2eWfXe8PXbceQxMmTZxx8
         kEs2icMEbbE3R8IXT46WkoUC/Z9T/Z8ZhQmydwhjlUI7PsWngT0xnNwN+547VQCNCfVK
         H50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354669; x=1741959469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhAiG+qi3GeaVQhP5HW92YO4rjUq5KzIddSEtmQYAwo=;
        b=Gy6iDuTbCuogUKSWvsiYsDjUk5aCe5Jx4ZG6uGTGC4iyozmUK5CoR1e5d32wxSVI6C
         DJWYYjLSRSFxD5Kb5sz56fIna0cTTayUovpv2fGRfSxxQgqWRCjdGCuX4U4b2W8jvryR
         JxTE/bMuCknbPH57AZs9TkPnzaDx6F+PLSLNm7dHc0xujc+KFBo9dm93RUxbrgvJajvy
         JUf1fBsjAEKMq7+cYzXhVgvDg6Hs4BDNdrAykMXlwJ3ehcLEM2gyUO72PHWxFKwBGU9z
         rHmeE2pVEjwGU+LT54K5fAgRuwnovpACv3BA9mg8LpoB5ZEmcII/bGDzUF4f8ifmVx6r
         cDQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpqfdyu0zW0bOAtiKJa4snX+jSeN47VQc7dX+ah62pUijBg6G5lh/onHQmKiTrnkVluen2Vrq1qOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhng5JJQAC2KFi3XmEhSX7Hs0kZnbaevGGaGfYaqi0IXbmFzX5
	SLB1S9sZvRmmRhhZOGoo1chcc/w/fKSwOoKkgkPc4x8rtdk+VqK2uM6LIQPxoHLShb9/8Bkr4+K
	TFMblR68WRfa5n8w/1msPIri5E5BHIevS/vdXug==
X-Gm-Gg: ASbGncuYl2z/sY3c/sPWN6sIltaUv9g9qWUdViU8GlGNnMm54q1tUeGcYYTz+vESSgW
	mPpH43kuN7z6PJlNmKnauq19Sfg7ZqShS46oHPIVRVBDEVSDdpVe3+XafRoQTPPBLCg81MRsaBe
	AkdUAQLt5C8/JBnj2eyEl2kZ4FJ2LEdLvXiTL8AFXbRxrTIb/GEaR68HVO
X-Google-Smtp-Source: AGHT+IGzkNoMHjmvOj1hQqXkv2F5z2g3i4Jr8kD59wAfvhlOi53g3cqwXoU/0aqTwNXIKKE8Ssj4pheG14cvE/77p9o=
X-Received: by 2002:a05:6512:3048:b0:549:5769:6af6 with SMTP id
 2adb3069b0e04-549903f6a2dmr1550533e87.9.1741354668560; Fri, 07 Mar 2025
 05:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com> <20250115103004.3350561-4-quic_mdalam@quicinc.com>
In-Reply-To: <20250115103004.3350561-4-quic_mdalam@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Mar 2025 14:37:37 +0100
X-Gm-Features: AQ5f1JpFjLgvIBX6jbFKPzEzBuYS5kNiIudISoUHjkmPBU-Dykoze86uPUbnTss
Message-ID: <CAMRc=Mc641VWZp_2cMxrvs2ErwwkE04903GZ8BzDAZg3+H19NQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] dmaengine: qcom: bam_dma: add bam_pipe_lock flag support
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, corbet@lwn.net, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, martin.petersen@oracle.com, 
	enghua.yu@intel.com, u.kleine-koenig@baylibre.com, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_utiwari@quicinc.com, quic_srichara@quicinc.com, quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:33=E2=80=AFAM Md Sadre Alam <quic_mdalam@quicinc=
.com> wrote:
>
> BAM IP version 1.4.0 and above only supports this LOCK/UNLOCK
> feature. So adding check for the same and setting bam_pipe_lock
> based on BAM SW Version.
>

Why do we need to read it at run-time if we already know the version
of the IP from the compatible?

Bartosz


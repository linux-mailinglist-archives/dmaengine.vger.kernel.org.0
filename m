Return-Path: <dmaengine+bounces-7014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04649C0FD0C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 18:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C84835021E
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D253161B3;
	Mon, 27 Oct 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5dMn04R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC353191C0
	for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587925; cv=none; b=LX0HeZGXz7ps6FKVJ36WDiicMPvqq+t7hTam2IFCdQZpDpEudrD+ZoE6rGjKrrPR5t+4FEDX0i2jN+K0PsQoaq7+OnxXaaM2ru4gcEbQrxg5jhrXB7AoophsIGHB8E9LRFPFfL2CYREznIVlrgzEV0/6cJy+HGCowdAgbcghWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587925; c=relaxed/simple;
	bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfu2FBiDWC6fLCdstQyy+uhGUDCBkltTR0F5NIxuLswxRD//iml21ErIDIVVKcyUiTTj6UsqUfFmmMurSqL5P3Pgpilsfcv1gXSPu2puFUmSwSaIL4iiHUUcssjgzCXhj8DFwk9o2n22+Jt2ZORGlMbKJ68oldRrDTzOafMvxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5dMn04R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3476976f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Oct 2025 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587923; x=1762192723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
        b=b5dMn04RsBnItqzMCrb5hnhZy7S5RbR+b34HZ83ocRWHgAEC+41JFR/XB9gGdXfhOX
         AEy5dHe3CpmqPWYAgEgp0XIQeIxawt1YD8j9ObNaAUgkN3kj46zrjZFzuGKGz3Y/LxYd
         QiL6xQ/8/epQfyOZPzu/5eFO4BhrmoRE+nOqooYLV3lLQrJBMpedGZHDyGCF49BuTo+p
         xQhOmLbKmtWl9p/JnsxUHeO+NRKpI2GZvDsho5pqpVjW6X9OvTKtgA6dpYMO9OjnSiSL
         EW/edlUyJLao0lgmcVIoziB0HYEPyN75dIvuePvJPwahmVPokHxRYM3kj1dgB00w8wCS
         iwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587923; x=1762192723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrLZa5alrgHzC1J99K289oAUToN5br+ZIZn9l5DB14I=;
        b=JCBE7IJecBRSCiqDjnJ9cw2WKY3EPvWQb7qT8uOKc8Kz2Pon7Lr3eZ7g5rFt3F/v+l
         RB4+8Uo4sGW7Biby6zUjzzyVzSpr0zbSH8JfGLyZ3fE0IYHFDE8ajjvUHIHDH5Z76q2m
         6s7/U5DRJyUX/jGOSXRXr3EcA/gNY8pz1sOOdsjE+HwsvisLbHHCWQ8qJjODbajlZd7A
         0kkQ12r4lWQxTZ1E1Yn+8ALPnmEhLBuf5JG/wN5dIefJTirZfEIxvItGX0gHHdekGiwM
         PsXxP6omnzgrwT6YwG1JBPLO4Ys6Cak+OFQK4sifnMeAdwURIHj6Qb57/1s38P8pWFWl
         0X0A==
X-Forwarded-Encrypted: i=1; AJvYcCVOuSDoTCFrspNm/q4LixsViWLXCNWGyapoEOkzau7oyY5doo0WHhcBSeUlekKwool+Zq2uuxbsyHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxneIGZZutwVqwm8+0VTpSY/bFpuCAcc7o7v1o5RWHsDAnFZZUv
	a7CKB+8dX4XQ8WrkoKsELU/XgCnJqyYmF8A5NayCPqoy7aAqLEH3QzjV
X-Gm-Gg: ASbGncuVuhQwwHC+OOLXomTfRPA7UoPxynH8PuJq+52eX36kzVG1mYj7JdcWxAOz4dU
	xsIMCYqvvrdRDSLsNwwr89ZoAwf2v5bvKdnTtl05xTD9OQuEbYpAsVh0+pHrINKcEDWn4dsRlmX
	JHwbm02LUOj8p/04w7stJjGk+GEJriv3qX0B50XbRGjJR4Li2wijnw4zkxIMw6KbW7VJtb6j3Wm
	ZO8KsdwhXXsGNNVigWjBcofdYNJhIVdzpVK3rPdUW7EWfzTX1BWjJM4WWMAq16JPDqs0XMRNOKE
	L+gqG/yA1HtXyjZRTvJenissZ0K5gtkG6TYqHGjw5xl5B4vOOt1PlpAkms9I7GcLsZfjNLdHAoj
	e4AAwNZIINYrnxDZ1gz6nI1eHbQwh3h7n+RkXt8hPtDiiRWpZ9uuU5i4i7fQ0v1JRQGQEhr9+B1
	oBDohmtqUB4dpsZ8E5cH3S2EsAW5OshO8mo0g8OuJGOMYSACUqGOADBn8rioGYuQJwe8mN
X-Google-Smtp-Source: AGHT+IEEbY/WNAlAvL+pz8s7XDkjY8oak1WE3FbbRf2JSc/Ve9J9gkYo1nnN4xz8/yWauuSoOfnmDA==
X-Received: by 2002:a05:6000:2287:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-429a7e59dbemr594649f8f.14.1761587922569;
        Mon, 27 Oct 2025 10:58:42 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm15264123f8f.40.2025.10.27.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:58:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 09/10] arm64: dts: allwinner: a523: Add SPDIF TX pin on PB and
 PI pins
Date: Mon, 27 Oct 2025 18:58:41 +0100
Message-ID: <4686611.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20251027125655.793277-10-wens@kernel.org>
References:
 <20251027125655.793277-1-wens@kernel.org>
 <20251027125655.793277-10-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 13:56:50 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> The SPDIF TX (called OWA OUT in the datasheet) is available on three
> pins. Of those, the PH pin is unlikely to be used since it conflicts
> with the first Ethernet controller.
>=20
> The Radxa Cubie A5E exposes SPDIF TX through the PI pin group on the
> 40-pin GPIO header.
>=20
> The Orange Pi 4A exposes SPDIF TX through both the PB and PI pin
> groups on the 40-pin GPIO header. The PB pin alternatively would be
> used for I2S0 though.
>=20
> Add pinmux settings for both options so potential users can directly
> reference either one.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




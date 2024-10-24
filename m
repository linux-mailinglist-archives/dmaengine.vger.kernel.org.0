Return-Path: <dmaengine+bounces-3465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F689AE1B2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BC51F23A25
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B51C07CD;
	Thu, 24 Oct 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiEVDmY6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076701C07CE;
	Thu, 24 Oct 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763846; cv=none; b=sykOIQQpno/Q5XS7/7/zeKNpkHROZISVLnQ/FCcFaZDr1gGUjEOpQ4kzloluq8fLZIw5UF0xw69+8knmSSWioOvcPQjxj9K5zT27NmO7XE+YtJCSjuRes7hQzJYleX20JSoEuiLQFM7J4efE5jnMyRYzz0hk260oE64HpaEb2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763846; c=relaxed/simple;
	bh=PVT4x+5HpkJQPwdJsjK0MwsWAxzsoTXRtb4fDO7mWLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOAtxiazhUUH/3Dy2nRkZL+lQ/+ha/CKEe44PyksJRpGI6be3jbG1teBSZcOzS4hMiwYLUvoJVfTg2dDhC0BHGFBP+4ZLXHKkglewEZGqRRZmCcu8GB/7XWV/ieW/uHofxbA7oj1CtDUAycsu7s/1GVVveNYNnzlft3SqSL+cXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiEVDmY6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so1006001e87.1;
        Thu, 24 Oct 2024 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729763842; x=1730368642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVT4x+5HpkJQPwdJsjK0MwsWAxzsoTXRtb4fDO7mWLM=;
        b=kiEVDmY6XwsBp4SdramVG5Th1OvRnaXVUgKmqzCQsKn0ZaVjpW3uYA85GjTZVXdKCL
         uXv/CdtBzqL3alJbx4gthkNesguWFBqAvlr+Ol97gYsZgfN9qTvJoIvK0QNOwxyI55Kd
         2TcXW+9Hx3NFbqtW33m7J9IuqxF4CW/BOKje+WQKdjmnZNgGPk1UaWjhDFdsqJ502nsi
         f4j2YwdFqnKytKE4J0nXSYhzuCvtSkXhd54UChyEBNr34+T1+pT9BZ9DpUyHA+WylOng
         mjuz9HfsJswMjL2BH8WzeFr8XyF5pmM6yEs0bYRXKR2cvSpzYizxPlcriLdPOGG7OCxU
         UCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763842; x=1730368642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVT4x+5HpkJQPwdJsjK0MwsWAxzsoTXRtb4fDO7mWLM=;
        b=Eg5pjiEc0RTnc7HzOPMSnRfRRlgkXZn1zRCSFG/wyeaYNqiXatKDMc6Py9ZGqcGYRw
         4rP78hF9r6jXD/SGXx+8zNlWNBMH9vpZ4UpBGIXgnH03uQMaC96GqpVxEXERbAKoxDmh
         DlgnZ/l8nHh2kuayRJ0jmtjovbxm01aR2U7FbRKuPT5tC/JmgF8adrcoSDoBDDD+8eVW
         O17RIRoEZdBCsXmnq3rCLs3eHyumRAWN5fZPv/s7E6pUq/ibcQMNQVnvSNGnZxTOJeJ1
         s37W3fOh3elpG2k8AAU0lYXKXL2ZQ3PFKWuWX7as6hHzintnEHOq1H0Bzi+Es4sEoG1K
         bxNA==
X-Forwarded-Encrypted: i=1; AJvYcCUGYC9InPkHAvaXufWjeNdewiSgDU9boM/nO6J9jmFxnwC4A4YpPK3bxJfkaHXHkApLumJXj+TzP7S0Cg==@vger.kernel.org, AJvYcCUGwTwutEURS/rtqsP3eige9/cIZvi+Jub6S+tiyM2jCCIx1XN4uEf9GgAbmVthp6CsODWfTcvUE1DRFATTNFk0BYw=@vger.kernel.org, AJvYcCUuGRRLiNmRivBMQ1iapEmPH1/0TECfvOQZx3Z1s7aG+bYPRopDMFR5lBfCdylhzaVc5Yh+dYcjKLRzZV0=@vger.kernel.org, AJvYcCUvHagB4/WE74kMNSef7k6sXlexU9xIND7/IeV5fr55I+7lttFWG9m7RhAQYww29l16MmLFMC6kUNP4@vger.kernel.org, AJvYcCVAKhmyY4yGYrHF5P9gq0OezEgQOohwerl7/bma2hL0V0FeIe4brXSgo5h+A8/kaPWNbnn5xKXZ09dI0Ws=@vger.kernel.org, AJvYcCVdCTMV4dn4rt+YdRGkOyXnH06BfL3IOjVZPVpgT0Mt93MQD+t/jNRePYMTuhO2tsWvACNb87L0@vger.kernel.org, AJvYcCW/j4zPkninzLUtjBRVVVZz0EW64As+HWMz7bLlIerYHJeUK6zcdGDniXPlqEK2UMyiRCt7YigLESoJ@vger.kernel.org, AJvYcCWIZMPVe74T39UINNqXt8EyhmgTIvDu+zjs328fB3sQ41eqMsSFZe6qrbv3lz/vpjZ0PIQ/0ArbkW/WO64=@vger.kernel.org, AJvYcCX773FGbdp1eh1jExBQ9ifvuKPPpaGDyBAzq4uqpPfx8WOuh1YIMAwT5aXpzgZw2OEuLUkEFMYOgNsS@vger.kernel.org, AJvYcCXgfxG2ReNMukzGxN9RmIL4
 etyU5WQzpkqccC5AtgmOVQOIXOEmHtzmSCpiDlLMUf9n4NgCLe84wBqmEw==@vger.kernel.org, AJvYcCXoGXwayp1M4glgDYsE4ouGnCjw3c5LUZZmKeBZGuUuTCCRG03jhjBJMxfS02+Awbkz26DytktLmfY=@vger.kernel.org, AJvYcCXrXl/bzhyIoVi4dQs6GGNqzINaNFQQeG/Mzl2XUzlIu/MHvnZx9vLcKpw1dk3/PDjU7tVgPhPezeAtmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEad1I3k8G+8sGAnXgVyrZJd5cwed3cBkiyv/hOQuKCkniYtM3
	76Ab2GVcJ6o24xhEiYBD/oC1tMY4O40KcAn0GtsGxc53e9ai1Oxf
X-Google-Smtp-Source: AGHT+IEoo2Czcs+RGUiJMg6LdY8jxuXv0lNt1Zx6z+DI1lmpOeNWP3pCK2fVmcYSte0wULTaokncdw==
X-Received: by 2002:a05:6512:a90:b0:539:e97c:cb10 with SMTP id 2adb3069b0e04-53b23e857f8mr904316e87.40.1729763841812;
        Thu, 24 Oct 2024 02:57:21 -0700 (PDT)
Received: from seven-swords.. ([2a03:d000:2:9006:4eed:fbff:fe72:e806])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5988sm1310862e87.2.2024.10.24.02.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:57:19 -0700 (PDT)
From: Ivan Epifanov <isage.dna@gmail.com>
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mattst88@gmail.com,
	netdev@vger.kernel.org,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	patches@lists.linux.dev,
	richard.henderson@linaro.org,
	s.shtylyov@omp.ru,
	serjk@netup.ru,
	shc_work@mail.ru,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various compliance requirements."
Date: Thu, 24 Oct 2024 12:57:08 +0300
Message-ID: <20241024095708.189649-1-isage.dna@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
References: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> I'm Finnish. Did you think I'd be *supporting* Russian
> aggression? Apparently it's not just lack of real news, it's lack of
> history knowledge too.

As an avid history lover, you've seem to forgot, that Finland fought on Nazi side.
So yeah, we're well aware you don't like Russians, unless they're in concentration camps.
Which is exactly what you do now: segragate, based on nationality. Strip of credits and names.
Once a nazi - always a nazi. So, fuck you.



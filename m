Return-Path: <dmaengine+bounces-8269-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4308D2339A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 09:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E3F30B3710
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7133B95A;
	Thu, 15 Jan 2026 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ/XHSeO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E033508F
	for <dmaengine@vger.kernel.org>; Thu, 15 Jan 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466484; cv=none; b=j3R2HTooy6niic4/L7TE8MI3/JU1OPhcwcTG97UFOBqUxSs3iJ952n+HCkzvdKX9KhkjSIrxEIOXmxtEgCBsRL1KJug2S6M6e/RjJx2zPTe8VJyLPlB1i/QhDtWJketd7O3mrHkMhkTxqhNdbcIhQwDDVx7aQ5Z2BmMb1skpU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466484; c=relaxed/simple;
	bh=pebBiil2ei/oib7mZd9mepzUxVShBPvTNogkSnHrW1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFdxladeq4Ns+tUzNIDskuQzm46ExdwD0RJR/y6uvC4a+/Xds5Ro5ipn8mWuOxTrOmuSqJFufESIk9eT8+SMG+92xI8voXbfE6vgtYI9XafxIijlczSrdwCfrxfpeJgNPjsWK/UOfOzm2z2oNbI6YjumYaz2+C26GC7PrmY67bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ/XHSeO; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f1fb91996so1516984c88.1
        for <dmaengine@vger.kernel.org>; Thu, 15 Jan 2026 00:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768466482; x=1769071282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pebBiil2ei/oib7mZd9mepzUxVShBPvTNogkSnHrW1U=;
        b=SZ/XHSeO08Mn34xmfcutAj310xtfInQlFp0pit8oillBo1fBFke1FV7Y5hhdePw+Ap
         qcLz/5iMAYoUos6lXJka0fp7vLHquAeLcPXf0gYfCee6oMIQiSNExFBDd7ALU/D8gzKo
         Zs4eFXhZZF5mL5hHUIIQX3Yc2xLHn0d52xQExBlODtIvuCL/GG2l83oZ+9pQuW28lwuM
         zRHtef2iqZ31pKcNOG5rZixfdUEpBrZBko3flJ3DQvGTsbrvB+quY9gXE0ONlexr30m3
         S3G87qZRb/uOS4fWUKyrlhVA91/zIYBlstTIymiQlDcCya1DX8QNjrGFehVRNEfA82XI
         h1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466482; x=1769071282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pebBiil2ei/oib7mZd9mepzUxVShBPvTNogkSnHrW1U=;
        b=ZMT+tGosmXImU7C6O8P5e44ykWOIktVLLmPRDO5dUoGSY3/yKyjzu5M/E7acQLJKaT
         +YEXVzg0zGlIwlpda+rBysDwYbwMlKRZaRSHoFCiNlodi4XyF/n5P3hMK6hR01zvO9Vm
         AnSFXD+XZ0vVEz2/8eDWcW5Aa6+Hz2TKCTHdErNDozCGzSZ0RBd8DzAr5FdaaveiJ5ay
         rydkXMCL435Al9g2dr6FrhshXP4+7CmNVCrCpsnJq2wP5lF0vfqHDgp74YAmMUabMBLT
         BlZbUbMCYAqF/vEwKkmT1GMYqtaXBK+plOMzN6UPB3WP7PfN3e3cWsB6HOW1BOKFfsjf
         K4IA==
X-Forwarded-Encrypted: i=1; AJvYcCWkDWmrPHRE7jwi4kBnk+FOu5fxF0/R4WRcGlkiS5pF8CUVDrn/Hxs/kFqqN+ImifVACOxGGjdxaT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPUyEpAuTDRVCV5xFv5VKqWwXg7vay70Rwv8yb12TsfFZcV+r
	+5LqULJ2kXFDTHr7HElJ8p3egsMP7KRx/8pwbkrim2Z0Q63EvuqIXxb62YbQgUtZH1TrYHBlbu8
	VWoH8tIJ9gaj73WYwZdtXhOfNUAr70IY=
X-Gm-Gg: AY/fxX6ou8t+t6TXfiSHxxqRL1KgeOR0dljiRS3pRiik3BYPqhnGoZQD9Bi+2j+cizt
	ZEddhLZGSIe2+ZHA2oxJdqrwPA7zLXXdUibgoqGbrhc5RpP2WMfwoOqits+1PtAa9bLU6ZCMYlF
	a4RUihjG2oOIx9oDZUhpjY0l2LwQs+JQN3QuM6uDrAQTjTTM7y5atwQw1toN1JwX/ZRudDjWYXL
	SBC2d4sn9cVoTy07wx5OSnDykErIP5HlemnwikbPr0ofFAzcxiFdbJLaimmUhPuVkJrjMy3JsTa
	fDy+OeSHsYknUQVtPoRhpuv1gYMeDnzNbCz7Qk2mQuzzzrglTGSGd8uVuH3tOuX+KAP6j37qUBY
	DbA0Q8uhUfg==
X-Received: by 2002:a05:7022:2392:b0:11b:9386:a3bf with SMTP id
 a92af1059eb24-12336adc557mr5402464c88.42.1768466482362; Thu, 15 Jan 2026
 00:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com> <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 15 Jan 2026 10:44:04 +0200
X-Gm-Features: AZwV_QgLOj1RDdzVccL_41XskfEEs9aTrYg8yhWQDuDVwvWQC6YUiA6AbKgDm9g
Message-ID: <CAEnQRZBkxugbzhNk+HE_t=2z_-1OZ_mgON=8=5Q6wV0zJcNHbA@mail.gmail.com>
Subject: Re: [PATCH 01/13] dmaengine: of_dma: Add devm_of_dma_controller_register()
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:34=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add a managed API, devm_of_dma_controller_register(), to simplify DMA
> engine controller registration by automatically handling resource
> cleanup.

<snip>

> +static inline
> +devm_of_dma_controller_register(struct device *dev, struct device_node *=
np,

static inline int?


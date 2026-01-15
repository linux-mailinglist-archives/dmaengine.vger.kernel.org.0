Return-Path: <dmaengine+bounces-8270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75109D233D0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75B8E3023111
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3833BBB1;
	Thu, 15 Jan 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKvh7Nwz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4333A708
	for <dmaengine@vger.kernel.org>; Thu, 15 Jan 2026 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466561; cv=none; b=pTqoDvlFQbD0Efa4NcmX+OCrRbR57cy4ys6yhI0ewBUsWak4463PA+da3I8dA7NC9c5mhsxF1Z0+bU+J+Ry7Ps9AEcoREjHiSn9enWedRAwGLzsi666AKpKBWYzgJGA6eINKOXUjXyyGblabbYgNl0VN6TVuzm5SFB81aGcvK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466561; c=relaxed/simple;
	bh=VUL6Odvz2BGJmEiErMIp7g1YPSC3jt6JjrwwVLc52zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/WHAbD2RP4VhFIKdFNJTn4/xhTt1m+vWBnweM2crx0jRnK4sXik3FnYtenrgP84PVckIbbbtDTwFQym8t38XWy/sXTizY1r2PTlXc3VQW4w1hZePvQ2GlPFa2C11mid9TMIoKFQ3T2IxvXD2VSjFJU/idqE6BxwkeoPsJznBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKvh7Nwz; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121bf277922so852386c88.0
        for <dmaengine@vger.kernel.org>; Thu, 15 Jan 2026 00:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768466558; x=1769071358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUL6Odvz2BGJmEiErMIp7g1YPSC3jt6JjrwwVLc52zk=;
        b=GKvh7NwzgBdYiYlE70l/lFxzOru3vkQxO3vU9KGfnxWaOxLqzTn9Zn2GO4RY6H0JV/
         WTV7Sh3IzL+e22TIARy0575ItvU4RgCjw2o/Erlc4zEtnIR/Y34YNNO8XCmq9PZzbH7V
         ylIqiJRfKoxzu3ENdeI1jCpfgxF5PjL/ULj+i+96S7aK1q4OnLrOBuy7xwsxo+heoHXP
         +7IRr50rR19/FxGeGVxtzdgtzsXWrlu9KgBX70D/ZICQONTZ4qNtK/Kh0OhWv+FVV/Yr
         MnRKMYN5uyTvDKlbdw/JV7ZNemiY0enSUF+l1TLAfbuIeKdi9fLECNp9JK/Pk8Ll6vfR
         t/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466558; x=1769071358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUL6Odvz2BGJmEiErMIp7g1YPSC3jt6JjrwwVLc52zk=;
        b=QL3ieV7RYh5WW8VyJSYa6jx7B2RNY2BW0arttnTZOsovS0CsClpRvrkgR+bgmnuaSA
         YNuDrx7kRgm4HOjcpty7ZT64to3LrQV/TKtsWXjBsC5zG1e7rVi2BCEYZiKtcdhkz2kM
         h543CQ87L7RNJDjEcGPCUZVlSf+1mHRjnuli3sJWRhkB1wJilwDxisHmy/rYTzxsA9Uu
         KcG+8b5UbTR+9fDkqovVqXDIQSPoeki0+wA+zUUG7KV85UZYTye00PorqRT3/wgdVyWC
         aHAY12rc05mgH8kCaAlrcKrlMxEPCAt560E83mzD+ZU/6rizjZda9v6FmHrFD3DmTXfQ
         K6cA==
X-Forwarded-Encrypted: i=1; AJvYcCVR8OFzzDH3WaZhgprWO+Qi2OwnKFzTGoQWDKOWbuwmS0q1UvRs31AFvXBO6+IgIBIu6EeBkKxVZv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzurWI5uNCbuGALqoy5hbEShNfeboNNUjXsFCGpqmqsRwuSChnq
	E7bwMw/GbSkr0d0cVA6RhgDeDQiIwg4dEaLVgtI0XTsr+pyj4dX34xsLEElCbanB2hNCkOxOjNR
	Nbb+XBUev83Go157g/md39+s6O6wzKro=
X-Gm-Gg: AY/fxX6jMA1Y2wmqpS0Va7yQT6+GCC5dDRKW97aC6vRuC2WZSap3nno8uR40OXUgyGe
	f1ZKSM8b3xa8un9fZbW1uW4SAXoGJ2tOH9i6iGZwNEm5asrF+nZJxHE4BrRKZ79AkeI0Nzf40Gi
	8ql42rr6yFL28IXSzWVGwEY6oYhpn015BWLlQew+4imbJTALrmRJJU73J3gUW/ZoGmPXQ/QQLL0
	cNpGHUnLLNzq5eicaK5WOS8CsbXO/PhNGxy+2kmBtp2M8uBkvevjV+AXkNv6jixAWQVGUbYfK6T
	d8CjDS1Vr3d8mxdq2N0uVYvnYUGMpLmuI2gAAcV5zZEze6d7LfCIBQHgwFxAx2ySuALKPkua/9C
	hq7OpDooRiQd31kmPtlaL
X-Received: by 2002:a05:701b:231a:b0:11d:f440:b757 with SMTP id
 a92af1059eb24-12336a8ac7cmr5154017c88.26.1768466557874; Thu, 15 Jan 2026
 00:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com> <20260114-mxsdma-module-v1-3-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-3-9b2a9eaa4226@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 15 Jan 2026 10:45:18 +0200
X-Gm-Features: AZwV_Qi-TQ7lJMIQ3JWU_HIrOBnLtQtdsWIBSjxYFap9Y2nvd_jWRPWPx5vtGmI
Message-ID: <CAEnQRZBe5Q2Ejbf_-+Mo8zTc=mSDgpXuXbh3NVHcwjooggD0Ow@mail.gmail.com>
Subject: Re: [PATCH 03/13] dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()
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
> Propagate the return value of of_dma_controller_register() in probe()
> instead of ignoring it.
>
> Fixes: a580b8c5429a6 ("dmaengine: mxs-dma: add dma support for i.MX23/28"=
)
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I think you can send this as an independent patch or at least put it
first in the series as it is a bugfix.


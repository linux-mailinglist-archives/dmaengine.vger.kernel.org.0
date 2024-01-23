Return-Path: <dmaengine+bounces-812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2678396F7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603C51C2275A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E18121D;
	Tue, 23 Jan 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYlwAX+n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258D8005F;
	Tue, 23 Jan 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032367; cv=none; b=rsn+v/7wbItuzF6GJ+lop/3spmziBU9tuPGKPGm2pCQstXkvZUZjdE9BinspMo+LCAqnJc7uc+nc0zzXWGJHAAGInBtZGRlut3DlHshtJuxxV5Bu8alYpKCe03Gh5PTS6untBx1fZI/rrkGYtVOsAJ+Xz9PofLkxWa8e//Fdh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032367; c=relaxed/simple;
	bh=ODSh1qtbG1bbM6CR7/IPiC9+vleF+a/NSYhW27DI1Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjQT6LXhI4dUZDanRTWn4KJr5T3J4PSQbiKDhlvNnk9RXA5NWWQtdEcu2SZEKqaL1tF6OVj1OCXxHrXvmR57XLwzXeIbgzn9Hb0LKPoJ/1vPHjR77PiWqTn99e+bQz8xeQQdLjSNWxQW9CVsTAZH8c8Tx2pdbwHIdefHZ3QZVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYlwAX+n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e775695c6so45257155e9.3;
        Tue, 23 Jan 2024 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032364; x=1706637164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCFDtyr7qd7xHPm6qu+8wvTk3uDcROtuqsSzfcIUekg=;
        b=nYlwAX+nks14ELHpcKQFM83hgLtffpQLp+MCElkdyNk+brPsVufEIWxASFLcc7YwL9
         86XdyehvSBOtZnxzBF7Qx7l7cx8L1sUkm7xoDdPCaAX/4vdlcsY0xOZEiagf8xMxc/tS
         WCI+WEDQTi+nODVEr/evOW49p3TSndQ4J5mG4WOAFUqd6U0ke+tJ7/e19JwzT6X5erW3
         UWZa+yPKZjK5cMtXVyD9usy9F4mApVU+z+MaS67GUfK2MqMcK7bSbZNu4YFsHAPRAbZF
         2QUAeJEwhf+xMlMwq2dR2v7tHTiQFX1cTcGTZ32VtXIIPAkNqYVWJQ9RUPfhi1Hqbtnw
         TI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032364; x=1706637164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCFDtyr7qd7xHPm6qu+8wvTk3uDcROtuqsSzfcIUekg=;
        b=EFcey2opbbVE5bjN4NB5uhii4/x0UAwrkB292GjFjEHY2o5nBkiq7iQv1IvfDqeiwi
         IvkF0gS3/pII5DF3nqxRGaZYi4YqoESaQnpY1iPCaXZufCrsmeBuWi0hbKYAV8Xm3zk9
         swlMlzRZU9Ua5WS6TcO5SUEX5bd4c+9Yj2M+NIZOPY6jkTrCzxBM9Z3i1xjZNvbkX1QU
         mpbuWUB1Tm6mQucHFe23795Ug2BIeCSyOSW75Pue123LkD8HZqnS9WHOlYFaHRDYBZy9
         FRpMcEHec2wpGxRDYTZ04+RhihGrdLUgU+IwIZfgqVHfy47tHJySKkBupxlCtvvtz3IY
         7Tbg==
X-Gm-Message-State: AOJu0Yxv6D58Xip1r9aUbi6G/rbp8yQ1Qto3ji6XSzS2F1ZMM/stlBro
	s34rK+1yF9HUEYVbmuNmnfcSUcyAC5iexo8erFJLExsjZbxy+1Us
X-Google-Smtp-Source: AGHT+IFLLxpjWeVimFPeA0MfQxF3KfPqSXqkgvuKucKNZCdN75cq8KsxjdqW/L6iAutpuqHKjQj9nA==
X-Received: by 2002:a05:600c:a003:b0:40e:6227:175e with SMTP id jg3-20020a05600ca00300b0040e6227175emr856538wmb.61.1706032363904;
        Tue, 23 Jan 2024 09:52:43 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040e76b60235sm32151725wmq.8.2024.01.23.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:52:43 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 5/7] arm64: dts: allwinner: h6: Add RX DMA channel for SPDIF
Date: Tue, 23 Jan 2024 18:52:42 +0100
Message-ID: <22159747.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20240122170518.3090814-6-wens@kernel.org>
References:
 <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-6-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 22. januar 2024 ob 18:05:16 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SPDIF hardware found on the H6 supports both transmit and receive
> functions. However it is missing the RX DMA channel.
> 
> Add the SPDIF hardware block's RX DMA channel. Also remove the
> by-default pinmux, since the end device can choose to implement
> either or both functionalities.
> 
> Fixes: f95b598df419 ("arm64: dts: allwinner: Add SPDIF node for Allwinner H6")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




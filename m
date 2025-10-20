Return-Path: <dmaengine+bounces-6887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A8BF29BB
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 550394E8E48
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD931329A;
	Mon, 20 Oct 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAbfcdLb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645A2D1F44
	for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980054; cv=none; b=TbUqUufEMQFXjjQo52KiUaI3GapCRZd+r9LIM4WmgIWWbrXsrR9rT9jq9DQ4nsvYzQOU5lP60cR1CrHfxhs9aSZ4Dm4Np/VB2Sn/G+v86zMp/1geaSK49/F/tw4miwE7r6kHVzrnB4x88OYpCtdLRzpRZZyFxkERByyrspLrAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980054; c=relaxed/simple;
	bh=9640FzO+7LwBWDEDlYQ6XFq5rpeqGgD5bICG4rK6d/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PU0h/fHgkqpgAwVzk/JUQzGO5PMcmV0M2/RPjpqfqn0LiLgyiK9vsYHxjqKblgzeyIvkYXgLgeifNlx+HD/R/CivkNxOeDlWdkNbriQCbbYwDSZ3GCJbE+mr6MNEkOVxI5Smtxs0X+LbNjGi0iDgPEDhtG31acZCtAIPfjvdZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAbfcdLb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b303f7469so36415125e9.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Oct 2025 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760980051; x=1761584851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9640FzO+7LwBWDEDlYQ6XFq5rpeqGgD5bICG4rK6d/M=;
        b=mAbfcdLbHYH9nh1WuMzbACp3YNcbnk2jSc+G+v2ZA/HvkC1tV3CD+/av9IYxHJ1i88
         NH0pTwd6hN2JXq44T/tL9owUp51vo9OhNK/yFqvnqT/FdeuqkqZwr/XtDiNEJUC/Xl8n
         Chd0qMQkLT8KrrFcJP5aYB7vtfZN7gRRQ/1wMVJhTd82szdU9nwI5ECSuoiUJBcF96+K
         tTIT4L9wiFfl6dUThiOn1Mc2iGE9G2TUpC6y6e2xsrnMhcaURYLWuwxVRRvBvwSZW7fD
         KLbFV9z+rogiqf0hlY8rVZA5MbBYC5hGi7bEcMtHWl+qGPKv/dIXYOCAyC9HRLhu+6k4
         Ycnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980051; x=1761584851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9640FzO+7LwBWDEDlYQ6XFq5rpeqGgD5bICG4rK6d/M=;
        b=pJ/6o+68EVvuTtazaHtDHnv9fg4vdPz4jD8U6praeUosYCoMPtQc3/kg0wQ62pCFZk
         ePjOvF0xWO+zOFHtIyA3LzJhzvChffcu+o62uI2bGdy6AdmB9QovkYFkxGV/Y66KJjhU
         IBuFAQ07qMCXV2eCn8kBFdaHLLi4P/y2+NsXO1dGN8mr2SOxXpplXGLQlroQvDy7y1dy
         NWXW/fFA1uGxGVO9DBw6t6Zgkv7r0I52X46KYHC7cU8wtih/2kCQ9Xy1ekwwTO3ahVDl
         ITOsJ/JU+DI/Pcrjza8oq1ZHVDcLkUbHvL20uHxCh/sAD2h+RTE11HLMqe2QseHXGMUm
         IT8A==
X-Forwarded-Encrypted: i=1; AJvYcCV+6HFyfmodzw2gxKB3D5VTWPg1rzq3CnbAiCVIyAFX5u24PXVz4rRt+/jKA6SlqAyj/Z5/w1qWtIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTx4BBNpOQ5tLYbAKLODK+8ZGj2X+l7ilqOUJtu/p/n8vr63Ro
	ouYgR3avMaq6iqyfZrn28akwtzsWX4PvOHhJQjL4iPr6feUnHcRk3fTGzcqyuQ==
X-Gm-Gg: ASbGncuJ0glfHzOg6ibyOeZGIc139akozzKy3miadpqNyto3jKn19AOYuKAK/9K2Sih
	4uQLQPbQKduurviHEJk3ZZFxtQEwuM+lefXfGMDAVdcV7hdQgD51O/KSGWTjK9wMHji1pk681rb
	zzu3sURURkKaN+tI0KliggBM2lXLOKdlaLK0l/ITUEYHcJnAPFkYM3w5JjpcvE0+v9wEP3pVOm3
	+NmReCMLoiNYu764VBge4qBmfVDRehli7oA/BjtmwraVJt0uotY/GkxH0qvoSZl3Z6CpyXczJo6
	E9Ze0bcHk6GCwxXVH5BvLwuPhn3qsdraCz2VChgb27aj0apdYX0sBDHezLHhfcYZbMxDO5H2unH
	ARntlEqvrlUMXOGhGOXeVx7Qcn6diCajPt8h3g5J/kbhhsLPomEP7vnId7+YEZV9FHTiSarfK0k
	w/nfS61kcZUBGIrWXxplfcqMI+hxZ2phHxBGSreh2Uu57+05YEObXOvPhsyIOSb3nmZzOt
X-Google-Smtp-Source: AGHT+IF71H05NxO/mN75w8LXTuLNlvDg53UBaWFoqKaZMqlp8yMREG6PcbIoHKXwfd7uM03lA2vPNA==
X-Received: by 2002:a05:600c:524f:b0:471:115e:624f with SMTP id 5b1f17b1804b1-4711790c2d6mr98843065e9.21.1760980050861;
        Mon, 20 Oct 2025 10:07:30 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c34sm252921305e9.10.2025.10.20.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:07:30 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org
Subject:
 Re: [PATCH] dmaengine: sun6i: Add debug messages for cyclic DMA prepare
Date: Mon, 20 Oct 2025 19:07:29 +0200
Message-ID: <1934468.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20251020170147.2783867-1-wens@kernel.org>
References: <20251020170147.2783867-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:01:45 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The driver already has debug messages for memcpy and linear transfers,
> but is missing them for cyclic transfers.
>=20
> Cyclic transfers are one of the main uses of the DMA controller, used
> for audio data transfers. And since these are likely the first DMA
> peripherals to be enabled, it helps to have these debug messages.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




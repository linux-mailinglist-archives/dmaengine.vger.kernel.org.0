Return-Path: <dmaengine+bounces-1355-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B087A5A0
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E6CB21C9B
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ED838DF7;
	Wed, 13 Mar 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itFTvRxf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA421CF87;
	Wed, 13 Mar 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324919; cv=none; b=UO7MhiwyK/LHPp9D5aC/RD++oWlVSE91TqfeXnG/5JtZbi5e8OM420P1PCeT2ABXvK8BJljtcZK2IwjED1cjR2/8CimnDOI/JiIouzT3dsSwV62XKGhM8vdc5XMUqB/DQTDdrcQxWyrR9N6AOBVdh9Ur4EMqDmMjgHNKG6G8yUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324919; c=relaxed/simple;
	bh=aXTCLlS4y4QEhlbLUhInaMoXhFqY3QaANvShb1ApMks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoy0e+bVhtySffYrLAq1x+ftEt1xQ2P/KdYKZyy8e2O/yr1SLR5lu5nUnMHfY0MKBbg+20mKeftXir39v3PntVaNr9BVDjVHWQH/QqUQSifRFfnUtjoanaOjNqVKGGtw1Ck8JON/FyYk8i6hsO4XsmLGZw9Ad0CsiqEQatued8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itFTvRxf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29a5f5ea920so857915a91.1;
        Wed, 13 Mar 2024 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710324917; x=1710929717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQiuGj7PdiBNl0+f5A7u09zOwXRzHIjc9Zi58L9ZCcU=;
        b=itFTvRxfAeQ1DK6pN88wNWdkvu8O3xrSg14bCgtWKroZyhaKeqgTbhKdTQ4fr3N+zE
         y50eZAHAe5/bMDSSReRMw3CofkE+9B53RwLejOWFncUhcLNrWWZHKcswj69L0KFZmeFM
         RJTsVDJkZOFs/Ir5v8UFtKk0KW8t6qbUa2PQNLEHkPYCcqKna1Bd0b5Bto/MCtbg5NsD
         flsd9HKvru+hMlbQ0ixB58WonQPYmZdAUGUbKVNpVUit7SkcI60mBzyScO5yYe+8RP+e
         6SI3H4SaZ6GJDlohLpnb1GESQJGjs3ZZ0WX+eWeHTOQlJvtOzXUjpeBOlQzAHPOYI+Dy
         BgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710324917; x=1710929717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQiuGj7PdiBNl0+f5A7u09zOwXRzHIjc9Zi58L9ZCcU=;
        b=SYfDlImS+49RnoVIMHKZeD8mF7s6AQzmwN7LmfLZSVcoYVfyi0lgspF25jvDv6wBrK
         b1U2zHfboBkj1McMvVq7waQCMyLYktw5QQop1hJidT7L6Hc1cYwPyKcgPylFXjskFbPW
         Uf1TbF62SksgQthRFccqunpiDTwvOdKVw2fiAgH9XkinJVPKpHkdrLpMxAYI0ohc6iQC
         +rtvd9eVbJUCFVonrszcoXqAVQCI4Tf25J/wj0Tiq59V7tZJkzvwJMDGpEKODSPzLkFB
         HKXhiwzFuICejJIekrrsJ9nvgg+IkzyetgHp1f/Fm7+5utxTctYRGRDG4D2fLq7xHb0j
         wKpA==
X-Forwarded-Encrypted: i=1; AJvYcCVgmm652KCXwFcIql+U8hWg56tzH5OMyo1lSh9a/SEr7GWLzeXMc45fbJ1K2gbqv9gafKUJMjupkxw0LauRASz1J6kIECrnBY+ig5XUYp2NcC9AFiabpJACphM+hD+iRDfs2ZW6KTT6
X-Gm-Message-State: AOJu0YyUwAYVW0RpU1IRF27CvxKvn2Yak8+9UUt/WhlcXAdjsfn1zvDs
	JDoBnz/4+34Zho7qUtNPRZHUW20CIAyuReCnBQktFZOd+9V/gFNmmRaBRuLLeLZCex8eiZsbE8L
	M/gQyi6uljz2sjN6cRFt8G1ve6Y0=
X-Google-Smtp-Source: AGHT+IFdJFcl/SekdaJH+/L4KOclnX+rJ0Kbf80hXyVdh/bz4CV/ejFTQkgi9XmXAQjX0FJCQ+yCTkyB9cnpDtcMmME=
X-Received: by 2002:a17:90a:7186:b0:29b:ff24:4426 with SMTP id
 i6-20020a17090a718600b0029bff244426mr1061401pjk.2.1710324916981; Wed, 13 Mar
 2024 03:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com> <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Mar 2024 07:15:04 -0300
Message-ID: <CAOMZO5ARM2pS93jLjpYZRfLU-tohuDXUZxDrWFjvVBGtH2t_aQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dmaengine: imx-sdma: Add i2c dma support
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:33=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Robin Gong <yibin.gong@nxp.com>
>
> New sdma script (sdma-6q: v3.5, sdma-7d: v4.5) support i2c at imx8mp and

v3.5/ v4.5 is from 2019, so not "new".
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/imx/sdma/sdma-imx6q.bin?id=3D55edf5202154de59ee1c6a5b6b6ba6fa545715=
15

I think you meant  v3.6/v4.6 that Joy Zou has just submitted:

https://lore.kernel.org/linux-firmware/20240313071332.1784885-1-joy.zou@nxp=
.com/T/#u


Return-Path: <dmaengine+bounces-8268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F9D21C2A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 00:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7E5D300AAD6
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF076393408;
	Wed, 14 Jan 2026 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRckAmLX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4083563F4
	for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433263; cv=none; b=MnfezoXx/jYps0yfIQ6SUe1f7BLMk9RHzTMjyu5hWnbGZpQwUMYxzqzqdDPpbFYG2W/4GcSN8/pOaG/uxnPqP2ZZvzcdR+C92E3GcsqPZ48ihpe2mQZ5CRQl1a21QS6HS5vyntNT4tUlg3Z+FhdGSlRupKYVmnY+RsDJB+hSfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433263; c=relaxed/simple;
	bh=7CUg3xaON2YJyNDUAfyHXm5zz5PYeFuwzhozRYxq9FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLwvvNjLAXceJbld/lOVkAJ9pr4mMqzRSZ/B6SOlNZtdfyhatVSh21cyOvCse/jZAdWPGs14L/FjoGXb6ipfHdVWjCvMpu8Fid2PHLmUWRXyqaMQuUrMQ0G3CgnuVqE51eUs3qfxYDz4Mf2KOXp4NwFhm0m5mnYiNA52c5fjqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRckAmLX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b679cff1fso306853e87.0
        for <dmaengine@vger.kernel.org>; Wed, 14 Jan 2026 15:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768433250; x=1769038050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO7/rwLXC5yGRDXneYIJQs+eB1xaWdUmRL6MCrxGUVo=;
        b=NRckAmLXQTmDNgYWUlmjejyavZ/T3x8/2/qWB9kSI66UFZehw++BSp/DKq90LkJ9Ys
         BU8NidRECMCIlegq0mx/vXPs8bChq+lJTwr7kndaW2QEey2NswfGJ42IWjhJBT/1oAzF
         ezLvefXuNi44ehLrTNIqEwS0vy51stKVJEHTTGGi4xluA70qKPKhtM2uV4eUxUwRGIyW
         eSxsR9ZRwJ43S8Gf7q54FFbghR01YzGPGPhQW5zv8MjYKXck1vgFDCeporbbPuo3JkLK
         J32leOzGqQVhJAEjDAAmk5Lqifv1rOUELZ4LlwuCN8sWYFFPy/YdSklB6ODtkX0A0u1G
         09/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768433250; x=1769038050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zO7/rwLXC5yGRDXneYIJQs+eB1xaWdUmRL6MCrxGUVo=;
        b=aLGqiEFz33kUpXrUwVzA+E1unZywXh/EcO1f5jFH8RoZenSbyy6AHvrMwST/ueyicN
         2Q1B5riVSNS5uEAc7N5SAwtgcz5q49LISApqwep95JAYr8XSky2VHX/4jhrjhI4tyJSQ
         e0lGciFOwJvxrjTOxZoZxBF/x0JAIC01ZpVsq9Blx915ghsXL2ggUk8gSGjC+5fwLhPz
         qgtWN9oWzG8JGEsM6/pLumpclsyH+iuEM/0cskFMfSFDezGTw2Cd0Z5xQTxJS1JFn4aJ
         u+lG/M0T3WxQmy6r/FO/3jncmQwvW30xDrKGj2MI28CVKRJcGaZQZ3BIlePtVOChU9Qh
         zUmg==
X-Forwarded-Encrypted: i=1; AJvYcCXbXI6fSV2oG1veXw91hlA+FUY2n66S65eSFiTP9nxGiC6KuFS2O714dM4KkBLXPBUgAF13aV3b4R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleYyIiHJT3bQR3ulrE0luJRT4ZowBfj/m7euBht98071vEHQ2
	z3dZCdO/Wj5ARt4CpM2s21/DNaaLH+ntI/pzyJwZPAGDyhw/NfRXihqHZ6iRqbF+pTsLJGc77QR
	L9uddE3P+Ze+dzmtO9m7JIcKFUh0u2Ak=
X-Gm-Gg: AY/fxX4nfyBuhp7j1LUFmbfLeXOqAp2yuYZjjFRSWPmnf8r5LCcihYec/vfglaGSePD
	vSBKw1sPYbcNW1vMIVrAZiVNo0ls1U759Bs9u4MB/Lerm6CRsfByCLZFMfqK/O81m+rbMAAlxJT
	uPpuCTR/omwH6PQXsEGCA+fUnZfP16KgIS0eKdkhXfAgMcJurgtN0O8O7WGxUPkNwaHyPPQfCda
	mkg6f9dJAgZcqf7eknDfv24Oj4n2lFXQqstE375sAAIMxhHVZoQx/FtCH5RrcyZff+ZzP9dj9zN
	tfHviyxxJti8W4W8P0OaNqBZSRs=
X-Received: by 2002:a05:6512:b90:b0:594:25a6:9996 with SMTP id
 2adb3069b0e04-59ba0f5fd8bmr1478472e87.10.1768433249392; Wed, 14 Jan 2026
 15:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com> <20260114-mxsdma-module-v1-2-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-2-9b2a9eaa4226@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Jan 2026 20:27:18 -0300
X-Gm-Features: AZwV_QhLF-nZE9rj0D3-1M6Zo3V1EfOAoeRCu5Cv2BQMtPfiN1SS9FZTgf1Ap2k
Message-ID: <CAOMZO5AF5-=-2F2W_U9=VbkwtBp2_hzKkJziefLeufD97xNj=g@mail.gmail.com>
Subject: Re: [PATCH 02/13] dmaengine: mxs-dma: Use local dev variable in probe()
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:33=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

>         ret =3D of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
>         if (ret) {
> -               dev_err(mxs_dma->dma_device.dev,
> +               dev_err(dev,
>                         "failed to register controller\n");

Better put the dev_err() into a single line now.


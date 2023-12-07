Return-Path: <dmaengine+bounces-397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF280895C
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 14:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2641C20AD0
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EA40BFE;
	Thu,  7 Dec 2023 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVcvCfp8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4CD54;
	Thu,  7 Dec 2023 05:39:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c0a11a914so10026395e9.2;
        Thu, 07 Dec 2023 05:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956382; x=1702561182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNlERt5vaxD3qhwXwd+Dclsfyu3fQGlJIAQtAXUS3yA=;
        b=dVcvCfp8RNdBNp97w0xJ92fCnjKdhkvYdwHdwVepg8khlsn6togyOu5052BQYvGg3d
         cJr7EXSay3+nqvqU0rVfyVHWym/ggIS2sHbeVcdQO/+aWUxlU6TKRC19SAJiIMzqffHQ
         m4JaLXreQNPGkg2YZxhRSwPVnvP435YlclS7rBRAV+JnB1n6m8YiZ3CRNhHtsiTp7kqP
         4/lbFRR3OfvrQMfSaK15RTSxgIUDVCGalN9sk0IYhqnTJ6huY3sgBp5JydQ9qEr/sSkZ
         kAHZhg53myBXZsVi31y4zVdg8Zu70HEx9M0nfd4YsREcyvPDbwkBLqvaoVSaiXfKFE6Z
         5tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956382; x=1702561182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNlERt5vaxD3qhwXwd+Dclsfyu3fQGlJIAQtAXUS3yA=;
        b=ZaJ6ghnsP2kK7zC93gnnaTGx1wdNC6oNO2W9BqvnzyjfDwO0jveyvGyegscjUbWHtd
         UbMNW5cRbFvwyLeOPPIaOCOuIamBuCFx5pEgKelfQzCl14fKmXEJDlhEuRMHvWK5sW2y
         GrX4E1TVLRAfC/efAXs1f1Rsdv4RyWK5+CMn8JWlyG32hVp5yumhDUGebiv1CKkdpHVA
         wfqM0wsJ6032szydhqMGjZWyb692gaAUE94n9qeX0yFVZ8d1cNkZiEf+tfFOSgUboN1P
         h/JWBbwVmSNkJtBnRu7UM8+j1IFeWutLRWVyM5kc702lX1j5ANq5OB436LKGFve23oWy
         JVmA==
X-Gm-Message-State: AOJu0YxtE9MlWC6VpFcOpYJfKvExFeLFomze09Ub8VUXSUPjk5rHti/J
	RbXKcvPtWhWlXVl980swrNNxwHpuV8ca6DjoPFcfCQwv
X-Google-Smtp-Source: AGHT+IFc3fB6rEkp3vetEY+eHNgP3eqg/Ant0fURSkyk08Fbiuy+m+NJBFf83U89xaDmP287XoOLqLnmQgPq08G8tYo=
X-Received: by 2002:a1c:7c08:0:b0:40b:5e59:b7a2 with SMTP id
 x8-20020a1c7c08000000b0040b5e59b7a2mr1669821wmc.127.1701956381852; Thu, 07
 Dec 2023 05:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207133452.14726-1-dg573847474@gmail.com>
In-Reply-To: <20231207133452.14726-1-dg573847474@gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 7 Dec 2023 21:39:30 +0800
Message-ID: <CAAo+4rVWbAmNnM+ewr-EZDSmVzbTtUcs0TdnyO1G-JJxGPoYXg@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: pch_dma: Fix potential deadlock on &pd_chan->lock
To: vkoul@kernel.org, allen.lkml@gmail.com, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear maintainers,

The patch is to fix several potential deadlocks that I found several months ago,
and they are found by static analysis tool.

Thanks much for your effort in reviewing!

Regards,
Chengfeng


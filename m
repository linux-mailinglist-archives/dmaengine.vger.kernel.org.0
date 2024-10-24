Return-Path: <dmaengine+bounces-3543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C99AF227
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAA288995
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A5231C9F;
	Thu, 24 Oct 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAjoxaBC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD52170B1;
	Thu, 24 Oct 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796974; cv=none; b=YZCFr8zAmYaS7yfF4RaOtQNa3si1qM3MuFyi9vg7d3uWzuBgc5F7z+S9bScZf6+VYePNeJ1svKtQl4nESwdjjTbdS/kY3TH42hD1VyPiJgt7VGSluG06GGj30u7X12iSS+8WHX3XclBIB4R/mnBnYsxzOJ+zIW5Ad/cTeaw7tF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796974; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRhHLh+falF/oqws9YLKjMna6yJNpn6Zj2/Y4yfxzkasBIMSU9kXHZRGMp4KMNPfK34AsvP81p1ABYpqAvzgmlDA+tmIE6IQfDre6P/9P2l+qGTyXJjECvb9de35yq2CPCFLb1SegSvP11MuvIVVUXqEnKfCVU07yItLE1hN5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAjoxaBC; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso12731221fa.0;
        Thu, 24 Oct 2024 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796970; x=1730401770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=MAjoxaBCAqPbhBjLuRpkziZDkmp5z1h1GylPO5z0AkmY9VVIN4mAN/CyWe6VZCNcGN
         a81OD3rPwHFQd/uBlbWoL3ZOn7v8RlRExqbeb2jU1LMzNeMDiUGdorzw1asd+oN7af6k
         nx1IPvkUfE/09tS+CC5t8AqEPEUpkpI6Hs6wtPl3BIaf9yX3Pmx1kdUqyKOyp9usil3t
         lD+wD0VMMZHlSvevP7n+zsJC/onzu2zsnzK1/syspCT4hrND3GrKFAUwGWFFMJn6DScE
         1kqsHFHNCP6Mdfe8GuqVH1tQ+bxukqezN9RLQnwP4viI47T2dE1+GM/5iu7TETKSK0EM
         HS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796970; x=1730401770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=g0wn+snGfgmK6ukZUWY0Rwf2Twj/wENwrL9xBfkRLA14eT1AI9M1kPyLMluolI8HLk
         CPwhrO3nU0zxiCNftpbNM5bdt24mY90dXQaEGz0smX1TS8+AY9i3BCH/I7YkPrsqXFlF
         SzZJ+kyGUm+UQOaeEK8sl/DFdCLCcTRo9lRo/dbxAlTjFosqYPheZJKWJTNFiSB1gnnK
         12kQOzpMGUA8Q2tOpWdSARHqrqPDvbJMLOB3jmVI8Na0LyG0nG23BYE3pR62KtwEYGdM
         nTPn7fQOUzmlnZmeXZOljYd0of2svZ1tMyKzLzVitHCB+AND6mw93gxZ/iV1zhYsyC2w
         AXOw==
X-Forwarded-Encrypted: i=1; AJvYcCU0tbimLV8Q0JctPMcLbDKivaUtmNuo9/cseTSW4+ehD4yKN1+vkRAC9xuFrj+u2YKdN20vrTZkJj3I@vger.kernel.org, AJvYcCUJrZLy59iZQJw9V2PtUIsOweOID+2GA+gXcdK+KWJ6qeOTbpm4f5LxwGom6sd1DW1DTjoAiD2nn7yRV9M=@vger.kernel.org, AJvYcCUSYWRLtJDXRyowG1SD7vXFRHOHH8DZ/cwqaGuKIBeOj3OiDoFPqJAX9A5I61oxr7MGcVs8jh7a@vger.kernel.org, AJvYcCUSsOSjgYQ2QB+JTM6WvxNDbnUwi1jTVsfLalPl9lCJWyQc9uAOcfTfxARQtefeLq5tvERGRudes8WgeBw=@vger.kernel.org, AJvYcCUntmlMR4qYIF0AXDPmO58kPwqfObtTAAWLX0w6q7iKHkx2AF94TM0aEkFZda8UEZ1KXS8q8ZAKFsM6tA==@vger.kernel.org, AJvYcCVL3B/ANDZc6I/BI5B1TpQlVCy8QTgFq/J7MuG3RbtLzh0Tt8QEavko+nw542tJ0jrKfVIp4sw3XWdI8VIeX1zImnU=@vger.kernel.org, AJvYcCW0EnwnRPQk70c2vqhEXHuLKwPywZvuvRTdg2nPvf/3zFG6BHWWg5p7h5lR/2NwpqwAIRazQAWG87E=@vger.kernel.org, AJvYcCWC6QhaTr8kajW5hTgFnydmkQm4ur9qVvUR9O6oZamu7K8HC18Hgn6m3FzIxvmmTFLbDByrduYUiawB@vger.kernel.org, AJvYcCX3lz7v0E1MpDI+ysL1RxRENQPPUdBc0Djg09gc/0oN93332B65TjrNZV9Mf/HECwYERtXiA2lZRaVC@vger.kernel.org, AJvYcCXOZYriUh98s2/UUelqbUvVw/+s
 oPKsLDzT3m38vVsYigH3y5cSR7vpOkDQdKur7zqtDvTBssgqruWmsbA=@vger.kernel.org, AJvYcCXSFmMfQGCsWD8kb+rKekkVMWMBhZqd8zwaK3WyJbm4bm0U2T3ZpzQzQ8GvKCDHFlu4lvcikreKzjY2pQ==@vger.kernel.org, AJvYcCXdgM9ZbL/1gATE7g/dZF2noALwm6Xwu+WeZwVWOINZDH8GmIaqGkO1M7p4/4Drz937ondRsSHZeUuopg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycAB51b8Ae18EP0HZ2u/6mYomCDOsGgULdXH6vg6xiLK2/naUr
	H1WfLY2iUbpCsFBlj+uVzFMbG25WnA8FzmHTKYwj93lwZ37rhAbM
X-Google-Smtp-Source: AGHT+IFapLMqtC9mxh4U1nb2UZfEM+54m0DZFZCbAfTGzuxOWpBN1kwUmsJsLlMrKLr/VmOnsfwzqA==
X-Received: by 2002:a05:651c:a0b:b0:2f8:c0bd:d65f with SMTP id 38308e7fff4ca-2fc9d328398mr32688711fa.20.1729796970166;
        Thu, 24 Oct 2024 12:09:30 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae155acsm14571141fa.121.2024.10.24.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:29 -0700 (PDT)
From: Russian Troll Factory No134398604222658691317071485813290162362119138299248751155352853315159317771744424793254803551268236789250431586118349188925940 <vladimirputin693389@gmail.com>
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
Subject: Magisk patch for android nox devices
Date: Thu, 24 Oct 2024 22:09:26 +0300
Message-ID: <20241024190926.14783-1-vladimirputin693389@gmail.com>
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


Hi, the linux mailing list.
You have asked me for your opinion. I present my opinion to you:
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK
LINUS TORVALDS IS A DICK





Return-Path: <dmaengine+bounces-3502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86669AF001
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E51E1F22636
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F420400A;
	Thu, 24 Oct 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji7aHX2F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37B20ADC0;
	Thu, 24 Oct 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795975; cv=none; b=QPspqsLcO+wMM7DAUTd5MC5LHYef2VtSZna/WVKw7gguOBoUfHSgAVvnRhmgDFEe1j08C1o44NJrMgWUbx1z1cNjfIXW5i3aSAP1FihedpERYAumBz/pyNErrzZXqRcvq7Ycvt7ij83g87lk80TssHIAbzBQ1ebgDPIeDbnD2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795975; c=relaxed/simple;
	bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE63dyp9nxMJev/C+tg9E0Tvq0yaiNEmQVVz+CXUDyEUT/3P416GZYfQLd78A7+vtxAxSGFXHkoyLONGsfNuaTAz4+niU9o6+k3474gF6ygaQddhSNQqIdBbhe6BngJiIq8mo+SHyoT6xf+oZz6hnttck8rIdj1c5hCP/7Lmjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji7aHX2F; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f8490856so1211647e87.2;
        Thu, 24 Oct 2024 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795971; x=1730400771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
        b=Ji7aHX2Fl0Bup5yleXQglxPmeh3dFg2sj7fIyG5xUS9rLVWogsYjL1tGxlmse0hgT+
         omGffpTOChf1XaoFpUEoePzqZvS2vNxlB2y6lxYDXC2xnbXGbv46MuI4o07kGq+zGPyW
         JteP604mW+qkAFw/fU3D72rRTTFFpJ1/GZz1a+dAX5/m3LSPsDK629e+OWEaO/ZYikve
         CjN+gddUbr2sV6NwHxxOuw5ZuN8hwaxFSyyST0BXCKVL03NXPmeKi2pnZQgKz4rPEU3F
         qJifwJV0hGKbmADgBdRkpWC+YV9y+lM69lpYdbvhE/9Q1gY48FX2GZ4nHFHBOFx2n+Jj
         XhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795971; x=1730400771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
        b=r5wUBZRitjqYDvmD99kKx8G2AGbiBObAWSgLLfWvdH+3EtCVilzM0CmrCjFBpQ3uEN
         8fzKgps+ghdZnFhiIOljoAvBahFYOZI87WZ878KPR+Q7wjikUVkGo5ih9MCFSI8kjoow
         x4OPLeZ9FgpiRNXLWx3M+SK/5xIlhe0f3A1+YcaYwz8g3PJrGEckTfC5yuFr0wgFMoXh
         hM+IEnbmuA0M4r9+ATxEStMBixQ60JTrRnPnGmnzXZWcHAWIHqFCjJfVXE2BLB0wix64
         2YjZHd5zLrs7OqacYizygmm9RQXK1eTmDWHqatP1IQcyl3AjXb2MqJpfZlnISEg4zN+R
         5RAw==
X-Forwarded-Encrypted: i=1; AJvYcCU67Q1F6zT0PAaQ6TVRe7D9tqx5xUWkb4ry54EnOQ4AhxavgRBHZTZiQO0KDaHYpJ5KKhmCuOgmeXKulpcd@vger.kernel.org, AJvYcCUWLcOgEbgZJYFWAqV8oshrGtgQDaz9g6a88lKZfEJcFnfZwDfU6FUSfjnumoXZTD9kMsi1VQyxD1RZ@vger.kernel.org, AJvYcCUh8EBB4Q/8aOZh1iuMs8DYfQWPjpRf8C5sbBeH/uzzd+rwPxhRzbFvl367IloM64vemuxfCBDF4MI=@vger.kernel.org, AJvYcCUiQLgDVHgpxsMTKXxRoXJiDBWipYBRt4XIvD2pagXGgPvTrt08onO6gbv3QyWDVRSUFIp8Ckiqps33lrC+@vger.kernel.org, AJvYcCV76LWeXR1fJSsAEv75txMIggl9NbqD6Q4CRHMAuz+WXarJEjY7HgbYOhQKPeH6b3PTR/8jWniW@vger.kernel.org, AJvYcCVH6q8EMF4WcekDuFP23aeyEugzKuwN3tme5V1NoyCDtjc8RqRhf4ZDpOI/lwU1il/DCFLiCl9EyRGxIA==@vger.kernel.org, AJvYcCVoFBhirUrzH5rwLzeBNcqmLqBynElkt78eGPSmbt6wugJ8/AudcMs+5BmwPSaYyX8tN/pWsD56gMmw@vger.kernel.org, AJvYcCVqNlL6a1Emn+ws7nXp7vOuqmYHfP9YcK6HqFwHd9oaC/CBtHx12jEa9pRwkit5i14Tg17Jy/Bm4BF1hadNxmlORrI=@vger.kernel.org, AJvYcCW0+NkWnoXFBVob+IB0agsd34JDeyGv1jlv6w0qKAVXtd77rXJHEBJfb/6HPFnfGPzmECFOycrmUS4C0dQ=@vger.kernel.org, AJvYcCWZQ3wjJXCB6Fy3IIAToG+p
 3GmvHirwWRskya18P99moY2nI882DkpVKOYXqHxfVHReJihhd0N1IdkQgw==@vger.kernel.org, AJvYcCXP+K6FyWxUwCIexl3P0Wuwr41651FRxH64BcEYKEQmlIz3gBv6UQHRi70P7aBciD4cb/bDHJVWXF9K@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuV9YjRTuFZjLoQPbqloN8ytP4ABATVQr5jIshV923sRdR2pf
	QtylzNw76vRExsVYCRxHu9XfA8NM1MRmQw0wSZPq4BSlHSCBZnab
X-Google-Smtp-Source: AGHT+IHshdOlG57FQEvIzmi2L21uI7l2qUqICJxK2F+XyFQ9DK63Vd7m8czfNiZl0Og14v2rRrY6/A==
X-Received: by 2002:a05:6512:1599:b0:539:f26f:d285 with SMTP id 2adb3069b0e04-53b1a2fb015mr4711374e87.3.1729795970834;
        Thu, 24 Oct 2024 11:52:50 -0700 (PDT)
Received: from localhost.localdomain ([193.106.59.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f029bsm1441196e87.119.2024.10.24.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:52:49 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: fancer.lancer@gmail.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	andy@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	jdmason@kudzu.us,
	jiaxun.yang@flygoat.com,
	keguang.zhang@gmail.com,
	kory.maincent@bootlin.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org,
	nikita.shubin@maquefel.me,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paulburton@kernel.org,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com,
	shc_work@mail.ru,
	siyanteng@loongson.cn,
	tsbogend@alpha.franken.de,
	xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Date: Thu, 24 Oct 2024 21:52:46 +0300
Message-ID: <20241024185246.315631-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Serge,

On behalf of a long time Linux user and developer I thank you for your hard work and contributions to the kernel.

> For that reason I have no any (company) lawyer to talk to

I think you should contact the lawyers of Baikal Electronics JSC which are listed as your work place in your GitHub profile and which is under sanctions due to it being directly involved in the ongoing war. Specifically the production of your company makes its way into rockets and drones which I see explode out of my window every night. Given your history contributing Baikal patches in 2023 you do not seemed to have a problem with this fact I suppose.

It's quite apalling that this needs to be broken down to adult people.

Take care and consider rethinking your life choices.

Oleksiy


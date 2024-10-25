Return-Path: <dmaengine+bounces-3589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310699B094D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE7F1F2178A
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA2175D46;
	Fri, 25 Oct 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJUF3TFa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604D1531C1;
	Fri, 25 Oct 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872657; cv=none; b=jDGZjch4SwD/sXcPtXeTnBI10+OA4JW/Bq5+r7zobdsZGmua9qRx7O+jEytaVahad1jzR6+w9z4qasDn+C9muCDcMgSPMBPFmmHKLnPsTktgZDtoK59s5mICH3dyyb8vwjIwAeFXSh87x1t/IaGX1tnGb7DIdtGrijovr0JsyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872657; c=relaxed/simple;
	bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6Q2L/7tJlkPlD4W46vAFO05lXahDG8Fu0w2oOzLlMM19FIQ7SOeGllpEjCNpapn/iHuv2v6CajVckQCtBC5WdWh9CaLhFKaLaRvgn+0YiPEUDDjGDtoLvfeG30/qOFhrPyhweWf2OMLPxYxT06oVo/MckfH2KS2NS2EaNubU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJUF3TFa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2798604e87.1;
        Fri, 25 Oct 2024 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729872654; x=1730477454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
        b=JJUF3TFaim8pwHT0PWu49yUBR5nCinbM0lMKotWLMz3GYXfx5lRy1OmgAIl2Mnft6z
         rDWypOcy9V6CEZML+fkUIS4pqxFk5EHHp4XXg+JC+BO1T0gSSSbNb3sMzEclNwDMpNp7
         C5ZzEFNU64NKjjobQvzKiBEOt1Rvbqm0Dj+Qg/r8AQ7SGyXpJ7JwwqJcldqECbm8jQtz
         39YImWmFZQIpckOZwFQjO0shRxYl2v6IN7HlWddoSCbcqMmF/tDbq9/CTZIfYHg/e+uN
         6vC3kxvXFB+3csIplHfSCsZbI8Odd/kPq9dbtlNwIt/HWxeSSkAIfoe5D9kYJeXviXv+
         9LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872654; x=1730477454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
        b=gUbzyUiLr/oQjgO/oKEAD575tca993ODtwJSdyz0lNkjXa7AvWbar0YRbc2D/44j59
         kkCTmdr88zvP2ykoFhM67/RgTSoYLKDYsOdv72Mzht4D+h4tCI0bCh+95XUUhDcACsIi
         mSb3NRKYAbdXlsZHt5y++mbqCre9ybV33p4jRS79dYXm3Zxsc95OgNDRceDls0XR9K+9
         AtAz8LAZSJFOrE6dvtd1u3iQoe+JDFCLWfKJdqXdpebgTdIz0gmRfvlAOLuEZSrefI6r
         KmeUT+O1q4BvKGNqtvOj1pfiFwzus3YllUC6qjBBxfY6eVTpA7dD0p4XL7vZkZJL6OZ9
         ZRKA==
X-Forwarded-Encrypted: i=1; AJvYcCU81sCET00v3d6U5avomUa9A8K2xGMGbq/KlVkvMMa4yHF8rbwaUi+fVR9KaIy9WHeuwqgiNFDMdJ4beK50@vger.kernel.org, AJvYcCUYssiOq3d7d9j0nCKWjlLsYWUXnLyKj4WexEGR7AfTJYwZxTZtVDOcdO60JnA4crcqOPRXbqXDNkZD@vger.kernel.org, AJvYcCVAYR72SRDwkNCkqVA2qWw7g5EahUQYQkh5i7isxjNOuIYUbqAfaaU+/1HQtBzncbkzgHllG7/ipdjXqw==@vger.kernel.org, AJvYcCWEnNiio7h/uIvWPisKfHPljqdFxxWZldvQUrJF/SqcqzgIFWDYXpWax82m3mv9i5WptqwRGpbNTd4=@vger.kernel.org, AJvYcCWUSippOC8rxzwr0M27cfkMtpWMgQakFHo6aiK33d+ajhMtpJmXzeZI0d99CwRTYKbvUrHUkxYo+zz8@vger.kernel.org, AJvYcCWsXCyct4pX+xU56RhKmFzxgPyfl9HN3tmHZ3ST86X5zcscEbZfO/qwhmLCrs70WMkD/pmg0Iq6ib+QkQ==@vger.kernel.org, AJvYcCWwoICUi2AU63wFE8nyUpnY+WFlI6fuqTgj/MV9e3mD34irlB+7qwuRiHTU7SEDlRMY6U1t5WQjYFkTSzg=@vger.kernel.org, AJvYcCX9r6nweTXEHSaz7K4DgFiNPj/1Hq6k4MXcM8sOZQiqe5hWNZp36v0WvCgKg2fNP4Jz/rqic3jF@vger.kernel.org, AJvYcCXDrWZiMBgnJv2D8D1NC3zTtUgxTiayaQv4HV3GzG40gLsO/aaWzcGpYXQyJy3Ao9MMtbRxPWR0pyYShhll@vger.kernel.org, AJvYcCXIaBRR47sM5vs4h0UlS7hrr6mj4M8Q
 kK1TVAtpWo+XWP2am6lhiE+uKbnhCRcttrIeCkUbAxROaaCy@vger.kernel.org, AJvYcCXaS5KY1bK8M3S8Uyi9l9uwIajVVG6oQrUeIN4U9oJB0F24bALDGohvOd8vVdemwiP9uUJXFLWsNOFgzKeX+5mcGQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJb3tO1qlG+JEO1SWKa/Co5BfKO3PEk00UjU+jirJgMlJoMbR3
	rK+mq+HNKF9ZO9H1eohnoojE9yd+kMaK7fOL1IcppX8cGY1ZmL5h
X-Google-Smtp-Source: AGHT+IEmCTGCwN6K9pQ3iSetR+mNImL5rR1c3V5LVNYK3uoq3APkW+2SExfNUH0cNfIdopoaOZh13Q==
X-Received: by 2002:a05:6512:ad3:b0:539:f5b3:f87c with SMTP id 2adb3069b0e04-53b1a375bfemr6363948e87.46.1729872653315;
        Fri, 25 Oct 2024 09:10:53 -0700 (PDT)
Received: from localhost.localdomain ([193.106.59.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a7efsm228124e87.56.2024.10.25.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:10:52 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	d.milivojevic@gmail.com,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	elfy.ua@gmail.com,
	fancer.lancer@gmail.com,
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
Date: Fri, 25 Oct 2024 19:10:48 +0300
Message-ID: <20241025161048.330741-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
References: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> P.S. "Don't feed the trolls"

Don't you worry. Our friend here tried to reply to this message, he did so twice in fact with slightly different wording, but it was full of political rage and tu quoque so I assume he fell victim to the spam filter thanks to you special counter-baiting operation so to speak.

That aside, I did a very superficial search and it seems that the original author had already had a pull being rejected on the grounds it was coming straight from his Baikal credentials. It's a real pity that an apparently very able engineer is just playing pretend despite knowing full well why is it so that LF migh not want to be associated with Baikal in any way.


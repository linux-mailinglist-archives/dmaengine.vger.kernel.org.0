Return-Path: <dmaengine+bounces-3508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E79AF058
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263A81C21E5F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D126216A3B;
	Thu, 24 Oct 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjaa/K0O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82D20CCF9;
	Thu, 24 Oct 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796829; cv=none; b=AVPHt30KAQFTlj3dYvHWdvLea8CwST6aP1VWzKOQRisUfN0T8yF2js+sdWtPf4cYcSuwK/suMyjHe1vw6WEjW6krtxf4QH3s3By2k58Z1HosKdoHF6UUk/MCUmnLbiT4I6iEL/3srzZucBJ7CcuhyO7YcWyM17Lecyer3C2hVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796829; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbSNhiv6iXS6UgO/qJdiYhSQPkDOr/Z9SSVlHrePfOyq80PIak15nSV2VY2wimAeuc51XrYUFB3Xfjo9+VzhQEkrESv7/tGL21hboK450XuhKlGBX292nd+zua684UtKeXcaduYC1sJXCw2w7i9U9G7jS8qAp6CK7cI/d/2k7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjaa/K0O; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539f53973fdso1059959e87.1;
        Thu, 24 Oct 2024 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796825; x=1730401625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Mjaa/K0O1O25hRch1HckjCh/sZbfQ2SsNRg/gEZdyBQZMsdgQ/pacj/3h7cYcU9y5a
         G2cjmGiTHdyBocO4NY7MKwuKzGqKW7CKMR52nm2GuQ5vqxm+02+VjHhYHLvXTOPUb+x/
         jSpA6//D2eTCs2imlCLQCdl0KnRk+g5pS6Y2PRNPyxobXc9nI6bihxyncdEJIQUzFHKK
         Xpowb7Bv1ZsQEdtMAKn8LSZFM2Bj2hYx1SGHuKbMKThBGfrMqIUaitODO2hxtmrj/Kkj
         DiEG0tti7OO/fMGLvkF+fX5MgETKtwWfm3Gawe6SBF7tEC/JUp/KhbuBMj6cBnmkjrTG
         Sxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796825; x=1730401625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=BTHpgieECVz4xqqf00OzkQc9UJBUTpGbzjB+1/8H2AXZ00U6LLGPVWko6dP3IYHAYG
         XkMCjUzE/G2om8H1tqlp8cx0hT2FASE8nMXcSCSoacQHh1e7DXkT9st/XEIP5sUMcrFm
         8qcZWv9o2Wo3pCQlbWSxySAszO1ceWUlfmuCAadMAWHxvWBqJYY2lxuG/1i69IO6vjyA
         cczFULaD48nWtGQkiFlKw3LE/csfacalKdlglw93dBu781wGsasTLf8l83pwlTrpQhG8
         QG7z2lODSYaSZ0xPCD9XeWek+N5eZZAiPV/QqCUJ2lCLwN+BYCuxyQs2doFQ24x+wa23
         A4bw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ThBx/X/yVr+NTz4Ep9ikKx5PdLztusHuXQz19S4UFLf7atqz+NrGMLuUuoWqWNjf1T9woUAe@vger.kernel.org, AJvYcCUNZQ85SLjYKOBon6PuyoGFERKX4+EQnwFLklU/MrmsG7EbBl67qKHcz8MinR/SObptv/JBTFORARxOdw==@vger.kernel.org, AJvYcCVaBHrTDCb4E8r9KhR84/KMHG8FhGXHK5qYT76MQuWr+XHUtV5YUA/aohVNypvVKkOll6cMpymUA5vC@vger.kernel.org, AJvYcCW9wqehpDHIwYmqj89aBsJAHnPNjOqpSV4Nk3022XPL/4jQbOQak8hoU1n2KlBt3OlNE1jIqU4pntN0NQ==@vger.kernel.org, AJvYcCX/FoOC0nBO9oc2HGldfqKTaZ4ByWeGTHH+Sa2j4IuMH0YOP5kofxo1L4TgdYCQBjyGZQXXwZ7mxWA3fxw=@vger.kernel.org, AJvYcCX2v79d9K1ijhwUD8VLXBEbv9DEdOlvgt9ALnaekxr1xhMCBcjBvdJOuXjw7vPEAZuNNWZsIHGARKDGQ74=@vger.kernel.org, AJvYcCX58TwHYscXbpedeqjJJAC4w/mq9YTLriRykVzKOyMEG37/bM26RA50wQV2k8jJ9EmhSomTHufBy6/UOg==@vger.kernel.org, AJvYcCXOoJXuQ5XGum59tTYd67JgItXEs5N5neV21fQlNmNLwkPGrsMqa/5se+RkBzuZZh8CoozUEqj/GxEZ@vger.kernel.org, AJvYcCXXadDICOGzYHWiyQd8JIt6kag3+GEDq7BNJj/vKsAb10rgPLAxwY3sfuqL0ZhCGrAAN43DXxypyVgcOlVv8NLOKj0=@vger.kernel.org, AJvYcCXaGSQNtpDpegIk3VfQ
 JZBJjEpTFgO8bKL1Wcc4CnqZZYMCDtmNwJ8wHgO4cuIrFWLsPCGquzvOc5lJ@vger.kernel.org, AJvYcCXdOeojvl4u+BPWrSH1HTPT5psBK0Q/b86ksqMNhXYsymAQNSQIcUDxxqapuQY5XVqzjWVBjuJJynQ=@vger.kernel.org, AJvYcCXh/Wvl2m+dAVZLFol44XaFNTHJpQEw95ggCAjFzXLMMMxyPGNQBmnM4Qvh8FDeNLO4aUD5c+J/K+YowUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VsORKEXFigVxSPA7SsEPTsPZmJlRiMmO1u7vHkjI1vC5cbxi
	Zal6VFnYniC59BMbyya3FvJFqcgPUhCn2fWiUbv/c07kb0YCdEnF
X-Google-Smtp-Source: AGHT+IH5/lWQMtuO5pOB1UrSm9Fd5th+ark0CF90jp9Q4lFRRD+kn0uQqfM5B2q2xOqwjpbQCovMAA==
X-Received: by 2002:a05:6512:33cd:b0:53a:c15:96a5 with SMTP id 2adb3069b0e04-53b237529ebmr1033204e87.27.1729796825321;
        Thu, 24 Oct 2024 12:07:05 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22442675sm1438892e87.300.2024.10.24.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:05 -0700 (PDT)
From: Russian Troll Factory No281742296698911513916097227571403478972960872081416129133806325921427484102557115242113662430579342664221326259814970166525751 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:01 +0300
Message-ID: <20241024190701.14332-1-vladimirputin693389@gmail.com>
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





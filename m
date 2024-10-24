Return-Path: <dmaengine+bounces-3528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6C9AF15C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396A01C22782
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069D21C188;
	Thu, 24 Oct 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JENDbBMc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955E21C16D;
	Thu, 24 Oct 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796900; cv=none; b=PozWjgIi2vfsSRELqV6BU7uOK0f/HK60jE/IkhszvMZ2feYk67JLE0Gw/uoSLqJnBfXz703MwGYY4aMS+d8pe+eCENim4y57UTx6cA9d8XKGsZuwbwI2URrZMrqnt8sD5SUw62F94ojI3SpVkCjTsy7NIdnQkrS/5EFcWGjnfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796900; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdomRbNtUYK/yiHZVsmSYt+4bpAuC6VaInsIR1TGRZMu5gz9htxZzC7l+gd8+Wx00q23aN6I/kqK3wzxl10vwf6ortnWBCrWce2+QxqD+AtBFXA2a7FLJw3rj9ysmvL174P1nQoguvksoLX882hTMZDw1p6B2JA/Xwyj5u3WSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JENDbBMc; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so19848911fa.0;
        Thu, 24 Oct 2024 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796896; x=1730401696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=JENDbBMc/NEfNndFyez1XKbvx4xeXJtQo5kXztcxvjI8+CvXYXpuPQ4Xe+dpceByLz
         pp8J/wgJFeHiehuTpDHU+ZEktC+uxe7gx+EL3R+qiszqMUXJHerDGhz+o2QfA1rePKcP
         IkEaeN1R/pzLpR0bJ7x4XTsIT/RCw7yS+BpNkvyiBL/FHIiAU/Kn1dldLftRy7/WGaIH
         ziJ6Sq4ehywUbrOsWG4KvzeebYSj9PlUi0RwZqWVs5LPiIPEBS9BjIjD/71rWEpOw6FA
         C9Ps+FwHpgOZ8APeN489PfEfYLNq7VxIKpUQlQ68kLIOPqUu/FoUwrzQ4NeQ2vBKBV/z
         PaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796896; x=1730401696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=kkSdL90LOJixIhXk8XSTK5LhFCnnmvVjz/AhtGFoxsoQ9WSxCIKve0rFtR/0NaAIHz
         QsmVM8psAEH5RgoynPYuISYoGFjGA42y/ots/YFmqRAN6z0aOvH8j9l3iCuWfnVdQlUJ
         WkhtDQgCeW/vvcELFi5s1fzL69xm0DcMk1wNoYCpkzhgpQbpwcLPJDt7sTCi/xOlamuN
         i/2ElD1Nk8FO4yINno/MyLWW2exMaPSke/LWyE+tztw7a/ftdsKb/DiE0+33NQCWyTN0
         fXcBao+YH7bTmlXs9g98Zp/UoitlD10Xx8H5siAIcogQ8YJB3mi5jJultq2ZzkwCZ+Rn
         p7qw==
X-Forwarded-Encrypted: i=1; AJvYcCU75XPMKT1wc063xzSpQBMw3G0ka0wtjvs/cGZ3V8uGceErfhlCf2mvyIFkg63xaoEKipTA2N+iBQry@vger.kernel.org, AJvYcCUIMonuyMytcXtUUUomgD87r7/I84vQrnGFXmV+F1J8guPbc0K/mnj8NAdrdWKrCDRhtaZ5lAZOs2cBltk=@vger.kernel.org, AJvYcCULAd5QQ4kgZnnlNND+CEt1XXlq3hGzUPwagnqFodvy02DRbewA4OwDhbU5egBqbB2PgqhEFODR@vger.kernel.org, AJvYcCUQvlkcXjIvdA6ruapTWS/JEKzy3jQjp2FNHF5eRtzajg5jY5zjX7kD+BvnrDDKeoTTGcPjlURkZxFg@vger.kernel.org, AJvYcCUpEqtaHCdwEi9itNjsjUbCfU2VznuINrKyPOUvqT7FA2V6kZp5zmJZNtM/gUmB2X8kdozgX+g963lRcoODzpbxRZc=@vger.kernel.org, AJvYcCVR2Sj3ua0DG300Yk0RQH7HmCgC+ODdi7GdCFUNp3YfiDCXi9t/m7CEaMNN51YhnDXSDPdiiBkbOaM5Nw==@vger.kernel.org, AJvYcCW746myOo0WYyos1ZiQD/QqjyRm6TxsmZbBjjIeZPclr6icpjlFDm+cC3z999k8WbNTwHhBK9s8xaNocw==@vger.kernel.org, AJvYcCWCLuVydkQPwN3hI3Gitb7393/zClgYopqlppGwAtrvPR0vUHqWS3U4Wkci8z1zLezlR3Sb5dX/3+1V@vger.kernel.org, AJvYcCWHET3iG0w2xfJMKcnNbjoTRpcF+m+NcvdQwOJFf29IxA6+cqc8RjcIA3J2gM8dIM+X9aLlB3NteWY=@vger.kernel.org, AJvYcCWhKIP1sVL5y2YZ7hhnkZXhRigm
 E1EHUoAf2O/OFxfc34ViyQXfRtp3tD5aSFd7PJXNLO99omtPFWasw/k=@vger.kernel.org, AJvYcCWsvuC1Bj02ExtSodx8wGw4gISnHjsjiK0e9wC4R9aaZUSKetxuUA9ZQ28B6UuRLmfQ6h8fNogE++FgdKY=@vger.kernel.org, AJvYcCXk5NVty6PPY6rGZ4ThTgFYsv+VA9B2e2SzmzwqUqPAXxppqVuzQ6+SqyhL4CbtjfUYhCpmpBmF0d/QDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLNLddJjwUkkjq5wdY/gghgjLW9Aww25xLgWOEM8CJd4RMey0
	y8FS9SePgPAeKemLKoW7Ik5b6Ana7PHkYTiQR2SXj+ujLDmP3ODk
X-Google-Smtp-Source: AGHT+IHZ4mZANVCLlLlCkeso+D62SLs9JJJPTEJAxC7y7llB/MjOtpAC/Bvd9WI4S3pGVoQ5GZzLJQ==
X-Received: by 2002:a05:651c:2222:b0:2f7:5a41:b0b with SMTP id 38308e7fff4ca-2fc9d34a353mr53905951fa.26.1729796895582;
        Thu, 24 Oct 2024 12:08:15 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b75bsm14747971fa.23.2024.10.24.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:15 -0700 (PDT)
From: Russian Troll Factory No23842130191005615298197021176028071661393765023998612818175484311252912213179134437986189991480920612188433236525528315786385 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:11 +0300
Message-ID: <20241024190811.14552-1-vladimirputin693389@gmail.com>
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





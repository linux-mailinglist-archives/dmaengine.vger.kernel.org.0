Return-Path: <dmaengine+bounces-3470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3D9AE3F1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642B2B22AD9
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DE1D1729;
	Thu, 24 Oct 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLWGWnyF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635991C726D;
	Thu, 24 Oct 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769580; cv=none; b=q3eesvRmosBtWG1vsB89aYMoF6ZgRCSESdyim232jqRqQgu2s1J13i5+a8n4vpd0RQ46pGmlHTOeCed/ln/htIMuozztcuD/KtWGdboTbgfcaciG2vW0sm22yHzbDzRftwUqUvfsB+SR8KO8GVWlS1FwQG2DCzDdPlILxR61zLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769580; c=relaxed/simple;
	bh=jaOLrmAOgefAgbtZ2Lh4kHXHkgV6DCOo2suKobuzSjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOAZy1f2QbkM9oJ2XyuQdZDNdbSftTH8DfC/kS2B3DdNXgCSjjRT5MRDZtuyc9TlXglYsmmrQKr3wDtL/XfbqjpYVNwLPWn/fHwWoJt2x8ASvyVbgdgNgqyLhbSOzC3ttp45Hx5hooE+bPFV4RQVY5YF8pUyUG1kuxjXh98xfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLWGWnyF; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cdda5cfb6so6426175ad.3;
        Thu, 24 Oct 2024 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729769577; x=1730374377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tv6O+TghCU2f9mC++4kG9WDH4zCondacLVwevpdizzo=;
        b=iLWGWnyFsPBsVi4R06t+mGR0ow0oKN/SOxv2hG/GR60jbOw2l7QqWbo1DVv0IPTro3
         uWIuXEoAb6pF0hjXnnSN5uNBnbefoJXWBPSqryvo9R9pET87W1KaFVBo32JJtyCeFzsC
         BbU6pNekE+9pkt1Su+64d9gRcFpiTfMsgX4gYP8JQNNnoEP+Y0ogwYuoXZfgEfbmy2i/
         IiZSY4rpSDRBWzon/sN18VltdgduKKtl0rQS4WNerN/ATJ5yMgz3HBIEMdAMyQI35wJX
         FzZy84AP4JPS9TCKcHVNZPjtm1j9RqRqQWtMlQSvaYzcr1/DrDstj5sYFd6iQJ3Uq0wM
         ynGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729769577; x=1730374377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tv6O+TghCU2f9mC++4kG9WDH4zCondacLVwevpdizzo=;
        b=u/MLFD1pL6qMiLP4NMDPvnJs6oCBllZPrjXNJ5DYS8RXFyxWnYX62K3UFuXXIWmcau
         SFme8FqqnbKAdppTWkKYdOo9qMOHMiYsq5W1dyQT/pdAiiTIB1W8GG13T1AgqTTydT1L
         eX3CgjmvpBVqz/wxPqQ7ZJKYlFcHzGWfVuCM/0N9pG7NIjA8OHnrBgUgl98hvgH1D2uR
         1HqDulEbAWefNT1MiiU/jjM3dr7Unhhhve4h++oXuZJt/AZ15DKE+OkNu6yUQPmTArGg
         EBTNKg9j7Y8ONTC0Qqlcnn5yozAqcQQsuVqwPWemBl/2nIzz758M+AHFHJ3FePduUKDc
         08RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkWgc5gm4UiyzmY4/PLKLX8cQtKekK8FiEuvS6v+G7hINamxv7J5dM4g3BX3vczjqn6NqI7/XyFjK7JA==@vger.kernel.org, AJvYcCV+PKaWBqgSyVdy4vtZjwhCcjPbuzoiMdShSgZ+hdfKb1kx1WE4ckHsBRknAxACFs6fjNOyqp/LTBar@vger.kernel.org, AJvYcCVLwkSW60YTS0QyZvhvMYu8G4iN2tocv7D0rxiTAB5H/An6h4YdeCb1p95XHBCYAQFKd4V9DbJFkXtmsLs=@vger.kernel.org, AJvYcCVYJx3KuHEGTxXinf0Vf0Wrw5cf5jkUHFydigs/IRdiXWHwLWdw+R4oslcedUxYXOV5ZT6AP9ib@vger.kernel.org, AJvYcCVabQ1V5qOpTs9atHFd1E3ba/LlyPNiteGBNrSXJW7DMFO1e6CRaXHUM2gaTSwmv+T3l7l9nhchygkg@vger.kernel.org, AJvYcCVkFhSCc4LDtt+mF79R8IFdR7kNolg1rRKR2Z4kDjVE8u9ZucgoMl/wDJzwlRpcL6HvZXOsuYGsa80pVPg=@vger.kernel.org, AJvYcCVtU3mCAPPl07cj2YNeliKqIcxz69bDYob/OplIPn/aKail7mD9vfC0zrn5j8MTnQ+t6G0tsyMti7kc@vger.kernel.org, AJvYcCWakYHTt4t+K9TOql8I7dG1N3cF4D8c70kr+liWzVdhjxBhzky6LJpaJ010TBnUotbum/3MJf8fweVG2GgjGDCn36s=@vger.kernel.org, AJvYcCX55RlZou2yniR2m/aLR23gSxf+nkfLH4hC1KKDz+JNu0OPsox/CdtotQSop0b1En3Vbf9WOcfH28Xbxw==@vger.kernel.org, AJvYcCXHN+oh8GVE1UN53MYJouFz
 FL4/j/VNA3ONir7/pgSZK9TnKhd3SohMF818pwdz7mpWdfZz7vnXFcY=@vger.kernel.org, AJvYcCXOX+6Moi7o0LjdeOPO+b8e7OfuURi/6ng8uyu/ZqTuBusyaOa1YVeXXrRpxQDXHpDw8poVAUjSwH/XVnc=@vger.kernel.org, AJvYcCXdrhdwIzegOpRuKQGEt69P2TkPZQ9O5qDMT3OR8Q0NeHQ2p1+100KxKaj1aSffe381DzOsdOcosn5gSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPP/E7DuDUsdNswickcY60EGl2fjxcPzoMmqJWKp51ZT5qYOt
	sG/US391zNvbl0UfGkBKLysnq8/NkJPegJnwQO4anTNZp8yTj3u2
X-Google-Smtp-Source: AGHT+IGnX8BAozTq7iV5Cfb4iMWgUhRXOngKBX3V0+lNlRioh+e/fyzPpLUXG8x8OAUIikKgPta+wg==
X-Received: by 2002:a17:902:e80c:b0:20c:e5b5:608a with SMTP id d9443c01a7336-20fa9de92a8mr80789405ad.5.1729769576555;
        Thu, 24 Oct 2024 04:32:56 -0700 (PDT)
Received: from codespaces-a350b5.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net ([23.97.62.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f364bsm70916385ad.264.2024.10.24.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:32:56 -0700 (PDT)
From: Jensen Huang <jensenhuangnvdia@gmail.com>
X-Google-Original-From: Jensen Huang <JensenHuangNVDIA@gmail.com>
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
	xeb@mail.ru,
	Jensen Huang <JensenHuangNVDIA@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements.
Date: Thu, 24 Oct 2024 11:32:46 +0000
Message-ID: <20241024113246.22901-1-JensenHuangNVDIA@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove some entries due to various compliance requirements. They can come
back in the future if sufficient documentation is provided.

Signed-off-by: Jensen Huang <JensenHuangNVDIA@gmail.com>

---

Follow 6e90b67

---

Linus Torvalds said

"I'm Finnish. Did you think I'd be supporting Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too."

So we should remove Israeli developers too, because Israel is committing aggression and genocide.

Link: https://lore.kernel.org/all/CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com/
---
 MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7..9ce642d40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,13 +2275,6 @@ S:	Maintained
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git clkdev
 F:	drivers/clk/clkdev.c
 
-ARM/CONEXANT DIGICOLOR MACHINE SUPPORT
-M:	Baruch Siach <baruch@tkos.co.il>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/boot/dts/cnxt/
-N:	digicolor
-
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
-- 
2.46.2



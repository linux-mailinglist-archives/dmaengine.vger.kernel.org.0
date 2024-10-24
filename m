Return-Path: <dmaengine+bounces-3544-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B879AF234
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB11C1C2469A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C53DABE1;
	Thu, 24 Oct 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4cpxVCL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC62170B1;
	Thu, 24 Oct 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796978; cv=none; b=JbxZApKomsSH7FkhDIB8Y46BgO9rnDHdDSetBQK9BU+z8za36B7y7zI+ZaE7g/tWvddW4vXl83szbophAwRxDI69RGmaepjegmFbkRaAvmAoW0GxFs9qoa5X9rR1Y9uz+NhWja4p0Srhjwbb8IASIZM0tfo4yJhrE8Dil2Crla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796978; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moBPc/9wcnTKL5aFLe6EtkGbXXhnfgNhKcxGh+riknh1tpEwsNqHaAyBpgQ9flD2HH55zlF4aTv4XImhvhR/wE7CRV73xzip+SLKHNw3oMVCp1rj4tIPcG2Qbt9dpN7nvCTrTPFDws6W1SJNJ1cc+I9qHbVN6GwAVJi7la/xGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4cpxVCL; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539e3f35268so1623794e87.3;
        Thu, 24 Oct 2024 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796973; x=1730401773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=a4cpxVCLWoPViSeFc5asrgOm5WUEfpDSmaNwMtexWKcIaDHpVqA835YTdOm4iSbh/y
         ZBj7qUt77YqAJLa7u5X+3si0gpdKjwHvzVvis9AWXZU4lLKROP5BlX2piGsnyGSwcd6/
         KD+R/5NGVSOnirTRjOESsqPAGsdBcq7LHa/5LRjGjoMksZzh6AV0l/1Ji34F162PZ7u3
         RPbmfbbRFYrZSoStXRtGGfw+oQhSpYFJvwUI0fQ1KH9JLs2fVI2Ej8wlWezAPGZ0+pro
         R6E0wn54bZXwao+lxF0roXwP9R33p20DRetPJjClR3V1QofEcVkWctScuZmE5/VVxev5
         aFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796973; x=1730401773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=pSw8twMgH8G4RHQWbAKVAnBnfGO5vQNAKRPCQ3MqJ/8CSCfvAtg3S9Sndla6ibkrRd
         Kh8YoN7WdV2fGsZlKTsyi4p3fMif47N/vF3uI0sIb/gePBew9epbxf1aG2JIhDaOR5uX
         qUW4Ivk0UP2YrFAOf5JN8pDAg5FJjTcGOVcFnuEt0/0Auyso+8WB8KCa33VZ+TEcMl0J
         sPHod+DFgzQQcfoUAgSrv0XKZVp8sRNbTdHNDkMPr2DXsyi5h6s6cyIyYq/bZzHLEohI
         Q74QKVt6H03IAbvu2vuPAryzPa5IZ/YYQSTBoCKA9iXtNXTnUCz6xTH7ungVRHN5Zmsi
         CKdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8EGVfNhRemZlkvwizS2geUMBB9Iy6zW2EFheOfBEoPl+T0jYjpjm6A7iwnXXFQcdeSY9QqGphEeT/rA==@vger.kernel.org, AJvYcCUpCqqloBWzm17wvVKyYJ8KDuD7iru/7GoQv8XpmQYDnbSwON0rlhJGksYCLvWFFJGjDd3luNHLAZadjbg=@vger.kernel.org, AJvYcCUro8brlLVaFrXYSNkcGiHOMNOEQ4fidys6FIrsuuB52cQJHT+8QRvY8mc651Zx8bl1h9nowux+@vger.kernel.org, AJvYcCVl8Zl/jm69v3cnD/XoBP57EbDBQ0ZlSI1TSCBxuvIfGAhCQK7Bte3k3tqnFLEIhPuNsqpk9iqf4bNsVw==@vger.kernel.org, AJvYcCVrEFEkG0BkBb78/ksLkmDwcxhVXEOL5OvUUFt3iarTrt0cqNSaozZg1qPskrCR1TTaoEFXJz6smSMFl18=@vger.kernel.org, AJvYcCWA+ZC+2efYL88TAEBCkEo1K0683p6ANIhAwus8EXyWUGOdiOVb2E41ti/z2ibuk7KCT44SWIDmOuM=@vger.kernel.org, AJvYcCWwZ2JoeOq1LV6ANusVlHNyjQ1djDqYzRw+TIkASxwbnU2cotYopP4hM2wrhr2nPG5ZvmewHF/Yuq962Q==@vger.kernel.org, AJvYcCX6Yq+61iyXgk0x9infOx/AYeaMI7ps4IFeaTbN1G7msv0+kwGzN7vJt52kvsuTyyRRXGrFBx4tTW3P@vger.kernel.org, AJvYcCXIgGfpf9jhUncXmZ6+0UiuUvi4S50twrXXeSUUXd5ltPuWfDlZaw5PyhpCBrO7Aahe11NqcDpBnFVEAoOZP2fLfgM=@vger.kernel.org, AJvYcCXK+j8ixD2QQYmfctm/
 EgpxtTPgHw4DMjSvNyKQPehgHUh+nKJBR+Gonb/OuT0JshGvXX6Sm+2NVeuB@vger.kernel.org, AJvYcCXe/nfRBxKBRLMm34QvELYzaAkNnIXTyl8PDyIP9WY1vvJCkiOOFA0hcoI0gHsYPuzq5CEGDVKKr6oO@vger.kernel.org, AJvYcCXyr94lFlVSVRYCZwBmnOZgNQudKy3HrpFowE/NrZtGv+rNbbIeWqyXloag+sxl2QA+JGmEr4m3KKYAo5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx412DzDxHkaaUS2B4NIr2//llS7rxjeJBPVn+YISDNsAeEgHm9
	i3vmxDG4fmFs6p4Q4kpO37GqnhXq69bOtC2keRV+rp29zCp5SZq4
X-Google-Smtp-Source: AGHT+IGZ895jKqwRbzaGicljzk6LotZ3aPjvA0kkJGYZAmQ4aiD1QiASYKAVqSVUEGs5wxQUcbywuw==
X-Received: by 2002:a05:6512:10c9:b0:539:964c:16d9 with SMTP id 2adb3069b0e04-53b1a381324mr4167714e87.57.1729796973097;
        Thu, 24 Oct 2024 12:09:33 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224203d0sm1456035e87.150.2024.10.24.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:09:32 -0700 (PDT)
From: Russian Troll Factory No2708244593518649817073458115213400141616877250811766822346192812686202883217843230833232112404007111781932511204195783256 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:09:28 +0300
Message-ID: <20241024190928.14794-1-vladimirputin693389@gmail.com>
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





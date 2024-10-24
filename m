Return-Path: <dmaengine+bounces-3530-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732809AF177
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274C0285F0B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D121D198;
	Thu, 24 Oct 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2O/Ep/3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D17218338;
	Thu, 24 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796910; cv=none; b=jiIWNcCbBIm58VdvmtbnqdOkhMeQnn54aBCpLvSl/3qjZzvIcnafEgXp5IWxl7GtuWM2Ubfok3pHUiuN/y0WyI0jefuG8HVD/aQ4RS0Mt2nFE9FIgAHoprmIGfmoPuu7BMl7vjFkVPQbJ5GJJQnNjcMc0/ywJ/d1ypBQKkO6K8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796910; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clNKKRu23KjwokXKdVJJRiqVUDLoQrMB3MLK3iv/NwV8mZcyUdg4/HbhTDngZTOmuleeQW2JRscWtdjh4iiN86JFpXI3lMTnOIyJfM15toJJJVfGsIWmQlnQKlLVNQVpfKa0oqYPXChm/36TYplopG/PTe2Ee2ukwhfABc6160A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2O/Ep/3; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1486056e87.0;
        Thu, 24 Oct 2024 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796906; x=1730401706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=F2O/Ep/3SyENmF80iSzny9TKFhfhOMgbM4Z7DgL9AVjtf4K+37Rjh8CjNkJsSa2odr
         HdmNBsOKDRLC7+hWvOTas1ZakdjLXVZ6p6XEIFn/aDhdFDaCRnOzL61vc6G0sf77WqQr
         74J45qmFGA+dLC456CSYjObpwdLLOytY0yRwwLfmL9bOvg6F/yyJQlUVaXiZTVezw2RX
         EsyJtwbvV0Ce/7VEYuW2CCnOvgmWBbO4roKrZLCGXpYmBGv5h2rUyhSTYYmZBTIYMMwp
         WnkkQ33lDp16AUK+bp9yayvtHZfVhsCDDZWZYKnIeqGMnXrWTWMs2nav8F/G0Wq5fvzi
         mS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796906; x=1730401706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=fDk7TG7tUVlMcq1rPLWFjiiQsV+Trj2252CWV9+jexsbwOcbcWegZaWqEq9HkbZikJ
         htDTbDfXHPdH8810cnoltHUvY4vkYKnH0aAbnPNSsekjOUQAu3HnjvNehUuInhiNR5YZ
         ZgnkLX+qiojKIONjOOm6BS4EWZbgj1Xv4byVZHt8gWN/NMorSR4X/voxL8YbadkkgNX0
         O7TRq9B8VBBBh+shpZo781jMr5/hrqmVM0HhgkpUC0NVTXTLCaRLxMqbhWA8tgF3zylI
         Z2O/Jhokf0rGxMCBXQFepO8Eotb1DO24nr/31WpHcHEPkPSeK1a4CYRDS1GGhzqQZyh8
         aaxw==
X-Forwarded-Encrypted: i=1; AJvYcCVA08evSGjnI5CoS4BHxhA5fw86lqIf6IHynonDVIMtOrmUMDw8G+LDnnD+57anBAkbUR3/fdAPM3qGnw==@vger.kernel.org, AJvYcCVeluql+ggxjwZWTa0AvcAZ/uB0SlxvgYXMX0XVCYtGcLGowRB87qdFJTY6x7s16TNhgS+JMJth1dWz@vger.kernel.org, AJvYcCW120RkTXfQqhlXVG03pKLSG8iMz4ryT9MX9OC7+kSKckJ8RRHZ2DcB7OrJJ/7IVpQDWOJv0ZXBbFI=@vger.kernel.org, AJvYcCW62Io/dOO46dya+kFmeKvJprR8KlwMWMpGEXLTCqnISoKJ6I9g9ge0jC+6PmitIO+hBdPGGS1PJZuNNw==@vger.kernel.org, AJvYcCW8eVeI0/MGwO2uryjzGMp5YvUOEW8rfx1z4PIIDg2KU7fq5kpD3vqM6cXua5kEKffRzmeVAWwl@vger.kernel.org, AJvYcCWPxCFHhJRFWUKXXoqNlQGxkpnFDIs0Bk+xhL+LopAm0UmVqcmUO/z4w1vUvnamfj5CDncoZzy9sf9y@vger.kernel.org, AJvYcCWXORGjhoRLiStT+2O5E3eF6MOFZ9QLmCW2q3MPLBYMwRYRoQaPNtKV3ufDqOuEu4Nc5dVAEZOWuVXfOg==@vger.kernel.org, AJvYcCWiUSG6lo2BBvm8bir5SIB98ZFNF0CitAGrOUwslJ9OrlVjBrLTEjk+cHuy1YRVn66gFMsF/IMsMhCgyWE=@vger.kernel.org, AJvYcCXBa6J5LqFbpf2vr2qOLFlC9NqKhHrhdV8JiltmePW4ZBrs8lDyVS5HvLp2hYLv/EwZ/jlXY3nlpgvA@vger.kernel.org, AJvYcCXEIDqysroB522LkeFNo8ePKl0UU/iyjm7v
 fma0w3QluImo/mKY0akhr/gDXfIePI74EXL/E5eGrvtaWKM=@vger.kernel.org, AJvYcCXh/8uRgzNWvLI8iQ/3BrNI7vVd+ZNFxGsz9sQosasZDAw9Ti6mIYhZhd0KgAZYZn74lO8lFKySZfUibkOQmgCLSb0=@vger.kernel.org, AJvYcCXtlKDtkPmI+zvRHl3z+iqndw4TtXjHIVu7uwV4h1mQmy4zra5kiFKJLM7ROEv8NNfcMU67fpN7aWtA5I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkBYByVOQj+/OWxG8+T0TuKQBtDWwI/5/IYbTY0XMM0n0mctn
	+koYCmWp82MBrYe5XxlaLQRe1W7TZ/73U5RcYmQfSOUqEp0YfMI1
X-Google-Smtp-Source: AGHT+IEZzJLR145GJzMZ//8YaakKVG0RxlbFHBMcO0RFu2VGfGcm2ycXlRRkl6N+GaZaMh5BTOkrxg==
X-Received: by 2002:a05:6512:280b:b0:536:52ed:a23f with SMTP id 2adb3069b0e04-53b1a22dca7mr4041490e87.0.1729796906237;
        Thu, 24 Oct 2024 12:08:26 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f0038sm1440615e87.87.2024.10.24.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:24 -0700 (PDT)
From: Russian Troll Factory No74255552498227832615065052010472479835158450552548358488651726023873146347163208232916321944189786270563719972248210083 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:20 +0300
Message-ID: <20241024190820.14585-1-vladimirputin693389@gmail.com>
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





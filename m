Return-Path: <dmaengine+bounces-3536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE189AF1CB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4FE1C23302
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B1227389;
	Thu, 24 Oct 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvAukHir"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F66218D6A;
	Thu, 24 Oct 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796938; cv=none; b=Nx9KGD4QsIVQvob7avURo7fCWSe9SFNLtlRiZV4jj9t8PHHGcVatlsCnOMRsARMqMX+ejtzLpQmlZjpSXBFGojH4xp2nRqZ81r/ZLfsauSUbSlkBDkzw04PImkBJ+rnBBAaGMsYxhZOXHt6ThRpXtJnCtNvc7N9zT7HAMpxXm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796938; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7frdsD54vw3Bz7CSVFkCk6opjnuNpCb06WBXUKEdtFLWK+vKRLIzXEfHL6gBEahVY3YKdF8L4XphFaVx4qCHKzekcfBxrhgUbWbsP7k8pdQ8R4DVw0Z1upak4P5ggVz9Cn+YQmzSFp5NL8Oxp3O2tfmdg+/fOu3cQfaXZmRK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvAukHir; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1675535e87.2;
        Thu, 24 Oct 2024 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796934; x=1730401734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=VvAukHirMDsAzp3aC4RCW3gHMfc+pFHTN29yCK05d7F4vlp1P/XXu6iln9xu6Cm8EI
         gx/iMNK/vV4qd1ir48siHvy5ZBlINxPv0htPbxVWXUN6FeyD1ExNdTv/5hWhhnCwcvVd
         I+WoPIassLSJser1sfMw5AQsvV4ze75e3crpvhcQtmPqIMQWQkDyj9IbyAqThONjqa20
         f5qCtX1X7CrJG0Wcmc7jhTB7Ghq6hd9S8UGmUSbGMuIfdlQwMYaKav//dHqHzk8FMAzJ
         A0XZEYPfT7R92hooVGybBqCysW2fLA56/ZRzxVc4x4W+9V5NY75XNswSzbOo/lwFXkNZ
         DItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796934; x=1730401734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=lrskXmekT73m0p7q9JNtXuZbiN+eoer4LBqLjpTSSjEzC23VIXRUqwL+0pLQ26/sY2
         igLFD6WpVzJVte47UR7qIvX1IMAUPZK1MKcmJZjCpbsJvbWSQOccTH0P7GZXAVh6p+Ik
         pfnWftw/cmNkVz7F/7+483l4LtI20wicSL1AwMEha42qxs6GI7+6Q+xnaFLYmiuhFG9+
         vrdZXbXdjwmxXwzPHALBAAXs1kIaqsxbznd4EI8t+0/RwPgrA0LYspk/6ul8SQ6FwfRI
         4Y9J+JTn8ArL9IPm+LTGWpujlqTG5mN2JAobSCkCKrHJEeD9UWaMgV1YLBUIYRfzU3VM
         SExA==
X-Forwarded-Encrypted: i=1; AJvYcCU8iWsc/sK+P0UtHi9QrhBeYUHyz/j7bokwakJK0dEo4RmyDvFcSQxmQ+F1feeSHB3743/806T1@vger.kernel.org, AJvYcCUFG2ZfM0pPahl8lzX/lgayAGYDYW2sgDfgd6cZ99nS/Cd0oTPaHxVu1Fy39xAVnbjefbYOzKrc7SI6@vger.kernel.org, AJvYcCUs4/R0d/IirNFQBZsj6nfj4RwL/ISDxxq4DDaZmptQbJ2/kvWctYB90vqxUn2/mOoBDA/yXvHNvvcMpyHKu/NX6b4=@vger.kernel.org, AJvYcCUwZoVyuVnxFfz+laKrwZkNoCwry1wj6zGGx1PkVi2Tt8xwlEgVASlAXdcf8rsg+Uww8YoLekwbpMWu@vger.kernel.org, AJvYcCVnPxKPe+c+VbebpB2QZO8B5Eiv/XBNho02GyT1H+iMIqoAWOoypFyGWu2liTKV6LBjoCnzPnLNRyKYfw==@vger.kernel.org, AJvYcCW9mQtKTznRYtrZociAfrLrgAKnnrrE6fER2ErtXYLyfiNpPEk7ri8NSrso0fCxLdPKdY6azJCD79o=@vger.kernel.org, AJvYcCWQnzoLXVZY1SFtprBlZC0Sc58y2pBzYu5NLOzuh2froty9Yl/AZfahga+FHB/PNGfFOQM0DquWrLr9@vger.kernel.org, AJvYcCXE/RhJN1piR/+IdGbi6BK3F9dqgJTm+xC6rQY0UmC3KMgeD59SPzwHOOns9JiLMMRSqICTJKtMYf2ufQ==@vger.kernel.org, AJvYcCXZvNBEevhZHOQivj9HfabukbZdmqllVWdfhhQ+0aZ3mTB0R886M4AcW+TSgIBu9unNlfo+lOd/zk8C8bs=@vger.kernel.org, AJvYcCXbmyw/7AOiQXPPIABgGHHWWGik
 diyKTAqx3LZuqMdR6Sq7Pu32GkFkbcj6Kj+z9fXS6/6JqQdVZB3nQnY=@vger.kernel.org, AJvYcCXfLdK25vZnYRkrFz3prGqOssc3dPaGJjFXB/LPqJbotvGpHQMuHtsqj6Um624sMf0rxCESFHK6GoRfZg==@vger.kernel.org, AJvYcCXiP1sHQ29iyNJgZHY1sv0oyVinEjyDOspdd9u+ZvVMI/uxrOrNkPJ1rjiz1H9sO1Gu5UdJAqoh3J590W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIn7J87lhkhzRYZTIKe8TG3SwBxHD0ux4U5byhW5nHvDHDCej
	ddCFpxzo7p+KjYBSEZLq5keIXpxA95+Lm49I5tuCpZCokL7swa3n
X-Google-Smtp-Source: AGHT+IG7Wg+Hj9XzYeteYNXGUivEaYyyZ2vLKRLa9Gb6eLe8lHZI5A6woAaI51jN7g0AWdRxwo+OLQ==
X-Received: by 2002:a05:6512:250e:b0:539:f705:dbb3 with SMTP id 2adb3069b0e04-53b23dfa26fmr2178944e87.23.1729796933597;
        Thu, 24 Oct 2024 12:08:53 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f0067sm1453521e87.81.2024.10.24.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:51 -0700 (PDT)
From: Russian Troll Factory No1453814022200981107625138523228501451930834124675582212844455857829216311903157331000974131513604256422023857593247344819185 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:47 +0300
Message-ID: <20241024190847.14684-1-vladimirputin693389@gmail.com>
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





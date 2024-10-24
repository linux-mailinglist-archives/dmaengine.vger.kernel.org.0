Return-Path: <dmaengine+bounces-3518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0FE9AF0DF
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB811C2251C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294A2194A0;
	Thu, 24 Oct 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw1Sl8qs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BF219493;
	Thu, 24 Oct 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796860; cv=none; b=a39NCO+WFTCk8FEvlltFz3mGSMOlHDzqHz8pVEDl8tdAiB49XW4d3W2hiBM/US3WuLwSK7lGiEs0lRq+HSjWPOEmmib6NDzicSsZWD9H89rmApPorWd9Ps6TI9+ITxvktrhGEQtzQAHn2QdTpJdubYF1Mqg1rla25vhpeVpkWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796860; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXXCkFe7RVHqZetHdJxhvUs9WP9j6G+JBzwBmBZRJzLaZcxO6pbS8BmscldpvbTaDoBWrIsGB3028gaKK4rK+O97fhGcLtpkXRDDHrI3vh0vvadaoAiWH5a0TCHFXK4/EA+AYpcXSAidrL8IohXz8rnLaKZS74zthx8QcyzKM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw1Sl8qs; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb518014b9so10857561fa.3;
        Thu, 24 Oct 2024 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796856; x=1730401656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=jw1Sl8qsnr89cqXNCeURzVXCiXjLptJZdkzPHxfsKVnzj+zKdjkkQQLtPI0OAPsTKW
         ezcIyteuTCLqllaTKdo2AYJs2UF0M2e3oaIIOrGqr5oFICCffqpAyRXmZtHu8gqZqmN4
         jWvlcpsHAXLQbC0W38gkAjTDjxNB6JVrFcdHpQP65FaVHtMi7HcgaKk60QNDxlQKZgtc
         /L8pf0WTttyiT8yLnNSFsTwDeXLSsB83QapfeKd54ddsEj9gCbqzwiC7b5hIk9kV+tYk
         5Ya6ICHAXQlDeXusr26u6YqlfRZn81ycpFZvR3KvXlsOtr61OmwyquUKd5V/Y/o/hDwh
         URBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796856; x=1730401656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=Cd5IrV1BrqKPWVKIObx35g81/UwMuTjuTSc+QE1iNG5FLQN1k6BMMWJE7lMcBs/M7G
         cnLDdG3M+R/0t5nlyv68Uc9iJUtwvPvQh8UPDMjYwk8v9LcvtZs9EgyOa0DKr0/41lGn
         D3FXrJyv4zm7Vh6NTIbyWsPZQXeS/LVTjtqv9ZhMtzF/ZTXnayQsi9bqJ/jjGkmjd9or
         QRVUHI0URmwC8V5L3M2MNlvj+lj2mubAYJmmjzWJEvD8pQPKGXVs9ds1gCRHCfayCVxE
         xhzSvoQ7tC/lLYheerN8UnjiTZPLANyv0ljqZ6WFtfm1JmIIC3A/PmBxDLIxjH29MX27
         FyUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9pwZ1swVuvssBwD1QzTlCa3okJNylMSxhdetu0bTkozKhQK3ziTIBqubm3va8N4jWx2d9UPRoQTYyiQ==@vger.kernel.org, AJvYcCUIMZzNY08wjLyVDxHPX0o9nBRjrfXsdlnyg+0kdSFVuUITnhj5N4IyectW7jR+Co1AC9gbpBx7vMU=@vger.kernel.org, AJvYcCUNV0yO0ytLGBdppkcq/K9j2aoUomvYrYCWtRpUk2WObfFmkYzLv/QNo82WdsMprGDtfSHpD8i0cDVb@vger.kernel.org, AJvYcCUwJyj7NeYqPP983gsgxH1OaHGFwHUv9ugK9Xj2RhDtOw0UqC+PbLwuv7ubeCv54dRfoVS6KzkXsF3SU7k=@vger.kernel.org, AJvYcCVGUwwnk0E1TCX1mgIfFGCAywOEyMYmPwXN+p9hkO4zEDk1sjqP08qLReorot4/GNDlB4kT4Pvb+CCcfQ==@vger.kernel.org, AJvYcCW2/LY3EkSX4DTZr43hhFQyCWwJ1nG90vHXRsZ40dZGqTF3km4eMH65p7gUoCqcyHeqnnSxpaT3BR9nz6E=@vger.kernel.org, AJvYcCW9hFi5jebUfI2FiK37rwPwEXaf0HwENipHlxknIJZP4C+OwbCp9JPECI8UMyf1l+e6gWSFAiBZOWhkc3M=@vger.kernel.org, AJvYcCWw+rw4MtkORXYuezaM5vpszk/pH2hronTGzFBCFfEPL0MHkeNJsHywC6RU3Ndx7iEPBGtH3BD+m8SUpvRZ6eqEhQ8=@vger.kernel.org, AJvYcCX2WSlIJ6zoEWyZcjxm9mEJUVDia7155SQKSk/qMNsXBsixFQ8FNmITt6gC1qR0ko/+dBM/WfKoyg6kJg==@vger.kernel.org, AJvYcCXgP8g7ZHVv
 jPuZuKrkazHS41uH3jP9crRieZhrFe7NX5t2rC3cG86jarFogl28W8E5ToBKkpWIOQC5@vger.kernel.org, AJvYcCXoXMeBoEXd5XQcjWXc1dsANREFH9ycu/lKOSFGn8/panfVr+pgR77M1PATlJMpQoswvyR0yXhd0Cz2@vger.kernel.org, AJvYcCXu9xGX6egEz3iSLcoRe6ueZfKh/kH9jAJWrhxBO7ZEGtgr6yI2o8eZ92pepa0dsPU0avyviTCz@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5eHxXuw9B2cmdQYquq8H4QvXKmaIbyqMvM9btOyoYN3jsq1V
	KqZN/iAOttZxqih6mtVTpohOFLdA/bL1rpBtQ40wylbEsGvNNJcN
X-Google-Smtp-Source: AGHT+IE+nkMbR6s0+00N8NglvukSJnDC6AndEgDDgpa061MuXeUGZ/nI1UG0fIFCf92SdAMC/cobBw==
X-Received: by 2002:a05:651c:2209:b0:2fb:61d9:d72b with SMTP id 38308e7fff4ca-2fca81c1cb6mr20952221fa.1.1729796855377;
        Thu, 24 Oct 2024 12:07:35 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad4b804sm14781981fa.1.2024.10.24.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:34 -0700 (PDT)
From: Russian Troll Factory No20905209601311958242731565374199235311807310329238357771204132243322402928837852364679735075180081157725285325023645145514407 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:30 +0300
Message-ID: <20241024190730.14442-1-vladimirputin693389@gmail.com>
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





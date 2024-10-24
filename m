Return-Path: <dmaengine+bounces-3487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479C9AED71
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F911F259DD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4651FAF10;
	Thu, 24 Oct 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkW7QPsX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B241F76B9;
	Thu, 24 Oct 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789991; cv=none; b=rro6f7Iq6UT4DdS2ARsjodBY9gS8/8NpMZxmqTzfadjzgu46z/6ntrz4Ju6EF3TxDfFXSQveFYzIjh/AbPBfBsCxOzRMnoc4XrNzY20vSc4ZODZjioLgGJUe4mDLBnCazr+ebMGp2px12EzpTgGGeTn832TkVXHooWkcMB7CfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789991; c=relaxed/simple;
	bh=6hdAvb8NLWL704iTziqYqjEOhmMGQ3+UNyvCY/oBTLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAMVWPbXeFNeKlPoaIJjgGj8GSYLYnZTglQtir4Flk+Tt+vXpk/iLtqL4LT01xS2yFnPtz8lWGpL5sDfmFGii5KvQGAyehRZcIP1XKECRe87LbHQownOFTJzVWcBO/MTopXwaBecsCpnlGw47Yg4geK2nczt7zr2YslLL4k4p9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkW7QPsX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1089824e87.2;
        Thu, 24 Oct 2024 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789987; x=1730394787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hdAvb8NLWL704iTziqYqjEOhmMGQ3+UNyvCY/oBTLo=;
        b=AkW7QPsXagd8eZ4geKJbYcNjef2g8jMmlpfYwCAmLMyrquOwZUApHR/66yrgYOC71f
         G+iSBcNbuq6SEO3TRJLgbHpTMc4FnWb4IF601C7nXLquE4smEoSJQ+EtDroIgmrPFSyj
         9PN7szr65lwKMeESx5Aj6/kFdPpIWblCqCTH9e5XSQn8klXoiHZfHZJrxvy0pLbwrop4
         rG2JfzIdCHiBNHeW78Xp5m5yv62Pl7pqwdrJgnooLoqfOmQWEMTfJ/hLDe0wSHJRZwIc
         /1Cb6T1lkdMRrw8OnpLpr/l7ZY61lN+qQzcS0O0aEriqciIIwKjIyFK66/rlsN3T4EFG
         DK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789987; x=1730394787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hdAvb8NLWL704iTziqYqjEOhmMGQ3+UNyvCY/oBTLo=;
        b=EX9DVwEclPHa5hEJ0GtmEOwfMcE2qj36PR0hy9eXxm/vFmIhLxKVqmrktZptvBUbNi
         3ikMHix8lyrWR2sAAPpI7iXNuyEuoEydGFZZI375IpNcd9Vif7msgyzh3ax+84Uj2HyC
         opIsFUu1U/jW1wVvhrpb1YRssHsbehbkjAmj0gvajje1qBQePkYcs2GVRoCvEvxPTS1L
         JS1ZcN6qJFQ+Pp8cVU1Wa+XGdMvTUkCT2xsKWaiwtNpCMljA4RTVaW4LHeTIG18ggzju
         Bbj+rua8VnZdVdecHrBmPpmctod3uLIct/aQmX4liiLqbKM+QZirnw9O4oytdeawY1bP
         h3CA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHf5lGyZtHnMPHgHoxmh08FHe3oppQsWlnHE/muoAzeaRhegly2i2MyjRj3KKqmbCVhUx0vVktZN83Zo=@vger.kernel.org, AJvYcCUXKhwH54zE4GasMIVwrKvDnrlH68vrh4h7rmZFDKQH5x+kM8j5WGsO5vHOLnYnLXT3E09q/gbJTzUm@vger.kernel.org, AJvYcCV0fZ16PCiotMZ62Ok2FMPOy0mK8fPDrhRxrsv0+zuFGhXHm8SDEYPFKaHs3fYo4T7n9hlSmLiv@vger.kernel.org, AJvYcCVTtYHRmzumuTq57WpE1IqDokAKSv924o3mpD0jXZri2zgOq4Txt8LvkoJQAKwgDVjFtbvZUnIEBL3DEw==@vger.kernel.org, AJvYcCWICZ6HstfsEFyXOKAZ1lcSQUNPn8edw4Ns4SXgvh/oY2QW9MrxMThTKLR3kH71LEu/ZN25D+bOmjUwkw==@vger.kernel.org, AJvYcCWMb13+1ILHEF2D5T7GGNJ0FQLfPXk3nV3aH/yiqb+vKYN+Lmqiw0oSa2Kn2qCIYBCeapCGR0HeszHq@vger.kernel.org, AJvYcCWcNwdXiO85Va+NN1FB4LyqLVV40+Yo9d6c3thOujJQUPdxu5IYP2kxQKfQFM+aGPIi2FLRkWhQE32b@vger.kernel.org, AJvYcCX8MDUaQ7u76GPADJLXZaOho9fNbzQerLWOVuC4mwzqJMAy7clbGSYIpWxIY1Y3nMeE8c0viyYJk4XV6EJLaTZeF8s=@vger.kernel.org, AJvYcCXQ/nmcuOzmudwuJVKIntgVA+ADjx9WD16mABUpiFCqBbnV6uEReDWdD2TknFpwn9qSZ/jGBecEr3Q=@vger.kernel.org, AJvYcCXZ1DqhMCcYI2ml2HOw6s5rnH+p
 UAP3KHbZdkP1QHuL61XNBqewHF4zAdYz5t2WPRNoecqHJCZivFaaHAE=@vger.kernel.org, AJvYcCXckHYBTkv6uViV2FpTKCtD73VAYwS//4rpncnSWktEMOY2+wS+D457wwiv5pc11gEcWuFupuMVwFSXjw==@vger.kernel.org, AJvYcCXguJgTEg8qQgevsutgQTBXRIoq9f1v4QbCeH/qiboliN+DzCOT34ncLnlXzG9Y7P3OcZYkIEJB3fwxh4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoxT4dsyRHZeOlNYMeyThp4uMOwN0aXuSLs1Z4M7XpPY9Cled
	icNDGwcN9MhPYe9Hp/as2FPSg+mR5WBT9WW/cucukxrJfQwj4KKj
X-Google-Smtp-Source: AGHT+IEJrnhn/5/VxTjI1TEQfMbkTLNVVw+upqvyz70ssz9oIGnbiAEnPfVYa3vxl29Vh+zfeQfo5A==
X-Received: by 2002:ac2:4c42:0:b0:539:8ad5:5093 with SMTP id 2adb3069b0e04-53b23e33be4mr1818516e87.35.1729789986594;
        Thu, 24 Oct 2024 10:13:06 -0700 (PDT)
Received: from seven-swords.. ([2a03:d000:2:9006:4eed:fbff:fe72:e806])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224202a6sm1431843e87.125.2024.10.24.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:13:05 -0700 (PDT)
From: Ivan Epifanov <isage.dna@gmail.com>
To: linux@roeck-us.net
Cc: andriy.shevchenko@intel.com,
	aospan@netup.ru,
	conor.dooley@microchip.com,
	ddrokosov@sberdevices.ru,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	hoan@os.amperecomputing.com,
	ink@jurassic.park.msu.ru,
	isage.dna@gmail.com,
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
	torvalds@linux-foundation.org,
	torvic9@mailbox.org,
	tsbogend@alpha.franken.de,
	v.georgiev@metrotek.ru,
	wangyuli@uniontech.com,
	wsa+renesas@sang-engineering.com,
	xeb@mail.ru
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various compliance requirements."
Date: Thu, 24 Oct 2024 20:13:01 +0300
Message-ID: <20241024171301.241949-1-isage.dna@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
References: <61a622bd-7597-45e2-96d9-9cba02fba407@roeck-us.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I really don't want to get involved, but this misinformation really goes too far.

Then don't.

> https://en.wikipedia.org/wiki/Finland_in_World_War_II

> provides context. And it does sound familiar. Turns out the Finnish defended
> themselves against invasion from the Soviet Union. Sounds familiar ? Guess it's
> the same as those alleged Nazis in Ukraine nowadays.

Especially if you can't read beyond few pararaphs.


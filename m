Return-Path: <dmaengine+bounces-3480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892609AEBB9
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7736C28610F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AA1F76D9;
	Thu, 24 Oct 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfAiwh3t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF116DC36;
	Thu, 24 Oct 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786731; cv=none; b=SMvg+ARcj9yr0OJcQDzrFvrYGrHmhjsyCr1Ojc4TjvKuqVMIM5DC9eVvOR+ZvLss7kz4iTKbsRXcdCWV67N6FhSZZkqnfhQT3wIhA8gxUBN4E7+x+oxv98QJwaXVF1WkJkURJhc/5tFvtWPkU/KEI8SXBSI4X7Cep0LJN6BIWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786731; c=relaxed/simple;
	bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC43ps0JK0tJbQCsRkVVKIO1TZbPxqelKWauTpYc9JZ2wSw3+s/t56IIRSUIZgplGDn0RMFQDJ+5rPmOLsr1A9stdH3fKioduMaI1nJQv5Mx8P3yBeUYLD6eF+y5jc7QgG3bzd2nlPHEZCSWK/1fAWWo8qRW8AG/eVzAqrvbwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfAiwh3t; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so163358a91.2;
        Thu, 24 Oct 2024 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786728; x=1730391528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
        b=AfAiwh3tz2ruuvSO2sN27Q/HFLMV3BXFpH07EPeFG8LgcH2WSgSBHDIrKDAXVVjxl1
         Da0/eW5JUsr49hEW3ZyFIZPS4+7UZltW8LDqTennr73a2u7q5yo2HQ9n/hQTSrn7Qdpb
         uWuc8rbAEwKm6v9EptvjhNF6YnATj08XvCtVNQoFktSBl2fQP2p/KUSk57PG0TofudFx
         HiIUItYmnY5KFRhaLiBn+YKd6wOr8eU9hqT6RRTOuYo4+rrnc+ikm+A/jgpdNmeiJdeO
         DuEJ6z6uwS3FsUoComlPBV8AWFY/D+qrmOuCLPTujgqZ6mw76o6TzS5urwRvIqQEIj3s
         +6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786728; x=1730391528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
        b=GUxH526F7XR4Gxmx5Pxv35JgVDKSHurKbmOSoGMqRbeqL1dVqrdCStyU+wa3N+N5bi
         +lvOqVu9RS1HwBwMEwIYr9WRkOtKEZWXXOtkxPLe0F7eU5T+oqOA/ZBWghnoJ1Myhs7s
         AddE82ppO9CABxim28odR3Vh1rQ6olEQ/bsvmEm4MzAGifPLOAYgxnPT0/ZLfOaMZ5RZ
         1nvhOtFDd3yCapXs4LbeI4W1J7JdRY2rmdbW25FjEuFSFtD1oktnXoQtF+Ce3EmvtsBq
         J5bL0ZN7iAED+DBskfF6QjGzpl1fGFuMWBt62xRMiKlWWx4u5fdC/TTqF+etS7D4ocVC
         lANA==
X-Forwarded-Encrypted: i=1; AJvYcCUXKyj2CSq2xXt4RYRLTBnl/gDdxmv9dozt9GNnKr5HDR2cEV5HJXjgNmJR+Dd9qj071qVbt6oZ7EZLL6Y=@vger.kernel.org, AJvYcCUYsGsP4mKVCi2uRFWOOQEquchw9QsxofBO/wsC89n8h4FUeVDDJD/Hc5hQFJmDyRANenv2XiK1J062Yg==@vger.kernel.org, AJvYcCUzOydbw5QKCaYkUh9CQYfGcNS7wjjRDqyi9kp5Uy8RY9Vv36QTyQg7j8EoW2O3yAv2vvccvzvDDhQ=@vger.kernel.org, AJvYcCV/8khykCZkI1faG/W9QrKuSZMiswSryeITy47AHHHwfBw3d9+B2zdLS3sKhDyv/w29ZSdHnuQmxRdH@vger.kernel.org, AJvYcCV/yHnZ/z/lAXsSjAjWTex6cqJJD0XCz4/BfgmwvSHsZhInwlmex3lBrh4XDkhVQKl0hG2zpdHjkE7ZiQ==@vger.kernel.org, AJvYcCVKJddMmhh05FFeQRx8WqvhTfhzDISiuVIfZa/lMDzZV4ERamqdtr5D3FrDFbyy+2s56EPPrOVbWBUPvAuQ@vger.kernel.org, AJvYcCVcRjNUTEzVG3jvT9xaf49LfnA5ZkgO3zniNvhCYICAxAfMHQ+IwXK5EEPHCSpqJROy2VDv8EIWEIygasXP6y+5suQ=@vger.kernel.org, AJvYcCVtvbdAqo99KpTYStn9xzZem2gu8tXLoxuSFWTvni7nO0F/cY8Qp1fBwYtbOGWWp3fK/q8aEPE3lT3o@vger.kernel.org, AJvYcCWd4dMkAS+jeCb6jUwDhuc/NwN/jGE8J+R/OPq+w7Lw5XpXhFnuCJ5BRR+iAHoy5Zg/Iq2O8Au0+zPTSXMT@vger.kernel.org, AJvYcCWzZLlIJMznKErY
 26bvtZ8t5+V0z6/GcZpKY6WzNHxXpFrvPTMrPuT6wk+GyCfjaTg3KficxJQ6i+BP@vger.kernel.org, AJvYcCXsvrHotjcPU/B++3eN/eXKKEhFzi0OnfNPUQzuY4xxMOh+UtperckwazNN6tbAKPm32o3mfd3g@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYAeZW/uoDfo7x7puA6z/y1xqtlZOTFTdafs45BRm1BckX70a
	nyFp/n8DlGlqjb48oMNvgIr3Ou/PWczejy+kYN/fDL9B+nLK67Q5B2kXeSfghgfD5aZpHVqVJsl
	29PCJOR1+9yBHRr/YeOAMCMp6Wbw=
X-Google-Smtp-Source: AGHT+IGwQoYu8jU0A8Seg0m6K5s4gCJzmA1d6LWFyNxT6v2L0ZL8B5/jlWz644nhMDNM5pjG7/4zlnFaQ4bagHvBeV8=
X-Received: by 2002:a17:90a:6286:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e76b5e039bmr3425664a91.3.1729786728192; Thu, 24 Oct 2024
 09:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com> <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
In-Reply-To: <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 18:18:36 +0200
Message-ID: <CALtW_aggEMXB=aiOe3XD2Y3U5qK62q_zxQjyg4k-mKdJsCLo0w@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kory Maincent <kory.maincent@bootlin.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	"paulburton@kernel.org" <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Arnd Bergmann <arnd@arndb.de>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci <linux-pci@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	Vladimir Oltean <olteanv@gmail.com>, Kelvin Cheung <keguang.zhang@gmail.com>, 
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> HUAWEI TECHNOLOGIES CO., LTD. Under CMIC-EO13959 sanction program.
>
> Although it's a Non-SDN sanction, it can still be interpreted as
> "subject to an OFAC sanctions program".
>
> How should we handle it?

It has already been "handled" using the same vague justifications
with a cherry on top: some good old American bigotry and supremacy about the
"free world".

https://lore.kernel.org/all/20241024032637.34286-1-quake.wang@gmail.com/


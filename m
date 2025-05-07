Return-Path: <dmaengine+bounces-5099-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CBAAD6E8
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76BF7B701A
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341F2144CC;
	Wed,  7 May 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5RX8B9N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DA1D61BC;
	Wed,  7 May 2025 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601893; cv=none; b=F1kDVd7cEc/TRfWlmOt4esAaUrkS4vcbSKrAxp093eUJFsMi+wDE81G4D5cZRLZOahFLA0H/UzaG4B5cVcOvHbcX8w+oXX/J+/6XfyOgiFDAGAHV7hHZ8fiUW4ul215dAuyLRQI4drMFHnmNtFsQiqRUkjN+QuyhZ06tn78pNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601893; c=relaxed/simple;
	bh=HNkP2z7fO8dRjzXPZ7zZcqQkaQmQMB+gSMGx+hs7H8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5cnYyKqGJlNSxUtYceXyXDY6K+eaf57L5h+h51Esq8SycuSfWSTRjaslespmAXf+bZDDiQqEjhOFb6AwwqrZCuRYdonEYU4RrjAhMI8ZIJVdfH+kazx9seE0vHXJY9KRV/SK8r6l4OKy/ozYJ2H0NtDGUusFVdWrBy4nJ9KMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5RX8B9N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso3408585e9.1;
        Wed, 07 May 2025 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746601890; x=1747206690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jn2G++5P5iR4QIZl9LBB+QOBbe9aArcNf9gSE3QaJs8=;
        b=l5RX8B9N5xlX1AessZ1yBLDY6pk4rXVmApcN52SPgRXWbhXOIF+pPjhRaFoASxl1MJ
         M4RRWIkWDXF83R6taA6gegJ0t8Y2d9APDn95HXTKpUcxo9LE0nqV6QGl4D/X+0r/rDrk
         8kzyl/GEzEyClsbOcFTDT1RPVKGJ6O7Zk5zv4nHjp/dZtyVccW5TcfCfN4jcVl3Zjp/p
         Q1iG/xjW8oqKtIHLqHg0/mOSF3Irc2OxVtVJJ8rxXLd/8QJRFS+pdJ81vsoGpCcC41oT
         yqiEX0QyPHHMO2aJLlr212GPYEujfOxoqvRYZ/7BREkNOf+4jVYrgO66E+wgzeZ2drlK
         aOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746601890; x=1747206690;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jn2G++5P5iR4QIZl9LBB+QOBbe9aArcNf9gSE3QaJs8=;
        b=upTo1AQAerSJ0sypdZTAR5J14jfG4iLK+TVJgbdSfbwuY4mER5XwBTO6zXEwUoiMC5
         imLnYVMSdejPxnBdZA3wmwrW0ntFxbNKrLBkSHGaeKKDXG9E5G1l90uzoYnGm5pX0EMn
         qFAPeU0vP466JgS18InkkdVlBla30PPTsvgRSX131KWkC+DryaDqUYOGjh4ZUSIP3Nc1
         PNRIpDUF/xIotJu56eDmoKSW9ieEV0wguqr9H5N28qXVtGX26Ia1QtOD5QYcqvLd9qz1
         VpyCX9cFJhTr4TXH3EgHimk9XDr3ooPrx8satsQegLCnuNSSlFdIvYFOBNi87i8RWSmn
         pkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+GOTOmdQGql8m5H2005rwsY/OdSF+D/QMKLl6jkY4aSs87RhTXETkVhlsKL57YlAfqeGtX3GV0b2+@vger.kernel.org, AJvYcCU8cnQKqAJdTqoreQ//Z0HW3GPYrMZzmP84unHlY2DQMcK/uhw6UihFo1wV/cReEz8XaeogoBW/bZT0@vger.kernel.org, AJvYcCUf/IdUbPCnx9/JENEQMmIePXxBEFtnKXAvR5rLBBOQfHFNcoBqxEFY68UKlvvxR6ddhvIXV47WpzQ=@vger.kernel.org, AJvYcCV8Kdczc3DWLlw8StWhjTZ/Tv/3ZfFmj9ZdHUQ5AnRN4WY4nrnCuzzrstFpeV13qweRrHbz9aruLTVV@vger.kernel.org, AJvYcCWKNNXHGX68zQGVYc6qBtlqmBYKcJObkfTD2hhpIgMDW1YTIDlVkHJIy+GYVHxwPj7oAHCr7vu6RA8u@vger.kernel.org, AJvYcCWtHqZuiAGRhONDWA42p+KzPPba//QPmLa3S6fiUv6d7sA25VePr2m+pUcDdVGNJKdU7Tf7deylVBGKjg==@vger.kernel.org, AJvYcCWu4ez2Lvqxe5DnmpmOwe7KweQzlWi+AYk7wJYNWykjoQnpOh2t58mjsAs0J8UdhcgU8HR9JMiPrDYIslg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayOEO05l816MxYEfASy3S5X3KkFR/yBjKLrsRcibyE3cqz95P
	wzjArMfNjX4cea7W5+yh8zjbEud5tmD63GB2/3fG5V6NhavspBJz
X-Gm-Gg: ASbGncu1ZttCnXmhy8wqux31Z5EnGBediXWiuBHO+vYuVGGckx/vyaxNklld6VE+DiZ
	tMYbGkt6neDkBE8s90pQIsugXkfzTCYYHNiHGtNqhbpmELuF9scrUZHNqESvRckDPqkqp4KlpGs
	FXonwQ+7zT6HjhhMaS6DNxiRmACs+PNwLNCQcxSI6+jAmH8/96b6fDQNiKm0c2blIhftCinENFT
	ldvkaR73RVEDayY6IQZDthkfQZJbvgTQElQ5AnB82fmTExHyB16oD+wchJWYgzsLfrikG9cFCg/
	GUGuQ7Tmnlh7NzR4B2W/Hiz2C0fhLxkEnw9Pn6lElc6Mo49weYLJS2t36HIyoPudpqmllOpwzHC
	SR+CBmhLG0lIQH5I=
X-Google-Smtp-Source: AGHT+IFP/BGLUhNjkANF9Q5NNHil9mQ7V1wjQN+dodd00ido4Dc9LAmYaJnyVsjC3DmY9ZMTKkKmAQ==
X-Received: by 2002:a05:600c:6749:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-441d44c3a91mr16863985e9.14.1746601889628;
        Wed, 07 May 2025 00:11:29 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d43cb584sm20895405e9.8.2025.05.07.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:11:29 -0700 (PDT)
Message-ID: <ffebef8dd4255da67a8d6b7228f4e04e789532d5.camel@gmail.com>
Subject: Re: [PATCH v4 4/7] include: fpga: adi-axi-common: add new helper
 macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Moritz Fischer <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,  Tom Rix
 <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare
 <jdelvare@suse.com>,  Guenter Roeck <linux@roeck-us.net>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette
 <mturquette@linaro.org>
Date: Wed, 07 May 2025 07:11:53 +0100
In-Reply-To: <79c256ab-3d21-481c-ab9d-eca643d3d998@baylibre.com>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
	 <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
	 <79c256ab-3d21-481c-ab9d-eca643d3d998@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 12:21 -0500, David Lechner wrote:
> On 5/5/25 11:41 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Add new helper macros and enums to help identifying the platform and so=
me
> > characteristics of it at runtime.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0include/linux/adi-axi-common.h | 35 +++++++++++++++++++++++++++++=
++++++
>=20
> Since this file was moved in the previous patch, should we drop "fpga:" f=
rom the
> subject of this patch?

sure

>=20
> > =C2=A01 file changed, 35 insertions(+)
> >=20
> > diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-com=
mon.h
> > index
> > 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5=
716d428fd2
> > 9 100644
> > --- a/include/linux/adi-axi-common.h
> > +++ b/include/linux/adi-axi-common.h
> > @@ -12,6 +12,8 @@
> > =C2=A0#define ADI_AXI_COMMON_H_
> > =C2=A0
> > =C2=A0#define ADI_AXI_REG_VERSION			0x0000
> > +#define ADI_AXI_REG_FPGA_INFO			0x001C
> > +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
>=20
> Doesn't the voltage register only apply to AXI CLKGEN and therefore would
> belong in the clock driver rather than here? 0x1C seems to be the last of=
 the
> defined "common to all IP cores" address before we possibly get into
> core-specific register definitions starting at 0x40.
>=20
> I guess there are 1 or 2 other cores that define it at the same place, bu=
t it
> still seems not-global.


Hmm, to be honest I did not checked. This patch was out of tree and I blind=
ly pushed
it (as its straightforward). Will drop the above.

>=20
> > =C2=A0
> > =C2=A0#define ADI_AXI_PCORE_VER(major, minor, patch)	\
> > =C2=A0	(((major) << 16) | ((minor) << 8) | (patch))
> > @@ -20,4 +22,37 @@
> > =C2=A0#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff=
)
> > =C2=A0#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> > =C2=A0
> > +#define ADI_AXI_INFO_FPGA_TECH(info)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((info) >> 24) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_FAMILY(info)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (((info) >> 16) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)=C2=A0=C2=A0=C2=A0=C2=A0 ((=
(info) >> 8) & 0xff)
>=20
> I guess we don't care about the DEV_PACKAGE field?

ack

>=20
> > +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ((val) & 0xffff)
>=20
> This VOLTAGE also goes applies to the first comment.
>=20

ack


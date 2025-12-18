Return-Path: <dmaengine+bounces-7812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E33ECCD4CA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15D64301ADF5
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC67332EAA;
	Thu, 18 Dec 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzOjmPrn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4232D435
	for <dmaengine@vger.kernel.org>; Thu, 18 Dec 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084330; cv=none; b=H70E2nyBrz2a8Lj7AJ8nbWr41OCSJaGhXkBKoWjN91jW4ihugjtG11hRoW5JKF+EM39yvaosJmbriz1ovy9dqzno7TeWESMEr6LFsaSfteByIhV4A49mGqrQMbm1XsPHq77oN3rmQcNLJ2xDXoytMMB3XTZQyYUnXcUxgkKoq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084330; c=relaxed/simple;
	bh=Jku28IM/c1IYSHnKsavbvy9aaLBIgMj3F4YQHgrupho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq6Ihb7+usdCMYXbNRipdk7x3erR7/rme94LawiDIPbXZYCIaggqrXSGeil19PFQvSUP9+peHO3RJbG4nJkxJ2bkq2Juk6Wy7wEaTJBLGyjkQfCWPE+HtMw849gYOGYVhQza8idSINh3Jm4GCDk0FPeGcVLNsJvHAAvkJUojKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzOjmPrn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ba55660769so852106b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 18 Dec 2025 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766084317; x=1766689117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=NzOjmPrn46f7eL94kTiu7+0zvL7EqcBFTL/HGLf3Rc6h3rBZjvJM5i3qCCD2fYrXy7
         eJklrOOWGmpDdYURm2bD9+/3PlBRsY8WKHCZ2GLGzwLcw74QlWuQ3QwUrvnoh8XgWay8
         gOij/Oftk04H9HcDeMjrum7Gp/tJMDS9TcpBQwDo75WutLi+yiY8j3WBiG0hbm0He5W7
         e9CpO9bAAOVDpz+N+io0xTJRBjOcs9kNkjAd+Z+kY0znjtSG4hOPaCJlbg1PV1xakEpj
         cFYP81lVX+QhyL2f1NFGqqWTbtem9suiHwzZLYFwy//KO+NJmpEmbUADkYq65Km/0XcM
         myZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084317; x=1766689117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQfRVSe9fO1PObUKRZHse1cNpjrf0uUXBusNVMTFfiA=;
        b=Of9dBE62TxY+wGhFRdWaIw+HMWqzM7NWFTyDzlA6bWYa0aYSnvjLfoDNSV6yzs0GrB
         wXS9fYu2tCNVwLfJ74zjBFa2iZ8AtffE6n2WLBKCYelPm11dYXW1UpmaHX7l3MZ3eMGq
         mmIlZ34DTc3z0WEqNpzqROf71C98I1VHlhASAHRXECb0F4qYAMNK1w7k55OgDkzaWrNH
         a7LMrJ8CQ+vMnhK3/Y5ewa0CPwOeX1enpG6vxxlYIMAATznuXo7HaDU+cGTwthsU3EPJ
         wO0wDLl193lLQd+N0mRnioeiNzoKPHfasinVW4Ac5Le6E/vblp0wHZqyu9kqLi3fxMC1
         994A==
X-Forwarded-Encrypted: i=1; AJvYcCXVFSVnn4MqCRmPWGE6X1wVQ8MGdItXnhZfO2KzD5SyolgUkYdZ01lv0jUD1H3Us8JDuqFqqv/ZUFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVZZeiVm2q50QlB+7NSMMOYcYCZJY8kACgFTVBrg4wpxFecM1
	G0IfS0BE1Lz5K2pmtnYnxpeGXhrYH6vQOh7SMx16dH5sOyRRfWR9Eo8r
X-Gm-Gg: AY/fxX5vm2+L0Mz9KV1F8272EOC0W33482eHLxvcgwaDrKj4yD+VRQJWok7gSIuf7w/
	LZDiDoqtJk/3tn0MFPJtcmMQLAm5mM84pu/0s99RCAY2RH0NjSgeJYPn9P0wwiKncFUQ9V9mDI+
	2Sf7EuJRSrnAzSsSFnO0J2sVpg6JfxgOdOcLBnxcx7okDIi1yDqBX9YKwR/1QifsZ9oaxQTiJDa
	T848k9xgXohniiZvVw3u/1p0m7Cq6EckOH+i759RSbcMeeJLQCK0S4Jlx7ZuMiTNywSL+oY313R
	XvoxsO2+jyu9aw9Homr8B66pi2l6p8+JAmJvHIkCFB885lqFmEWkM30gjJyjgWYepkqSUtgQgzo
	hmq25Oct3qjzLFcuSs+R9+KSYwj7eyDxzFeSvHquDeOSGhQhKxDGyviLmBiQk0O/D2x5cyiOpdu
	shGSSgi0Bhj20GThmKokPK1eOA
X-Google-Smtp-Source: AGHT+IFf3D0xeHaQPPXEeazhorZHgIgTwRHiyRuussKNgJjGtFBYIJhQUMgRhb/IHzjPiFdB5lKzgg==
X-Received: by 2002:a05:7022:3705:b0:119:e56b:91e9 with SMTP id a92af1059eb24-121722dff1cmr177764c88.26.1766084317443;
        Thu, 18 Dec 2025 10:58:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm299016c88.12.2025.12.18.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:58:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Dec 2025 10:58:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linusw@kernel.org, olivia@selenic.com, radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	richardcochran@gmail.com, wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org, mwalle@kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH v2 15/19] dt-bindings: hwmon: sparx5: add
 microchip,lan9691-temp
Message-ID: <8462a516-4e8f-413c-813d-e7ff0e6eaa1d@roeck-us.net>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-15-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163820.1584926-15-robert.marko@sartura.hr>

On Mon, Dec 15, 2025 at 05:35:32PM +0100, Robert Marko wrote:
> Document LAN969x hwmon temperature sensor compatible.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter


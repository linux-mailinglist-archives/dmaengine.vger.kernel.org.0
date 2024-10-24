Return-Path: <dmaengine+bounces-3455-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DD9ADB03
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 06:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554541F22BAA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 04:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A7171E76;
	Thu, 24 Oct 2024 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYwBDNZC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464F16D9B8;
	Thu, 24 Oct 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744929; cv=none; b=Kb5PVQQ5Hvc1m3+uBmCnG79KYnjpHAHYwxyo1jo/Hjlpwi9dW9jMJbOApFSyb8OLSxa7IU5mZgbxu6/MOw4i/GDCY7DngflV/DuoKt5xAan3p+RMaETiG4D5VqOmg1mqtWglGG7GFDSiE2nzTU5ieAONw1EEF8jfLd17qaCgEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744929; c=relaxed/simple;
	bh=/E05jT6POpOqZDCpwe8J4QUwk/2Ud1uqQgjbaLBTXt0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qe7SXfWJeqMkBqkBNX+jZ04P6GKiGbO2ltLOqohlDiQmUKkTsHZ74cgn8yzHBqtC+6DJGH4YeGaS7QKAA4J43B9KWvjg5TmwweKNB7l6wzbHEii9kDGkE4SvfTZMXZVL7ZEMFE4+ZKo88KH/StUCnNXQKspQU+uC+lrJda7k0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYwBDNZC; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f6e44727so379622b6e.0;
        Wed, 23 Oct 2024 21:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729744927; x=1730349727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/E05jT6POpOqZDCpwe8J4QUwk/2Ud1uqQgjbaLBTXt0=;
        b=iYwBDNZCE4PIvv2GzhNkgR0nhcJHXEMmQ/4Es1RoDp6eS9i9Sy60W5PZP8GRnBmEQ6
         eCCmoVkahEHUNX0q757rmHgTCnBb3OiP48oSMYxH3hwxOOK8iHWG7fky8fMtk2p52LAK
         aw2egkSYqXKUmnhsQlR5oP1ciT0QSZoe8Ua0LsHzURqcMsZwTOOtJnywIDnho84lV0nc
         x0OIyT0adoIeK9mJpEx9aiz7EWL42XeLz8mkexAKqjIkRHwUY9S6ZZuln1XBv6bFcmle
         aG+CFNtIdNk++42zFJOY9Gi++ALFS9125ln/LhKvlC44e/jbe+smGXwgx2AVgiUGl++B
         H6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729744927; x=1730349727;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/E05jT6POpOqZDCpwe8J4QUwk/2Ud1uqQgjbaLBTXt0=;
        b=m6tnofiDEOr2PL0e46WFkiqwcr6hc9BJ56/St3gPSsXrnNyQcRtqkAjQ8fKpRfh966
         lBkenycEEVpeewH/KTZeRCEYaTqxk8WSuCxZCi2e0dbA3FxMjvL85PdV2bpiVMeG4km7
         wV1wIVe8mUrz1iCj/ZsVWeSB1hjJ1Xso9RuT10JuNSe+m/O7GK+uLP5Rp/PeZO2N91hU
         lsfwDr6HW2nERIealvnmW6fgqH8FbwvKLrT9HGXyxRGhSCFHWSWMfmOqcnVzBU3luSXf
         FyQhHId5tc3X04QH9aNAq21fXTPnmc9J1yUJu0m24UpjGt/DO7NDx0vD79BtA3Jw1iY/
         wiNg==
X-Forwarded-Encrypted: i=1; AJvYcCU8yXETFVXvX4Qy1lZW1xs5lTH2lDQr7n4qoJtN5K7zt4C8lMgBoyfPoZ7CiZFV0smzrFxpZQ5x27tizU8=@vger.kernel.org, AJvYcCUAFEcVi/E1h+gCSHIpQxg8Ebc4ZC/nZgWy0nzEqeAC7JYgIlFvAR6lpmDosDYml4HSuxjjNr00onoWJ8U=@vger.kernel.org, AJvYcCUrgyH22CeC2NO0Ru+7cgXphwZ/7a9w3hNmnsDomhP7O6yc+dEfbFVtbe74vKNMWnnr41/QEPBroD4C@vger.kernel.org, AJvYcCVpdjGI1wKOXlaFnQaV8saJPykrbhNYfcgbjZ4XK4iF8BcLwxxXg5UuoR9v9eaUUihTuK8zaDPOyU0lWA==@vger.kernel.org, AJvYcCVtjXdUbAeNbiJcutBuf3oVFmCDP3xIY4M09km2QULbKi/7q5g0hmomejUuOZXmZTWS3v3dUQhdIWU=@vger.kernel.org, AJvYcCWcXrye6ten84Z/7bReyRPrOMmGPpeaVuQ6I0R1kZNJxLiK2NOkxJfO1hNWA3r5cwSkCdN10SKSupfC@vger.kernel.org, AJvYcCX8AMOF8wqogJfgUsEQBcHMnHix14/XGtMrv7W66Tb0M+hEwJokY1etik+bebMgKlZrVMbQKXVcArZn@vger.kernel.org, AJvYcCXAByLVofUKiQGmamMKhrI/MpBF4gn2yR/cMxj28pGrVyc2n9d5u9Rf4Mc2WLQ4mWTtHUucF8WxpDqqPg==@vger.kernel.org, AJvYcCXIXjF9a4H3tzvMOWrTxznlh6L4e/zBzOYNwWrAZaQldauWmZ9NX2ieS+jZhmLBArO/SZQHCzoHpHnsWU4=@vger.kernel.org, AJvYcCXUGvStD/7y2uW31S6Jy+p3hPok
 AoH0TFIrvPmw+QqOKm3WaEDc+P6pKamJWG9MVVC0xuXiZbPL@vger.kernel.org, AJvYcCXr7C7x0L+IYNAN4Ho8VhzN/7/cxGYsf889UdlOp8gMIpi7+/SYoPXi3SaZN0h7PltlbN5nR1Iuv6je4B7gc8ygXeM=@vger.kernel.org, AJvYcCXxiFpBwWKKL3DbZ8TtwYWyxkwu/PG2+l4Ya7zS9/yaeIFM3pzOwIi1L/2H9Enio2iNc40fgIA6ZD3Hrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79KG7HsQRrtfq58Kx5WV+6qcfbD1L2dr14l5saBwpnqUyzrcH
	r4jgLp3Pns1jAUVZb6M/Zss58G2Rs6608WFUHMx9VS9xaV0H9gr2HRzAFP1GT0I/TktE8hLiiHh
	GMiVWbrV7I6u0v9ChP5cYGIb7/dpOiDpCcv+ozAzg
X-Google-Smtp-Source: AGHT+IEcPxkLcRYoYZ+qYqdz3rf9C8aaTqIgeoOwaGj1dLh0kiz4T/GQTSq6ljBIHvhnOb/5OXIeeI806cLnduNI9A0=
X-Received: by 2002:a05:6870:3324:b0:286:f2cc:7a4a with SMTP id
 586e51a60fabf-28ccb9e54fbmr5220982fac.34.1729744926679; Wed, 23 Oct 2024
 21:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ar Worf <fricks6@gmail.com>
Date: Thu, 24 Oct 2024 09:42:02 +0500
Message-ID: <CANSmiqmTobiHdS3zi794hg=rmvg6ePWDp7_vhgMD4_Sb4by7hA@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: torvalds@linux-foundation.org
Cc: aospan@netup.ru, conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, jeffbai@aosc.io, kexybiscuit@aosc.io, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	Matt Turner <mattst88@gmail.com>, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, torvic9@mailbox.org, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, wangyuli@uniontech.com, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

> I'm Finnish.

Said a descendant of Swedish occupiers. Ooookay.

If you deleted all the code committed by Russians, that would be at
least understandable. But what you just have done is refusing the
people who contributed to the kernel due credit for their work, while
keeping the results. A totally imperialist mindset.


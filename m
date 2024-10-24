Return-Path: <dmaengine+bounces-3517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084C9AF0D3
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBBAB2247D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA619218D94;
	Thu, 24 Oct 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRHlGxzE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BD2141CB;
	Thu, 24 Oct 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796856; cv=none; b=hp3v3J30ME06ZadSwcNtOvajxKxOtSnzU7WGAhXlF8RpBZiqH+6PGcYPsewrvbZXD2Fvfa8kVcMdiT3Z9+mH1RVEyCmb6BIuscj+4SF52Jb5FoPLmvklXNoVx/J2kUsBg8ebnbNYP7+p8ZafnxO/aZ7N3+EJUp8c2cN+APkk+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796856; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGaEPmV7wz7CinF++Vpi7PfMIz2difZIaQvNSGNo8LRPLlsFu8bO30S+GzrL+TGhO1KxqfoB3Bv6QIpZqLNizNDHIrC5R8KzhFPGvr9anApmShtGePqT8HQz81rH/ArL4YOvcW/9lIJJdtzssLKtjrj1VlBHQVQEZMEc66nMMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRHlGxzE; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so21566681fa.1;
        Thu, 24 Oct 2024 12:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796852; x=1730401652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=aRHlGxzEYWD45fxc0gDBEXN+QMIDDPMPGIdXHwkBSyD50swvjp4zliqBIxxB8VtC/9
         cDZENRcd3l7sEsDDuHnW5Myh9tw/qK/i+2Arpi9tY0D/cj7iLB+ISngDBIZUKrCDBlju
         I50f8EvQ0kP4oh1HfyJB2jG3BJsGftAmdDNJnxOrlitma0WPu6DDL7eRMQv7Jni2fCdS
         FIYiFUHvakHr9Fu4KKPPjLFBw2ASlKG5SvYF0PmYc8PiwfSDoYAkp/DI0jjMvNigYv4N
         XgVFtbcg1/Y3/gGerHBFPrDNRqdz4p/dG6rTnS4QL95Cy4sy2IqyThR1SXs1P2ZgIYA/
         E2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796852; x=1730401652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=rsYguaTRmfGpajLjcZMppQv0+u3YLFnpjNpc1eyXcV5XRUe0wdTVF/UimJ6Z9SaX8/
         EmxpIpZJjhaaFaSmFJA56zZKSuFIcMSEpGWa/DghMTrV295rWkD6k4501IDW3SbEDjM7
         Vka0yxeX+eY7bU9vOE9hkthgAKtsTukEI+xpZS6+AEi2fCnstpirAGlfKIS/QDRfGrX5
         K/GbceZnwaUddZnHl3NqQyDZTGFav9ojQqzUgg+3jrOKuFDxXwRE4m+uko8gqJvZkC/c
         t5TdWX1YBRTGZAGcztWaSu57/d1pSQp8tm88mTCn/288QlPnW+0/LO4BcwfC9bKmzYUR
         4vhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuEsuiTTBlfzOa+JPAGnTXimaotRmZQD/EYEyL9qVIvDHs1J8XS30FBRl3VR2uO+lJxxMzGamT6UTIusY9ctMwt8=@vger.kernel.org, AJvYcCUuv6Nk63On8Jyd+mhMyZMB/Lhtn5g0IKSksd6Wp/hpDMC+BMLlCSUVi3LxutWWW9xhn5CLMQOSaDewwOc=@vger.kernel.org, AJvYcCVTDSDMf/5ckCOm3+Y427tqP55VQ5274weuZGCn3ika6Wvrsxm7fzFG3xZYnYCxamB6UovkIwcm6Cz2Yw==@vger.kernel.org, AJvYcCVlY0mj2uQN63uhzZFvyeqxHO6KP8a1WE0Deffwp2Y6tHWbI5FoUwuLaDAW8bCskWfKUK/w1lGCD59FM+g=@vger.kernel.org, AJvYcCVphYpk81U/qxbuG7/aMsiASWB783rz9LqgQSZTNVmTlYycfVynvbG/L6ZmwZW1CybAvh/w2IYVTt9J@vger.kernel.org, AJvYcCW3nipfY5rca2rYUpo5+uG7DT8ZpebtEfNIMXTpwDfP7xgKlljrCoBEMK8UnOpN8eUICd/GweAQMk3Kdw==@vger.kernel.org, AJvYcCW5zl2MbRA+UaTE87AcgkbJs8i73X6WxxsdHb8V/Z9GHJYoO7vpk3HPGtSrWlMxTMDhB356GWKfuwq0ng==@vger.kernel.org, AJvYcCWPxMiYww5NHiNpBG4P6uxcOC9PI7ue+7xzSqk+gH+U12gfujY6ZyRjH4q6Wo+BZGTTwH0JdwwtmNX0@vger.kernel.org, AJvYcCWZJSMbwJWVXdoV4/DpIAFZeL2bTe/cHVXH/vhe/X9XselkhkUGOklLTY5oN+PUSQ4O5PYgG7w9SDUihDg=@vger.kernel.org, AJvYcCWe6ggF1/VE
 1617TNooe0MpOnu7QHcs+3f13Je8H+5Gnp+GeSD2zd+LHffDySzopOHO5jrtRCO3@vger.kernel.org, AJvYcCWxAhkQDtXj5vaVQwWuq7fRlgPubC0/3G/hxT45dITXRGZS0GOMPdiKxUhu9KiEeQ4I2Oce0QyNlTR4@vger.kernel.org, AJvYcCX9zB5YuhAmK2xHqiy8pqI6c5/E2ucKSqkGaIp8xhCoLFSRw0Il5QRU07avoBEtjxkSg5dR6Ja+4SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgItkF2umyjQFtku0OF2U2nnfrsNlaFleDec9lDyGC08Umy+4x
	xYCqGg+wQODLD2Lws5tUj8xig3ZkrpqT8QLGbbdyoEuebB8SuAZI
X-Google-Smtp-Source: AGHT+IGkzrmT5YQQnbQNKibdTSknEXEO914jZOPptCJkfMXB6whnJnD5AUwpq7nePl6mk8t7k8VBXA==
X-Received: by 2002:a05:6512:239d:b0:539:918c:5132 with SMTP id 2adb3069b0e04-53b235c402bmr1230309e87.0.1729796852047;
        Thu, 24 Oct 2024 12:07:32 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431b33sm1435730e87.214.2024.10.24.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:07:30 -0700 (PDT)
From: Russian Troll Factory No260514655240868651681554541120830602982121025722286328249193132677890951209756961642118806381177982473576792841666513973 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:07:26 +0300
Message-ID: <20241024190726.14431-1-vladimirputin693389@gmail.com>
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





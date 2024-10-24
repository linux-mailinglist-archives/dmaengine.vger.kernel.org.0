Return-Path: <dmaengine+bounces-3527-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16C9AF154
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A820B28504E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232021C168;
	Thu, 24 Oct 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxs9G72L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72D21C161;
	Thu, 24 Oct 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796897; cv=none; b=l7hhn/zleE5hF5UfDw7kG89eMHqXyblG1yeHGNaQ7yWcxsIxRErBLmnEdKih1ARwRhO9ncst01SHkontbzWXDIm/4qIaDHZap0Jen0ndTtoiRpYBlXsOC/PNg1iHSGTR5qa7nvEtaVA/Ru8kBZT4dvfbcsqb2BMS10vIdDKoj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796897; c=relaxed/simple;
	bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9puml857y0JtQWhAN49g1nqQbRj178qhufJx1M50il5MBFfHgVeCf4e6wxPQJKCGEAumleBJhQ5wzEewVh0panR1AS80nh0E27ATMdbkm4Z1erU8vM8JkLNQFcxx2fPAm6OEAuXJOGQuZAo/eJb7zvCxL7qZ4W5lberivfArRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxs9G72L; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1807649e87.0;
        Thu, 24 Oct 2024 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729796893; x=1730401693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=hxs9G72Lyl2lWiIn2pZeJH4TJaKfcRj33efYGvosgKi5e/Pbw8x5UpC+szLZrgsxpS
         X9lv/eoN9hBT2DCoFRFaROV4+o/wtEacfwni9VIgjiheOmIGZ5hygxbZvK7pHpiEKTra
         4/AYk4OWXeCzykT6GFibB8wB+x+XmpnWa7tvWix9F+D7Fsp0l1lCtbDm63Rqblatgdpp
         Oo+CLfHn78MABAyx456Zq2mKMntyAO27dJSraUaHxqzg8CF2sb2M8onAFN16g4PpsTy0
         ORgVsjCEOY8FV9J0hj6wdaIyYD5t17gKqWgOhNn7yC6Cf8eLBqIcCRa5mRreN50dTXph
         XHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796893; x=1730401693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLVkYT85aPE762YWX/Qza6i4TLO/D+UE9Oy6vAHa5Y=;
        b=PwI/UT/qD0r31QMjP+254Ndt2tpgGzgfq6B9UV3KqaOrFWLUKREv14iOQV58100l53
         9ijB0B4eSPLoltdQYVY8+FLRtYXMto0g3yFeiGTDDH2+wCl1/4FS5F2wJ/4mzwU08YbD
         O7ckkj7fpQVMxjnWq5GTX5HTKknZjMhFIgnntyIz8hiZ/lTHcjAhGHm+p9ctYX2gILYm
         R+9GI+vo7hwvfk0BNQZLNt73Y6FWq6OzdbPVItfN48EvGojTktqKGR2lAwsPTQWJKCF1
         BAe4XMRgTpm0etLZsoqGvqh54vqL0ilUp1ZLsZenuw2iszo3fRSjhaF405QZmqh/34MD
         ravQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3gzlTXW1OV5YR49EL6DPZOCEpgjOGSibLnNnfPj2qai3oF8fYdGtwYGjpH1SokAUfC0eYAQI9M3+1UA==@vger.kernel.org, AJvYcCUIPhwURSGscf8Ms/9wnqdRto5q+IH5E1h1u+4Td8hrLLAzLDjCsBJqlGbk0lpWT1lRI/BV6sQS@vger.kernel.org, AJvYcCUe96kbzVwMz1y3Cid66pync1Fc5FmpPrsfvYiNMJ0lmd+B9tzCTkGRvs/F1pbu7xNXwaPfIrNS6yiNAUEp5WqTiyc=@vger.kernel.org, AJvYcCVRCdWHds3xqpiFsRW+BqyS+5Tsli/HsmAXCfrW9Vgbjc0gf02bs7AVTZJjjKJv9Sz1a3XabB5x6OFG8+4=@vger.kernel.org, AJvYcCWOJqsIwVp4eL4XViQSIyVFWKq+gNU0xu96Rx1W0KFbQl6YbABhuFtOH7X2e27OVGE2CyJpeG4rTjbvfQ==@vger.kernel.org, AJvYcCWusv42aGKi1W7Pqn34x4lwmvsc/8yPskqJZMxTzEti+eF3IpHYTQmkcmtEeme1xPPn2inwPJJcLo1z@vger.kernel.org, AJvYcCXFGb7o8oXQb+OY1mHn/gCYMHHP6+SIqomCz+S99XRgY1URLN8YqPbhGfG+kcc4zfHYkDfd0prihLQu@vger.kernel.org, AJvYcCXFnbJIYoe8UwLrCu2bqGHi1czhokF2AFAB1h2vakM/o/eadDy1h1FyNItVRJ2H83MQojsBme7OlrOZ@vger.kernel.org, AJvYcCXSNkazgX8ny2Yh9/sK+6j5i/7UuoAzaRLEIzjtuazGXgG2oFutdBH+PUU8Mvu5MEjbyxfY+PyZ+CBmHw==@vger.kernel.org, AJvYcCXitRZnuXy2BTh9S9ul+gwS
 8GAg94Rgfmp7nhPVAxKUf3JdaJwuvHGaNq7qWdUvcrsntmsNXt2oE2fRxn8=@vger.kernel.org, AJvYcCXkwKCwHg9GiO0lT+fGKzwLwo+aB7PL+Z9VK2gmCycS1hyyhKbNCEcMolm+SL+117880kLWoOE18ug=@vger.kernel.org, AJvYcCXoKnbpIkei8ZU2srCNBr7rq8gArEe5qfw6jSS//itn0j8s/g97OSPZ3NI+cLxUYuAxpMI6JyOIzXyN1QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjhX97AcIazjAit0qwdR252WYJrYe+Df6DWL6T1twsDaCU/gn
	zsZAgi5NcppB/rxR+n7CrJ7/rp0ddD4LJf5rNQ+93dX9/nioEHws
X-Google-Smtp-Source: AGHT+IGZYzWbE1pJRcoyjYFbA1Ua9LkybkjVXP58LxbxPMgTzA/Wi7pXBn0z2FSPrBCh2tWMrF6DLw==
X-Received: by 2002:a05:6512:a92:b0:535:6992:f2c3 with SMTP id 2adb3069b0e04-53b23e684e3mr1843540e87.41.1729796893136;
        Thu, 24 Oct 2024 12:08:13 -0700 (PDT)
Received: from localhost.localdomain ([176.106.245.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ef52sm1438249e87.279.2024.10.24.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:08:11 -0700 (PDT)
From: Russian Troll Factory No2843521911106131646113453137919440112706319275011777828742997520352230512502114345975733522649412069169501286322423657199205879 <vladimirputin693389@gmail.com>
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
Date: Thu, 24 Oct 2024 22:08:08 +0300
Message-ID: <20241024190808.14541-1-vladimirputin693389@gmail.com>
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





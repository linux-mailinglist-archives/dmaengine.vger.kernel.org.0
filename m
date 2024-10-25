Return-Path: <dmaengine+bounces-3583-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93079B004A
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C241C2236F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F11FCC7E;
	Fri, 25 Oct 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="q/qrI706"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFD1F76DA;
	Fri, 25 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852617; cv=none; b=DLJUC6/3KjdWO660bW+jexgDkD9MZH8V9hYNyfuutQ0wiOF0Q7uq4qyYmdSvxMGxRCsWJaeHBIV0F4wNLB8cne5bDdj7c2FU9G2HD5zw5V+duvJ3FXxUR5erMkubVTwaun1PG7csPYnG4FswXETgk+3Wz8ogtp0zhzRt4213DJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852617; c=relaxed/simple;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wi1j7ZMwZgRN62g9cTnfJC6EkWlZh6VEMyM7Z6r4LbRXfXCg1YV9tn3iasFGamXv9cG7sOVAbe7DjTB8NVoS4BgInrPYFILoHKw0dkFDt66I9dFW+bX0xXobJfPxmuzX9qQljqcTk0B5IKa+rjctVO0U71AcqVGC6XNNZyxJxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=q/qrI706; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852596; x=1730457396; i=wahrenst@gmx.net;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q/qrI70695V/9bTDqyidpR3DqN7SvtuI9udN3qlYdVTHhjTe3pdXukCgXVr4eSZT
	 oVpVSWvm9Ht8gJZWw6h3QFcW/FmIZvn6x1IdOeioU5edI3X9axkQUaZ7MR3YgJWAr
	 zx6prtedcexgJh39RlANFrBey61daP9eSO6kyYmiDdSpdYj3E5KxY+EI3YfqL0qCf
	 B5FAXvAWQc6+wmANqG2oK83TG/NapT1C7OwePVWRlDh4bK5uvTLsWMsEUJJDdI42e
	 PDpB87erwL4DhJEMrtWAEMgZV2OmisPUU2T9IXxSzIhyeJimpVfAFdK0+1uGor7M9
	 lIyWrRTn32WWWWA19w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1tcWVM2Kx2-00mIdc; Fri, 25
 Oct 2024 12:36:36 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V5 9/9] ARM: bcm2835_defconfig: Enable SUSPEND
Date: Fri, 25 Oct 2024 12:36:21 +0200
Message-Id: <20241025103621.4780-10-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025103621.4780-1-wahrenst@gmx.net>
References: <20241025103621.4780-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SXjQg6GNw0ZSmSHqCIeG/A2AkVfM9T0ww/zGck0+NtQOedM3JmX
 nhvnTRKK+Jjft6MtlKRLW/DprsGs2O6qwPDtcV7LmsT3VHJU2mvgDnoWKG0zD4F9S4r+ID5
 y96ms+DyCXFaM6Gi5sBPfDPI5dY2bBqgdan7D2XSLY4t6Tqe5hKlJ7GM/BV2pqsol2Vd6nF
 UVibuxzjEiygkJgZnD+RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l56zcNjiEFw=;7BA/2Q97vKnLVe4tWhxMXYjl5WO
 Vf2oL5llpTDWf8MMu9SWofNzQf00yjoNfDRWjsvmbB2kSd2mfqFBGvWS+jobK6SYQENAU1GFv
 E7gqHgJAGhKJAt/rRfh6ye7918d1iY+U6vWOnntYrG3EZa5tPHeHrSf7NOrxPicSds48iRbLp
 vlODfPnpmOxdJ0i0zGVig/ePbLUQq4bgCKTofjkbvSLQ6B8a89bskm6TAF27lav+yDu0/Q274
 7IRz8Lmqengc83zCrSgBNXGVMhF8hicywRZGtIFwLkowDcLV9wVLgSabxW7Vo7cJNviWWK6IY
 TcH4MpqCX7elZEHVdQQpkvxhaKq/l6hcKalsfVKs8dDzEverWVdhnY4WZDw+9mKOxmpLVLvI2
 IP/wpO0YsYmsB2LIq3zJwHMZNOeab8EJmmK+pBwpBHovOFIETtV5zv/xvwbwctN78nw/MkIGY
 Y+twbeMLVUmzBNKzW3aicYfxswcjucU/Q1+wvb6wy7wTsEWWwq3cNI6aEc+T0vUHwIxIhZsvh
 qm/l3gQD/KHna78N7aKm6eXugMekG5JxmkqplrP5q2dhDf8esJgup8JnyqknyBtw8ICJc6+57
 qmpk3EZ2ul6gZ6Rooe7wpwFQJ0/BMTkfcE3YtaJBZ4gAo2ibh5ysM1SP/qLaJ0a534K7ago3R
 66F+hWNXMva7K2+GU0V6jDxSMGEG18oGYRQtP9scz74H1ctu7pbv2aib6pFZlsIxrWvc5MI49
 QKF+weCWt7mRfrAUZex0E8GSHrQ0BaI80FgHvdi06pu4LAWmj82B98YdVIJGMIAxjmhTm8UgU
 iSWTw800/7Xf2LzAuNtCGITg==

Since the Raspberry Pi supports Suspend-To-Idle now, this option
should be enabled. This should make power management testing easier.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
=2D--
 arch/arm/configs/bcm2835_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835=
_defconfig
index b5f0bd8dd536..97632dee1ab3 100644
=2D-- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -38,8 +38,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dy
 CONFIG_VFP=3Dy
-# CONFIG_SUSPEND is not set
-CONFIG_PM=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
=2D-
2.34.1



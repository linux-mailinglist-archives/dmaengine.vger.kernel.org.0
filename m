Return-Path: <dmaengine+bounces-3558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900929AF38C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22521C240C0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FF217902;
	Thu, 24 Oct 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="f+sUdQPI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7A2170CD;
	Thu, 24 Oct 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801150; cv=none; b=jjERx89tsiEUFPPGrpYsckUfoKMtRnJZs3wlIQx0DSB2QmOTpWKuYSzI7CiK/P/ROvOh8kmQWMwfCXzVZTVoW1eGJ6EBBrUKEVBlAxGLncu4wkx45zvOgWqkCCyfSxXKF4Ixv9Poyeshqg4znXh60ORBg4Pyl5BvV4j82qcti2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801150; c=relaxed/simple;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyqd3qQCioRQAaV5aqHIimBclOHbQwSYaxm2Q4CPXxz7ja1YrOz3mNnkGtpP5GIbzlErZb4P343saDZ6FI62uFuxObKc4UyRzvtbzi2FOc1P18BuspGgpGqvSIVCNOWM/CRMfszBkDeWM3r/CpSiI1G+7UAVa7PCAy9m16AEdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=f+sUdQPI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801129; x=1730405929; i=wahrenst@gmx.net;
	bh=EIb/0BVQLAIWTGsSf2exEUrI6S97uVc10LsFQOB7HdM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f+sUdQPIrpLcefcW9v+loVnd4h4gsck8HNCHWcpP3Nfk99KiATs4QJkAvJEe3rDS
	 MhR8qm9+EjTb0Bn25PBmJk+tmJBk3wdvAR4ftaA4J1rfuXWuoAmbBznBtQvnfJxov
	 lvCk2fawLS5Fzjmjoach7C/8405fkKde9SDXNrCQ3xmmiGdd+NpSc+HpMtisWIUAC
	 xIiRpXBU7P6NATk3Ss8GOEE0fN8p5D45EVZG2AGlGP9jDEMt6gftus+iGlXNzeiSR
	 wGoH/n62knbVqXDD1nVVO+XPpNCb/Mrj+zGaRVlRs4CM7ubmZDFWpIa/13FHmjTqz
	 kvE2ApD3fC9hxOd4Wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1tGFWf15oq-00HnTY; Thu, 24
 Oct 2024 22:18:49 +0200
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
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 9/9] ARM: bcm2835_defconfig: Enable SUSPEND
Date: Thu, 24 Oct 2024 22:18:37 +0200
Message-Id: <20241024201837.79927-10-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024201837.79927-1-wahrenst@gmx.net>
References: <20241024201837.79927-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y5qs/K+Ex8uHWt3Wttf4GhkVYRu3Bxw5179FQJlfcGye3NuYOCR
 rlCUl4rYbHCkDTE0zT9u2NBAmL64Jd3QihDV92VlvKRtbLca9N7WjGdTP+QyH2x7mUabJqE
 qKI8xvSwgeKpTl+BjWz04YJl/Rion2QY3C3kJFsI7qAIXd8TStmqJgWB9Ej+XwxUbdD61rr
 bSuWGu1IT+G9XL2uAuhpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Bqh0xCZoz8=;7qu7RK6hWjZs3fljgjsKj1/Vyl/
 ykqWpTFJZT6uHKczUlyiqZovVrD2KIPNEp0uF+KUvU3Pcr4p+1qvKIl2WhLYDVoVQANhub/gJ
 DSWWnDp26eAVcntEruJm9YumheLecR/XB8j2naIuhoqe2bK0xe3cWgPo7ddT1TxOaDzlwU+mH
 pgvVQuT5+rA/UM5/lVNeBr/jVwvcecwyu2sOANNkqqgsbNXb1u74ib8507/tD0zPFG48Zp3vu
 OjA2tSiHoS0jfCSeJApf0016KWwsNHZ0vmxY5ZZBnlNjiSNyaLepHBIZ/20My4rKWUgLYB/Au
 URUeJRmHdl13QDeXARorbtntR9IYMowWYzdra0luik5WeyBe0zcGWvc5B4Cv8WSD6LAWWklIR
 Jc1KFyEbXpURxZC2r974fDURffxx4SHi3FkfBVmoKwl9qzV7Jf+1iO2eY0BIPP8DR9yRLFmT6
 UChhtkQtAePgVLuKYcIMvAmvfaskALwQTB/QbEIaHaCbPN1/1yPWrKTbl7SXv909Ep3OA4J5L
 SEoQJSvvvtI/dy/NapCw/qu9g9jA1Xpapf6tlm5TW7EvCuNlJ6c30LzxxHqJLpzrNIvDkoKfB
 MWclfuY9e56KGJGoyCTlLXdQCU3mEl2KUcd0wKK3VLXJjTgtqBFFKaDVQp578XkBHGKrLLGjn
 FBcQ2J+7ZSvzLGnd0et8UhCimlOghZ6q0/Kb5kEh9j9440wrf/KoVQyXxJi/WYQVq3QciNCD9
 M6CWHHltYhrJbFNz5PEC2fxeiUG7xH5w3SvA1ui+Lj2QSYFkJSkXWxHy/LP5Kq/LjzP1QfF2q
 n+HGCgrJRdE1UOdQsZo5bnEQ==

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



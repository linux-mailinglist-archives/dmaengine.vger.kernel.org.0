Return-Path: <dmaengine+bounces-3554-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA899AF380
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BE11C238AF
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF12170D9;
	Thu, 24 Oct 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UgcDTyOU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394022B650;
	Thu, 24 Oct 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801148; cv=none; b=bSJHej7MnP39QTfh1IgSk4+fx8o/sTrMcY4GMOVXbDM8rf2NjnA994Lej9snTpgjNuKjOudZgy1hOwielEmkt+bV7di9hq3iPE8AOwMDkNkES6zPCQ4kVo3Y3tZbf1lzZZ7Ni1Lib4j4hyyI7ifYYef1EjkjPqRyDm+Sz5DA2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801148; c=relaxed/simple;
	bh=M2oHeB+WOJwn9JLMEYWUmv8S51I4OUTUIuKP3pPKzws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIhwUAO2x/512pGAqUyJbUodihYM7GEGrBr0/qC3O5eCz7rSAvfSZ6LN3kXKygF4eaYNw3TDTnas3KP150lQQJEw0xLbeTtJQ3HpjCvO6fdzLyAs1IO+7NKRtCf+vDMJO0KTJjoaN8cXie+kr+IpiYnPdfuLLhvejO6TCoDlZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UgcDTyOU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801125; x=1730405925; i=wahrenst@gmx.net;
	bh=v+14rsoDnpAU5TPVahAWZNaZb+eP4NYQnwXlsAb9tek=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UgcDTyOU5bSh/Of79AnlYW2C8G6v/KE/0uWp3LwaS+2sqDjpsumWPc1ecW20OIax
	 hHzduJZHohBslNz6BdvpvcK4W7qpIptZIMKMxo4sq1mpFodYQnzt8f/Ibe3D5owFl
	 OwYmfZGZEOVtfXT/lFQxy/+CkCg8jm0zPlV0waE5jHxjFLfycWr2Bga76xhFpkcWy
	 9w3bUncR87f7knGrWygBhXOoKY639eSmDMjX2poe0/crWdFdmBeN3u6EVKFT5ILZ0
	 sAQrsVY8T8lkxHM0eYqnQefxySVZ9F8dr4cio4TqeUvO4ntN9U6rvsUyJnQt46i0l
	 amzgo/brHTx8pWC2Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1twyC43LRo-010j8C; Thu, 24
 Oct 2024 22:18:44 +0200
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
Subject: [PATCH 1/9] Revert "usb: dwc2: Skip clock gating on Broadcom SoCs"
Date: Thu, 24 Oct 2024 22:18:29 +0200
Message-Id: <20241024201837.79927-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:PoFhx6WkBPUO7pLARqsqywTbLY7iieU0MH5b7d0DdfFeMyOazVo
 Mu56Lc1LhP+2/40RmxDhm0iBfV4aj2TJaNQdfgZCBspp9FgEHwaA7cUDn2tWA4ak5i9qNuA
 Rn1Fzj45z2VgnIuahh4hiksqiW9DaE/bxVdC6RB4z89CtXfzfZ9pu/wZX/yxxB03AQL21AF
 jk25RXvuolTepHkR+oNiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I8zVc3auTtg=;cId+YZnZj+DctB2DlOUivtlkeoa
 ducXA7FUpTt0qSb2hc9U6KaZToeZhHSNStRCCMf1Cye1+c08UFvOpPa4wPj8aExUhmSzA4R44
 0vRxuTayMSDIy+BMxp+LO8xCYemeOK1LTOq24TELfudNbwMV2NJRoK+O4/JTAJ5RJ9msAt9r/
 80/Qn/H74CcArXtceabruOXR/mBIldWMm5VdcQ9yIacwatdoqkmVLn8XDXc1gQrOA294BXeOw
 y9arKXpEgB3Q4MTxqg5R0FfQetMjR6OhfI/69JYz0xOSy/sAJcFyHrW50kZt2KvG0EmQWCjKr
 roknfVV4Tz02lH1pFj4s2mvp8Z4l73eDWL56LF2RWRk2knT33iNcIYWFzwKbCRYRkRJ1DUiUY
 LLWpIA3hLYFvfsj2f1oSrh2+BwgGShutOafeGXHy8/+wuMe/a6jtnjMwoTzLmULWPF6Sv90Dx
 127L1SNJq02h0dOeb0uno78azOCDngx/Wp3ZnvnlqdB0FvNTbsWaC/OXE15FV4/Vvd8VtMUsM
 kNJQOvmn1YqPa2mkWVV7nhaMRC7g/AssBXjYX7ob+qM4T7WWjARm4WTptbp+d/BUo62RS40dN
 i0YiU1dyIbxIV5vb3NwAUjx/Q/tLLFKliS+jCPNaew9dv3TvtgGgKYJT6eP8rE3Xc1bybD5z1
 304Dcr13+RulTZ05w3YkilQ3ZIeUpWFrMU1aQJo3Mq4gaPa6lYu9fEbM/g4ky2nGGoBfJ2FBx
 63mjKnGCcnCQxX/zrxTNsg7eXkdLUD/TDdzOnIlXmR35OKaGE0bsBSF8Q6mO9MZxGNkJQw7hq
 BxPPXRpw/eCjR8O0nt8IVPYA==

The commit d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
introduced a regression on Raspberry Pi 3 B Plus, which prevents
enumeration of the onboard Microchip LAN7800 in case no external USB devic=
e
is connected during boot.

Fixes: d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 68226defdc60..4d73fae80b12 100644
=2D-- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -23,7 +23,6 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg=
)
 	p->max_transfer_size =3D 65535;
 	p->max_packet_count =3D 511;
 	p->ahbcfg =3D 0x10;
-	p->no_clock_gating =3D true;
 }

 static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
=2D-
2.34.1



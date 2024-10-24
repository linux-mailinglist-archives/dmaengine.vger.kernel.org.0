Return-Path: <dmaengine+bounces-3552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6A9AF379
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9610C1C2335B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39321643A;
	Thu, 24 Oct 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iizMTzz8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6EB189916;
	Thu, 24 Oct 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801147; cv=none; b=NydYeJTVfvAMgy2aEV6ZmHMeH788erUZGJpv7lY+3otH8sMkk4+LYftlRtiL/lZFJ7AVmKdw2b20mbw8Mqt7bJEQ9c/UUo2hP4MwL9+uc/8LyeZmxgUqAdXLX9ey+sm4YpPk/WUvNQBxsfx3u4TnGNTohxenlQAjA7QYFzlZZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801147; c=relaxed/simple;
	bh=YB9sep2oCN35bAcGfSErLNH5swAiXAI0QKrxaK1mf2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3ghdo/4uPH9pYKHsOFCZ0uootY8uo9SBxjNdYN5jgz4acV9VmN+0gzU26ENEJlllXKvAlSjghsgMlwPjDXVvCSA1mP3GVcBDBw0nvmIlgD6LhhvOuZi60qpFE6ERPdBTYBEMO+yJ5kEN4U38LLTgIEdFD/SSH5kUv9zGpudCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iizMTzz8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729801126; x=1730405926; i=wahrenst@gmx.net;
	bh=kE9FPbtpN1gptfSk3BViKriGQyJtWlX0djOx3GlUBlw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iizMTzz892WPd7YaLtaujj/lOy0cUqiiXP+tEw336uO6CZMXHbV4g32/L2EZo13g
	 ycMm1aSQa+ShVeLq6o7h2EUmtU6cdSpJES7tCSp/MU3m80X7/mOXOWbqhPLD/6hBH
	 sQBFLkkPQN3j8o68Spb0aTw0UBDZtqTr46ygYljc3uTWQucd2OeKkU6RA5mefcqAu
	 GrWPJchlOzqtzUWSXzioXOFN4REO0T8cLZvnYGU9ieU7CxaTLgCV2TRMAZ9znwzCF
	 FHhxBVEbH+XfEmWunQyHtji80hIEpSws+1yultzgOrOzgpG79Oh5TlfX86PmXluRR
	 jxntSTo4JfdGgdvy8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1tkEjD3kbO-00n1jq; Thu, 24
 Oct 2024 22:18:46 +0200
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
Subject: [PATCH 3/9] mmc: bcm2835: Fix type of current clock speed
Date: Thu, 24 Oct 2024 22:18:31 +0200
Message-Id: <20241024201837.79927-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:ZHnUj5N1ri1FpgNmvmUfKpJ9EiJQpv1kd+uvgbTIUstY1PSxrly
 8HeS+/FhbVxKaaRb8yQqTsJcZoJHeNKOf3U3evEWVJjhnGE8PNjuuYVdbuL70ociJQOLGm9
 caxShFkJTRZeEVpz1IlOnpJcVzDc7UBxGPcke2XHsrX4Zdh1pn1m2utJkd1Ne6JIcwFcexU
 YsE74od3LaP9yL3cMaOOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7dNHSwoAxOw=;Ok3TtRcyjeVnY1CYGL21gL5LX4u
 pVP7Lzl6Oe4+cPYtXju8zUfZdE0pTqF58Q685nJlqCu2JWSvaCN2S19czG+V8Ms3fRgjZbcOn
 qdVL2O9+14D+IIsHjmOb9WYMXzNEUhwoos/V8PpFqqLsxHqaWGAp+OLM5Df5CHvpr2rAyOUYg
 1XWUWUXJFjoIRoW1XQL+GXtwBwsHypTRqwSGu1d+RJb+kTcuAwfil8fzR0XoPNVi9YsfT3fBa
 7ZC9/TqV5IF43qX8FersJSEpFduFvJSi3p0VKxENo4yFQLIRZ8ryIm40/1dNKovLgL06hFHA2
 Pn5lmCi5Z41ci+vIzH2Dl9hhE2gu6bWRPkhbRHzMmMeXczmo2G6Fk+OkoiZeh6Tu9fnw9AtHu
 Ud4tNzCj2ArdUpUNCO00kjqqxEgrZNYiEBThjMxKyQcphEz0rt1+75VMekALKYocyeS1HTk7O
 vI257JLeoXtln/Rz+cU2iBuVsPJrTNOFcQRODa6Na0CuqpGawb9JKtr8Uc1IaAAOXt+OShsGr
 yj4hJ5R0wK/zr47cu9rsIeSSc+5PDmeaTTbyNM/OMG9TQrnKH7BkP2VE8H2dgvJmQRzb2UVY5
 +rdxeoBr7SGI9n2JJgnrae4I1P5RY1JXI5f1u4nfz2CUQFtKTI5KA+xaPgacxWTAaI0Eghqn4
 8gDVPcCaPdnxVgTThrgHzgLOlcpvQn2zPaCTVSfrABivY6Wx/xDn0csGPZZAnYmYA3Cd4uYrE
 UAmAdIf/jAMFDB23WW3lmmLNvCUItAcGgPjV57+lO88mEeA55czVEHvpX4xPi0Bg3F1fa0mGn
 +rT5/+W06U9lT9ldU7qlla5w==

The type of mmc_ios.clock is unsigned int, so the cached value
should be of the same type.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controll=
er.")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/mmc/host/bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..3d3eda5a337c 100644
=2D-- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -150,7 +150,7 @@ struct bcm2835_host {

 	struct platform_device	*pdev;

-	int			clock;		/* Current clock speed */
+	unsigned int		clock;		/* Current clock speed */
 	unsigned int		max_clk;	/* Max possible freq */
 	struct work_struct	dma_work;
 	struct delayed_work	timeout_work;	/* Timer for timeouts */
=2D-
2.34.1



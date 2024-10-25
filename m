Return-Path: <dmaengine+bounces-3582-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EA9B0046
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12001C2277F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96F1FBF75;
	Fri, 25 Oct 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="nimaA2Ha"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E01EF943;
	Fri, 25 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852616; cv=none; b=uRBJzvRngcYizmeyWnfYKzE/mrzbNdgqM/HFdbhcdiMM1KC2sO7mRGadE0PYq90UGqxDzRdEWOIaueBXR4LkcFkltabBUTNtyms90tmxrLsv7pxVDE7zoiUv54NFHtaooB6o4OIkLmiyAWF5+MBlZsROIYKJFOcilytlTG0rmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852616; c=relaxed/simple;
	bh=YB9sep2oCN35bAcGfSErLNH5swAiXAI0QKrxaK1mf2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sla3dZNNS9LcgHojHRQI4b7bJ52/9NII7T5BYp/V2GmaY7KH65WYTu/u7s6ANAGJy3olWKEM6OXUVpV3cvQEu9SH8fyLWUxYeC9UDeSARHo7xFHBNr/JxsceULAjkyLqyPzJUhxxvV+EHUuDgS+IJCvHnu9XRGymPvtXEUOTG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=nimaA2Ha; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852592; x=1730457392; i=wahrenst@gmx.net;
	bh=kE9FPbtpN1gptfSk3BViKriGQyJtWlX0djOx3GlUBlw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nimaA2HazKryFAo61mBKF14k6YYiPaV7xQ1fZV9RdxaU30jeL9pwWRcjUVBnVhwr
	 HEPyanwkh25JNv/mqUtom6TV/ZHQfInbegDHUMAbLGSF0jNL7ufWSjB0R7G7cwnUM
	 40tyyHPgRYJxX7Dv8Asdo+2bjr3mPXAWg+tfd9MoIp5311149n8dfiJFis3hdRcE0
	 woWCsBJPmK6vQaoXSWpDweXkNrQbNmnXyIp+M26Isw40KiIeOzH/JXQraqhin+LTa
	 PPIV1EO3MFJOqR078ZlUj0ZJPFBJuuU5RSeh5xUnbm3ozhCujZ8KKG5XDRLh3/RoP
	 4YnEV50qeFQuL9zvvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1tM5Y72BwV-00RcC3; Fri, 25
 Oct 2024 12:36:32 +0200
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
Subject: [PATCH V5 3/9] mmc: bcm2835: Fix type of current clock speed
Date: Fri, 25 Oct 2024 12:36:15 +0200
Message-Id: <20241025103621.4780-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:unuppcKVWCelo/CPxApDW+wIc1GUoX5LJis6Za5+ejJZaHISsel
 IrRzfjqFWcMwDfIXZpLa+5lFhoBUfSvGs+EAIPExq8Swhcg/G+lOKK+sCLeIOlj3cDjrA9h
 IjTu4RRYIfyAfpffgtfG55gnPNU5ri2ZIGBLzasCgjtpy3YjxCWxikUpJ8x+bOOQ1ay58pn
 VLYdTXA8JOHka4KiQFdBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mki8rbRtU9I=;jGGeBqmE9YrFESl0962y8sxY9+4
 KRxp3OeEGgrFfERPShzSLCn4CQi73c6JOoQqGjCmjnaBso+sSd3JekCaBRULbxdNRGcI42LJV
 vW3ORJVwGYYiSRE6Lj9MUSOaLtFMQ0LbpP8Ek1GzChGPM0f+FOHQzGBEVXKYFZqrLHucy4OYC
 LKYHX43b5+1pILA4Vm9G34ZhfTGgj9KvUKt56wU15CQIp3oeJVF4mWVytFey+Ac0ZMZy+P9SQ
 S9HYLjSr8XuPE5Q3vqWm2NY8b6LtErxRPV8/9wgsOGkJVsuODydkZGXmE6um+lVGc0CaJZENf
 vhIInz5m+vSloowgZ41EDsFxVcKhcy2L5eOFt9p420KiWqtj/gK7btr3tJqgNOOhCV0jUEBh0
 jTI4068OPO1zPMSPchXJg7XVLYLuzPCUVdANo8xe0R26xwepxG8YyQahYiaptvwC+qZ0Non1E
 kUpeyeSMioJJtCX2KMuEMdr5XTW1AP/teLvE71Rnq6JLeNJEWmZdwiaS5hey9sz9TiZ396vC3
 4FJq4lZbsZ153EflsJoCAv+NSEywJ+3dcSsz4z+6E9oOh8EIMqLy4f9dQpa+p1u95v16CT7o3
 QcTRfUW/zkXdCjCmF8LBMNszXBGXuE9Grhfq2v7xExy3y9LDzdBUILZLAF6uVSs+gJ0vBTNAx
 3Pdoo25rcA3ponjBezNsunRlDQFkSrdWOtRdBu/Dp4s07w+trqJfAwF/JZTDrTqvGyObWiOgZ
 MQKZ4HPSF+9gjHuLKmeWvxH7+/A6DcRdJia1uxwJ/L6DlrTW8n1+uxzsLJZ/f0vGJaiKU6ogE
 o8sFCbk2+OAgqFZZ7nOBx/ng==

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



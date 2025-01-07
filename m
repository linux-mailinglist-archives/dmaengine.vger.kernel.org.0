Return-Path: <dmaengine+bounces-4085-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66136A042F9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2025 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958521883F7A
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF81F37D4;
	Tue,  7 Jan 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qerTNdLK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603D1F37A2
	for <dmaengine@vger.kernel.org>; Tue,  7 Jan 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261009; cv=none; b=CA/SIzRJUMLHk6Yl7SUsMKsovdk5A/3lDdAJ0EE+W4iROCWDFFeFhArCY+3vwxh1/sYdWlo8MJfd1/1Y2hQMUidmD+X43VccMRNCwvrhwehpwxZnbOV8FQmbGQPJNj0fJpZfLWjmBQv7boUtJAszbax/fgrhjEtPKlBmZ7ExcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261009; c=relaxed/simple;
	bh=qnrXhGpjWg4oiCCei7G9eYhGu0ZsqmNtZoYPw6SRkCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TAn+rhM+xfOp8eTZVchts+RrW1fly+Io/BnI+TaP2tO2Ml5SYzNAyV1C1XHkgRvit4wOnkUCi8Fjw2MvcEciV9hEEZvHMHOK9M7TTVxC/phXN8Kr6v9SSUMXe0joRiS+MHzG0lpf57XD6LzxiyKm8yOWU2NC0iz/HNHSe+9dS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qerTNdLK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736260983; x=1736865783; i=wahrenst@gmx.net;
	bh=xFQrLDTViZiWjjLwQVlNYwRn2uOyZ5VxY841DFPTids=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qerTNdLKnJODo0IAcDcHdLdjtWBUxvJ/vL6yi3wbgYo9BM4whLcqz1Ule6IJYlrj
	 +wl0z3aUI3Je4P51c8jek8vYfwI8DpmL+xGbFPCdXtEcmjzu5xmcH3uMzryPdvCQs
	 hDocgY4/GvqB+vPanyu0PgSeQOdW5aDxYnM1L9qn1MOl06NQuEW3lowuxZRf1kUUf
	 QMny1oVHuZwFa2HB+tUwhmYF1ThTCKA8rxr2TtIFKOfksKvFFg3ln9GfIRFeq+QxH
	 MKYXQv7qVKSCOuWqO5Qo0Nj/cESyzqz/prfj78VXe6wdZgZclZx1JkrNpx+e2SzE4
	 s/5k5oCki/7bVzhMbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1tFRCY2Rir-003DtV; Tue, 07
 Jan 2025 15:43:03 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
Date: Tue,  7 Jan 2025 15:42:51 +0100
Message-Id: <20250107144251.101912-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yaUVsQbt7GfhhXIzcKOAAYXvUn+Gxqvvxu3vaUPmgoFX97FuZvz
 TRdBZlUSEFiJcAw9u/qnM2stgu2qhX1vQ8YwmksopHqHq5m5HYrCuIYwDf7XFxg37SZ09dA
 KhP3pO7t8XtHc6voxp1vIhwC2Kkbodtj6vr2NVGlcWo8Eix0LaUUJ5FMdbTRf7hTCFIiBCl
 xupWDfjQiyUyTWjf/jw/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1hi32d8l5AM=;ehhMs+rkxrIDCM4YSyzGXIMljnO
 efqXWFYV4O/T77I4k/H4ycCMrBvya52QOXm2TlUAKnJESpQNmlqMUrRClKu/AKOQx4y6xh/rx
 dtmy3v9j6waTFI4uj59AP1MfUcsLrK1O4X9z3/i47Gwyv1L6gQZ8hfgEyJ+WvjH/cCwqyW7np
 GdAi6Q9VMIgs3Z5GoJbwnubaesyZD0njAOjxzw5LOuueJ8CkL8SLugYBUoTXup+drG5XpKEyD
 axylYW/gRIQxz6MscUadIKB1rvBgoi72bpSd3MOboALYPZt7ER0CCSUnkoRnBCjRPsPegGbFC
 yNSWXp8G3d9NYym+QoTXow68wQvFrhlCqRIjX6P7nv+f5MR2VCvItspLjBXZZUiaaiGkONydT
 DApPlgllVpIe8h9z44yjH5fzUs5ceWrG9Np9X2EdaFpnxzim6rPE4yX+Yghxdg3Ljt1q+c5sO
 rsc8E0NR64pFK6zn7WzXQkdHTj8Lu5fdKI0uCuEML9ySZY5bIicr4L5L3zCShXbx49X09m08S
 UcuRgCTn30IR+phioDQ1kf3aRMiD29NGUdiAmzy6q9IQvTVrvjh4RUcgWthAYNTqXBUqIuNPx
 g2gEH6Eau3AeFFH+6MgJCKGkemy2YszXPbm5fcxIznnB2iH/QZWpZ5F5UITgFQlheisOV6wvs
 ghbSuCdG5WCmxobdDse3fdPdQQHgpygTHXN0M0RTaXxxYS7q9V4LgOXEaYfXpWZoynieaR/ya
 a8fyaSJ293QyABwPjWXyG9i0IJD8XRBIWZyiC3kiDAMXlWcJ8t0KbQnkUHH7QwS/CnWIc1fU8
 9RIwdiVdwi5larsnClLFTpi7JJZ03yIMAWdxqrf40jVDDxInOLV91BN/4/jnOlllKcVrTvFH/
 D57cqQwFkbiEd0kE4bFD7OLkqVhgL6OmHidQ02TvC9t4fP0Ad2ESe3iHgeKtLJ4BlQ9wZL/Om
 pnDJbYfSGA25y5wWpsNwgYhlvODvQBr64mW57S6f8gZA0PRe4lsjCN6+IyWu6r5oTA/arKnHz
 kmGbn7RanYMMigKjAL+RsTHpFxlSLwpOtLODw0DZGRmlTgP+ugL5tcih68yhgKiaQNiXYsRqe
 Ubr72kkjhjPYD3wGOnKNVDbDUdSqkI

The old SET_LATE_SYSTEM_SLEEP_PM_OPS macro cause a build warning
when CONFIG_PM is disabled:

warning: 'bcm2835_dma_suspend_late' defined but not used [-Wunused-functio=
n]

Change this to the modern replacement.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501071533.yrFb156H-lkp@in=
tel.com/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 20b10c15c696..0117bb2e8591 100644
=2D-- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -893,7 +893,7 @@ static int bcm2835_dma_suspend_late(struct device *dev=
)
 }

 static const struct dev_pm_ops bcm2835_dma_pm_ops =3D {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
+	LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
 };

 static int bcm2835_dma_probe(struct platform_device *pdev)
=2D-
2.34.1



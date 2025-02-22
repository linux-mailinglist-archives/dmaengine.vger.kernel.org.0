Return-Path: <dmaengine+bounces-4565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A07A4072C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6473A31C9
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EC207A22;
	Sat, 22 Feb 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="V4dlGSCi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDF207A23
	for <dmaengine@vger.kernel.org>; Sat, 22 Feb 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217849; cv=none; b=ClZsZgPMDnVidx3dPBru+EFaXv0yzM5t9QkqFx5qUDiGvvS7K333vJWau1anw8ta17myCob/0SkhCy3w/oeR+yQJswKEAo8cwlw0bpaWeUS3O7NlmoRVWit5h767TuYmBYNgEmqPH+3iP9CQk2kFckPBCwrfKttNdwvDQHJ0Kxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217849; c=relaxed/simple;
	bh=qnrXhGpjWg4oiCCei7G9eYhGu0ZsqmNtZoYPw6SRkCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+vowC42RLdwtwrRlNLvkkF/Bzvt6FsTqwCEx1A2WcsPP5jNmd3U4+D7JwcVuYIDQcHuOBiInn95XG46Ifkp7RM4PT1W3x9dge3qEmKnEu1Th3LaUgQa1jY9OJ01vdhT5QuLfOZu0D5SBqUDhifW5RhEVExQfDjCJEgP4O+gfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=V4dlGSCi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740217834; x=1740822634; i=wahrenst@gmx.net;
	bh=xFQrLDTViZiWjjLwQVlNYwRn2uOyZ5VxY841DFPTids=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V4dlGSCiHx6lxqM5+L+E49ZrYSKJDgUFVt8zBa/ZIj5KrPXTGEuePqZfQH5NwZxw
	 Q1b6s5huG8ATpsFlFsTFfZsPfJv4evY0rNSv68r39uzVGX8FuF+gFU1bLebeOW/5e
	 3BEgmKdz/1hJs6JLjoP2dEI3A87uDvTdhsMdLBG7BNMQb5EFfJxZ2cyPE2N8TfEfh
	 iLFWKwNxEFQ+w0m68R+NYCbD9F6qi/yQYnRUY/oY6VM5Oc6VtRAWFkOd+BoRIkKJM
	 ZHBzD10jEEzyXB9NI/4boY6svLi5iRNDfaJc5zzU7v8fTa4jT/WT7klbAQQbzZSMM
	 D4SWEJWdjJySCGWvWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1tG5Xp1lYF-011EEh; Sat, 22
 Feb 2025 10:50:34 +0100
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
Subject: [PATCH RESEND] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
Date: Sat, 22 Feb 2025 10:50:28 +0100
Message-Id: <20250222095028.48818-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3nPVxWJTvQffyVtEA2wGihuKdB2cuO9l/Jgj7+4Y8R4+SEPpuQb
 NTo0rq8b5vY3W+Xn6vqu1TCwnrf5CQ7A8powy1h42s+/Fdn7ASETs50IMBWb4u3YJWJ0jDs
 iJcEcpGYssIevUlMmR3VN6psFldM77JHSodwxNOXpjDZTjwqBpqlrIc7bx8DGUKxLUQbtoK
 MXhYCbgk/b46e+NGunl5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:anKeN2AApoU=;w8csw9M7KFpulkVVFwH/BpcDTR3
 TL3AEqayjijLMp8s2uHrStYw471nBYcr3yyoHkWUAVIrkVMIfeiqINIiwp3DN7+MggyK+K7YW
 6R4e3k3CwOrDn+yBZY6LDnR17nYnjYHcQxNKNtJbUibNcMbbY+Nt9pE9MyZI07HUT2Co+eXS3
 TkPLQEqgd2qPH+QW8qI7vz2Wrg+KPs18kxValuaQw+JFXvqqvCsGurstygLPiZ+P2u5o0UoZQ
 T2pIPmfRyPLWieAkbCnDNcI9gsJOPor2CEWpaM7jxGndeModOc7T/o1ByWCAKZAvJA/Zlx5/D
 MUzyZr9IfGTjvW46labcJVOYfN1xGDMldbhV6ql5bQH81OmJOMR5qpEwEPixc5WKBVuBbJugZ
 Hq/4vX7zuh2Frwc9OVzi3qHFp5+ktR8uRQy29Xd27CzPAJse3Hx55VpL/pXBpNvWeU+K086/o
 rNxmU8A/kP8jShEiSSyW/aoJ4f/IDDVEvZoV40lpTtxTDKAthmy8QEf/tbxRAZcIUSuO1vd3N
 /ECXGrjZXMocp0mT9X7jmE3aFx6+/Q1sjbr6rkG0AriVKFUZbz06s1UED5PIAgXqvN9tdMT32
 Isu51ORYhcODj6fYDZqFfoda/nhpJaxT2mWxscxu4xuYdcXkTbp+jr9dxueYZ3nSjWxg5FNf2
 HAtpLBE7FF0YQ7nONRgTEbkz+I+tsO4fhk9O6vFZuO5+u/gPCH2ml9wm/EQcBElv+JsDxG9pY
 jKP5DnGOEKnhJlO7ldIhNjSMGRAy7uixwuZf7ffBAjTczVBqKAlHqat21wJEs7hcxos22gP3K
 irnnl8H5eluvWG8sgO1I6Vh81bqVNCGs/7FYhOaDqLFMIFrIcxtGu3GVC6eqFSvH0HhPQfV+h
 RjXVMkEc6HE7DfeyT64/teMAblGk/q4yuHbCuZx9X8Sj3hV1wJCbXgIoGmsysP7XavqY1kHb6
 9vhsG6Hw5/oEmN2JYVFt4IJih4731bEI6G5y/OlV4SU77D88By5ScYYTiMLIQWVE8bXbxlBiK
 TfLX0wGF25ZLbuciG/ahdS934uzujc6kDUDFi2DGeMxO+tePpBEntL8aCfTm3/qtMD58WN+rc
 Au5PFPUCC24hUrrfKemkRbystFfFB7LrXUk9ZMcjmHM8znowe3+8MJ33sEohsQSvDz3YSdo3w
 irhczxtq5PwYiW9Tz1X8iR5ypAaFrlbo/ZoT+pgu+HCyuhcEOarJb5Y/ISF9orQzG7m5Q6KaP
 A1vFdLnAvCR5h4vc5Pup2zc66xjR8tXI7Oy3unU4hOnb+9LPFXOclsz83YQC8CMVSt8EZ2BoN
 ZhnvyrTE51dPBOWPwNKBZ6TrqbCnQheYehxQE9ASFF4OtJplStgNb7Zzb0y8uxGxY11RQJDoF
 3nA+45WDDnD+Vt64J/KUDwTM+ZjPnGP+RAwEelUeFMk8eAGJaueSLTR9QK

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



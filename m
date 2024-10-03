Return-Path: <dmaengine+bounces-3260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF998ECEB
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED58B21246
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2024 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF714A099;
	Thu,  3 Oct 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IktCPAQR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03251B969;
	Thu,  3 Oct 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951208; cv=none; b=JH8aeE5jIgVRuW7dW0AOvRzOKSNZHul0vvyJiXRNFyg9YutLPZfkmnrGvBeYRDj7tMFAYq8Ble1JlI86Qx5fywafPf49Y8BdLj23SgjfG1fOzbc5HQwtZZlmgFIZeWe6ntZiIP7umdoaohU2GkbHVv5bNXmHIZ+3JjPsJNNHFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951208; c=relaxed/simple;
	bh=xUg5L1FsC7hlElkj9d3y+8S9WZWsnv60Vz5r2Gf41gY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=e+NjfzCt9iKqI4/+RBXiyxxim79dhua/7ngGBnpmd1tvj+tdt+piol8yR2mgDU26VF03Xije+y1r3qcP9y6idS+oGHBU5rKcK8WiNhZK+K+cGkJsyXFCUwdMXzJ4CjCDLRpXRj8i/P+UWSuxNkCqIm0U58e76aFTJmv/LgThjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IktCPAQR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727951189; x=1728555989; i=markus.elfring@web.de;
	bh=R2w453dMi5AaWXjIawX5EavqkP9cJY1Odqr//4eqXac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IktCPAQRUigFhHRRfTJT43DygSGfWlZz8RcxX8MkRSn5tYmuzyCR6t/MhZ7ZBD8R
	 g5kXQn7c9l/VD1iY4tXxAIAABIO4IpFSTAxYI5Oav0OXQn6Zb3Te6Dwk9qpegfbcX
	 8/wLtVl0Odzi97pvm4fGLuoJY0Pu0P0M4nh55x7HC1GXRINQeKvVelV14KrzAxyCW
	 W6bN98W2dkkg5wctrUH2eP5Ws3DHAwRWRFMtc4jf/OFg0k874DlyoufmhLhk8XzaW
	 YPJbsESV0TzI6PV4tLnhRGLZrRBT+2l593L4XwwD7VWhX4T1GPclEr8oegSpRlMdH
	 oZ+lu3PRrTWiMoLASg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOhn-1s8css2eTX-00mtTg; Thu, 03
 Oct 2024 12:26:29 +0200
Message-ID: <4f999e1b-9c10-453c-b68b-1495861d425c@web.de>
Date: Thu, 3 Oct 2024 12:26:25 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmaengine@vger.kernel.org, Amit Vadhavana <av2082000@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Kees Cook <kees@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Yuri Tikhonov <yur@emcraft.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: ppc4xx: Call of_node_put(np) only once in
 ppc440spe_adma_setup_irqs()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wF4pxVDcuHj1rmCiDeCDgSESgdi1hQR/00hO6L5B7vWXltKu8Ju
 3+8DL33chZt3s7kkuClGOY+ADWoOhYVf/+9JM7wUjuRrIzIQkC7RPbju9lbt4JCzAkCZBEn
 0oFMeXQtqCHZQTN/4BdReyzZCJ2a1qXYe+JiSstIlcygWpGURG8PJnmTo1hxa+QWCFHB3LT
 rXce0KgNoBy0YCgFeZUeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jcLQ3ddXnSo=;pUvB0QAL1Ny3FZXliuLFWZn02dk
 llZNIw/09EpEExfh2fjfp+MBLRag/lHKutoIr5EhcanUqixG4DPp+f9cfQRXvOz0vENaQZZOZ
 ax9SEpxKRltqcjQUU0goyoXMVHHlMXjC0MMPoMypUWbTape20Tt7foTOIQ5/YYu6chp9JSc16
 NwUVV7TPiVuDrv2etfohp7sUDB31Ej1hJshaNHXwSW7ZShbL31iqCCh1m0/PqDdJtO8tff6gg
 GvNwhHWCWc9aXiyJMi4KpOeOXqy8TEmJ/bmWsbpqXbGatVkZ24xU1jafKo/nLCgckidrFEYGQ
 0NlyV+PFPjJfiR6miYuATjI80HO3hLLTM8xlfqmGDjTTC45Vi8V4MqEOLZk7I3qRRcqLebabw
 2pZZiJNIaoJ9Od/U/fslatWLxbs+1/hdqL37xnOV40g3ISwtmvcJH+m3tdnt5drNwkwtc4Fwg
 V386FWLaJmAbv63D5ExDfNTtXnyXq9rTAlRktJG8x5VpeVIS0gHSZhprj9ABVTVGn5+8A8XZk
 Dk0PsBbXU4PP9vB2IsGVsx9CIDM9GSdKBsrBVHU/DyZwGH2O71B99L19oOX4aDp6qh6LbMbzc
 9DQpC5PD1YEAI/YRf7uA2PtxQ5u/y2facHi7BMKkNr0FZXTWMaXOGZeJnP9OmLsdhsKl7iQJ/
 1MiM+VD7u4cJvSY28g5GFCOMyfjggsKnT/TzwjV1Obi/AjA7CKlWc4HICiNabOookqnuBwsHT
 bOSKLJwEyIramp+9gKbRwsx8L14e9Eg+1DzzrLZfNV0Kdy00I6XOiyEIGIsa24Yi9GJNhCvIj
 NQDGTr1+P1hRff4Hc6xVY5AA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 3 Oct 2024 11:40:06 +0200

An of_node_put(np) call was immediately used after a null pointer check
for an of_iomap() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/ppc4xx/adma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 7b78759ac734..25d5ec028d68 100644
=2D-- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -3938,13 +3938,13 @@ static int ppc440spe_adma_setup_irqs(struct ppc440=
spe_adma_device *adev,
 			goto err_req2;
 		}
 		adev->i2o_reg =3D of_iomap(np, 0);
+		of_node_put(np);
 		if (!adev->i2o_reg) {
 			pr_err("%s: failed to map I2O registers\n", __func__);
-			of_node_put(np);
 			ret =3D -EINVAL;
 			goto err_req2;
 		}
-		of_node_put(np);
+
 		/* Unmask 'CS FIFO Attention' interrupts and
 		 * enable generating interrupts on errors
 		 */
=2D-
2.46.1



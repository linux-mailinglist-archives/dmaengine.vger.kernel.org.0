Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE51FBA1BD
	for <lists+dmaengine@lfdr.de>; Sun, 22 Sep 2019 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfIVKJ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Sep 2019 06:09:59 -0400
Received: from mout.web.de ([217.72.192.78]:43293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfIVKJ7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Sep 2019 06:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569146984;
        bh=x0xTUVNZ5DZI5aFJZQ6x46EDyr2xe+kGBRm1hkcsD0Y=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=F9WA/lImU+qXyqHyFPmzmVObVT3wwCsbgE0R8rDIiGS03P9RGuTLLUocKU9N+rRFH
         tziYJW8LNFIuCIN9RzZr84BiM5Vqjgf5o1DbfhSt5+WBxY5p/HfO2Cwa1nPZ8ltjtN
         ZogCxyDkrpiy7Omwf/+klkVH2cPKakw2xaYbM9JQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.8.78]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1i4NZk0xOm-0139DX; Sun, 22
 Sep 2019 12:09:44 +0200
To:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: k3dma: Use devm_platform_ioremap_resource() in
 k3_dma_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aaed7862-49bb-e368-3e7b-5cc2c3d915b1@web.de>
Date:   Sun, 22 Sep 2019 12:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kI58SOul5RHBDRAQhyI+cRexLHBkmreL0ZLp9+F5Ki/9/weUZLr
 f2z1MQg/y847feRPM7+2OzrE09C2xpXJCZ6MyC0+OuRtFh1/+jnrVr8ZmyvGGVv2sEpkChz
 9v5wJgRu+n2qBP6fRjcsZkoUt2Rvy+jglC/IAsnxKY/gtFbE6XwDrI+OKcnK94fSy7LG8cW
 LWZxZ9XkTA4nMU9vM5QTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9MPXdxXL8yE=:xqDoSkfR802PUJ6DnILu2y
 HvDUASu2MuVr4St0rc9OjeIAqV9iBwj2jsekmZhlRHVDRIpr+JnZK7OoKuT1LOkpQl47X+G5f
 tvNbbTDOK37kuXqzQ/uY7U1vtfnLL5XH0oYNSPPlpiz0GW2UMDNDPiJ6avJ5an5xg/eKfGAbG
 EX7RGiEKfYyLcA7Lepd/h6397l8SRjXoxuD8IfUm+OdKJ4xTC/uWOuT293I5E/n/D+Gp1BIdj
 /qRhWgNlq0kuByqO7Y2m37co9lbmc4XmwJJsR1jNkCrAUDUtSwbcPr5ir6MpEHnOXpqwBqKnI
 bF4RT8MJ/Ro5qKtmQzaljq2WGMTDTMcEdJC7jU1r5DFZCxpIRvgPC3nglnUAbV3niyWEHIPGX
 y8QpLWy+nl56HX49y9Vzf9Md9lSyMxkxbs6E5BuQA3fK4hqg6MyfUy2UI5zUlzH8DjCg2ntdg
 cWazNNf1LWAgX6QYq0dqimglzbYoY4g97bxTx3qq0UQiUzp9YGqVRAJGJGaVfLcVUeuf0rI8V
 UprEtdURz8coWvDR6/jO7c0vSjR0mBtv+BiqyY2h/ahgvWU8lIKSgZq18dkN7Psj1taumbhSb
 PK/QMIGZH+LDzBVi9KfragCoqW8l8IEFbKG2zNT9kIXls17x/AnxRnCyGOOTLhSM6FA9A4zbk
 zrlyHgDItOc4bE/rynQv/SWzhBMNoeKIwHCfDP9C76ilQmb2afUAKVeqCLLYwlqIE7KMnJHJM
 U6NX9BmA0PiBfeeH3SmnmURrH72mvxf8/41IHaFWs6gZfQBCZ8LojwmfRDrArcxO3wortmnwY
 5BNfUmP5tUE8K5jrbUiqJZmGm1qOweltn8piYg0PL/98/h28d13H4tH94UCu18ngnVc4ijkeC
 x865sMu78BvcaPAk21fyWBiGQ2WCsocOCII5aI6tNQzSOU6zOH1OP8kLDYl/tFu6MalVRdWB4
 K/mMPOV7aw0pAYJl4G+cABOQuTGXBcFpsbfTa2OBbBxWvL4jXQCw3cqiMlB7kjEnQaW5kjWv/
 kx8NJcnQo0bxXSCxbQ+2H9omoeoe4ooMJ9cohZc4bBV8cR8p0yuBprLkC+Nh9KnRIIgmwPZru
 CW5j4+CiNBTkIlXKG/biRkt8Az4rXyZwHMmWqkbIgAIvOdgPRBoIHM96Vq64wHR+WCmD45REQ
 g6Q9d5XPPxg5jChYoE/g0/AQx8GU6DBXQqe0GlvAJ+oSxy5eIbcism2q8K6XhTJZPzmWjA2cd
 B+uTquRWMMZuEtIZVLU0PBVvZpZahuX78dQxsjo+e+KITNzOpKCPqwDUhzqI=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Sep 2019 11:36:18 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/k3dma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 4b36c8810517..adecea51814f 100644
=2D-- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -835,13 +835,8 @@ static int k3_dma_probe(struct platform_device *op)
 	const struct k3dma_soc_data *soc_data;
 	struct k3_dma_dev *d;
 	const struct of_device_id *of_id;
-	struct resource *iores;
 	int i, ret, irq =3D 0;

-	iores =3D platform_get_resource(op, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -EINVAL;
-
 	d =3D devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
@@ -850,7 +845,7 @@ static int k3_dma_probe(struct platform_device *op)
 	if (!soc_data)
 		return -EINVAL;

-	d->base =3D devm_ioremap_resource(&op->dev, iores);
+	d->base =3D devm_platform_ioremap_resource(op, 0);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);

=2D-
2.23.0


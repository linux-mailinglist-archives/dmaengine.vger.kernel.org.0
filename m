Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61ABA205
	for <lists+dmaengine@lfdr.de>; Sun, 22 Sep 2019 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfIVLbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Sep 2019 07:31:08 -0400
Received: from mout.web.de ([217.72.192.78]:59089 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfIVLbI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Sep 2019 07:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569151844;
        bh=kC76RXvfJTy1HZUekXpbmi7oxCJC1XxnD+EiRjMIZvo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EAhfm2pN+jW523GMafYEw+FVFzrL4bDED1EDqskmS/0ccx3hWzDCk5iiOmtFXjNQw
         rYYqvjVDcEmOVI7lkWjsp6B11mizPO8Zk1C1VVQ+1R9lXuAK/sRaVyzGTq6BBHsliA
         4vCzdx4VR6X0O9s4WfsVyAZpqKIKg/xuLX+tb/ho=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.8.78]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9os0-1iN1ch460m-00B38s; Sun, 22
 Sep 2019 13:30:44 +0200
To:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] dmaengine: owl: Use devm_platform_ioremap_resource() in
 owl_dma_probe()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d36b6a6c-2e3d-8d68-6ddc-969a377ca3b2@web.de>
Date:   Sun, 22 Sep 2019 13:30:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DjgGZJ2CdVmeeHm5b7Ehe3aT2ACCFpE86w/u10/ZvEVJMvN2S6B
 sL85AWmfmP8feL8NN/2F8OEGGmyFkFcJHKAIfAqMcIKiW7Gbvk//O27IEr4BpaqXIqqVeMo
 WUXy8jpHqE+eO7/Nof2Wdtq7zO5iq7puvnHjKBq3q4D+XQ9XPj0HY7bhoAKJ5TTQfRNhp9p
 yp4viTOfuHIy9mHlgJESQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:npTUmH/GVX4=:5D9q1T1bl9fyv+TyBzQAU+
 ZiitkRZYzVCQ3nsO34CA9gWtb6jNdFs+o70D0dKiiFS1FFw9FNVnZ4nCTbrn24yHv+wW6yJy5
 hGyhnZA+uSE265JUawOoJeupEDdd176i/SbHbbp+sXX7YYf2CnlDT9o7nhEJyhDlQJIWCMooz
 ckxIjDcvBmb7xEJDqsHKbTd8g6RxodBUIDt4megD2k576r0Ew14ua9B5W/USY8GEf9Z0jOwBM
 3SyBEeT2wIwdfptJigYbEyoM5Fhb7saueupsO7ctJ6oZFDASPqFdSHO95r9GMSzCJ8NjHxiIH
 wNRltuRzrOWRRq0P7ue58HdWNOLmOMm7xIAhTGvVsFvvi93CJoTImJCgA1nvgyngq+JnZJSg/
 HmSZCg7/d95me2LeltV1iBcoMuZ3qG9EX4Nw+r1Xvz/iTZjoh7mv3+MhP1lBznAgB3wJK/9YT
 dr37SikcxFcKN5X4VvrtPST+SsFiPLdARcnGfD8VKXFkyvmuVJZD48l+QGhzErXdwtPdFcteM
 hJ07hn4MJlgSzjNsUqTlRktzIlKZabnm9hm1bGBd7DiWvROmU0mrIKAohgIrQ/YuXoAGGp3IO
 0zc68nzoq9CgRaTCIiJGHMVxZKtyjwH7o5mSpBAgyKxNUHVYjwj3EvIuPVVdpZW0isK+BP8e/
 4L/vEpgSV6KTzRYHohFRxDMLH4/xcvldSK4V4ojzHNKCgSC/Po22hYft13f8Dr9OXJQKzBV2s
 INOfEjY0qBTJ0ntW0eonT59OZqtNvE/2R3own8+kqg9voxTQkkWXxroG6ScAD7HKltvdJPH8F
 AqCfj6KfYkOYuDfvUR//LR1K0jHeJWaHpwgG/2bhq3pm23NC6S2/8firTs7RLyiEUkM7o8S3/
 upaN/TsxdoTTr8Dqu0cVUkX2ZGns+tfxnSNIjXwVWCwc5280cdygy7ITk+GTvf0E+FTbgCyCW
 dE+jga4OrEww/0Bb0xxEkabxnAbr084XQ3XDVD2Mc1GcyXpTXZa7ZDdGjo20K03i9cR5zLQGt
 qU6vdaXTaCMr63M3DZj1kmJaxIi8liwSVkP6Y8V9Mb/M6d+3wIHGpR+t14xe8oxrN9siL9Dhf
 r3VtV7eMguF33rg+Ovi0MNN2b4oAVhoyU3EiL6slzkgTr5sNoJyn3TsNgb2cKKdfc+oRBLLVS
 inRnrC81nWDI6TKF1UGI+RwQj2h7hXNuH6HgfINnAD3EmCRE58uJHk1vx5ytgUMRB0kFCSUIQ
 95N0UoVTZ9pxXShp2gOs08QNR2etXuQKIrI4bFBWgn9lzTAnUyfE5uG3amCA=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Sep 2019 13:23:54 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/owl-dma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 90bbcef99ef8..023f951189a7 100644
=2D-- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1045,18 +1045,13 @@ static int owl_dma_probe(struct platform_device *p=
dev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
 	struct owl_dma *od;
-	struct resource *res;
 	int ret, i, nr_channels, nr_requests;

 	od =3D devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
 		return -ENOMEM;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	od->base =3D devm_ioremap_resource(&pdev->dev, res);
+	od->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(od->base))
 		return PTR_ERR(od->base);

=2D-
2.23.0

